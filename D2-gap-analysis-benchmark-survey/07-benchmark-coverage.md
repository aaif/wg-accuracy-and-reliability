# 7. Benchmark Coverage

> Status: outline (carried over from the running notes)

Benchmarks are one lens on the landscape, not the whole of it (see [§0](00-methodology.md)). This section looks at what benchmarks and leaderboards measure and why their results are hard to use for enterprise decisions. It condenses the benchmark material from the running notes.

## Evaluation dimensions

- Map terms to D1: accuracy, reliability, robustness, recoverability, calibration, etc.
- Any unclear or contested terminology should be fed back into D1.

| Dimension | Enterprise meaning |
|---|---|
| Task accuracy | Final state matches the success criteria |
| Process accuracy | Steps and tool order are acceptable |
| Functional correctness | Right tool, valid arguments |
| Evidence accuracy | Claims are faithful to sources and tool output |
| Contextual correctness | Fit for the live user, tenant and policy |
| Repeated-run success rate | Same pass/fail over declared repeats |
| Trajectory and resource consistency | Stable action path, latency, tokens and cost across repeats |
| Operational fault robustness | Behaviour under tool, API and infrastructure faults |
| Recoverability | Retry, fallback and human handoff work without further failure |
| Calibration | Stated confidence matches the empirical error rate |
| Failure attribution | Reasoning vs infrastructure vs tool/world vs user |

Benchmarks use overlapping names ("success", "pass", "win rate"). Scores are only comparable once the evaluation envelope is declared: subject, number of repeats, injected faults and agent specification version.

## Coverage matrix

- Summarize current academic and industry benchmark coverage, then use the coverage/gap matrix as the main evidence.
- For each dimension, compare coverage across model/component, agent, multi-agent system, and workflow. Keep benchmark catalog detail in the appendix.

## Why benchmark results do not transfer

Typical public harnesses assume the happy path: an agent (or model) as subject, clean infrastructure, annotated correctness and a single-run success rate.

| Gap | Enterprise need | Benchmark habit |
|---|---|---|
| Subject | Certify a workflow or multi-agent system | Score an agent on isolated tasks |
| Runs | Repeated-run success rate | Single-run success as the default |
| Context | User, infrastructure and world evidence | User symptoms and faults left out |
| Governance | Declared envelope and failure attribution | Leaderboard without a frozen specification |

Four lenses explain why academic results are hard to use: requirement coverage (an agent score used to certify a workflow), consumability (no runnable or comparable harness), terminology ("success" without an envelope), and systematic analysis (a single run reported as operational readiness).

Scores should only be compared at the same level of the claim hierarchy: application context, scenario, test, run.

Evidence strength also varies: a declared envelope and identity first, then deterministic oracles (state checks, unit tests), then faults and repeats, then judges and rubrics. Claims at the higher tiers without the first are governance gaps.

## Examples (public, not endorsements)

- **tau-bench** (arXiv 2406.12045): agent subject, strong repeated-run signal, workflow coverage minimal, envelope often implicit.
- **WebArena** (arXiv 2307.13854): agent subject, substantial single-run outcome, weak on reliability and on the user.
- **SWE-bench Pro** (arXiv 2509.16941): agent subject, tests functional correctness, no faults and no repeat-run reporting.
