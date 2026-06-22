# Contributing to ARWG taxonomy & landscape

**Source of truth:** the **18 JSON files** in this folder (`s{section}-{topic}-{p0|p1|p2}.json`). Each file is one review slice by section and priority band. Edit terms in PRs; discuss in threaded comments.

**Pull-request workflow:** [`../CURRENT-WORKSTREAMS.md`](../CURRENT-WORKSTREAMS.md).

**Source document labels:** [`README.md` — Source document lookup](./README.md#source-document-lookup) at the end of the index.

**Export to Taxonomy WG:** WG **liaison and/or chairs** batch agreed slices to [ws-taxonomy-landscape](https://github.com/aaif/ws-taxonomy-landscape) when ready — contributors do not need to run export tooling.

## Alignment with Taxonomy WG schema

Each **term object** follows the [Taxonomy & Landscape WG data schema](https://github.com/aaif/ws-taxonomy-landscape/blob/main/docs/data-schemas.md) (SKOS-lite glossary fields: `term`, `definition`, `aliases`, `broaderTerm`, `scopeNote`, `relatedTerms`, `contrastsWith`, `workgroups`, `literatureNote`, `academicTerms`, and related metadata).

ARWG adds **`x-*` fields** on top for **review and export tracking only** — they are not part of the upstream Taxonomy WG canonical payload unless liaison normalizes on export:

| Field | Purpose |
|-------|---------|
| `x-termStatus` | Review symbol: stable / qualified / contested / aaif-new (shown as ○ † △ ★ in the README) |
| `x-reviewTier` | How much active WG debate the term needs (1 = discuss first, 2 = confirm, 3 = reference) |
| `x-consensus-reached` | Set `true` only after a resolved PR thread records WG agreement |
| `x-sources` | Short pointers (e.g. running notes Taxonomy thread) — not duplicate definitions |
| `x-measuresTerm` | Metrics only: 1:1 link to the symptom or root-cause term quantified |

Slice files also use ARWG-only envelope fields: `sectionGuide` (once per section on the anchor JSON), `priority`, `category`, `taxonomyLayer`, and `title` with band suffix (`— P0`).

## File naming

`s{section}-{topic}-{p0|p1|p2}.json` — e.g. `s08-failure-p0.json`.

Each file’s **`title`** includes its review band (e.g. `System boundaries & evaluation subjects — P0`).

**`sectionGuide`** (why the section exists, how to use it, category overview) appears **once per section** — on the **lowest-numbered priority file** only (`p0` if present, otherwise `p1`, then `p2`). Other files in the same section (`s03-boundaries-p1.json`, etc.) contain **`terms`** only. Edit the shared guide on the anchor file when section-level prose changes.

Each JSON file then holds a **`terms`** array for that band.

## Term fields

| Field | Description |
|-------|-------------|
| `term` | Canonical label for this entry (unique across all 18 files). |
| `definition` | Normative definition — what reviewers comment on in PR threads. |
| `priority` | Review band: **`P0`** parent concepts first, **`P1`** refinements and leaves, **`P2`** optional adjuncts. |
| `category` | Glossary grouping (e.g. Evaluation subjects, Symptoms, Root causes). |
| `taxonomyLayer` | Architecture layer the term belongs to (e.g. subject, property, symptom). |
| `aliases` | Other labels in the wild; not separate canonical terms. |
| `broaderTerm` | Parent in the hierarchy — must name another `term` in this glossary. |
| `scopeNote` | When or how to apply the term; boundaries and caveats. |
| `relatedTerms` | Associated terms for navigation — each must exist elsewhere in this glossary. |
| `contrastsWith` | Terms this one must not be confused with — each must exist in this glossary. |
| `workgroups` | AAIF working groups that own or use this sense (usually Accuracy & Reliability). |
| `literatureNote` | How the literature uses the label; where AAIF narrows or diverges. |
| `academicTerms` | Academic or vendor labels **not** adopted as AAIF terms. |
| `x-termStatus` | Review symbol: **`stable`** (○ widely used), **`qualified`** († needs qualifier), **`contested`** (△ debatable), **`aaif-new`** (★ coined for ARWG). |
| `x-reviewTier` | How much active WG debate this term needs: **`1`** = focus (contested or AAIF-new — discuss first), **`2`** = confirm definition, **`3`** = reference vocabulary (stable shared terms — read for consistency, rarely debated). Used for review planning; not surfaced in the README index. |
| `x-consensus-reached` | **`false`** until the WG agrees in a resolved PR thread; set **`true`** when consensus is recorded (README shows agreed terms in **bold**). |
| `x-sources` | Pointers to charter, running notes, or external refs — not duplicate definitions. |
| `x-measuresTerm` | For metrics only: the single symptom or root-cause term this metric quantifies (1:1). |

## Consensus in PR (`x-consensus-reached`)

Default is **`false`** on every term.

| Step | Action |
|------|--------|
| 1 | Reviewers comment on a term’s `definition` (and related fields) in the PR thread. |
| 2 | When the thread is **resolved** and maintainers confirm **WG consensus**, set `"x-consensus-reached": true` on that term **in the same PR** (or a follow-up consensus PR). |
| 3 | Terms in **bold** in [`README.md`](./README.md) should match `x-consensus-reached: true`. |

Do **not** set `true` on terms still marked `△ contested` unless the dispute was explicitly resolved in the thread.

Example (inside a term object):

```json
"x-consensus-reached": true
```

## Term order

Within each JSON file, **`terms`** are ordered by **`priority`** (P0 → P1 → P2), then **`category`** (alphabetical), then **`term`** (alphabetical). Keep this order when adding entries — append within the correct priority/category band or re-sort the file consistently.

Use **one field per line** (pretty-printed JSON) so GitHub suggestion blocks touch only the lines that change.

## Review order

Sign off **P0** parent terms in a section before large **P1** refinement passes (e.g. Symptom, Root cause, Evaluation metric before specific subtypes and rates).

## README in this folder

[`README.md`](./README.md) is a navigation index (tables, diagrams, `#L` links into JSON). **JSON is authoritative**; anchors are best effort. Liaison/chairs may refresh the README when the JSON changes.
