#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
INPUT_DIR="$ROOT_DIR/D1-terminology-taxonomy"
OUTPUT_ROOT="$ROOT_DIR/docs"
OUTPUT_DIR="$OUTPUT_ROOT/d1"
BUILD_DIR="$OUTPUT_DIR/build"
CHAPTERS_DIR="$OUTPUT_DIR/chapters"
ASSETS_DIR="$OUTPUT_DIR/assets"
HEADING_FILTER="$ROOT_DIR/scripts/strip_heading_numbers.lua"
TABLE_WIDTH_FILTER="$ROOT_DIR/scripts/pandoc_table_widths.lua"
GLOSSARY_LINK_FILTER="$ROOT_DIR/scripts/autolink_glossary_terms.lua"
PDF_HEADER="$ROOT_DIR/scripts/pandoc-pdf-header.tex"
GLOSSARY_APPENDIX_FILE="appendices/F-glossary-alphabetical.md"

CHAPTER_FILES=(
  "00-taxonomy-architecture.md"
  "01-purpose-and-scope.md"
  "02-design-principles.md"
  "04-system-boundaries.md"
  "03-core-concepts.md"
  "05-reliability-dimensions.md"
  "06-operational-governance.md"
  "07-grounding-evidence-terms.md"
  "08-failure-vocabulary.md"
  "09-metrics-measurement.md"
  "10-evaluation-ecosystem.md"
  "11-response-correction.md"
)

REFERENCE_FILE="references.md"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "Error: pandoc is required but not found in PATH." >&2
  exit 1
fi

PDF_ENGINE="${PDF_ENGINE:-}"
SKIP_PDF="${SKIP_PDF:-0}"

if [[ "$SKIP_PDF" != "1" ]]; then
  if [[ -z "$PDF_ENGINE" ]]; then
    for candidate in xelatex lualatex pdflatex tectonic weasyprint wkhtmltopdf; do
      if command -v "$candidate" >/dev/null 2>&1; then
        PDF_ENGINE="$candidate"
        break
      fi
    done
  fi

  if [[ -z "$PDF_ENGINE" ]]; then
    echo "Error: no PDF engine found (tried: pdflatex, xelatex, lualatex, tectonic, weasyprint, wkhtmltopdf)." >&2
    echo "Hint: install a TeX engine (e.g. pdflatex) or run with SKIP_PDF=1 for HTML-only output." >&2
    exit 1
  fi
fi

mkdir -p "$BUILD_DIR" "$CHAPTERS_DIR" "$ASSETS_DIR" "$OUTPUT_ROOT"

# Avoid publishing stale chapter pages from previous scope configurations.
find "$CHAPTERS_DIR" -type f -name '*.html' -delete

normalise_nav_title() {
  local file_name="$1"
  local heading="$2"
  local stem="${file_name%.md}"
  local chapter_index="${stem%%-*}"
  local chapter_number="$((10#$chapter_index))"
  local title="$heading"

  title="$(echo "$title" | sed -E 's/^§([0-9]+)[[:space:]]*[—-][[:space:]]*/\1 - /')"

  if [[ "$file_name" != "$REFERENCE_FILE" ]]; then
    if ! echo "$title" | grep -Eq "^[0-9]+[[:space:]]*[-.]"; then
      title="$chapter_number - $title"
    fi
  fi

  echo "$title"
}

CSS_FILE="$ASSETS_DIR/d1.css"
cat > "$CSS_FILE" <<'CSS'
:root {
  --fg: #101418;
  --muted: #4a5561;
  --bg: #f7faf9;
  --card: #ffffff;
  --line: #d9e2e1;
  --accent: #0b5b78;
}

body {
  font-family: "Source Serif Pro", Georgia, "Times New Roman", serif;
  color: var(--fg);
  background: var(--bg);
  line-height: 1.6;
  max-width: 960px;
  margin: 0 auto;
  padding: 2rem 1.25rem 4rem;
}

h1, h2, h3, h4 {
  font-family: "Source Sans 3", "Helvetica Neue", Helvetica, Arial, sans-serif;
  line-height: 1.25;
}

h1 {
  margin-top: 0;
  color: var(--accent);
}

a {
  color: var(--accent);
}

table {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
  background: var(--card);
}

th, td {
  border: 1px solid var(--line);
  padding: 0.45rem 0.55rem;
  text-align: left;
  vertical-align: top;
}

blockquote {
  margin: 1rem 0;
  padding: 0.25rem 0.9rem;
  border-left: 4px solid var(--line);
  color: var(--muted);
  background: var(--card);
}

code, pre {
  font-family: "SFMono-Regular", Menlo, Consolas, monospace;
}

.nav {
  margin-bottom: 1.5rem;
  padding: 0.8rem 0.9rem;
  border: 1px solid var(--line);
  background: var(--card);
}

.muted {
  color: var(--muted);
}
CSS

COMBINED_MD="$BUILD_DIR/d1-combined.md"
: > "$COMBINED_MD"

for file in "${CHAPTER_FILES[@]}"; do
  path="$INPUT_DIR/$file"
  if [[ ! -f "$path" ]]; then
    echo "Error: missing chapter file: $path" >&2
    exit 1
  fi
  cat "$path" >> "$COMBINED_MD"
  printf "\n\n" >> "$COMBINED_MD"
  printf "\\newpage\n\n" >> "$COMBINED_MD"
done

if [[ -f "$INPUT_DIR/$REFERENCE_FILE" ]]; then
  cat "$INPUT_DIR/$REFERENCE_FILE" >> "$COMBINED_MD"
fi

if [[ -f "$INPUT_DIR/$GLOSSARY_APPENDIX_FILE" ]]; then
  printf "\n\n" >> "$COMBINED_MD"
  cat "$INPUT_DIR/$GLOSSARY_APPENDIX_FILE" >> "$COMBINED_MD"
fi

TOC_MD="$BUILD_DIR/toc.md"
cat > "$TOC_MD" <<'MD'
# D1 Table of Contents

Navigation:
- [Back to D1 index](index.html)
- [Single-page HTML](d1-single-page.html)
MD

if [[ "$SKIP_PDF" != "1" ]]; then
  printf -- "- [PDF](d1-deliverable.pdf)\n" >> "$TOC_MD"
fi

printf "\n## Chapters\n" >> "$TOC_MD"

for file in "${CHAPTER_FILES[@]}"; do
  stem="${file%.md}"
  title_line="$(grep -m1 '^# ' "$INPUT_DIR/$file" || true)"
  title="${title_line#\# }"
  if [[ -z "$title" ]]; then
    title="$stem"
  fi
  title="$(normalise_nav_title "$file" "$title")"
  printf -- "- [%s](chapters/%s.html)\n" "$title" "$stem" >> "$TOC_MD"
done

if [[ -f "$INPUT_DIR/$REFERENCE_FILE" ]]; then
  ref_stem="${REFERENCE_FILE%.md}"
  ref_title_line="$(grep -m1 '^# ' "$INPUT_DIR/$REFERENCE_FILE" || true)"
  ref_title="${ref_title_line#\# }"
  if [[ -z "$ref_title" ]]; then
    ref_title="References"
  fi
  printf -- "- [%s](chapters/%s.html)\n" "$ref_title" "$ref_stem" >> "$TOC_MD"
fi

INDEX_MD="$BUILD_DIR/index.md"
cat > "$INDEX_MD" <<'MD'
# D1 Deliverable

D1 provides the normative vocabulary and taxonomy for accuracy and reliability in agentic systems.

This publication is a supporting document to the ARWG taxonomy effort.

## Summary

- Defines shared terminology across evaluation subjects, dimensions, metrics, and failure classes.
- Establishes boundary and attribution rules to keep evaluation claims comparable.
- Provides publication-ready terminology constraints for ARWG deliverables.

## Read the deliverable

- [Single-page HTML](d1-single-page.html)
- [Table of contents](toc.html)
MD

if [[ "$SKIP_PDF" != "1" ]]; then
  printf -- "- [PDF](d1-deliverable.pdf)\n" >> "$INDEX_MD"
fi

printf "\n## Chapter pages\n" >> "$INDEX_MD"

for file in "${CHAPTER_FILES[@]}"; do
  stem="${file%.md}"
  title_line="$(grep -m1 '^# ' "$INPUT_DIR/$file" || true)"
  title="${title_line#\# }"
  if [[ -z "$title" ]]; then
    title="$stem"
  fi
  title="$(normalise_nav_title "$file" "$title")"
  printf -- "- [%s](chapters/%s.html)\n" "$title" "$stem" >> "$INDEX_MD"
done

if [[ -f "$INPUT_DIR/$REFERENCE_FILE" ]]; then
  ref_stem="${REFERENCE_FILE%.md}"
  ref_title_line="$(grep -m1 '^# ' "$INPUT_DIR/$REFERENCE_FILE" || true)"
  ref_title="${ref_title_line#\# }"
  if [[ -z "$ref_title" ]]; then
    ref_title="References"
  fi
  printf -- "- [%s](chapters/%s.html)\n" "$ref_title" "$ref_stem" >> "$INDEX_MD"
fi

pandoc "$INDEX_MD" \
  --from gfm \
  --to html5 \
  --standalone \
  --metadata title="D1 Deliverable" \
  --css "assets/d1.css" \
  --output "$OUTPUT_DIR/index.html"

pandoc "$TOC_MD" \
  --from gfm \
  --to html5 \
  --standalone \
  --metadata title="D1 Table of Contents" \
  --css "assets/d1.css" \
  --output "$OUTPUT_DIR/toc.html"

pandoc "$COMBINED_MD" \
  --from gfm \
  --to html5 \
  --standalone \
  --toc \
  --number-sections \
  --top-level-division=chapter \
  --lua-filter "$HEADING_FILTER" \
  --lua-filter "$GLOSSARY_LINK_FILTER" \
  --metadata title="D1 - Terminology and Taxonomy" \
  --css "assets/d1.css" \
  --output "$OUTPUT_DIR/d1-single-page.html"

if [[ "$SKIP_PDF" != "1" ]]; then
  pandoc "$COMBINED_MD" \
    --from gfm \
    --toc \
    --number-sections \
    --top-level-division=chapter \
    --variable=documentclass:report \
    --include-in-header "$PDF_HEADER" \
    --lua-filter "$HEADING_FILTER" \
    --lua-filter "$TABLE_WIDTH_FILTER" \
    --lua-filter "$GLOSSARY_LINK_FILTER" \
    --metadata title="D1 - Terminology and Taxonomy" \
    --pdf-engine "$PDF_ENGINE" \
    --output "$OUTPUT_DIR/d1-deliverable.pdf"
fi

for file in "${CHAPTER_FILES[@]}"; do
  stem="${file%.md}"
  in_file="$INPUT_DIR/$file"
  title_line="$(grep -m1 '^# ' "$in_file" || true)"
  title="${title_line#\# }"
  if [[ -z "$title" ]]; then
    title="$stem"
  fi

  tmp_md="$BUILD_DIR/$stem.nav.md"
  {
    echo "[Back to D1 index](../index.html) | [ToC](../toc.html) | [Single page](../d1-single-page.html)"
    echo
    cat "$in_file"
  } > "$tmp_md"

  pandoc "$tmp_md" \
    --from gfm \
    --to html5 \
    --standalone \
    --metadata title="$title" \
    --css "../assets/d1.css" \
    --output "$CHAPTERS_DIR/$stem.html"
done

if [[ -f "$INPUT_DIR/$REFERENCE_FILE" ]]; then
  ref_stem="${REFERENCE_FILE%.md}"
  ref_in_file="$INPUT_DIR/$REFERENCE_FILE"
  ref_title_line="$(grep -m1 '^# ' "$ref_in_file" || true)"
  ref_title="${ref_title_line#\# }"
  if [[ -z "$ref_title" ]]; then
    ref_title="References"
  fi

  ref_tmp_md="$BUILD_DIR/$ref_stem.nav.md"
  {
    echo "[Back to D1 index](../index.html) | [ToC](../toc.html) | [Single page](../d1-single-page.html)"
    echo
    cat "$ref_in_file"
  } > "$ref_tmp_md"

  pandoc "$ref_tmp_md" \
    --from gfm \
    --to html5 \
    --standalone \
    --metadata title="$ref_title" \
    --css "../assets/d1.css" \
    --output "$CHAPTERS_DIR/$ref_stem.html"
fi

cat > "$OUTPUT_ROOT/index.html" <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="refresh" content="0; url=d1/index.html">
  <title>ARWG deliverables</title>
</head>
<body>
  <p>Redirecting to the <a href="d1/index.html">D1 deliverable</a>.</p>
</body>
</html>
HTML

if [[ "$SKIP_PDF" == "1" ]]; then
  echo "D1 site built (HTML only) in: $OUTPUT_DIR"
else
  echo "D1 site built (HTML + PDF) in: $OUTPUT_DIR"
fi
