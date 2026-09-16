# AAIF Accuracy & Reliability Survey

This document specifies a platform-neutral survey for the Agentic AI Foundation Accuracy & Reliability Working Group. It includes 16 questions and does not specify an implementation platform.


## Response formats

- **Single select:** exactly one answer may be selected.
- **Multi-select:** one or more answers may be selected.
- **Single-response matrix:** one Likert-scale type of answer is selected for each row.
- **Inline text:** a short text field appears beside the answer choice and is required only when that choice is selected.


## Eligibility

Welcome, and thank you for your interest!

The Agentic AI Foundation (AAIF), part of the Linux Foundation, supports the development of open standards and tools for Agentic AI. Its Accuracy & Reliability Working Group is gathering firsthand experiences with AI systems used for real work. Your responses will help us understand common challenges and prioritize future work.

Please avoid including identifying or confidential information in your responses.

### Q1. Eligibility and real-world use

- **Response:** Single select
- **Required:** Yes
- **Behavior:** The first five choices continue to the rest of the survey. The final three choices go to the early-exit thank-you section, with no further questions. Their Q1 answer is saved when they click Submit.

**During the past six months, which best describes your experience with AI systems?**

If more than one system reached real-world use, answer about the one you worked with most. If two qualify equally, choose the one you worked with most recently.

- Serious pilot: Tested in an intended work setting to assess whether it could perform real tasks, but not yet part of normal work
- Limited deployment: Part of normal work for some intended users or workflows
- Broad deployment: Part of normal work for most intended users or workflows
- Paused or retired: Reached a serious pilot or deployment before use was paused or stopped
- Real-world use, stage not sure: Used for real work, but I am not sure which stage fits
- Demo, prototype, or generic research only: Did not reach real-world use
- Secondhand knowledge only: Knew about a system used for real work but did not personally work with it
- No relevant system experience

## About the system

**Focal-system instruction**

For the rest of this survey, answer about the same system you had in mind for Q1 and your experience with it during the past six months. When a question asks about the system or organization at a particular point, answer based on the last time you worked with it.

### Q2. Direct activities

- **Response:** Multi-select
- **Required:** Yes
- **Inline text:** Required when “Something else (describe briefly)” is selected.

**Which activities have you personally performed with this system? Select all that apply.**

- Designed, built, configured, or integrated it
- Tested or evaluated its quality
- Deployed, operated, monitored, or investigated it
- Reviewed, corrected, or approved its outputs or actions
- Used its outputs or relied on its actions in my work
- Made decisions about its development, deployment, or continued use
- Something else (describe briefly)

### Q3. Primary area of work

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else (describe briefly)” is selected.

**Which area of work was this system’s primary use? Choose the closest answer.**

- Customer or employee support
- Information search, research, or synthesis
- Content creation, editing, or design
- Software development or IT operations
- Data extraction, document processing, or administrative tasks
- Analysis, forecasting, planning, or decision support
- Risk assessment, compliance, or audit
- Business transactions or workflow execution, such as orders, payments, or scheduling
- Something else (describe briefly)
- Not sure

### Q4. System structure

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else (describe briefly)” is selected.

**Which best describes how this system completed a typical task? Choose the closest answer.**

- An AI response without tools or actions: Produced an answer, draft, or label from information supplied to it without choosing subsequent steps, calling other software, or taking actions
- One AI agent: One agent chose how to carry out the task, including which tools or actions to use
- Multiple AI agents: Two or more AI agents coordinated, delegated, handed off, or checked one another’s work
- A preset automated workflow with AI steps: Software or fixed rules determined the sequence; AI performed individual steps without choosing what happened next
- Something else (describe briefly)
- Not sure

### Q5. Organization size

- **Response:** Single select
- **Required:** No

**Approximately how many employees or regular staff worked at the organization where this system was primarily used for real work? If you worked with it for a client or customer, answer about that organization rather than your own.**

- 1 to 99
- 100 to 999
- 1,000 or more
- The system was used across several organizations or customers (no single organization applies)
- Not sure

## Benefits and challenges

### Q6. Constraints

- **Response:** Single-response matrix
- **Required:** Yes; one response for every factor row
- **Row order:** Fixed as listed
- **Scale order:** Fixed as listed

**During the past six months, how much did each factor limit progress or expansion of this system?**

Factors:

- Cost of building or running the system
- Difficulty accessing or integrating data, tools, or systems
- Security, privacy, legal, or compliance requirements
- Gaps in staffing or expertise to build or maintain the system
- Low user trust or willingness to use the system
- Inaccurate or unusable results or actions
- Unreliable behavior across repeated use or changing conditions
- Insufficient evidence to judge whether the system worked well enough

Scale:

1. Did not limit progress
2. Limited progress somewhat
3. Limited progress substantially
4. Stopped or reversed progress
5. Not sure

### Q7. Human checking

- **Response:** Single select
- **Required:** Yes
- **Display order:** Fixed as listed

**Which best describes how human review was usually used to check whether this system’s outputs or actions were acceptable? Choose the closest answer.**

- No routine human review
- Occasional spot checks
- Review mainly when the system flagged uncertainty or requested help
- Review mainly for high-risk cases
- Review of most or all outputs or actions
- A mix of approaches, with no main pattern
- Not sure

### Q8. Most significant benefit

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else (describe briefly)” is selected.

**What was the most significant benefit this system delivered in real work?**

- Completed roughly the same work faster or with less effort
- Handled more work, cases, or users
- Improved the quality or consistency of work
- Improved responsiveness or availability
- Enabled work that was previously impractical or impossible
- Produced no meaningful additional benefit
- Something else (describe briefly)
- Not sure

## Accuracy and reliability

### Q9. Frequency of unacceptable results

- **Response:** Single select
- **Required:** Yes
- **Scale order:** Fixed as listed

**During the past six months, when this system was used for real work, roughly how often did it produce a result or action that was unacceptable for its intended use?**

- Never or almost never
- Rarely (a small minority of uses)
- Sometimes, but not in most uses
- Often (a substantial share of uses)
- In most or almost all uses
- Varied too much across tasks to answer
- Not sure

### Q10. Accuracy and reliability factors

- **Response:** Single-response matrix
- **Required:** Yes; one response for every factor row
- **Row order:** Fixed as listed
- **Scale order:** Fixed as listed

**How much did each of the following accuracy or reliability problems affect the system’s usefulness or continued use?**

Factors:

- Incorrect, misleading, or unusable results or actions
- Inconsistent quality or behavior on repeated or similar tasks
- Failure to follow an instruction, requirement, or limit
- Failure when inputs, context, or operating conditions changed
- Failure when a tool, data source, or dependency changed or broke
- Failure to express uncertainty or request human help when needed

Scale:

1. Did not reduce usefulness or limit use
2. Reduced usefulness somewhat
3. Reduced usefulness substantially
4. Caused use to be restricted, paused, or stopped
5. Not sure

### Q11. Recognition before impact

- **Response:** Single select
- **Required:** Yes
- **Scale order:** Fixed as listed

**Among the unacceptable results or actions you know about, how often were problems identified before they affected real work?**

- Every or almost every time
- Most of the time
- About half the time
- Some of the time, but fewer than half
- Never or almost never
- No known unacceptable results or actions
- Not sure

### Q12. Most serious consequence

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else (describe briefly)” is selected.

**What was the most serious consequence of an accuracy or reliability problem with this system that you know about? Choose the closest answer.**

- No known accuracy or reliability problems
- Problems occurred, but had no known effect on real work
- Work was delayed, repeated, or abandoned
- A customer, employee, or other user received an inadequate outcome
- A decision, record, or system action had to be corrected or reversed
- Substantial additional cost or direct financial loss occurred
- A security, privacy, legal, compliance, or safety issue occurred
- Use of the system was restricted, paused, or stopped
- Something else (describe briefly)
- Not sure

### Q13. Primary quality evidence

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else (describe briefly)” is selected.

**Which approach was mainly used to judge whether this system’s quality was acceptable? Choose the closest answer.**

- Informal human judgment or spot checks
- Results from repeatable tests or evaluations
- User feedback, task results, or business outcomes
- No quality assessment was done
- Something else (describe briefly)
- Not sure

## Future priorities

### Q14. Shared-industry priority

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else (describe briefly)” is selected.

**Based on your experience with this system, which area most needs shared industry work to improve accuracy or reliability?**

- Defining what “acceptable quality” means for a particular use
- Designing systems to prevent accuracy or reliability failures
- Testing whether systems successfully complete real-world tasks
- Measuring consistency across repeated or similar situations
- Detecting declines in quality after systems change
- Recovering safely from failures, including failures in tools or data sources
- Managing uncertainty and involving people at the right time
- Detecting and learning from failures during real-world use
- Something else (describe briefly)
- Not sure

### Q15. Preferred resource

- **Response:** Single select
- **Required:** Yes
- **Inline text:** Required when “Something else (describe briefly)” is selected.

**Which type of resource from the Accuracy & Reliability Working Group would most help you improve systems like this one?**

- Shared, plain-language terminology for failures
- Practical guidance on metrics and evaluation design
- Reusable tests, evaluation tools, or test cases
- Reliability design and human-handoff patterns
- Monitoring and incident-learning guidance
- Worked examples and case studies
- A quality or conformance framework
- Something else (describe briefly)
- Not sure

### Q16. Optional close

- **Response:** One short text response
- **Required:** No

**Optional: What important accuracy or reliability problem or experience did this survey miss?**

## Early-exit thank-you

- **Behavior:** Display before submission only for respondents who select one of the final three Q1 choices. Respondents who reach the end of the main survey skip this section and submit directly.

**Thank you for your interest!**

This survey focuses on firsthand experience with AI systems used for real work. There are no further questions for you.

Please click Submit to finish.

## Thank-you

- **Behavior:** Display after submission for both completed and screened-out responses.

Thank you for your time and input. Your response will help the Accuracy & Reliability Working Group understand common challenges and prioritize future work.
