# Vehicle Rental System – Database Design & SQL Queries

## 📌 Overview
This project demonstrates the database design and SQL query implementation for a **Vehicle Rental System**.  
The goal of this assignment is to show understanding of:

- Entity Relationship Diagram (ERD) design
- Primary Key (PK) and Foreign Key (FK) relationships
- One-to-One, One-to-Many, and Many-to-One relationships
- SQL queries using `JOIN`, `EXISTS`, `WHERE`, `GROUP BY`, and `HAVING`

---

### ERD LINK
- [https://drawsql.app/teams/zinnodev/diagrams/vehicle-rental-system-erd]

## 🗂️ Database Design

The system manages the following entities:

- **Users**
- **Vehicles**
- **Bookings**

### 🔗 Relationships
- **One-to-Many**: One user can make many bookings
- **Many-to-One**: Many bookings can be associated with one vehicle
- **Logical One-to-One**: Each booking connects exactly one user and one vehicle

---

## 📐 ERD Description

### Users Table
- Stores system users (Admin / Customer)
- Each user is uniquely identified by email

**Attributes:**
- `id` (PK)
- `role` (Admin, Customer)
- `name`
- `email` (Unique)
- `password`
- `phone`

---

### Vehicles Table
- Stores rental vehicles information
- Each vehicle has a unique registration number

**Attributes:**
- `id` (PK)
- `name`
- `type` (car, bike, truck)
- `model`
- `registration_number` (Unique)
- `price_per_day`
- `availability_status` (available, rented, maintenance)

---

### Bookings Table
- Stores booking records
- Links users and vehicles using foreign keys

**Attributes:**
- `id` (PK)
- `user_id` (FK → Users.id)
- `vehicle_id` (FK → Vehicles.id)
- `start_date`
- `end_date`
- `booking_status` (pending, confirmed, completed, cancelled)
- `total_cost`

---

## 🛠️ SQL Schema

```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    role ENUM('Admin', 'Customer') NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE vehicles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type ENUM('car', 'bike', 'truck') NOT NULL,
    model VARCHAR(100),
    registration_number VARCHAR(50) UNIQUE NOT NULL,
    price_per_day DECIMAL(10,2) NOT NULL,
    availability_status ENUM('available', 'rented', 'maintenance') NOT NULL
);

CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    booking_status ENUM('pending', 'confirmed', 'completed', 'cancelled') NOT NULL,
    total_cost DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
);
