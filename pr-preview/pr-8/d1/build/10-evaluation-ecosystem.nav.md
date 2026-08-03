[Back to D1 index](../index.html) | [ToC](../toc.html) | [Single page](../d1-single-page.html)

# Evaluation Ecosystem

This chapter defines the ecosystem nouns needed to describe how evaluation
runs — benchmark, scenario, trace, harness, and participants — while keeping
those terms separate from agent quality properties. Organisations often
compare systems by leaderboard position while silently changing scenario
design, subject boundaries, or evaluation envelope: a "rank #1" result on a
benchmark with model-only scope cannot be treated as evidence of workflow
reliability in production unless the workflow envelope is also declared and
measured.

## Benchmarks, leaderboards, and harness vocabulary

A benchmark is one way to measure the system under study; it is not a
property of the agent itself. A complete evaluation programme must declare
the evaluation subject, the scope rings, the dimensions, and the envelope —
agent specification, governance, infra assumptions — and not only a headline
score.

A benchmark, in the strict sense, is a documented evaluation package with
scenarios, datasets, scoring rules, statistical coverage, and reporting
conventions. A leaderboard is a ranked comparison surface, often built from
one good attempt — pass@1 or best-of-k, for example — on benchmark items, and
is not equivalent to a full benchmark protocol or a deployment guarantee. An
evaluation scenario is one test condition: a task instance, a perturbation,
and an envelope together. A dataset is the set of items that stand in for
user tasks or world state, and its coverage — which task types, domains,
failure modes, and envelope parameters it exercises — determines whether
gaps in results are benchmark gaps or agent gaps. Ground truth, or expected
result, is the declared correctness criterion for an item, and statistical
coverage is whether the sample size and diversity actually support the claim
being made.

The distinction between a leaderboard and a benchmark matters because
industry often publishes leaderboard rank from a single successful run or a
best-of-k trial, while reliability dimensions — pass^k, trajectory
consistency, resource consistency — and outer-ring claims — workflow
outcome, user symptoms, infra envelope — require a benchmark with a declared
protocol, not a leaderboard row alone. Scores that cannot be tied to
identity, policy context, or a frozen specification carry limited
attribution value.

This separation is treated as settled here: benchmark, scenario, trace, and
evaluator are ecosystem nouns describing how evaluation runs, while
accuracy, reliability, dimensions, and failure classes are property nouns
describing what is claimed. Benchmarks usually mimic users and world state
with fixed datasets, and rarely include full production infra, real user
behaviour, or live trust anchors; gap analysis asks which system-boundary
stages a given benchmark actually exercises.

Mapping enterprise requirements to benchmark coverage — including dimension
by object matrices and populated inventories — is left to later work.
Even so, this chapter establishes the framing needed to build an accuracy
and reliability landscape map: coverage of failure-mode spans, coverage of
non-failure performance characterization, and placement of controls across
design-time, runtime, and external governance layers.
