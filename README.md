# Cohort Analytics Dashboard with Lakehouse on MS-Fabric

## 📌 Project Overview

While exploring new datasets and project ideas, I came across this e-commerce dataset on Kaggle. Rather than treating it as a standard exploratory exercise, I used it as an opportunity to apply a **real-world analytics approach** and put my own spin on the problem.

The goal of this project was to move beyond static reporting and build an **end-to-end analytical solution** that reflects how enterprise dashboards are designed and consumed. To do this, the dataset was loaded into a **Microsoft Fabric Lakehouse** and analyzed using **DirectQuery**, allowing all transformations to be performed in a governed, centralized environment without importing data into Power BI.

By combining a public dataset with an enterprise-style architecture and advanced analytical techniques, this project showcases how Power BI can be used not just to visualize data, but to **answer meaningful business questions at scale**.

You can find the link to Kaggle dataset [here.](https://www.kaggle.com/datasets/abhayayare/e-commerce-dataset)

*Thank you for taking the time to explore this project. It represents work I’m genuinely proud of.*


## 📚Table of Contents:
|**No.**  |**Section**|
|:-: | :------------ | 
|1.   |  [Business Problem](#Business-problem)                              |
|2.   |  [Key Business Questions](#key-business-questions)                              |
|3.   |  [Analytical Approach](#analytical-approach)                              |
|4.   |  [Data Architecture And Governance](#data-architecture-and-governance)                              |
|5.   |  [Dashboard Highlights And Features](#dashboard-highlights-and-features)                              |
|6.   |  [Key Insights](#key-insights)                              |
|7.   |  [Business Recommendations](#business-recommendations)                              |


## 🔍Business Problem

**QuantMart** is a fictional mid-scale **e-commerce retailer** operating in the daily-use and lifestyle products segment. The business relies on a mix of paid marketing, organic traffic, and repeat customers to drive growth.

The dataset used in this project is **synthetically generated (sourced from Kaggle)** and represents realistic e-commerce transaction behavior, including customer acquisition, repeat purchases, and revenue patterns typically observed in production systems.

Over multiple months, QuantMart maintained **stable website traffic and consistent acquisition activity**. However, leadership observed:

- Flattening revenue growth
- Declining contribution from repeat customers
- Increasing dependence on first-time purchases to meet monthly targets

At the aggregate level, traditional KPI dashboards—**Revenue, Orders, Conversion Rate, and Traffic**—continued to appear stable. These metrics explained *what* was happening, but failed to explain *why* long-term performance was weakening.

[(Back to top)](#table-of-contents)


## 📌Key Business Questions

To make better decisions around retention, marketing spend, and long-term growth, the team needed clear answers to some fundamental questions:

- Are customers dropping off sooner than they used to?
- Is revenue falling because we’re losing customers, or because existing customers are spending less?
- Which groups of customers stick around and actually create long-term value—and which ones disappear after the first purchase?
- Are the customers we’re acquiring today better or worse than the ones we acquired in the past?


[(Back to top)](#table-of-contents)


## 📊Analytical Approach
To address these gaps, I built a **Customer Cohort Analysis framework** that shifts the focus from aggregate monthly KPIs to **customer behavior over time**.

Customers were grouped into cohorts based on their **first purchase month** and tracked across subsequent periods to analyze:

- Retention and churn patterns
- Revenue retention vs customer retention
- Early-lifecycle drop-off
- Cohort performance trends over time

This approach enabled a lifecycle-driven understanding of growth and revealed structural retention issues that traditional dashboards could not capture.

[(Back to top)](#table-of-contents)


### 💡Why Cohort Analysis?

Cohort analysis reveals insights that aggregate metrics hide:
| What Aggregate KPIs Suggest | What Cohort Analysis Might Reveal             |
|-|--            |
| Overall revenue looks stable month over month | Newer customer cohorts are churning faster than older ones       |
| Conversion rates appear healthy | Customers are dropping off earlier in their lifecycle |
| Growth appears flat but acceptable | Revenue is coming from a smaller group of repeat customers |
| Acquisition performance seems unchanged | Customer quality is declining over time                            |


By grouping customers based on their **first purchase month**, we can objectively evaluate **customer quality, retention health, and revenue durability**.

[(Back to top)](#table-of-contents)


### 🗂️Cohort Definition

- **Cohort Type:** Acquisition-based
- **Cohort Key:** Customer First Purchase Month
- **Index:** Months since first purchase (0, 1, 2, …)

Each cohort answers:
> “How do customers acquired in *Month X* behave over time?”

[(Back to top)](#table-of-contents)


## 🗂Data Architecture And Governance


This project uses a **Microsoft Fabric Lakehouse** with a clear separation between **data preparation** and **analytics**.

All data cleaning, shaping, and transformations were handled through the **Lakehouse SQL endpoint**. This ensured that raw data was standardized and business-ready **before** it was exposed to reporting, and that no data needed to be copied or moved outside the governed environment.

There was a strict requirement that the data **must not leave the platform**. Because of this, importing data into Power BI or creating local extracts was not an option. Instead, Power BI connects directly to the Lakehouse and queries the data **in place**.

All SQL queries were written with **query folding in mind**, and reusable **views were created wherever complex logic was required**, avoiding heavy CTE usage in the reporting layer to ensure better performance and maintainability.

You can find the SQL queries I used here: [SQL Queries](https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/tree/main/SQL%20Queries)

![Lineage](https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Workspace%20Lineage.png)

### How Analytics Were Built

While data preparation lives in the SQL layer, all business metrics—such as retention, churn, and revenue calculations—are implemented in **DAX** within Power BI. This keeps analytical logic flexible and close to the reporting layer, while the underlying data remains centrally governed.

[(Back to top)](#table-of-contents)


## 📊Dashboard Highlights And Features



### 🔹 Cohort Matrix with Metric Switcher
A dynamic cohort matrix allows users to switch between:
- **Retention %**
- **Cohort users**
- **Churn %**
- **Revenue retention**




### 🔹 Early Retention Slope Analysis
A dedicated visual tracks **early retention slope** for each cohort, highlighting how customer engagement changes in the first few months after acquisition.




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



### 🔹 Key Influencers Visual
A built-in **Key Influencers visual** helps explore which factors are most associated with revenue changes, such as:
- Average order value
- Units sold
- Selling price



![Products Page](https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Products%20Page.gif)

[(Back to top)](#table-of-contents)


## 🔑Key Insights


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

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Average%20Revenue.png" width=400> <img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Total%20Revenue.png" width=400>


### 5. Revenue Is Primarily Controlled by Order Value, Not Order Volume

The Key Influencers analysis makes one pattern very clear: **Average Order Value (AOV) is the strongest lever behind revenue movement**, both when revenue increases and when it declines. When AOV rises, revenue increases meaningfully; when AOV falls, revenue drops by a similar magnitude. Changes in units sold do matter, but their impact is consistently secondary.

What’s important here is the symmetry. Revenue doesn’t just benefit from higher AOV — it is **highly sensitive to AOV declines as well**. This tells us that revenue volatility is driven more by **pricing, product mix, and basket composition** than by fluctuations in traffic or demand.

In practical terms, demand exists and customers are placing orders. The bigger challenge is **how effectively each order is monetized**. This makes value-focused strategies — such as smarter bundling, cross-sell placement, pricing discipline, and protecting basket size — far more impactful than simply driving more traffic or orders.

<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Key%20Influencers%20Increase.png"  height=500>
<img src="https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/Screenshots/Key%20Influencers%20Decrease.png"  height=500>


### 6. Mid-Range Products Drive the Majority of Revenue

When revenue is broken down by price category, **mid-range (<$100) and value-priced (<$50) products contribute the largest share**, clearly outperforming premium and luxury items. This shows where customers are most comfortable spending.

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

[(Back to top)](#table-of-contents)


## 💡Business Recommendations

### ▶️Fix the First-Repeat Moment, Not Traffic Volume

The largest losses in both retention and revenue occur immediately after the first purchase. Instead of increasing acquisition spend, focus on improving **first-repeat conversion within the first 7–30 days** by strengthening things like post-purchase experience, delivery reliability, and repeat-purchase incentives. 

Small improvements at this stage will compound more effectively than scaling top-of-funnel traffic in a high-churn environment.


### ▶️Design the Funnel Around High-Value Customers

Revenue retention consistently outperforms user retention, indicating that a **small subset of customers drives a disproportionate share of long-term value**. 

These customers should be identified early and protected through:
- Loyalty tagging
- Personalized offers
- Prioritized fulfillment.

Treating high-value users as a distinct segment improves revenue resilience and reduces over-reliance on acquisition volume.

### ▶️Make Mid-Range Pricing the Core Growth Engine

Mid-range products contribute the highest share of revenue, outperforming both budget and premium segments. This price band should be positioned as the primary growth engine, supported by clear value communication, product comparisons, and repeat-purchase nudges. It offers the best balance between scale, margin, and customer comfort.



### ▶️ Treat Early Churn as a Lifecycle Experience Problem

Churn consistently spikes immediately after the first purchase and then stabilizes across cohorts, indicating that losses are driven by early experience rather than marketing performance. Instead of addressing churn through promotions, churn patterns should be used to prioritize improvements in checkout flow, fulfillment reliability, returns, and post-purchase communication.

Reducing friction at these early touchpoints directly addresses the stage where the majority of customer value is lost and has a greater long-term impact than increasing short-term promotional spend.


[(Back to top)](#table-of-contents)



## You can explore the report [here](https://github.com/GH-AkshyM/Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric/blob/main/PBIX%20file/Cohort%20Analysis%20with%20Lakehouse(Direct%20Query).pbix). Download and open using Power BI Desktop. 

## Check out some of my other works: 
- 📦 **[Revenue Health Dashboard](https://github.com/GH-AkshyM/Revenue-Health-Dashboard/tree/main)** – Executive Revenue Dashboard for Higher-Ups, Simplify monthly reports.  
- 🧠 **[HR Attrition Analytics with Dataflow Gen2](https://github.com/GH-AkshyM/Hr-Attrition-Analytics-Dashboard)** – A Clean Minimalistic look into Attrition Analytics with Insights Hard-coded.  
- 📈 **[Sentiment Analysis Using BERT](https://github.com/GH-AkshyM/Sentiment-Analysis-using-BERT)** – Using SQL and Python pre-trained models for analysing customer reviews.
