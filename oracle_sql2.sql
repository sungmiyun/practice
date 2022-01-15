SQL(Standard Query Language) : �����ͺ��̽����� �����͸� �˻�, ����, ����, ������ �� �ִ� ǥ�� ���

DDL(Data Definition Language) : �����Ϳ� �� ������ ����
create : ������ ���̽� ��ü�� ����
drop : ������ ���̽� ��ü�� ����
alter : ������ �����ϴ� �����ͺ��̽� ��ü�� �ٽ� �����ϴ� ����

DML(Data Manipulation Language) : �������� �˻��� ���� ���� ó��
insert : �����ͺ��̽� ��ü�� �����͸� �Է�
delete : �����ͺ��̽� ��ü�� �����͸� ����
update : ������ �����ϴ� �����ͺ��̽� ��ü ���� ������ ����
select : �����ͺ��̽� ��ü�κ��� �����͸� �˻�

CRUD
Create -> INSERT
Read -> SELECT
Update -> UPDATE
Delete -> DELETE

SELECT��
SELECT * FROM emp;
SELECT empno, ename, job FROM emp;
SELECT ename, sal, sal + 300 newsal FROM emp;

WHERE���� �˸��ƽ��� ����� �� ����
SELECT ename, job, deptno, FROM emp WHERE ename = 'SMITH';
SELECT * FROM emp WHERE hiredate > '81/09/08';
SELECT * FROM emp WHERE hiredate != '81/09/08';
SELECT * FROM emp WHERE hiredate <> '81/09/08';
SELECT * FROM emp WHERE hiredate ^= '81/09/18';

SELECT * FROM emp WHERE sal >= 1000 AND sal <= 1500;
SELECT * FROM emp WHERE sal BETWEEN 1000 AND 1500;
SELECT * FROM emp WHERE sal NOT BETWEEN 1000 AND 1500;

SELECT * FROM emp WHERE sal IN (1300, 2450, 3000);
SELECT * FROM emp WHERE sal NOT IN (1300, 2450, 3000);

SELECT * FROM emp WHERE ename = '%S%';
SELECT * FROM emp WHERE ename NOT LIKE '%S%';

SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;

ORDER BY�� �˸��ƽ� ����� ������
��������
SELECT * FROM emp WHERE ORDER BY sal;
SELECT * FROM emp ORDER BY sal ASC;

��������
SELECT * FROM emp WHERE ORDER BY sal DESC;

SELECT * FROM emp ORDER BY sal DESC, ename ASC;

�׷��Լ� :  �� ���� ������ �����Ͽ� �׷캰�� �ϳ��� ����� ����
AVG() : ���, COUNT() : ���ڵ��� ��, MAX() : ���� ū ��, MIN() : ���� ���� ��, SUM() : ��� ���� �հ�
SELECT MAX(sal), MIN(sal), ROUND(AVG(sal)), SUM(sal) FROM emp; 

GROUP BY : SELECT������ �׷��Լ� ����� ���� �÷��� ������ �� ���� ������ ���� �÷��� ������ ��� �ݵ�� GROUP BY ���� �÷� ����
SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;

HAVING : �׷� ó�� ����� �����ϰ��� �� �� HAVING �̿�
SELECT deptno, ROUND(AVG(sal)) FROM emp 
GROUP BY deptno
HAVING ROUND(AVG(sal)) >= 2000;

����
1. ORACLE ����
- ���� ����(equi join)
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

�߰����� ���� ���
SELECT e.ename, d.dname
FROM emp e. dept d
WHERE e.deptno = d.deptno
AND e.ename = 'SCOTT';

�񵿵� ����(non equi join)
����̸�, �޿�, �޿����(emp, salgrade ���̺�)
SELECT e.ename, e.sal, s.garde
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

self join
��� �̸��� �ش� ����� ���ӻ�� �̸� ���ϱ�(���ӻ�簡 ���� ��� ����)
SELECT a.ename ����̸�, m.ename ���ӻ���̸�
FROM emp a, emp m
WHERE a.mgr = m.empno;

�ܺ� ����(������ �� ǥ��)
��� �̸��� �ش� ����� ���ӻ�� �̸� ���ϱ�(���ӻ�簡 ���� ����� ǥ��)
SELECT a.ename ����̸�, m.ename ���ӻ���̸�
FROM emp a, emp m
WHERE a.mgr = m.empno(+);

[�ǽ�]
�ٹ���(loc)���� �ٹ��ϴ� ����� ���� 5�� ������ ��� �ο��� ���� ���� ������ �����Ͻÿ�.
(�ٹ� �ο� 0���� ���� ǥ��)
SELECT d.loc, COUNT(e.empno) emp_member
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno
GROUP BY d.loc
HAVING COUNT(e.empno) <= 5
ORDER BY emp_member ASC;


2. ǥ�� SQL

��������(INNER JOIN)
SELECT e.ename, d.dname, d.deptno
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE e.ename = 'SMITH';

���� ���� ���ǿ� ���� �÷��� �̸��� ���ٸ� USING �� ��� ����
SELECT e.ename, d.dname, deptno
FROM emp e JOIN dept d
USING(deptno)
WHERE e.ename = 'ALLEN';

�ܺ�����(OUTER JOIN)
��� �̸��� �ش� ����� ���ӻ�� �̸� ���ϱ�(���ӻ�簡 ���� ����� ǥ��)
SELECT e.ename name, m.ename manager_name
FROM emp e LEFT OUTER JOIN emp m
ON e.mgr = m.empno;

[�ǽ�]
10�� �μ����� �ٹ��ϴ� ������� �μ���ȣ, �μ��̸�, ����̸�, ����, �޿������ ����Ͻÿ�.
SELECT e.deptno, d.dname, e.ename, e.sal, s.grade
FROM emp e INNER JOIN dept d 
ON e.deptno = d.deptno
INNER JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.deptno = 10;


��������

������ �������� : ���� �� ���� ��(��)�� ��ȯ
SELECT empno, ename, job FROM emp
WHERE job = (SELECT job FROM emp WHERE empno = 7698);

������ �������� : �ϳ� �̻��� ���� ��ȯ�ϴ� ��������
IN ������ ���
�μ����� ���� �޿��� ���� �޴� ����� ������ �޿��� �޴� ����� ������ ���
SELECT empno, ename, sal FROM emp
WHERE sal IN(SELECT MIN(sal) FROM emp GROUP By deptno);

ANY ������ ���
ANY �����ڴ� ���������� ����� �� ��� �ϳ��� ���̶� ������ �Ǹ� ������� ��ȯ
SELECT ename, sal FROM emp
WHERE sal > ANY(SELECT sal FROM emp WHERE job = 'SALESMAN');

ALL ������ ���
ALL �����ڴ� ���� ������ ����� ��� ���� ��ġ
SELECT ename, sal FROM emp
WHERE sal > ALL(SELECT sal FROM emp WHERE job = 'SALESMAN');

[�ǽ�]
CHICAGO �������� �ٹ��ϴ� ����� ��� �޿����� ���� �޿��� �޴� ����� �̸��� �޿�, �������� ����Ͻÿ�.

SELECT e.ename, e.sal, d.loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE e.sal > (SELECT ROUND(AVG(sal)) FROM emp e INNER JOIN dept d ON e.deptno = d.deptno WHERE d.loc = 'CHICAGO');

INSERT��
���� : INSERT INTO ���̺�� (�÷���....) VALUES (��..)
INSERT INTO dept (deptno, dname, loc) VALUES (70, 'MUSIC', 'INCHEON');

UPDATE��
���� : UPDATE ���̺�� SET �÷��� = ������...... WHERE ����
UPDATE dept SET dname = 'CINEMA', loc = 'JEJU' WHERE deptno = 70;

DELETE��
���� : DELETE FROM ���̺�� WHERE ����
DELETE FROM dept WHERE deptno = 70;




