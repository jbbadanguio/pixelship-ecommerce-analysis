# <div align="center">PixelShip E-Commerce Analysis</div>

<p align="center">
  <img src="assets/pixelship_logo.gif" alt="PixelShip Logo">
</p>


# Overview
PixelShip is a global e-commerce company founded in 2018 that sells popular electronics from brands like Apple, Samsung, and Lenovo. With a massive, underutilized dataset, the Head of Operations has asked for a comprehensive analysis of sales trends from 2019-2022.

The primary goal is to uncover critical insights to share at the upcoming company-wide town hall. This analysis will help the finance, sales, and product teams understand peak-COVID performance and identify key opportunities for growth.

# ERD
![Entity Relationship Diagram](assets/erd.webp)


# Executive Summary
Sales at PixelShip saw an unprecedented surge in 2020, driven by the COVID-19 pandemic, followed by a market correction and sales decline in 2022. Despite this, the company's loyalty program has shown exceptional promise, with loyalty members' average order value (AOV) and order volume surpassing non-loyalty members in 2021 and 2022.

Key opportunities lie in:
- Enhancing the loyalty program to capitalize on this high-value segment.
- Investigating operational inefficiencies, particularly in EMEA, which shows the longest average delivery times.
- Managing product refunds, as high-value items like laptops (ThinkPad, MacBook) have the highest refund rates, while popular items (Apple AirPods) have the highest refund count.


# Detailed Analysis & Insights
### Overall Sales & Regional Trends
- **Peak-COVID Surge**: The company experienced a massive 163% YoY sales surge in 2020. This momentum slowed in 2021 and saw a -46% decline in 2022 as sales "normalized" post-pandemic.
- **Most Popular Products by Region**: Apple AirPods are the most popular product by order count across all regions. North America remains the highest-volume region for top-performing products.
- **Spotlight on MacBooks**: MacBook sales in North America peaked in Q4 2020, aligning with the work-from-home trend. Sales have since stabilized but remain a critical, high-AOV product category.

### Product Performance & Refunds
- **Refund Rate vs. Count**: The analysis revealed a key difference:
  - **Highest Refund Rate**: The ThinkPad Laptop has the highest refund rate (11.7%).
  - **Highest Refund Count**: Apple AirPods have the highest number of refunds (2.6K), likely due to their high sales volume.
- **High-Value Refunds**: Other high-AOV items like the MacBook Air (11.4%) and Apple iPhone (7.6%) also have high refund rates, suggesting a potential issue with product descriptions, quality, or customer expectations on expensive items.

### Loyalty Program & Customer Behavior
- **Loyalty Program is a Success**: While non-loyalty customers drove sales in 2019-2020, the trend has reversed. In 2022, loyalty members not only placed more orders but also had an AOV that was ~$30 higher than non-loyalty members.
- **Time to First Purchase**: Interestingly, both loyalty and non-loyalty customers take a similar amount of time to make their first purchase (approximately 3.4 - 3.5 months after account creation). This suggests the loyalty program's value is in retention and higher AOV, not necessarily a faster initial conversion.

### Operational Efficiency
- **Delivery Time Bottleneck**: The EMEA region has the highest average time-to-deliver for products, representing a key operational bottleneck that could be impacting customer satisfaction.

# Actionable Recommendations for Stakeholders
Based on these insights, I propose the following actions:

**For the Marketing Team:**
- **Double-down on the loyalty program**. The data proves its value. Launch campaigns focused on converting non-loyalty customers and retaining existing members, highlighting the exclusive perks that drive high-AOV purchases.
- **Use the "most popular product by region"** data to inform targeted ad spend.

**For the Product Team:**
- **Investigate high-AOV refunds**. Partner with Customer Service to understand why ThinkPads and MacBooks are being returned at such a high rate. This could be a quality control issue, a problem with carrier shipping, or mismatched expectations from the product page.

**For the Operations Team (Attn: Angie):**
- **Analyze the EMEA logistics chain**. The high delivery time in EMEA is a clear outlier. A deep-dive is needed to identify bottlenecks (e.g., specific carriers, customs delays, warehouse locations) to improve efficiency.

### Tools & Technical Documentation
**Tools Used:** Excel, Google BigQuery, and Tableau.

**Technical Files:** The complete SQL queries used for this analysis are available in the pixelship-operations.sql file in this repository.
