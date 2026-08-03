[Back to D1 index](../index.html) | [ToC](../toc.html) | [Single page](../d1-single-page.html)

# System Boundaries and Object of Evaluation

This chapter fixes the declared evaluation subject and boundary rules that
must precede any score interpretation, so that claims can distinguish model,
agent, MAS, and workflow outcomes without ambiguity.

## 3.1 Objects of evaluation

Accuracy and reliability claims can apply to four distinct objects, and a
claim must state which object is being evaluated — an unqualified claim is
ambiguous. A model is a single LLM or ML model component, evaluated in
isolation with fixed inputs; its boundary is the input and output of one
inference call. An agent is a model with context assembly logic, tool
integrations, memory, and a prompt chain, evaluated as a single unit; its
boundary is the agent session, including any external tool calls made for one
task. A MAS, or multi-agent system, is a networked composition of agents that
exchange messages and collaborate on tasks; its boundary is the orchestration
for one task or session, including inter-agent communication. A
workflow/pipeline is a deterministic or semi-deterministic process that
includes agents alongside non-LLM components such as databases, APIs, and
rule engines; its boundary is the end-to-end process, with accuracy judged on
final outputs.

The object must be declared before an accuracy or reliability claim is
stated. A claim that "the system has 95% accuracy" with no declared object is
uninterpretable.

---

## 3.2 Agent boundary definition

The agent boundary is the point at which external infrastructure interacts
with agent-internal state. This boundary is necessary to separate failures
that occur because the agent's context assembly or reasoning was wrong from
failures that occur because the environment did not deliver what the agent
expected. Failures at the boundary itself — for example, a tool call that was
well-formed but returned a corrupted result — are attributed to the
infrastructure layer first, not to cognition, unless infrastructure is
verified to be functioning correctly.

An agent boundary includes the model itself, the tools that contribute to
the agent's decision process as context (as opposed to tools the agent can
act through), and its dependencies on external systems such as APIs,
knowledge bases, and memories. A MAS boundary includes the agents that
constitute it, as well as any service instrumental to its operation, such as
communication and coordination systems. As a consequence, an agent carries
important requirements on the infrastructure it runs on.

---

## 3.3 Agent reliability vs infrastructure reliability

Agent reliability and infrastructure reliability are distinct properties at
different layers of the system, and conflating them produces misleading
evaluation results and incorrect attribution.

Agent reliability applies to an agent or a MAS and answers whether the
system preserves correct behaviour across its operating envelope; it is
measured through metrics such as pass^k, consistency, robustness,
predictability, and safety — each developed in full in Chapter 5. Infrastructure
reliability applies to the platform, runtime, and tools, and answers whether
they are available and delivering correct inputs; it is measured through
metrics such as uptime, error rate, latency P99, and retry success rate.

The qualifier rule that follows from this distinction is that an unqualified
"reliability" refers to agent reliability — the Princeton-style definition
covering four dimensions of output quality. When infrastructure availability
or platform uptime is meant instead, the term infrastructure reliability must
be used.

---

## 3.4 Why infrastructure failures affect agent accuracy

Infrastructure failures can cause agent accuracy to degrade even when the
agent's cognitive logic is correct, which is why establishing and excluding
infrastructure failure comes first, before a deficit is attributed to agent
reliability or cognitive quality. A typical chain runs as follows: an
infrastructure failure means the agent never receives a tool result, so it
reasons under incomplete context, its output is wrong, and that wrongness is
measured as an accuracy degradation. The correct attribution for this chain
is infrastructure failure, not cognitive failure — infrastructure health
must be established before a failure is attributed to agent reliability or
cognitive quality.

---

## 3.5 Deployment boundary declaration (minimum)

For production-relevant accuracy and reliability reporting, each claim should
also declare whether agents are directly exposed to end users, whether
execution is autonomous or approval-gated, whether the runtime is production
cloud, a controlled private environment, or mixed, and whether actions are
read-only, constrained write, or privileged write. These declarations do not
replace metrics; they define the boundary conditions under which metrics are
interpretable.

---

## 3.6 Failure surface immediately after boundary declaration

Once boundaries are declared, the next step is to classify what can fail on
the external surface versus the internal surface. The external failure
surface, outside the evaluated agent or MAS logic, covers infrastructure and
dependency faults such as API unavailability, stale indexes, message loss,
policy-service failures, and trust-anchor inconsistencies. The internal
failure surface, inside the evaluated subject, covers reasoning defects,
context assembly errors, tool misuse, delegation-chain issues, and
recovery-policy misconfiguration.

The governing rule is manifestation-first: symptoms are captured as observed
— wrong output, unsafe action, silent failure, unstable trajectory, cost
spikes — before root causes are reconstructed using the attribution order
developed later in this vocabulary. This ordering prevents two common errors:
blaming the agent for upstream dependency failures, and treating all output
defects as "model" failures.
