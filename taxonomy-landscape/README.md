# ARWG taxonomy & landscape

## About this index

This README and the **`s*.json`** files were built from working-group contributions — [running notes](../CURRENT-WORKSTREAMS.md), D1 terminology (work in progress), and D3 gap analysis (work in progress) — and further extended into a JSON-first taxonomy review. Comments from working-group and pull-request threads were integrated into the term records; that material lives in `definition`, `scopeNote`, `literatureNote`, and where useful `x-sources`, not duplicated as narrative here.

This index is a **living document**: sections, term sets, and prose will be **extended or revised as ARWG deliverables progress** (D1, D3, and related work). Nothing here is frozen except what the working group records as agreed in JSON (`x-consensus-reached`).

**Definitions live in JSON.** Edit those fields in pull requests. Links in the tables below use `#L` anchors for convenience; if an anchor drifts, open the JSON file directly.

**Scope.** The Accuracy & Reliability Working Group owns vocabulary for evaluation subjects, accuracy and reliability properties, failure symptoms and root causes, metrics, evaluation harness artefacts, and correction patterns — from a single agent run through multi-agent systems, workflows, grounding, governance, and enterprise SLAs.

## Outline and rationale

Section labels mirror **D1 numbering** (terminology deliverable, work in progress). **(§3)–(§8)** are the core property and failure narrative. **(§9)** metrics, **(§10)** evaluation ecosystem, and **(§11)** response are transversal layers in the model but numbered after §8 so the architecture can grow without renumbering failures. This index lists §3→§8 first, then §9–§11 — **review dependency order**, not D1 file order.

| Section | What it covers | Why it appears here |
|---------|----------------|---------------------|
| (§3) | System boundaries and evaluation subjects | Every claim must name *what* is evaluated |
| (§4) | Accuracy, reliability, and output quality | Single-run accuracy vs repeated-run reliability; task and process correctness; output quality |
| (§5) | Reliability dimensions | Named families for reliability — consistency, robustness, calibration, safety |
| (§6) | Operational and governance terms | Identity, traceability, recoverability — not quality dimensions |
| (§7) | Grounding, evidence, and world | How outputs relate to authoritative state |
| (§8) | Failure vocabulary | Symptoms and root causes for remediation |
| (§9) | Metrics and measurement | Quantifiers linked to (§4)–(§8) via `x-measuresTerm` |
| (§10) | Evaluation ecosystem | Benchmarks, scenarios, traces, participants |
| (§11) | Reliability by design; correction and control | Prevent and react to failures (D1 layer 5) |

Each section below adds a short **P0 / P1 / P2** note: parent terms in **P0** are what refinements in **P1** and **P2** presuppose. That ordering helps end-to-end review; it is not a gate for contributors.

## How to contribute

Before editing terms, read [`CONTRIBUTING.md`](./CONTRIBUTING.md) for JSON field semantics, alignment with the Taxonomy WG schema, and the `x-*` review fields. See [`../CURRENT-WORKSTREAMS.md`](../CURRENT-WORKSTREAMS.md) for workstreams and pull-request merge practice.

Contributors work in different ways — all are valid:

- **By domain.** Jump to the section that matches your expertise and open a PR on the linked `s*.json` file. Start with **M1** in [Suggested milestones](#suggested-milestones) if you are new.
- **By dependency.** If you prefer a full pass, reading (§3) through (§8) in order shows how terms chain together; settle **P0** in a section before debating **P1** leaves in the same section. Open a PR on the JSON file for the terms you change.
- **By source label.** If you arrive with a term from running notes or an earlier draft, use [**Source document lookup**](#source-document-lookup) at the end of this file to find the canonical JSON entry.

**Section and document editors.** We welcome volunteers to **lead review** for one or more sections (for example (§8) failures or (§9) metrics) or for the **README and JSON index as a whole**. An editor helps keep section prose and term records coherent, triages PR comments in their slice, and surfaces open questions to the working group. You do not need to own every term — ad hoc contributions remain welcome. To volunteer, say so in a PR comment, on the [running notes](../CURRENT-WORKSTREAMS.md) Taxonomy thread, or at a WG meeting.

## Suggested milestones

Review batches are defined by **`x-milestone`** on each term in the slice `s*.json` files — that field is the source of truth. To list every M1 term, search the slice files for `"x-milestone": "M1"` (or use the table below).

A milestone is **complete** when every term in that batch has **`x-consensus-reached: true`** (shown **bold** in the index). Symbol prefixes in the table reflect **`x-termStatus`** and **`x-discouraged-for-technical`** only — see [Term symbols](#term-symbols).

### Definitions and discussion threads

Each term’s **`definition`**, **`scopeNote`**, **`literatureNote`**, and **`x-sources`** live in the slice JSON. Links in the table open the canonical term record (`#L` anchors). Pull-request comments carry open debate; agreed text belongs in the slice file.

<!-- milestone-table:start -->
| Milestone | Rationale | Terms (canonical links) |
|-----------|-----------|-------------------------|
| **M1** (41) | Gap-analysis anchors: evaluation subjects, core accuracy and reliability parents, reliability dimension families, grounding and trust, agent identity, benchmark frame, top-level failure labels, human in the loop. | (§3) [○ Agent](./s03-boundaries-p0.json#L25), [★ Agent boundary](./s03-boundaries-p0.json#L54), [★ Evaluation subject](./s03-boundaries-p0.json#L77), [† Model](./s03-boundaries-p0.json#L105), [○ Multi-agent system](./s03-boundaries-p0.json#L135), [△ × Workflow](./s03-boundaries-p0.json#L166)<br>(§4) [△ Accuracy](./s04-core-p0.json#L31), [† Agent reliability](./s04-core-p0.json#L67), [△ Contextual correctness](./s04-core-p0.json#L125), [△ Reliability](./s04-core-p0.json#L186), [○ Response quality](./s04-core-p0.json#L333), [○ Task completion](./s04-core-p0.json#L390)<br>(§5) [† Calibration](./s05-reliability-dimensions-p0.json#L27), [△ Consistency](./s05-reliability-dimensions-p0.json#L55), [★ Cross-agent factual alignment](./s05-reliability-dimensions-p0.json#L87), [★ Input paraphrase robustness](./s05-reliability-dimensions-p0.json#L111), [★ Operational fault robustness](./s05-reliability-dimensions-p0.json#L139), [★ Outcome consistency](./s05-reliability-dimensions-p0.json#L165), [★ Resource consistency](./s05-reliability-dimensions-p0.json#L194), [† Robustness](./s05-reliability-dimensions-p0.json#L219), [△ Safety](./s05-reliability-dimensions-p0.json#L249), [★ Trajectory consistency](./s05-reliability-dimensions-p0.json#L276), [† Cross-agent agreement](./s05-reliability-dimensions-p0.json#L304)<br>(§6) [○ Recoverability](./s06-governance-p0.json#L37), [○ Agent identity](./s06-governance-p0.json#L111)<br>(§7) [† Grounding](./s07-grounding-p0.json#L31), [○ Trust anchor](./s07-grounding-p0.json#L60), [★ Evidence accuracy](./s07-grounding-p0.json#L85)<br>(§8) [○ Root cause](./s08-failure-p0.json#L116), [△ × Hallucination](./s08-failure-p0.json#L145), [○ Symptom](./s08-failure-p0.json#L175)<br>(§10) [○ Benchmark](./s10-ecosystem-p1.json#L25), [○ Evaluation participant](./s10-ecosystem-p1.json#L154), [○ Evaluation scenario](./s10-ecosystem-p1.json#L179), [○ Infrastructure](./s10-ecosystem-p1.json#L204), [○ Leaderboard](./s10-ecosystem-p1.json#L235), [○ Operator](./s10-ecosystem-p1.json#L291), [○ Orchestrator](./s10-ecosystem-p1.json#L317), [○ Tool](./s10-ecosystem-p1.json#L425), [○ User](./s10-ecosystem-p1.json#L502)<br>(§11) [† Human in the loop](./s11-response-p1.json#L113) |
| **M2** (33) | Remaining correctness variants, traceability, evaluation-metric parent, telemetry and trace, operational failure classes, failure attribution, core response patterns. | (§3) [★ Agent specification](./s03-boundaries-p1.json#L91), [★ Scope ring](./s03-boundaries-p1.json#L171), [○ Trajectory](./s03-boundaries-p1.json#L248)<br>(§4) [○ Annotated correctness](./s04-core-p0.json#L94), [† Infrastructure reliability](./s04-core-p0.json#L156), [★ Statistical coverage](./s04-core-p0.json#L217), [† × Trustworthiness](./s04-core-p0.json#L244), [○ Model output reliability](./s04-core-p1.json#L11), [★ Realised accuracy](./s04-core-p1.json#L36), [† Functional correctness](./s04-core-p0.json#L279), [○ Process accuracy](./s04-core-p0.json#L306), [○ Task accuracy](./s04-core-p0.json#L364), [○ Intent adherence](./s04-core-p1.json#L58), [○ Skill adherence](./s04-core-p1.json#L83)<br>(§6) [† Deterministic operation](./s06-governance-p0.json#L62), [○ Deterministic validation](./s06-governance-p0.json#L89), [† Explainability](./s06-governance-p0.json#L134), [○ Traceability](./s06-governance-p1.json#L96)<br>(§7) [○ Evidence](./s07-grounding-p1.json#L39), [○ Ground truth](./s07-grounding-p1.json#L65), [○ Provenance](./s07-grounding-p1.json#L90)<br>(§8) [★ Failure attribution](./s08-failure-p1.json#L11), [○ Infrastructure failure](./s08-failure-p0.json#L37), [○ Reasoning failure](./s08-failure-p0.json#L64), [○ Recovery failure](./s08-failure-p0.json#L91)<br>(§9) [★ Evaluation envelope](./s09-metrics-p1.json#L60), [○ Evaluation methodology](./s09-metrics-p1.json#L83), [○ Evaluation metric](./s09-metrics-p1.json#L33)<br>(§10) [○ Telemetry](./s10-ecosystem-p1.json#L369), [○ Trace](./s10-ecosystem-p1.json#L476)<br>(§11) [★ Correction mechanism](./s11-response-p1.json#L60), [○ Escalation](./s11-response-p1.json#L89), [○ Verification loop](./s11-response-p1.json#L213) |
| **M3** (85) | Refinements, symptom and root-cause subtypes, metric rates, evaluation-ecosystem and grounding detail, correction and reliability-by-design vocabulary. | (§3) [○ Agency](./s03-boundaries-p1.json#L11), [○ Agent components](./s03-boundaries-p1.json#L35), [○ Agent goal](./s03-boundaries-p1.json#L62), [○ Multi-agent intent](./s03-boundaries-p1.json#L118), [○ Plan](./s03-boundaries-p1.json#L146), [○ Skills](./s03-boundaries-p1.json#L193), [○ System prompt](./s03-boundaries-p1.json#L220), [○ User intent](./s03-boundaries-p1.json#L274)<br>(§6) [† × Guardrails](./s06-governance-p1.json#L13), [○ Observability signal](./s06-governance-p1.json#L43), [○ Policy enforcement](./s06-governance-p1.json#L69), [○ Security boundary](./s06-governance-p1.json#L119)<br>(§7) [○ Agent memory](./s07-grounding-p1.json#L11), [○ Shared memory](./s07-grounding-p1.json#L118), [○ Tool result](./s07-grounding-p1.json#L145), [○ Trust requirement](./s07-grounding-p1.json#L170), [○ User-provided context](./s07-grounding-p1.json#L192), [○ Annotation](./s07-grounding-p2.json#L11), [○ Expected result](./s07-grounding-p2.json#L34), [○ Knowledge base](./s07-grounding-p2.json#L57), [○ Retrieval result](./s07-grounding-p2.json#L84), [○ Session memory](./s07-grounding-p2.json#L109)<br>(§8) [○ Authorization failure](./s08-failure-p1.json#L37), [○ Configuration error](./s08-failure-p1.json#L63), [○ Coordination failure](./s08-failure-p1.json#L86), [○ Goal misalignment](./s08-failure-p1.json#L110), [○ Message delivery failure](./s08-failure-p1.json#L136), [○ Planning error](./s08-failure-p1.json#L161), [○ Tool availability failure](./s08-failure-p1.json#L183), [○ Entity mismatch](./s08-failure-p1.json#L205), [○ Fabricated tool result](./s08-failure-p1.json#L228), [○ Incorrect task outcome](./s08-failure-p1.json#L250), [○ Overconfident error](./s08-failure-p1.json#L274), [○ Silent wrong action](./s08-failure-p1.json#L298), [○ Stale source error](./s08-failure-p1.json#L323), [○ Task abandonment](./s08-failure-p1.json#L347), [○ Ungrounded claim](./s08-failure-p1.json#L372), [○ User re-prompt](./s08-failure-p1.json#L398)<br>(§9) [○ Calibration error](./s09-metrics-p1.json#L107), [○ Configuration error rate](./s09-metrics-p1.json#L133), [○ Coordination failure rate](./s09-metrics-p1.json#L155), [○ Entity mismatch rate](./s09-metrics-p1.json#L177), [○ Fabricated tool result rate](./s09-metrics-p1.json#L199), [○ Goal misalignment rate](./s09-metrics-p1.json#L221), [○ Hallucination rate](./s09-metrics-p1.json#L243), [○ Incorrect task outcome rate](./s09-metrics-p1.json#L268), [○ Infrastructure failure rate](./s09-metrics-p1.json#L294), [○ Message delivery failure rate](./s09-metrics-p1.json#L317), [○ Planning error rate](./s09-metrics-p1.json#L339), [★ Policy violation rate](./s09-metrics-p1.json#L361), [○ Reasoning failure rate](./s09-metrics-p1.json#L383), [○ Recovery failure rate](./s09-metrics-p1.json#L406), [★ Repeated-run success rate](./s09-metrics-p1.json#L426), [○ Silent wrong action rate](./s09-metrics-p1.json#L457), [○ Stale source error rate](./s09-metrics-p1.json#L477), [○ Task abandonment rate](./s09-metrics-p1.json#L499), [○ Task success rate](./s09-metrics-p1.json#L521), [○ Tool availability failure rate](./s09-metrics-p1.json#L550), [○ Ungrounded claim rate](./s09-metrics-p1.json#L572), [★ User re-prompt rate](./s09-metrics-p1.json#L594), [○ Resource cost variance](./s09-metrics-p2.json#L11), [○ Retry budget utilisation](./s09-metrics-p2.json#L35)<br>(§10) [○ Context](./s10-ecosystem-p1.json#L53), [○ Context assembly](./s10-ecosystem-p1.json#L79), [○ Context source](./s10-ecosystem-p1.json#L105), [○ Entry point](./s10-ecosystem-p1.json#L127), [○ Model access](./s10-ecosystem-p1.json#L266), [○ Runtime platform](./s10-ecosystem-p1.json#L341), [○ Telemetry path](./s10-ecosystem-p1.json#L396), [○ Tool access](./s10-ecosystem-p1.json#L451), [○ Evaluator](./s10-ecosystem-p2.json#L11), [○ Message bus](./s10-ecosystem-p2.json#L35)<br>(§11) [† Self-correction](./s11-response-p1.json#L33), [○ Retry](./s11-response-p1.json#L143), [○ Abstention](./s11-response-p2.json#L11), [○ Circuit breaker](./s11-response-p2.json#L36), [○ Compensation](./s11-response-p2.json#L60), [○ Fallback](./s11-response-p2.json#L85), [○ Rollback](./s11-response-p2.json#L107), [† Proactive grounding](./s11-response-p1.json#L165), [○ Reliability by design](./s11-response-p1.json#L187), [○ Delegation control](./s11-response-p2.json#L132), [○ Policy gate](./s11-response-p2.json#L155), [○ Specification validation](./s11-response-p2.json#L179), [○ Version pinning](./s11-response-p2.json#L202) |
<!-- milestone-table:end -->

## Term symbols

Literature and source-review symbols on each term — **orthogonal to WG consensus** (`x-consensus-reached`). A term may show **two symbols**: a primary status (○ † △ ★) and an additional **×** when `x-discouraged-for-technical` is true (see below).

| Symbol | JSON field | Meaning |
|--------|------------|---------|
| ○ | `x-termStatus: stable` | **Literature aligned** — shared sense in papers or benchmarks; details in `literatureNote` |
| † | `x-termStatus: qualified` | **Qualifier required** — overloaded label; narrow in `definition` / `scopeNote` |
| △ | `x-termStatus: contested` | **Sources disagree** — incompatible definitions or placement (often cross-WG) |
| ★ | `x-termStatus: aaif-new` | **No prior source** — ARWG coinage without an established external label |
| × | `x-discouraged-for-technical: true` | **Additional marker** — imprecise, ambiguous, or too coarse for technical ARWG output; stacks with ○ † △ ★; prefer terms in the [census](#community-vocabulary-census) |
| **bold** term name | `x-consensus-reached: true` | **WG consensus** after a resolved PR thread — formatting only, not a literature symbol |

## Community vocabulary census

Different communities use **different words for the same underlying concept** — product docs, security operations, academic benchmarks, enterprise procurement. ARWG will build a **census** of those familiar labels and cross-link them to canonical JSON terms. Less precise or ambiguous labels remain valid in their home context; when **technical accuracy** is required (metrics, gap analysis, cross-WG claims), prefer the AAIF term in the right column — glossary entries with **×** flag that preference.

**Guidelines for census terms in JSON** (terms that appear in the table or carry **×**):

1. **`definition`** — state the sense ARWG indexes, even if narrower than everyday use.
2. **`scopeNote` / `literatureNote`** — list other common meanings or name the liaison WG sense when the same word means something else (e.g. [Workflow](./s03-boundaries-p0.json#L161) vs <u>Workflows & Process Integration</u>).
3. **`relatedTerms` / `contrastsWith`** — point to recommended AAIF terminology for technical output.
4. **`academicTerms`** — host literature-only labels (pass@k, ECE) that are never canonical AAIF terms.
5. Set **`x-discouraged-for-technical: true`** when the label should show **×** in this index in addition to its primary symbol.

D1 when a label must not stand alone: [Appendix C](../D1-terminology-taxonomy/appendices/C-discouraged-synonyms.md). Conflict register: [§12](../D1-terminology-taxonomy/12-conflict-resolution.md).

| Familiar label | AAIF term(s) | Note |
|----------------|--------------|------|
| pass@k | [Task success rate](./s09-metrics-p1.json#L500) | Academic single-run best-of-k — `academicTerms` only |
| pass^k | [Repeated-run success rate](./s09-metrics-p1.json#L409) | Academic all-trial success — `academicTerms` only |
| ECE | [Calibration error](./s09-metrics-p1.json#L104) | Expected calibration error — `academicTerms` only |
| Faithfulness | [Grounding](./s07-grounding-p0.json#L31), §8 symptom subtypes | RAG evaluation scalar — not one AAIF metric |
| [Hallucination](./s08-failure-p0.json#L141) | [Ungrounded claim](./s08-failure-p1.json#L357), [Entity mismatch](./s08-failure-p1.json#L197), [Stale source error](./s08-failure-p1.json#L310), … | Familiar umbrella (△ ×) — subtype required for measurement |
| [Guardrails](./s06-governance-p1.json#L13) | [Policy enforcement](./s06-governance-p1.json#L64), [Observability signal](./s06-governance-p1.json#L39) | Product/runtime vocabulary († ×) |
| [Trustworthiness](./s04-core-p0.json#L237) | [Accuracy](./s04-core-p0.json#L31), [Reliability](./s04-core-p0.json#L181), §5 dimensions, [Grounding](./s07-grounding-p0.json#L31) | Executive narrative († ×) — decompose for technical claims |
| AI safety (unqualified) | [Safety](./s05-reliability-dimensions-p0.json#L241) | Qualify which sense — see Appendix C |
| Reliability of LLM (unqualified) | [Model output reliability](./s04-core-p1.json#L11), [Agent reliability](./s04-core-p0.json#L66) | Disambiguate evaluation subject |
| Workflow (ambiguous) | [△ × Workflow](./s03-boundaries-p0.json#L161) | ARWG **evaluation subject** — align with <u>Workflows & Process Integration</u> on orchestration / durable execution |

---

### Other working groups column

**ARWG owns every category in this index by default.** In the section tables below, **Other working groups** lists external WGs whose deliverables overlap the category:

- <u>Underlined</u> — **potential** category owner or lead liaison (proposed — confirm in PR)
- **Bold** — **consensus** category owner after a resolved PR thread (none yet)

When a row has no external WGs, the cell is **—** (ARWG only).

## §3 — System boundaries & evaluation subjects

Every accuracy or reliability claim must name **what** is evaluated. This section defines the evaluation subjects — [Agent](./s03-boundaries-p0.json#L25), [Model](./s03-boundaries-p0.json#L102), [Multi-agent system](./s03-boundaries-p0.json#L131), [Workflow](./s03-boundaries-p0.json#L161), and [Evaluation subject](./s03-boundaries-p0.json#L75) — and [Agent boundary](./s03-boundaries-p0.json#L53), which separates the agent from users, operators, tools, and infrastructure.

[Workflow](./s03-boundaries-p0.json#L161) here is the **scored end-to-end subject** (agent steps plus scored non-agent steps). The same word is used elsewhere for orchestration; see [Community vocabulary census](#community-vocabulary-census).

**P0** fixes the evaluation object. **P1** adds terms needed to describe a run (trajectory, intent, specification). Agree **P0** before §4.

| Priority | Category | Terms | Other working groups | Milestone |
|----------|----------|-------|----------------------|-----------|
| **P0** (6)<br>`s03-boundaries-p0.json` | Evaluation subjects (6) | [○ Agent](./s03-boundaries-p0.json#L25)<br>[★ Agent boundary](./s03-boundaries-p0.json#L53)<br>[★ Evaluation subject](./s03-boundaries-p0.json#L75)<br>[† Model](./s03-boundaries-p0.json#L102)<br>[○ Multi-agent system](./s03-boundaries-p0.json#L131)<br>[△ × Workflow](./s03-boundaries-p0.json#L161) | <u>Workflows & Process Integration</u> (trajectory)<br><u>Observability & Traceability</u> (trajectory)<br><u>Identity & Trust</u> (agency)<br><u>Security & Privacy</u> (agency) | M1 |
| **P1** (11)<br>`s03-boundaries-p1.json` | Evaluation subjects (11) | [○ Agency](./s03-boundaries-p1.json#L11)<br>[○ Agent components](./s03-boundaries-p1.json#L34)<br>[○ Agent goal](./s03-boundaries-p1.json#L60)<br>[★ Agent specification](./s03-boundaries-p1.json#L88)<br>[○ Multi-agent intent](./s03-boundaries-p1.json#L114)<br>[○ Plan](./s03-boundaries-p1.json#L141)<br>[★ Scope ring](./s03-boundaries-p1.json#L165)<br>[○ Skills](./s03-boundaries-p1.json#L186)<br>[○ System prompt](./s03-boundaries-p1.json#L212)<br>[○ Trajectory](./s03-boundaries-p1.json#L239)<br>[○ User intent](./s03-boundaries-p1.json#L264) | <u>Workflows & Process Integration</u> (trajectory)<br><u>Observability & Traceability</u> (trajectory)<br><u>Identity & Trust</u> (agency)<br><u>Security & Privacy</u> (agency) | M2 (3)<br>M3 (8) |

## §4 — Core concepts — accuracy & output quality

### One run versus repeated runs

| | **Accuracy** | **Reliability** |
|---|--------------|-----------------|
| **Question** | Was this run correct against the declared criterion? | Does correctness hold across repeated runs and relevant condition changes? |
| **Scope** | One scored run | Repeated runs under a declared [Evaluation envelope](./s09-metrics-p1.json#L59) |
| **Parent terms** | [Accuracy](./s04-core-p0.json#L31); output quality in this section | [Reliability](./s04-core-p0.json#L181), [Agent reliability](./s04-core-p0.json#L66); dimension families in §5 |
| **Example metric** | [Task success rate](./s09-metrics-p1.json#L521) | [Repeated-run success rate](./s09-metrics-p1.json#L426) |

[Accuracy](./s04-core-p0.json#L31) and [Reliability](./s04-core-p0.json#L181) are separate claims: the first scores a single run; the second scores stability across repeats. This section also defines **output quality** — whether the result fits the task ([Response quality](./s04-core-p0.json#L322), [Task accuracy](./s04-core-p0.json#L352), [Process accuracy](./s04-core-p0.json#L296)) — and correctness qualifiers ([Annotated correctness](./s04-core-p0.json#L92), [Contextual correctness](./s04-core-p0.json#L122)). [Evidence accuracy](./s07-grounding-p0.json#L83) is in §7.

**P0** holds the parent terms. **P1** adds derived notions such as [Model output reliability](./s04-core-p1.json#L11) and [Realised accuracy](./s04-core-p1.json#L35). Agree **P0** before **P1**.

| Priority | Category | Terms | Other working groups | Milestone |
|----------|----------|-------|----------------------|-----------|
| **P0** (13)<br>`s04-core-p0.json` | Accuracy & reliability (8) | [△ Accuracy](./s04-core-p0.json#L31)<br>[† Agent reliability](./s04-core-p0.json#L66)<br>[○ Annotated correctness](./s04-core-p0.json#L92)<br>[△ Contextual correctness](./s04-core-p0.json#L122)<br>[† Infrastructure reliability](./s04-core-p0.json#L152)<br>[△ Reliability](./s04-core-p0.json#L181)<br>[★ Statistical coverage](./s04-core-p0.json#L211)<br>[† × Trustworthiness](./s04-core-p0.json#L237) | — | M1 (4)<br>M2 (4) |
|  | Output quality (5) | [† Functional correctness](./s04-core-p0.json#L270)<br>[○ Process accuracy](./s04-core-p0.json#L296)<br>[○ Response quality](./s04-core-p0.json#L322)<br>[○ Task accuracy](./s04-core-p0.json#L352)<br>[○ Task completion](./s04-core-p0.json#L377) | — | M1 (2)<br>M2 (3) |
| **P1** (4)<br>`s04-core-p1.json` | Accuracy & reliability (2) | [○ Model output reliability](./s04-core-p1.json#L11)<br>[★ Realised accuracy](./s04-core-p1.json#L35) | — | M2 |
|  | Output quality (2) | [○ Intent adherence](./s04-core-p1.json#L56)<br>[○ Skill adherence](./s04-core-p1.json#L80) | — | M2 |

## §5 — Reliability dimensions

After [Reliability](./s04-core-p0.json#L181) and [Agent reliability](./s04-core-p0.json#L66) in §4, this section names the **dimension families** used to describe reliability across repeated runs: [Consistency](./s05-reliability-dimensions-p0.json#L54), [Robustness](./s05-reliability-dimensions-p0.json#L212), [Calibration](./s05-reliability-dimensions-p0.json#L27), [Safety](./s05-reliability-dimensions-p0.json#L241), and refinements such as [Outcome consistency](./s05-reliability-dimensions-p0.json#L160) and [Input paraphrase robustness](./s05-reliability-dimensions-p0.json#L108).

**P0** holds the dimension families. **P2** adds [Cross-agent agreement](./s05-reliability-dimensions-p0.json#L294) for multi-agent settings.

| Priority | Category | Terms | Other working groups | Milestone |
|----------|----------|-------|----------------------|-----------|
| **P0** (10)<br>`s05-reliability-dimensions-p0.json` | Reliability dimensions (10) | [† Calibration](./s05-reliability-dimensions-p0.json#L27)<br>[△ Consistency](./s05-reliability-dimensions-p0.json#L54)<br>[★ Cross-agent factual alignment](./s05-reliability-dimensions-p0.json#L85)<br>[★ Input paraphrase robustness](./s05-reliability-dimensions-p0.json#L108)<br>[★ Operational fault robustness](./s05-reliability-dimensions-p0.json#L135)<br>[★ Outcome consistency](./s05-reliability-dimensions-p0.json#L160)<br>[★ Resource consistency](./s05-reliability-dimensions-p0.json#L188)<br>[† Robustness](./s05-reliability-dimensions-p0.json#L212)<br>[△ Safety](./s05-reliability-dimensions-p0.json#L241)<br>[★ Trajectory consistency](./s05-reliability-dimensions-p0.json#L267) | <u>Security & Privacy</u> (safety) | M1 |
| **P2** (1)<br>`s05-reliability-dimensions-p0.json` | Reliability dimensions (1) | [† Cross-agent agreement](./s05-reliability-dimensions-p0.json#L294) | <u>Security & Privacy</u> (safety) | M1 |

## §6 — Operational & governance terms

Terms for **attribution and control** — [Agent identity](./s06-governance-p0.json#L108), [Traceability](./s06-governance-p1.json#L90), [Recoverability](./s06-governance-p0.json#L37), [Policy enforcement](./s06-governance-p1.json#L64) — are not accuracy or reliability scores. They support audit, reproduction, and linking failures in §8 to responsible components.

**P0** covers identity, recoverability, and deterministic operation. **P1** adds observability and traceability. **P2** adds [Security boundary](./s06-governance-p1.json#L112).

| Priority | Category | Terms | Other working groups | Milestone |
|----------|----------|-------|----------------------|-----------|
| **P0** (5)<br>`s06-governance-p0.json` | Correction mechanisms (1) | [○ Recoverability](./s06-governance-p0.json#L37) | <u>Workflows & Process Integration</u> (HITL)<br><u>Security & Privacy</u> (policy gates) | M1 |
|  | Measurement & evaluation (2) | [† Deterministic operation](./s06-governance-p0.json#L61)<br>[○ Deterministic validation](./s06-governance-p0.json#L87) | <u>Observability & Traceability</u> (trace requirements for attribution) | M2 |
|  | Observability & attribution (2) | [○ Agent identity](./s06-governance-p0.json#L108)<br>[† Explainability](./s06-governance-p0.json#L130) | <u>Observability & Traceability</u> (trace, telemetry)<br><u>Identity & Trust</u> (agent identity)<br><u>Security & Privacy</u> (policy enforcement) | M1 (1)<br>M2 (1) |
| **P1** (4)<br>`s06-governance-p1.json` | Observability & attribution (4) | [† × Guardrails](./s06-governance-p1.json#L13)<br>[○ Observability signal](./s06-governance-p1.json#L39)<br>[○ Policy enforcement](./s06-governance-p1.json#L64)<br>[○ Traceability](./s06-governance-p1.json#L90) | <u>Observability & Traceability</u> (trace, telemetry)<br><u>Identity & Trust</u> (agent identity)<br><u>Security & Privacy</u> (policy enforcement) | M2 (1)<br>M3 (3) |
| **P2** (1)<br>`s06-governance-p1.json` | Observability & attribution (1) | [○ Security boundary](./s06-governance-p1.json#L112) | <u>Observability & Traceability</u> (trace, telemetry)<br><u>Identity & Trust</u> (agent identity)<br><u>Security & Privacy</u> (policy enforcement) | M3 |

## §7 — Grounding, evidence & world

This section defines how agent outputs relate to **authoritative sources**: [Grounding](./s07-grounding-p0.json#L31), [Trust anchor](./s07-grounding-p0.json#L59), [Evidence](./s07-grounding-p1.json#L38), [Tool result](./s07-grounding-p1.json#L140), and [Evidence accuracy](./s07-grounding-p0.json#L83). It supports classifying failures in §8 that come from stale, missing, or mismatched world state rather than from reasoning alone.

**P0** — grounding, trust anchor, evidence accuracy. **P1** — operational evidence types. **P2** — knowledge bases and session memory.

| Priority | Category | Terms | Other working groups | Milestone |
|----------|----------|-------|----------------------|-----------|
| **P0** (3)<br>`s07-grounding-p0.json` | Evaluation ecosystem (2) | [† Grounding](./s07-grounding-p0.json#L31)<br>[○ Trust anchor](./s07-grounding-p0.json#L59) | <u>Workflows & Process Integration</u> (orchestrator, tool)<br><u>Observability & Traceability</u> (telemetry, trace) | M1 |
|  | Output quality (1) | [★ Evidence accuracy](./s07-grounding-p0.json#L83) | — | M1 |
| **P1** (8)<br>`s07-grounding-p1.json` | Evaluation ecosystem (8) | [○ Agent memory](./s07-grounding-p1.json#L11)<br>[○ Evidence](./s07-grounding-p1.json#L38)<br>[○ Ground truth](./s07-grounding-p1.json#L63)<br>[○ Provenance](./s07-grounding-p1.json#L87)<br>[○ Shared memory](./s07-grounding-p1.json#L114)<br>[○ Tool result](./s07-grounding-p1.json#L140)<br>[○ Trust requirement](./s07-grounding-p1.json#L164)<br>[○ User-provided context](./s07-grounding-p1.json#L185) | <u>Workflows & Process Integration</u> (orchestrator, tool)<br><u>Observability & Traceability</u> (telemetry, trace) | M2 (3)<br>M3 (5) |
| **P2** (5)<br>`s07-grounding-p2.json` | Evaluation ecosystem (5) | [○ Annotation](./s07-grounding-p2.json#L11)<br>[○ Expected result](./s07-grounding-p2.json#L33)<br>[○ Knowledge base](./s07-grounding-p2.json#L55)<br>[○ Retrieval result](./s07-grounding-p2.json#L81)<br>[○ Session memory](./s07-grounding-p2.json#L105) | <u>Workflows & Process Integration</u> (orchestrator, tool)<br><u>Observability & Traceability</u> (telemetry, trace) | M3 |

## §8 — Failure vocabulary

**Symptoms** are what operators and users observe ([Symptom](./s08-failure-p0.json#L169), [Ungrounded claim](./s08-failure-p1.json#L357), [Silent wrong action](./s08-failure-p1.json#L286), …). **Root causes** are classes used for remediation ([Root cause](./s08-failure-p0.json#L113), [Planning error](./s08-failure-p1.json#L155), [Coordination failure](./s08-failure-p1.json#L83), …). [Hallucination](./s08-failure-p0.json#L141) is a familiar symptom label; prefer a specific subtype for measurement.

**P0** — parent terms and top-level classes. **P1** — observable subtypes; each pairs with a rate metric in §9.

| Priority | Category | Terms | Other working groups | Milestone |
|----------|----------|-------|----------------------|-----------|
| **P0** (6)<br>`s08-failure-p0.json` | Root causes (4) | [○ Infrastructure failure](./s08-failure-p0.json#L37)<br>[○ Reasoning failure](./s08-failure-p0.json#L63)<br>[○ Recovery failure](./s08-failure-p0.json#L89)<br>[○ Root cause](./s08-failure-p0.json#L113) | <u>Security & Privacy</u> (authorization, policy)<br><u>Workflows & Process Integration</u> (coordination) | M1 (1)<br>M2 (3) |
|  | Symptoms (2) | [△ × Hallucination](./s08-failure-p0.json#L141)<br>[○ Symptom](./s08-failure-p0.json#L169) | — | M1 |
| **P1** (17)<br>`s08-failure-p1.json` | Measurement & evaluation (1) | [★ Failure attribution](./s08-failure-p1.json#L11) | <u>Observability & Traceability</u> (trace requirements for attribution) | M2 |
|  | Root causes (7) | [○ Authorization failure](./s08-failure-p1.json#L36)<br>[○ Configuration error](./s08-failure-p1.json#L61)<br>[○ Coordination failure](./s08-failure-p1.json#L83)<br>[○ Goal misalignment](./s08-failure-p1.json#L106)<br>[○ Message delivery failure](./s08-failure-p1.json#L131)<br>[○ Planning error](./s08-failure-p1.json#L155)<br>[○ Tool availability failure](./s08-failure-p1.json#L176) | <u>Security & Privacy</u> (authorization, policy)<br><u>Workflows & Process Integration</u> (coordination) | M3 |
|  | Symptoms (9) | [○ Entity mismatch](./s08-failure-p1.json#L197)<br>[○ Fabricated tool result](./s08-failure-p1.json#L219)<br>[○ Incorrect task outcome](./s08-failure-p1.json#L240)<br>[○ Overconfident error](./s08-failure-p1.json#L263)<br>[○ Silent wrong action](./s08-failure-p1.json#L286)<br>[○ Stale source error](./s08-failure-p1.json#L310)<br>[○ Task abandonment](./s08-failure-p1.json#L333)<br>[○ Ungrounded claim](./s08-failure-p1.json#L357)<br>[○ User re-prompt](./s08-failure-p1.json#L382) | — | M3 |

## §9 — Metrics & measurement

Metrics **quantify** terms from §4–§8. [Evaluation metric](./s09-metrics-p1.json#L33) is the parent; examples include [Task success rate](./s09-metrics-p1.json#L521), [Repeated-run success rate](./s09-metrics-p1.json#L426), and rates paired with §8 symptoms and root causes. Each metric links to the term it measures via `x-measuresTerm` in JSON.

**P0** (in **P1** file band) — evaluation metric parent. **P1** — dimension and failure rates. **P2** — cost and variance adjuncts.

| Priority | Category | Terms | Other working groups | Milestone |
|----------|----------|-------|----------------------|-----------|
| **P0** (1)<br>`s09-metrics-p1.json` | Metrics (1) | [○ Evaluation metric](./s09-metrics-p1.json#L33) | — | M2 |
| **P1** (24)<br>`s09-metrics-p1.json` | Measurement & evaluation (2) | [★ Evaluation envelope](./s09-metrics-p1.json#L59)<br>[○ Evaluation methodology](./s09-metrics-p1.json#L81) | <u>Observability & Traceability</u> (trace requirements for attribution) | M2 |
|  | Metrics (22) | [○ Calibration error](./s09-metrics-p1.json#L104)<br>[○ Configuration error rate](./s09-metrics-p1.json#L129)<br>[○ Coordination failure rate](./s09-metrics-p1.json#L150)<br>[○ Entity mismatch rate](./s09-metrics-p1.json#L171)<br>[○ Fabricated tool result rate](./s09-metrics-p1.json#L192)<br>[○ Goal misalignment rate](./s09-metrics-p1.json#L213)<br>[○ Hallucination rate](./s09-metrics-p1.json#L234)<br>[○ Incorrect task outcome rate](./s09-metrics-p1.json#L258)<br>[○ Infrastructure failure rate](./s09-metrics-p1.json#L283)<br>[○ Message delivery failure rate](./s09-metrics-p1.json#L305)<br>[○ Planning error rate](./s09-metrics-p1.json#L326)<br>[★ Policy violation rate](./s09-metrics-p1.json#L347)<br>[○ Reasoning failure rate](./s09-metrics-p1.json#L368)<br>[○ Recovery failure rate](./s09-metrics-p1.json#L390)<br>[★ Repeated-run success rate](./s09-metrics-p1.json#L409)<br>[○ Silent wrong action rate](./s09-metrics-p1.json#L439)<br>[○ Stale source error rate](./s09-metrics-p1.json#L458)<br>[○ Task abandonment rate](./s09-metrics-p1.json#L479)<br>[○ Task success rate](./s09-metrics-p1.json#L500)<br>[○ Tool availability failure rate](./s09-metrics-p1.json#L528)<br>[○ Ungrounded claim rate](./s09-metrics-p1.json#L549)<br>[★ User re-prompt rate](./s09-metrics-p1.json#L570) | — | M3 |
| **P2** (2)<br>`s09-metrics-p2.json` | Metrics (2) | [○ Resource cost variance](./s09-metrics-p2.json#L11)<br>[○ Retry budget utilisation](./s09-metrics-p2.json#L34) | — | M3 |

## §10 — Evaluation ecosystem

**How** an evaluation runs: [Benchmark](./s10-ecosystem-p1.json#L25), [Evaluation scenario](./s10-ecosystem-p1.json#L173), [Evaluation participant](./s10-ecosystem-p1.json#L149) ([User](./s10-ecosystem-p1.json#L484), [Operator](./s10-ecosystem-p1.json#L281), [Tool](./s10-ecosystem-p1.json#L425), …), [Trace](./s10-ecosystem-p1.json#L459), and [Infrastructure](./s10-ecosystem-p1.json#L197). Distinct from the properties in §3–§5.

**P1** — core ecosystem nouns. **P2** — secondary participants such as [Evaluator](./s10-ecosystem-p2.json#L11).

| Priority | Category | Terms | Other working groups | Milestone |
|----------|----------|-------|----------------------|-----------|
| **P1** (19)<br>`s10-ecosystem-p1.json` | Evaluation ecosystem (19) | [○ Benchmark](./s10-ecosystem-p1.json#L25)<br>[○ Context](./s10-ecosystem-p1.json#L52)<br>[○ Context assembly](./s10-ecosystem-p1.json#L77)<br>[○ Context source](./s10-ecosystem-p1.json#L102)<br>[○ Entry point](./s10-ecosystem-p1.json#L123)<br>[○ Evaluation participant](./s10-ecosystem-p1.json#L149)<br>[○ Evaluation scenario](./s10-ecosystem-p1.json#L173)<br>[○ Infrastructure](./s10-ecosystem-p1.json#L197)<br>[○ Leaderboard](./s10-ecosystem-p1.json#L227)<br>[○ Model access](./s10-ecosystem-p1.json#L257)<br>[○ Operator](./s10-ecosystem-p1.json#L281)<br>[○ Orchestrator](./s10-ecosystem-p1.json#L306)<br>[○ Runtime platform](./s10-ecosystem-p1.json#L329)<br>[○ Telemetry](./s10-ecosystem-p1.json#L356)<br>[○ Telemetry path](./s10-ecosystem-p1.json#L382)<br>[○ Tool](./s10-ecosystem-p1.json#L410)<br>[○ Tool access](./s10-ecosystem-p1.json#L435)<br>[○ Trace](./s10-ecosystem-p1.json#L459)<br>[○ User](./s10-ecosystem-p1.json#L484) | <u>Workflows & Process Integration</u> (orchestrator, tool)<br><u>Observability & Traceability</u> (telemetry, trace) | M1 (9)<br>M2 (2)<br>M3 (8) |
| **P2** (2)<br>`s10-ecosystem-p2.json` | Evaluation ecosystem (2) | [○ Evaluator](./s10-ecosystem-p2.json#L11)<br>[○ Message bus](./s10-ecosystem-p2.json#L34) | <u>Workflows & Process Integration</u> (orchestrator, tool)<br><u>Observability & Traceability</u> (telemetry, trace) | M3 |

## §11 — Response — design & correction

Patterns that **prevent** failures ([Verification loop](./s11-response-p1.json#L206), [Proactive grounding](./s11-response-p1.json#L160)) and **recover** from them ([Retry](./s11-response-p1.json#L139), [Human in the loop](./s11-response-p1.json#L110), [Rollback](./s11-response-p2.json#L103)).

**P0** — [Self-correction](./s11-response-p1.json#L33). **P1** — primary correction mechanisms and reliability by design. **P2** — operational controls (circuit breaker, policy gate, version pinning).

| Priority | Category | Terms | Other working groups | Milestone |
|----------|----------|-------|----------------------|-----------|
| **P0** (1)<br>`s11-response-p1.json` | Correction mechanisms (1) | [† Self-correction](./s11-response-p1.json#L33) | <u>Workflows & Process Integration</u> (HITL)<br><u>Security & Privacy</u> (policy gates) | M3 |
| **P1** (7)<br>`s11-response-p1.json` | Correction mechanisms (4) | [★ Correction mechanism](./s11-response-p1.json#L59)<br>[○ Escalation](./s11-response-p1.json#L87)<br>[† Human in the loop](./s11-response-p1.json#L110)<br>[○ Retry](./s11-response-p1.json#L139) | <u>Workflows & Process Integration</u> (HITL)<br><u>Security & Privacy</u> (policy gates) | M1 (1)<br>M2 (2)<br>M3 (1) |
|  | Reliability by design (3) | [† Proactive grounding](./s11-response-p1.json#L160)<br>[○ Reliability by design](./s11-response-p1.json#L181)<br>[○ Verification loop](./s11-response-p1.json#L206) | — | M2 (1)<br>M3 (2) |
| **P2** (9)<br>`s11-response-p2.json` | Correction mechanisms (5) | [○ Abstention](./s11-response-p2.json#L11)<br>[○ Circuit breaker](./s11-response-p2.json#L35)<br>[○ Compensation](./s11-response-p2.json#L58)<br>[○ Fallback](./s11-response-p2.json#L82)<br>[○ Rollback](./s11-response-p2.json#L103) | <u>Workflows & Process Integration</u> (HITL)<br><u>Security & Privacy</u> (policy gates) | M3 |
|  | Reliability by design (4) | [○ Delegation control](./s11-response-p2.json#L127)<br>[○ Policy gate](./s11-response-p2.json#L149)<br>[○ Specification validation](./s11-response-p2.json#L172)<br>[○ Version pinning](./s11-response-p2.json#L194) | — | M3 |

---

## Source document lookup

Running notes, D1 drafts, and related working-group threads used overlapping labels for the same concepts. The table below maps those **source labels** to the canonical term in this glossary. Thread and draft content should already appear in the JSON fields listed above; if a contribution is missing or misrepresented, fix it in a PR on the linked file.

| Source label | Section | Term |
|--------------|---------|------|
| Accuracy | (§4) | [Accuracy](./s04-core-p0.json#L31) · `s04-core-p0.json` |
| Statistical coverage | (§4) | [Statistical coverage](./s04-core-p0.json#L211) · `s04-core-p0.json` |
| Reliability (unqualified) | (§4) | [Reliability](./s04-core-p0.json#L181) · `s04-core-p0.json` |
| Reliability of agent / MAS | (§4) | [Agent reliability](./s04-core-p0.json#L66) · `s04-core-p0.json` |
| Reliability of LLM | (§4, P1) | [Model output reliability](./s04-core-p1.json#L11) · `s04-core-p1.json` |
| Reliability of infrastructure | (§4) | [Infrastructure reliability](./s04-core-p0.json#L152) · `s04-core-p0.json` |
| Trustworthiness | (§4) | [† × Trustworthiness](./s04-core-p0.json#L237) · `s04-core-p0.json` |
| Response quality | (§4) | [Response quality](./s04-core-p0.json#L322) · `s04-core-p0.json` |
| Functional correctness | (§4) | [Functional correctness](./s04-core-p0.json#L270) · `s04-core-p0.json` |
| Task completion | (§4) | [Task completion](./s04-core-p0.json#L377) · `s04-core-p0.json` |
| Consistency | (§5) | [Consistency](./s05-reliability-dimensions-p0.json#L54) · `s05-reliability-dimensions-p0.json` (+ [Outcome](./s05-reliability-dimensions-p0.json#L160) / [Trajectory](./s05-reliability-dimensions-p0.json#L267) / [Resource](./s05-reliability-dimensions-p0.json#L188) consistency) |
| Robustness | (§5) | [Robustness](./s05-reliability-dimensions-p0.json#L212) · `s05-reliability-dimensions-p0.json` (+ [Input paraphrase robustness](./s05-reliability-dimensions-p0.json#L108)) |
| Recoverability | (§6) | [Recoverability](./s06-governance-p0.json#L37) · `s06-governance-p0.json` |
| Explainability | (§6) | [Explainability](./s06-governance-p0.json#L130) · `s06-governance-p0.json` |
| Deterministic | (§6) | [Deterministic operation](./s06-governance-p0.json#L61), [Deterministic validation](./s06-governance-p0.json#L87) · `s06-governance-p0.json` |
| Agent identity | (§6) | [Agent identity](./s06-governance-p0.json#L108) · `s06-governance-p0.json` |
| Hallucinations | (§8) | [△ × Hallucination](./s08-failure-p0.json#L141) · `s08-failure-p0.json` (+ subtypes in `s08-failure-p1.json`) |

Also included from related source discussion: [Annotated correctness](./s04-core-p0.json#L92) vs [Contextual correctness](./s04-core-p0.json#L122); [Calibration](./s05-reliability-dimensions-p0.json#L27).
