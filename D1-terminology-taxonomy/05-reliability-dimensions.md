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
