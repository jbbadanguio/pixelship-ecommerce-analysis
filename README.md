# <div align="center">PixelShip E-Commerce Analysis</div>

<p align="center">
  <img src="assets/pixelship_logo.gif" alt="PixelShip Logo">
</p>


# Overview
PixelShip is a global e-commerce company founded in 2018 that sells popular electronics from brands like Apple, Samsung, and Lenovo via its website and mobile app. Despite having a massive and largely underutilized dataset of orders, customers, and shipping information, the company's data was messy and had not been leveraged for strategic insights.

To address this, the Head of Operations commissioned a comprehensive sales and operational trend analysis focusing on the volatile 2019-2022 period. The primary goal was to uncover critical, data-driven insights to optimize operations, improve team processes, and understand peak-COVID performance.

This analysis provides actionable recommendations for the sales, marketing, and product teams by focusing on three North Star Metrics: **Sales Revenue**, **Average Order Value (AOV)**, and **Order Count**.

# ERD
<p align="center">
  <img src="assets/PixelShip ERD.svg" alt="ERD">
</p>

# Executive Summary
This analysis of PixelShip's e-commerce data from 2019-2022 reveals a company shaped by pandemic-driven volatility, with significant opportunities in loyalty program expansion and product-level optimization.

From 2019 to 2022, the company averaged 27,000 sales per year, generating an average of $7M in annual revenue with an Average Order Value (AOV) of $254. Performance peaked in 2020 with more than double the sales and revenue of 2019. While order volume continued to grow in 2021, AOV and total revenue declined as purchasing behavior normalized post-COVID.  

Key findings include:
- **Loyalty Program Success:** The loyalty program has emerged as a key growth engine. In 2021-2022, loyalty members made more purchases than non-members and, by 2022, spent approximately $30 more on average per order.  
- **Product & Refund Tension:** Refund trends highlight a divide between high-volume and high-value products. While high-volume items like AirPods generate the most returns by count, premium products like the ThinkPad Laptop and Macbook Air Laptop, have the highest refund rates, signaling a potential gap in customer expectations versus product quality or price.  
- **Top Revenue Driver:** The 27in 4K Gaming Monitor was the top product by revenue, underscoring its strategic importance.  

Key opportunities lie in expanding the loyalty program to maximize retention, addressing the high refund risk for premium products through improved support, and leveraging seasonal trends to optimize inventory.

# Detailed Analysis & Insights
## Sales Performance

<p align="center">
  <img src="assets/sales-1.png">
</p>

- North America consistently led in sales contribution, accounting for 52% of total revenue across a volatile four-year period. The pandemic triggered a dramatic +163% YoY surge in 2020, followed by a -46% correction in 2022 as demand normalized.
  
- This volatility underscores the importance of agile forecasting and regional segmentation. North America’s resilience suggests it should remain a strategic anchor while other regions are evaluated for growth potential.

<p align="center">
  <img src="assets/sales-2.png">
</p>

- The 27in 4K Gaming Monitor emerged as the top revenue driver, with strong performance across multiple regions. Apple AirPods led in order count but ranked second in revenue, reflecting their mass-market appeal. The MacBook Air, despite having 10x fewer orders than AirPods, contributed significantly to revenue due to its high AOV.
  
- This mix of volume and premium pricing highlights the importance of balancing accessibility with strategic high-value offerings.

<p align="center">
  <img src="assets/sales-3.png">
</p>

- Sales of the 27in 4K Gaming Monitor peaked during Q4 2020, aligning with remote work and holiday shopping trends. The highest concentration of purchases occurred in the weeks leading up to Thanksgiving and Christmas. 

- This seasonal surge reflects consumer investment in home entertainment and productivity during post-COVID restrictions. It also reinforces the value of time-sensitive promotions and inventory planning around key calendar windows.

## Product Dynamics

<p align="center">
  <img src="assets/product-1.png">
</p>

- High-AOV products like the MacBook Air and ThinkPad Laptop show elevated refund rates, introducing tension between perceived value and customer satisfaction. The ThinkPad leads with an 12% refund rate, while the MacBook Air follows closely at 11%, despite generating $3.1M more in sales. 

- These patterns suggest that premium pricing may raise expectations that aren't always met. Addressing post-purchase experience and product positioning could reduce refund risk in high-value segments.

<p align="center">
  <img src="assets/product-2.png">
</p>

- Apple AirPods have the highest number of refunds (2.6K) but maintain a relatively low refund rate of 5%, likely due to their massive sales volume. In contrast, the MacBook Air has fewer refunds but a much higher refund rate, pointing to quality perception or buyer hesitation. 

- This distinction helps separate operational volume from customer satisfaction concerns. It also suggests that refund mitigation strategies should be tailored by product tier.

<p align="center">
  <img src="assets/product-3.png">
</p>

- Refund rates for high-AOV products like the MacBook Air and ThinkPad Laptop remained elevated until a sharp drop to 0% in 2022. While this may reflect operational improvements or policy changes, it’s also possible that refunds were not yet recorded at the time of data extraction. _Further validation is recommended before interpreting this as a sustained trend._

- Tracking refund trends over time helps isolate whether issues are product-specific or systemic. It also provides a feedback loop for refining product quality and support strategies.

## Loyalty Program Impact

<p align="center">
  <img src="assets/loyalty-1.png">
</p>

- Loyalty members overtook non-members in AOV in mid-2021 and sustained a $30 lead through late 2022. This consistent gap suggests that loyalty participants are more willing to invest per purchase.
  
- The trend reflects deeper customer commitment and possibly stronger alignment with premium offerings. It also validates the loyalty program’s role in driving long-term value rather than short-term acquisition.

<p align="center">
  <img src="assets/loyalty-2.png">
</p>

- From December 2020 to August 2022, loyalty members consistently placed more orders than non-members. This behavior indicates stronger engagement and repeat purchasing, not just higher spend per order. 

- The volume advantage complements the AOV lead, reinforcing the program’s impact on both frequency and value. Together, these metrics suggest loyalty members are more profitable and more predictable.

<p align="center">
  <img src="assets/loyalty-3.png">
</p>

- Loyalty members convert more reliably in mid-range windows (31–120 days), outperforming non-members in nearly every bucket beyond the first 30 days. This pattern suggests thoughtful, committed purchasing rather than impulsive behavior. 

- This also highlights the loyalty program’s strength in nurturing long-term engagement rather than accelerating immediate conversion. Lifecycle marketing strategies should focus on reinforcing value during this mid-funnel window.

## Marketing Segment Behavior
_Note: While “Unknown” channels appear in the dataset, they likely reflect gaps in attribution rather than a coherent acquisition strategy. Their behavior should be interpreted cautiously and may warrant further investigation into tracking completeness._

<p align="center">
  <img src="assets/marketing-1.png">
</p>

- Refund risk is highest among website purchases from social media and unknown channels, especially when paired with tablet or TV devices. These segments show elevated refund rates, suggesting passive browsing, low buyer confidence, or attribution gaps. 

- In contrast, mobile app purchases, particularly via direct and email channels, show lower refund rates, indicating stronger intent and post-purchase satisfaction. Segmenting by device and channel reveals clear behavioral differences that are worth targeting.

<p align="center">
  <img src="assets/marketing-2.png">
</p>

- Spending behavior varies widely across acquisition sources. Direct and email channels show consistent mid-tier AOV, with a consistent spread into high-value purchases, indicating strong customer trust and reliable performance. Affiliate and social media channels display greater volatility and outliers. 

- These patterns suggest that not all channels serve the same strategic purpose. Direct and Email are foundational for both everyday revenue and premium customer acquisition, while Affiliate requires granular analysis to separate high-performing partners from noise. Social Media excels at driving volume and brand engagement but is not a reliable source for high-ticket conversions.


<p align="center">
  <img src="assets/marketing-3.png">
</p>

- Mobile app purchases from affiliate, social media, and email channels drive the highest loyalty engagement, with rates above 60–75%. Website purchases, especially via affiliate and direct channels, lag behind, suggesting weaker retention.
  
- This highlights mobile-first environments as key drivers of long-term customer investment. Pairing acquisition strategy with platform behavior can optimize loyalty outcomes.

# Actionable Recommendations for Stakeholders

**For the Executive Leadership:**
- Double down on North America as the primary revenue engine, but monitor for post-pandemic normalization and diversify regional bets.
- Elevate high-AOV products like the MacBook Air in strategic planning, as they drive disproportionate revenue despite lower volume.
- Invest in loyalty program expansion, especially through mobile app channels, to deepen mid-term engagement and customer lifetime value.
- Reassess refund policies for premium products. High return rates may signal misaligned expectations or quality perception gaps.


**For the Marketing and Acquisition Teams:**
- Prioritize mobile app acquisition via affiliate, social media, and email. These segments show the highest loyalty conversion and lowest refund risk.
- Audit social media and unknown website traffic, especially on tablets and TVs, as they show elevated refund rates and may require better targeting or messaging.
- Refine messaging for high-AOV products in volatile channels (e.g., affiliate, social) to align perceived value with actual product experience.
- Use channel-platform pairing to guide campaign design. Not all traffic converts or retains equally.


**For the Product and Merchandising Teams:**
- Monitor refund rates on premium SKUs (e.g., ThinkPad, MacBook). Cconsider post-purchase education, setup support, or satisfaction guarantees.
- Leverage seasonal demand patterns to optimize inventory and promotional timing.
- Bundle or reposition high-AOV items with lower-risk accessories to reduce perceived purchase friction.
- Use refund trends by year to evaluate the impact of policy or quality changes.




### Tools & Technical Documentation
**Tools Used:** Excel, SQL, BigQuery, and Tableau.
