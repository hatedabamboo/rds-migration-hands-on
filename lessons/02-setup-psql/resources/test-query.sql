SELECT first_name, last_name, email
FROM mock_data
WHERE email LIKE '%com'
AND SUBSTRING(first_name, 1, 1) = SUBSTRING(last_name, 1, 1)
ORDER BY last_name ASC, first_name ASC;
