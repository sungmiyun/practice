Database : 지속적으로 저장되는 연관된 정보의 모음.
    DBMS : Database Managment Ststem, 데이터를 효율적으로 관리할 수 있는 시스템
           데이터베이스에 추가, 삭제, 변경, 검색
    
    관계형 데이터 베이스(RDBMS)의 특징
    1. SQL문 사용
    2. 테이블 사용
    3. 연산자 집합 사용

SQL : Standard Query Language 
      데이터베이스에서 데이터를 검색, 삽입, 갱신, 삭제
    SQL문 종류
        DDL(Data Definition Language) : 데이터와 그 구조를 정의
            create, drop, alter
    DML(Data Manipulation Language) : 데이터의 검색과 수정등의 처리
     INSERT : 데이터베이스 객체에 데이터를 입력
     DELETE : 데이터베이스 객체에 데이터를 삭제
     UPDATE : 기존에 존재하는 데이터베이스 객체안의 데이터 수정
     SELECT : 데이터베이스 객체로부터 데이터를 검색
    
    DCL (Data Control Language) : 데이터베이스 사용자의 권한을 제어
     grant, revoke
    
데이터베이스에 이름 지정 규칙
1) 문자로 시작
2) 1~30자까지
3) A~Z, a~z, 0~9, _, $, #만 포함해야함
4) 동일한 사용자가 소유한 다른 객체의 이름과 중복되지 않아야 함
5) 오라클 서버의 예약어가 아니여야함.

    
    
SELECT문
    데이터베이스로부터 저장되어 있는 데이터를 검색하는데 사용

전체 컬럼명을 명시해서 전체 행 정보를 읽어옴
    SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno FROM emp;
    * : 전체 컬럼
    SELECT * FROM emp;

특정 열(컬럼) 선택
    SELECT ename, sal FROM emp;

주석
    SELECT * /*주석*/ FROM emp; 

연산
    SELECT ename, sal, sal + 300 FROM emp;

연산자 우선순위
    SELECT ename, sal, 12 * (sal + 300) FROM emp;

열 alias 정의(열 이름을 바꿈)
SELECT sal * 12 ASal  FROM emp;
SELECT sal * 12 as ASal FROM emp;
SELECT sal * 12 "Annual Salary" FROM emp;
알리아스에 큰따옴표를 사용하는 경우
    - 대소문자 구별을 원할 때
    - 공백 포함시
    - _,#등 특수문자 사용시
    - 숫자로 시작할 경우

연결 연산자
    열이나 문자열을 다른 열에 연결
    두 개의 세로선(||)으로 나타냄
    결과 열로 문자식을 생성
        SELECT ename || ' has $' || sal FROM emp;

dual
    DUAL은 함수 및 계산의 결과를 볼 때 사용할 수 있는 공용(public) 테이블
        SELECT ASCII('A') FROM dual;
        SELECT SYSDATE FROM dual;
        SElECT 7 + 10 FROM dual;

distinct : 중복행 삭제
    SELECT distinct deptno FROM emp;
    SELECT distinct(deptno) FROM emp;
 
 [실습문제]
 1) emp 테이블에서 사원번호, 사원이름, 월급을 출력하시오
 SELECT empno, ename, sal FROM emp; 
 2) emp 테이블에서 사원이름과 월급을 출력하는데 컬럼명은 "이 름", "월 급"으로 바꿔서 출력하시오.
 SELECT ename as "이 름", sal as "월 급" FROM emp;
 3) emp 테이블에서 사원번호, 사원이름, 월봉, 연봉을 구하고 각각 컬럼명은 "사원번호", "사원이름", "월급", "연봉"으로 출력하시오.
 SELECT empno as "사원번호", ename as "사원이름", sal as "월급", sal * 12 as "연봉" FROM emp; 
 4) emp 테이블의 사원명과 업무를 쉼표(,)로 연결해서 표시하고 컬럼명은 Employee and Job으로 표시하시오.
 SELECT ename || ', ' || Job as "Employee and Job" FROM emp;



선택을 사용하여 행 제한
<WHERE절에 알리아스를 사용할 수 없음>

SELECT * FROM emp WHERE deptno = 10;
SELECT ename, job, deptno FROM emp WHERE ename = 'SMITH';
SELECT * FROM emp WHERE hiredate > '81/12/03';
SELECT * FROM emp WHERE hiredate != '81/06/09';
SElECT * FROM emp WHERE hiredate ^= '81/06/09';
SELECT * FROM emp WHERE hiredate <> '81/06/09';

SELECT * FROM emp WHERE sal >= 1250 AND sal <= 3000;
BETWEEN ~ AND ~ : 두 값 사이(지정한 값 포함)
    SELECT * FROM emp WHERE sal BETWEEN 1250 AND 3000;
    SELECT * FROM emp WHERE sal NOT BETWEEN 1250 AND 3000;

IN : 값 목록 중의 값과 일치
    SELECT * FROM emp WHERE sal IN (1300, 2450, 3000);
    SELECT * FROM emp WHERE sal NOT IN (1300, 2450, 3000);
    SELECT * FROM emp WHERE ename IN ('ALLEN', 'FORD');

LIKE : 지정한 데이터를 검색(패턴을 이용함)

    % : 0개 이상의 문자를 나타냄
    _ : 한 문자를 나타냄

    SELECT * FROM emp WHERE ename LIKE '%S%';
    SELECT * FROM emp WHERE ename NOT LIKE '%S%';
22로 끝나는 입사일
    SELECT * FROM emp WHERE hiredate LIKE '%22';
FOR 다음에 꼭 한 글자
    SELECT * FROM emp WHERE ename LIKE 'FOR_';

NULL 조건 사용
    COMM = NULL은 사용 불가능
    SELECT * FROM emp WHERE comm IS NULL;
    SELECT * FROM emp WHERE comm is NOT NULL;

논리연산자(AND, OR, NOT)를 사용하여 조건 정의
    SELECT empno, ename, job, sal FROM emp WHERE sal >= 2000 AND job LIKE '%MAN%';
 
 SELECT ename, job, sal FROM emp
 WHERE sal >= 3000 OR job = 'CLERK';
 
 SELECT ename, job FROM emp
 WHERE job NOT IN ('CLERK', 'SALESMAN');
 
[실습문제]
1) 사원번호가 7900인 사원이름, 업무, 급여를 출력하시오.
SELECT ename, job, sal FROM emp WHERE empno = 7900;
2) 사원이름이 SMITH인 사람의 이름과 월급, 부서번호를 구하시오.
SELECT ename, sal, empno FROM emp WHERE ename LIKE 'SMITH';
3) 월급이 2500이상 3000미만인 사원이름, 입사일, 월급을 구하시오.
SELECT ename, hiredate, sal FROM emp WHERE sal >=2500 AND sal < 3000;
4) 급여가 2000에서 3000사이에 포함되지 않는 사원이름, 업무, 급여를 출력하시오.
SELECT ename, job, sal FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;
5) 81년 05월 01일과 81년 12월 03일 사이에 입사한 사원의 이름, 급여, 입사일을 출력하시오.
SELECT ename, sal, hiredate FROM emp WHERE hiredate BETWEEN '81/05/01' AND '81/12/03';
6) 사원번호가 7566,7782,7934인 사원을 제외한 사람들의 사원번호, 이름, 월급을 출력하시오.
SELECT empno, ename, sal FROM emp WHERE empno NOT IN ('7566', '7782', '7934');
7) 부서번호 30에서 근무하며 월 2,000달러 이하를 받는 81년 5월 1일 이전에 입사한 사원의 이름, 급여, 부서번호, 입사일을 출력하시오.
SELECT ename, sal, deptno, hiredate FROM emp WHERE deptno = 30 AND sal <= 2000 AND hiredate < '81/05/01';
8) 사원이름 중 s가 포함되지 않은 사람들 중 부서번호가 20인 사원들의 이름과 부서번호를 출력하시오.
SELECT ename, deptno FROM emp WHERE ename NOT LIKE '%S%' AND deptno = 20;

ORDER BY절 : 정렬

오름차순
    SELECT * FROM emp ORDER BY sal ASC;
    SELECT * FROM emp ORDER BY sal;
    SELECT * FROM emp ORDER BY ename ASC;

내림차순
    SELECT * FROM emp ORDER BY sal DESC;
    SELECT * FROM emp ORDER BY ename DESC;

1차 정렬시 중복값이 있으면 중복값 중 2차 정렬을 실행할 수 있음
    SELECT * FROM emp ORDER BY sal ASC, ename ASC;

열 alias를 기준으로 정렬
    SELECT empno, ename, sal * 12 annsal FROM emp ORDER BY annsal;

열의 숫자 위치를 사용하여 정렬
                1    ,  2 ,  3    , 4
        SELECT ename, job, deptno, hiredate FROM emp ORDER BY 3;
    테이블에 생성된 순서대로 열 숫자 위치 부여
        SELECT * FROM emp ORDER BY 2;

[실습문제]
1) 사원번호, 사원이름, 입사일을 출력하는데 입사일이 빠른 사람 순으로 정렬하시오.
SELECT empno, ename, hiredate FROM emp ORDER BY hiredate;
2) 사람이름, 급여, 연봉을 구하고 연봉이 많은 순으로 정렬하시오.
SELECT ename, sal, sal * 12 FROM emp ORDER BY sal * 12 DESC;
3) 10번 부서 또는 20번 부서에서 근무하고 있는 사원의 이름과 부서번호를 출력하는데 이름을 영문자순으로 표시하시오
SELECT ename, deptno FROM emp WHERE deptno IN (10, 20) ORDER BY ename ASC;
4) 커미션 계약을 맺은 모든 사원의 이름, 급여, 커미션을 출력하는데 커미션을 기준으로 내림차순 정렬하시오.
SELECT ename, sal, comm FROM emp WHERE comm IS NOT NULL ORDER BY comm DESC;


함수

문자함수
    대소문자 조작함수 - LOWER, UPPER, INITCAP
     소문자로 변경
        SELECT LOWER('HELLO') FROM dual;
     대문자로 변경
        SELECT UPPER('hello') FROM dual;
      첫글자만 대문자로 변경
        SELECT INITCAP('hello wORLD') FROM dual;
        SELECT INITCAP(ename) FROM emp;

    문자 조작함수 
    CONCAT(문자열1, 문자열2) : 문자열1과 문자열2를 연결하여 하나의 문자열로 반환
        SELECT CONCAT('Hello', ' World') FROM dual;
        SELECT CONCAT(ename, job) FROM emp;
    SUBSTR(대상문자열, 인덱스) : 대상문자열에서 지정한 인덱스부터 문자열을 추출
                        [주의] 인덱스는 1부터 시작
        SELECT SUBSTR('Hello World', 3) FROM dual;
        SELECT SUBSTR(job, 4) FROM emp;
        지정한 인덱스부터 3개만 추출
        SELECT SUBSTR('Hello World', 3, 3) FROM dual;
        뒤에서 3번째부터 끝까지 추출
        SELECT SUBSTR('Hello World', -3) FROM dual;
        뒤에서 3번째서 두개만 추출
        SELECT SUBSTR ('Hello World', -3, 2) FROM dual;
    LENGTH(대상문자열) : 문자의 갯수
        SELECT LENGTH('Hello World',-3,2)  FROM dual;
        SELECT ename, Length(ename) FROM emp;
    INSTR(대상문자열, 검색문자) : 검색문자의 위치 값 검색
     SELECT INSTR('Hello World' , 'e') FROM dual;
    검색문자가 없을 경우 0
        SELECT INSTR('Hello World' , 'E') FROM dual;
        
        SELECT INSTR('Hello World', 'o' )FROM dual;
                            대상문자열, 검색문자, 검색 인덱스 , 해당위치부터 검색
            SELECT INSTR('Hello Word', 'o', 6) FROM dual;
                            대상문자열, 검색문자, 컴색인데스, 반복 인덱스
         SELECT INSTR ('Hello World', 'o', '1', '2') FROM dual;
         
TRIM : 문자열에서 공백이나 특정문자를 제거한 다음 다음 값을 반환
`방향 : 왼족->. leading 오른쪽 -> trailing 쪽 -> both;
        SELECT TRIM (both 'h' from 'bshchh') FROM dual;
        
 REPLACE (대상문자열, old, new) : 대상문자열에서 old 문자를 new 문자로 대체
    SELECT REPLACE ('010.2936.0433', '.', '-') FROM dual;
        
함수 중첩
SELECT ename, LOWER(SUBSTR(ename, 1, 3)) FROM emp;
        
 [실습]
 1) 업무(job)을 첫글자는 대문자 나머지는 소문자로 출력하시오.
SELECT INITCAP(job) FROM emp;
 2) 사원이름 중 A가 포함된 사원이름을 구하고 그 이름 중 앞에서 3자만 추출하여 출력하시오.
 SELECT SUBSTR(ename,1,3) FROM emp WHERE ename LIKE '%A%';
 3) 이름의 세번째 문자가 A인 모든 사원의 이름을 표시하시오.
 SELECT ename FROM emp WHERE SUBSTR(ename, 3,1) = 'A';
 4) 이름의 글자수가 6자 이상인 사원의 이름을 소문자로 이름만 출력하시오.
SELECT LOWER(ename) FROM emp WHERE LENGTH(ename) >= 6;       
        
숫자함수
    CEIL(숫자) : 올림 처리한 정수값을 반환
        SELECT CEIL(1.4) FROM dual;
    ROUND(숫자, 지정자릿수) : 반올림
        SELECT ROUND(45.926) FROM dual;
        SELECT ROUND(45.926, 2) FROM dual;
    TRUNC(숫자, 지정자릿수) : 절삭
        SELECT TRUNC(45.926, 2) FROM dual;
        SELECT TRUNC(45.926) FROM dual;
    MOD(숫자, 나눌숫자) : 나머지 값
        17 %2는 오류
        SELECT MOD(17, 2) FROM dual;
        
날짜함수
    SYSDATE : ORACLE 서버의 현재 날짜와 시간을 반환
        SELECT SYSDATE FROM dual;
        
날짜의 산술연산자 사용
    SELECT ename, (SYSDATE - hiredate)/7 AS WEEKS FROM emp WHERE deptno = 10;        
        
     MONTHS_BETWEEN : 두 날짜 간의 월 수
        SELECT MONTHS_BETWEEN('2012-03-23', '2010-01-23') FROM dual;
        SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) FROM emp;
     ADD_MONTHS : 특정 날짜의 월에 정수를 더한 다음 해당 날짜를 반환하는 함수
        SELECT ADD_MONTHS('2021-01-20', 8) FROM dual;
     NEXT_DAY : 지정된 요일의 다음 날짜
        SELECT NEXT_DAY('2021-01-05', '월요일') FROM dual;
     LAST_DAY : 월의 마지막 날
        SELECT LAST_DAY('2021-01-20') FROM dual;
        SELECT LAST_DAY(SYSDATE) FROM dual;
     EXTRACT : 날짜 정보에서 특정한 연도, 월, 일, 시간, 분, 초 등을 추출
        SELECT EXTRACT(YEAR FROM SYSDATE) YEAR,
               EXTRACT(MONTH FROM SYSDATE) MONTH,
               EXTRACT(DAY FROM SYSDATE) DAY FROM dual;
      
변환함수
  명시적으로 데이터 유형 변환
    TO_NUMBER : 문자 -> 숫자
    TO_CHAR : 숫자 -> 문자, 날짜 -> 문자
    TO_DATE : 문자 -> 날짜
    
    TO_CHAR
    날짜 -> 문자
     SELECT TO_CHAR(날짜, 포맷문자) FROM 테이블명;
        SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM dual;

    숫자-> 문자
     실제 자리수와 일치
       SELECT TO_CHAR(1234,9999) FROM dual;
       SELECT TO_CHAR(1234, '9999') FROM dual;
      ##으로 출력되는 오류 발생
       SELECT TO_CHAR(1234, 0000) FROM dual;
       SELECT TO_CHAR(1234, '0000') FROM dual;
     자리수가 모자람 -> ####
       SELECT TO_CHAR(1234, 999) FROM dual;
       SELECT TO_CHAR(1234, '999') FROM dual;
       SELECT TO_CHAR(1234, '000') FROM dual;
     실제 자리수보다 많은 자리수 지정 => 다섯자리를 확보하고 첫자리는 비워두고 숫자를 표시
       SELECT TO_CHAR(1234, 99999) FROM dual;
       SELECT TO_CHAR(1234, '99999') FROM dual;
     다섯자리를 확보하고 첫자리는 0으로 채우고 숫자 표시 01234
       SELECT TO_CHAR(1234, '00000') FROM dual; 
     소수점 자리 
       SELECT TO_CHAR(1234, 9999.99) FROM dual;
       SELECT TO_CHAR(1234, '9999.99') FROM dual;
       SELECT TO_CHAR(1234, '0000.00') FROM dual;
     반올림해서 소수점 둘째자리까지 표시
       SELECT TO_CHAR(25.897, '99.99') FROM dual;
       SELECT TO_CHAR(sal * 1.15, '9999.9') FROM emp; 
       SELECT TO_CHAR(sal * 1.15, '9999') FROM emp; 
     통화표시 
       SELECT TO_CHAR(1234, '$0000') FROM dual;
                            지역통화표시
       SELECT TO_CHAR(1234, 'L0000') FROM dual;
     
    TO_DATE
        SELECT TO_DATE('21-01-20', 'YYYY-MM-DD') FROM dual;
        
    TO_NUMBER
        SELECT TO_NUMBER('100', '999') FROM dual;
        SELECT TO_NUMBER('100', '000') FROM dual;
         포맷형식 생략 가능
        SELECT TO_NUMBER('100') FROM dual;
        
일반함수

    NVL(value1, value2) : value1이 null이면 value2를 사용. value1과 value2의 자료형이 일치
        SELECT * FROM emp;
        SELECT ename, sal, sal + NVL(comm,0) 실급여 FROM emp;
        SELECT ename, NVL(TO_CHAR(comm), 'No Commission') "COMM." FROM emp;        
        
    NVL2(value1, value2, value3) : value1이 null인지 평가. null이면 value3, null이 아니면 value2
                                   자료형이 일치하지 않아도 됨
        SELECT ename, NVL2(comm, 'Commission', 'No Commission') FROM emp;
    
    NULLIF(value1, value2) : 두 개의 값이 일치하면 NULL, 두 개의 값이 일치하지 않으면 value1
        SELECT ename, NULLIF(LENGTH(ename), LENGTH(job)) "NULLIF" FROM emp;
    
    COALESCE(value1, value2, value3,....) : null값이 아닌 값을 사용(자료형 일치)
        SELECT comm, sal, COALESCE(comm, sal, 0) FROM emp;
        
    CASE 컬럼 WHEN 비교값 THEN 결과값
             WHEN 비교값 THEN 결과값
             WHEN 비교값 THEN 결과값
             (ElSE 결과값)
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
        
    DECODE(ORACLE 전용) : = 비교만 가능
    DECODE(컬럼, 비교값, 반환값,
                비교값, 반환값,
                비교값, 반환값,
                반환값)
        
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
                                
[실습문제]
1) 각 사원에 대해 사원번호, 이름, 급여 및 15% 인상된 급여 (New salary)를 정수(반올림)로 표시하시오.
SELECT empno, ename, sal, ROUND(sal + sal * 0.15) "New salary" FROM emp;
SELECT empno, ename, sal, ROUND(sal * 1.15) "New salary" FROM emp;
SELECT empno, ename, sal, TO_CHAR(sal * 1.15, '9999') "New salary" FROM emp;
2) 각 사원의 이름을 표시하고 근무 달 수(입사일로부터 현재까지의 달 수)를 계산하여 
 열레이블을 MONTHS_WORKED로 지정하시오. 결과는 정수로 반올림하여 표시하고 근무 달 수를 기준으로 오름차순 정렬
 SELECT ename, ROUND(MONTHS_BETWEEN(SYSDATE, hiredate)) "MONTHS_WORKED" FROM emp ORDER BY MONTHS_WORKED ASC;
 SELECT ename, TO_CHAR(MONTHS_BETWEEN(SYSDATE, hiredate), '999') "MONTHS_WORKED" FROM emp ORDER BY MONTHS_WORKED ASC;
3) 이름을 소문자로 표시, 업무, 근무연차를 출력하시오.
SELECT LOWER(ename), job, TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate) / 12) 근무연차 FROM emp;
4) 사원이름, 월급, 월급과 커미션을 더한 값을 컬럼명 실급여라고해서 출력하시오.
SELECT ename, job, sal + NVL(comm,0) "실급여" FROM emp;
        
        
그룹함수 
그룹함수는 행 집합 연산을 수행하여 그룹별로 하나의 결과를 산출

AVG() : NULL을 제외한 모든 값들의 평균을 반환, NULL값은 평균계산에서 무시됨
    SELECT AVG(sal) FROM emp;
        
COUNT() : NULL을 제외한 값을 가진 모든 레코드의 수를 반환, COUNT(*) 형식을 사용하면 NULL도 계산에 포함
  NULL을 제외한 값을 가진 모든 레코드 수 반환 COUNT(comm) -> 4
    SELECT COUNT(comm) FROM emp;
  NULL도 계산에 포함 COUNT(*) -> 14
    SELECT COUNT(*) FROM emp;
 
MAX() : 레코드 내에 있는 여러 값 중 가장 큰 값을 반환
    SELECT MAX(sal) FROM emp;
    SELECT MAX(ename) FROM emp;
    
MIN() : 레코드 내에 있는 여러 값 중 가장 작은 값을 반환
    SELECT MIN(sal) FROM emp;
    SELECT MIN(ename) FROM emp;

SUM() : 레코드들이 포함하고 있는 모든 값을 더하여 반환
    SELECT SUM(sal) FROM emp;
    
    SELECT MAX(sal), MIN(sal), ROUND(AVG(sal)), SUM(sal) FROM emp;
    SELECT MAX(sal), MIN(sal), ROUND(AVG(sal)), SUM(sal) FROM emp WHERE deptno = 10;
    
   20번 부서에서 일하는 사원의 수 
    SELECT COUNT(*) FROM emp WHERE deptno = 20;
   30번 부서에서 일하는 사원의 수
    SELECT COUNT(ename) FROM emp WHERE deptno = 30;

GROUP BY & HAVING    
SELECT절에 그룹함수를 적용할 때 개별 컬럼을 지정할 수 없다.         
개별 컬럼을 지정할 경우에는 반드시 GROUP BY 절에 지정된 컬럼만 가능
   부서별 최대 급여
    SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;
   부서별 사원 수
    SELECT deptno, COUNT(empno) FROM emp GROUP BY deptno;
   다중 열에서 GROUP BY 절 사용
    SELECT deptno, job, SUM(sal) FROM emp GROUP BY deptno, job ORDER BY deptno, job;      

HAVING : 그룹 처리 결과를 제한하고자 할 때 HAVING절 이용
    HAVING절에 알리아스 사용을 할 수 없음
    <오류 발생>
       SELECT deptno, AVG(sal) FROM emp 
       WHERE AVG(sal) >= 2000
       GROUP BY deptno;
    <정상구문>
       SELECT deptno, AVG(sal) FROM emp 
       GROUP BY deptno
       HAVING AVG(sal) >= 2000;
 
       SELECT deptno, MAX(sal) FROM emp
       GROUP BY deptno
       HAVING MAX(sal) > 3000;
 
 그룹함수의 중첩
    SELECT MAX(AVG(sal)) FROM emp GROUP BY deptno;
 
 [실습문제]
 1) 모든 사원의 급여 최고액, 총액 및 평균액을 표시하시오. 열레이블을 각각 maximum, minimum, sum, average로
 지정하고 결과를 정수로 반올림하고 세자리 단위로 ,를 명시하시오.
 SELECT TO_CHAR(MAX(sal), '9,999') maximum, MIN(sal) minimum,
        TO_CHAR(SUM(sal), '99,999') sum, TO_CHAR(AVG(sal), '9,999') average FROM emp;
 2) 업무가 동일한 사원 수를 표시하시오. (업무와 사원 수 표시)
 SELECT job, COUNT(job) FROM emp GROUP BY job;
 3) 30번 부서의 사원수를 구하시오.
 SELECT COUNT(*) FROM emp WHERE deptno = 30;
 4) 업무별 최고 월급을 구하고 업무, 최고 월급을 출력하시오.
 SELECT job, MAX(sal) FROM emp GROUP BY job;
 5) 부서별로 지급되는 총월급에서 금액이 9,000이상을 받는 사원의 부서번호, 총월급을 출력하시오.
 SELECT deptno, SUM(sal) FROM emp GROUP BY deptno HAVING SUM(sal) >= 9000;
 6) 업무별로 사원의 수가 4명 이상인 업무와 인원수를 출력하시오.
 SELECT job, COUNT(*) FROM emp GROUP BY job HAVING COUNT(*) >= 4;
 7) 사원수가 5명이 넘는 부서와 부서번호와 사원수를 구하시오.
 SELECT deptno, COUNT(*) FROM emp GROUP BY deptno HAVING COUNT(*) > 5;
 
 JOIN
  둘 이상의 테이블을 연결하여 데이터를 검색하는 방법
 <ORACLE 전용>
  동등 조인(Equal Join) : 조건절에 Equality Condition(=)에 의하여 조인이 이루어 짐
  SELECT emp.ename, dept.dname FROM emp, dept WHERE emp.deptno = dept.deptno;

 테이블에 알리아스 부여하기
 SELECT e.ename, d.dname FROM emp e, dept d  WHERE e.deptno = d.deptno;
 
 추가적인 조건 명시하기
 SELECT e.ename, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno AND e.ename = 'ALLEN';
 
 SELECT e.ename, e.sal, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno AND e.sal BETWEEN 3000 AND 4000;

  비동등 조인(NON EQUI JOIN)
   테이블의 어떤 colium도 join할 테이블의 column에 일치하지 않을 때 사용하고 조인 조건은 
   동등(=) 이외의 연산자를 갖음(between and, is null, is not null, in not in)
   
   사원이름, 급여, 급여등급 구하기(emp, salgrade 테이블 이용)
      SELECT e.ename, e.sal, s.grade
      FROM emp e, salgrade s
      WHERE e.sal BETWEEN s.losal AND s.hisal;
   
SELF JOIN 
사원이름과 해당 사원의 관리자 이름 구하기(관리자가 없는 사람은 제외)
SELECT e.ename 사원이름, m.ename 관리자이름
FROM emp e, emp m
WHERE e.mgr = m.empno;
   
 외부조인(Outer Join)
 equal join 문장들 한 가지 제약점은 그것들이 조언을 생성하려 하는 두 개의 테이블의
 두 개의 컬럼에서 공통된 값이 없다면 테이블로부터 테이터를 반환하지 않는다는 것.
 정상적으로 조인 조건을 만족하지 못하는 행들을 보기위해 outer join을 사용
 
 누락된 행의 반대 테이블에 (+)기호 표시
 SELECT distinct(e.deptno), d.deptno 
 FROM emp e, dept d 
 WHERE e.deptno(+) = d.deptno;
 
 사원 이름과 해당 사원의 관리자 이름 구하기(관리자가 없는 사원도 표시)
 SELECT e.ename 사원이름, m.ename 관리자이름 
 FROM emp e, emp m
 WHERE e.mgr = m.empno(+);
   
 
 [실습문제]
 1) 모든 사원의 이름, 부서번호, 부서이름을 표시하시오. (emp, dept)
 SELECT e.ename, e.deptno, d.dname 
 FROM emp e, dept d 
 WHERE e.deptno = d.deptno;
 2) 업무가 MANAGER인 사원의 저오블 이름, 업무, 부서명, 근무지 순으로 출력하시오. (emp,dept)
SELECT e.ename, e.job, d.dname, d.loc 
FROM emp e, dept d 
WHERE e.deptno = d.deptno AND e.job = 'MANAGER';         
 3) 커미션을 받고 급여가 1,600이상인 사원의 사원이름, 급여, 부서명, 근무지를 출력하시오.
 SELECT e.ename, e.sal, d.dname, d.loc 
 FROM emp e, dept d 
 WHERE e.deptno = d.deptno AND e.comm IS NOT NULL AND e.sal >= 1600;
 4) 근무지가 CHICAGO인 모든 사원의 이름, 업무, 부서번호 및 부서 이름을 출력하시오.
 SELECT e.ename, e.job, d.deptno, d.dname 
 FROM emp e, dept d 
 WHERE e.deptno = d.deptno AND d.loc = 'CHICAGO';
 5) 근무지별로 근무하는 사원의 수가 5명 이하인 경우, 인원이 적은 도시 순으로 정렬하시오.
 (근무인원이 0명인 곳도 표시)
 SELECT d.loc, COUNT(e.empno) emp_member
 FROM emp e, dept d 
 WHERE e.deptno(+) = d.deptno 
 GROUP BY d.loc
 HAVING COUNT(e.empno) <= 5
 ORDER BY emp_member ASC;
 
 <표준 SQL>
 
 내부 조인(Inner Join)
  SELECT e.ename, d.deptno FROM emp e INNER JOIN dept d ON e.deptno = d.deptno;
  SELECT e.ename, d.deptno FROM emp e JOIN dept d ON e.deptno = d.deptno;
 
 join 사용지 on절을 정의하고 부가적인 조건이 있으면 where절 사용
   SELECT e.ename, d.dname
   FROM emp e JOIN dept d
   ON e.deptno = d.deptno
   WHERE e.ename = 'ALLEN';
 
 만약 조인 조건에 사용된 컬럼의 이름이 같다면 다음과 같이 USING절을 사용하여 조인 조건을 정의할 수 있음
 SELECT e.ename, d.dname
 FROM emp e JOIN dept d
 USING(deptno);

[주의] USING에 사용된 컬럼은 테이블명 또는 테이블 알리아스를 붙이지 않음
SELECT e.ename, d.dname, deptno
FROM emp e JOIN dept d
USING(deptno);
 
 JOIN할 때 하나의 테이블에만 존재하는 컬럼은 테이블명 또는 테이블 알리아스를 붙이지 않아도 식별 가능
 SELECT ename, dname, e.deptno
 FROM emp e JOIN dept d
 ON e.deptno = d.deptno;
 
 
 SELF JOIN
  사원 이름과 해당 사원의 관리자 이름 구하기(관리자 없는 사원은 제외)
  SELECT e.ename name, m.ename manager_name
  FROM emp e JOIN emp m
  ON e.mgr = m.empno;
 
  외부 조인(Outer Join)
  사원 이름과 해당 사원의 관리자 이름 구하기(관리자가 없는 사원도 포함)
  SELECT e.ename name, m.ename manager_name
  FROM emp e LEFT OUTER JOIN emp m
  ON e.mgr = m.empno;
 
 [실습문제]
 1) 모든 사원의 이름, 부서번호, 부서이름을 표시하시오. (emp, dept)
 SELECT e.ename, e.deptno, d.dname 
 FROM emp e INNER JOIN dept d 
 ON e.deptno = d.deptno;
 
 SELECT e.ename, deptno, d.dname 
 FROM emp e JOIN dept d 
 USING(deptno);
 2) 근무지가 CHICAGO인 모든 사원의 이름, 업무, 부서 번호 및 부서 이름을 표시하시오.
SELECT e.ename, e.job, e.deptno, d.dname
FROM emp e JOIN dept d 
ON e.deptno = d.deptno AND d.loc = 'CHICAGO';
 3) 근무지별로 근무하는 사원의 수가 5명 이하인 경우, 인원이 적은 도시 순으로 정렬하시오.(근무인원이 0명인 곳도 표시)
 SELECT d.loc,  COUNT(e.deptno) emp_member
 FROM emp e LEFT OUTER JOIN dept d
 ON e.deptno = d.deptno
 GROUP BY d.loc
 HAVING COUNT(e.empno) <= 5
 ORDER BY emp_member ASC;
 4) 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 급여+커미션, 급여등급을 출력하는데 
 각각의 칼럼명을 "사원번호" "사원이름" "연봉" "급여등급"으로 출력하시오. 단 커미션이 null인 것은 제외하고 출력(emp, salgrade)
 SELECT e.empno "사원번호", e.ename "사원이름", e.sal * 12 "연봉", e.sal + NVL(e.comm, 0) "실급여", s.grade "급여등급"
 FROM emp e JOIN salgrade s
 ON e.sal BETWEEN s.losal AND s.hisal
 WHERE e.comm IS NOT NULL;
 
 
 집합연산자
 
 UNION(합집합 중복값 제거)
 SELECT deptno FROM emp
 UNION 
 SELECT deptno FROM dept;
 
 UNION ALL(합집합 중복값까지 반환)
 SELECT deptno FROM emp
 UNION ALL
 SELECT deptno FROM dept;
 
 INTERSECT(교집합)
 SELECT deptno FROM emp
 INTERSECT
 SELECT deptno FROM dept;
 
 MINUS(차집합)
 SELECT deptno FROM dept
 MINUS 
 SELECT deptno FROM emp;
 
 Subquery
 SQL문장의 절에 내장되어 있는 select문장
 
 단일행 서브쿼리 : 오직 한 개의 행(값)을 반환
 SELECT empno, ename, job FROM emp
 WHERE job = (SELECT job FROM emp WHERE empno = 7369);
 
 SELECT ename, sal FROM emp
 WHERE sal > (SELECT sal FROM emp WHERE ename = 'BLAKE');
 
 다중 행 서브쿼리 : 하나 이상의 행을 반환하는 서브쿼리
 
 IN 연산자 사용
 
 부서별로 가장 급여를 적게 받는 사원과 동일한 급여를 받는 사원의 정보를 출력
 SELECT empno, ename, sal, deptno FROM emp
 WHERE sal IN (SELECT MIN(sal) FROM emp GROUP BY deptno);
 
 ANY 연산자의 사용
 any 연산자는 서브쿼리의 결과값 중 어느 하나의 값이라도 만족이 되면 결과값을 반환
 SELECT ename, sal, job FROM emp
 WHERE sal > ANY(SELECT sal FROM emp WHERE job = 'SALESMAN');
 
 ALL 연산자의 사용
 all 연산자는 서브쿼리의 결과와 모든 값이 일치
 SELECT empno, ename, sal, deptno FROM emp
 WHERE sal > ALL(SELECT sal FROM emp WHERE deptno = 20);
 
 다중열 서브쿼리
 서브쿼리의 결과가 두 개 이상의 컬럼으로 반환되어 메인쿼리에 전달하는 쿼리
 SELECT empno, ename, sal, deptno FROM emp
 WHERE (deptno, sal) IN (SElECT deptno, sal FROM emp WHERE deptno = 30);
 
 [실습문제]
 1) "BLAKE"와 같은 부서에 있는 사원들의 이름과 입사일을 구하는데 "BLAKE"는 제외하고 출력
 SELECT ename, hiredate FROM emp
 WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'BLAKE')
 AND ename != 'BLAKE';
 ----------------------------(BLAKE가 여러명일 경우)
  SELECT ename, hiredate FROM emp
 WHERE deptno IN (SELECT deptno FROM emp WHERE ename = 'BLAKE')
 AND ename != 'BLAKE';
 
 2) 평균 급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을 출력하는데 월급이 높은 사람 순으로 출력
 SELECT empno, ename, sal FROM emp
 WHERE sal > (SELECT AVG(sal) FROM emp)
 ORDER BY sal DESC;
 
 3) 10번 부서에서 급여를 가장 적게 받는 사원과 동일한 급여를 받는 사원의 이름과 월급을 출력
 SELECT ename, sal FROM emp
 WHERE sal = (SELECT MIN(sal) FROM emp WHERE deptno = 10);
 
 4) 사원수가 3명이 넘는 부서의 부서명과 사원수를 출력
 SELECT a.dname, b.cnt FROM dept a, ( SELECT deptno, COUNT(empno) cnt FROM emp GROUP BY deptno) b
 WHERE a.deptno = b.deptno AND b.cnt > 3;
 ---------------------------------------------
 SELECT d.dname, COUNT(e.empno) cnt 
 FROM emp e, dept d
 WHERE e.deptno = d.deptno
 GROUP BY d.dname
 HAVING COUNT(e.empno) > 3;
 
 5) 사원번호가 7844인 사원보다 빨리 입사한 사원의 이름과 입사일을 출력하시오.
 SELECT ename, hiredate FROM emp 
 WHERE hiredate < (SELECT hiredate FROM emp WHERE empno = 7844);
 6) 직속상사(mgr)가 KING인 모든 사원의 이름과 급여를 출력하시오
 SELECT ename, sal FROM emp
 WHERE mgr = (SELECT empno FROM emp WHERE ename = 'KING');
 7) 20번 부서에서 가장 급여를 많이 받는 사원과 동일한 급여를 받는 사원의 이름과 부서명, 급여, 급여등급을 출력하시오
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
 8) 총급여(sal + comm)가 평균 급여보다 많은 급여를 받는 사원의 부서번호, 이름, 총급여, 커미션을 출력하시오.
   (커미션은 유(o),무(x)로 표시하고 컬럼명은 "comm유무"로 출력)
SELECT deptno, ename, sal + NVL(comm, 0) AS 총급여, NVL2(comm, 'O', 'X') "comm유무"
FROM emp
WHERE sal + NVL(comm, 0) > (SELECT AVG(sal) FROM emp );
----------------------------------------------------
SELECT deptno, ename, sal + NVL(comm, 0) AS 총급여,
        CASE WHEN comm IS NOT NULL THEN 'O'
            ELSE 'X'
        END AS comm유무
FROM emp
WHERE sal + NVL(comm, 0) > (SELECT AVG(sal) FROM emp);
9) CHICAGO 지역에서 근무하는 사원의 평균 급여보다 높은 급여를 받는 사원의 이름과 급여, 지역명을 출력하시오.
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
10) 커미션이 없는 사원들 중 월급이 가장 높은 사원의 이름과 급여등급을 출력하시오.
SELECT e.ename, s.grade
FROM emp e JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal
AND e.sal = (SELECT MAX(sal) FROM emp WHERE comm IS NULL);
11) SMITH의 직속 상사(mgr)의 이름과 부서명, 근무지역을 출력하시오.
SELECT e.ename, d.dname, d.loc
FROM emp e JOIN dept d
USING(deptno)
WHERE e.empno IN (SELECT mgr FROM emp WHERE ename = 'SMITH');

 INSERT문 : 테이블에 행을 삽입
 
 전체 데이터 삽입
 INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
 VALUES (8000, 'DENNIS', 'SALESMAN', 7698, '99/01/22', 1700, 200, 30);
 
 전체 데이터를 명시할 때는 컬럼명 생략 가능
 INSERT INTO emp VALUES (8001, 'SUNNY', 'SALESMAN', 7698, '99/03/01', 1000, 300, 30);
 
 값이 입력되지 않는 컬럼이 있을 경우(insert문장에 컬럼을 꼭 명시해야함)
 INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, deptno)
 VALUES(8002, 'PETER', 'CLERK', 7698, '99/05/02', 1800, 10);
 
 SELECT * FROM emp;
 
 UPDATE문 : 행단위로 데이터 갱신
 UPDATE emp SET mgr = 7839 WHERE empno = 8000;
 UPDATE emp SET ename = 'MARIA', sal = 2500, comm = 500 WHERE empno = 8000;
 
 전체 행의 이름을 변경
 UPDATE emp SET ename = 'DENNIS';
 
 DELETE문 : 행을 삭제
 DELETE FROM emp WHERE empno = 8000;
 
 전체행이 삭제됨
 DELETE FROM emp;
 
 작업한 내용을 테이블에 반영하지 않음
 ROLLBACK;
 
 데이터베이스 트랜잭션
 트랜잭션은 데이터 처리의 한 단위
 트랜잭션은 데이터를 일관되게 변경하는 DML문장으로 구성됨
 
 트랜잭션의 시작 : 실행 가능한 SQL문장이 제일 처음 실행될 때
 트랜잭션의 종료 : COMMIT(변경사항 저장)이나 ROLLBACK(변경사항 취소)
                 DDL이나 DCL 문장의 실행(자동 COMMIT)
                 기계 장애 또는 시스템 충돌
 
 데이터베이스 객체
 테이블 : 기본 저장 단위로 행과 열로 구성
 뷰     : 논리적으로 하나 이상의 테이블에 있는 데이터의 부분 집합을 나타냄
 시퀀스 : 숫자 값 생성기
 인덱스 : 질의의 성능을 향상
 동의어 : 객체에 다른 이름을 제공
 
 테이블
  : 테이블은 기본적인 데이터 저장 단위
    레코드와 컬럼으로 구성
    레코드(record, row) : 테이블의 데이터는 행에 저장
    컬럼(column) : 테이블의 각 컬럼은 데이터를 구별할 수 있는 속성을 표현 
 
 테이블 생성
 CREATE TABLE employee(
   empno number(8),
   name varchar2(20) not null,
   salary number(8,2),
   hire_date date default SYSDATE,
   constraint employee_pk primary key (empno)
 )0;
 
 primary key와 foreign key 제약 조건을 적용한 테이블 생성
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

[실습문제]
1) 테이블명 : student 
    컬럼명 : id(varchar2(10), name(varchar2(30)), age(number(3)), score(number(3))
    제약조건 : primary key       not null           not null        not null
    
create table student(
    id varchar2(10),
    name varchar2(30) not null,
    age number(3) not null,
    score number(3) not null,
    constraint student_pk primary key(id)
);

2) 테이블명 : muser
    컬럼명 : id,           name,          phone,          reg_date
    자료형 : varchar2(10)   varchar2(30)    varchar2(15)      date
    제약조건 : primary key     not null                      not null
    
    테이블명 : mboard
    컬럼명 : num,         subject,        content,        favorite,          reg_date,      id
    자료형 : number        varchar2(100)   varchar2(4000)    number(1)      date           varchar2(10)
    제약조건 : primary key    not null                                         not null      foreign key

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
  
테이블의 관리
add 연산자 : 테이블에 새로운 컬럼을 추가
alter table employee add(addr varchar2(50));

제약 조건 추가
alter table employee add constraint employee_pk primary key (empno);
 
modify 연산자 : 테이블의 컬럼을 수정하거나 not null 컬럼으로 변경할 수 있음
alter table employee modify (salary number(10, 2) not null);
 
drop 연산자 : 컬럼의 삭제
alter table employee drop column name;
 
컬럼명 변경
alter table employee rename column salary to sal;
 
테이블명 변경
rename employee to employee2;
 
테이블의 삭제
drop table employee2;
 
 
 
뷰(View)
복잡한 질의를 쉽게 작성하기 위해
데이터 독립성을 제공하기 위해
동일한 데이터로부터 다양한 결과를 얻기 위해

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
유일한 값을 생성해주는 오라클 객체
시퀀스를 생성하면 기본키와 같이 순차적으로 증가하는 컬럼을 자동적으로 생성할 수 있음.
보통 primary key 값을 생성하기 위해 사용

CREATE SEQUENCE test_seq
start with 1
increment by 1
maxvalue 100000;

currval : 현재 값을 반환
nextval : 현재 시퀀스 값의 다음 값 반환

SELECT test_seq.nextval FROM dual;
SELECT test_seq.currval FROM dual;

시퀀스 삭제
DROP SEQUENCE test_seq;

인덱스(index)
인덱스는 원하는 정보의 위치를 빠르고, 정확하고, 지능적으로 알아낼 수 있는 방법을 제공한다.
테이블의 컬럼에 대한 제약 조건을 설정할 때 Primary key나 Unique로 설정하면 Oracle은 자동으로 이 컬럼에 대해 
Unique Index를 설정한다.

유일한 값을 가지는 컬럼에 인덱스 설정 : Unique Index

CREATE UNIQUE INDEX dname_idx
ON dept (dname);

유일한 값을 가지지 않는 컬럼에 인덱스 설정 : Non Unique Index

CREATE INDEX ename_idx
ON emp(ename);

동의어(Synonym)
동의어(객체의 다른 이름)을 생성하여 객체 액세스를 단순화한다.
다른 사용자가 소유한 테이블을 쉽게 참조
긴 객체 이름을 짧게 만든다.

동의어 생성
CREATE SYNONYM emp_view
FOR emp_info_view;

SELECT * FROM emp_view;

동의어 삭제
DROP SYNONYM emp_view;


 
 
 
일반 계정 생성
SQL PLUS(18c), RUN SQL Command Line(11g)
사용자명 입력 : system
비밀번호 입력 : oracle
SQL> conn /as sysdba
연결되었습니다.
SQL> create user c##sunny identified by 1234;
사용자가 생성되었습니다.
SQL> grant connect, dba, resource to c##sunny;
권한이 부여되었습니다.

암호 변경
ALTER USER scott IDENTIFIED BY lion;

사용자 삭제
DROP USER scott;



[포트폴리오]

 CREATE TABLE classinfo(
    class_no number(2),
    cname varchar2(30) not null,
    reg_date date default SYSDATE,
    constraint classinfo_pk primary key (class_no)
);
INSERT INTO classinfo VALUES(10, '별님반', '20/04/08');
INSERT INTO classinfo VALUES(20, '햇님반', '20/04/08');
INSERT INTO classinfo VALUES(30, '꽃님반', '20/04/08');
 
 CREATE TABLE studentinfo(
    id varchar2(10),
    name varchar2(30) not null,
    class_no number(2) not null,
    reg_date date default SYSDATE,
    constraint studentinfo_pk primary key (id),
    constraint studentinfo_fk foreign key (class_no) references classinfo(class_no)
);
INSERT INTO studentinfo VALUES ('dragon', '박문수', 10, '20/04/08');
INSERT INTO studentinfo VALUES ('sky', '장영실', 10, '20/04/08');
INSERT INTO studentinfo VALUES ('blue', '홍길동', 20, '20/04/08');

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
 
 INSERT INTO department VALUES (10, '경찰소', '서울');
 INSERT INTO department VALUES (20, '병원', '부산');
 INSERT INTO department VALUES (30, '식당', '광주');
 
 
 INSERT INTO employee VALUES (1000, '박문수', '경찰', 1000000, 10);
 INSERT INTO employee VALUES (2000, '김유신', '의사', 2000000, 20);
 INSERT INTO employee VALUES (3000, '이순신', '요리사', 3000000, 30);
 
 SELECT * FROM employee;
 
 SELECT e.name, e.job, e.sal 
 FROM employee e JOIN department d
 ON e.dno = d.dno
 WHERE d.dname = '경찰소';
 
 SELECT e.name, e.job, e.sal, d.dname, d.loc
 FROM employee e JOIN department d
 ON e.dno = d.dno
 WHERE sal >= (SELECT AVG(sal) FROM employee);
 
 SELECT * FROM employee;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 