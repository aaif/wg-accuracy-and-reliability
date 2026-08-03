# Terminology and Boundaries for Accuracy and Reliability

## Executive summary

This document establishes a stable, vendor-neutral vocabulary for accuracy and
reliability claims about agents and multi-agent systems operating under
enterprise conditions.

The approach taken is conceptual rather than procedural. Before any claim is
made, the evaluation subject must be identified: a model, an agent, a
multi-agent system, or a workflow/pipeline. Properties — what is being claimed
— are kept separate from evaluation artefacts — how a claim is tested. Metrics
are treated as quantifiers attached to explicit concepts rather than as
substitutes for those concepts, and observed symptoms are separated from
attributed root causes before any preventive or corrective mechanism is
chosen. One consequence of this approach is a strict interpretation rule: a
leaderboard score or an isolated benchmark result is not sufficient grounds for
a broad reliability claim unless the evaluation subject, its operating
envelope, and its methodology are all declared.

The chapters that follow build this vocabulary in a fixed order, because each
layer depends on the one before it. Purpose and scope fixes why the vocabulary
is needed and what it deliberately leaves out. Design principles set the
admission criteria and layering rules used to decide whether a candidate term
earns a place in the vocabulary. System boundaries then declares the
evaluation subject and the attribution boundary that any later claim must
respect, and immediately distinguishes failures that originate outside the
evaluated subject from failures that originate inside it, so that symptoms can
be mapped before root causes are reconstructed. Core concepts positions
accuracy against reliability and introduces the correctness variants needed to
avoid category errors between the two. Reliability dimensions decomposes
reliability itself into consistency, robustness, predictability, and safety.
Operational and governance terms adds the identity, traceability, and
recoverability constraints that attribution and audit require. Grounding and
evidence terms defines how claims are anchored to world evidence and to trust
anchors. Failure vocabulary formalises the progression from symptom to
attribution to root cause so that remediation is actionable rather than
generic. Metrics and measurement links dimensions and failures to explicit
quantifiers under a declared envelope, including non-failure performance
characteristics such as cost, variance, and consistency under load. Evaluation
ecosystem separates properties from the benchmark, scenario, trace, and
harness artefacts used to measure them. Response and correction closes the
loop by defining reliability-by-design patterns and correction mechanisms.

Read in this order, the vocabulary gives practitioners a common dashboard
language for accuracy and reliability across deployment profiles, a shared way
to declare boundaries for security and production exposure, and a
release-claim structure that reduces ambiguity across teams.



ewpage

# Purpose and Scope

This chapter fixes why this vocabulary exists, what it standardises, and which
topics are deliberately out of scope, before term-level decisions begin.

## 1.0 Introduction

Agentic systems need a shared, vendor-neutral vocabulary for accuracy and
reliability. Its function is to make claims comparable across benchmarks,
internal evaluations, and operational contexts by fixing term meanings,
subject boundaries, and qualifier rules.

The vocabulary is built by separating four layers: the evaluation subject, the
evaluative properties, the measurement vocabulary, and the response
vocabulary. This separation prevents common category errors, such as treating
a benchmark as if it were a property, or using a metric label as though it
were a definition.

In this framing, accuracy remains a narrower correctness concept, while
reliability spans more dimensions in practice: consistency, robustness,
predictability, safety, and resource-variance considerations under a declared
scope. Accuracy and reliability together form an overset of concerns: failure
vocabulary and attribution on one side, and non-failure performance
characterization — cost and resource variance, predictability quality, and
repeatability — on the other.

## 1.1 What this document standardises

This chapter set establishes the canonical vocabulary for the Accuracy &
Reliability Working Group (ARWG) of the Agentic AI Foundation (AAIF). It
defines the layered taxonomy architecture —
evaluation subject, dimensions, metrics, failure model, response, and
evaluation ecosystem — together with the system under study (agent, MAS or
multi-agent system, workflow, and the infra, world, and user rings that
expand scope, covered in §3). It fixes the top-level evaluative concepts used throughout, the qualifier
rules that prevent overloaded terms from creating false agreement, the
category boundaries that separate dimensions (what "good" means) from metrics
(how it is measured) and from operational and governance properties, and the
minimum vocabulary needed to establish classification boundaries.

This is a normative reference, not a tutorial or a survey: it defines terms,
boundaries, qualifier rules, and category structure, and does not prescribe
adoption programmes, procurement framing, or deployment playbooks.

---

## 1.2 In scope

The taxonomy architecture covers the layered structure spanning evaluation
subject, dimensions, metrics, failure model, response, and evaluation
ecosystem. System boundaries cover the agent, the MAS, the workflow, the
infra/world/user rings that surround them, and the agent boundary and tool
attribution rules developed in §3. The core evaluative concepts are accuracy
(outcome and action) and reliability, together with the formal relationship
between them, developed in §4. Reliability itself is decomposed into
consistency, robustness, predictability, safety, and related sub-types in §5.

Beyond these core concepts, the vocabulary also covers the supporting
operational terms — runtime and recovery properties that affect realised
reliability — and the governance and attribution terms needed for
accountability, lineage, and audit. It covers failure vocabulary: symptom and
root-cause labels with their required subtypes or qualifiers. It resolves
conflicts where key terms diverge across Rabanser et al.'s reliability study
[2026], MAST (the Multi-Agent System Failure Taxonomy [Cemri et al., 2025]),
BFT (Byzantine Fault Tolerance) literature, and classical MAS usage, and it
sets the qualifier rules that determine which terms require qualification
and what qualifier forms are
allowed.

---

## 1.3 Out of scope

Several adjacent topics are deliberately left out. Training-time accuracy —
pre-training, fine-tuning, and RLHF quality — is a model-internal concern, and
prompt engineering vocabulary is a practitioner technique rather than a
standardised evaluation concept, so neither is treated here. Infrastructure
SLO thresholds and operational commitments are also out of scope: infra-related
metric vocabulary is defined when needed for taxonomy clarity, but Site
Reliability Engineering (SRE) policy thresholds, compliance bars, and
operational runbooks are not set here.
Regulatory compliance policy is likewise excluded — technical vocabulary for
evidence is provided, but legal compliance is not certified.

On the evaluation side, benchmark annotation methodology is left to dataset
labelling practice: correctness terms are defined here, not labelling methods.
Benchmark inventories and coverage matrices are treated as an external
analysis artefact, though the minimum vocabulary and required reporting
fields those artifacts should use are defined. Gap analysis and solution
landscape prioritisation fall outside this scope entirely, as does narrative
positioning content — this is normative terminology, not a messaging guide.

Quality thresholds and deployment bars are not set here either: terms and
metrics are defined, not pass/fail policy thresholds. Measurement operations
and playbooks — how evaluation campaigns are run, as opposed to what is
measured — are out of scope, as are test dataset design principles beyond
naming dataset and ground-truth concepts, and implementation pattern
catalogues beyond naming the mechanisms themselves.

---

## 1.4 Audience

This vocabulary is written for authors and reviewers who need a stable
reference to cite normatively, for practitioners evaluating or deploying
multi-agent systems who need a working vocabulary for describing failures,
measurements, and design properties, and for benchmark and tool authors who
need to align their metric names and definitions with ARWG usage.

It is not primarily addressed to audiences seeking procurement or
policy-positioning narrative, nor to audiences seeking new benchmark design
methods beyond terminology scope.

This vocabulary can also be put to immediate, day-one use by each of these
audiences without waiting for later deliverables. Evaluation and benchmark
authors can use the subject, dimension, failure
class, and envelope labels defined here so that results remain comparable
across frameworks; the immediate action available to them is to reject
summaries that preserve scores but omit subject or envelope declarations.
Platform and runtime teams can use the subject and boundary terms to separate
attribution before remediation, applying the attribution order — infra, then
agent, then world, then recovery — before choosing retries, fallbacks, or
rollbacks.

Product and engineering managers can use the qualifiers defined here to
prevent ambiguous quality claims in release reviews, requiring
profile-specific indicators and a single stable metric dictionary per
deployment profile. Security, risk, and governance stakeholders can require
traceable claims tied to versioned identity, trust-anchor declaration, and
explicit user-exposure scope, treating missing provenance or exposure metadata
as governance exceptions rather than model-quality exceptions. Observability
partners can use the metric and failure vocabulary as dashboard semantics
while trace mechanics remain in Observability WG scope, enforcing a stable
semantic mapping so trend lines do not silently change meaning.

---

## 1.5 Internal consistency rule

Canonical definitions are maintained in this chapter set alone. When a term
needs to change, the change is made directly in the chapter where the term is
defined, and any other chapter that relies on that term is updated in the same
revision so the published set never disagrees with itself.

---

## 1.6 Why this vocabulary is needed

Agentic AI systems introduce a class of failures that existing vocabulary from
machine learning, distributed systems, and SRE does not cleanly address. Three
converging problems motivate the vocabulary developed in the chapters that
follow.

The first problem is that the same word means different things across
communities. The term "reliability" means infrastructure uptime to an SRE,
output stability across runs to an evaluation researcher, and behavioural
conformance over time to an agent architect. The term "hallucination" is
applied to source-grounding failures, entity-resolution errors,
stale-retrieval artefacts, and fabricated tool invocations — four different
root causes requiring four different fixes. Without a shared vocabulary,
procurement claims, benchmark comparisons, and failure reports create false
agreement.

The second problem is that accuracy and reliability are not improving
together. Rabanser et al. [2026] tracked 24 months of frontier model releases
and found that reliability gains lagged noticeably behind accuracy gains over
the same period. Capability scaling addresses cognitive failures — wrong
reasoning given correct inputs. Infrastructure resilience — tool
unavailability, message loss, adversarial perturbation — is orthogonal to
model capability and requires separate engineering investment. Without a
vocabulary that separates these, engineering effort is systematically
misallocated.

The third problem is that agentic systems introduce new failure modes with no
agreed names. MAST [Cemri et al., 2025] identifies fourteen failure modes
across three categories — system design issues, inter-agent misalignment, and
task verification failures. Failures like fabricated tool results, dropped
intermediate state, and delegation chain breaks do not exist in single-model
evaluation literature. FINOS, Open Banking Standards, and regulated
enterprise use cases add entity-resolution and lineage requirements that LLM
benchmarks do not address.

The chapters that follow respond to these three problems with a minimal,
normative vocabulary that makes the relevant distinctions precise enough to be
measurable, actionable, and citable across ARWG work. In practice, this
addresses concrete pain points seen in enterprise programs: non-comparable
benchmark claims, misattributed incidents, release sign-off ambiguity, and
dashboard drift where metric names stay constant while their meanings change
across deployments.



ewpage

# Design Principles for Terminology

This chapter defines the method gates for the rest of the vocabulary: which
terms are admitted, how category boundaries are enforced, and how overload is
prevented, before moving to subject and property definitions.

Teams often debate terms that sound important but cannot be measured,
attributed, or used to choose a remediation path. The gate applied throughout
is simple: if a proposed term cannot change a metric, an attribution
decision, or an engineering choice, it remains narrative vocabulary and is not
admitted as a canonical term.

## 2.1 Admission criteria

A term is included only if it satisfies at least one of three criteria. It may
have measurement relevance, meaning it maps to an observable quantity or an
evaluation protocol rather than only appearing in prose. It may have
attribution relevance, meaning it helps locate where a failure belongs by
naming an object, a layer, or a scope. Or it may have design relevance,
meaning it changes a remediation or architecture decision. A term that
satisfies none of these three criteria is not admitted to the canonical
working term set.

---

## 2.2 Requirements for the vocabulary

The vocabulary as a whole is held to a consistent set of requirements. Terms
must support evaluation and metrics, not only prose consistency, and
definitions should help locate where failures belong, including object,
category, and scope. Terms should guide remediation or architecture choices,
and should remain interoperable across sources — Rabanser et al.'s
reliability study, Tau-Bench, MAST, and classical MAS usage — through
explicit conflict notes and source mappings. Terms should not absorb adjacent governance or SRE scope by
accident; out-of-scope edges must stay explicit, and overloaded labels
require qualifiers.

Adopted terms need concise canonical definitions so that later work can cite
them normatively, and the structure needs to survive future taxonomy and
benchmark evolution. Throughout, the vocabulary stays confined to terminology
and taxonomy: it does not set thresholds, playbooks, or procurement
narrative.

---

## 2.3 Assumptions

A small number of assumptions guide this design, stated explicitly so the
working group can reject or amend them if needed.

Top-level concepts should be kept few, because too many peer concepts make
the glossary unusable; the risk is that important distinctions hide under
sub-terms. A term is worth standardising only if it changes measurement,
attribution, or design — this avoids philosophical drift, at the risk that
some stakeholder-facing language is underrepresented. Failure vocabulary
should sit below outcome metrics, keeping symptoms distinct from evaluation
concepts, though some communities may prefer a failure-first framing instead.
Category distinctions are treated as necessary because failures are
compositional, which avoids conflating symptom and root cause at the cost of
more reading complexity. Infrastructure and governance terms should stay
visible without dominating the vocabulary, which keeps the scope aligned with
its accuracy-and-reliability focus, though some readers may expect broader
reliability coverage as a result. Finally, an unqualified "hallucination" is
treated as too weak for engineering use — this enables actionable reporting,
even though the qualified language may feel less intuitive to some
stakeholders.

---

## 2.4 Layered taxonomy (structural categories)

Terms sit in a fixed hierarchy, with the full layer sections developed in
§9–§11 for this publication scope. Every term also carries exactly one
primary category, and the two views align with each other.

The evaluation-subject layer holds agent, MAS, and workflow. The dimensions
layer holds accuracy (outcome and action) and reliability (consistency,
robustness, predictability, safety). The metrics layer holds pass^k, task
success rate, ECE (expected calibration error, one of predictability's
sub-metrics), cost variance, and related measures. The failure-model layer
holds the progression from symptom to attribution to root cause. The response
layer holds design patterns and correction mechanisms. The
evaluation-ecosystem layer holds benchmark, dataset, scenario, ground truth,
and trace. A cross-cutting layer holds the governance and observability
requirements developed in Chapter 6.

Governance — identity, versioning, policy, trust, audit — constrains every
layer. Observability defines what must be visible in order to measure and
attribute; trace emission standards themselves are outside this scope.

Every term is tagged with exactly one primary category. A concept is a
top-level evaluative notion, such as accuracy or
reliability. A dimension is a property under accuracy or reliability, such as
consistency, robustness, task accuracy, or process accuracy. A metric is a
numeric or categorical measure of a dimension, such as task success rate,
pass^k, or calibration error. An operational property is a runtime or
recovery property affecting realised outcomes, such as recoverability. A
failure term is a symptom or root-cause label, such as a hallucination
subtype or a reasoning failure. A governance term is an attribution,
identity, audit, or policy term, such as agent identity or agent
specification. A process term is a property of a mechanism or procedure, such
as deterministic validation. An ecosystem term is a participant or artefact in
evaluation, such as a benchmark, dataset, user, or tool.

---

## 2.5 Failure taxonomy

There is no pre-existing AAIF failure taxonomy adopted outside this effort;
this chapter set introduces the initial failure taxonomy baseline used by
ARWG.

In this version, failure terminology is organised to support engineering use.
Top-level concepts define what is being evaluated, reliability dimensions
define how outcomes vary across conditions, failure categories explain why
outcomes fail and where remediation should apply, and operational controls
define how systems absorb, bound, or recover from failure states. Without
this structure, term definitions lose attribution value and remediation
guidance becomes inconsistent. Failure subtypes are therefore included for
attribution and correction, and are extended iteratively as the taxonomy
matures.

---

## 2.6 Taxonomy update methodology (publication scope)

For the currently published chapter set, taxonomy updates follow an
operational sequence: validate boundary consistency across chapters 3 through
11, covering subject, dimension, metric, failure, response, and ecosystem;
resolve conflicts through explicit qualifier rules rather than silent
renaming; and verify that cross-chapter references still point to the right
section after a change.

This process is intentionally lightweight at this stage and may be expanded
later once ARWG formalises broader conformance workflows.



ewpage

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



ewpage

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



ewpage

# Reliability Dimensions

This chapter decomposes reliability into measurable dimension families, so
that a single overloaded "reliable" label is avoided and coverage, protocol,
and SLA reasoning can proceed dimension by dimension. Teams commonly optimise
one reliability signal, such as repeated-run consistency, while hidden
failure risk remains on safety, robustness, or predictability — a model can
be highly consistent yet confidently wrong on the cases it misses, with
consistency improving while its confidence calibration and safety record
still deteriorate.

## 5.1 Overview

Reliability is not a scalar. It decomposes into four independently measurable
dimensions, each capable of failing while the others hold, and a system must
be evaluated against all four to constitute a reliability claim. This
decomposition follows Rabanser et al. [2026], who ground it in cross-domain
safety-critical engineering practice (aviation, nuclear power, automotive)
and validate it empirically across fifteen models on two benchmarks.

---

## 5.2 The four dimensions

Consistency is the same correct output across repeated runs on the same
input, measured canonically as pass^k — the probability of a correct result
on all k runs — and it catches stochastic instability. Robustness is the
same correct output across semantically equivalent input variants or
operational perturbations, measured across prompt, fault, and environment
perturbations, and it catches brittleness to surface variation and
infrastructure faults. Predictability is whether the system fails in
expected, boundable ways rather than surprising ones, measured through
confidence calibration, discrimination between likely-correct and
likely-wrong outputs, and proper-scoring-rule quality; it catches the gap
between an agent that fails rarely-but-unpredictably and one a user can
learn to anticipate. Safety is the avoidance of prohibited actions and the
bounding of harm when violations do occur, measured through compliance and
harm severity, and it catches boundary violations and their consequences.

---

## 5.3 Canonical definitions

### Consistency

Unqualified consistency is the stability of correct outcomes across repeated
evaluations of the same task under nominally equivalent conditions, measured
as pass^k. The unqualified term means repeated-run output consistency in the
Princeton sense; two further qualified forms are separately canonical.
Factual consistency means that no two agents carry conflicting values for the
same key within a MAS — a spatial, cross-agent property rather than a
temporal one. Agreement, in the BFT sense, means agents converge to the same
value regardless of whether that value is correct, and is used only when
explicitly referencing distributed-systems consensus literature. Berdoz et
al. [2026] find that LLM-agent groups do not reach valid agreement reliably
even in benign, non-adversarial settings, and that the dominant failure mode
is a loss of liveness — stalled or timed-out convergence — rather than
convergence to a corrupted value; this is why the qualifier distinguishes
agreement from correctness rather than treating them as the same property.

Consistency is not the same as robustness: a system can have high
consistency — the same answer across ten runs of the same input — and low
robustness, changing its answer when the input is paraphrased, and the
reverse also holds. Conflating the two produces misleading evaluation
results.

### 5.3.1 Three sub-types of consistency

Rabanser et al. [2026] distinguish three sub-types of consistency that should
be tracked separately. Outcome consistency is the same result, success or
failure, across repeated identical tasks, measured as pass^k, and it catches
stochastic instability in end-state correctness. Trajectory consistency is
similar action paths to reach the solution, including action-type
distributions and ordering, and it catches reproducibility of process rather
than only end-state. Resource consistency is low variability in
computational and monetary costs — latency, duration, API spend — across
identical requests, and it catches unpredictable resource consumption.

Unqualified "consistency" means outcome consistency (pass^k); the trajectory
and resource sub-types require an explicit qualifier. As Rabanser et al.
[2026] put it, referring explicitly to variance makes the notion more
precise, whereas terms such as "stability" remain comparatively vague. A
system can have high outcome consistency alongside high trajectory variance —
reaching the right answer via a different path each time — because the two
are independent properties.

---

### Robustness

Robustness is the stability of correct outcomes under semantically
equivalent or operationally relevant perturbations. Three sub-types are
recognised. Prompt robustness holds when input phrasing varies while meaning
is preserved — paraphrases and reformulations, within or across languages.
Fault robustness holds when infrastructure conditions vary instead — tool
timeouts, dropped calls, or malformed responses that a resilient agent
absorbs through retries or fallbacks rather than abandoning the task.
Environment robustness holds when the operating environment itself changes
in ways that preserve its meaning but not its surface form — reordered
fields in a returned record, a different date format, a renamed API
parameter — the kind of change that should not affect a well-built agent but
often does. When the perturbation type matters for a claim, the sub-type
qualifier is required; unqualified "robustness" is acceptable only when
covering all three sub-types jointly.

### 5.3.2 Prompt robustness in enterprise settings

Prompt robustness is particularly critical for enterprise deployment
[Rabanser et al., 2026]. It measures whether a system consistently handles
semantically equivalent reformulations of instructions, within or across
languages, so that different phrasings such as "cancel my subscription" and
"end my plan" produce the same reliable outcome. Robustness does not cover
the countermeasures or mitigation mechanisms themselves; those are
recoverability and operational terms, developed in Chapter 6.

---

### Predictability

Predictability is whether a system fails in expected, boundable ways rather
than catching users by surprise — a system that fails predictably is
preferable to one that fails rarely but arbitrarily. Rabanser et al. [2026]
operationalise predictability through three sub-metrics rather than a single
score. Calibration is the degree to which a system's stated confidence
aligns with its empirical correctness rate, measured as the gap between mean
stated confidence and observed accuracy (expected calibration error, ECE): a
calibrated system that is 80% confident is correct approximately 80% of the
time, while an overconfident system claims certainty on cases it gets wrong
and an underconfident system hedges even when it is right. Discrimination is
whether confidence scores actually separate successes from failures,
regardless of whether the confidence values themselves are well-calibrated
in absolute terms — a system can be discriminating without being calibrated,
and vice versa. The Brier score is a proper-scoring-rule measure that jointly
captures calibration and discrimination in one number, penalising both
overconfidence and poor separation.

These three sub-metrics can move independently: a system that is well
calibrated on average may still fail to discriminate individual successes
from failures, and a system with strong discrimination may still be
systematically over- or under-confident. Calibration is a model-level
property that cannot be fully corrected by context assembly or architectural
choices alone.

### 5.3.3 Predictability and behavioural conformance — distinct senses of the term

Predictability, as defined above, is Rabanser et al.'s precise, metric-grounded
sense: calibration, discrimination, and Brier score, all computed from
confidence scores and observed outcomes. A different, broader sense
sometimes appears in agent-oriented systems literature — whether an agent's
behaviour over time conforms to an expected pattern at all, independent of
whether it reports confidence [Wooldridge, 2009] — which is closer to the
behavioural-conformance question raised in §4.2. These are not synonyms: a
system can be predictable in the calibration sense, its stated confidence
tracking its accuracy, while still being unpredictable in the
behaviour-conformance sense, choosing a different strategy on every run.
This vocabulary uses "predictability" in Rabanser et al.'s precise sense
throughout this chapter; the broader behavioural-conformance sense remains an
open question in its own right, left unresolved rather than folded into this
dimension.

---

### Safety

Safety, in the Princeton sense that is the default here, is the degree to
which a system avoids prohibited, harmful, or unauthorised actions under the
defined task and control regime, and bounds the harm on the occasions a
violation does occur. It is measured through two sub-metrics: compliance,
the fraction of tasks completed without a constraint violation, and harm
severity, the expected cost of the violations that do occur, weighted by how
severe each one is. "Safety" in ARWG output defaults to this definition, and
the qualifier "safety in the BFT/Lamport sense" is required when referencing
the distinct state-machine liveness/safety property from that literature
instead.

Safety is kept structurally as one of the four reliability dimensions, but it
is reported separately from the other three rather than folded into a single
aggregate reliability score. The reason is that safety violations are a tail
phenomenon: a system that behaves safely 99% of the time but causes
catastrophic harm in the remaining 1% would have that risk averaged away and
hidden by any blended score. A system can be consistently wrong in a harmful
direction, which would make it reliable but not safe, and this is precisely
why Rabanser et al. [2026] exclude safety from their aggregate reliability
score and treat it as a hard constraint instead — a choice this vocabulary
adopts for the same reason.

---

## 5.4 How the four dimensions relate

A complete reliability claim must state which of the four dimensions is
being evaluated and the conditions under which it was measured. Consistency
asks whether the system gives the same answer across runs, with outcome
consistency (pass^k) as the unqualified default and trajectory and resource
consistency requiring an explicit qualifier. Robustness asks whether the
system gives the same answer under perturbation, split into prompt
robustness for paraphrase and reformulation, fault robustness for
infrastructure failure, and environment robustness for meaning-preserving
changes to the operating environment. Predictability asks whether the system
fails in expected, boundable ways, measured through calibration,
discrimination, and Brier score. Safety asks whether prohibited actions are
avoided and harm is bounded when they are not, reported separately from the
other three dimensions rather than blended into one aggregate score, because
averaging would hide tail-risk violations.

---

## 5.5 Resilience as a sub-dimension

Resilience is not a peer concept to accuracy or reliability. It is the
sub-question of reliability that asks how accuracy degrades under
perturbation: gracefully, bounded and surfaced as uncertainty, or
catastrophically and silently. Under the Princeton decomposition, resilience
corresponds to the robustness dimension, specifically its fault and
environment sub-types. The term "resilience" is used in this vocabulary to
remain consistent with classical MAS literature [Wooldridge, 2009], but it
maps to Princeton's robustness measured over fault and environment
scenarios.

---

## 5.6 Self-correction

Self-correction is a mechanism that improves consistency and fault
robustness at a cost. It is not itself a measurable reliability dimension —
it does not appear as a column in the four-dimension table. Self-correction
mechanisms that act on predicted failures, such as circuit breakers,
proactive monitors, and uncertainty-driven abstention, are in scope for
fault robustness evaluation.



ewpage

# Operational and Governance Terms

This chapter adds cross-cutting governance and operational constraints
required for attribution, reproducibility, and audit, while keeping them
distinct from accuracy and reliability dimensions. Incident reviews often
conclude "agent failure" without enough identity, provenance, or
traceability to reproduce and fix the issue correctly — if two releases
share a product name but not a stable identity or version handle, a failure
report can be attributed to the wrong runtime artifact entirely.

## 6.1 Purpose of this chapter

The terms here describe the governance cross-cutting concern and the
runtime, recovery, and audit properties that constrain measurement and
response. They are not quality dimensions for individual outputs; conflating
them with accuracy or reliability dimensions produces claims that are not
meaningful.

Reliability by design and correction mechanisms form the response layer of
the taxonomy; detailed patterns for that layer are deferred to
implementation-focused work, and this chapter instead covers the governance
terms and selected operational properties that appear here.

---

## 6.2 Operational properties

### Recoverability

Recoverability is the ability of a system to detect, contain, and restore
from failures with bounded impact and bounded escalation cost. It is an
operational property, and it always requires a qualifier, since
"recoverability" alone is ambiguous between individual agent recovery and
system-wide recovery — qualifiers such as agent recoverability, session
recoverability, or workflow recoverability should be used when scope
matters.

Recoverability is a mechanism that improves fault robustness and consistency,
but it is not itself a reliability dimension. A system can have high
recoverability, detecting and restoring quickly, and still exhibit low
reliability, failing frequently; the two must be measured separately.
Recoverability does not cover the correctness of an individual output or base
accuracy. It is adopted here as an operational property, not a fifth
reliability dimension, and is developed further in §11.

### Deterministic / stochastic

In its narrow sense, deterministic describes a procedure, validator, or
state transition that repeats the same steps and yields the same result for
the same inputs. This is a process term, and it always requires a qualifier:
"deterministic" must be confined to specific procedures, checkers, or
workflow steps, and must not be used as a quality claim about an LLM agent
as a whole. It is correct, for instance, to say that a deterministic
final-state validator is used to score task outputs, or that the workflow
transitions are deterministic, or that the evaluation protocol uses
deterministic scoring — but it is incorrect to say that an agent itself is
deterministic, or that a MAS became "more deterministic" after a fix, or
that reliability improved by making a system "more deterministic."

Stochastic follows the same constraint: it is reserved for LLM output
variance and probabilistic sampling, and should not be used as a synonym for
"unreliable."

---

## 6.3 Governance and attribution terms

### Trustworthiness

Trustworthiness is not a canonical metric term in this vocabulary. It is a
composite stakeholder judgment that potentially combines accuracy,
reliability, safety, provenance, governance, and user perception of an
agent's decisions, and it always requires a qualifier stating which
underlying properties are being judged.

#### Accuracy vs trustworthiness

Accuracy and trustworthiness are distinct properties and must not be
conflated. Accuracy is an inherent agent property: whether outputs are
correct against a specified evaluation criterion. Trustworthiness is a
user-reliance property: whether a user can rely on the agent to make sound
decisions in context. An agent that scores high accuracy on benchmarks may
still not be trustworthy in production, if the user's task context differs
from the benchmark distribution (an a-priori correctness gap, §4.1.2), if
the user over-relies on the agent's confident outputs (a calibration
failure), or if the agent's accuracy is not interpretable or auditable for
the specific user's risk tolerance.

Accuracy, in this vocabulary's position, is an inherent system property
measured against a specified criterion, while trustworthiness is reserved
for composite user-reliance judgments that require explicit qualification of
which underlying properties — accuracy, calibration, safety, provenance —
are being combined, and for what audience and risk context. "Trustworthy AI"
with no further specification is not a canonical metric and is insufficient
for ARWG technical claims.

### Agent identity

Agent identity is a stable identifier and versioned attribution handle for
an agent artifact or runtime participant. It is a governance term and does
not require a qualifier. Agent identity enables traceability — which agent
produced which output — SLA attribution — which agent version is in scope
for a reliability commitment — delegation auditing — which agent delegated
to which — and debugging, isolating a regression to a specific agent
version. It is not a quality metric: agent identity does not measure
accuracy or reliability, but is a prerequisite for accountability and
lineage, and its detailed specification is out of scope here. An agent's
identifier must remain stable as its capabilities evolve, and must support
delegation auditing across versions.

#### Lineage reliability

Multi-agent systems that spawn sub-agents create agent lineage chains, and
the reliability of a parent agent depends in part on the reliability of the
sub-agents it spawns — dealing with the reliability of the lineages of
agents spawned by an agent is itself a governance concern. Lineage
reliability is recognised here as spanning agent identity, traceability,
and the non-regression of spawned agents, named as part of the governance
vocabulary rather than measured as a separate metric.

---

### Traceability

Traceability is the ability to reconstruct which agent, version, inputs,
tools, evidence, and actions contributed to an outcome. It is a governance
term that requires a qualifier when scope is narrow, distinguishing, for
example, output traceability from tool-call traceability or delegation
traceability.

Traceability is related to but distinct from provenance: traceability covers
the full reconstruction of a reasoning or action chain, while provenance is
the narrower concept of recorded origin and transformation history for data
and evidence items. Traceability depends on provenance being maintained, but
the two are not synonyms.

---

### Provenance

Provenance is the recorded origin and transformation history of data,
evidence, metrics, and outputs used by the system. It is a governance term
that always requires a qualifier, since context determines whether the
concern is data provenance, evidence provenance, or metric provenance.
Provenance is not a synonym for lineage, which is too vague without
qualification, nor for traceability, which is broader, nor for
auditability, which is an organisational property rather than a data
property. A minimal provenance definition is kept here, without prescribing
field-level implementation schemas.

---

### Explainability

Explainability is the degree to which a system's outputs, actions, or
decisions can be made understandable to a relevant audience. It is a
governance term that always requires a qualifier, since the audience
matters — developer, operator, end user, or regulator — and the appropriate
level of explanation differs accordingly. Explainability is orthogonal to
quality metrics: a system can be accurate and unreliable, reliable and
unexplainable, or explainable and wrong, so explainability must not be
folded into accuracy or reliability definitions. It belongs instead under
auditability and governance.

---

## 6.4 Decision status for these terms

The governance vocabulary is stable for this publication cycle. Recoverability
is adopted as an operational property, with explicit scope qualification and
without promotion to a reliability dimension. Deterministic and stochastic
are adopted in narrow technical senses only — procedure-level determinism
and model variance, respectively. Agent identity, lineage reliability,
traceability, provenance, and explainability are adopted as governance and
audit terms, not as direct quality metrics.

Trustworthiness remains non-canonical as a metric label and must be
qualified as a narrative composite judgment; the core distinction from
accuracy is preserved as a standing editorial rule for claims made using this
vocabulary.



ewpage

# Grounding and Evidence Terms

This chapter anchors quality claims to world evidence, trust anchors, and
entity identity, separating reasoning defects from evidence and context
failures for the attribution work in later chapters.

## 7.1 Purpose of this chapter

Many failures that look like reasoning defects are actually about evidence:
whether a claim is tied to a source at all, whether that source is the right
one, and whether the source itself is still current. This chapter names those
evidence-side properties — grounding, trust anchors, entity resolution, stale
sources, and unsupported claims — so that Chapter 8 can attribute a failure to
the right one of them instead of collapsing all of them into "hallucination."

## 7.2 Grounding

Grounding is the degree to which claims, decisions, and recommended actions
are tied to identifiable evidence, tool results, or authorised data sources,
rather than resting on model parametric guesswork alone. It is central to
evidence accuracy and to the hallucination subtyping developed in Chapter 8,
and the underlying evidence items themselves — the specific facts,
measurements, or observations cited in support of a conclusion, each with an
identifiable origin — are what a claim is grounded in or against.

The term carries two senses that must be distinguished in cross-document or
benchmark claims. In the source sense, grounding asks whether a claim has any
identifiable evidence anchor at all; a claim with no traceable source is
ungrounded regardless of whether it happens to be true. In the semantic
sense, grounding asks whether a claim is faithful to the source it cites; a
claim can be anchored to a real source and still misrepresent what that
source says. A claim can fail the source sense, the semantic sense, or both,
and the two failures call for different fixes — a retrieval or citation fix
for the first, a faithfulness or reasoning fix for the second — so a claim
about "grounding" should generally specify which sense is meant.

## 7.3 Trust anchors

A trust anchor is an authoritative data source, service, or verification rule
against which an agent output can be checked for high-stakes tasks — an
authoritative system of record, rather than a source that merely happens to
be retrieved. Declaring which trust anchor, if any, backs a claim is part of
the deployment boundary declaration (§3.5) and the minimum dashboard contract
(§9.4): a claim with no declared trust anchor and a claim checked against a
declared authoritative system of record carry different evidentiary weight,
even when their surface confidence looks the same. Detailed trust-anchor
protocols are deferred to later, implementation-focused work; this chapter
fixes the concept and its role in evidence claims.

## 7.4 Entity resolution

Entity resolution is the process of determining whether references across
inputs, tools, or documents denote the same real-world entity. It plays a
dual role in this vocabulary, appearing both as a failure term and as a
process term, and it does not require a qualifier.

An entity resolution failure occurs when two references that refer to the
same real-world entity — the same service, device, company, or person — are
treated as distinct, or when two different entities are conflated. This
causes downstream reasoning errors that are functionally similar to grounding
failures but have a distinct root cause and a distinct remediation. The
boundary with grounding failures is that a grounding failure is about whether
a claim is anchored to an authorised source, while an entity resolution
failure is about whether the agent knows that two references refer to the
same thing; the two can co-occur, since an unresolved entity may produce an
ungrounded claim, but addressing one does not address the other.

### Entity resolution with permanent, authoritative identifiers

Entity resolution failures are particularly acute when agents must identify
real-world entities — companies, people, legal entities, places — across
documents and systems with no stable, authoritative identifier. Correctly
identifying a company, person, or place referred to in a document, whether
legal, regulatory, or web-sourced, is problematic in practice and gives rise
to hallucinations; the underlying fix is for these entity types to be
identified with permanent IDs of some sort, with agents using those IDs on a
permanent basis.

Several ecosystem initiatives are relevant here. Authoritative identifier
registries, such as company, legal-entity, and person authority files, are
open systems of permanent IDs that can serve as grounding anchors for entity
claims in enterprise contexts. The FINOS LF project (finos.org) maintains
open source financial data standards relevant to entity resolution in
financial workflows, and the Open Banking Standards in Europe define
standardised entity identifiers for banking counterparties.

Entity resolution is therefore not only a technical ML problem; it has an
ecosystem dimension, since authoritative identifier registries can serve as
trust anchors for entity claims. This chapter names the concept and its
scope, drawing on information integration, knowledge graph, and enterprise
workflow practice as primary sources. Entity mismatch is adopted as a symptom
subtype (§8), entity resolution as a process term, and grounding as the
broader evidence property that both relate to.

---

## 7.5 Stale source / stale retrieval

A stale source is an evidence source or retrieval result that was current
when the agent's knowledge or retrieval index was last updated, but is no
longer accurate with respect to the real world at the time of the agent's
reasoning. It is a failure term that does not require a qualifier.

Stale source names a temporal grounding failure: the source was authorised
and valid at some earlier time but is no longer reliable. It is distinct from
a missing source, where the required evidence was never retrieved (a spatial
gap); from a wrong source, where the retrieved source does not pertain to the
claim (an entity resolution or retrieval failure); and from a corrupted
source, where the source was modified in transit (an integrity failure).
Mapping stale source formally into a broader failure taxonomy remains outside
this scope.

---

## 7.6 Unsupported claim

An unsupported claim is an output claim for which no identifiable evidence
source can be traced, regardless of whether the claim happens to be
factually correct. It is a failure term that does not require a qualifier.

An unsupported claim is a source grounding failure that produces an output
without any evidence anchor, and it is the most precise available subtype for
what is colloquially called "hallucination" when the complaint is about
lacking evidence rather than about wrong reasoning. Unsupported claim is a
subtype of the broad hallucination symptom category; "hallucination" is
required to carry a subtype in all technical contexts, and unsupported claim
is the preferred term specifically when the grounding evidence is absent.
Chapter 8 develops the full treatment of hallucination and its subtypes.

---

## 7.7 Decision status for these terms

The chapter-level decision is stable for this publication cycle. Grounding is
adopted with a dual sense and must be qualified in cross-document or
benchmark claims. Trust anchors are adopted as a design property. Entity
resolution is adopted as a distinct attribution concept, explicitly separated
from grounding. Stale source is adopted as a standalone failure term.
Unsupported claim is adopted as a hallucination subtype and remains the
preferred term when the evidence anchor is missing.

No unresolved blocking issue remains in this chapter; remaining refinements
are editorial and can be handled in normal revision flow.



ewpage

# Failure Vocabulary and Restricted Terms

This chapter turns observed breakdowns into a controlled symptom, attribution,
and root-cause vocabulary, so that remediation choices are tied to the right
failure class rather than to umbrella labels. Teams commonly say
"hallucination" for several distinct defects and then apply one generic fix
that does not address the actual root cause — a stale source issue and a
fabricated tool result can both look like wrong output, but they require
different controls: a freshness policy in one case, a tool-use integrity
check in the other.

## 8.1 Purpose of this chapter

This chapter constrains the use of broad or overloaded failure language in
ARWG output, implementing the progression from symptom, the observable
event, to failure attribution, to root cause, the engineering lever.
Symptoms are what operators and users see; root causes are why, grouped in
§4.5 as reasoning, infrastructure, and recovery failures. Symptoms are not
nested under root-cause types — one symptom may map to several causes, and
attribution (§3.4) resolves which applies.

---

## 8.2 Hallucination

Hallucination has no standalone canonical status in this vocabulary; it
requires a subtype whenever it is used. It is retained as a broad symptom
label for stakeholder communication and coarse failure grouping, but it must
not be used as a primary metric or as a complete root-cause diagnosis in
ARWG technical output without a subtype qualifier.

When a failure is described as a "hallucination" in technical output, a
subtype or root-cause refinement is required. Six subtypes are canonical:
unsupported claim, an output claim with no traceable evidence source
(§7.6); entity resolution error, where two distinct entities are conflated
or one entity is split into two (§7.4); stale source, a claim derived from
evidence that is no longer current (§7.5); wrong grounding, a claim that
contradicts its cited source (§7); fabricated tool result, where reasoning
refers to a tool result that never occurred (§8.3); and dropped intermediate
state, where a produced intermediate result is later ignored or lost
in-session (§8.3).

### Why unqualified hallucination is insufficient

Cemri et al. [2025] observe that hallucination has become a vague umbrella
term used for many types of agentic AI failure, and that the definition does
not clarify cases where the model produces an answer grounded in retrieved
data that is itself incorrect or outdated. A so-called hallucination can be
an unsupported claim with no evidence, calling for a grounding policy fix; a
wrong entity resolution, calling for an entity resolution fix; a stale or
low-quality retrieved source, calling for a retrieval freshness or TTL fix;
a fabricated tool capability or action result, calling for a tool-use guard
fix; or a dropped or corrupted intermediate state, calling for a context
integrity fix. Each subtype sits at a different attribution layer and calls
for a different remediation, and using the umbrella term prevents correct
attribution.

### Contested edge case: grounded-but-outdated output

A particularly important boundary case for the hallucination taxonomy is
where, as Cemri et al. put it, the definition does not clarify cases where
the model produces an answer grounded in retrieved data that is itself
incorrect or outdated — an outdated blog post retrieved from the web, for
example. In such cases the system behaves correctly with respect to its
retrieval pipeline, yet the final answer is still factually wrong, and it is
unclear whether this should be classified as a hallucination.

The classification depends on why the answer is wrong. A source that was
current at index time but is now outdated is a stale source failure, a
temporal grounding failure. A source that was never accurate is a wrong
grounding failure, a semantic grounding failure. A claim made without a
traceable source is an unsupported claim. A claim that contradicts its own
cited source is also a wrong grounding failure.

This vocabulary's position is that the grounded-but-outdated case is not a
hallucination in the strict sense. It is a stale source failure and should be
classified as such: the agent behaved correctly given its retrieval
pipeline, and the failure lies in the currency policy of the retrieval or
knowledge base, not in the agent's reasoning.

This subtype decomposition also has a formal-semantics reading, though it is
offered as a supporting frame rather than as canonical engineering
vocabulary: unsupported claims have a vacuous extension, meaning no
real-world referent appears in the evidence, while entity resolution errors
produce the wrong extension, meaning the wrong referent is selected.

---

## 8.3 Additional failure subtypes

Four further subtypes are canonical for ARWG failure attribution. A
fabricated tool result is reasoning that references a tool output never
returned in-session, whose primary root cause is an attention or
context-integrity failure. A dropped intermediate state is an earlier
intermediate result that is missing when needed, whose primary root cause
is a spatial context gap. Tool misuse is a tool used outside its declared
contract or with the wrong parameters, whose primary root cause is a
misconfigured agent or a model capability ceiling. A delegation chain break
is a delegated task that targets a sub-agent that is unavailable or
unauthorised, whose primary root cause is a topology or coordination
failure.

---

## 8.4 Silent failure

A silent failure is a case where the agent produces a confident,
syntactically correct output that is factually wrong or action-unsafe, and
neither the agent nor any downstream checker surfaces any signal of the
error. This is an important concept for ARWG evaluation design.

Silent failures are especially dangerous because they are not caught by
downstream operators who rely on confidence signals or syntactic validation.
A canonical example is a system that registers zero verification-gate
failures while also producing zero correct task outputs: the verification
layer sees no errors, yet every decision is wrong. Silent failures are a
category of predictability failure, specifically a calibration failure
(§5.2): the system is not indicating its uncertainty, and its confidence
signals are misleading.

---

## 8.5 Discouraged umbrella terms

Several terms are discouraged for use as canonical metric terms in ARWG
technical output, though they may still appear in narrative or
stakeholder-facing contexts. Unqualified hallucination is discouraged
because it is too broad; use a specific subtype from §8.2 instead.
Trustworthiness is discouraged as canonical metric language; use explicit
dimensions such as accuracy, reliability, or predictability instead. "Reliability
of LLM" is discouraged because it is ambiguous; use model-level output
reliability or agent reliability instead. Unqualified "AI safety" is
discouraged because it mixes distinct senses; qualify the exact safety sense
used instead.

---

## 8.6 Attribution evidence requirements

Scope rings, symptoms, and root-cause classes are named here for published
scores, and attribution records must provide sufficient evidence to map
events onto this attribution model. Root cause is derived, not logged as a
primitive field: it is produced from the causal tree and the attribution
rules in §3.4.

Minimum attribution evidence should answer three questions. Contact type asks
what kind of contact occurred — model, tool, state, or communication — and is
used for boundary and ring placement. Initiation source asks who initiated
the step — model, workflow logic, runtime policy, or user — and is used to
split design, cognitive, and governance causes. Execution mechanism asks how
the step was executed — call, orchestration edge, or policy injection — and
is used as process-accuracy and trajectory evidence.

These three evidence facets map onto five failure-class labels. A
design/orchestration failure has the workflow or agent specification as its
primary ring, is viewed through a specification/orchestration lens, and is
labelled design/orchestration. A cognitive/reasoning failure has the agent as
its primary ring, is viewed through a reasoning lens, and is labelled
reasoning failure. A governance/policy failure has the governance cross-cut
as its primary ring, is viewed through a policy/compliance lens, and is
labelled governance failure. An infrastructure failure has infrastructure as
its primary ring, is viewed through an infrastructure lens, and is labelled
infrastructure failure. A recovery-exhausted failure has the agent or MAS as
its primary ring, is viewed through a recoverability lens, and is labelled
recovery failure.

No specific field-naming schema is mandated for initiation or execution
fields; any chosen schema should preserve the three evidence facets above so
that ring attribution remains reproducible and symptoms are not collapsed
into a single "hallucination" bucket.



ewpage

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



ewpage

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



ewpage

# Response (Design and Correction)

This chapter closes the methodology by defining preventive and corrective
response terms that operationalise reliability by design and complete the
failure-to-remediation loop. Teams often detect failures but lack a shared
lifecycle for containment, safe degradation, attribution, and iterative
correction across design-time and runtime layers: when an external policy
service fails during an autonomous run, a robust response is not to
"continue normally," but to contain the situation first — abstain, fall
back, or hand off to a human — and only then attribute the cause and retry
under control.

## 11.1 What this chapter covers

Response vocabulary names how systems prevent failures, through reliability
by design, and how they react after detection, through correction
mechanisms; together these form the response layer of the taxonomy.
Reliability-by-design patterns are upstream measures that reduce failure
before commit, such as a verification loop, proactive grounding, a policy
gate, or specification validation. Correction mechanisms are defined
reactions after failure or suspicion, such as retry, escalation,
human-in-the-loop, rollback, compensation, or a circuit breaker.

Recoverability (§6) is an operational property, not a fifth reliability
dimension: it describes whether the system can detect, bound, and exit fault
states, while correction mechanisms are how recoverability is exercised in
practice.

---

## 11.2 Boundary of this chapter

This chapter defines what correction terms mean and how they relate to
reliability and recoverability. It does not prescribe implementation-specific
event schemas, transport formats, or orchestration protocol details.

---

## 11.3 Canonical terms

Normative definitions for this publication scope are maintained in this
chapter set. Admission follows the same criteria set out in §2.

---

## 11.4 Closing the loop

The preceding chapters fix a usable boundary between definition and
implementation: what is meant by evaluation subject, accuracy, reliability,
its dimensions, governance terms, failure classes, metrics, ecosystem
artefacts, and correction mechanisms. Taken together, they provide a shared
vocabulary that can be cited consistently across ARWG work, the terminology
needed for measurement and drift or degradation detection claims, correction
and reliability-by-design language for proactive and reactive practices, and
a vendor-neutral terminology base that can be adopted across toolchains.

This vocabulary does not prescribe implementation platforms or compliance
policy. Its role is to provide the common language required to make later
guidance and specifications precise, comparable, and auditable.

## 11.5 Action points by persona (usable now)

Several actions can be taken immediately by partners using this taxonomy.
Evaluation and benchmark teams can attach the full reporting field set —
subject, deployment profile, rings, dimension, metric, envelope, and
identity/version reference — to every published benchmark result, so that
readers can compare like with like across frameworks, and can reject any
result line that omits subject or envelope metadata, flagging it as
non-comparable rather than low quality.

Agent and platform engineering teams can require stable agent identity and
version tagging for every evaluated release, then apply the attribution
order — infra, then agent, then world, then recovery — before selecting
remediation, treating attribution as a mandatory gate in incident triage so
that retry or fallback changes are not used to mask upstream boundary
failures.

Release and operations teams can include a release accuracy-and-reliability
card in change approval, declaring the deployment profile (autonomous,
copilot, or CI/CD automation), the action authority (read, constrained
write, or privileged write), the trust-anchor mode, and the profile-specific
metric family, and can block promotion when profile or boundary declarations
are missing, even when headline accuracy looks strong.

Security and governance teams can require evidence-linked claims, explicit
user-exposure classification, and traceability to the evaluated
identity/version before production sign-off, classifying sign-off exceptions
as governance exceptions rather than model exceptions whenever provenance,
exposure scope, or trust-anchor declarations are incomplete.

Product and workflow owners can select indicators by deployment profile and
business workflow stage, then monitor drift or degradation using consistent
semantics over time rather than swapping metric meanings across releases,
keeping one stable metric dictionary per profile so that product reviews
track real performance movement rather than taxonomy drift.

Together, these actions reduce ambiguity immediately, while detailed
thresholds, conformance suites, and platform-specific implementation
guidance are left for later work.

## 11.6 What comes next

This chapter set provides the taxonomy contract; subsequent work
operationalises it. Reliability-by-design implementation guidance,
a quality standard with thresholds and formal criteria, a corrective action
framework with escalation semantics, and an evaluation and conformance
methodology are all planned as follow-on deliverables. This sequencing keeps
the present scope focused while still giving partners concrete day-one
value: a minimal adoption pack limited to four artifacts — an
accuracy-and-reliability claim field card, a deployment profile sheet, a
release boundary declaration checklist, and a dashboard semantic mapping.
Everything beyond this pack — thresholds, conformance suites, implementation
playbooks, and runtime-level recovery specifications — is intentionally
deferred to that later work.

## 11.7 Failure lifecycle and response lifecycle

Chapter 8 already defines failure vocabulary and attribution evidence
requirements. Operationally, those definitions map onto a practical
lifecycle. The first step is to observe symptoms: collect user-visible and
system-visible signals — quality drops, safety alerts, retries, anomalies —
without forcing a premature root-cause label. The second is to classify and
scope: label symptoms with the vocabulary defined here and declare subject,
profile, rings, and envelope, so that events are comparable and
attributable. The third is to reconstruct root cause: apply the attribution
order — infra, then agent, then world, then recovery — using evidence
fields, deriving root cause from evidence rather than logging a guessed
cause string. The fourth is to contain and degrade safely: when immediate
full repair is not possible, apply bounded-risk actions such as abstaining,
gating, falling back, rolling back, or handing off to a human, in order to
prevent uncontrolled impact. The fifth is to correct and iterate: push fixes
at the right layer — a design-time pattern, a runtime policy, an external
control — then re-measure with the same semantics to confirm improvement.

This lifecycle is broader than "debugging failures": it supports safe
degradation and controlled operation whenever uncertainty or external
dependency risk remains.

## 11.8 Accuracy-and-reliability design space and landscape framing

Accuracy and reliability work is not only failure handling. It is the
combined coverage of failure-mode span — how well reasoning, infrastructure,
grounding, coordination, and recovery failures are detected, attributed, and
mitigated; non-failure performance characterization — how well cost, latency
and resource variance, calibration quality, and consistency under load are
measured and tracked; control timing — which controls are applied at design
time, at runtime, and during post-incident iteration; and control locus —
which controls live inside agents, in orchestration and runtime layers, or
in external governance and human processes.

Together, these four axes give a grounding for a solution landscape map:
solution families can be positioned by which part of the failure or
performance span they cover, which layer they operate on, and whether they
prevent, detect, contain, or recover. In this framing, observability is the
bridge between symptoms and root-cause reconstruction: it enables
attribution and iterative improvement, including cases where immediate
in-agent correction is impossible and external containment is required.

Read end to end, the operational schema runs as follows. Once boundaries are
declared, failures are split into an external failure surface and an
internal failure surface; symptom observability captures what manifests;
root-cause reconstruction applies the attribution order; containment and
safe degradation bound the impact; remediation is applied at design time, at
runtime, or through external controls; and the same claim is re-measured to
confirm the fix held. Running in parallel at every step is non-failure
performance characterization — accuracy baseline, cost, latency, variance,
and calibration — so that a system is never assessed on failure handling
alone. The resulting coverage is the sum of three things: failure-mode span
coverage, performance-characterization coverage, and control coverage across
every stage of this lifecycle.

The cross-WG handoff that follows from this framing stays fixed: ARWG
defines what is named and measured, Observability defines trace mechanics,
Identity and Trust defines identity and trust-anchor standards, and Security
and Privacy defines controls for exposed or privileged contexts.



ewpage

