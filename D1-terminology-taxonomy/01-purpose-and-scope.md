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
