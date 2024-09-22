# SQL-training

### 1. ER Diagram

Tables used - 
- Client
- Product
- SalesOrder
- Sales_Order_Detail

### 2. Basic SQL Commands

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

