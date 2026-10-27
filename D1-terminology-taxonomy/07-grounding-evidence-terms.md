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
