CREATE TABLE CLIENT (
    CLIENT_NO INT PRIMARY KEY,
    CLIENT_NAME VARCHAR(20),
    CITY VARCHAR(15),
    STATE VARCHAR(15),
    PIN INT,
    BALANCE_DUE DECIMAL(10, 2)
);
