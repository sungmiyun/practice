SQL(Standard Query Language) : 데이터베이스에서 데이터를 검색, 삽입, 갱신, 삭제할 수 있는 표준 언어

DDL(Data Definition Language) : 데이터와 그 구조를 정의
create : 데이터 베이스 객체를 생성
drop : 데이터 베이스 객체를 삭제
alter : 기존에 존재하는 데이터베이스 객체를 다시 정의하는 역할

DML(Data Manipulation Language) : 데이터의 검색과 수정 등의 처리
insert : 데이터베이스 객체에 데이터를 입력
delete : 데이터베이스 객체에 데이터를 삭제
update : 기존에 존재하는 데이터베이스 객체 안의 데이터 수정
select : 데이터베이스 객체로부터 데이터를 검색

CRUD
Create -> INSERT
Read -> SELECT
Update -> UPDATE
Delete -> DELETE

SELECT문
SELECT * FROM emp;
SELECT empno, ename, job FROM emp;
SELECT ename, sal, sal + 300 newsal FROM emp;

WHERE절은 알리아스를 사용할 수 없음
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

ORDER BY는 알리아스 사용이 가능함
오름차순
SELECT * FROM emp WHERE ORDER BY sal;
SELECT * FROM emp ORDER BY sal ASC;

내림차순
SELECT * FROM emp WHERE ORDER BY sal DESC;

SELECT * FROM emp ORDER BY sal DESC, ename ASC;

그룹함수 :  행 집합 연산을 수행하여 그룹별로 하나의 결과물 산출
AVG() : 평균, COUNT() : 레코드의 수, MAX() : 가장 큰 값, MIN() : 가장 작은 값, SUM() : 모든 값의 합계
SELECT MAX(sal), MIN(sal), ROUND(AVG(sal)), SUM(sal) FROM emp; 

GROUP BY : SELECT절에서 그룹함수 적용시 개별 컬럼을 지정할 수 없기 때문에 개별 컬럼을 지정할 경우 반드시 GROUP BY 절에 컬럼 지정
SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;

HAVING : 그룹 처리 결과를 제한하고자 할 때 HAVING 이용
SELECT deptno, ROUND(AVG(sal)) FROM emp 
GROUP BY deptno
HAVING ROUND(AVG(sal)) >= 2000;

조인
1. ORACLE 전용
- 동등 조인(equi join)
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

추가적인 조건 명시
SELECT e.ename, d.dname
FROM emp e. dept d
WHERE e.deptno = d.deptno
AND e.ename = 'SCOTT';

비동등 조인(non equi join)
사원이름, 급여, 급여등급(emp, salgrade 테이블)
SELECT e.ename, e.sal, s.garde
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

self join
사원 이름과 해당 사원의 직속상사 이름 구하기(직속상사가 없는 사원 제외)
SELECT a.ename 사원이름, m.ename 직속상사이름
FROM emp a, emp m
WHERE a.mgr = m.empno;

외부 조인(누락된 행 표시)
사원 이름과 해당 사원의 직속상사 이름 구하기(직속상사가 없는 사원도 표시)
SELECT a.ename 사원이름, m.ename 직속상사이름
FROM emp a, emp m
WHERE a.mgr = m.empno(+);

[실습]
근무지(loc)별로 근무하는 사원의 수가 5명 이하인 경우 인원이 적은 도시 순으로 정렬하시오.
(근무 인원 0명인 곳도 표시)
SELECT d.loc, COUNT(e.empno) emp_member
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno
GROUP BY d.loc
HAVING COUNT(e.empno) <= 5
ORDER BY emp_member ASC;


2. 표준 SQL

내부조인(INNER JOIN)
SELECT e.ename, d.dname, d.deptno
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE e.ename = 'SMITH';

만약 조인 조건에 사용된 컬럼의 이름이 같다면 USING 절 사용 가능
SELECT e.ename, d.dname, deptno
FROM emp e JOIN dept d
USING(deptno)
WHERE e.ename = 'ALLEN';

외부조인(OUTER JOIN)
사원 이름과 해당 사원의 직속상사 이름 구하기(직속상사가 없는 사원도 표시)
SELECT e.ename name, m.ename manager_name
FROM emp e LEFT OUTER JOIN emp m
ON e.mgr = m.empno;

[실습]
10번 부서에서 근무하는 사원들의 부서번호, 부서이름, 사원이름, 월급, 급여등급을 출력하시오.
SELECT e.deptno, d.dname, e.ename, e.sal, s.grade
FROM emp e INNER JOIN dept d 
ON e.deptno = d.deptno
INNER JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.deptno = 10;


서브쿼리

단일행 서브쿼리 : 오직 한 개의 행(값)을 반환
SELECT empno, ename, job FROM emp
WHERE job = (SELECT job FROM emp WHERE empno = 7698);

다중행 서브쿼리 : 하나 이상의 행을 반환하는 서브쿼리
IN 연산자 사용
부서별로 가장 급여를 적게 받는 사원과 동일한 급여를 받는 사원의 정보를 출력
SELECT empno, ename, sal FROM emp
WHERE sal IN(SELECT MIN(sal) FROM emp GROUP By deptno);

ANY 연산자 사용
ANY 연산자는 서브쿼리의 결과값 중 어느 하나의 값이라도 만족이 되면 결과값을 반환
SELECT ename, sal FROM emp
WHERE sal > ANY(SELECT sal FROM emp WHERE job = 'SALESMAN');

ALL 연산자 사용
ALL 연산자는 서브 쿼리의 결과와 모든 값이 일치
SELECT ename, sal FROM emp
WHERE sal > ALL(SELECT sal FROM emp WHERE job = 'SALESMAN');

[실습]
CHICAGO 지역에서 근무하는 사원의 평균 급여보다 높은 급여를 받는 사원의 이름과 급여, 지역명을 출력하시오.

SELECT e.ename, e.sal, d.loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE e.sal > (SELECT ROUND(AVG(sal)) FROM emp e INNER JOIN dept d ON e.deptno = d.deptno WHERE d.loc = 'CHICAGO');

INSERT문
형식 : INSERT INTO 테이블명 (컬럼명....) VALUES (값..)
INSERT INTO dept (deptno, dname, loc) VALUES (70, 'MUSIC', 'INCHEON');

UPDATE문
형식 : UPDATE 테이블명 SET 컬럼명 = 데이터...... WHERE 조건
UPDATE dept SET dname = 'CINEMA', loc = 'JEJU' WHERE deptno = 70;

DELETE문
형식 : DELETE FROM 테이블명 WHERE 조건
DELETE FROM dept WHERE deptno = 70;




