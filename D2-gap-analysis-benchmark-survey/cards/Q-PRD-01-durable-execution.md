# Q-PRD-01 · How do I keep a long-running agent run going when the process running it crashes, restarts or is moved?

**Stage:** Production · **Status:** partly · **Use cases:** long-running incident, approval and remediation workflows · **Patterns (§4):** Long-Running Recoverable Workflow · **Requirements (§5):** state continuity; concurrency and retry safety; safe retry, resume, rollback or compensation
**Dimensions (§7):** Recoverability, operational fault robustness, repeated-run success rate · **Pairs with:** Q-PRD-02 (side-effect safety) · **Author:** Jordan Augé

## Challenge
An agent run can last minutes or days. Meanwhile the process running it (the worker) can be interrupted: a crash, a lost machine, a deployment, a scale-down, a timeout. Example: an agent is issuing a refund when its worker dies.

Durable execution records the run's progress as it goes, so a new worker resumes where the old one stopped instead of starting over or repeating work. The software doing this is an engine.

**Why this is about accuracy and reliability.** A run that restarts from zero may take a different path. A run that repeats a step may charge twice. A run that is silently lost never reports failure. In each case the final answer can look fine while the outcome is wrong, so recovery is a reliability property (can the system get back to a correct state?) and a correctness one (is the outcome still right?).

Agents make this harder than ordinary workflows. A model call is non-deterministic: when an engine replays a step (re-runs it to rebuild where the run was), the answer may change. And a tool call in flight at the crash may or may not have taken effect: the refund may already be done. Its outcome is unknown.

Kubernetes is the main example of a platform that interrupts workers: pod loss, rolling updates, scale-in, eviction. It restarts lost pods but manages pods, not runs: nothing on it saves or restores run state [16][17]. An engine must.

## Landscape
Everything below is taken from the cited documentation, read on 2026-11-12. Where we infer something, it says so.

**In the AAIF landscape** (landscape file of 10 Nov 2026 [24]; the label is the one used there):
- **Google ADK** (member): not an engine itself; the ADK integrations page lists a Dapr integration [27] and Temporal documents an ADK integration [26].
- **Diagrid Dapr Runtimes** (member): a runtime that includes a workflow engine (durable timers, external events, at-least-once activities) [6].
- **LangGraph** (external): checkpointers save graph state so a thread can resume from its last checkpoint [10].
- **MCP** (member): the protocol through which agents call tools. It matters here because a tool call is the step whose outcome can be unknown; see Q-PRD-02.
- **OpenTelemetry GenAI SIG** (external), **Datadog AI Observability** (member), **Arize AI** (external): relevant to monitoring (see below).
- **Microsoft AutoGen** (member), **CrewAI**, **LangChain**, **LlamaIndex** (external): agent frameworks and orchestration runtimes. Their behaviour on interruption has not been examined yet.
- **Agent evaluation harnesses** (Promptfoo, Braintrust, LangSmith Evaluation): none is known to inject worker interruptions; not checked in detail.

**Outside the AAIF landscape:**
- **Engines:** Temporal, Restate, Dapr Workflow, DBOS Transact and Argo Workflows record progress and resume it, by replaying history or from a journal of completed steps [1][4][6][7][8]. Dapr and Argo are CNCF graduated projects; Temporal, Restate and DBOS are vendor projects [23].
- **Agent frameworks that bring their own persistence or sit on an engine:** Dapr Agents (runs model calls as workflow activities [15]), Pydantic AI (supports several engines [14]), kagent [12][13].
- **Platform** (where workers run): Kubernetes gives a worker a warning period before it stops and limits how many pods are taken down at once; autoscalers (KEDA) and batch admission (Kueue) add scaling and preemption [16][17][19]. None of them knows about runs.
- **Standards and guidance:** the CNCF cloud native agentic standards post and Certified Kubernetes AI Conformance mention agentic workloads; we found no requirement on checkpointing, resume or graceful termination in them [25][28].
- **Evaluation:** no public benchmark found for run survival. Fault injection tools can create the failures: Chaos Mesh, Litmus, Toxiproxy [20][21][22].

## Today
Teams pick one engine and put each model and tool call in a retryable unit (a step the engine can re-run). Engines are alternatives, and stacking them multiplies retries, so the documented pattern is one framework on one engine [14]. Human approvals and long waits are well covered (external events, signals, timers) [1][6]. Side-effect safety is left to the application, usually through idempotency keys (a unique ID sent with a request, so the receiver can ignore a repeat).

## Comparison
Engines differ in what they record and how they resume. Temporal and Dapr replay deterministic code against a recorded history [6]. Restate journals steps [4]. DBOS checkpoints steps in Postgres [7]. Argo re-runs a whole step [8]. Temporal, Dapr and DBOS state that a step may run more than once [1][6][7]: if the worker dies mid-step, the step runs again, so an idempotency key is what prevents a second refund. LangGraph resumes a node (one step of its graph) from its beginning, re-running its model and API calls [10]. kagent restores the last snapshot but does not retry the interrupted turn: that is snapshot-and-revert, not durable execution [12]. Engines and frameworks are alternatives at each layer, not a stack.

## How to monitor it
D2 says which signals must be observable; how they are emitted belongs to the Observability WG. For recovery, the questions and the signals that answer them are:

| Question | Signal to observe | Where it can come from |
|---|---|---|
| Did the run survive the interruption? | Run outcome (completed, failed, stuck) for runs in flight at the time | Engine run status; the application |
| How long did recovery take? | Time from interruption to resumed progress (time to safe state) | Engine events joined with platform events (pod and node events on Kubernetes [16]) |
| Did it resume in the right place? | Resumed step versus last completed step; checkpoint timestamps | Engine history or journal |
| Was the outcome repeated or lost? | Count of repeated side effects, compared with the system of record | The application's ledger or database, not the agent's own report |
| Was it one interruption or many? | Attempt count and retry source (engine, framework or platform) | Engine and framework logs and traces |

Sources of signal available today are engine-specific, and which of these each engine and the OpenTelemetry GenAI conventions expose has not been checked. This is one of the gaps below.

## Gaps
| Gap | Type (§8) | Layer |
|---|---|---|
| No comprehensive, vendor-agnostic overview: guarantees, limits and behaviour on platforms such as Kubernetes are documented per product, and we found no neutral comparison (the landscape above was assembled from each product's own documentation) | Coverage | Practice |
| No standard interface: resume, retry and history semantics, and the way a run's state is recorded, differ per engine and framework, so runs and tooling are not portable between them | Standardization | Interop |
| Engines and frameworks re-run the step that was in flight at the crash [1][6][7][10], and do not track whether a model or tool call had already taken effect, so external effects are left to idempotency keys set by the application (see Q-PRD-02) | Coverage | Infrastructure |
| Overlap with platform and scaling: shutdown timeouts disagree across layers (on Kubernetes: pod, engine, sidecar); eviction, OOM (out-of-memory) kills and preemption bypass graceful termination [18]; autoscalers cannot choose which replica to remove and may ignore in-flight work [19]; engine, framework and platform retries compound [6] | Continuity / Depth | Infrastructure |
| Run survival, time to safe state and checkpoint completeness have no standard names, little tool-native measurement and no conformance scenario | Observability / Standardization | Evaluation |

Also open, not detailed here: versioning covers code shape but not a changed model, prompt or tool schema under in-flight runs [5].

## Next
- **D3:** a reference pattern: align the platform's shutdown grace period (on Kubernetes, the pod's) with engine shutdown, and give each run one owner. Longer term, a common vocabulary and interface for durable execution of agents.
- **D4:** names and definitions for run survival (share of in-flight runs that complete correctly after an interruption), time to safe state, and checkpoint completeness.
- **D5:** recovery rules for interrupted runs.
- **External:** bridge to the CNCF AI conformance work, which today says nothing on resume; input to the Observability WG on the signals above.

## Requirements and checks
- **REQ-A:** an in-flight run completes correctly after a crash, machine loss, deployment, scale-in or timeout (on Kubernetes: pod loss, node drain, scale-in or rolling update).
- **REQ-B:** after resume, no completed step is repeated and no side effect is duplicated.
- **TEST-A:** kill a worker with no grace period during a step of a 20-step reference run; assert resume at or after the last durable step and zero duplicate effects.
- **TEST-B** (Kubernetes case): delete a worker with a grace period and drain its node; assert the signal is handled and the run completes.
- **TEST-C:** roll out a new worker version mid-run; assert the run finishes or resumes without non-determinism errors.
- **TEST-D:** trigger scale-in and preemption while runs are in flight; assert none is cut off or restarted from the beginning.
- **TEST-E** (with Q-PRD-02): partition a worker from the engine, then heal; assert exactly one completion per step.

None of these checks has been run yet.

## Sources
Product pages were read on 2026-11-12. Statements about what a product does not do come from its documentation and are hypotheses until a second reviewer confirms them.

1. Temporal, [Activities](https://docs.temporal.io/activity-definition) (also [retry policies](https://docs.temporal.io/encyclopedia/retry-policies))
2. Temporal, [retry policies](https://docs.temporal.io/encyclopedia/retry-policies)
3. Temporal, [limits](https://docs.temporal.io/cloud/limits)
4. Restate, [key concepts](https://docs.restate.dev/foundations/key-concepts)
5. Restate, [versioning](https://docs.restate.dev/operate/versioning)
6. Dapr, [workflow features and concepts](https://docs.dapr.io/developing-applications/building-blocks/workflow/workflow-features-concepts/)
7. DBOS, [architecture](https://docs.dbos.dev/architecture)
8. Argo Workflows, [retries](https://argo-workflows.readthedocs.io/en/latest/retries/)
9. Argo Workflows, [scaling](https://argo-workflows.readthedocs.io/en/latest/scaling/)
10. LangGraph, [checkpointers](https://docs.langchain.com/oss/python/langgraph/checkpointers)
11. LangSmith, [Agent Server](https://docs.langchain.com/langsmith/agent-server)
12. kagent, [runtime and lifecycle](https://github.com/kagent-dev/kagent/blob/main/docs/architecture/runtime-and-lifecycle.md)
13. kagent, [persistence and checkpoints](https://github.com/kagent-dev/kagent/blob/main/docs/architecture/persistence-checkpoints-and-forks.md)
14. Pydantic AI, [durable execution overview](https://pydantic.dev/docs/ai/integrations/durable_execution/overview/)
15. Dapr Agents, [durable agent source](https://github.com/dapr/dapr-agents/blob/main/dapr_agents/agents/durable.py)
16. Kubernetes, [pod lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)
17. Kubernetes, [disruptions](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/)
18. Kubernetes, [node-pressure eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/)
19. KEDA, [scaling deployments](https://keda.sh/docs/2.21/concepts/scaling-deployments/)
20. Chaos Mesh, [pod chaos](https://chaos-mesh.org/docs/simulate-pod-chaos-on-kubernetes/)
21. Litmus, [Kubernetes faults](https://github.com/litmuschaos/chaos-charts/tree/master/faults/kubernetes)
22. [Toxiproxy](https://github.com/Shopify/toxiproxy)
23. CNCF landscape data, [full.json](https://landscape.cncf.io/data/full.json) (project maturity)
24. AAIF, [ws-taxonomy-landscape](https://github.com/aaif/ws-taxonomy-landscape), `landscape/landscape.yml`, as of 10 Nov 2026
25. CNCF, [Cloud native agentic standards](https://www.cncf.io/blog/2026/03/23/cloud-native-agentic-standards/)
26. Temporal, [Google ADK integration](https://docs.temporal.io/develop/python/integrations/google-adk)
27. ADK, [Dapr integration](https://adk.dev/integrations/dapr/)
28. [Certified Kubernetes AI Conformance](https://github.com/cncf/k8s-ai-conformance)
