[Back to D1 index](../index.html) | [ToC](../toc.html) | [Single page](../d1-single-page.html)

# Metrics and Measurement

This chapter binds the properties and failure classes defined in §4–§8 to
explicit quantifiers under a declared evaluation envelope, so that metric
claims do not replace or redefine the underlying concepts.

## 9.1 Metrics as quantifiers

Metrics are how dimensions are quantified. They are not dimensions in their
own right; they are numbers or rates attached to the properties and failure
classes defined earlier in this vocabulary. Each metric that quantifies a
symptom or root cause must declare which term it measures, so that a metric
is never used as if it were a substitute for the underlying concept.

---

## 9.2 Metrics change when scope expands

The same dimension name can require different metrics depending on which
ring is in scope, and expanding scope also adds metrics that do not apply at
inner scopes. Outcome accuracy, for example, is measured at agent scope as
task success rate or pass@1; adding the MAS ring brings in joint outcome and
milestone pass; adding the workflow ring brings in end-to-end process
outcome; adding the infra ring brings in realised accuracy under platform
faults; and adding the user ring brings in contextual correctness and task
completion. Action accuracy is measured at agent scope as tool-sequence
match or process rubric, with the MAS ring adding the harder problem of
per-agent action attribution and the workflow ring adding step and non-LLM
stage correctness.

Outcome consistency is measured at agent scope as pass^k, with a MAS-scope
roster pass^k rare in the literature and a workflow-scope pipeline pass^k
still a gap in current practice. Resource consistency is measured at agent
scope as the token or latency coefficient of variation per run, with the MAS
ring adding aggregate team cost variance, the workflow ring adding full
pipeline cost, and the infra ring adding P99 latency and retry cost. Fault
robustness is measured at agent scope as tool-timeout recovery, with the MAS
ring adding message loss between agents, the workflow ring adding database
and API failures in orchestration glue, and the infra ring adding
platform-SLO breach impact.

Grounding and evidence metrics run from citation faithfulness at agent
scope, through cross-agent fact alignment at MAS scope and audit trail to
system of record at workflow scope, to stale-index detection at infra scope
and user-specific context fit at user scope. User-facing metrics appear only
once the workflow and user rings are in scope, covering approval-gate
outcomes, re-prompt rate, abandonment, and human-in-the-loop rate.

New metrics of this kind appear whenever the evaluation subject moves
outward, from agent to workflow; whenever a new ring is included, such as
user symptoms or infra resource caps; or whenever a dimension sub-type is
split, such as trajectory versus outcome consistency.

The reporting rule that follows from this is that a metric claim should
always state the dimension, the metric itself, the evaluation subject, and
the scope rings included. "Outcome consistency, pass^8, Agent, harness-only
(no production infra envelope)" and "Outcome accuracy, process completion,
Workflow, includes payment API and human approval step" are both complete in
this sense, because a reader can tell exactly what was and was not measured
without needing to ask.

---

## 9.3 Related work and admission

Metric names from benchmarks and papers are mapped in the taxonomy review
artifacts; the admission criteria for a metric to enter this vocabulary are
the same ones set out in §2.

---

## 9.4 Minimum dashboard contract (actionable now)

To make accuracy and reliability claims operational from day one, each
dashboard panel should publish a minimum set of reporting fields: evaluation
subject, deployment profile, scope rings, dimension, metric, evaluation
envelope, agent identity/version, and trust-anchor class. This does not
prescribe any particular vendor tooling; it defines the semantic contract
that allows cross-team comparison.

Three deployment profiles should be declared at minimum. An autonomous
profile is one where the agent or MAS can execute state-changing actions
without synchronous user confirmation. A copilot profile is one where a user
approval gate exists before high-impact action commit. A CI/CD automation
profile is one where the agent acts in software delivery workflows and
rollback and blast-radius controls are mandatory.

Alongside the profile, a minimal set of boundary and security qualifiers
should be declared: user exposure, distinguishing internal operator only,
employee-facing, and external user-facing; runtime location, distinguishing
controlled private environment, managed cloud, and mixed environment; action
authority, distinguishing read-only, constrained write, and privileged
write; and trust-anchor mode, distinguishing an authoritative system of
record that is declared from one that is not.

A minimum metric stack follows for each profile, as an initial
recommendation rather than a fixed standard. For an autonomous profile, this
means outcome consistency (pass^k), safety violation rate, fault robustness,
and recoverability-related correction success rate. For a copilot profile,
this means task accuracy, calibration quality, user override rate, re-prompt
rate, and escalation-to-human rate. For a CI/CD automation profile, this
means process accuracy, rollback invocation rate, false-positive
intervention rate, and change-failure-related correction latency. These
profile stacks are a starting point for interoperable dashboard language;
thresholds and conformance bars are left to later ARWG deliverables.

This minimum contract is designed to solve immediate operational pain
points: incomparable dashboard claims across teams, hidden boundary changes
between deployments, and release decisions made from headline scores without
a declared evaluation envelope.

## 9.5 What affects performance and how it manifests

Once boundaries and failure surfaces are declared, performance must be
characterised along both non-failure and failure-aware axes. The non-failure
axes are baseline accuracy, latency, cost, and resource variance under the
declared envelope. The failure-aware axes are failure incidence rate by
class, blast-radius indicators, time-to-detect, time-to-contain, and
correction success rate.

These manifest differently depending on which surface is involved.
External-surface manifestations include intermittent timeouts, stale
evidence retrieval, dependency-induced degradation, and policy-service
mismatch. Internal-surface manifestations include unstable reasoning
trajectory, tool-sequence drift, unsupported claims, and unsafe action
attempts.

Two interpretation rules follow from this combined view. Good average
performance does not imply low operational risk if failure incidence or
containment metrics are poor, and high failure incidence can be tolerable in
some profiles only when containment and safe-degradation metrics remain
within their declared bounds.
