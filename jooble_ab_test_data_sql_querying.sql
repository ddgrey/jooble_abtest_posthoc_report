SELECT
	user_id,
	session_id,
	RIGHT(session_id, 1)::int AS session_count,
	timestamp,
	EXTRACT(DAY FROM (test_start_date - MIN(test_start_date) OVER ()))::int AS test_start_day,
	variant,
	country_code,
	device_type,
	apply_click_conversion AS pm_apply_click_conversion, -- 'pm' means 'primary metric'
	jobs_applied_count AS sm_jobs_applied_count, 		 -- 'sm' means 'secondary metric'
	job_saves_count AS sm_job_saves_count,
	email_signup AS sm_email_signup,
	create_cv AS sm_create_cv,
	session_duration_min AS sm_session_duration_min,
	return_visit_7d AS sm_return_visit_7d
FROM
	jooble.jooble_ml_ab_test_data