# Post-A/B test analysis for ML job ranking (Jooble-like aggregator)

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
3. Then to conduct a post hoc stat. analysis via a [Python script](jooble_ab_test_posthoc_v2.ipynb) with tests being chosen based on the metric data type:
    - `binary`: `Z-test for proportions (effect size: Cohen's h)`
    - `categorical`: `Chi-squared test (effect size: Cramer's V)`
    - `numeric`: `Brunner-Munzel test (effect size: Cliff's Delta)` (against the weaker Mann-Whitney test)
        - `zero-inflated distribution`:  Two-part testing = `Chi-squared test` (analysis of zeros) + `Brunner-Munzel test` (analysis of non-zeros)
        - `non-to-low zero-inflated distribution` (i.e. all other numerical cases): `Brunner-Munzel test`
4. Then to generate a simple yet actionable [Excel report file](ab_test_results_report.xlsx) with both "Summary" and "Detailed Results" sheets

    <p align="left">
      <img src="https://drive.google.com/uc?export=view&id=10GFjRUTuAvqd_pL5M5vrdz95RjlajBFr" width="435" style="margin-right: 10px;">
      <img src="https://drive.google.com/uc?export=view&id=1g7owj8yFmwMAcC9ZVRtV2KhzkFYJDacT" width="350">
    </p>
  
5. **Finally, to that moment — anyone could process A/B test results using the script, almost *no matter the scenario*. The code handles common data types found in split tests, and in seconds generates a report that is easy enough to understand!**

---

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

### **Stat. test power analysis methods:**
- `Z-test for proportions`: `Two-sample z-test power analysis` (zt_ind_solve_power())
- `Chi-squared test`: `Two-sample chi-squared test power analysis` (adjusted GofChisquarePower() for independence test)
- `Brunner-Munzel test`: `Monte Carlo simulation power analysis` (with KDE for smoothing discretized continuous values)

### **Python script workflow overview:**
1. **Load A/B test data**  
   Automatically selects the most recent test file from a designated folder, based on a date-formatted filename suffix.
2. **Define statistical test functions**  
   Implements reusable functions for statistical analysis, storing test results per metric in a structured dictionary.
3. **Define visualization functions**  
   Creates plotting utilities to generate figures for each metric, also stored in a dictionary for later use.
4. **Apply appropriate tests**  
   Dynamically selects the correct statistical test based on each metric’s data type and distribution characteristics.
5. **Generate Excel report**  
   Combines statistical outputs and visualizations into a formatted Excel report using custom layout logic.

---

[**LinkedIn**](https://www.linkedin.com/in/dvyemchuk/) | [**Telegram**](https://t.me/ddgrrey)
