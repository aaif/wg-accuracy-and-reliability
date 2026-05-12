# Agentic AI Foundation Working Group Charter - Accuracy & Reliability

## Working Group Name

**Working Group Name:** Accuracy & Reliability  
**Short Name / Acronym:** ARWG  
**Date Approved:**   
**Last Updated:** 2026-04-14  
**Homepage / Repo (if applicable):** https://github.com/aaif/wg-accuracy-and-reliability  
**Primary Contact (Chair/Lead):** Jordan Augé (Cisco) <augjorda@cisco.com>

## Purpose and Mission

### Mission Statement

The Accuracy & Reliability Working Group advances the Agentic AI Foundation's mission by establishing the standards, benchmarks, and engineering practices required for AI agents to operate accurately and reliably under real-world enterprise conditions.

### Why this Working Group exists

This Working Group was formed to address the gap in understanding, measuring, and responding to failures of reliability and accuracy in agentic systems. Agentic workloads are non-deterministic, yet most practitioners operate without visibility into whether their systems meet their quality requirements. This WG focuses on a tractable core: classifying the broad categories of failure — what can be controlled, where resilience mechanisms apply, and where human intervention is required — and providing shared definitions and recommendations for how to address each, both proactively and reactively. 

### Strategic Objectives

- **Shared understanding:** Establish what reliability and accuracy mean in the context of agentic systems, including a shared vocabulary and taxonomy that the wider ecosystem can adopt.
- **Measurement and detection:** Provide reference approaches for measuring reliability and accuracy, and for detecting drift or degradation in deployed systems.
- **Correction patterns:** Document categories of corrective action available when failures occur, including what can be addressed autonomously, what requires resilience mechanisms, and what requires human intervention.
- **Design guidance:** Produce guidance that helps practitioners build agentic systems with reliability and accuracy as first-class properties from the start.

### Guiding principles

- **Reliability and accuracy by design**: We prioritize approaches that prevent failures at the design phase rather than patching them reactively.
- **Grounding recommendations**: Prescriptions are informed by clear definitions and observable evidence. We aim to define what reliability and accuracy mean before recommending how to achieve them, recognising that definitions and practices will co-evolve.
- **Vendor neutrality**: Standards, taxonomies, and reference implementations remain independent of specific model providers, agentic frameworks, or cloud platforms.
- **Transparency as a prerequisite**: Reliability cannot be assessed without visibility. We define what outcomes the observability layer must capture; the mechanics of trace emission are delegated to the Observability WG.


## Scope

### In Scope (technical areas)

 - **Accuracy & Reliability Frameworks**: Defining the dimensions and metrics for agent accuracy and reliability, classifying the failure modes that threaten them, the evaluation techniques for measuring them, and the quality thresholds required for formal performance standards in autonomous systems.
- ** Reliable Architecture Patterns**: Defining proactive structural requirements, such as verification loops and grounding to authoritative data sources, to ensure agent reasoning remains aligned with authoritative data.
- **Recovery and Corrective Actions**: Standardizing the specifications for safe-state restoration, rollback mechanisms, and automated compensatory actions, as well as the triggers and handoff requirements for human intervention.


### Out of Scope (what the WG will not do)

- **Model internals and training**: The WG evaluates agents or multi-agent systems as a whole, not the underlying models. It does not address foundation model training, fine-tuning, or prompt engineering.
- **Trace and log emission standards**: We define what reliability and accuracy signals and outcomes should be observable; how to emit traces and logs is delegated to the Observability WG.
- **Production tooling and platforms**: We produce standards and blueprints, not production-grade recovery platforms or commercial guardrail software.
- **Domain-specific regulatory compliance**: We provide technical frameworks for accuracy and reliability; we do not prescribe legal or compliance policy for specific industries or jurisdictions.
- **Runtime and orchestrator development**: We define standards for how runtimes and orchestrators should handle failure and ensure accuracy and reliability in agents or multi-agent systems; we do not develop or maintain production runtimes.

### Assumptions and Dependencies

- **Assumptions:** [e.g., “Upstream projects will provide X interface”]
    - **Operational Predictability:** Enterprise users require reliable execution of autonomous systems. We assume agent frameworks will adopt standardized "hooks" for state recovery and trajectory management.
    - **Immutable Agent Identity:** We assume the adoption of standards for uniquely identifying agent instances. Reliability and auditability depend on the ability to uniquely identify the subject of an evaluation across different versions and environments.
    - **Versioning for Reproducibility:** We assume that agent configurations—including models, prompts, and tool-sets—are versioned. Accuracy and reliability metrics are only valid when tied to a specific, "frozen" state of the agent system.
    - **Availability of Trust Anchors:** We assume that high-stakes tasks has an authoritative Trust Anchor or system of record against which an agent’s output can be systematically verified.


- **Identity & Trust WG**: Agent identity standards produced by this WG are a prerequisite for reliable auditability; ARWG will express its requirements and consume its outputs.
- **Observability WG**: ARWG defines what reliability and accuracy signals must be captured; how those signals are emitted is the Observability WG's domain.
- **Security & Privacy WG**: Security controls defined by this WG underpin the trustworthiness of agent execution. Trusted anchors for agent identity, benchmark data, and evaluation results all depend on integrity guarantees this WG provides.
- **Peer AAIF working groups**: Shared terminology, cross-WG deliverable alignment, and handoffs for topics outside ARWG scope.

## Goals, Deliverables, and Success Criteria


### Planned Deliverables

For each deliverable, define owner, format, and target date.
Deliverable types, versioning schemes, and review processes are defined in §11.

#### Phase 1: Foundation (0–3 Months)

**D1. Reliability & Accuracy Taxonomy**
Formal classification of terminology and boundaries, including failure term taxonomy and shared vocabulary for consistency and robustness.  
Living document - Owner: TODO - Format: TODO - Target date: TODO

**D2. Liaison & Dependency Map [Inter-WG]**
Identification of cross-WG touchpoints and assigned liaison roles to ensure interoperability and prevent technical overlap.  
Living document - Owner: TODO - Format: TODO - Target date: TODO

#### Phase 2: Strategy & Best Practices (3–6 Months)

**D3. Gap Analysis and Accuracy Benchmark Survey**  
Research report mapping enterprise requirements against existing industry benchmarks to identify coverage gaps — specifically which accuracy dimensions and reliability scenarios are underserved by current benchmarks. The findings of D3 directly inform the scope of D6.  
Report/Whitepaper - Owner: TODO - Format: TODO - Target date: TODO

**D4. Canonical Whitepaper: Accuracy & Reliability in Agentic Systems**  
The foundational positioning paper, covering evaluation dimensions, measurement techniques, quality threshold frameworks, and test dataset design principles alongside proactive reliability patterns.  
Report/Whitepaper - Owner: TODO - Format: TODO - Target date: TODO

**D5. Reliability-by-Design Best Practices Guide**  
Practical translation of taxonomy into architectural patterns, focusing on verification loops, proactive grounding, and delegation controls.  
Report/Whitepaper - Owner: TODO - Format: TODO - Target date: TODO


#### Phase 3: Implementation & Validation (6 Months+)

**D6. Agent Output Quality Standard: Evaluation Protocol and Metric Specification**  
Normative standard produced in response to the gaps identified in D3 — directly addressing the absence of an industry standard for measuring agent output quality identified in §2. Defines measurement techniques for both accuracy and reliability dimensions, with baseline quality thresholds required for enterprise deployment.  
Agent Evaluation Playbook: step-by-step guidance on running an evaluation campaign, selecting fault scenarios, interpreting accuracy and reliability results across dimensions, and reporting findings in a format compatible with D6 thresholds. Covers both automated benchmark scoring and user-perceived reliability signals.  
Specification - Owner: TODO - Format: TODO - Target date: TODO

**D7. Trust Anchors and Grounding Guide [Inter-WG]**  
Defining evidence requirements and entity resolution protocols that interface with observability and data standards.  
Specification - Owner: TODO - Format: TODO - Target date: TODO

**D8. Agent SLA and Failure Signaling Specification**  
Standardized framework for reporting quality-of-service claims, reliability signals, and failure alerts to orchestrators and human operators — including HITL escalation triggers, state-handoff formats, and human feedback signals (task completion validation, re-prompt events) as first-class reliability inputs.  
Specification - Owner: TODO - Format: TODO - Target date: TODO  

**D9. Recovery Reference Implementation**  
Code-based reference implementation demonstrating standardized recovery hooks, state restoration, and automated compensation patterns.  
Reference Implementation - Owner: TODO - Format: TODO - Target date: TODO  

**D10. Conformance Test Suite**  
Validation artifacts to test whether systems meet the defined protocol and signaling requirements, and the technical foundation for the ARWG Reliability Conformance Mark — including pass/fail criteria, coverage requirements across accuracy and reliability dimensions, and self-certification guidance.  
Specification - Owner: TODO - Format: TODO - Target date: TODO  

**D11. Benchmark and Leaderboard**  
Ecosystem artifact for comparing systems consistently across defined tasks and reliability dimensions.  
Deliverable types, versioning schemes, and review processes are defined in §11. Internal documents (I-series) are working artifacts not intended for public publication.

#### Phase 1 — Foundation (0–3 months)

- **D1. Terminology, Taxonomy & Failure Mode Classification** *(Living Document)*
  Shared vocabulary for accuracy and reliability in agentic systems. Includes a structured classification of agent-specific failure modes — distinguishing what can be controlled, where resilience applies, and where human intervention is required — and explicit boundaries defining what is and is not within scope of evaluation.

- **D2. Gap Analysis and Benchmark Survey** *(Report)*
  Survey of existing benchmarks and state of the art, identifying which accuracy and reliability dimensions are underserved. Directly informs D4.

- **I1. Inter-WG Coordination Specification** *(Internal Living Document)*
  ARWG requirements on adjacent WGs (Identity & Trust, Observability, Security & Privacy), liaison assignments, shared interface contracts, and boundary decisions on failure modes that span multiple WGs.

#### Phase 2 — Best Practices (3–6 months)

- **D3. Reliability-by-Design Best Practices Guide** *(Report)*
  Practical architectural patterns for building agents and multi-agent systems where reliability and accuracy are first-class properties, including verification loops and grounding practices.

- **D4. Agent Output Quality Standard** *(Specification)*
  Normative specification defining evaluation dimensions, measurement techniques, and quality thresholds for assessing the accuracy and reliability of agents and multi-agent systems.

#### Phase 3 — Normative Standards (6 months+, speculative)

> The following deliverables represent the WG's longer-term ambitions. Scope, format, and priority will be refined based on progress in Phases 1 and 2.

- **D5. Corrective Action Framework** *(Specification)*
  Categories of response to accuracy and reliability failures — what can be addressed autonomously, where resilience patterns apply, and when human intervention is required — with handoff and signaling requirements for each.

- **D6. Evaluation and Conformance Guidance** *(Specification)*
  Criteria and methodology for assessing whether agents or multi-agent systems meet the quality thresholds defined in D4, including self-assessment guidance.

### Definition of Done (DoD)

A deliverable is considered complete only when it meets the following criteria:
- Technical Feasibility & Implementation: For specifications and "Recovery Hooks," at least one Reference Implementation or a formal set of conformance tests must be provided to demonstrate practical application in a multi-agent environment.
- Proactive & Reactive Validation: Architectural guidelines must explicitly address both Proactive Design (prevention/grounding) and Reactive Recovery (mitigation/restoration) to ensure holistic reliability.
- Identity & Anchor Verification: Any specification involving entity resolution or grounding must demonstrate compatibility with at least one external Trust Anchor and a versioned Agent Identity schema.
- Inter-WG Alignment: Deliverables impacting telemetry, metadata, or risk must receive a "no-conflict" sign-off from the Observability or Security & Privacy Working Groups to ensure Foundation-wide interoperability.
- Consensus-Based Approval: The artifact must be reviewed and approved via the WG’s consensus process, including a minimum 2-week open comment period for all ARWG members.
- Open Accessibility: Final versions must be published in the WG’s official repository or website with a clear versioning history and vendor-neutral licensing (e.g., Apache 2.0 or Creative Commons).
- User Perspective Validation: Each deliverable must explicitly address both the system perspective (does the agent produce correct, reliable results?) and the user perspective (do users experience the agent as reliable — would they re-prompt, override, or abandon the task?). For specifications, this means including at least one user-observable reliability signal or user-facing quality criterion. For guidance documents, this means including evaluation scenarios that capture user-perceived accuracy, not only automated benchmark scores.


### Success Metrics (KPIs) (pick a small set)
- **Adoption:** [e.g., number of downstream projects implementing spec]
- **Quality:** [e.g., passing conformance suite, security review completed]
- **Community:** [e.g., active contributors, meeting attendance, issue throughput]
- **Timeliness:** [e.g., % milestones met]
- **Adoption (Integration Readiness):** Completion of a "Framework Integration Kit" for the ARWG Taxonomy, providing ready-to-use mapping files for at least the set of identified agent frameworks to ensure the spec is "adoptable" on day one.
- **Quality (Validation):** All Phase 3 specifications must be accompanied by a Reference Implementation or Conformance Test Suite that passes a peer-reviewed technical gate, ensuring the standards are practically viable.
- **Community (Diversity):** Maintaining a contributor base representing at least five distinct organizations, ensuring the work represents a broad technical consensus rather than a single vendor's viewpoint.
- **Adoption:** Number of references to ARWG deliverables in other WGs, projects, or external publications. This could be supported by the release of a "Framework Integration Kit" for the ARWG outcomes, providing ready-to-use material for a set of identified agent frameworks.
- **Quality:** Deliverables meet DoD criteria; Phase 3 specifications validated by at least one reference implementation or conformance test.
- **Community:** Active contributors from at least five distinct organizations; sustained meeting participation.
- **Timeliness:** % of milestones delivered on schedule across phases.

## Working Methods

### Operating Model

**Decision-making:** Consensus-driven, with chair-led resolution. If consensus cannot be reached, a formal vote will be triggered as per the Agentic AI Foundation’s fallback bylaws to ensure progress is not stalled.  
**Work Tracking:** All technical work, taxonomy updates, and deliverable drafts are tracked in the ARWG GitHub repository under the AAIF organization using the issue tracker and pull request (PR) process.  
**Primary Artifacts:** Specifications, "Reliability-by-Design" guidance documents, landscape surveys, reference implementation "hooks" (SDKs), and conformance test suites for agent accuracy.

### Meetings

**Cadence:** Biweekly (alternating Tuesdays, as established in Feb/Mar notes)  
**Duration:** 60 minutes  
**Time Zone Considerations:** Alternating morning/afternoon (PT/ET/CET) to accommodate global contributors  
**Open Meetings:** Yes  
**Recordings:** Recorded and published to the AAIF member portal (participants are notified at the start of each session)  
**Minutes/Notes:** AI-generated notes are associated to meeting recordings

### Communication Channels

- **Async:**
    - **Discussions:** GitHub Discussions for deep-dive technical taxonomy threads; Discord/Slack for out-of-band interactions
    - **Documents:** Shared Google Drive for initial drafting, then ARGW github repository.
    - **Email:** wg-accuracy-reliability@lists.aaif.io
- **Sync:** Zoom (link provided via calendar invite to all members)
- **Announcements:** Distributed via the mailing list and the #wg-accuracy-reliability channel in the AAIF Slack/Discord.

## Membership and Participation

### Who can participate

Participation is open to all individuals and organizations consistent with foundation policies.

### Member Roles

**Participants:** Anyone attending meetings or contributing asynchronously.  
**Contributors:** Individuals making substantive contributions (issues, PRs, documents, reviews).  
**Maintainers/Approvers:** Chair and co-chair of the WG..  
**Chairs/Co-Chairs:** Responsible for WG operations, facilitation, and external representation.  

### Joining

- Subscribe to the WG's communication channel(s).  
- Attend at least one meeting or make an asynchronous contribution.  
- Sign the DCO/CLA as required by AAIF policy.  

### Expectations

- Follow the Code of Conduct and collaboration norms.  
- Make contributions in the open (issues, PRs, meeting discussions) whenever possible.  
- Declare conflicts of interest when relevant, particularly when advocating for approaches that benefit a specific product or organization.

## Governance and Decision-Making

### Leadership Structure

**Chair(s):** Jordan Augé (Cisco)
**Co-Chair(s):** Casper Nielsen (Diagrid)

### Selection and Term

**Chairs are selected by:** Election among Contributors, confirmed by the AAIF Technical Committee.  
**Term Length:** 1 year  
**Renewal:** Allowed, maximum 2 consecutive terms.  
**Removal/Resignation:** A chair may resign at any time. Removal requires a supermajority (2/3) vote of Contributors, or action by the AAIF Technical Committee.  

### Decision Process

**Default method:** Rough consensus documented in issues and meeting notes.  
**When consensus cannot be reached:**  
    - **Escalation path:** AAIF Technical Committee.  
    - **Fallback vote rules:**  Quorum of 1/3 of eligible Contributors (defined as those who have been active in the last 6 months), simple majority to pass. One vote per organization to prevent stacking.

### Quorum (if voting is used)

Quorum is met when 1/3 of eligible Contributors (active in the last 6 months) are present or have responded asynchronously within the voting period (minimum 7 days for async votes).

## Relationship to Other Groups

### Internal Coordination

**AAIF Technical Committee:** WG reports to the TC; major deliverables require TC review.  
**Liaison(s) to other WGs:** (importance, name/role)
- Identity and trust WG (high) - Brian Malone (BrightQuery), Matthew Khouzam (Ericsson)
    - Input to ARWG: Agent identity schemas, versioning standards, and delegation lineage models that ARWG deliverables depend on for attribution and audit.
    - Output from ARWG: Reliability metadata requirements — what fields an agent identity schema must carry to support accuracy measurement, failure attribution, and reproducibility.
- Observability & Traceability WG (high) - Robert Kirkum (Apollo GraphQL), Casper Nielsen (Diagrid), Sivapriya Vellaichamy (JP Morgan), Matthew Khouzam (Ericsson)
    - v: Trace Context propagation standards carrying Agent ID and version through multi-step trajectories, enabling ARWG to pinpoint which agent version produced which outcome.
    - Output from ARWG: Specification of which reliability and accuracy outcomes agent traces must capture — the measurement requirements that the observability layer must support.
- Security & Privacy WG (high) - Matthew Khouzam (Ericsson)
    - Input to ARWG: Cryptographic verification mechanisms for Trust Anchors and evidence sources, ensuring grounding data has not been tampered with; privacy controls for sensitive content in agent traces.
    - Output from ARWG: Privacy requirements for trajectory snapshots and state restoration artifacts; abuse case documentation for reliability features that could expose sensitive behavioral data.
- Governance, Risk & Regulatory Alignment WG (medium) - Liaison not defined
    - Input to ARWG: Regulatory vocabulary and compliance frameworks (EU AI Act, NIST AI RMF) that enterprise adopters must satisfy; risk classification models for agentic systems.
    - Output from ARWG: Canonical accuracy and reliability terminology usable in regulatory filings and compliance documentation; quality threshold frameworks applicable to regulated deployments.
- Workflows & Process integration WG (medium) - Rahul Vishwakarma (Hitachi)
    - Input to ARWG: Workflow orchestration patterns and enterprise process integration requirements that recovery and compensation logic must be compatible with.
    - Output from ARWG: SLA signaling specification and failure state formats that orchestrators can natively consume; HITL escalation trigger standards for workflow handoff.
- Agentic commerce WG (low) - Prasad Wangikar (Stripe), Brian Malone (BrightQuery)
    - Input to ARWG: High-stakes transactional use cases and enterprise quality bar requirements for mission-critical agentic deployments, informing D3 gap analysis.
    - Output from ARWG: Accuracy and reliability measurement standards applicable to commercial agentic transactions; conformance criteria relevant to transactional accountability.

### Shared deliverables/dependencies

Cross-WG dependencies and touchpoints are tracked in D2 (Liaison & Dependency Map), maintained as a living document and updated through regular offline alignment with liaison representatives from each WG.

### External Coordination

#### Standard bodies / Upstream projects

Those bodies should serve as a reference for potential overlapping terminology.

| External Group | Relationship |
|---|---|
| OpenTelemetry GenAI SIG | Primary technical boundary. ARWG defines what reliability outcomes agent traces must capture; OTel defines how to emit them. Formal liaison to be named. |
| W3C PROV | Foundational provenance standard. ARWG deliverables on traceability and lineage must be compatible with the W3C PROV data model. |
| FINOS / Open Banking | Coordinate on entity resolution and authoritative identifier standards for grounding (D7). |
| NIST AI RMF / EU AI Act | Terminology alignment on trustworthiness, safety, and accountability to ensure ARWG standards are applicable in regulated enterprise contexts. |
| OWASP Agentic Security | Coordinate on failure modes at the intersection of reliability and security — prompt injection, tool tampering, and grounding integrity. |

**Policy for external representation:** Chairs may speak on behalf of the WG by default. The WG may nominate members by vote to represent the WG's interests in external groups they already participate in. Technical opinions expressed by individual members outside of this role are their own.

## Intellectual Property, Licensing, and Compliance

### Licensing

**Code contributions:** Apache-2.0 or MIT (per repository license as approved by AAIF). 
**Documentation and specifications:** CC-BY-4.0 (or per repository license as approved by AAIF).

### Contribution Requirements

- AAIF DCO/CLA policy.
- Repository contribution guidelines.
- Review requirements (minimum one approving review from a Maintainer).

### Antitrust and Competition Law

- Meetings and communications must follow the Linux Foundation's antitrust guidelines.
- Avoid discussions of pricing, market allocation, competitive strategy, or other restricted topics.
- Deliverables must be vendor-neutral and not advantage any single member organization's products.

### Code of Conduct

This WG adheres to the Linux Foundation Project’s Code of Conduct.

## Security, Safety, and Responsible AI (Agentic AI-Specific)

### Security Practices

**Threat modeling:** Required for any specification that defines data formats containing potentially sensitive content (e.g., agent prompts, tool call arguments, user data).  
**Vulnerability disclosure:** Follow AAIF's vulnerability disclosure process. [TBD: link]  
**Security review gates for releases:** Specifications that touch data capture or transmission must undergo security review before publication.: [e.g., dependency scanning, SAST, SBOM]

### Agentic Safety and Risk Management

**Safety by Design:** Specifications must include guidance on autonomy bounds—defining explicit "stop conditions" or guardrails where an agent must halt and request human intervention rather than attempting a risky recovery.  
**Tool Access Control & Verification:** WG deliverables will emphasize that reliability is tied to safety; agents must verify the integrity of Trust Anchors and tools before execution to prevent prompt injection or "man-in-the-middle" data corruption.  
**Red Teaming for Reliability:** Recommended practices include using evaluation harnesses that simulate environmental perturbations (e.g., API downtime, ambiguous inputs) to test the robustness of recovery logic.  
**Abuse Case Documentation:** Specifications must consider how reliability features (like trajectory snapshots) could be misused to reconstruct sensitive interactions or bypass security controls, and include appropriate mitigations.
Privacy  
**Data Handling in Recovery:** Specifications must provide guidance on managing personal data within trajectory snapshots and state restoration files, emphasizing data minimization, automated redaction, and granular retention policies.  
**Privacy-Preserving Grounding:** When utilizing external Trust Anchors for entity resolution, guidance must ensure that grounding queries do not leak sensitive organizational or individual context to external providers.  
**Logging and Telemetry Guidelines:** WG deliverables will define the distinction between "Standard Operational Metadata" (captured by default) and "Sensitive Content" (e.g., full input/output history), which requires explicit opt-in, encryption, and access controls.

## Deliverable Lifecycle and Publication

### Living document

**Description:** Continuously maintained artifact reflecting the current state of knowledge — taxonomies, landscape surveys, liaison maps, and leaderboards. Not a snapshot; intended to evolve with the ecosystem.  
**Versioning:** Date-stamped (YYYY-MM-DD). No semantic versioning. Each published update replaces the prior version in place with a visible revision date.  
**Review process:** Changes merged by WG consensus via pull request. Formal quarterly review by the full WG to assess currency. Deprecated by WG consensus when superseded or no longer maintained.  

### Report or whitepaper

**Description:** Point-in-time artifact capturing analysis, positioning, or guidance — gap analyses, benchmark surveys, best practices guides, and positioning papers. Published once; not updated in place.  
**Versioning:** Date-versioned (YYYY-MM-DD) at publication. Superseded by a new report when the content is no longer current; the original is archived, not modified.  
**Review process:** Minimum two-week WG review period. Approval by WG consensus. No public comment period required, but chairs may open one at their discretion for high-impact reports.

### Specification

**Description:** Normative artifact defining requirements, protocols, or measurement standards that downstream implementers must conform to — evaluation protocols, SLA signaling formats, grounding standards, and conformance criteria.  
**Versioning:** Semantic Versioning (Major.Minor.Patch). Patch: editorial corrections that do not change normative requirements. Minor: additive normative content that does not break existing implementations. Major: breaking changes to normative requirements, requiring a new public comment period.  
**Review process:** Minimum two-week internal WG review, followed by a thirty-day public comment period open to all AAIF members before ratification. Breaking changes (major version) restart the full process. At least two Maintainer approvals required before ratification.

### Reference implementation

**Description:** Code artifact demonstrating that a specification is practically implementable — recovery hooks, state restoration patterns, or conformance test harnesses. Normative only insofar as it demonstrates spec feasibility; implementations may deviate in non-normative respects.  
**Versioning:** Semantic Versioning aligned with the specification it implements. A reference implementation must declare which specification version it targets.  
**Review process:** Peer-reviewed technical gate: the implementation must pass the corresponding conformance test suite and include a mapping from each normative requirement to the implementing code. At least one Maintainer approval required. Security review required before release if the implementation handles agent data or network communication.

### Archival / Deprecation

**Deprecation policy:** A deliverable may be deprecated by WG consensus when it is superseded by superior technical patterns, rendered unnecessary by upstream standards adoption (e.g., from CNCF or W3C), or is no longer functionally maintained.  
**Sunset criteria:** If a specification or reference implementation has no active maintainer and has received no substantive updates for 12 months, the WG chairs will initiate a review for potential archival or transfer to "Experimental" status.

## Resources and Budget (Optional)

**Infrastructure:** GitHub repository for specification tracking, CI/CD pipelines for validating reference implementation "hooks," and static site hosting (GitHub Pages) for the "Reliability-by-Design" guidance documents.  
**Sponsor engagement:** Member organizations (specifically Platinum and Gold) are encouraged to contribute dedicated engineering time for developing the Reference Implementation SDKs and maintaining the Reliability Taxonomy.

## Amendments

This charter may be amended by:
- Consensus of the Working Group, with a minimum 2-week notice period.
- Amendments are documented in the WG repository.
- Substantive changes to scope or governance require AAIF Technical Committee approval.

## Ratification

By approving this charter, the Working Group commits to operating transparently, in the open, and in alignment with foundation policies.
  
**Approved By:** [TOC / Governing Board / Steering Committee]  
**Date:** [YYYY-MM-DD]  
**Signatories (optional):** [Names/Titles]

## Optional Appendix A: Role Descriptions

### Chair/Co-Chair

Runs meetings, sets agendas, ensures notes are published, drives milestones, represents the WG in cross-WG and external coordination, and ensures the WG operates within its charter.

### Maintainer/Approver

Responsible for repository health, reviews and merges contributions, ensures release readiness, and provides technical direction on deliverables within their area.

### Contributor

Provides substantive work items (PRs, documents, issues, reviews), participates in discussions, and helps shape WG deliverables through active engagement.
