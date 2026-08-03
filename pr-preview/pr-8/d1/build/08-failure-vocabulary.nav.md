[Back to D1 index](../index.html) | [ToC](../toc.html) | [Single page](../d1-single-page.html)

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
