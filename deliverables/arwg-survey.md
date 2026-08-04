# ARWG Agent Adoption, Accuracy & Reliability Survey

This is the platform-neutral review source for the Accuracy & Reliability Working Group survey. It records the agreed 15-question survey and the behavior a fielded survey must preserve, independent of implementation platform.

## Review status

- The question stems, answer choices, factor rows, and ordered scales below reproduce the locked baseline.
- Reviewers should flag unclear wording, missing response paths, analytical problems, or implementation risks in line comments. Proposed content changes should be discussed explicitly rather than silently incorporated.
- Survey-platform selection, privacy and aggregation language, analysis procedures, and deployment configuration are outside this document's current scope.

## Reading the response specifications

- **Single select:** exactly one listed answer may be selected.
- **Multi-select:** one or more listed answers may be selected unless an exclusive choice is specified.
- **Single-response matrix:** exactly one scale answer is selected for each factor row.
- **Inline text:** a short text field appears beside the answer choice and is required only when that choice is selected.
- **Display order:** fixed as listed in this survey. Any later randomization must preserve ordered scales and the placement of terminal choices such as “None,” “Something else,” and “Not sure.”

## Focal-system instruction

For the rest of this survey, think of the AI agent system that reached a serious pilot or deployment and that you personally worked with most during the past six months. If two qualify equally, choose the one you worked with most recently. Answer every question about that same system.

## Entry and anchor

### Q1 — Direct activities

- **Response:** Multi-select
- **Required:** Yes
- **Behavior:** “None of these” is exclusive. Selecting it and continuing ends the survey and records the response as screened out rather than incomplete.

**Which activities have you personally performed with this system during the past six months? Select all that apply.**

- Designed, built, configured, or integrated it
- Tested or evaluated its quality
- Deployed, operated, monitored, or investigated it
- Reviewed, corrected, or approved its outputs or actions
- Used its outputs or relied on its actions in my work
- Made product or operational decisions using firsthand evidence about it
- None of these

### Q2 — Real-world use

- **Response:** Single select
- **Required:** Yes

**When you last worked with this system, how widely was it being used for real work?**

- Serious pilot — being tried with real data or intended users, but not yet part of normal work
- Limited deployment — part of normal work for some intended users or workflows
- Broad deployment — part of normal work for most intended users or workflows
- Paused or retired after reaching a serious pilot or deployment
- Not sure

### Q3 — Primary area of work

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else—describe briefly” is selected.

**When you last worked with this system, which area of work was its primary use? Choose the closest answer.**

- Customer or employee service
- Research and knowledge work
- Content and creative work
- Software engineering or IT operations
- Data, document, or administrative processing
- Analysis, planning, or decision support
- Risk, compliance, quality, or evaluation
- Business operations or transactions
- Something else—describe briefly
- Not sure

## Adoption and general concerns

### Q4 — Constraints

- **Response:** Single-response matrix
- **Required:** Yes; one response for every factor row
- **Row order:** Fixed as listed
- **Scale order:** Fixed as listed

**During the past six months, how much did each factor limit progress or expansion of this system?**

Factors:

- Unclear value or fit with the intended work
- Financial or computing cost of building and running the system
- Response time or ability to handle the required volume
- Access to or integration with required data, tools, or systems
- Security, privacy, legal, or compliance requirements
- Gaps in staffing, skills, or operational ownership
- Low user trust or willingness to adopt
- The system’s results or actions were not accurate or useful enough
- The system did not behave reliably across repeated use or changing conditions
- Insufficient evidence to determine or demonstrate whether the system worked well enough

Scale:

1. Not a limitation
2. Present, but did not slow progress
3. Slowed progress somewhat
4. Slowed progress substantially
5. Stopped or reversed progress
6. Not enough visibility

### Q5 — Adoption consequence

- **Response:** Single select
- **Required:** Yes
- **Scale order:** Fixed as listed

**During the past six months, what was the most significant effect these constraints had on adoption or continued use of the system?**

- No meaningful effect
- Work continued, but required additional effort, safeguards, or human checking
- Launch, expansion, or planned improvements were delayed
- Planned users, use cases, capabilities, or autonomy were reduced
- Development, expansion, or use was paused but may resume
- The system or affected use case was stopped or abandoned
- Not enough visibility

### Q6 — Human checking

- **Response:** Single select
- **Required:** Yes
- **Display order:** Fixed as listed

**During the past six months, which best describes how meaningful human checking was applied to this system’s outputs or actions before they were relied on or allowed to stand?**

- No routine human checking
- Occasional spot checks
- Checking mainly when the system flags uncertainty
- Checking mainly for high-risk cases
- Most or all outputs received a substantive review
- Practices varied too much to identify one pattern
- Not enough visibility

### Q7 — Most significant benefit

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else—describe briefly” is selected.

**During the past six months, what was the most significant benefit this system delivered in real work?**

- Completed roughly the same work faster or with less effort
- Handled more work, cases, or users
- Improved the quality or consistency of work
- Enabled work that was previously impractical or impossible
- Improved responsiveness or availability
- Produced no meaningful additional benefit
- Too early to tell
- Something else—describe briefly
- Not enough visibility

## Accuracy and reliability

### Q8 — Frequency of unacceptable results

- **Response:** Single select
- **Required:** Yes
- **Scale order:** Fixed as listed

**During the past six months, when this system was used for real work, roughly how often did it produce a result or action that was unacceptable for its intended use?**

- Never or almost never
- Rarely—a small minority of uses
- Sometimes, but not in most uses
- Often—a substantial share of uses
- In most or almost all uses
- Varied too much across tasks to answer
- Not enough visibility or use to answer

### Q9 — Accuracy and reliability factors

- **Response:** Single-response matrix
- **Required:** Yes; one response for every factor row
- **Row order:** Fixed as listed
- **Scale order:** Fixed as listed

**During the past six months, how much did each of the following accuracy or reliability problems affect the system’s usefulness or continued use?**

Factors:

- Incorrect, misleading, or unusable results or actions
- Different results or actions under materially similar conditions
- Failure to follow an instruction, requirement, or limit
- Failure when inputs, context, or operating conditions changed
- Failure when a tool, data source, or dependency changed or broke
- Failure to flag uncertainty or involve a person when needed

Scale:

1. Did not encounter this
2. Encountered it, but with little or no effect
3. Reduced usefulness somewhat
4. Reduced usefulness substantially
5. Caused use to be restricted, paused, or stopped
6. Not enough visibility

### Q10 — Recognition before impact

- **Response:** Single select
- **Required:** Yes
- **Scale order:** Fixed as listed

**During the past six months, among the unacceptable results or actions you know about, how often was the problem recognized before it affected real work?**

- Every or almost every time
- Most of the time
- About half the time
- Some of the time, but fewer than half
- Few or none of the time
- No unacceptable results or actions were known
- Not enough visibility

### Q11 — Most serious consequence

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else—describe briefly” is selected.

**During the past six months, what was the most serious consequence you know occurred because of an accuracy or reliability problem with this system?**

- No accuracy or reliability problem was known
- The problem was corrected before affecting real work
- Work was delayed, repeated, or abandoned
- A customer, employee, or other user received an inadequate outcome
- A decision, record, or system action had to be corrected or reversed
- Substantial additional cost or direct financial loss occurred
- A security, privacy, legal, compliance, or safety issue occurred
- Use of the system was restricted, paused, or stopped
- Something else—describe briefly
- Not enough visibility

### Q12 — Primary quality evidence

- **Response:** Single select
- **Required:** Yes

**During the past six months, which source of evidence had the greatest influence on decisions about whether this system’s quality was acceptable?**

- Informal human judgment or spot checks
- A repeatable collection of examples or test cases
- Defined measures or acceptance thresholds
- Production monitoring or incident evidence
- Real-world user, task, or business outcomes
- No consistent approach
- Not enough visibility

## Priorities and close

### Q13 — Shared-industry priority

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else—describe briefly” is selected.

**Based on your experience with this system, which accuracy or reliability problem most needs shared industry work?**

- Defining what “acceptable quality” means for a particular use
- Evaluating representative end-to-end tasks and workflows
- Measuring consistency across repeated or similar situations
- Detecting regressions after systems change
- Handling failures in tools, data, or dependencies
- Managing uncertainty and involving people at the right time
- Detecting and learning from production failures
- Something else—describe briefly
- No shared industry work is needed
- Not sure

### Q14 — Preferred ARWG output

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else—describe briefly” is selected.

**Which one vendor-neutral ARWG output would most help people working with systems like this one?**

- Shared, plain-language terminology for failures
- Practical guidance on metrics and evaluation design
- Reusable tests, evaluation tools, or test cases
- Reliability design and human-handoff patterns
- Monitoring and incident-learning guidance
- Worked examples and case studies
- A quality or conformance framework
- Something else—describe briefly
- None of these
- Not sure

### Q15 — Optional close

- **Response:** One short text response
- **Required:** No

**Optional: What important accuracy or reliability problem or experience did this survey miss?**
