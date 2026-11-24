# 2. Purpose and Audience

> Status: outline (carried over from the running notes)

**Primary audience:** enterprise practitioners responsible for evaluating, deploying, operating, governing, or adopting agentic systems, who need to translate current benchmark research into practical reliability and accuracy decisions inside their organizations.

One style could be reader personas (builders, evaluators/data scientists, product owners, operators/SREs, governance/risk teams, buyers/adopters) and the questions they need answered.

## Charter objectives

The charter asks D2 to survey the state of the art, identify which accuracy and reliability dimensions are underserved, and directly inform D4. This breaks down into four objectives:

1. **Assemble the landscape.** Map what enterprises can build on today, with emphasis on open source: agent frameworks and harnesses, protocols, runtimes and orchestrators, evaluation and observability tooling, standards, and benchmarks and leaderboards. Benchmarks are one lens on this landscape, not the whole survey.
2. **Identify underserved dimensions.** For each accuracy and reliability dimension (terms from D1), show what the landscape covers and where it does not, including gaps in how the pieces fit together (see §8 for gap categories).
3. **Prioritize for enterprise deployment.** Rank gaps by their impact on the enterprise use-case patterns (§4) and requirements (§5), and on whether open-source options can close them.
4. **Inform D4 and hand off the rest.** Give D4 the evidence it needs on evaluation dimensions and measurement, and route remaining gaps to D1, D3, D5, D6 and inter-WG liaison, or mark them out of scope (§9).

## Objectives

| Persona | Question |
|---|---|
| Builders | What should we test during design and integration? |
| Evaluators | Which benchmarks represent our use cases and evaluation subjects? |
| Product owners | What evidence demonstrates useful and reliable task completion? |
| Operators/SREs | How do we detect, verify, and recover from failures? |
| Governance teams | What evidence supports oversight and assurance? |
| Buyers/adopters | Which benchmark claims are relevant to our deployment? |
