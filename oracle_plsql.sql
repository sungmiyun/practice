PL/SQL
PL/SQL�� Procedural language extension to Structured Query Language(SQL)�� ����
SQL�� Ȯ���� ������ ó�� ���

PL/SQL�� �⺻ ����
�����(declarative part) : ����� ������ ����� ����(����ο��� ������ ��� ���� ����)
�����(executable part) : ���� ó���� ������ ����ϴ� �κ�
����ó����(exception-building part) : ����ο��� ������ ó���ϴ� �� �߻��� �� �ִ� ���� �����鿡 ���� ó��

�⺻ ����
begin
    dbms_output.put_line('Hello World');
end;

declare
 --������ ������ �� �ִ� �����
  message VARCHAR2(100);
begin
 --����ο��� ����� ������ ����ο��� �̸� ����Ǿ�� ��
 message := 'Hello World!!';
  dbms_output.put_line(message);
end;

declare
  message VARCHAR2(100) := 'HELLO WORLD';
begin
  dbms_output.put_line(message);
end;

declare 
  counter INTEGER;
begin
  counter := counter + 1;
  if counter is null then 
    dbms_output.put_line('Result : counter is null');
  end if;
end;

�͸� ���(ANONYMOUS BLOCK)
declare 
  counter INTEGER;
  i INTEGER;
begin
  for i in 1..9 loop
    counter := (2 * i);
    dbms_output.put_line('2 * ' || i || ' = ' || counter);
  end loop;
end;


����ó����
declare
  counter INTEGER;
begin
  counter := 10;
  counter := counter / 0;
  dbms_output.put_line(counter);
exception when zero_divide then 
  dbms_output.put_line('errors');  
end;
  
�ݷ���
varray
varray�� variable array�� ���ڷ� ���� ����(fixed number)�� ���� �迭

declare
  type varray_test is varray(3) of integer;
  varray1 varray_test; --������ ������ varray_test Ÿ�� ����
begin
  varray1 := varray_test(10, 20, 30);
  
  dbms_output.put_line(varray1(1));
  dbms_output.put_line(varray1(2));
  dbms_output.put_line(varray1(3));
end;

��ø ���̺�
��ø ���̺��� varray�� ��������� ����ÿ� ��ü ũ�⸦ ����� �ʿ䰡 ����

declare
  type nested_test is table of varchar2(10);
  nested1 nested_test; --������ ������ nested_test Ÿ���� ����
begin
  nested1 := nested_test('A', 'B', 'C', 'D');
  
  dbms_output.put_line(nested1(1));
  dbms_output.put_line(nested1(2));
  dbms_output.put_line(nested1(3));
  dbms_output.put_line(nested1(4));
end;

Associative array(index-by table)
Associative array(���� �迭)�� index-by table �̶�� �ϸ� Ű�� ���� ������ ������ �ݷ������� 
�ϳ��� Ű�� �ϳ��� ���� ����

declare
  type assoc_array_num is table of number index by pls_integer;
  --Ű�� pls_integer�� �̸�, ���� number���� ��ҵ�� ����
  assoc1 assoc_array_num; --���� ������ assoc_array_num Ÿ�Ժ���
begin
  assoc1(3) := 33; --assoc_array_num�� Ű�� 3, ���� 33
  
  dbms_output.put_line( assoc1(3));
end;


declare
  type assoc_array_str is table of varchar2(32) index by varchar2(64);
  --Ű�� varchar2(64)���̸�, ���� varchar2(32)���� ��ҵ�� ����
  assoc2 assoc_array_str;
begin
  assoc2('K') := 'Korea';
  
  dbms_output.put_line(assoc2('K'));
end;


�ݷ����� �����ͺ��̽� ��ü�� ����
create type alphabet_type as varray(26) of varchar2(2);

declare
  test_alph alphabet_type;
begin
  test_alph := alphabet_type('A', 'B', 'C', 'D');
  
  dbms_output.put_line(test_alph(1));
  dbms_output.put_line(test_alph(2));
  dbms_output.put_line(test_alph(3));
  dbms_output.put_line(test_alph(4));
end;

���ڵ�
���� �ٸ� ������ Ÿ���� ���� �� �ִ�.

declare
  type record1 is record (deptno number not null := 50, 
                                dname varchar2(14), 
                                 loc varchar2(13));
  rec1 record1;
begin
  --record1 Ÿ���� ���ڵ� ���� rec1�� dname �ʵ忡 �� �Ҵ�
  rec1.dname := 'RECORD';
  --record1 Ÿ���� ���ڵ� ���� rec1�� loc�ʵ忡 �� �Ҵ�
  rec1.loc := 'SEOUL';
  
  --rec1 ���ڵ� ���� dept ���̺� insert
  INSERT INTO dept VALUES rec1;
  
  COMMIT;
exception when others then
  ROLLBACK;
end;


PL/SQL ����


if��

declare
  grade char(1);
begin
  grade := 'B';
  if grade = 'A' then
    dbms_output.put_line('Excellent');
   elsif grade = 'B' then
     dbms_output.put_line('Good');
   elsif grade = 'C' then
     dbms_output.put_line('Fair');
   elsif grade = 'D' then
     dbms_output.put_line('Poor');
  end if;
end;

case��

declare
  grade char(1);
begin
  grade := 'B';
  
  case grade when 'A' then dbms_output.put_line('Excellent');
             when 'B' then dbms_output.put_line('Good');
             when 'C' then dbms_output.put_line('Fair');
             when 'D' then dbms_output.put_line('Poor'); 
             else dbms_output.put_line('Not Found');
  end case;
  
end;

loop��

declare
  test_number integer;
  result_num integer;
begin
  test_number := 1;
  loop
    result_num := 2 * test_number;
    if result_num > 20 then
      exit; --�� ����
    else 
      dbms_output.put_line(result_num);
    end if;
    test_number := test_number + 1;
  end loop;
end;

declare
  test_number integer;
  result_num integer;
begin
  test_number := 1;
  
  loop
    result_num := 2 * test_number;
    
    exit when result_num > 20;
    dbms_output.put_line(result_num);
    test_number := test_number + 1;
  end loop;
  
end;


while - loop��

declare
  test_number integer;
  result_num integer;
begin
  test_number := 1;
  result_num := 0;
  
  while result_num < 20 loop
    result_num := 2 * test_number;
    dbms_output.put_line(result_num);
    test_number := test_number + 1;
  end loop; 
end;

for - loop��

declare
  test_number integer;
  result_num integer;
begin
  test_number := 1;
  result_num := 0;
  
  for test_number in 1..10 loop
    result_num := 2 * test_number;
    dbms_output.put_line(result_num);
  end loop;
end;

Ŀ��(cursor)
select���� �̿��ؼ� ��������� ��ȯ�ް� �Ǵµ� �޸𸮿� ��������� Ŀ��(cursor)�� ����ؼ� �� ������տ� ������

declare
  cursor emp_csr is
  select empno
  from emp
  where deptno = 10;
  
  emp_no emp.empno%type;
  
begin
  open emp_csr;
  
  loop
    fetch emp_csr into emp_no;
    -- %notfound : Ŀ�������� ��� ������ �Ӽ�.
    -- �� �̻� ��ġ(�Ҵ�)�� �ο찡 ������ �ǹ�
    exit when emp_csr%notfound;
    dbms_output.put_line(emp_no);
  end loop;
  close emp_csr;
end;


PL/SQL �������α׷�
���� ���ν����� �Լ�

�Լ�

�Է¹��� �����κ��� 10%�� ������ ��� �Լ�
create or replace function tax(p_value in number)
    return number 
is 
begin
    return (p_value * 0.1);
end;

SELECT TAX(100) FROM dual;
SELECT sal, TAX(sal) tax, sal-TAX(sal) "�Ǳ޿�" FROM emp;



�޿��� Ŀ�̼��� ���ļ� ������ ���
create or replace function tax2(p_sal in emp.sal%type, p_bonus emp.comm%type)
    return number
is
begin
  return ((p_sal + NVL(p_bonus, 0)) * 0.1);
end;

SELECT empno, ename, sal, comm, TAX2(sal, comm) AS tax
FROM emp;

�޿�(Ŀ�̼� ����)�� ���� ������ ������ ���� ������. �޿��� �� $1,000���� ������ ������ 5% �����ϸ�,
$1,000 �̻� $2,000���ϸ� 10%, $2,000�� �ʰ��ϸ� 20%�� ������
create or replace function tax3(p_sal in emp.sal%type,
                                p_bonus emp.comm%type)
    return number
is
  sum2 number;
  tax number;
begin
  sum2 := p_sal + NVL(p_bonus, 0);
  
  if sum2 < 1000 then
    tax := sum2 * 0.05;
  elsif sum2 <= 2000 then
    tax := sum2 * 0.1;
  else
    tax := sum2 * 0.2;
  end if;
  
  return tax;
end;

SELECT empno, ename, sal, comm, TAX3(sal, comm) AS tax 
FROM emp;


�����ȣ�� ���ؼ� �޿��� �˷��ִ� �Լ�
create or replace function emp_salaries(emp_no number)
    return number is
    nSalaries number (9);
begin
  nSalaries := 0;
  SELECT sal 
  INTO  nSalaries
  FROM emp
  WHERE empno = emp_no;

  return nSalaries;
end;

SELECT emp_salaries(7369) FROM dual;


�μ���ȣ�� �����ϸ� �μ����� ���� �� �ִ� �Լ�
create or replace function get_dept_name(dept_no number)
    return varchar2 is
    sDeptName varchar2(30);
begin
  SELECT dname
  INTO sDeptName
  FROM dept
  WHERE deptno = dept_no;
  
  return sDeptName;
end;

SELECT get_dept_name(50) FROM dual;

[�ǽ�����]
1) �� ���ڸ� �����ϸ� ������ �ؼ� ������� ��ȯ�ϴ� �Լ��� �����Ͻÿ�(add_num)
create or replace function add_num(num1 integer, num2 integer)
    return integer is
begin 
  return num1 + num2;
end;

SELECT add_num(4,5) FROM dual;

2) �μ���ȣ�� �Է��ϸ� �ش� �μ����� �ٹ��ϴ� ������� ��ȯ�ϴ� �Լ��� �����Ͻÿ�(get_emp_count)
create or replace function get_emp_count(dept_no emp.deptno%type)
    return integer is
    emp_count integer;
begin
  SELECT COUNT(*)count
  INTO emp_count
  FROM emp
  WHERE deptno = dept_no;
  
  return emp_count;
end;

SELECT deptno, dname, get_emp_count(deptno) ����� FROM dept;

3) emp���̺��� �̿��ؼ� �����ȣ�� �Է��ϸ� �ش� ����� ������ �̸��� ���ϴ� �Լ��� �����Ͻÿ�(get_mgr_name)
create or replace function get_mgr_name(emp_no emp.empno%type)
    return varchar2 is
    m_name varchar2(10);
    
begin
  SELECT ename
  INTO m_name
  FROM emp 
  WHERE empno = (SELECT mgr FROM emp WHERE empno = emp_no);

  return m_name;
end;

create or replace function get_mgr_name(emp_no emp.empno%type)
    return varchar2 is
    m_name varchar2(10);
begin
    SELECT m.ename
    INTO m_name
    FROM emp a, emp m
    WHERE a.mgr = m.empno
    AND a.empno = emp_no;
    
    return m_name;
end;

SELECT empno, ename, get_mgr_name(empno) "������ �̸�" FROM emp;

4) emp ���̺��� �Ի����� �Է��ϸ� �ٹ������� ���ϴ� �Լ��� �����Ͻÿ�.(�Ҽ��� �ڸ��� ���� trunc) (get_info_hiredate)
create or replace function get_info_hiredate(hire_date emp.hiredate%type)
    return number is
begin
    return TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12);
end;

SELECT ename, get_info_hiredate(hiredate) �ٹ����� FROM emp;

5) emp���̺��� �̿��ؼ� �����ȣ�� �Է��ϸ� �޿������ ���ϴ� �Լ��� �����Ͻÿ�.(get_sal_grade)
create or replace function get_sal_grade(emp_no emp.empno%type)
    return char is
    s_grade char(1);
begin
    SELECT CASE WHEN sal >=4000 AND sal <= 5000 THEN 'A'
                WHEN sal >=3000 AND sal < 4000 THEN 'B'
                WHEN sal >=2000 AND sal < 3000 THEN 'C'
                WHEN sal >=1000 AND sal < 2000 THEN 'D'
                ELSE 'F'
            END grade
    INTO s_grade
    FROM emp
    WHERE empno = emp_no;
    
    return s_grade;
end;
------------------------------------------------------
create or replace function get_sal_grade(emp_no emp.empno%type)
    return number is
    s_grade number;
begin
    SELECT s.grade
    INTO s_grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN s.losal AND s.hisal
    AND e.empno = emp_no;
    
    return s_grade;
end;

SELECT ename, sal, get_sal_grade(empno) �޿���� FROM emp;

6) �����ȣ�� �Է��ϸ� �ٹ��μ����� ���ϴ� �Լ�(find_dname)
create or replace function find_dname(emp_no emp.empno%type)
    return varchar2 is
    d_name varchar2(10);
begin
    SELECT d.dname
    INTO d_name
    FROM emp e INNER JOIN dept d
    ON e.deptno = d.deptno 
    AND e.empno = emp_no;
    
    return d_name;
end;

SELECT ename, empno, find_dname(empno) FROM emp;




���ν���
create or replace procedure hello_world 
is 
    message VARCHAR2(100);
begin
    message := 'Hello World';
    dbms_output.put_line(message);
end;

���ν��� ����
EXEC �Ǵ� EXECUTE ���ν�����(�Ķ����...);

exec hello_world;

create or replace procedure hello_world(p_message IN VARCHAR2)
is
begin
    dbms_output.put_line(p_message);
end;

exec hello_world('Korea');

�μ����̺� �μ������� �Է��ϴ� ���ν����� ����
create or replace procedure add_department(p_deptno in dept.deptno%type,
                                           p_dname in dept.dname%type,
                                           p_loc in dept.loc%type)
is
begin
    INSERT INTO dept
    VALUES (p_deptno, p_dname, p_loc);
    
    COMMIT;
    exception when others then
      dbms_output.put_line(p_dname || ' register is failed');
      ROLLBACK;
end;

exec add_department(60, 'IT SERVICE', 'BUSAN');
SELECT * FROM dept;

������̺� ��� ������ ����
create or replace procedure register_emp(e_empno emp.empno%type,
                                         e_ename emp.ename%type,
                                         e_job emp.job%type,
                                         e_mgr emp.mgr%type,
                                         e_sal emp.sal%type,
                                         e_comm emp.comm%type,
                                         e_deptno emp.deptno%type)
is
begin
    INSERT INTO emp VALUES(e_empno, e_ename, e_job, e_mgr, SYSDATE, e_sal, e_comm, e_deptno);
    
    COMMIT;
    exception when others then
        dbms_output.put_line(e_ename || ' register is failed');
        ROLLBACK;
end;

execute register_emp(9000, 'PETER', 'SALESMAN', 7788, 6000, 200, 30);
SELECT * FROM emp;

�μ���ȣ�� ���ؼ� �μ���� �μ��� ��ġ ���ϱ�
create or replace procedure output_department(p_deptno in dept.deptno%type)
is
    --��������
    d_dname dept.dname%type;
    d_loc dept.loc%type;
begin
    SELECT dname, loc
    INTO d_dname, d_loc
    FROM dept
    WHERE deptno = p_deptno;
    
    dbms_output.put_line(d_dname || ', ' || d_loc);
end;

exec output_department(60);

Ŀ�� �̿��ϱ�
Ŀ��(cursor)�� �̿��Ͽ� ���� ���� ��� ��ȯ�Ǵ� ���� ��(�������)�� ó��

create or replace procedure info_hiredate(p_year in varchar2)
is
    --%ROWTYPE : %ROWtype���� ������ Ÿ���� �����Ǿ� �ִ� ��� ���̺�(emp)�� 
    --          �ϳ��� ���� ������ ��� �÷��� ������ Ÿ���� ������
    e_emp emp%ROWTYPE;
    --Ŀ�� ����
    CURSOR emp_cur is 
        SELECT empno, ename, sal
        FROM emp
        WHERE TO_CHAR(hiredate, 'YYYY') = p_year;
begin
    OPEN emp_cur;
    loop
        fetch emp_cur into e_emp.empno, e_emp.ename, e_emp.sal;
        exit WHEN emp_cur%NOTFOUND; --���� ������ loop�� ����
        dbms_output.put_line(e_emp.empno || ', ' || e_emp.ename || ', ' || e_emp.sal);
    end loop;
    CLOSE emp_cur;
end;

exec info_hiredate('1981');

SALES �μ��� ���� ����� ���� ����
create or replace procedure emp_info(p_dept dept.dname%type)
is
    cursor emp_cur is
        SELECT empno, ename
        FROM emp e JOIN dept d
        ON e.deptno = d.deptno
        WHERE dname = UPPER(p_dept);
        
        --���� ����
        e_empno emp.empno%type;
        e_ename emp.ename%type;
begin
    open emp_cur;
    loop
        fetch emp_cur into e_empno, e_ename;
        exit when emp_cur%NOTFOUND;
        dbms_output.put_line(e_empno || ', ' || e_ename);
    end loop;
    close emp_cur;
end;

exec emp_info('SALES');

����ó��

create or replace procedure info_hiredate2(p_syear in char := null,
                                           p_eyear in char := null)
is
    --���� ����
    year_err EXCEPTION;
    --���� ����
    e_emp emp%ROWTYPE;
    --Ŀ���� ����
    cursor year_cur is
        SELECT empno, ename, hiredate
        FROM emp
        WHERE TO_CHAR(hiredate, 'YYYY') BETWEEN p_syear AND p_eyear;
begin
    --���ڷ� ���޵Ǵ� ������ ���� ��� ���ܰ� �߻�
    if ((p_syear IS NULL) OR (p_eyear IS NULL)) then
        RAISE year_err;
    end if;

    open year_cur;
    loop
        fetch year_cur into e_emp.empno, e_emp.ename, e_emp.hiredate;
        exit when year_cur%NOTFOUND; --���� ������ LOOP ����
        dbms_output.put_line(e_emp.empno ||', ' || e_emp.ename || ', ' || e_emp.hiredate);
    end loop;
    close year_cur;
    --����ó����
    exception when year_err then
        dbms_output.put_line('���� ���� �� ���� ������ ���� Ȯ���ϼ���!');
end;

exec info_hiredate2('1980', '1981');
exec info_hiredate2();

[�ǽ�����]

1) ������ �Է��Ͽ� �ش� ������ �����ϴ� ������� �����ȣ, �̸�, �޿�, ������ ����Ͻÿ�.
(���ν����� : job_info, Ŀ���� : emp_cur)
create or replace procedure job_info(p_job emp.job%type)
is
    e_emp emp%ROWTYPE;
    cursor emp_cur is
    SELECT deptno, ename, sal, job
    FROM emp
    WHERE job = p_job;    
begin
    open emp_cur;
    loop
        fetch emp_cur into e_emp.deptno, e_emp.ename, e_emp.sal, e_emp.job;
        exit when emp_cur%NOTFOUND;
        dbms_output.put_line(e_emp.deptno || ', ' || e_emp.ename || ', ' || e_emp.sal || ', ' || e_emp.job);        
    end loop;
    close emp_cur;
end;

exec job_info('MANAGER');


2) �����ȣ�� �� ������ �Է��ϸ� emp ���̺��� �ش� ����� ������ ������ �� �ִ� ���ν����� �ۼ��Ͻÿ�.
(���ν����� : change_job)
create or replace procedure change_job(e_empno emp.empno%type,
                                       e_job emp.job%type)
is
begin 
    UPDATE emp SET job = e_job WHERE empno = e_empno;
    
    COMMIT;
    exception when others then
        dbms_output.put_line(e_empno || ' update is failed');
        ROLLBACK;
end;

exec change_job(7369, 'DRIVER');
SELECT * FROM emp;

3) �μ� �̸��� �Է¹����� �ش� �μ��� ����� ���� �޿��� ���� ������ ������ ����
(���ν��� : emp_salary_info, Ŀ���� : emp_cur)
create or replace procedure emp_salary_info(p_dname dept.dname%type)
is
    --���� ����
    e_emp emp%ROWTYPE;
    cursor emp_cur is
     SELECT empno, ename, sal
     FROM emp e JOIN dept d
     ON e.deptno = d.deptno
     WHERE d.dname = p_dname
     ORDER BY sal DESC;
begin
    open emp_cur;
    loop
        fetch emp_cur into e_emp.empno, e_emp.ename, e_emp.sal;
        exit when emp_cur%NOTFOUND;
        dbms_output.put_line(e_emp.empno || ', ' || e_emp.ename || ', ' || e_emp.sal);
    end loop;
    close emp_cur;
end;

exec emp_salary_info('SALES');


























