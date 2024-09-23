CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    manager_id NUMBER,
    CONSTRAINT fk_manager
        FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);