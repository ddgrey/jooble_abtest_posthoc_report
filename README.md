# Post-A/B test analysis for ML job ranking algorithm

### **Idea**: 
1. To generate a [realistic dataset](jooble_ml_ab_test_data_generated.rar) for a performed A/B-test related to *testing a new ML-based job ranking algorithm vs. basic one* with following metrics:
    - `primary/pm`: `pm_apply_click_conversion`
    - `secondary/sm`: `sm_jobs_applied_count`, `sm_job_saves_count`, `sm_email_signup`, `sm_create_cv`, `sm_session_duration_min`, `sm_return_visit_7d`
   <p align="left">
     <img src="https://drive.google.com/uc?export=view&id=1X0aq2e9SbhuR7D7uf19ECAd-W6m6h_xd" width="800">
   </p>
   
   <p align="left">
     <img src="https://drive.google.com/uc?export=view&id=1YfRKgOTfrM6QtdSNnVSh6tJZlcMkA7Lp" width="800">
   </p>
  
2. Then to retrieve this generated data via [SQL syntax](jooble_ab_test_data_sql_querying.sql) from the local PostgreSQL DB and do some transformations to simulate real conditions
3. Then to conduct a post hoc stat. analysis via a [Python script](jooble_ab_test_posthoc.ipynb) with tests being chosen based on the metric data type:
    - `binary`: `Z-test for proportions (effect size: Cohen's h)`
    - `categorical`: `Chi-squared test (effect size: Cramer's V)`
    - `numeric`: `Brunner-Munzel test (effect size: Cliff's Delta)` (against the weaker Mann-Whitney test)
      
   *Unfortunately, I had no enough time to make the stat. test selection more nuanced based on the underlying data distribution (e.g., moderately/highly zero-inflated one, parametric tests with distr. shape transformation, or Monte Carlo simulation for non-parametric test power analysis)*
4. Then to generate a simple yet actionable [Excel report file](ab_test_results_report.xlsx) with both "Summary" and "Detailed Results" sheets
   
   *Again, if I had more time I would've designed the report supporting visualizations and internal clarifications (it clearly lacks some descriptions)*
   <p align="left">
     <img src="https://drive.google.com/uc?export=view&id=1KiCVaeYEMR4ri2FinWQvgMYNI25VSh5W" width="350">
   </p>
  
5. **Finally, to that moment — anyone could process A/B test results using the script, almost *no matter the scenario*. The code handles common data types found in split tests, and in seconds generates a report that is easy enough to understand!**

### **A/B-test design parameters:**
- `Hypothesis`: *New ML-based job ranking algorithm increases **job application rate** by 15% compared to basic search ranking*
- `Baseline conversion`: 0.0840
- `Expected conversion`: 0.0966 (but the factual one is 0.124, which is **46% greater**)
- `MDE (relative)`: ±15%
- `Confidence`: 95%
- `Power`: 90%
- `Split`: 50/50
- `Sample size per variant`: 10,452
- `Traffic per day`: 26,000 (the actual daily traffic divided by 10 for simplicity)
- `A/B-test duration`: 0.8 days (but the minimum is 2 weeks due to weekly fluctuations)
- `Total traffic for 2 weeks`: 364,000 (26,000 * 14)

---

I enjoyed doing this work and hope I've shown enough interest in working with Jooble.  
Together, we’ll redefine what’s possible in the job aggregator space! 🙌😊

[**LinkedIn**](https://www.linkedin.com/in/dvyemchuk/) | [**Telegram**](https://t.me/ddgrrey)
