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
| (§4) | Accuracy, reliability, and output quality | Defines *correct on this run* (accuracy) and *stable across repeats* (reliability), plus task-facing output quality |
| (§5) | Reliability dimensions | Decomposes “reliable” into consistency, robustness, calibration, … |
| (§6) | Operational and governance terms | Identity, traceability, recoverability — not quality dimensions |
| (§7) | Grounding, evidence, and world | How outputs relate to authoritative state |
| (§8) | Failure vocabulary | Symptoms and root causes for remediation |
| (§9) | Metrics and measurement | Quantifiers linked to (§4)–(§8) via `x-measuresTerm` |
| (§10) | Evaluation ecosystem | Benchmarks, scenarios, traces, participants |
| (§11) | Reliability by design; correction and control | Prevent and react to failures (D1 layer 5) |

Each section below adds a short **P0 / P1 / P2** note: parent terms in **P0** are what refinements in **P1** and **P2** presuppose. That ordering helps end-to-end review; it is not a gate for contributors.

## Cross-cutting topics

Transversal concerns are **split across numbered sections** but each has a primary home in this index. Use this table to find vocabulary by topic; full definitions stay in the section tables below.

| Topic | Primary index section | Also touches |
|-------|----------------------|--------------|
| **Metrics & quantifiers** | [(§9)](#9--metrics--measurement) | (§4)–(§8) via `x-measuresTerm` on rate terms |
| **Evaluation ecosystem** | [(§10)](#10--evaluation-ecosystem) | (§3) evaluation subjects; (§6) evaluation envelope |
| **Governance & identity** | [(§6)](#6--operational--governance-terms) | Charter assumptions; (§10) operators and infrastructure |
| **Grounding & world** | [(§7)](#7--grounding-evidence--world) | (§4) evidence accuracy; (§8) hallucination subtypes |
| **Response & correction** | [(§11)](#11--response--design--correction) | (§6) recoverability |

## How to contribute

Before editing terms, read [`CONTRIBUTING.md`](./CONTRIBUTING.md) for JSON field semantics, alignment with the Taxonomy WG schema, and the `x-*` review fields. See [`../CURRENT-WORKSTREAMS.md`](../CURRENT-WORKSTREAMS.md) for workstreams and pull-request merge practice.

Contributors work in different ways — all are valid:

- **By domain.** Jump to the section that matches your expertise (for example (§8) failures, (§9) metrics, (§6) governance) and open a PR on the linked `s*.json` file.
- **By dependency.** If you prefer a full pass, reading (§3) through (§8) in order shows how terms chain together; settle **P0** in a section before debating **P1** leaves in the same section. Open a PR on the JSON file for the terms you change.
- **By source label.** If you arrive with a term from running notes or an earlier draft, use [**Source document lookup**](#source-document-lookup) at the end of this file to find the canonical JSON entry.

**Section and document editors.** We welcome volunteers to **lead review** for one or more sections (for example (§8) failures or (§9) metrics) or for the **README and JSON index as a whole**. An editor helps keep section prose and term records coherent, triages PR comments in their slice, and surfaces open questions to the working group. You do not need to own every term — ad hoc contributions remain welcome. To volunteer, say so in a PR comment, on the [running notes](../CURRENT-WORKSTREAMS.md) Taxonomy thread, or at a WG meeting.

## Term symbols

Literature and source-review symbols on each term — **orthogonal to WG consensus** (`x-consensus-reached`).

| Symbol | JSON `x-termStatus` | Meaning |
|--------|---------------------|---------|
| ○ | `stable` | **Literature aligned** — shared sense in papers or benchmarks; details in `literatureNote` |
| † | `qualified` | **Qualifier required** — overloaded label; narrow in `definition` / `scopeNote` |
| △ | `contested` | **Sources disagree** — incompatible definitions or placement across sources |
| ★ | `aaif-new` | **No prior source** — ARWG coinage without an established external label |
| **bold** term name | `x-consensus-reached: true` | **WG consensus** after a resolved PR thread — formatting only, not a fifth literature symbol |

---

## §3 — System boundaries & evaluation subjects

Every accuracy or reliability claim must name *what* is evaluated. We open here because until agent, multi-agent system, workflow, and model are distinct, the same score can mean the model answered correctly or the business process succeeded — and gap analysis cannot compare like with like.

Evaluation scope is not a single slider from “model only” to “full enterprise”. It is a set of **dimensions that may be orthogonal**: the agent in isolation, the multi-agent roster, the workflow, environment and grounding, infrastructure and deployment, governance and identity, users and human-in-the-loop, safety and operations. An agent can score well on a narrow benchmark yet fail in deployment — for example when a user’s query, persona, or context makes a technically correct answer **useless** (out of scope, wrong granularity, too long, or not actionable). Each **participant** in a benchmark or production run (user, operator, tool, orchestrator, infrastructure) can introduce **different metrics**, or **different ways to assess the same metric**. D1 will therefore need **sections and subsections** that different experts can own (model evaluators, workflow integrators, observability, identity, security). This slice supplies the shared nouns; the table below lists evaluation subjects and the **agent boundary** vocabulary that separates agent-internal state from users, operators, infrastructure, and authoritative world sources.

**P0** locks the evaluation-object terms the rest of the narrative assumes (agent, MAS, workflow, evaluation subject, model). **P1** adds agent specification, trajectory, intent, scope rings, and related terms needed to reproduce a run but not to choose the object itself. Settle **P0** before §4 — if agent versus workflow is still disputed, nothing downstream can stabilize.

| Priority | Category | Terms | Other working groups |
|----------|----------|-------|----------------------|
| **P0** (6)<br>`s03-boundaries-p0.json` | Evaluation subjects (6) | [○ Agent](./s03-boundaries-p0.json#L25)<br>[○ Agent boundary](./s03-boundaries-p0.json#L53)<br>[○ Evaluation subject](./s03-boundaries-p0.json#L75)<br>[○ Model](./s03-boundaries-p0.json#L102)<br>[○ Multi-agent system](./s03-boundaries-p0.json#L131)<br>[○ Workflow](./s03-boundaries-p0.json#L161) | - Workflows & Process Integration<br>- Observability & Traceability (trajectory)<br>- Identity & Trust (agency)<br>- Security & Privacy (agency) |
| **P1** (11)<br>`s03-boundaries-p1.json` | Evaluation subjects (11) | [○ Agency](./s03-boundaries-p1.json#L11)<br>[○ Agent components](./s03-boundaries-p1.json#L34)<br>[○ Agent goal](./s03-boundaries-p1.json#L60)<br>[○ Agent specification](./s03-boundaries-p1.json#L88)<br>[○ Multi-agent intent](./s03-boundaries-p1.json#L114)<br>[○ Plan](./s03-boundaries-p1.json#L141)<br>[○ Scope ring](./s03-boundaries-p1.json#L165)<br>[○ Skills](./s03-boundaries-p1.json#L186)<br>[○ System prompt](./s03-boundaries-p1.json#L212)<br>[○ Trajectory](./s03-boundaries-p1.json#L239)<br>[○ User intent](./s03-boundaries-p1.json#L264) | - Workflows & Process Integration<br>- Observability & Traceability (trajectory)<br>- Identity & Trust (agency)<br>- Security & Privacy (agency) |

## §4 — Core concepts — accuracy & output quality

Once evaluation objects are fixed in §3, this section defines the two charter properties — **accuracy** (correct on this run against a declared criterion) and **reliability** (stable across repeats and conditions). Core terms from the source documents are listed here and in [Source document lookup](#source-document-lookup). Bare correctness is not enough for operators or end users: a response can be factually aligned yet **wrong for the task** (misunderstood intent, wrong skill, incomplete process step). Output-quality terms bridge that gap so §5 dimensions, §8 failures, and metrics can distinguish “wrong answer” from “right answer, wrong delivery”.

**P0** is the charter-aligned core: accuracy, reliability, annotated versus contextual correctness, task and process accuracy, evidence accuracy, and related parent terms. **P1** holds derived notions such as realised accuracy and model output reliability that presuppose those distinctions; do not approve **P1** until **P0** correctness variants are accepted.

| Priority | Category | Terms | Other working groups |
|----------|----------|-------|----------------------|
| **P0** (13)<br>`s04-core-p0.json` | Accuracy & reliability (8) | [○ Accuracy](./s04-core-p0.json#L31)<br>[○ Agent reliability](./s04-core-p0.json#L66)<br>[○ Annotated correctness](./s04-core-p0.json#L92)<br>[○ Contextual correctness](./s04-core-p0.json#L122)<br>[○ Infrastructure reliability](./s04-core-p0.json#L152)<br>[○ Reliability](./s04-core-p0.json#L181)<br>[○ Statistical coverage](./s04-core-p0.json#L211)<br>[† Trustworthiness](./s04-core-p0.json#L237) | - ARWG primary — accuracy/reliability sense owned here |
|  | Output quality (5) | [○ Functional correctness](./s04-core-p0.json#L270)<br>[○ Process accuracy](./s04-core-p0.json#L296)<br>[○ Response quality](./s04-core-p0.json#L322)<br>[○ Task accuracy](./s04-core-p0.json#L352)<br>[○ Task completion](./s04-core-p0.json#L377) | - ARWG primary |
| **P1** (4)<br>`s04-core-p1.json` | Accuracy & reliability (2) | [○ Model output reliability](./s04-core-p1.json#L11)<br>[○ Realised accuracy](./s04-core-p1.json#L35) | - ARWG primary — accuracy/reliability sense owned here |
|  | Output quality (2) | [○ Intent adherence](./s04-core-p1.json#L56)<br>[○ Skill adherence](./s04-core-p1.json#L80) | - ARWG primary |

## §5 — Reliability dimensions

With **Reliability** and **Agent reliability** from §4 in place, this section explains *why* “reliable” must be decomposed. Enterprise buyers and benchmark designers need named families — consistency, robustness under paraphrase or operational fault, calibration, safety — instead of a single pass/fail label that hides which stress broke. Input paraphrase and operational fault robustness belong here; adversarial stress, governance breakage, and user-visible symptoms often surface together with §8 failure terms. Subsections in D1 can track dimension families so coverage matrices and SLA authors edit the slice they own.

**P0** holds the Princeton-aligned dimension families and outcome consistency required for any reliability claim. **P2** adds cross-agent agreement as a multi-agent refinement. There is no **P1** band in this section; settle **P0** before metrics and before deep §8 work that cites dimension names.

| Priority | Category | Terms | Other working groups |
|----------|----------|-------|----------------------|
| **P0** (10)<br>`s05-reliability-dimensions-p0.json` | Reliability dimensions (10) | [○ Calibration](./s05-reliability-dimensions-p0.json#L27)<br>[○ Consistency](./s05-reliability-dimensions-p0.json#L54)<br>[○ Cross-agent factual alignment](./s05-reliability-dimensions-p0.json#L85)<br>[○ Input paraphrase robustness](./s05-reliability-dimensions-p0.json#L108)<br>[○ Operational fault robustness](./s05-reliability-dimensions-p0.json#L135)<br>[○ Outcome consistency](./s05-reliability-dimensions-p0.json#L160)<br>[○ Resource consistency](./s05-reliability-dimensions-p0.json#L188)<br>[○ Robustness](./s05-reliability-dimensions-p0.json#L212)<br>[○ Safety](./s05-reliability-dimensions-p0.json#L241)<br>[○ Trajectory consistency](./s05-reliability-dimensions-p0.json#L267) | - Security & Privacy (safety)<br>- ARWG primary for measurement dimensions |
| **P2** (1)<br>`s05-reliability-dimensions-p0.json` | Reliability dimensions (1) | [○ Cross-agent agreement](./s05-reliability-dimensions-p0.json#L294) | - Security & Privacy (safety)<br>- ARWG primary for measurement dimensions |

## §6 — Operational & governance terms

Attribution, reproducibility, and audit require vocabulary that is **not** a quality dimension — agent identity, traceability, recoverability, deterministic validation, policy enforcement. Without these terms, §8 cannot answer *who* failed or *whether* the run can be reproduced, and operators cannot connect scores to controls. This slice is where Observability, Identity & Trust, and Security working groups intersect ARWG; D1 subsections should let each liaison lead their overlap without redefining accuracy or reliability.

**P0** covers production prerequisites: identity, recoverability, explainability, and deterministic operation. **P1** adds observability signals and traceability shared with the Observability working group. **P2** names the security boundary as a Security working group touchpoint. Review governance **P0** before deep §8 attribution work.

| Priority | Category | Terms | Other working groups |
|----------|----------|-------|----------------------|
| **P0** (5)<br>`s06-governance-p0.json` | Correction mechanisms (1) | [○ Recoverability](./s06-governance-p0.json#L37) | - Workflows & Process Integration (HITL)<br>- Security & Privacy (policy gates)<br>- ARWG charter scope |
|  | Measurement & evaluation (2) | [○ Deterministic operation](./s06-governance-p0.json#L61)<br>[○ Deterministic validation](./s06-governance-p0.json#L87) | - ARWG primary<br>- Observability & Traceability (trace requirements for attribution) |
|  | Observability & attribution (2) | [○ Agent identity](./s06-governance-p0.json#L108)<br>[○ Explainability](./s06-governance-p0.json#L130) | - Observability & Traceability (trace, telemetry)<br>- Identity & Trust (agent identity)<br>- Security & Privacy (guardrails, policy enforcement) |
| **P1** (4)<br>`s06-governance-p1.json` | Observability & attribution (4) | [○ Guardrails](./s06-governance-p1.json#L13)<br>[○ Observability signal](./s06-governance-p1.json#L39)<br>[○ Policy enforcement](./s06-governance-p1.json#L64)<br>[○ Traceability](./s06-governance-p1.json#L90) | - Observability & Traceability (trace, telemetry)<br>- Identity & Trust (agent identity)<br>- Security & Privacy (guardrails, policy enforcement) |
| **P2** (1)<br>`s06-governance-p1.json` | Observability & attribution (1) | [○ Security boundary](./s06-governance-p1.json#L112) | - Observability & Traceability (trace, telemetry)<br>- Identity & Trust (agent identity)<br>- Security & Privacy (guardrails, policy enforcement) |

## §7 — Grounding, evidence & world

Many apparent reasoning errors are **grounding** failures — stale sources, wrong entities, ungrounded claims — not flaws in the model’s internal chain-of-thought. This section names how outputs relate to authoritative world state: trust anchors, evidence, tool results, provenance, shared memory. It explains why gap analysis must separate “model wrong” from “world or API wrong”, and why hallucination subtypes in §8 need a grounding vocabulary first. Tool and orchestration experts may own evidence-source subsections; measurement authors own evidence-accuracy links to §4.

**P0** establishes grounding, trust anchor, and evidence accuracy as the minimum to classify a claim as grounded. **P1** adds operational evidence types (tool result, ground truth, provenance). **P2** covers evaluation infrastructure such as knowledge bases and session memory. Settle **P0** before §8 hallucination subtypes.

| Priority | Category | Terms | Other working groups |
|----------|----------|-------|----------------------|
| **P0** (3)<br>`s07-grounding-p0.json` | Evaluation ecosystem (2) | [○ Grounding](./s07-grounding-p0.json#L31)<br>[○ Trust anchor](./s07-grounding-p0.json#L59) | - Workflows & Process Integration (orchestrator, tool)<br>- Observability & Traceability (telemetry, trace)<br>- ARWG gap inventory |
|  | Output quality (1) | [○ Evidence accuracy](./s07-grounding-p0.json#L83) | - ARWG primary |
| **P1** (8)<br>`s07-grounding-p1.json` | Evaluation ecosystem (8) | [○ Agent memory](./s07-grounding-p1.json#L11)<br>[○ Evidence](./s07-grounding-p1.json#L38)<br>[○ Ground truth](./s07-grounding-p1.json#L63)<br>[○ Provenance](./s07-grounding-p1.json#L87)<br>[○ Shared memory](./s07-grounding-p1.json#L114)<br>[○ Tool result](./s07-grounding-p1.json#L140)<br>[○ Trust requirement](./s07-grounding-p1.json#L164)<br>[○ User-provided context](./s07-grounding-p1.json#L185) | - Workflows & Process Integration (orchestrator, tool)<br>- Observability & Traceability (telemetry, trace)<br>- ARWG gap inventory |
| **P2** (5)<br>`s07-grounding-p2.json` | Evaluation ecosystem (5) | [○ Annotation](./s07-grounding-p2.json#L11)<br>[○ Expected result](./s07-grounding-p2.json#L33)<br>[○ Knowledge base](./s07-grounding-p2.json#L55)<br>[○ Retrieval result](./s07-grounding-p2.json#L81)<br>[○ Session memory](./s07-grounding-p2.json#L105) | - Workflows & Process Integration (orchestrator, tool)<br>- Observability & Traceability (telemetry, trace)<br>- ARWG gap inventory |

## §8 — Failure vocabulary

With subjects, properties, dimensions, governance, and grounding in place, this section names **what failed** (symptoms users and operators observe) and **why** (root causes for remediation). Symptom labels without cause classes produce blame without fix paths — re-prompts, abandonment, silent wrong actions, planning errors, coordination breakdowns, authorization violations, recovery failures. D1 will need separate subsections for **symptoms** (often user-research and ops led) versus **root causes** (often platform and MAS led), plus shared parent terms so metrics in §9 can attach `{term} rate` pairs.

**P0** establishes hierarchy parents: Symptom, Root cause, Hallucination, and the infrastructure, reasoning, and recovery failure classes. **P1** adds observable refinements and operational subclasses; each **P1** leaf should eventually pair with a `{term} rate` metric. Sign off **P0** parents before **P1** leaves and before the metrics section.

| Priority | Category | Terms | Other working groups |
|----------|----------|-------|----------------------|
| **P0** (6)<br>`s08-failure-p0.json` | Root causes (4) | [○ Infrastructure failure](./s08-failure-p0.json#L37)<br>[○ Reasoning failure](./s08-failure-p0.json#L63)<br>[○ Recovery failure](./s08-failure-p0.json#L89)<br>[○ Root cause](./s08-failure-p0.json#L113) | - Security & Privacy (authorization, policy)<br>- Workflows & Process Integration (coordination)<br>- ARWG attribution target |
|  | Symptoms (2) | [△ Hallucination](./s08-failure-p0.json#L141)<br>[○ Symptom](./s08-failure-p0.json#L169) | - ARWG primary (user-visible and operator-visible failure labels) |
| **P1** (17)<br>`s08-failure-p1.json` | Measurement & evaluation (1) | [○ Failure attribution](./s08-failure-p1.json#L11) | - ARWG primary<br>- Observability & Traceability (trace requirements for attribution) |
|  | Root causes (7) | [○ Authorization failure](./s08-failure-p1.json#L36)<br>[○ Configuration error](./s08-failure-p1.json#L61)<br>[○ Coordination failure](./s08-failure-p1.json#L83)<br>[○ Goal misalignment](./s08-failure-p1.json#L106)<br>[○ Message delivery failure](./s08-failure-p1.json#L131)<br>[○ Planning error](./s08-failure-p1.json#L155)<br>[○ Tool availability failure](./s08-failure-p1.json#L176) | - Security & Privacy (authorization, policy)<br>- Workflows & Process Integration (coordination)<br>- ARWG attribution target |
|  | Symptoms (9) | [○ Entity mismatch](./s08-failure-p1.json#L197)<br>[○ Fabricated tool result](./s08-failure-p1.json#L219)<br>[○ Incorrect task outcome](./s08-failure-p1.json#L240)<br>[○ Overconfident error](./s08-failure-p1.json#L263)<br>[○ Silent wrong action](./s08-failure-p1.json#L286)<br>[○ Stale source error](./s08-failure-p1.json#L310)<br>[○ Task abandonment](./s08-failure-p1.json#L333)<br>[○ Ungrounded claim](./s08-failure-p1.json#L357)<br>[○ User re-prompt](./s08-failure-p1.json#L382) | - ARWG primary (user-visible and operator-visible failure labels) |

## §9 — Metrics & measurement

Dimensions and failure classes are **not** numbers. This section names quantifiers — task success rate, repeated-run success rate, calibration error, and `{symptom} rate` / `{root cause} rate` pairs — that attach to §4–§8 concepts through `x-measuresTerm`. Conflating a property name with its metric blocks protocol design; each §8 leaf should eventually pair with a named rate. Metric authors and benchmark curators may own different slices; all presuppose agreed parents in §4 and §8.

**P0** defines Evaluation metric as the parent of all quantifiers. **P1** lists dimension headline metrics and one-to-one rates for §8 leaves. **P2** holds cost and variance adjuncts. Review §8 **P0** before adding **P1** metric leaves.

| Priority | Category | Terms | Other working groups |
|----------|----------|-------|----------------------|
| **P0** (1)<br>`s09-metrics-p1.json` | Metrics (1) | [○ Evaluation metric](./s09-metrics-p1.json#L33) | - ARWG primary (quantifiers for properties and failure classes) |
| **P1** (24)<br>`s09-metrics-p1.json` | Measurement & evaluation (2) | [○ Evaluation envelope](./s09-metrics-p1.json#L59)<br>[○ Evaluation methodology](./s09-metrics-p1.json#L81) | - ARWG primary<br>- Observability & Traceability (trace requirements for attribution) |
|  | Metrics (22) | [○ Calibration error](./s09-metrics-p1.json#L104)<br>[○ Configuration error rate](./s09-metrics-p1.json#L129)<br>[○ Coordination failure rate](./s09-metrics-p1.json#L150)<br>[○ Entity mismatch rate](./s09-metrics-p1.json#L171)<br>[○ Fabricated tool result rate](./s09-metrics-p1.json#L192)<br>[○ Goal misalignment rate](./s09-metrics-p1.json#L213)<br>[○ Hallucination rate](./s09-metrics-p1.json#L234)<br>[○ Incorrect task outcome rate](./s09-metrics-p1.json#L258)<br>[○ Infrastructure failure rate](./s09-metrics-p1.json#L283)<br>[○ Message delivery failure rate](./s09-metrics-p1.json#L305)<br>[○ Planning error rate](./s09-metrics-p1.json#L326)<br>[○ Policy violation rate](./s09-metrics-p1.json#L347)<br>[○ Reasoning failure rate](./s09-metrics-p1.json#L368)<br>[○ Recovery failure rate](./s09-metrics-p1.json#L390)<br>[○ Repeated-run success rate](./s09-metrics-p1.json#L409)<br>[○ Silent wrong action rate](./s09-metrics-p1.json#L439)<br>[○ Stale source error rate](./s09-metrics-p1.json#L458)<br>[○ Task abandonment rate](./s09-metrics-p1.json#L479)<br>[○ Task success rate](./s09-metrics-p1.json#L500)<br>[○ Tool availability failure rate](./s09-metrics-p1.json#L528)<br>[○ Ungrounded claim rate](./s09-metrics-p1.json#L549)<br>[○ User re-prompt rate](./s09-metrics-p1.json#L570) | - ARWG primary (quantifiers for properties and failure classes) |
| **P2** (2)<br>`s09-metrics-p2.json` | Metrics (2) | [○ Resource cost variance](./s09-metrics-p2.json#L11)<br>[○ Retry budget utilisation](./s09-metrics-p2.json#L34) | - ARWG primary (quantifiers for properties and failure classes) |

## §10 — Evaluation ecosystem

Benchmarks, scenarios, traces, tools, users, operators, and infrastructure describe *how* measurement runs — distinct from agent **properties** in §3–§5. A **benchmark** is a protocol with scenarios, envelope, and methodology that can support a qualified claim; a **leaderboard** is often a ranked snapshot (for example pass@1) useful as a headline but not a substitute for a declared benchmark. Inventory and gap analysis depend on this vocabulary once evaluation subjects from §3 are understood; benchmark maintainers and harness engineers can own D1 subsections here without editing core property definitions.

**P1** covers core ecosystem nouns every inventory row needs. **P2** adds secondary participants such as evaluator and message bus. This section is less blocking for §3–§8 sign-off and can track the inventory schema as it matures.

| Priority | Category | Terms | Other working groups |
|----------|----------|-------|----------------------|
| **P1** (19)<br>`s10-ecosystem-p1.json` | Evaluation ecosystem (19) | [○ Benchmark](./s10-ecosystem-p1.json#L25)<br>[○ Context](./s10-ecosystem-p1.json#L52)<br>[○ Context assembly](./s10-ecosystem-p1.json#L77)<br>[○ Context source](./s10-ecosystem-p1.json#L102)<br>[○ Entry point](./s10-ecosystem-p1.json#L123)<br>[○ Evaluation participant](./s10-ecosystem-p1.json#L149)<br>[○ Evaluation scenario](./s10-ecosystem-p1.json#L173)<br>[○ Infrastructure](./s10-ecosystem-p1.json#L197)<br>[○ Leaderboard](./s10-ecosystem-p1.json#L227)<br>[○ Model access](./s10-ecosystem-p1.json#L257)<br>[○ Operator](./s10-ecosystem-p1.json#L281)<br>[○ Orchestrator](./s10-ecosystem-p1.json#L306)<br>[○ Runtime platform](./s10-ecosystem-p1.json#L329)<br>[○ Telemetry](./s10-ecosystem-p1.json#L356)<br>[○ Telemetry path](./s10-ecosystem-p1.json#L382)<br>[○ Tool](./s10-ecosystem-p1.json#L410)<br>[○ Tool access](./s10-ecosystem-p1.json#L435)<br>[○ Trace](./s10-ecosystem-p1.json#L459)<br>[○ User](./s10-ecosystem-p1.json#L484) | - Workflows & Process Integration (orchestrator, tool)<br>- Observability & Traceability (telemetry, trace)<br>- ARWG gap inventory |
| **P2** (2)<br>`s10-ecosystem-p2.json` | Evaluation ecosystem (2) | [○ Evaluator](./s10-ecosystem-p2.json#L11)<br>[○ Message bus](./s10-ecosystem-p2.json#L34) | - Workflows & Process Integration (orchestrator, tool)<br>- Observability & Traceability (telemetry, trace)<br>- ARWG gap inventory |

## §11 — Response — design & correction

Production reliability depends on **preventing** failures (verification loops, proactive grounding, delegation control) and **recovering** when they occur (retry, human-in-the-loop, rollback, escalation, circuit breaker, fallback). This slice closes the loop from (§8) symptoms and root causes to remediation.

**P0** — self-correction only (stored in `s11-response-p1.json`). **P1** — reliability by design patterns and primary correction mechanisms (retry, escalation, HITL). **P2** — operational controls (circuit breaker, rollback, fallback, policy gates, version pinning).

| Priority | Category | Terms | Other working groups |
|----------|----------|-------|----------------------|
| **P0** (1)<br>`s11-response-p1.json` | Correction mechanisms (1) | [○ Self-correction](./s11-response-p1.json#L33) | - Workflows & Process Integration (HITL)<br>- Security & Privacy (policy gates)<br>- ARWG charter scope |
| **P1** (7)<br>`s11-response-p1.json` | Correction mechanisms (4) | [○ Correction mechanism](./s11-response-p1.json#L59)<br>[○ Escalation](./s11-response-p1.json#L87)<br>[○ Human in the loop](./s11-response-p1.json#L110)<br>[○ Retry](./s11-response-p1.json#L139) | - Workflows & Process Integration (HITL)<br>- Security & Privacy (policy gates)<br>- ARWG charter scope |
|  | Reliability by design (3) | [○ Proactive grounding](./s11-response-p1.json#L160)<br>[○ Reliability by design](./s11-response-p1.json#L181)<br>[○ Verification loop](./s11-response-p1.json#L206) | - ARWG primary (design-time reliability patterns) |
| **P2** (9)<br>`s11-response-p2.json` | Correction mechanisms (5) | [○ Abstention](./s11-response-p2.json#L11)<br>[○ Circuit breaker](./s11-response-p2.json#L35)<br>[○ Compensation](./s11-response-p2.json#L58)<br>[○ Fallback](./s11-response-p2.json#L82)<br>[○ Rollback](./s11-response-p2.json#L103) | - Workflows & Process Integration (HITL)<br>- Security & Privacy (policy gates)<br>- ARWG charter scope |
|  | Reliability by design (4) | [○ Delegation control](./s11-response-p2.json#L127)<br>[○ Policy gate](./s11-response-p2.json#L149)<br>[○ Specification validation](./s11-response-p2.json#L172)<br>[○ Version pinning](./s11-response-p2.json#L194) | - ARWG primary (design-time reliability patterns) |

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
| Trustworthiness | (§4) | [† Trustworthiness](./s04-core-p0.json#L237) · `s04-core-p0.json` |
| Response quality | (§4) | [Response quality](./s04-core-p0.json#L322) · `s04-core-p0.json` |
| Functional correctness | (§4) | [Functional correctness](./s04-core-p0.json#L270) · `s04-core-p0.json` |
| Task completion | (§4) | [Task completion](./s04-core-p0.json#L377) · `s04-core-p0.json` |
| Consistency | (§5) | [Consistency](./s05-reliability-dimensions-p0.json#L54) · `s05-reliability-dimensions-p0.json` (+ [Outcome](./s05-reliability-dimensions-p0.json#L160) / [Trajectory](./s05-reliability-dimensions-p0.json#L267) / [Resource](./s05-reliability-dimensions-p0.json#L188) consistency) |
| Robustness | (§5) | [Robustness](./s05-reliability-dimensions-p0.json#L212) · `s05-reliability-dimensions-p0.json` (+ [Input paraphrase robustness](./s05-reliability-dimensions-p0.json#L108)) |
| Recoverability | (§6) | [Recoverability](./s06-governance-p0.json#L37) · `s06-governance-p0.json` |
| Explainability | (§6) | [Explainability](./s06-governance-p0.json#L130) · `s06-governance-p0.json` |
| Deterministic | (§6) | [Deterministic operation](./s06-governance-p0.json#L61), [Deterministic validation](./s06-governance-p0.json#L87) · `s06-governance-p0.json` |
| Agent identity | (§6) | [Agent identity](./s06-governance-p0.json#L108) · `s06-governance-p0.json` |
| Hallucinations | (§8) | [△ Hallucination](./s08-failure-p0.json#L141) · `s08-failure-p0.json` (+ subtypes in `s08-failure-p1.json`) |

Also included from related source discussion: [Annotated correctness](./s04-core-p0.json#L92) vs [Contextual correctness](./s04-core-p0.json#L122); [Calibration](./s05-reliability-dimensions-p0.json#L27).
