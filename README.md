# Cohort Analytics Dashboard with Lakehouse on MS-Fabric

## 🔍 Business Problem

**QuantMart** is a fictional mid-scale **e-commerce retailer** operating in the daily-use and lifestyle products segment. The business relies on a mix of paid marketing, organic traffic, and repeat customers to drive growth.

The dataset used in this project is **synthetically generated (sourced from Kaggle)** and represents realistic e-commerce transaction behavior, including customer acquisition, repeat purchases, and revenue patterns typically observed in production systems.

Over multiple months, QuantMart maintained **stable website traffic and consistent acquisition activity**. However, leadership observed:

- **Flattening revenue growth**
- **Declining contribution from repeat customers**
- Increasing dependence on **first-time purchases** to meet monthly targets

At the aggregate level, traditional KPI dashboards—**Revenue, Orders, Conversion Rate, and Traffic**—continued to appear stable. These metrics explained *what* was happening, but failed to explain *why* long-term performance was weakening.

### Key Business Questions

To make better decisions around retention, marketing spend, and long-term growth, the team needed clear answers to some fundamental questions:

- **Are customers dropping off sooner than they used to?**
- **Is revenue falling because we’re losing customers, or because existing customers are spending less?**
- **Which groups of customers stick around and actually create long-term value—and which ones disappear after the first purchase?**
- **Are the customers we’re acquiring today better or worse than the ones we acquired in the past?**


### Analytical Approach

To address these gaps, I built a **Customer Cohort Analysis framework** that shifts the focus from aggregate monthly KPIs to **customer behavior over time**.

Customers were grouped into cohorts based on their **first purchase month** and tracked across subsequent periods to analyze:

- Retention and churn patterns
- Revenue retention vs customer retention
- Early-lifecycle drop-off
- Cohort performance trends over time

This approach enabled a lifecycle-driven understanding of growth and revealed structural retention issues that traditional dashboards could not capture.



## 🧠 Why Cohort Analysis?

Cohort analysis reveals insights that aggregate metrics hide:
| What Aggregate KPIs Suggest | What Cohort Analysis Reveals             |
|----------------------------|-----------------------------            |
| Overall revenue looks stable month over month | Newer customer cohorts are churning faster than older ones       |
| Conversion rates appear healthy | Customers are dropping off earlier in their lifecycle |
| Growth appears flat but acceptable | Revenue is coming from a smaller group of repeat customers |
| Acquisition performance seems unchanged | Customer quality is declining over time                            |


By grouping customers based on their **first purchase month**, we can objectively evaluate **customer quality, retention health, and revenue durability**.



## 🗂️ Cohort Definition

- **Cohort Type:** Acquisition-based
- **Cohort Key:** Customer First Purchase Month
- **Index:** Months since first purchase (0, 1, 2, …)

Each cohort answers:
> “How do customers acquired in *Month X* behave over time?”


## 🏗️ Data Architecture & Governance (Microsoft Fabric Lakehouse)


This project uses a **Microsoft Fabric Lakehouse** with a clear separation between **data preparation** and **analytics**.

All data cleaning, shaping, and transformations were handled through the **Lakehouse SQL endpoint**. This ensured that raw data was standardized and business-ready **before** it was exposed to reporting, and that no data needed to be copied or moved outside the governed environment.

There was a strict requirement that the data **must not leave the platform**. Because of this, importing data into Power BI or creating local extracts was not an option. Instead, Power BI connects directly to the Lakehouse and queries the data **in place**.

### How Analytics Were Built

While data preparation lives in the SQL layer, all business metrics—such as retention, churn, and revenue calculations—are implemented in **DAX** within Power BI. This keeps analytical logic flexible and close to the reporting layer, while the underlying data remains centrally governed.


## 📊 Dashboard Highlights & Features



### 🔹 Cohort Matrix with Metric Switcher
A dynamic cohort matrix allows users to switch between:
- **Retention %**
- **Cohort users**
- **Churn %**
- **Revenue retention**

This enables multiple lifecycle perspectives without duplicating visuals or pages.

---

### 🔹 Early Retention Slope Analysis
A dedicated visual tracks **early retention slope** for each cohort, highlighting how customer engagement changes in the first few months after acquisition.

This feature helps compare cohort performance beyond static retention snapshots.

---

### 🔹 Customer Type Comparison
The dashboard includes side-by-side comparisons between:
- One-time customers
- Repeat customers

Metrics such as total revenue and average revenue per user update dynamically based on selections.

![Cohorts Page](https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Cohort%20Page.gif)

### 🔹 Product Performance Deep Dive
The Products view includes:
- Top products by revenue and orders
- Product-level AOV and ASP
- Rating category and price category breakdowns
- Revenue contribution by price segment

This allows users to move seamlessly from customer-level to product-level analysis.


### 🔹 Key Influencers Visual
A built-in **Key Influencers visual** helps explore which factors are most associated with revenue changes, such as:
- Average order value
- Units sold
- Selling price

This enables exploratory analysis without writing additional queries.


![Products Page](https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Products%20Page.gif)

## 🔑 Key Insights


### 1. Early Retention Is the Biggest Structural Weakness

Across all cohorts, the biggest drop in retention happens immediately after the first purchase. By Month 1, retention typically falls to **just 4–14%**, and this pattern looks almost identical across different time periods and cohort sizes.

This consistency tells us that the problem isn’t seasonal or campaign-related. Instead, it points to a **fundamental gap in the early customer experience**. In simple terms, many customers don’t see enough value or reason to come back after their first order. Factors such as delivery experience, post-purchase communication, perceived pricing, onboarding, or the absence of strong repeat-purchase incentives are likely contributing to this early drop-off.

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Retention%20%25.png" >

### 2. Churn Remains High and Hasn’t Improved Over Time

After the initial drop in retention, churn quickly settles in the **88–95% range** and stays there for almost every cohort. What stands out is that newer cohorts behave almost exactly like older ones — there’s no visible improvement in how long customers stick around.

This suggests that key parts of the funnel haven’t meaningfully changed over time. Acquisition quality hasn’t improved, post-purchase engagement isn’t influencing repeat behavior, and any optimizations made so far haven’t translated into better retention outcomes.

High churn by itself isn’t unusual for an e-commerce business, especially one driven by one-time purchases. However, when churn remains this flat across cohorts, it signals that the business isn’t learning or improving fast enough at the funnel level.

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Churn%20%25.png" >


### 3. Revenue Holds Up Better Than Customer Retention

Even though most customers don’t return, revenue doesn’t fall off as quickly. Across several cohorts, **15–25% of the original revenue is still being retained** at later stages, despite a much smaller number of active users.

This gap between user retention and revenue retention shows that a **small group of customers is doing most of the heavy lifting**. These customers spend more, return more often, and contribute a disproportionate share of long-term revenue. As a result, looking only at average retention rates understates how healthy the revenue side of the business actually is.

This creates a clear trade-off. On one hand, it’s a strong signal that high-value customers exist and can be nurtured. On the other, it also means revenue is increasingly concentrated in a narrow segment, making the business more exposed if those customers churn.

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Revenue%20Retention%20%25.png" >

### 4. Repeat Customers Are Far More Valuable, but Underutilized

Repeat customers generate nearly **twice the average revenue per user** compared to one-time buyers. However, the bulk of total revenue still comes from one-time customers simply because there are many more of them.

This shows that the business is currently **volume-led rather than loyalty-led**. Topline growth depends heavily on continuous acquisition, while depth of customer relationships remains limited. As a result, revenue becomes more sensitive to any slowdown in traffic or rising acquisition costs.

Even a modest improvement in converting one-time buyers into repeat customers would significantly improve revenue efficiency and reduce dependency on constant acquisition.

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Total%20Revenue.png" >

### 5. Revenue Is Primarily Controlled by Order Value, Not Order Volume

The Key Influencers analysis makes one pattern very clear: **Average Order Value (AOV) is the strongest lever behind revenue movement**, both when revenue increases and when it declines. When AOV rises, revenue increases meaningfully; when AOV falls, revenue drops by a similar magnitude. Changes in units sold do matter, but their impact is consistently secondary.

What’s important here is the symmetry. Revenue doesn’t just benefit from higher AOV — it is **highly sensitive to AOV declines as well**. This tells us that revenue volatility is driven more by **pricing, product mix, and basket composition** than by fluctuations in traffic or demand.

In practical terms, demand exists and customers are placing orders. The bigger challenge is **how effectively each order is monetized**. This makes value-focused strategies — such as smarter bundling, cross-sell placement, pricing discipline, and protecting basket size — far more impactful than simply driving more traffic or orders.

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Key%20Influencers%20Increase.png"  height=500>
<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Key%20Influencers%20Decrease.png"  height=500>


### 6. Mid-Range Products Drive the Majority of Revenue

When revenue is broken down by price category, **mid-range and value-priced products contribute the largest share**, clearly outperforming premium and luxury items. This shows where customers are most comfortable spending.

Customers appear to be price-aware but not purely bargain-driven. The strongest product–market fit sits in accessible price bands where value feels clear and risk is low. Premium products, on the other hand, don’t scale as effectively without stronger brand trust or loyalty signals to support higher prices.

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Revenue%20By%20Category.png" >

### 7. New Customer Cohorts Are Getting Smaller Over Time

Cohort sizes steadily decline from early 2024 into late 2025, with recent cohorts shrinking to low double-digit and even single-digit user counts. Fewer customers are making it into the cohorts in the first place.

This points to **issues at the bottom of the funnel**, rather than a lack of interest. Potential contributors include lower conversion to completed purchases, stricter order qualification rules, or added friction during checkout and payment. When this is combined with already weak retention, it becomes clear that increasing traffic alone would not meaningfully improve performance.

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Cohort%20Users.png" height=500 >

### 8. Early Retention Lacks Momentum and Is Inconsistent Across Cohorts

The early retention slope (measured between Month 1 and Month 3) shows that **most cohorts fail to build meaningful momentum after the first purchase**. While a few cohorts exhibit mildly positive slopes, the majority remain flat or trend downward, and the magnitude of improvement is generally small.

More importantly, the slopes are **inconsistent across cohorts**. Positive early momentum does not persist in newer cohorts, and there is no clear upward trend over time. This suggests that early retention improvements are **sporadic rather than systematic**, likely driven by isolated factors instead of repeatable lifecycle strategies.

In practical terms, customers who survive the initial drop are not being pulled into a repeat habit. Short-term lifecycle touchpoints — such as post-purchase engagement, timely reminders, replenishment cues, or incentives — are not strong enough to create accelerating repeat behavior. Without early momentum, retention remains fragile and struggles to recover later in the lifecycle.

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Retention%20Slope.png" height=600 >

### 9. Looking Across All Metrics, the Story Is Consistent

When retention, churn, revenue retention, cohort size, pricing, and customer value are viewed together, they all point to the same underlying pattern.

The business does **not appear to have a demand problem**. Customers are finding the site and making purchases. Instead, performance is constrained by **funnel efficiency and early customer experience**, where most value is lost soon after the first transaction.

At the same time, revenue is becoming increasingly **concentrated among a small group of high-value repeat customers**. Without improvements to early retention, scaling acquisition would mostly increase churn rather than create sustainable growth.


## 💡 Business Recommendations


### 1. Fix the First-Repeat Moment, Not Traffic Volume
The largest revenue and retention losses occur immediately after the first purchase. Rather than increasing acquisition spend, prioritize **first-repeat conversion within 7–30 days** by improving post-purchase experience, delivery reliability, and repeat-purchase incentives.

**Why this matters:**  
Even a small uplift in first-repeat rate will compound revenue more effectively than scaling top-of-funnel traffic in a high-churn environment.

---

### 2. Design the Funnel Around High-Value Customers
Revenue retention consistently outperforms user retention, proving that a **small subset of customers drives long-term value**. Identify and actively protect these high-value customers through early loyalty tagging, personalized offers, and prioritized fulfillment.

**Why this matters:**  
Shifting focus from average customers to high-value segments reduces revenue concentration risk while improving LTV predictability.

---

### 3. Optimize for Value Expansion, Not Just Conversion
Revenue movements are driven primarily by **Average Order Value**, not transaction volume. Invest in pricing strategy, product bundling, cross-sell logic, and intelligent recommendations to increase basket value without increasing traffic dependency.

**Why this matters:**  
Value-based growth scales more efficiently and is less sensitive to rising acquisition costs in competitive e-commerce markets.

---

### 4. Double Down on Mid-Range Pricing as the Core Revenue Engine
Mid-range products contribute the highest share of revenue, outperforming both budget and premium segments. Position this segment as the **default growth engine**, supported by clear value messaging, comparisons, and repeat-purchase incentives.

**Why this matters:**  
Mid-range pricing balances affordability and margin, making it the most scalable segment for sustainable growth.

---

### 5. Treat Churn as a Product Signal, Not a Marketing Metric
Persistently high churn across cohorts indicates structural experience gaps rather than campaign inefficiencies. Use churn patterns to inform improvements in checkout UX, delivery SLAs, returns, and customer communication rather than increasing promotional spend.

**Why this matters:**  
Reducing friction in the core experience delivers longer-lasting impact than short-term promotional fixes.

---

### 6. Shift Measurement From Growth to Efficiency
Adopt lifecycle-focused KPIs such as **first-repeat conversion rate, revenue retention, and early retention slope**, instead of relying solely on total revenue or traffic growth.

**Why this matters:**  
In 2026, competitive advantage comes from **efficient growth**, not raw scale.

---

### 🎯 Strategic Takeaway
Sustainable growth for this e-commerce business will come from **improving early customer experience, expanding value per customer, and protecting high-value users**, rather than increasing acquisition volume. This approach aligns growth with profitability, resilience, and long-term customer equity.

