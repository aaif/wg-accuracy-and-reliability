# 4. Enterprise Use Cases → Patterns

> Status: outline (carried over from the running notes)

Group use cases by enterprise business task, not industry. Candidate families: knowledge retrieval and synthesis, document processing and review, customer or employee support, software engineering and CI/CD, business operations workflows, risk/compliance/audit, incident response and remediation, and procurement/vendor/entity review.

## Patterns

- **Knowledge and Evidence:** retrieving, synthesizing, and citing information for business tasks like research, support, and procurement review.
- **Artifact Generation and Review:** creating or assessing documents, code changes, or structured outputs for tasks such as document processing, compliance review, and CI/CD.
- **Decision Support:** analyzing evidence to recommend actions to humans during risk assessments, audits, and entity reviews.
- **Tool-Mediated Action:** executing actions that alter external states for business operations, remediation, and software operations.
- **Delegated Multi-Agent Workflow:** transferring work, context, and responsibility between agents for complex support, investigations, and multi-step automation.
- **Long-Running Recoverable Workflow:** maintaining state, verifying outcomes, and recovering from interruptions during incident responses, approval workflows, and remediation.

## Pattern template

Intended outcome · Evaluation subject(s) · Tools, data, and actors · Acceptance criteria or trust anchor · Main failure conditions · User-visible consequences

Examples so far: lost context, incorrect delegation, duplicate actions, concurrent writes, partial effects, and unverified outcomes.

## Gaps impacting enterprise use cases

One of the gaps companies must tackle to properly test the accuracy and reliability of their agentic solutions is reconciling the consumer and producer points of view on those concepts. With today's testing environments, there is no way to unify the viewpoints of consumers (typically users prompting agents, or agents interacting with other agents) and producers (the AI system) on accuracy and reliability of generated content. Developers of agentic solutions have all faced agents confidently claiming outcomes that they could easily show to be inaccurate.

Since the business objective of agentic providers is to improve trust between consumers and producers, companies must develop frameworks to reduce this gap. Based on experience with conversational agents for professional software users in a B2B setting, user trust in AI is task/topic specific and built or lost over time. While it depends on the accuracy and reliability of the underlying solution, it also heavily depends on:

1. **Use-case type:** assessment depends on how the produced content will be used: *explain this to me*, *show this to me*, or *do this for me*.
2. **Task risk profile:** what is the business implication of poor advice if the user acts on it?
3. **User profile:** is the user a novice or an expert on the topic?
4. **History of consumer-producer interactions** on this topic and use-case type: is there evidence the user trusted the AI on it?
5. The ability to reconcile the different data and tool contexts with which consumer and producer measure the validity of accuracy and reliability claims.

Companies therefore need analytics frameworks that quantify gaps between consumer and producer quality measures. Users are less likely to engage with AI when the gap between the two perspectives is high, regardless of the producer's scores. Testing therefore needs both benchmarks against set quality metrics and measurement of content delivery in the context of the user's environment.
