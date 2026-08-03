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
