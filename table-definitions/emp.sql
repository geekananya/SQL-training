CREATE TABLE EMP (
    EMPNO INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    ENAME VARCHAR(50),
    JOB VARCHAR(50),
    MGR INT,
    HIREDATE DATE,
    SAL DECIMAL(7, 2),
    COMM DECIMAL(7, 2),
    DEPTNO INT,
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO),
    FOREIGN KEY (MGR) REFERENCES EMP(EMPNO)
);

CREATE INDEX EMP_MGR_IDX ON EMP (MGR);
CREATE INDEX EMP_DEPTNO_IDX ON EMP (DEPTNO);
