-- Query 1: JOIN - Retrieve booking information with customer and vehicle names
SELECT 
    b.booking_id,
    u.name AS customer_name,
    v.vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM bookings AS b
INNER JOIN users AS u ON b.user_id = u.user_id
INNER JOIN vehicles AS v ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id;

-- Output:
-- booking_id  customer_name  vehicle_name    start_date   end_date     status
-- 1           Alice          Honda Civic     2023-10-01   2023-10-05   completed
-- 2           Alice          Honda Civic     2023-11-01   2023-11-03   completed
-- 3           Charlie        Honda Civic     2023-12-01   2023-12-02   confirmed
-- 4           Alice          Toyota Corolla  2023-12-10   2023-12-12   pending

-- Query 2: EXISTS - Find all vehicles that have never been booked
SELECT 
    v.vehicle_id,
    v.vehicle_name AS name,
    v.type,
    v.model,
    v.registration_no AS registration_number,
    v.price_per_day AS rental_price,
    v.availability_status AS status
FROM vehicles AS v
WHERE NOT EXISTS (
    SELECT 1 
    FROM bookings AS b 
    WHERE b.vehicle_id = v.vehicle_id
)
ORDER BY v.vehicle_id;

-- Output:
-- vehicle_id  name         type   model  registration_number  rental_price  status
-- 3           Yamaha R15   bike   2023   GHI-789              30            available
-- 4           Ford F-150   truck  2020   JKL-012              100           maintenance

-- Query 3: WHERE - Retrieve all available vehicles of a specific type (e.g. cars)
SELECT 
    vehicle_id,
    vehicle_name AS name,
    type,
    model,
    registration_no AS registration_number,
    price_per_day AS rental_price,
    availability_status AS status
FROM vehicles
WHERE type = 'car' 
    AND availability_status = 'available'
ORDER BY vehicle_id;

-- Output:
-- vehicle_id  name             type  model  registration_number  rental_price  status
-- 1           Toyota Corolla   car   2022   ABC-123              50            available

-- Query 4: GROUP BY and HAVING - Vehicles with more than 2 bookings
SELECT 
    v.vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM vehicles AS v
LEFT JOIN bookings AS b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_name
HAVING COUNT(b.booking_id) > 2
ORDER BY total_bookings DESC;

-- Output:
-- vehicle_name    total_bookings
-- Honda Civic     3