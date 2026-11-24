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
