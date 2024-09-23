# SQL-training

## 1. ER Diagram

Tables used - 
- Client
- Product
- SalesOrder
- Sales_Order_Detail

## 2. Basic SQL Commands

- DDL: CREATE, ALTER, DROP
- DML: SELECT, INSERT, UPDATE, DELETE
```sql
create table Students (
  roll int primary key,
  name varchar(20),
  deptid char not null
)

begin
insert into Students values (1, 'XYZ', 'A');
insert into Students values (2, 'ABC', 'D');
insert into Students values (3, 'ABCD', 'B');
insert into Students values (4, 'OQR', 'C');
insert into Students values (5, 'PQ', 'D');
insert into Students values (6, 'LM', 'A');
end;

select * from Students
```

![D0A37552-18F7-4C92-871D-1B05D91743AD](https://github.com/user-attachments/assets/f661a3fa-4619-4727-b537-827bda2424f9)

```sql
alter table Students add avg_marks int
alter table Students rename column deptid to dept
select * from Students
```

![image](https://github.com/user-attachments/assets/b91a6d03-c84b-4b63-9e83-a9ae2b3371ee)

```sql
update Students set name='LMN ABC' where roll=4
update Students set avg_marks=78.5 where roll=2
delete from Students where roll=5
select * from Students
```

![image](https://github.com/user-attachments/assets/a17bee9a-fa88-4f34-bc93-1f65dea9d5ea)

```sql
drop table Students
select * from Students
```

![751DBB81-05C0-44FD-8C94-93D2315B278E_4_5005_c](https://github.com/user-attachments/assets/f7f9b354-6a33-4181-8c3c-94d1062feab8)

## 3. Advanced SQL Commands

### I. Joins - Inner, Outer, Cross Joins

Consider 2 tables -

**Employee (emp)**
![image](https://github.com/user-attachments/assets/ce8c24d7-b82c-4283-a673-7ffcac779ba5)
**Department (dept)**
![image](https://github.com/user-attachments/assets/5023a449-19d6-4422-83ae-e53ee6a39618)

```sql
-- Natural Join [finds the common attribute and returns only the common rows(intersection)]

select * from emp natural join dept
```
![image](https://github.com/user-attachments/assets/240d6a8d-8f04-479c-877e-b3e582eabe7b)
Note that column DeptNo appears only once in a natural join.

```sql
-- Inner Join [joins tables on the basis of a given condition]

select * from emp, dept where emp.deptno=dept.deptno

-- or

select * from emp inner join dept on emp.deptno = dept.deptno
```
![image](https://github.com/user-attachments/assets/bd3e8772-ac88-4403-8d55-1f2084c44e08)

```sql
-- A table can also be joined with itself.

select e1.ename, e1.sal, e1.deptno, e2.ename, e2.sal, e2.deptno from emp e1, emp e2 where e1.sal < e2.sal and e1.deptno=10 and e2.deptno=30
```
![image](https://github.com/user-attachments/assets/a527a2a8-c0c7-4f4a-942e-0277635ddda3)

```sql
-- Outer Join: Includes unmatched rows

select * from emp right join dept on emp.deptno = dept.deptno

-- unmatched rows from only the table that is specified AFTER the right outer join clause
```
![image](https://github.com/user-attachments/assets/cdaad3d2-f25f-4d9f-b83b-708e030ae0ed)

```sql
select * from emp left join dept on emp.deptno = dept.deptno   

-- unmatched rows from only the table that is specified BEFORE the left outer join clause

select * from emp full outer join dept on emp.deptno = dept.deptno    -- unmatched rows from both tables
```
In our case, full outer join will include all matching rows, since the column being matched is primary key of one table.

![image](https://github.com/user-attachments/assets/861275c2-b34a-4459-9762-777dbfc16705)

```sql
-- CROSS JOIN: returns Cartesian product

SELECT *   
FROM emp   
CROSS JOIN dept;

--or

SELECT * FROM emp, dept
```
![image](https://github.com/user-attachments/assets/5a26d1ff-064d-4116-8976-e8f100089009)

### II. Subqueries and correlated subqueries

**Subqueries:** One query embedded in another query. The inner query is only executed once to return the values required by the outer query to execute.

```sql
select ename, job, sal
from emp
where empno
IN (
    select empno from emp where sal>2500
);
```
![image](https://github.com/user-attachments/assets/7be57c4e-1bda-4622-9526-6dfd4bf2d17b)

**Correlated Subqueries:** Evaluated once for each row of the outer query, the inner query is dependent on the outer query for values, and thus they are slower.

```sql
select ename, job, sal
from emp
where sal > (
    select avg(sal) from emp where deptno IN (20, 30, 40)
);
```
![image](https://github.com/user-attachments/assets/99f7b149-0118-4c93-9ad5-0029cdb3abfb)

### III. Set operations: UNION, INTERSECT, EXCEPT

**Conditions for valid set operations:**
1. The columns retrieved must be in the same order in each SELECT statement. 
2. The columns retrieved must be of similar data type.
3. There should be atleast two tables for the operation.

```sql
select deptno from emp
UNION 
select deptno from dept
```

![image](https://github.com/user-attachments/assets/a65c1de4-b185-45b4-8268-d5f72610d478)

```sql
select deptno from emp
INTERSECTION 
select deptno from dept
```

![image](https://github.com/user-attachments/assets/43db853d-18ad-4a26-9c81-68225067595a)

```sql
-- EXCEPT: similar to set difference operation. 
-- (In Oracle MINUS is used)

select deptno from dept
MINUS 
select deptno from emp
```
![image](https://github.com/user-attachments/assets/7677a9f8-af86-497c-bf46-3af76741f442)

### IV. Window functions: ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE(), LAG(), LEAD()

- Window functions aggregate or perform calculations over a set of rows(window).
- **ROW_NUMBER**

```sql
-- ROW_NUMBER() assigns a sequential integer (1,2,3…) to each row of a result set, starting with 1 for the first row of each partition(window).
select 
    ROW_NUMBER() over (
        PARTITION BY deptno     -- optional clause
        order by sal            -- mandatory clause
    ) row_number,
    deptno, ename, sal
from emp
ORDER BY deptno
```
![image](https://github.com/user-attachments/assets/fb7dce87-acbc-4e1a-b429-5e599c52dc9f)

- **RANK, DENSE_RANK**

```sql
select 
    ename, sal,
    RANK() over (order by sal desc) rank,   --> skips some ranks if indistinct values found(same values are always given same ranks)
    DENSE_RANK() over (order by sal desc) dense_rank    --> keeps the ranks sequential and starts by +1 with prev rank
from emp
```
![image](https://github.com/user-attachments/assets/67a6e0c6-5080-4c25-95a9-f8c0d4fdca84)

- **NTILE**

NTILE() divides the table into N groups with almost equal rows.
```sql
select NTILE(4) over (
    order by hiredate
    ) tileno, 
    ename, 
    hiredate
from emp
```
![image](https://github.com/user-attachments/assets/aa5e900a-d01a-4ec2-93fd-482082fd8080)
- **LAG, LEAD**

Get preceding and succeeding value of any row within its partition. These functions are termed as _nonaggregate Window functions._

Used to compare data of any row with its next or previous value.

```sql
-- Find the last hired job based on the department

select empno, 
    ename, 
    hiredate, 
    deptno,
    job, 
    LAG(job, 1) over (
        PARTITION BY deptno
        order by hiredate
    ) last_hired_role
from emp
order by hiredate
```
![image](https://github.com/user-attachments/assets/c3329243-dc35-4ca0-8ac4-f5f33e535f78)

### V. CTEs and Recursive queries

A **Common Table Expression (CTE)** is the result set of a query which exists temporarily and for use only within the context of a larger query. Much like a derived table, the result of a CTE is not stored and exists only for the duration of the query.
[Resource](https://www.atlassian.com/data/sql/using-common-table-expressions)

Reduces Complexity of the query.

![image](https://github.com/user-attachments/assets/d52b5ded-f931-44bb-83c0-289c4197c60d)


```sql
with student_marks
as (
    select name, avg(percentage) as avg_marks
    from student
    group by name
)

select name, avg_marks 
from student_marks 
where avg_marks > 90
```
![image](https://github.com/user-attachments/assets/7775ef23-320c-43ff-aec9-5bd47a684ace)


**Recursive Queries**

Performed using CTEs that refer to themselves.

For table -
![image](https://github.com/user-attachments/assets/3267e390-ddf9-4808-a4e6-26ad96667eb6)

```sql
WITH EmployeeHierarchy (employee_id, employee_name, manager_id, emp_level) AS (
    -- Base Case
    SELECT employee_id, name AS employee_name, manager_id, 0 AS emp_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case
    SELECT e.employee_id, e.name AS employee_name, e.manager_id, eh.emp_level + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT *
FROM EmployeeHierarchy
ORDER BY emp_level, employee_name;
```
![image](https://github.com/user-attachments/assets/7bf8be7b-7afc-4d16-a2bd-59c4a2c384d0)


### VI. Pivoting and Unpivoting data

**Pivoting:** Aggregating data by converting rows of a table into columns to summarize data.

| Month    | Product | Sales |
| -------- | ------- | ----- |
| January  | A       | 100   |
| January  | B       | 150   |
| February | A       | 200   |
| February | B       | 250   |

```sql
select *
from (
    select month, product, sales
    from sales
)
PIVOT (
    SUM(sales)
    for product in ('A', 'B')
) pivotTable
```

| Month    | A         | B     |
| -------- | -------   | ----- |
| January  | 100       | 150   |
| February | 200       | 250   |


**Unpivoting:** Converting specific columns to rows to normalize or prepare data.

| Month    | A         | B     |
| -------- | -------   | ----- |
| January  | 100       | 150   |
| February | 200       | 250   |

```sql
WITH pivotTable
AS (
    select *
    from (
        select month, product, sales
        from sales
    )
    PIVOT (
        SUM(sales)
        for product in ('A' as A, 'B' as B)
    )
)

select month, product, sales from (
    select month, A, B from (
        pivotTable      -- derived from above CTE
    )
)
UNPIVOT (
    sales for product in (A, B)
) unpivotTable
```

| Month    | Product | Sales |
| -------- | ------- | ----- |
| January  | A       | 100   |
| January  | B       | 150   |
| February | A       | 200   |
| February | B       | 250   |
