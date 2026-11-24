# D1 — Terminology & Taxonomy

**Working Group**: AAIF Accuracy & Reliability Working Group (ARWG)  
**Type**: Informational → Living Document  
**Depends on**: nothing — root dependency  
**Status**: v1.0.0-rc

---

## What this deliverable is

A canonical, versioned **taxonomy only** — vocabulary, boundaries, and layered
structure for accuracy and reliability in agentic systems. Organised in
the published chapter set (§0-§11).

D1 does **not** include benchmark inventories, coverage matrices, or gap analysis.

D1 focuses on structural and definitional content. Narrative positioning,
deployment thresholds, and implementation playbooks are outside scope.

---

## Document structure

| File | Section | Role |
|------|---------|------|
| [00-taxonomy-architecture.md](00-taxonomy-architecture.md) | §0 | Master skeleton — system under study, layers |
| [01-purpose-and-scope.md](01-purpose-and-scope.md) | §1 | Purpose, scope, out-of-scope (no benchmarks) |
| [02-design-principles.md](02-design-principles.md) | §2 | Admission criteria, layered categories |
| [04-system-boundaries.md](04-system-boundaries.md) | §3 | Agent, MAS, workflow, rings, tools, envelope |
| [03-core-concepts.md](03-core-concepts.md) | §4 | Accuracy, reliability, failure classes |
| [05-reliability-dimensions.md](05-reliability-dimensions.md) | §5 | Consistency, robustness, predictability, safety |
| [06-operational-governance.md](06-operational-governance.md) | §6 | Identity, traceability, recoverability |
| [07-grounding-evidence-terms.md](07-grounding-evidence-terms.md) | §7 | Grounding, trust anchors, evidence |
| [08-failure-vocabulary.md](08-failure-vocabulary.md) | §8 | Symptoms, root causes, runtime bridge (§8.6) |
| [09-metrics-measurement.md](09-metrics-measurement.md) | §9 | Metrics — layer 3; scope-dependent quantifiers |
| [10-evaluation-ecosystem.md](10-evaluation-ecosystem.md) | §10 | Benchmarks, scenarios, harness vocabulary — layer 6 |
| [11-response-correction.md](11-response-correction.md) | §11 | Reliability by design; correction mechanisms — layer 5 |

Chapters 12 and beyond (conflict resolution, glossary, open issues, change
log, and cross-links to problem statements and use cases) are working
material not yet part of the published build, and are intentionally left out
of this table until they're ready to publish.
