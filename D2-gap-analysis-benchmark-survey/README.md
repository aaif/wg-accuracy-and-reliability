# D2 — Gap Analysis and Benchmark Survey

> **Status: draft scaffold.** This folder starts D2 in GitHub so the WG can review it line by line. The section text is carried over from the D2 outline in the WG running notes (section "High level narrative"); it is lightly edited for Markdown, and the consumer/producer trust discussion in §4 is slightly condensed. Check it against the notes. The question-card format follows the 10 Nov 2026 WG slides.

**Charter:** "Survey of existing benchmarks, leaderboards, and state of the art, identifying which accuracy and reliability dimensions are underserved. Directly informs D4."
**Participants (charter):** Brian Malone, Sanjeev Suresh · **First iteration:** before 20 Dec 2026

## Narrative

Use-case patterns → Requirements across the lifecycle → Benchmark coverage → Gaps → Actions

## Sections

| # | File | Status |
|---|---|---|
| 1 | [Executive Summary](01-executive-summary.md) | outline |
| 2 | [Purpose and Audience](02-purpose-and-audience.md) | outline |
| 3 | [Analysis Scope and Evaluation Subjects](03-analysis-scope-and-evaluation-subjects.md) | outline |
| 4 | [Enterprise Use Cases → Patterns](04-enterprise-use-case-patterns.md) | outline |
| 5 | [Enterprise Requirements](05-enterprise-requirements.md) | outline |
| 6 | [Evaluation Across the Lifecycle](06-evaluation-across-the-lifecycle.md) | outline |
| 7 | [Benchmark Coverage](07-benchmark-coverage.md) | outline |
| 8 | [Key Gaps for Enterprise Deployment](08-key-gaps.md) | outline |
| 9 | [Recommendations and Next Steps](09-recommendations-and-next-steps.md) | outline |
| 10 | [Appendices](10-appendices.md) | outline |

## Question cards (proposal)

Sections 6–8 can be answered as question cards grouped by lifecycle stage: each card links a use-case pattern and requirement to what exists today (benchmarks, standards, open source, practices), typed gaps, and the next deliverable. Template: [cards/TEMPLATE.md](cards/TEMPLATE.md).

| ID | Stage | Question | Owner | Status |
|---|---|---|---|---|
| Q-PRD-01 | Production | Durable execution (see 10 Nov slides) | Jordan Augé | to add |
| [Q-PRD-02](cards/Q-PRD-02-side-effect-safety.md) | Production | How do I make sure an agent's side effects happen exactly once when tools fail or time out? | Jay Prajapat | draft |

## Contributing

Open a PR against this folder; one section or one card per PR keeps reviews small. Terms should come from D1; feed unclear terms back to D1. Commits need a DCO sign-off (`git commit -s`).
