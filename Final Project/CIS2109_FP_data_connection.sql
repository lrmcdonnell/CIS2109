
SELECT c.name AS "Customer Name", a."Date" AS "Appointment Date", o.name AS "Serivce", o."Desc" AS "Description"
FROM customer c
INNER JOIN appointment a ON c.customer_id = a.customer_customer_id
INNER JOIN services_requested sr ON a.appointment_id = sr.appointment_appointment_id
INNER JOIN service s ON sr.service_service_id = s.service_id
INNER JOIN offerings o ON s.offering_id = o.offering_id;

