Database : ���������� ����Ǵ� ������ ������ ����.
    DBMS : Database Managment Ststem, �����͸� ȿ�������� ������ �� �ִ� �ý���
           �����ͺ��̽��� �߰�, ����, ����, �˻�
    
    ������ ������ ���̽�(RDBMS)�� Ư¡
    1. SQL�� ���
    2. ���̺� ���
    3. ������ ���� ���

SQL : Standard Query Language 
      �����ͺ��̽����� �����͸� �˻�, ����, ����, ����
    SQL�� ����
        DDL(Data Definition Language) : �����Ϳ� �� ������ ����
            create, drop, alter
    DML(Data Manipulation Language) : �������� �˻��� �������� ó��
     INSERT : �����ͺ��̽� ��ü�� �����͸� �Է�
     DELETE : �����ͺ��̽� ��ü�� �����͸� ����
     UPDATE : ������ �����ϴ� �����ͺ��̽� ��ü���� ������ ����
     SELECT : �����ͺ��̽� ��ü�κ��� �����͸� �˻�
    
    DCL (Data Control Language) : �����ͺ��̽� ������� ������ ����
     grant, revoke
    
�����ͺ��̽��� �̸� ���� ��Ģ
1) ���ڷ� ����
2) 1~30�ڱ���
3) A~Z, a~z, 0~9, _, $, #�� �����ؾ���
4) ������ ����ڰ� ������ �ٸ� ��ü�� �̸��� �ߺ����� �ʾƾ� ��
5) ����Ŭ ������ ���� �ƴϿ�����.

    
    
SELECT��
    �����ͺ��̽��κ��� ����Ǿ� �ִ� �����͸� �˻��ϴµ� ���

��ü �÷����� ����ؼ� ��ü �� ������ �о��
    SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno FROM emp;
    * : ��ü �÷�
    SELECT * FROM emp;

Ư�� ��(�÷�) ����
    SELECT ename, sal FROM emp;

�ּ�
    SELECT * /*�ּ�*/ FROM emp; 

����
    SELECT ename, sal, sal + 300 FROM emp;

������ �켱����
    SELECT ename, sal, 12 * (sal + 300) FROM emp;

�� alias ����(�� �̸��� �ٲ�)
SELECT sal * 12 ASal  FROM emp;
SELECT sal * 12 as ASal FROM emp;
SELECT sal * 12 "Annual Salary" FROM emp;
�˸��ƽ��� ū����ǥ�� ����ϴ� ���
    - ��ҹ��� ������ ���� ��
    - ���� ���Խ�
    - _,#�� Ư������ ����
    - ���ڷ� ������ ���

���� ������
    ���̳� ���ڿ��� �ٸ� ���� ����
    �� ���� ���μ�(||)���� ��Ÿ��
    ��� ���� ���ڽ��� ����
        SELECT ename || ' has $' || sal FROM emp;

dual
    DUAL�� �Լ� �� ����� ����� �� �� ����� �� �ִ� ����(public) ���̺�
        SELECT ASCII('A') FROM dual;
        SELECT SYSDATE FROM dual;
        SElECT 7 + 10 FROM dual;

distinct : �ߺ��� ����
    SELECT distinct deptno FROM emp;
    SELECT distinct(deptno) FROM emp;
 
 [�ǽ�����]
 1) emp ���̺��� �����ȣ, ����̸�, ������ ����Ͻÿ�
 SELECT empno, ename, sal FROM emp; 
 2) emp ���̺��� ����̸��� ������ ����ϴµ� �÷����� "�� ��", "�� ��"���� �ٲ㼭 ����Ͻÿ�.
 SELECT ename as "�� ��", sal as "�� ��" FROM emp;
 3) emp ���̺��� �����ȣ, ����̸�, ����, ������ ���ϰ� ���� �÷����� "�����ȣ", "����̸�", "����", "����"���� ����Ͻÿ�.
 SELECT empno as "�����ȣ", ename as "����̸�", sal as "����", sal * 12 as "����" FROM emp; 
 4) emp ���̺��� ������ ������ ��ǥ(,)�� �����ؼ� ǥ���ϰ� �÷����� Employee and Job���� ǥ���Ͻÿ�.
 SELECT ename || ', ' || Job as "Employee and Job" FROM emp;



������ ����Ͽ� �� ����
<WHERE���� �˸��ƽ��� ����� �� ����>

SELECT * FROM emp WHERE deptno = 10;
SELECT ename, job, deptno FROM emp WHERE ename = 'SMITH';
SELECT * FROM emp WHERE hiredate > '81/12/03';
SELECT * FROM emp WHERE hiredate != '81/06/09';
SElECT * FROM emp WHERE hiredate ^= '81/06/09';
SELECT * FROM emp WHERE hiredate <> '81/06/09';

SELECT * FROM emp WHERE sal >= 1250 AND sal <= 3000;
BETWEEN ~ AND ~ : �� �� ����(������ �� ����)
    SELECT * FROM emp WHERE sal BETWEEN 1250 AND 3000;
    SELECT * FROM emp WHERE sal NOT BETWEEN 1250 AND 3000;

IN : �� ��� ���� ���� ��ġ
    SELECT * FROM emp WHERE sal IN (1300, 2450, 3000);
    SELECT * FROM emp WHERE sal NOT IN (1300, 2450, 3000);
    SELECT * FROM emp WHERE ename IN ('ALLEN', 'FORD');

LIKE : ������ �����͸� �˻�(������ �̿���)

    % : 0�� �̻��� ���ڸ� ��Ÿ��
    _ : �� ���ڸ� ��Ÿ��

    SELECT * FROM emp WHERE ename LIKE '%S%';
    SELECT * FROM emp WHERE ename NOT LIKE '%S%';
22�� ������ �Ի���
    SELECT * FROM emp WHERE hiredate LIKE '%22';
FOR ������ �� �� ����
    SELECT * FROM emp WHERE ename LIKE 'FOR_';

NULL ���� ���
    COMM = NULL�� ��� �Ұ���
    SELECT * FROM emp WHERE comm IS NULL;
    SELECT * FROM emp WHERE comm is NOT NULL;

��������(AND, OR, NOT)�� ����Ͽ� ���� ����
    SELECT empno, ename, job, sal FROM emp WHERE sal >= 2000 AND job LIKE '%MAN%';
 
 SELECT ename, job, sal FROM emp
 WHERE sal >= 3000 OR job = 'CLERK';
 
 SELECT ename, job FROM emp
 WHERE job NOT IN ('CLERK', 'SALESMAN');
 
[�ǽ�����]
1) �����ȣ�� 7900�� ����̸�, ����, �޿��� ����Ͻÿ�.
SELECT ename, job, sal FROM emp WHERE empno = 7900;
2) ����̸��� SMITH�� ����� �̸��� ����, �μ���ȣ�� ���Ͻÿ�.
SELECT ename, sal, empno FROM emp WHERE ename LIKE 'SMITH';
3) ������ 2500�̻� 3000�̸��� ����̸�, �Ի���, ������ ���Ͻÿ�.
SELECT ename, hiredate, sal FROM emp WHERE sal >=2500 AND sal < 3000;
4) �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����̸�, ����, �޿��� ����Ͻÿ�.
SELECT ename, job, sal FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;
5) 81�� 05�� 01�ϰ� 81�� 12�� 03�� ���̿� �Ի��� ����� �̸�, �޿�, �Ի����� ����Ͻÿ�.
SELECT ename, sal, hiredate FROM emp WHERE hiredate BETWEEN '81/05/01' AND '81/12/03';
6) �����ȣ�� 7566,7782,7934�� ����� ������ ������� �����ȣ, �̸�, ������ ����Ͻÿ�.
SELECT empno, ename, sal FROM emp WHERE empno NOT IN ('7566', '7782', '7934');
7) �μ���ȣ 30���� �ٹ��ϸ� �� 2,000�޷� ���ϸ� �޴� 81�� 5�� 1�� ������ �Ի��� ����� �̸�, �޿�, �μ���ȣ, �Ի����� ����Ͻÿ�.
SELECT ename, sal, deptno, hiredate FROM emp WHERE deptno = 30 AND sal <= 2000 AND hiredate < '81/05/01';
8) ����̸� �� s�� ���Ե��� ���� ����� �� �μ���ȣ�� 20�� ������� �̸��� �μ���ȣ�� ����Ͻÿ�.
SELECT ename, deptno FROM emp WHERE ename NOT LIKE '%S%' AND deptno = 20;

ORDER BY�� : ����

��������
    SELECT * FROM emp ORDER BY sal ASC;
    SELECT * FROM emp ORDER BY sal;
    SELECT * FROM emp ORDER BY ename ASC;

��������
    SELECT * FROM emp ORDER BY sal DESC;
    SELECT * FROM emp ORDER BY ename DESC;

1�� ���Ľ� �ߺ����� ������ �ߺ��� �� 2�� ������ ������ �� ����
    SELECT * FROM emp ORDER BY sal ASC, ename ASC;

�� alias�� �������� ����
    SELECT empno, ename, sal * 12 annsal FROM emp ORDER BY annsal;

���� ���� ��ġ�� ����Ͽ� ����
                1    ,  2 ,  3    , 4
        SELECT ename, job, deptno, hiredate FROM emp ORDER BY 3;
    ���̺� ������ ������� �� ���� ��ġ �ο�
        SELECT * FROM emp ORDER BY 2;

[�ǽ�����]
1) �����ȣ, ����̸�, �Ի����� ����ϴµ� �Ի����� ���� ��� ������ �����Ͻÿ�.
SELECT empno, ename, hiredate FROM emp ORDER BY hiredate;
2) ����̸�, �޿�, ������ ���ϰ� ������ ���� ������ �����Ͻÿ�.
SELECT ename, sal, sal * 12 FROM emp ORDER BY sal * 12 DESC;
3) 10�� �μ� �Ǵ� 20�� �μ����� �ٹ��ϰ� �ִ� ����� �̸��� �μ���ȣ�� ����ϴµ� �̸��� �����ڼ����� ǥ���Ͻÿ�
SELECT ename, deptno FROM emp WHERE deptno IN (10, 20) ORDER BY ename ASC;
4) Ŀ�̼� ����� ���� ��� ����� �̸�, �޿�, Ŀ�̼��� ����ϴµ� Ŀ�̼��� �������� �������� �����Ͻÿ�.
SELECT ename, sal, comm FROM emp WHERE comm IS NOT NULL ORDER BY comm DESC;


�Լ�

�����Լ�
    ��ҹ��� �����Լ� - LOWER, UPPER, INITCAP
     �ҹ��ڷ� ����
        SELECT LOWER('HELLO') FROM dual;
     �빮�ڷ� ����
        SELECT UPPER('hello') FROM dual;
      ù���ڸ� �빮�ڷ� ����
        SELECT INITCAP('hello wORLD') FROM dual;
        SELECT INITCAP(ename) FROM emp;

    ���� �����Լ� 
    CONCAT(���ڿ�1, ���ڿ�2) : ���ڿ�1�� ���ڿ�2�� �����Ͽ� �ϳ��� ���ڿ��� ��ȯ
        SELECT CONCAT('Hello', ' World') FROM dual;
        SELECT CONCAT(ename, job) FROM emp;
    SUBSTR(����ڿ�, �ε���) : ����ڿ����� ������ �ε������� ���ڿ��� ����
                        [����] �ε����� 1���� ����
        SELECT SUBSTR('Hello World', 3) FROM dual;
        SELECT SUBSTR(job, 4) FROM emp;
        ������ �ε������� 3���� ����
        SELECT SUBSTR('Hello World', 3, 3) FROM dual;
        �ڿ��� 3��°���� ������ ����
        SELECT SUBSTR('Hello World', -3) FROM dual;
        �ڿ��� 3��°�� �ΰ��� ����
        SELECT SUBSTR ('Hello World', -3, 2) FROM dual;
    LENGTH(����ڿ�) : ������ ����
        SELECT LENGTH('Hello World',-3,2)  FROM dual;
        SELECT ename, Length(ename) FROM emp;
    INSTR(����ڿ�, �˻�����) : �˻������� ��ġ �� �˻�
     SELECT INSTR('Hello World' , 'e') FROM dual;
    �˻����ڰ� ���� ��� 0
        SELECT INSTR('Hello World' , 'E') FROM dual;
        
        SELECT INSTR('Hello World', 'o' )FROM dual;
                            ����ڿ�, �˻�����, �˻� �ε��� , �ش���ġ���� �˻�
            SELECT INSTR('Hello Word', 'o', 6) FROM dual;
                            ����ڿ�, �˻�����, �Ļ��ε���, �ݺ� �ε���
         SELECT INSTR ('Hello World', 'o', '1', '2') FROM dual;
         
TRIM : ���ڿ����� �����̳� Ư�����ڸ� ������ ���� ���� ���� ��ȯ
`���� : ����->. leading ������ -> trailing �� -> both;
        SELECT TRIM (both 'h' from 'bshchh') FROM dual;
        
 REPLACE (����ڿ�, old, new) : ����ڿ����� old ���ڸ� new ���ڷ� ��ü
    SELECT REPLACE ('010.2936.0433', '.', '-') FROM dual;
        
�Լ� ��ø
SELECT ename, LOWER(SUBSTR(ename, 1, 3)) FROM emp;
        
 [�ǽ�]
 1) ����(job)�� ù���ڴ� �빮�� �������� �ҹ��ڷ� ����Ͻÿ�.
SELECT INITCAP(job) FROM emp;
 2) ����̸� �� A�� ���Ե� ����̸��� ���ϰ� �� �̸� �� �տ��� 3�ڸ� �����Ͽ� ����Ͻÿ�.
 SELECT SUBSTR(ename,1,3) FROM emp WHERE ename LIKE '%A%';
 3) �̸��� ����° ���ڰ� A�� ��� ����� �̸��� ǥ���Ͻÿ�.
 SELECT ename FROM emp WHERE SUBSTR(ename, 3,1) = 'A';
 4) �̸��� ���ڼ��� 6�� �̻��� ����� �̸��� �ҹ��ڷ� �̸��� ����Ͻÿ�.
SELECT LOWER(ename) FROM emp WHERE LENGTH(ename) >= 6;       
        
�����Լ�
    CEIL(����) : �ø� ó���� �������� ��ȯ
        SELECT CEIL(1.4) FROM dual;
    ROUND(����, �����ڸ���) : �ݿø�
        SELECT ROUND(45.926) FROM dual;
        SELECT ROUND(45.926, 2) FROM dual;
    TRUNC(����, �����ڸ���) : ����
        SELECT TRUNC(45.926, 2) FROM dual;
        SELECT TRUNC(45.926) FROM dual;
    MOD(����, ��������) : ������ ��
        17 %2�� ����
        SELECT MOD(17, 2) FROM dual;
        
��¥�Լ�
    SYSDATE : ORACLE ������ ���� ��¥�� �ð��� ��ȯ
        SELECT SYSDATE FROM dual;
        
��¥�� ��������� ���
    SELECT ename, (SYSDATE - hiredate)/7 AS WEEKS FROM emp WHERE deptno = 10;        
        
     MONTHS_BETWEEN : �� ��¥ ���� �� ��
        SELECT MONTHS_BETWEEN('2012-03-23', '2010-01-23') FROM dual;
        SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) FROM emp;
     ADD_MONTHS : Ư�� ��¥�� ���� ������ ���� ���� �ش� ��¥�� ��ȯ�ϴ� �Լ�
        SELECT ADD_MONTHS('2021-01-20', 8) FROM dual;
     NEXT_DAY : ������ ������ ���� ��¥
        SELECT NEXT_DAY('2021-01-05', '������') FROM dual;
     LAST_DAY : ���� ������ ��
        SELECT LAST_DAY('2021-01-20') FROM dual;
        SELECT LAST_DAY(SYSDATE) FROM dual;
     EXTRACT : ��¥ �������� Ư���� ����, ��, ��, �ð�, ��, �� ���� ����
        SELECT EXTRACT(YEAR FROM SYSDATE) YEAR,
               EXTRACT(MONTH FROM SYSDATE) MONTH,
               EXTRACT(DAY FROM SYSDATE) DAY FROM dual;
      
��ȯ�Լ�
  ��������� ������ ���� ��ȯ
    TO_NUMBER : ���� -> ����
    TO_CHAR : ���� -> ����, ��¥ -> ����
    TO_DATE : ���� -> ��¥
    
    TO_CHAR
    ��¥ -> ����
     SELECT TO_CHAR(��¥, ���˹���) FROM ���̺��;
        SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM dual;

    ����-> ����
     ���� �ڸ����� ��ġ
       SELECT TO_CHAR(1234,9999) FROM dual;
       SELECT TO_CHAR(1234, '9999') FROM dual;
      ##���� ��µǴ� ���� �߻�
       SELECT TO_CHAR(1234, 0000) FROM dual;
       SELECT TO_CHAR(1234, '0000') FROM dual;
     �ڸ����� ���ڶ� -> ####
       SELECT TO_CHAR(1234, 999) FROM dual;
       SELECT TO_CHAR(1234, '999') FROM dual;
       SELECT TO_CHAR(1234, '000') FROM dual;
     ���� �ڸ������� ���� �ڸ��� ���� => �ټ��ڸ��� Ȯ���ϰ� ù�ڸ��� ����ΰ� ���ڸ� ǥ��
       SELECT TO_CHAR(1234, 99999) FROM dual;
       SELECT TO_CHAR(1234, '99999') FROM dual;
     �ټ��ڸ��� Ȯ���ϰ� ù�ڸ��� 0���� ä��� ���� ǥ�� 01234
       SELECT TO_CHAR(1234, '00000') FROM dual; 
     �Ҽ��� �ڸ� 
       SELECT TO_CHAR(1234, 9999.99) FROM dual;
       SELECT TO_CHAR(1234, '9999.99') FROM dual;
       SELECT TO_CHAR(1234, '0000.00') FROM dual;
     �ݿø��ؼ� �Ҽ��� ��°�ڸ����� ǥ��
       SELECT TO_CHAR(25.897, '99.99') FROM dual;
       SELECT TO_CHAR(sal * 1.15, '9999.9') FROM emp; 
       SELECT TO_CHAR(sal * 1.15, '9999') FROM emp; 
     ��ȭǥ�� 
       SELECT TO_CHAR(1234, '$0000') FROM dual;
                            ������ȭǥ��
       SELECT TO_CHAR(1234, 'L0000') FROM dual;
     
    TO_DATE
        SELECT TO_DATE('21-01-20', 'YYYY-MM-DD') FROM dual;
        
    TO_NUMBER
        SELECT TO_NUMBER('100', '999') FROM dual;
        SELECT TO_NUMBER('100', '000') FROM dual;
         �������� ���� ����
        SELECT TO_NUMBER('100') FROM dual;
        
�Ϲ��Լ�

    NVL(value1, value2) : value1�� null�̸� value2�� ���. value1�� value2�� �ڷ����� ��ġ
        SELECT * FROM emp;
        SELECT ename, sal, sal + NVL(comm,0) �Ǳ޿� FROM emp;
        SELECT ename, NVL(TO_CHAR(comm), 'No Commission') "COMM." FROM emp;        
        
    NVL2(value1, value2, value3) : value1�� null���� ��. null�̸� value3, null�� �ƴϸ� value2
                                   �ڷ����� ��ġ���� �ʾƵ� ��
        SELECT ename, NVL2(comm, 'Commission', 'No Commission') FROM emp;
    
    NULLIF(value1, value2) : �� ���� ���� ��ġ�ϸ� NULL, �� ���� ���� ��ġ���� ������ value1
        SELECT ename, NULLIF(LENGTH(ename), LENGTH(job)) "NULLIF" FROM emp;
    
    COALESCE(value1, value2, value3,....) : null���� �ƴ� ���� ���(�ڷ��� ��ġ)
        SELECT comm, sal, COALESCE(comm, sal, 0) FROM emp;
        
    CASE �÷� WHEN �񱳰� THEN �����
             WHEN �񱳰� THEN �����
             WHEN �񱳰� THEN �����
             (ElSE �����)
    END
    
    SELECT ename, sal, job, 
        CASE job WHEN 'SALESMAN' THEN sal * 0.1
                 WHEN 'MANAGER' THEN sal * 0.2
                 WHEN 'ANALYST' THEN sal * 0.3
                 ELSE sal * 0.4
        END "Bonus"
    FROM emp;
        
    SELECT ename, sal, job,
        CASE WHEN sal >= 4000 AND sal <= 5000 THEN 'A'
             WHEN sal >= 3000 AND sal < 4000 THEN 'B'
             WHEN sal >= 2000 AND sal < 3000 THEN 'C'
             WHEN sal >= 1000 AND sal < 2000 THEN 'D'
             ELSE 'F'
        END "Grade"
    FROM emp ORDER BY "Grade", sal DESC;
        
    DECODE(ORACLE ����) : = �񱳸� ����
    DECODE(�÷�, �񱳰�, ��ȯ��,
                �񱳰�, ��ȯ��,
                �񱳰�, ��ȯ��,
                ��ȯ��)
        
    SELECT ename, sal, job,
        DECODE(job, 'SALESMAN', sal * 0.1,
                    'MANAGER', sal * 0.2,
                    'ANALYST', sal * 0.3,
                    sal * 0.4) "Bonus"
    FROM emp;
                    
    SELECT ename, sal, job,
        DECODE(TRUNC(sal/1000), 5, 'A',
                                4, 'A',
                                3, 'B',
                                2, 'C',
                                1, 'D',
                                'F') "Grade"
    FROM emp ORDER BY "Grade", sal DESC;
                                
[�ǽ�����]
1) �� ����� ���� �����ȣ, �̸�, �޿� �� 15% �λ�� �޿� (New salary)�� ����(�ݿø�)�� ǥ���Ͻÿ�.
SELECT empno, ename, sal, ROUND(sal + sal * 0.15) "New salary" FROM emp;
SELECT empno, ename, sal, ROUND(sal * 1.15) "New salary" FROM emp;
SELECT empno, ename, sal, TO_CHAR(sal * 1.15, '9999') "New salary" FROM emp;
2) �� ����� �̸��� ǥ���ϰ� �ٹ� �� ��(�Ի��Ϸκ��� ��������� �� ��)�� ����Ͽ� 
 �����̺��� MONTHS_WORKED�� �����Ͻÿ�. ����� ������ �ݿø��Ͽ� ǥ���ϰ� �ٹ� �� ���� �������� �������� ����
 SELECT ename, ROUND(MONTHS_BETWEEN(SYSDATE, hiredate)) "MONTHS_WORKED" FROM emp ORDER BY MONTHS_WORKED ASC;
 SELECT ename, TO_CHAR(MONTHS_BETWEEN(SYSDATE, hiredate), '999') "MONTHS_WORKED" FROM emp ORDER BY MONTHS_WORKED ASC;
3) �̸��� �ҹ��ڷ� ǥ��, ����, �ٹ������� ����Ͻÿ�.
SELECT LOWER(ename), job, TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate) / 12) �ٹ����� FROM emp;
4) ����̸�, ����, ���ް� Ŀ�̼��� ���� ���� �÷��� �Ǳ޿�����ؼ� ����Ͻÿ�.
SELECT ename, job, sal + NVL(comm,0) "�Ǳ޿�" FROM emp;
        
        
�׷��Լ� 
�׷��Լ��� �� ���� ������ �����Ͽ� �׷캰�� �ϳ��� ����� ����

AVG() : NULL�� ������ ��� ������ ����� ��ȯ, NULL���� ��հ�꿡�� ���õ�
    SELECT AVG(sal) FROM emp;
        
COUNT() : NULL�� ������ ���� ���� ��� ���ڵ��� ���� ��ȯ, COUNT(*) ������ ����ϸ� NULL�� ��꿡 ����
  NULL�� ������ ���� ���� ��� ���ڵ� �� ��ȯ COUNT(comm) -> 4
    SELECT COUNT(comm) FROM emp;
  NULL�� ��꿡 ���� COUNT(*) -> 14
    SELECT COUNT(*) FROM emp;
 
MAX() : ���ڵ� ���� �ִ� ���� �� �� ���� ū ���� ��ȯ
    SELECT MAX(sal) FROM emp;
    SELECT MAX(ename) FROM emp;
    
MIN() : ���ڵ� ���� �ִ� ���� �� �� ���� ���� ���� ��ȯ
    SELECT MIN(sal) FROM emp;
    SELECT MIN(ename) FROM emp;

SUM() : ���ڵ���� �����ϰ� �ִ� ��� ���� ���Ͽ� ��ȯ
    SELECT SUM(sal) FROM emp;
    
    SELECT MAX(sal), MIN(sal), ROUND(AVG(sal)), SUM(sal) FROM emp;
    SELECT MAX(sal), MIN(sal), ROUND(AVG(sal)), SUM(sal) FROM emp WHERE deptno = 10;
    
   20�� �μ����� ���ϴ� ����� �� 
    SELECT COUNT(*) FROM emp WHERE deptno = 20;
   30�� �μ����� ���ϴ� ����� ��
    SELECT COUNT(ename) FROM emp WHERE deptno = 30;

GROUP BY & HAVING    
SELECT���� �׷��Լ��� ������ �� ���� �÷��� ������ �� ����.         
���� �÷��� ������ ��쿡�� �ݵ�� GROUP BY ���� ������ �÷��� ����
   �μ��� �ִ� �޿�
    SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;
   �μ��� ��� ��
    SELECT deptno, COUNT(empno) FROM emp GROUP BY deptno;
   ���� ������ GROUP BY �� ���
    SELECT deptno, job, SUM(sal) FROM emp GROUP BY deptno, job ORDER BY deptno, job;      

HAVING : �׷� ó�� ����� �����ϰ��� �� �� HAVING�� �̿�
    HAVING���� �˸��ƽ� ����� �� �� ����
    <���� �߻�>
       SELECT deptno, AVG(sal) FROM emp 
       WHERE AVG(sal) >= 2000
       GROUP BY deptno;
    <���󱸹�>
       SELECT deptno, AVG(sal) FROM emp 
       GROUP BY deptno
       HAVING AVG(sal) >= 2000;
 
       SELECT deptno, MAX(sal) FROM emp
       GROUP BY deptno
       HAVING MAX(sal) > 3000;
 
 �׷��Լ��� ��ø
    SELECT MAX(AVG(sal)) FROM emp GROUP BY deptno;
 
 [�ǽ�����]
 1) ��� ����� �޿� �ְ��, �Ѿ� �� ��վ��� ǥ���Ͻÿ�. �����̺��� ���� maximum, minimum, sum, average��
 �����ϰ� ����� ������ �ݿø��ϰ� ���ڸ� ������ ,�� ����Ͻÿ�.
 SELECT TO_CHAR(MAX(sal), '9,999') maximum, MIN(sal) minimum,
        TO_CHAR(SUM(sal), '99,999') sum, TO_CHAR(AVG(sal), '9,999') average FROM emp;
 2) ������ ������ ��� ���� ǥ���Ͻÿ�. (������ ��� �� ǥ��)
 SELECT job, COUNT(job) FROM emp GROUP BY job;
 3) 30�� �μ��� ������� ���Ͻÿ�.
 SELECT COUNT(*) FROM emp WHERE deptno = 30;
 4) ������ �ְ� ������ ���ϰ� ����, �ְ� ������ ����Ͻÿ�.
 SELECT job, MAX(sal) FROM emp GROUP BY job;
 5) �μ����� ���޵Ǵ� �ѿ��޿��� �ݾ��� 9,000�̻��� �޴� ����� �μ���ȣ, �ѿ����� ����Ͻÿ�.
 SELECT deptno, SUM(sal) FROM emp GROUP BY deptno HAVING SUM(sal) >= 9000;
 6) �������� ����� ���� 4�� �̻��� ������ �ο����� ����Ͻÿ�.
 SELECT job, COUNT(*) FROM emp GROUP BY job HAVING COUNT(*) >= 4;
 7) ������� 5���� �Ѵ� �μ��� �μ���ȣ�� ������� ���Ͻÿ�.
 SELECT deptno, COUNT(*) FROM emp GROUP BY deptno HAVING COUNT(*) > 5;
 
 JOIN
  �� �̻��� ���̺��� �����Ͽ� �����͸� �˻��ϴ� ���
 <ORACLE ����>
  ���� ����(Equal Join) : �������� Equality Condition(=)�� ���Ͽ� ������ �̷�� ��
  SELECT emp.ename, dept.dname FROM emp, dept WHERE emp.deptno = dept.deptno;

 ���̺� �˸��ƽ� �ο��ϱ�
 SELECT e.ename, d.dname FROM emp e, dept d  WHERE e.deptno = d.deptno;
 
 �߰����� ���� ����ϱ�
 SELECT e.ename, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno AND e.ename = 'ALLEN';
 
 SELECT e.ename, e.sal, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno AND e.sal BETWEEN 3000 AND 4000;

  �񵿵� ����(NON EQUI JOIN)
   ���̺��� � colium�� join�� ���̺��� column�� ��ġ���� ���� �� ����ϰ� ���� ������ 
   ����(=) �̿��� �����ڸ� ����(between and, is null, is not null, in not in)
   
   ����̸�, �޿�, �޿���� ���ϱ�(emp, salgrade ���̺� �̿�)
      SELECT e.ename, e.sal, s.grade
      FROM emp e, salgrade s
      WHERE e.sal BETWEEN s.losal AND s.hisal;
   
SELF JOIN 
����̸��� �ش� ����� ������ �̸� ���ϱ�(�����ڰ� ���� ����� ����)
SELECT e.ename ����̸�, m.ename �������̸�
FROM emp e, emp m
WHERE e.mgr = m.empno;
   
 �ܺ�����(Outer Join)
 equal join ����� �� ���� �������� �װ͵��� ������ �����Ϸ� �ϴ� �� ���� ���̺���
 �� ���� �÷����� ����� ���� ���ٸ� ���̺�κ��� �����͸� ��ȯ���� �ʴ´ٴ� ��.
 ���������� ���� ������ �������� ���ϴ� ����� �������� outer join�� ���
 
 ������ ���� �ݴ� ���̺� (+)��ȣ ǥ��
 SELECT distinct(e.deptno), d.deptno 
 FROM emp e, dept d 
 WHERE e.deptno(+) = d.deptno;
 
 ��� �̸��� �ش� ����� ������ �̸� ���ϱ�(�����ڰ� ���� ����� ǥ��)
 SELECT e.ename ����̸�, m.ename �������̸� 
 FROM emp e, emp m
 WHERE e.mgr = m.empno(+);
   
 
 [�ǽ�����]
 1) ��� ����� �̸�, �μ���ȣ, �μ��̸��� ǥ���Ͻÿ�. (emp, dept)
 SELECT e.ename, e.deptno, d.dname 
 FROM emp e, dept d 
 WHERE e.deptno = d.deptno;
 2) ������ MANAGER�� ����� ������ �̸�, ����, �μ���, �ٹ��� ������ ����Ͻÿ�. (emp,dept)
SELECT e.ename, e.job, d.dname, d.loc 
FROM emp e, dept d 
WHERE e.deptno = d.deptno AND e.job = 'MANAGER';         
 3) Ŀ�̼��� �ް� �޿��� 1,600�̻��� ����� ����̸�, �޿�, �μ���, �ٹ����� ����Ͻÿ�.
 SELECT e.ename, e.sal, d.dname, d.loc 
 FROM emp e, dept d 
 WHERE e.deptno = d.deptno AND e.comm IS NOT NULL AND e.sal >= 1600;
 4) �ٹ����� CHICAGO�� ��� ����� �̸�, ����, �μ���ȣ �� �μ� �̸��� ����Ͻÿ�.
 SELECT e.ename, e.job, d.deptno, d.dname 
 FROM emp e, dept d 
 WHERE e.deptno = d.deptno AND d.loc = 'CHICAGO';
 5) �ٹ������� �ٹ��ϴ� ����� ���� 5�� ������ ���, �ο��� ���� ���� ������ �����Ͻÿ�.
 (�ٹ��ο��� 0���� ���� ǥ��)
 SELECT d.loc, COUNT(e.empno) emp_member
 FROM emp e, dept d 
 WHERE e.deptno(+) = d.deptno 
 GROUP BY d.loc
 HAVING COUNT(e.empno) <= 5
 ORDER BY emp_member ASC;
 
 <ǥ�� SQL>
 
 ���� ����(Inner Join)
  SELECT e.ename, d.deptno FROM emp e INNER JOIN dept d ON e.deptno = d.deptno;
  SELECT e.ename, d.deptno FROM emp e JOIN dept d ON e.deptno = d.deptno;
 
 join ����� on���� �����ϰ� �ΰ����� ������ ������ where�� ���
   SELECT e.ename, d.dname
   FROM emp e JOIN dept d
   ON e.deptno = d.deptno
   WHERE e.ename = 'ALLEN';
 
 ���� ���� ���ǿ� ���� �÷��� �̸��� ���ٸ� ������ ���� USING���� ����Ͽ� ���� ������ ������ �� ����
 SELECT e.ename, d.dname
 FROM emp e JOIN dept d
 USING(deptno);

[����] USING�� ���� �÷��� ���̺�� �Ǵ� ���̺� �˸��ƽ��� ������ ����
SELECT e.ename, d.dname, deptno
FROM emp e JOIN dept d
USING(deptno);
 
 JOIN�� �� �ϳ��� ���̺��� �����ϴ� �÷��� ���̺�� �Ǵ� ���̺� �˸��ƽ��� ������ �ʾƵ� �ĺ� ����
 SELECT ename, dname, e.deptno
 FROM emp e JOIN dept d
 ON e.deptno = d.deptno;
 
 
 SELF JOIN
  ��� �̸��� �ش� ����� ������ �̸� ���ϱ�(������ ���� ����� ����)
  SELECT e.ename name, m.ename manager_name
  FROM emp e JOIN emp m
  ON e.mgr = m.empno;
 
  �ܺ� ����(Outer Join)
  ��� �̸��� �ش� ����� ������ �̸� ���ϱ�(�����ڰ� ���� ����� ����)
  SELECT e.ename name, m.ename manager_name
  FROM emp e LEFT OUTER JOIN emp m
  ON e.mgr = m.empno;
 
 [�ǽ�����]
 1) ��� ����� �̸�, �μ���ȣ, �μ��̸��� ǥ���Ͻÿ�. (emp, dept)
 SELECT e.ename, e.deptno, d.dname 
 FROM emp e INNER JOIN dept d 
 ON e.deptno = d.deptno;
 
 SELECT e.ename, deptno, d.dname 
 FROM emp e JOIN dept d 
 USING(deptno);
 2) �ٹ����� CHICAGO�� ��� ����� �̸�, ����, �μ� ��ȣ �� �μ� �̸��� ǥ���Ͻÿ�.
SELECT e.ename, e.job, e.deptno, d.dname
FROM emp e JOIN dept d 
ON e.deptno = d.deptno AND d.loc = 'CHICAGO';
 3) �ٹ������� �ٹ��ϴ� ����� ���� 5�� ������ ���, �ο��� ���� ���� ������ �����Ͻÿ�.(�ٹ��ο��� 0���� ���� ǥ��)
 SELECT d.loc,  COUNT(e.deptno) emp_member
 FROM emp e LEFT OUTER JOIN dept d
 ON e.deptno = d.deptno
 GROUP BY d.loc
 HAVING COUNT(e.empno) <= 5
 ORDER BY emp_member ASC;
 4) Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, �޿�+Ŀ�̼�, �޿������ ����ϴµ� 
 ������ Į������ "�����ȣ" "����̸�" "����" "�޿����"���� ����Ͻÿ�. �� Ŀ�̼��� null�� ���� �����ϰ� ���(emp, salgrade)
 SELECT e.empno "�����ȣ", e.ename "����̸�", e.sal * 12 "����", e.sal + NVL(e.comm, 0) "�Ǳ޿�", s.grade "�޿����"
 FROM emp e JOIN salgrade s
 ON e.sal BETWEEN s.losal AND s.hisal
 WHERE e.comm IS NOT NULL;
 
 
 ���տ�����
 
 UNION(������ �ߺ��� ����)
 SELECT deptno FROM emp
 UNION 
 SELECT deptno FROM dept;
 
 UNION ALL(������ �ߺ������� ��ȯ)
 SELECT deptno FROM emp
 UNION ALL
 SELECT deptno FROM dept;
 
 INTERSECT(������)
 SELECT deptno FROM emp
 INTERSECT
 SELECT deptno FROM dept;
 
 MINUS(������)
 SELECT deptno FROM dept
 MINUS 
 SELECT deptno FROM emp;
 
 Subquery
 SQL������ ���� ����Ǿ� �ִ� select����
 
 ������ �������� : ���� �� ���� ��(��)�� ��ȯ
 SELECT empno, ename, job FROM emp
 WHERE job = (SELECT job FROM emp WHERE empno = 7369);
 
 SELECT ename, sal FROM emp
 WHERE sal > (SELECT sal FROM emp WHERE ename = 'BLAKE');
 
 ���� �� �������� : �ϳ� �̻��� ���� ��ȯ�ϴ� ��������
 
 IN ������ ���
 
 �μ����� ���� �޿��� ���� �޴� ����� ������ �޿��� �޴� ����� ������ ���
 SELECT empno, ename, sal, deptno FROM emp
 WHERE sal IN (SELECT MIN(sal) FROM emp GROUP BY deptno);
 
 ANY �������� ���
 any �����ڴ� ���������� ����� �� ��� �ϳ��� ���̶� ������ �Ǹ� ������� ��ȯ
 SELECT ename, sal, job FROM emp
 WHERE sal > ANY(SELECT sal FROM emp WHERE job = 'SALESMAN');
 
 ALL �������� ���
 all �����ڴ� ���������� ����� ��� ���� ��ġ
 SELECT empno, ename, sal, deptno FROM emp
 WHERE sal > ALL(SELECT sal FROM emp WHERE deptno = 20);
 
 ���߿� ��������
 ���������� ����� �� �� �̻��� �÷����� ��ȯ�Ǿ� ���������� �����ϴ� ����
 SELECT empno, ename, sal, deptno FROM emp
 WHERE (deptno, sal) IN (SElECT deptno, sal FROM emp WHERE deptno = 30);
 
 [�ǽ�����]
 1) "BLAKE"�� ���� �μ��� �ִ� ������� �̸��� �Ի����� ���ϴµ� "BLAKE"�� �����ϰ� ���
 SELECT ename, hiredate FROM emp
 WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'BLAKE')
 AND ename != 'BLAKE';
 ----------------------------(BLAKE�� �������� ���)
  SELECT ename, hiredate FROM emp
 WHERE deptno IN (SELECT deptno FROM emp WHERE ename = 'BLAKE')
 AND ename != 'BLAKE';
 
 2) ��� �޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������ ����ϴµ� ������ ���� ��� ������ ���
 SELECT empno, ename, sal FROM emp
 WHERE sal > (SELECT AVG(sal) FROM emp)
 ORDER BY sal DESC;
 
 3) 10�� �μ����� �޿��� ���� ���� �޴� ����� ������ �޿��� �޴� ����� �̸��� ������ ���
 SELECT ename, sal FROM emp
 WHERE sal = (SELECT MIN(sal) FROM emp WHERE deptno = 10);
 
 4) ������� 3���� �Ѵ� �μ��� �μ���� ������� ���
 SELECT a.dname, b.cnt FROM dept a, ( SELECT deptno, COUNT(empno) cnt FROM emp GROUP BY deptno) b
 WHERE a.deptno = b.deptno AND b.cnt > 3;
 ---------------------------------------------
 SELECT d.dname, COUNT(e.empno) cnt 
 FROM emp e, dept d
 WHERE e.deptno = d.deptno
 GROUP BY d.dname
 HAVING COUNT(e.empno) > 3;
 
 5) �����ȣ�� 7844�� ������� ���� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�.
 SELECT ename, hiredate FROM emp 
 WHERE hiredate < (SELECT hiredate FROM emp WHERE empno = 7844);
 6) ���ӻ��(mgr)�� KING�� ��� ����� �̸��� �޿��� ����Ͻÿ�
 SELECT ename, sal FROM emp
 WHERE mgr = (SELECT empno FROM emp WHERE ename = 'KING');
 7) 20�� �μ����� ���� �޿��� ���� �޴� ����� ������ �޿��� �޴� ����� �̸��� �μ���, �޿�, �޿������ ����Ͻÿ�
 SELECT e.ename, d.dname, e.sal, s.grade FROM emp e , dept d, salgrade s
 WHERE e.deptno = d.deptno
 AND e.sal BETWEEN s.losal AND s.hisal 
 AND e.sal = (SELECT MAX(sal) FROM emp WHERE deptno = 20);
 --------------------------------------------------------------------------------
  SELECT e.ename, d.dname, e.sal, s.grade 
  FROM emp e JOIN dept d
  ON e.deptno = d.deptno
  JOIN salgrade s
  ON e.sal BETWEEN s.losal AND s.hisal 
  WHERE e.sal = (SELECT MAX(sal) FROM emp WHERE deptno = 20);
 8) �ѱ޿�(sal + comm)�� ��� �޿����� ���� �޿��� �޴� ����� �μ���ȣ, �̸�, �ѱ޿�, Ŀ�̼��� ����Ͻÿ�.
   (Ŀ�̼��� ��(o),��(x)�� ǥ���ϰ� �÷����� "comm����"�� ���)
SELECT deptno, ename, sal + NVL(comm, 0) AS �ѱ޿�, NVL2(comm, 'O', 'X') "comm����"
FROM emp
WHERE sal + NVL(comm, 0) > (SELECT AVG(sal) FROM emp );
----------------------------------------------------
SELECT deptno, ename, sal + NVL(comm, 0) AS �ѱ޿�,
        CASE WHEN comm IS NOT NULL THEN 'O'
            ELSE 'X'
        END AS comm����
FROM emp
WHERE sal + NVL(comm, 0) > (SELECT AVG(sal) FROM emp);
9) CHICAGO �������� �ٹ��ϴ� ����� ��� �޿����� ���� �޿��� �޴� ����� �̸��� �޿�, �������� ����Ͻÿ�.
SELECT e.ename, e.sal, d.loc
FROM emp e JOIN dept d
ON e.deptno = d.deptno 
WHERE e.sal > (SELECT AVG(sal) 
             FROM emp 
             WHERE deptno = (SELECT deptno 
                             FROM dept 
                             WHERE loc = 'CHICAGO'));
----------------------------------------------------------------
SELECT e.ename, e.sal, d.loc
FROM emp e JOIN dept d
ON e.deptno = d.deptno 
WHERE e.sal > (SELECT AVG(e.sal), d.loc 
               FROM emp e JOIN dept d 
               ON e.deptno = d.deptno
               WHRE d.loc = 'CHICAGO');
10) Ŀ�̼��� ���� ����� �� ������ ���� ���� ����� �̸��� �޿������ ����Ͻÿ�.
SELECT e.ename, s.grade
FROM emp e JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal
AND e.sal = (SELECT MAX(sal) FROM emp WHERE comm IS NULL);
11) SMITH�� ���� ���(mgr)�� �̸��� �μ���, �ٹ������� ����Ͻÿ�.
SELECT e.ename, d.dname, d.loc
FROM emp e JOIN dept d
USING(deptno)
WHERE e.empno IN (SELECT mgr FROM emp WHERE ename = 'SMITH');

 INSERT�� : ���̺� ���� ����
 
 ��ü ������ ����
 INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
 VALUES (8000, 'DENNIS', 'SALESMAN', 7698, '99/01/22', 1700, 200, 30);
 
 ��ü �����͸� ����� ���� �÷��� ���� ����
 INSERT INTO emp VALUES (8001, 'SUNNY', 'SALESMAN', 7698, '99/03/01', 1000, 300, 30);
 
 ���� �Էµ��� �ʴ� �÷��� ���� ���(insert���忡 �÷��� �� ����ؾ���)
 INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, deptno)
 VALUES(8002, 'PETER', 'CLERK', 7698, '99/05/02', 1800, 10);
 
 SELECT * FROM emp;
 
 UPDATE�� : ������� ������ ����
 UPDATE emp SET mgr = 7839 WHERE empno = 8000;
 UPDATE emp SET ename = 'MARIA', sal = 2500, comm = 500 WHERE empno = 8000;
 
 ��ü ���� �̸��� ����
 UPDATE emp SET ename = 'DENNIS';
 
 DELETE�� : ���� ����
 DELETE FROM emp WHERE empno = 8000;
 
 ��ü���� ������
 DELETE FROM emp;
 
 �۾��� ������ ���̺� �ݿ����� ����
 ROLLBACK;
 
 �����ͺ��̽� Ʈ�����
 Ʈ������� ������ ó���� �� ����
 Ʈ������� �����͸� �ϰ��ǰ� �����ϴ� DML�������� ������
 
 Ʈ������� ���� : ���� ������ SQL������ ���� ó�� ����� ��
 Ʈ������� ���� : COMMIT(������� ����)�̳� ROLLBACK(������� ���)
                 DDL�̳� DCL ������ ����(�ڵ� COMMIT)
                 ��� ��� �Ǵ� �ý��� �浹
 
 �����ͺ��̽� ��ü
 ���̺� : �⺻ ���� ������ ��� ���� ����
 ��     : �������� �ϳ� �̻��� ���̺� �ִ� �������� �κ� ������ ��Ÿ��
 ������ : ���� �� ������
 �ε��� : ������ ������ ���
 ���Ǿ� : ��ü�� �ٸ� �̸��� ����
 
 ���̺�
  : ���̺��� �⺻���� ������ ���� ����
    ���ڵ�� �÷����� ����
    ���ڵ�(record, row) : ���̺��� �����ʹ� �࿡ ����
    �÷�(column) : ���̺��� �� �÷��� �����͸� ������ �� �ִ� �Ӽ��� ǥ�� 
 
 ���̺� ����
 CREATE TABLE employee(
   empno number(8),
   name varchar2(20) not null,
   salary number(8,2),
   hire_date date default SYSDATE,
   constraint employee_pk primary key (empno)
 )0;
 
 primary key�� foreign key ���� ������ ������ ���̺� ����
 create table suser(
   id varchar2(20),
   name varchar2(20),
   constraint suser_pk primary key(id)
 );
 
 create table sboard(
  num number,
  id varchar2(20) not null,
  content varchar2(4000) not null,
  constraint sboard_pk primary key(num),
  constraint sboard_fk foreign key (id) references suser(id)
);

[�ǽ�����]
1) ���̺�� : student 
    �÷��� : id(varchar2(10), name(varchar2(30)), age(number(3)), score(number(3))
    �������� : primary key       not null           not null        not null
    
create table student(
    id varchar2(10),
    name varchar2(30) not null,
    age number(3) not null,
    score number(3) not null,
    constraint student_pk primary key(id)
);

2) ���̺�� : muser
    �÷��� : id,           name,          phone,          reg_date
    �ڷ��� : varchar2(10)   varchar2(30)    varchar2(15)      date
    �������� : primary key     not null                      not null
    
    ���̺�� : mboard
    �÷��� : num,         subject,        content,        favorite,          reg_date,      id
    �ڷ��� : number        varchar2(100)   varchar2(4000)    number(1)      date           varchar2(10)
    �������� : primary key    not null                                         not null      foreign key

create table muser(
    id varchar2(10),
    name varchar2(30) not null,
    phone varchar2(15),
    reg_date date not null,
    constraint muser_pk primary key(id)
);

create table mboard(
    num number,
    subject varchar2(100) not null,
    content varchar2(4000),
    favorite number(1),
    reg_date date not null,
    id varchar2(10),
    constraint mboard_pk primary key(num),
    constraint nboard_fk foreign key(id) references muser(id)
);
  
���̺��� ����
add ������ : ���̺� ���ο� �÷��� �߰�
alter table employee add(addr varchar2(50));

���� ���� �߰�
alter table employee add constraint employee_pk primary key (empno);
 
modify ������ : ���̺��� �÷��� �����ϰų� not null �÷����� ������ �� ����
alter table employee modify (salary number(10, 2) not null);
 
drop ������ : �÷��� ����
alter table employee drop column name;
 
�÷��� ����
alter table employee rename column salary to sal;
 
���̺�� ����
rename employee to employee2;
 
���̺��� ����
drop table employee2;
 
 
 
��(View)
������ ���Ǹ� ���� �ۼ��ϱ� ����
������ �������� �����ϱ� ����
������ �����ͷκ��� �پ��� ����� ��� ����

CREATE OR REPLACE VIEW emp10_view
AS SELECT empno id_number, ename name,
          sal * 12 ann_salary
    FROM emp
    WHERE deptno = 10;
    
SELECT * FROM emp10_view;
 
CREATE OR REPLACE VIEW emp_info_view 
AS SELECT e.empno, e.ename, d.deptno, d.loc, d.dname
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;

SELECT * FROM emp_info_view;
 
DROP VIEW emp10_view;

Sequence
������ ���� �������ִ� ����Ŭ ��ü
�������� �����ϸ� �⺻Ű�� ���� ���������� �����ϴ� �÷��� �ڵ������� ������ �� ����.
���� primary key ���� �����ϱ� ���� ���

CREATE SEQUENCE test_seq
start with 1
increment by 1
maxvalue 100000;

currval : ���� ���� ��ȯ
nextval : ���� ������ ���� ���� �� ��ȯ

SELECT test_seq.nextval FROM dual;
SELECT test_seq.currval FROM dual;

������ ����
DROP SEQUENCE test_seq;

�ε���(index)
�ε����� ���ϴ� ������ ��ġ�� ������, ��Ȯ�ϰ�, ���������� �˾Ƴ� �� �ִ� ����� �����Ѵ�.
���̺��� �÷��� ���� ���� ������ ������ �� Primary key�� Unique�� �����ϸ� Oracle�� �ڵ����� �� �÷��� ���� 
Unique Index�� �����Ѵ�.

������ ���� ������ �÷��� �ε��� ���� : Unique Index

CREATE UNIQUE INDEX dname_idx
ON dept (dname);

������ ���� ������ �ʴ� �÷��� �ε��� ���� : Non Unique Index

CREATE INDEX ename_idx
ON emp(ename);

���Ǿ�(Synonym)
���Ǿ�(��ü�� �ٸ� �̸�)�� �����Ͽ� ��ü �׼����� �ܼ�ȭ�Ѵ�.
�ٸ� ����ڰ� ������ ���̺��� ���� ����
�� ��ü �̸��� ª�� �����.

���Ǿ� ����
CREATE SYNONYM emp_view
FOR emp_info_view;

SELECT * FROM emp_view;

���Ǿ� ����
DROP SYNONYM emp_view;


 
 
 
�Ϲ� ���� ����
SQL PLUS(18c), RUN SQL Command Line(11g)
����ڸ� �Է� : system
��й�ȣ �Է� : oracle
SQL> conn /as sysdba
����Ǿ����ϴ�.
SQL> create user c##sunny identified by 1234;
����ڰ� �����Ǿ����ϴ�.
SQL> grant connect, dba, resource to c##sunny;
������ �ο��Ǿ����ϴ�.

��ȣ ����
ALTER USER scott IDENTIFIED BY lion;

����� ����
DROP USER scott;



[��Ʈ������]

 CREATE TABLE classinfo(
    class_no number(2),
    cname varchar2(30) not null,
    reg_date date default SYSDATE,
    constraint classinfo_pk primary key (class_no)
);
INSERT INTO classinfo VALUES(10, '���Թ�', '20/04/08');
INSERT INTO classinfo VALUES(20, '�޴Թ�', '20/04/08');
INSERT INTO classinfo VALUES(30, '�ɴԹ�', '20/04/08');
 
 CREATE TABLE studentinfo(
    id varchar2(10),
    name varchar2(30) not null,
    class_no number(2) not null,
    reg_date date default SYSDATE,
    constraint studentinfo_pk primary key (id),
    constraint studentinfo_fk foreign key (class_no) references classinfo(class_no)
);
INSERT INTO studentinfo VALUES ('dragon', '�ڹ���', 10, '20/04/08');
INSERT INTO studentinfo VALUES ('sky', '�念��', 10, '20/04/08');
INSERT INTO studentinfo VALUES ('blue', 'ȫ�浿', 20, '20/04/08');

SELECT s.id, c.class_no, c.cname 
FROM studentinfo s, classinfo c
WHERE s.class_no = c.class_no 
AND c.class_no = (SELECT class_no FROM studentinfo WHERE id = 'dragon');

drop table department;
drop table employee;

CREATE table department(
    dno number(2) primary key,
    dname varchar2(30) not null,
    loc varchar2(30)
);

CREATE table employee(
    num number(6) primary key,
    name varchar2(30) not null,
    job varchar2(30),
    sal number(7),
    dno number(2) not null,
    constraint employee_fk foreign key (dno) references department(dno)
);
 
 INSERT INTO department VALUES (10, '������', '����');
 INSERT INTO department VALUES (20, '����', '�λ�');
 INSERT INTO department VALUES (30, '�Ĵ�', '����');
 
 
 INSERT INTO employee VALUES (1000, '�ڹ���', '����', 1000000, 10);
 INSERT INTO employee VALUES (2000, '������', '�ǻ�', 2000000, 20);
 INSERT INTO employee VALUES (3000, '�̼���', '�丮��', 3000000, 30);
 
 SELECT * FROM employee;
 
 SELECT e.name, e.job, e.sal 
 FROM employee e JOIN department d
 ON e.dno = d.dno
 WHERE d.dname = '������';
 
 SELECT e.name, e.job, e.sal, d.dname, d.loc
 FROM employee e JOIN department d
 ON e.dno = d.dno
 WHERE sal >= (SELECT AVG(sal) FROM employee);
 
 SELECT * FROM employee;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 