#!/usr/bin/env bash
# Build the ARWG deliverables site: an index of all deliverables, and for each
# deliverable a version page plus its nightly build (web pages, single page, PDF).
#
#   bash scripts/site/build.sh            # HTML + PDF
#   SKIP_PDF=1 bash scripts/site/build.sh # HTML only
#   SITE_LABEL="Preview of pull request #17" bash scripts/site/build.sh
#
# Layout of _site/:
#   index.html                    all deliverables
#   <slug>/index.html             versions of one deliverable (released, nightly)
#   <slug>/nightly/...            build of the current sources (latest)
#   <slug>/<version>/...          released versions, once there are any
#
# All links are relative, so the same output works at the site root (main)
# and under a prefix (pull request previews).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
HERE="$ROOT/scripts/site"
OUT="$ROOT/_site"
SKIP_PDF="${SKIP_PDF:-0}"
SITE_LABEL="${SITE_LABEL:-}"
BUILD_DATE="$(date -u +%F)"

# Registry: slug | title | source folder | released versions (space separated) | summary.
# To publish another deliverable, add a line (folders that do not exist are skipped).
# Until a version is released, only the nightly build exists.
DELIVERABLES=(
  "d2|D2 — Gap Analysis and Benchmark Survey|D2-gap-analysis-benchmark-survey||Living survey of the open-source landscape that enterprises build on to run reliable agentic systems, and the gaps in it. Starts with the methodology and a few key subjects."
)

command -v pandoc >/dev/null || { echo "pandoc is required" >&2; exit 1; }

PDF_ENGINE="${PDF_ENGINE:-}"
if [[ "$SKIP_PDF" != "1" && -z "$PDF_ENGINE" ]]; then
  for c in xelatex lualatex tectonic; do
    command -v "$c" >/dev/null && { PDF_ENGINE="$c"; break; }
  done
  [[ -n "$PDF_ENGINE" ]] || { echo "no PDF engine found; use SKIP_PDF=1" >&2; exit 1; }
fi

rm -rf "$OUT"
mkdir -p "$OUT/assets"
cp "$HERE/site.css" "$OUT/assets/site.css"
touch "$OUT/.nojekyll"

title_of() { # first H1 of a Markdown file
  local t; t="$(grep -m1 '^# ' "$1" || true)"; echo "${t#\# }"
}

banner() { # work-in-progress banner
  local b="<strong>Work in progress.</strong> Nightly build of ${BUILD_DATE}, not reviewed or released."
  [[ -z "$SITE_LABEL" ]] || b="$b $SITE_LABEL."
  printf '<div class="wip">%s</div>' "$b"
}

# nav_file <nav-html> <depth>: write the nav and banner to a temp file
nav_file() {
  local nav="$1" depth="$2" up="" f; f="$(mktemp)"
  for ((i = 0; i < depth; i++)); do up="../$up"; done
  printf '%s\n<div class="nav">%s</div>\n' "$(banner)" "${nav//@UP@/$up}" > "$f"
  echo "$f"
}

# html_page <in.md> <out.html> <title> <depth-from-site-root> <nav-html>
html_page() {
  local in="$1" out="$2" title="$3" depth="$4" nav="$5" up="" navfile
  for ((i = 0; i < depth; i++)); do up="../$up"; done
  navfile="$(nav_file "$nav" "$depth")"
  mkdir -p "$(dirname "$out")"
  LINK_MODE=page pandoc "$in" --from gfm --to html5 --standalone \
    --lua-filter "$HERE/links.lua" \
    --metadata pagetitle="$title" \
    --css "${up}assets/site.css" --include-before-body "$navfile" \
    --output "$out"
  rm -f "$navfile"
}

INDEX_MD="$(mktemp)"
cat > "$INDEX_MD" <<'MD'
# ARWG deliverables

Accuracy & Reliability Working Group. **No deliverable has been released yet.** Until a version is released, each deliverable only has a nightly build: the latest state of the sources, which may change at any time.

MD

for entry in "${DELIVERABLES[@]}"; do
  IFS='|' read -r slug title src releases summary <<< "$entry"
  SRC="$ROOT/$src"
  [[ -d "$SRC" ]] || { echo "skip $slug: $src not found"; continue; }
  D="$OUT/$slug/nightly"
  mkdir -p "$D"
  NAV="<a href=\"@UP@index.html\">All deliverables</a> | <a href=\"@UP@$slug/index.html\">${title%% —*} versions</a> | <a href=\"@UP@$slug/nightly/index.html\">Nightly</a> | <a href=\"@UP@$slug/nightly/$slug-single-page.html\">Single page</a>"
  [[ "$SKIP_PDF" == "1" ]] || NAV="$NAV | <a href=\"@UP@$slug/nightly/$slug-deliverable.pdf\">PDF</a>"

  # Ordered sources: numbered sections, question cards.
  SECTIONS=()
  while IFS= read -r f; do SECTIONS+=("$f"); done < <(cd "$SRC" && ls [0-9][0-9]-*.md 2>/dev/null | sort)
  CARDS=()
  while IFS= read -r f; do CARDS+=("$f"); done < <(cd "$SRC" && ls cards/Q-*.md 2>/dev/null | sort)

  # Section and card pages (same layout as the sources, so relative links work).
  for f in "${SECTIONS[@]}"; do
    html_page "$SRC/$f" "$D/${f%.md}.html" "$(title_of "$SRC/$f")" 2 "$NAV"
  done
  for f in "${CARDS[@]}" cards/TEMPLATE.md; do
    [[ -f "$SRC/$f" ]] || continue
    html_page "$SRC/$f" "$D/${f%.md}.html" "$(title_of "$SRC/$f")" 3 "$NAV"
  done

  # Cards index.
  if [[ -d "$SRC/cards" ]]; then
    CI="$(mktemp)"
    { echo "# Question cards"; echo
      echo "- [Template](TEMPLATE.html)"
      for f in "${CARDS[@]}"; do
        echo "- [$(title_of "$SRC/$f")](${f#cards/}.html)" | sed 's/\.md\.html/.html/'
      done; } > "$CI"
    html_page "$CI" "$D/cards/index.html" "Question cards" 3 "$NAV"
    rm -f "$CI"
  fi

  # Landing page of the nightly build = README.
  html_page "$SRC/README.md" "$D/index.html" "$title" 2 "$NAV"

  # Single page and PDF.
  COMBINED="$(mktemp)"
  : > "$COMBINED"
  for f in README.md "${SECTIONS[@]}" "${CARDS[@]}"; do
    [[ -f "$SRC/$f" ]] || continue
    cat "$SRC/$f" >> "$COMBINED"; printf '\n\n\\newpage\n\n' >> "$COMBINED"
  done
  SUBTITLE="Work in progress. Nightly build of $BUILD_DATE, not reviewed or released."
  SPNAV="$(nav_file "$NAV" 2)"
  LINK_MODE=flat pandoc "$COMBINED" --from gfm --to html5 --standalone --toc --toc-depth=2 \
    --lua-filter "$HERE/links.lua" --metadata title="$title" --metadata subtitle="$SUBTITLE" \
    --css "../../assets/site.css" --include-before-body "$SPNAV" \
    --output "$D/$slug-single-page.html"
  rm -f "$SPNAV"
  if [[ "$SKIP_PDF" != "1" ]]; then
    LINK_MODE=flat pandoc "$COMBINED" --from gfm --toc --toc-depth=2 \
      -V documentclass:report -V geometry:margin=2.5cm -V colorlinks=true -V urlcolor=blue \
      --include-in-header "$HERE/pdf-header.tex" --lua-filter "$HERE/links.lua" \
      --metadata title="$title" --metadata subtitle="$SUBTITLE" --metadata date="$BUILD_DATE" \
      --pdf-engine "$PDF_ENGINE" --output "$D/$slug-deliverable.pdf"
  fi
  rm -f "$COMBINED"

  # Version block shared by the deliverable's version page and the site index.
  BLOCK="$(mktemp)"
  {
    echo "**Status:** work in progress"; echo
    echo "$summary"; echo
    if [[ -n "$releases" ]]; then
      echo "**Released versions:**"; echo
      for v in $releases; do echo "- [$v]($slug/$v/index.html)"; done
    else
      echo "**Released versions:** none yet"
    fi
    echo
    echo "**Nightly (latest, work in progress):** updated on every merge to \`main\`."; echo
    echo "- [Web version]($slug/nightly/index.html)"
    echo "- [Single page]($slug/nightly/$slug-single-page.html)"
    [[ "$SKIP_PDF" == "1" ]] || echo "- [PDF]($slug/nightly/$slug-deliverable.pdf)"
    echo
  } > "$BLOCK"

  { echo "## [$title]($slug/index.html)"; echo; cat "$BLOCK"; } >> "$INDEX_MD"

  # Version page of the deliverable (links relative to <slug>/).
  VP="$(mktemp)"
  { echo "# $title"; echo; sed "s#]($slug/#](#g" "$BLOCK"; } > "$VP"
  html_page "$VP" "$OUT/$slug/index.html" "$title" 1 \
    "<a href=\"@UP@index.html\">All deliverables</a>"
  rm -f "$VP" "$BLOCK"
done

html_page "$INDEX_MD" "$OUT/index.html" "ARWG deliverables" 0 '<a href="@UP@index.html">All deliverables</a>'
rm -f "$INDEX_MD"
echo "Site built in $OUT"
