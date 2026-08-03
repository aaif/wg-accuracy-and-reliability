[Back to D1 index](../index.html) | [ToC](../toc.html) | [Single page](../d1-single-page.html)

# Core Concepts

This chapter establishes the core property split used throughout this
vocabulary: accuracy as single-run correctness and reliability as stability
across runs and conditions, so that downstream dimensions, failures, and
metrics remain comparable.

Teams often report high "quality" while mixing one-run correctness with
multi-condition stability, which makes release decisions inconsistent — a
system can be accurate on one run and still unreliable under repetition, and
the distinction below is what keeps that from being summarised as a single,
undifferentiated score.

## 4.0 Evaluation subjects

The concepts in this chapter apply to two classes of evaluation subject, both
introduced here with their exact boundaries fixed in Chapter 3. An agent is a
model together with its context assembly logic, tool integrations, memory,
and prompt chain, evaluated as one autonomous unit; it is the minimal
evaluation subject for accuracy and reliability claims. A MAS, or
multi-agent system, is a networked composition of agents exchanging messages
and collaborating on tasks, evaluated at the orchestration boundary; accuracy
for a MAS is judged on final outputs unless intermediate outputs are
explicitly in scope.

Any accuracy or reliability claim must declare which of these two subjects —
agent or MAS — is being evaluated. §3.1 gives the full object-of-evaluation
taxonomy, which also covers the model and the workflow/pipeline as evaluation
subjects.

---

## 4.1 Accuracy

Accuracy is the degree to which an agent or MAS produces the correct result
for a task instance under a specified evaluation setup. It is an outcome
concept: it answers whether the agent or MAS produced the correct answer on
this run.

Three properties follow from this definition. Accuracy is task-relative: it
is always measured against a task-specific expected result — a ground-truth
annotation, a deterministic final-state check, or a benchmark-specific
criterion — so there is no universal accuracy scalar. It is run-relative: it
describes what happened on a given run or task instance, not what happens
across runs, which is the concern of reliability instead. And its scope must
be declared: accuracy applies to an agent or to a MAS as a whole, and a
correct final output from a MAS that produced wrong intermediate artefacts
still counts as correct if only the final output is evaluated, provided the
scope — agent or MAS — is stated.

Accuracy does not cover run-to-run stability, uptime, provenance, or trust
judgments; those concerns belong elsewhere in this vocabulary. The benchmarks
most relevant for grounding the definition are Tau-Bench, Terminal-Bench, and
SWE-Bench.

### 4.1.1 Grounding accuracy in benchmark practice

The most principled way to operationalise accuracy is to examine how it is
defined across widely used benchmarks: Tau-Bench, Terminal-Bench, and
SWE-Bench [Yao et al., 2024; Jimenez et al., 2024; Merrill et al., 2026].
Their evaluation setups provide practical grounding for what "accuracy"
actually means in different contexts.

Tau-Bench validates accuracy deterministically: agents perform actions, and
the evaluation checks whether the final state is correct [Yao et al., 2024].
This operationalisation makes accuracy concrete and reproducible without
relying on an LLM acting as judge.

### 4.1.2 A-priori correctness and offline evaluation

For offline evaluation settings, the concept of a-priori correctness deserves
consideration. An offline evaluator does not have access to the totality of
the user's context, intent, or job-to-be-done at the time the evaluation is
run, so what is labelled "correct" in an annotation set is necessarily based
on a prior — a best estimate of what the user intended at annotation time.

The term "factually correct" should therefore be used carefully. Accuracy
here means correct with respect to the evaluation criterion specified in the
evaluation setup. Claims about real-world factual correctness require
explicit qualification, distinguishing a-priori correct (correct given the
pre-specified annotation) from contextually correct (correct given the
user's full context at inference time).

This distinction is directly relevant to benchmark validity: a system can
score 95% accuracy on an offline benchmark while producing outputs that are
contextually wrong for the specific user in production.

---

## 4.2 Reliability

Reliability — agent reliability, the working default in this vocabulary — is
the degree to which an agent or MAS preserves correct behaviour across
repeated runs and relevant condition changes within a defined operating
envelope. Where accuracy is an outcome concept, reliability is a variation
concept: it answers whether the system consistently produces correct answers
across the full distribution of conditions, including multiple runs,
paraphrased inputs, partial failures, and adversarial perturbations.

Three properties follow. Reliability is envelope-relative: it is always
measured with respect to a defined set of conditions — run count,
perturbation types, fault scenarios — so an unqualified claim of "high
reliability" is not meaningful without specifying that envelope. It is
multi-dimensional, decomposing into four independently measurable dimensions
developed in Chapter 5, and a system can score well on one and poorly on
another. And when "reliability" is used to mean infrastructure availability,
uptime, or delivery guarantees rather than agent output quality, it requires
the qualifier infrastructure reliability: pure availability or SLO language,
system uptime, and message delivery guarantees are not part of agent
reliability unless explicitly qualified this way. The primary source for this
definition is Rabanser et al. [2026].

The term itself is genuinely contested in the literature, and the contest is
worth resolving explicitly, because it determines what an unqualified
"reliability" claim means in this vocabulary.

Three usages recur. An infrastructure-first usage, aligned with SRE framing
[Beyer et al., 2016], treats reliability as covering uptime, fault recovery,
and delivery guarantees, with output correctness handled separately in model
or evaluation literature. A behaviour-first usage, consistent with
agent-oriented systems literature [Wooldridge, 2009], treats agent
reliability as the conformance of autonomous behaviour over time — a claim
that goes beyond uptime signals. A stratified usage, aligned with the
reliability-versus-accuracy decomposition used in recent agent evaluation
work [Rabanser et al., 2026], treats infrastructure availability as a
precondition for agent reliability rather than a synonym for it.

This vocabulary adopts the stratified usage as its working definition, for
two reasons. First, it does not discard the infrastructure-first view: it
keeps infrastructure reliability as a real, in-scope property, just at a
different layer, so nothing about uptime or delivery guarantees is lost,
only relocated under an explicit qualifier. Second, it lets agent reliability
retain a single, measurable meaning — output quality across conditions,
decomposed into consistency, robustness, predictability, and safety — that
lines up with Rabanser et al.'s reliability study and with the four-dimension structure
developed in Chapter 5. An unqualified "reliability" in this vocabulary
therefore means agent reliability in this sense; infrastructure meanings
require the infrastructure reliability qualifier.

The behaviour-first view is not fully resolved by this choice. Whether an
agent's behaviour over time conforms to a declared pattern is partially
captured by the consistency and safety dimensions, but treating behavioural
conformance as a first-class property in its own right remains an open
question rather than a settled sub-property, left as such rather than folded
silently into an existing dimension.

---

## 4.3 Accuracy and reliability as orthogonal concepts

Accuracy and reliability are orthogonal: each answers a different evaluation
question and can fail independently of the other. A system can have high
accuracy and low reliability, producing the right answer on a single
benchmark run and then failing on a substantial share of repeated runs. It
can have low accuracy and high reliability, consistently wrong but in a
bounded, predictable way. It can have both high accuracy and high
reliability, which is the target condition for production systems, or both
low accuracy and low reliability, unreliable and often wrong at once.

Rabanser et al.'s headline finding is precisely this gap: twenty-four months
of capability improvements raised pass@k, an accuracy measure, without
raising pass^k, a reliability measure, at the same rate.

---

## 4.4 Operational dependency

While orthogonal as concepts, accuracy and reliability are not operationally
independent in a deployed system. Realised accuracy depends on a reliability
substrate: if tools fail intermittently, if messages are dropped, if
retrieval is stale, or if retries behave pathologically, the system's
observed accuracy degrades as a result.

This gives four canonical answers worth stating plainly. Accuracy and
reliability are not the same thing. A system can be accurate but unreliable
under repeated evaluation. Deployed accuracy does depend on some reliability
properties. And operational properties should not necessarily be folded into
the definition of reliability itself — they are better modelled as
independent determinants of realised reliability and accuracy. The practical
rule is to keep accuracy and reliability distinct as evaluation concepts
while still modelling the operational properties that affect them.

---

## 4.5 A three-class taxonomy of failures

Failures across all taxonomies — MAST, Rabanser et al.'s reliability study,
and BFT literature — organise naturally into three classes that differ in
remediation, not only in location.

Cognitive failures are errors in reasoning or context content: wrong
semantics, logical inconsistency, knowledge gaps, or stale data. They are
addressed through better design — shared ontologies, integrity constraints,
grounding policy — and they set the accuracy ceiling under nominal
conditions. Infrastructure failures are runtime hazards that cannot be
designed away: tool unavailability, message loss, rate limits, model drift,
or adversarial input. They are addressed through resilience engineering —
retries, circuit breakers, fallbacks, model pinning — and they set the
reliability floor under operational conditions. Recovery mechanism failures
occur when self-correction fails to absorb a cognitive or infrastructure
fault; they are addressed through policy — retry budgets, escalation
thresholds, abstention conditions — and they determine the cost-resilience
tradeoff.

Put differently: cognitive failures are set by design and bound the accuracy
ceiling; infrastructure failures are set by operations and bound the
reliability floor; recovery failures are set by policy and govern the
cost-resilience tradeoff. This classification explains Rabanser et al.'s
result directly — reliability did not improve alongside twenty-four months of
accuracy gains because capability scaling addresses cognitive failures, while
infrastructure resilience is orthogonal to model capability and requires
separate engineering investment.

This three-way split is a summary classification for the current scope of
this vocabulary; a detailed failure taxonomy is developed in a subsequent
deliverable.
