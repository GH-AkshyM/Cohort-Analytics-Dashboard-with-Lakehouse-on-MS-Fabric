# Cohort-Analytics-Dashboard-with-Lakehouse-on-MS-Fabric

## 🔍 Business Problem

**UrbanBasket** is a fictional mid-scale **e-commerce retailer** operating in the daily-use and lifestyle products segment. The business relies on a mix of paid marketing, organic traffic, and repeat customers to drive growth.

The dataset used in this project is **synthetically generated (sourced from Kaggle)** and represents realistic e-commerce transaction behavior, including customer acquisition, repeat purchases, and revenue patterns typically observed in production systems.

Over multiple months, UrbanBasket maintained **stable website traffic and consistent acquisition activity**. However, leadership observed:

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
| What Aggregate KPIs Suggest | What Cohort Analysis Reveals |
|----------------------------|-----------------------------|
| Overall revenue looks stable month over month | Newer customer cohorts are churning faster than older ones |
| Conversion rates appear healthy | Customers are dropping off earlier in their lifecycle |
| Growth appears flat but acceptable | Revenue is coming from a smaller group of repeat customers |
| Acquisition performance seems unchanged | Customer quality is declining over time |


By grouping customers based on their **first purchase month**, we can objectively evaluate **customer quality, retention health, and revenue durability**.

---

## 🗂️ Cohort Definition

- **Cohort Type:** Acquisition-based
- **Cohort Key:** Customer First Purchase Month
- **Index:** Months since first purchase (0, 1, 2, …)

Each cohort answers:
> “How do customers acquired in *Month X* behave over time?”

---
## 🏗️ Data Architecture & Governance (Microsoft Fabric Lakehouse)


This project uses a **Microsoft Fabric Lakehouse** with a clear separation between **data preparation** and **analytics**.

All data cleaning, shaping, and transformations were handled through the **Lakehouse SQL endpoint**. This ensured that raw data was standardized and business-ready **before** it was exposed to reporting, and that no data needed to be copied or moved outside the governed environment.

There was a strict requirement that the data **must not leave the platform**. Because of this, importing data into Power BI or creating local extracts was not an option. Instead, Power BI connects directly to the Lakehouse and queries the data **in place**.

### How Analytics Were Built

While data preparation lives in the SQL layer, all business metrics—such as retention, churn, and revenue calculations—are implemented in **DAX** within Power BI. This keeps analytical logic flexible and close to the reporting layer, while the underlying data remains centrally governed.

### Why This Approach Was Chosen

This setup reflects a common enterprise pattern:
- **SQL** is used for reliable, repeatable data preparation
- **DAX** is used for dynamic, business-facing metrics
- **No data duplication** occurs across systems

The result is a solution that respects data governance constraints while still enabling detailed cohort analysis and lifecycle insights.



## 📊 Dashboard Design Principles

- **Heatmap-style cohort matrix** for instant pattern recognition
- **Metric switcher** (Retention %, Revenue Retention, Churn %)
- **Minimal slicers** to avoid over-filtering cohorts
- **Mobile-optimized layout**
- Zero clutter, maximum signal

---

## 🔑 Key Insights

### 🧠 Insight 1: Early-Stage Retention Is the Real Problem
Most churn happens between **Index 0 → Index 1**, indicating issues immediately after first purchase.

> This signals onboarding, experience, or expectation gaps—not long-term loyalty issues.

---

### 🧠 Insight 2: Newer Cohorts Underperform Historical Benchmarks
Cohorts acquired in recent months show:
- Lower retention
- Faster revenue decay
- Weaker recovery patterns

> Growth efforts are increasing **customer volume**, but **customer quality is declining**.

---

### 🧠 Insight 3: Revenue Retention Outperforms Customer Retention
Revenue drops slower than customer count, indicating:
- Fewer customers
- Higher dependency on a small, high-value segment

> This creates **revenue concentration risk**.

---

### 🧠 Insight 4: Retention Stabilizes After a Certain Index
Customers who survive beyond early churn windows show **stable behavior**.

> Retention investment should prioritize **early lifecycle interventions**, not late-stage discounts.

---

## 💡 Business Recommendations

### ✅ 1. Fix the First Experience, Not the Funnel Top
Improving acquisition without fixing early retention **destroys LTV**.  
Focus on:
- First purchase experience
- Delivery reliability
- Post-purchase communication

---

### ✅ 2. Redefine Growth KPIs
Shift success metrics from:
> **“How many customers did we acquire?”**  
to  
> **“How many customers reached Month 2?”**

---

### ✅ 3. Segment Retention Strategies by Cohort Health
- Strong cohorts → Upsell & loyalty
- Weak cohorts → Diagnose acquisition channel quality

---

### ✅ 4. Use Cohort Benchmarks for Decision-Making
Instead of reacting to short-term dips, compare:
> New cohorts vs historical best cohorts

This creates **contextual, bias-free performance evaluation**.

---

## 🚀 What Makes This Project Stand Out

- Business-first framing (not tool-driven)
- Clear separation of **symptom vs cause**
- Scalable cohort logic using DAX measures
- Performance-optimized model
- Executive-friendly storytelling

---

## 📌 Final Takeaway

Cohort analysis transforms raw data into **behavioral intelligence**.  
This project demonstrates how **retention, not acquisition**, is the real growth lever—and how data teams can surface that truth clearly and decisively.

---

**Thanks for stopping by!**  
If you’re interested in retention analytics, revenue diagnostics, or Power BI best practices, feel free to connect.
