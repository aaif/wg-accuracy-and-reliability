# 0. Methodology

> Status: proposal (for discussion)

D2 is a living document. It does not try to survey everything at once. It covers a small number of key subjects, each answered in the same way, and grows as members contribute more subjects.

## Subjects

A subject is a question an enterprise practitioner has to answer to run agentic systems reliably, for example "How do I keep a long-running agent task alive across pod loss and rolling updates?" Each subject is written up as one [question card](cards/TEMPLATE.md).

A subject belongs in D2 when it:

- threatens the outcome of an enterprise use-case pattern (§4) or a requirement (§5);
- is about evaluating, detecting, verifying or recovering from failures of accuracy or reliability;
- stays within the charter scope: not model training, not vendor selection, not building a platform.

The first iteration starts with durable execution (Q-PRD-01) and side-effect safety (Q-PRD-02). Further subjects are contributed by WG members (see Contributing in the README).

## Lifecycle

Every subject is placed on the lifecycle of an agentic system, so that evidence can be followed from one stage to the next:

| Stage | Question it answers |
|---|---|
| Research and selection | Is this model, framework or approach fit for the task? |
| Development and integration | Is it built and wired so that it can be reliable? |
| Pre-production validation | Does it hold up under test, perturbation and failure? |
| Deployment and operations | Can we see and verify that it works in production? |
| Recovery and improvement | Can it recover, and do incidents become tests? |

[§6](06-evaluation-across-the-lifecycle.md) gives the detail for each stage. A recurring gap is that evidence does not carry from one stage to the next.

## Method for each subject

1. **Ask.** State the question, the use-case pattern and the requirement behind it, and the lifecycle stage (above).
2. **Map.** Assemble what exists today, open source first: frameworks and harnesses, protocols, runtimes and orchestrators, evaluation and observability tooling, standards, practices, and benchmarks and leaderboards where they exist. Benchmarks are one input among these.
3. **Name the gaps.** Compare the landscape against the requirement and record each gap using the categories in §8, with the layer it sits in.
4. **Hands on.** Where feasible, check a key claim with a small experiment or test rather than documentation alone, and record the result, or why it was not possible.

## Evidence rules

- Every statement about what exists links to a source (documentation, specification, repository, paper) and notes the version or date consulted.
- A statement that nothing exists says how and when it was searched, and is worded as "none found", not "none".
- Experiments state the setup, the version tested and the number of runs; small runs are labelled illustrative.
- Terms come from D1; unclear terms are fed back to D1.

## Keeping it alive

- One subject or one card per pull request, with a named owner.
- Cards carry a status (draft, reviewed) and the date of their last landscape check.
- §7 and §8 are syntheses across cards. They are updated as cards are added or refreshed, not written separately.
- The WG reviews the card list periodically to add subjects, retire stale ones and refresh landscape entries.
