# 3. Analysis Scope and Evaluation Subjects

> Status: outline (carried over from the running notes)

- Covers a small set of key subjects (starting with durable execution and side-effect safety) contributed by WG members, selected and analysed as described in [§0 Methodology](00-methodology.md). New subjects are added over time.
- Analyzes benchmark and evaluation method coverage for enterprise agentic systems.
- Adopts D1 terminology for evaluation subjects: model/component, agent, multi-agent system, and workflow for a given evaluation context/envelope. Does not redefine D1 taxonomy, evaluate model internals, or prescribe vendor-specific tooling.

## Focus

The landscape of agent frameworks, harnesses, protocols, runtimes and tooling is too broad to survey end to end. D2 addresses a few elements of it, chosen because they decide whether an agentic system keeps working under real conditions, and because the charter's later deliverables (D3 design guidance, D4 quality standard, D5 corrective actions) need evidence on them:

- **Resilience by design.** Properties built in before failure happens: durable execution, idempotent side effects, state recovery, retries and timeouts. Starting subjects: durable execution (Q-PRD-01) and side-effect safety (Q-PRD-02).
- **Resilience after the fact.** Detecting and recovering from failures during operations, using telemetry: failure detection, escalation, rollback or compensation, and turning incidents into tests.
- **Monitoring.** What must be observed to support both of the above. Consistent with the charter, D2 looks at which signals and outcomes need to be observable, not how traces and logs are emitted (Observability WG).

Monitoring differs by aspect, so each subject states what is monitored and how:

| Aspect | Example signals | Typical source |
|---|---|---|
| Task outcome | Result correct against a trust anchor, task completed | Online evaluation, sampled checks |
| Agent behaviour | Tool calls, retries, loops, trajectory deviations | Traces |
| State and side effects | Duplicate or partial effects, unrecovered state | Application and system-of-record checks |
| System health | Latency, errors, cost, resource pressure | Metrics |
| Drift and degradation | Quality change across versions or over time | Repeated evaluation, trend analysis |
| User experience | Re-prompts, overrides, abandoned tasks | Product telemetry, feedback |

Other elements are in scope only when a member contributes a subject that meets the criteria in [§0](00-methodology.md).

## Template

- Use-case pattern and task
- Evaluation subject
- Agent/model/configuration version
- Tools and evidence sources
- Runtime and policy conditions
- Human involvement
- Lifecycle stage
- Cost and latency constraints, where relevant
