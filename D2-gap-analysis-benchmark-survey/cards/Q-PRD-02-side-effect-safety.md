# Q-PRD-02 · How do I make sure an agent's side effects happen exactly once when tools fail or time out?

**Stage:** Production · **Status:** partly · **Use cases:** UC-2 customer refund assistant (also UC-1) · **Patterns (§4):** Tool-Mediated Action, Long-Running Recoverable Workflow · **Requirements (§5):** concurrency and retry safety; safe retry/resume/rollback/compensation; outcome verification
**Pairs with:** Q-PRD-01 (durable execution) · **Author:** Jay Prajapat

## Challenge
A refund, cancellation or deployment can succeed while its response is lost (timeout, crash, pod loss). The agent then retries, so the action happens twice, or it reports failure for something that succeeded. The trajectory and the final answer look plausible; only the system of record shows the error.

Illustration (small, n=3 per mode, Google ADK + Gemini, one `issue_refund` tool): a failure *before* the refund was handled correctly in 3/3 runs. When the refund succeeded but its response was lost, the reply did not match reality in 3/3 runs and the refund was issued twice in 2/3. This is an illustration, not a benchmark.

## Landscape
- **Protocol:** MCP `ToolAnnotations` (`idempotentHint`, `destructiveHint`). They are hints only, and the defaults assume a tool is non-idempotent and destructive.
- **Practice:** idempotency keys and checking status before retrying, common in payment APIs.
- **Runtime:** durable execution engines; retry semantics differ per engine (see Q-PRD-01).
- **Evaluation:** fault injection in agent eval frameworks (for example ADK environment simulation, which injects faults *before* the tool runs); trajectory assertions (promptfoo, DeepEval); state-based benchmarks (τ²-bench database state checks, AgentDojo).
- **Guidance:** OWASP Top 10 for Agentic Applications 2026 mentions repeated actions only as cascade or cost symptoms.

## Today
Teams rely on tool-level idempotency where the backend offers it, and on manual review otherwise. Agent frameworks warn about repeated side effects on resume (for example LangGraph's interrupts docs) but leave handling to developers.

## Comparison
Complementary: protocol hints declare intent, durable engines decide when to retry, idempotency keys make retries safe, state-based evaluation verifies the outcome. No single layer covers the problem.

## Gaps
| Gap | Type (§8) | Layer |
|---|---|---|
| No eval tooling surveyed can inject a failure *after* the side effect or assert "this happened exactly once" | Coverage | Evaluation |
| `idempotentHint` exists, but client and framework retry behaviour is not specified or testable | Standardization / Adoption | Protocol |
| Idempotency conventions for agent tools are ad hoc per backend | Standardization | Practice |
| Whether the outcome the agent *reports* matches the *actual* outcome is not a standard metric | Observability | Evaluation |

## Next
- **D3:** a "side-effect-safe tools" pattern (idempotency keys, status check before retry, compensation).
- **D4:** outcome-consistency and exactly-once metrics.
- **D5:** compensation and escalation when duplicates occur.
- **External:** input to the MCP Tool Annotations interest group. Possible link with the Attestation & Evidence group on reported vs actual outcomes.

## Requirements and checks
- **REQ-A:** at most one side effect per user intent under retries and resumes.
- **REQ-B:** the outcome reported to the user matches the system of record.
- **TEST-A:** inject a failure *after* the tool commits; assert side-effect count = 1.
- **TEST-B:** compare the agent's final message with the ledger; flag mismatches.
- **TEST-C** (with Q-PRD-01): kill the worker mid-tool-call, resume, assert no duplicate.

## Sources
- MCP specification 2026-07-28, `ToolAnnotations` schema; MCP blog, "Tool Annotations as Risk Vocabulary" (Mar 2026)
- OWASP Top 10 for Agentic Applications 2026
- LangGraph documentation, interrupts
- τ²-bench evaluation documentation
- Retry experiment write-up (author; available on request)
