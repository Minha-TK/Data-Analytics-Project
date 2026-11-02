-- Hospital Management - SQL Project
-- Tables: doctors, patients, appointments, treatments, billing

-- Q1. Doctors with appointment more than 5 patients
SELECT doctors.doctor_id, doctors.first_name, COUNT(appointments.patient_id) AS patient_count FROM doctors INNER JOIN appointments ON doctors.doctor_id = appointments.doctor_id GROUP BY doctors.doctor_id HAVING COUNT(appointments.patient_id) > 5;

-- Q2. Patients with treatments
SELECT appointments.patient_id, treatments.treatment_type FROM appointments INNER JOIN treatments ON appointments.appointment_id = treatments.appointment_id;

-- Q3. Total appointments per patient
SELECT appointments.patient_id, COUNT(appointments.appointment_id), patients.first_name FROM appointments LEFT JOIN patients ON appointments.patient_id = patients.patient_id GROUP BY patients.patient_id;

-- Q4. Most common treatment
SELECT COUNT(treatment_id), treatment_type FROM treatments GROUP BY treatment_type ORDER BY COUNT(treatment_id) DESC LIMIT 1;

-- Q5. Doctors with most unique patients
SELECT doctor_id, COUNT(patient_id) AS unique_patients FROM appointments GROUP BY doctor_id ORDER BY unique_patients DESC LIMIT 1;

-- Q6. Rarely used treatments
SELECT treatment_type, COUNT(treatment_id) FROM treatments GROUP BY treatment_type ORDER BY COUNT(treatment_id) LIMIT 2;

-- Q7. Total number of patients
SELECT COUNT(patient_id) FROM patients;

-- Q8. Patients with multiple appointments on same day
SELECT patients.patient_id, patients.first_name, COUNT(appointments.appointment_id), appointments.appointment_date FROM patients JOIN appointments ON patients.patient_id = appointments.patient_id GROUP BY patients.patient_id, appointments.appointment_date HAVING COUNT(appointments.appointment_id) > 1;

-- Q9. How many patients each doctor has
SELECT doctor_id, COUNT(patient_id) FROM appointments GROUP BY doctor_id;

-- Q10. Which Department earns the most?
SELECT doctors.specialization AS Department, SUM(billing.amount) AS Total_Revenue FROM billing JOIN treatments ON billing.treatment_id = treatments.treatment_id JOIN appointments ON treatments.appointment_id = appointments.appointment_id JOIN doctors ON doctors.doctor_id = appointments.doctor_id GROUP BY doctors.specialization ORDER BY Total_Revenue DESC;

-- Q11. Patients with pending bills
SELECT patients.patient_id, patients.first_name || ' ' || patients.last_name AS patient_name, patients.contact_number, SUM(billing.amount) AS Due_amount FROM patients JOIN billing ON patients.patient_id = billing.patient_id WHERE billing.payment_status = 'pending' GROUP BY patients.patient_id;

-- Q12. Which treatment is most expensive?
SELECT treatments.treatment_type, ROUND(AVG(treatments.cost), 2) AS Avg_Cost, COUNT(treatments.treatment_id) AS Times_Performed FROM treatments GROUP BY treatments.treatment_type ORDER BY Avg_Cost DESC;

-- Q13. How many appointments are completed, cancelled, scheduled?
SELECT appointments.status, COUNT(*) AS Total_appointments FROM appointments GROUP BY appointments.status;

-- Q14. Monthly billing report
SELECT strftime('%Y-%m', billing.bill_date) AS Month, COUNT(billing.bill_id) AS Total_Bills, ROUND(SUM(billing.amount), 2) AS Monthly_Revenue FROM billing GROUP BY Month ORDER BY Month DESC;

-- Q15. Doctors with highest experience
SELECT first_name AS Doctor_name, specialization, years_experience FROM doctors ORDER BY years_experience DESC;

-- Q16. Patients who have both MRI and Chemotherapy
SELECT patients.patient_id, patients.first_name, patients.last_name FROM patients JOIN appointments ON patients.patient_id = appointments.patient_id JOIN treatments ON appointments.appointment_id = treatments.appointment_id WHERE treatments.treatment_type IN ('MRI', 'Chemotherapy') GROUP BY patients.patient_id HAVING COUNT(DISTINCT treatments.treatment_type) = 2;

-- Q17. Branch wise revenue
SELECT doctors.hospital_branch AS Branch, COUNT(DISTINCT billing.bill_id) AS Total_Bills, ROUND(SUM(billing.amount), 2) AS Branch_Revenue FROM billing JOIN treatments ON billing.treatment_id = treatments.treatment_id JOIN appointments ON treatments.appointment_id = appointments.appointment_id JOIN doctors ON appointments.doctor_id = doctors.doctor_id GROUP BY doctors.hospital_branch ORDER BY Branch_Revenue DESC;

-- Q18. Busiest days of the week
SELECT strftime('%w', appointments.appointment_date) AS Day_Number, CASE WHEN strftime('%w', appointments.appointment_date) = '0' THEN 'Sunday' WHEN strftime('%w', appointments.appointment_date) = '1' THEN 'Monday' WHEN strftime('%w', appointments.appointment_date) = '2' THEN 'Tuesday' WHEN strftime('%w', appointments.appointment_date) = '3' THEN 'Wednesday' WHEN strftime('%w', appointments.appointment_date) = '4' THEN 'Thursday' WHEN strftime('%w', appointments.appointment_date) = '5' THEN 'Friday' WHEN strftime('%w', appointments.appointment_date) = '6' THEN 'Saturday' END AS Day_Name, COUNT(appointments.appointment_id) AS Total_Appointments FROM appointments GROUP BY Day_Number ORDER BY Total_Appointments DESC;

-- Q19. Potential revenue lost
SELECT doctors.specialization, COUNT(appointments.appointment_id) AS Cancelled_Count, ROUND(AVG(treatments.cost), 2) AS Avg_Treatment_Cost, ROUND(COUNT(appointments.appointment_id) * AVG(treatments.cost), 2) AS Est_Revenue_Loss FROM appointments JOIN doctors ON appointments.doctor_id = doctors.doctor_id JOIN treatments ON appointments.appointment_id = treatments.appointment_id WHERE appointments.status = 'Cancelled' GROUP BY doctors.specialization;
