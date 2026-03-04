-- =============================================
-- Create Staff Table for Ocean View Resort
-- Run this SQL in your oceanviewresort database
-- =============================================

CREATE TABLE IF NOT EXISTS staff (
    staff_id    INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    phone       VARCHAR(20),
    position    VARCHAR(50) NOT NULL,
    department  VARCHAR(50) NOT NULL,
    salary      DECIMAL(10, 2) DEFAULT 0.00,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data (optional)
INSERT INTO staff (full_name, email, phone, position, department, salary) VALUES
('Kamal Perera', 'kamal@oceanview.com', '+94 77 123 4567', 'Receptionist', 'Front Office', 45000.00),
('Nimal Silva', 'nimal@oceanview.com', '+94 71 234 5678', 'Chef', 'Food & Beverage', 65000.00),
('Saman Fernando', 'saman@oceanview.com', '+94 76 345 6789', 'Security', 'Security', 35000.00),
('Dilani Jayawardena', 'dilani@oceanview.com', '+94 70 456 7890', 'Housekeeping', 'Housekeeping', 32000.00),
('Ruwan Bandara', 'ruwan@oceanview.com', '+94 75 567 8901', 'Concierge', 'Guest Services', 40000.00);
