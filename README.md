# Pixelship: Supply Chain & Profitability Analysis
<img width="1024" height="1024" alt="image" src="https://github.com/user-attachments/assets/da0aa0d4-26e7-40fb-ba42-8d6f9a5cfe8d" />


# Overview
Pixelship is a global e-commerce company for electronics. that experienced rapid growth between 2019 and 2022. My initial task was a broad exploratory analysis to understand key business trends across sales, marketing, and operations to report on overall company health.

In this first phase, I looked at North Star Metrics like overall sales revenue, Average Order Value (AOV), and order counts. While top-line revenue was strong, a critical concern was raised by the Head of Operations, Angie, regarding a perceived increase in customer refunds and complaints about shipping. This feedback suggested that our high-level success might be hiding underlying operational issues that were hurting profitability and customer satisfaction. This prompted a dedicated, deep-dive analysis into the company's supply chain performance.

_My objective for this project was to lead an end-to-end analysis of four years of order data to either validate or disprove this hypothesis._ 

# ERD
<img width="1875" height="1114" alt="image" src="https://github.com/user-attachments/assets/6357afa3-c031-454e-825f-0e24016d8987" />


# Executive Summary
My analysis uncovered several critical insights that reshaped the company's understanding of its operational health and its relationship with customer satisfaction.

**1. Operational Efficiency is a Core Strength:** 
- The central finding of this analysis is that shipping time is NOT a primary driver of customer refunds. The initial assumption that shipping delays were causing a spike in refunds was not supported by the data.

**2. The 7-Day "Tipping Point":** 
- The refund rate remains remarkably stable for deliveries taking up to two weeks, increasing only marginally from 4.89% (for 0-7 day deliveries) to 5.05% (for 8-14 day deliveries). This demonstrates that the company is highly resilient to minor shipping delays.

**3. The Problem is Acute, Not Chronic:** 
- My initial EDA revealed that widespread, systemic delays were not an issue. Instead, the data pointed to severe, acute failures concentrated in specific countries during specific years (e.g., Qatar in 2020), which required targeted investigation.

# Detailed Analysis & Insights
### Insight 1: Operational Performance Remained Stable and Efficient
Despite the global disruptions of the pandemic, Pixelship's core operations proved to be highly resilient. The company-wide average fulfillment time remained stable at approximately 7.5 days from 2019 through 2022. This key finding disproved the initial hypothesis that a general slowdown was causing customer dissatisfaction. The issue was not a systemic failure.

### Insight 2: Shipping Delays Show No Significant Impact on Refunds
The core of my investigation was to test the hypothesis that shipping delays were a primary driver of refunds. The data showed this to be incorrect.
- The refund rate for orders delivered within a week was 4.89%.
- For orders taking 8-14 days, the refund rate only increased to 5.05%.

This negligible increase proves that customers are not significantly more likely to request a refund, even when deliveries take up to two weeks. This insight prevents the company from investing resources in solving the wrong problem.

[VISUAL TO INSERT HERE]
Screenshot of a Tableau bar chart titled "Refund Rate Remains Stable Despite Minor Delays." This visual clearly shows the small difference between the 0-7 and 8-14 day buckets.

### Insight 3: Pinpointing Acute, High-Impact Failures
While the overall system was stable, my analysis of country-level performance uncovered specific, high-impact failures. These were not chronic issues but severe, isolated events.
- **Qatar (QA):** Average fulfillment time spiked to 47.6 days in 2020 before returning to normal.
- **Taiwan (TW):** Average fulfillment time hit 34.1 days in 2019 before returning to normal.

These acute failures, while not the primary driver of refunds, still represent a significant negative customer experience and a risk to the company's reputation in those markets.

[VISUAL TO INSERT HERE]
Screenshot of the Excel PivotTable or a Tableau chart showing the "Highest Avg Fulfillment Time by Country" with the yearly breakdown. This visually supports the finding about acute, year-specific failures.

# Actionable Recommendations for Stakeholders
Based on my analysis, I presented three strategic recommendations to the Head of Operations to refocus the company's efforts on the true drivers of customer satisfaction.

**Shift Focus from Shipping Time as the Primary Refund Driver:**
- **Recommendation:** Communicate to leadership and the customer support team that my analysis shows that shipping time is not the primary cause of customer refunds.
- **Business Impact:** This prevents the company from investing significant resources into optimizing a process that is not broken and allows us to redirect our analytical efforts toward finding the true root causes.

**Launch a New Analysis to Find the True Drivers of Refunds:**
- **Recommendation:** Initiate a new analytical deep-dive to investigate other potential causes for refunds, such as product category (are certain items defective more often?), marketing channel (do certain channels bring in less satisfied customers?), or purchase platform (is the mobile app experience causing issues?).
- **Business Impact:** This data-driven pivot puts the company on the right path to solving the actual problem, improving customer retention and protecting profit margins.

**Conduct a Post-Mortem on Acute Shipping Failures:**
- **Recommendation:** While not a primary driver of refunds, extreme delays are still a negative customer experience. I recommend a targeted investigation into the severe delivery failures to Qatar in 2020 and Taiwan in 2019.
- **Business Impact:** By identifying the root cause of these past events, we can prevent future catastrophic failures and protect the company's reputation in those markets.

### Tools & Technical Documentation
**Tools Used:** Excel, Google BigQuery, and Tableau.

**Technical Files:** The complete SQL queries used for this analysis are available in the sql.sql file in this repository.
