# Employee Attrition Analysis & Retention Strategy

## Project Overview

This project analyzes employee attrition using a data-driven approach to identify key drivers, uncover high-risk employee segments, and recommend actionable retention strategies.

The analysis integrates SQL (data transformation), Python (EDA), and Tableau (visualization) to build a complete end-to-end analytics workflow. The goal is to move beyond basic reporting and enable data-driven HR decision-making.

## Problem Statement

Employee attrition is a major challenge for organizations as it leads to:

-Increased recruitment and training costs.
-Loss of experienced employees.
-Reduced productivity and team stability.

This project aims to:

-Identify who is leaving.
-Understand why employees leave.
-Provide actionable strategies to improve retention.

## Dataset
Dataset sourced from Kaggle (HR Employee Attrition Dataset)

Contains employee-level data including demographics, job roles, compensation, and satisfaction metrics

## Tools & Technologies
SQL → Data cleaning, transformation, feature engineering

Python (Pandas, Matplotlib, Seaborn) → Exploratory Data Analysis

Tableau → Interactive dashboard visualization

## Data Processing Workflow

This project follows a structured and consistent data pipeline:

Data cleaning and feature engineering were performed using SQL
The processed dataset was exported as a structured table
This SQL output was used in Python for exploratory data analysis and validation
The same refined dataset was used in Tableau for dashboard creation

##### The SQL-transformed dataset was maintained as the single source of truth, ensuring consistency and reliability across all stages of analysis.

## Dashboard Preview

## Live Tableau Dashboard

👉 View Interactive Dashboard:
https://public.tableau.com/shared/8G7FH8ZP9?:display_count=n&:origin=viz_share_link

## Key Metrics
Total Employees: 1,470 /
Employees Left: 237 /
Attrition Rate: 16.12% /
Average Salary: 6,503

## Key Insights
Employees in the low-income group (~28.6%) have the highest attrition
Employees working overtime (~30.5%) are nearly 3x more likely to leave
Poor work-life balance (~19.6%) significantly increases attrition
Employees with 0–2 years experience (~27.9%) show the highest attrition
Low job satisfaction (~19.7%) strongly correlates with employee exits

## High-Risk Employee Segments

Attrition is driven by a combination of factors rather than a single variable.

The most critical high-risk segments identified:

🔴 Low Income + Overtime + Low Satisfaction → Highest Risk
🔴 New Employees + Poor Work-Life Balance → High Risk

#### These segments represent employees with the highest probability of leaving, making them key targets for retention strategies.

## Business Recommendations

Based on the analysis, the following strategies are recommended:

Improve compensation structure for low-income employees
Reduce excessive overtime to prevent burnout
Enhance work-life balance through flexible policies
Strengthen onboarding and engagement for new employees
Improve promotion and career growth processes

## Project Structure
📁 Employee-Attrition-Analysis
│──  HR-Employee-Attrition.sql
│──  Hr_Employee_Attrition.ipynb
│──  Dashboard-image.png 
│──  Employee_Attrition_Report.pdf
│── 📁 Dataset (CSV/Excel)
│──  Detailed Report

For complete analysis and business insights:
#### Employee_Attrition_Report.pdf

## Key Highlights
End-to-end analytics workflow (SQL → Python → Tableau)
Strong feature engineering for behavioral segmentation
Identification of high-risk employee groups
Focus on business insights and decision-making
Structured and reproducible data pipeline

## Author

Deepanshu Rajput
Data Analyst | SQL | Python | Tableau

## Support

If you found this project useful, consider giving it a ⭐ and connecting!
