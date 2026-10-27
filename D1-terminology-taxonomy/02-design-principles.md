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
