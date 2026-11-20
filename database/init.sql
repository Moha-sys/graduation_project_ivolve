-- iVolve DevOps Graduation Project
-- Database Initialization Script

CREATE DATABASE IF NOT EXISTS ivolve;
USE ivolve;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
