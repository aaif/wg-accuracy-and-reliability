# 8. Key Gaps for Enterprise Deployment

> Status: outline (carried over from the running notes)

Synthesize the coverage matrix into the gaps that matter most for enterprise deployment. Rank gaps by enterprise impact, coverage weakness, likelihood in real deployments, feasibility of measurement, and ARWG actionability.

## Gap categories

| Gap | Meaning | 10 Nov slides type |
|---|---|---|
| Coverage | No suitable evaluation exists | missing |
| Depth | Only simplified or nominal cases are tested | partial |
| Transfer | Component results do not predict system or production behavior | fragmented |
| Continuity | Evidence cannot be carried between lifecycle stages | discontinuous |
| Observability | The required outcome cannot be measured in production | unmeasurable |
| Feedback | Production failures do not become regression tests | discontinuous (production to test) |
| Standardization | Existing methods are not comparable | fragmented |
| Adoption | A method exists but is impractical for enterprises | unadopted |

> **Open question:** the 10 Nov slides use a second gap vocabulary (missing, partial, fragmented, discontinuous, unmeasurable, unadopted); the third column maps the categories above onto it. Merge the two into one list, ideally defined in D1.
