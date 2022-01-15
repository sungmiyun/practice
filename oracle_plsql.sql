PL/SQL
PL/SQL은 Procedural language extension to Structured Query Language(SQL)의 약자
SQL을 확장한 순차적 처리 언어

PL/SQL의 기본 구조
선언부(declarative part) : 사용할 변수나 상수를 선언(선언부에만 변수와 상수 선언 가능)
실행부(executable part) : 실제 처리할 로직을 담당하는 부분
예외처리부(exception-building part) : 실행부에서 로직을 처리하던 중 발생할 수 있는 각종 오류들에 대해 처리

기본 구조
begin
    dbms_output.put_line('Hello World');
end;

declare
 --변수를 선언할 수 있는 선언부
  message VARCHAR2(100);
begin
 --실행부에서 사용할 변수는 선언부에서 미리 선언되어야 함
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

익명 블록(ANONYMOUS BLOCK)
declare 
  counter INTEGER;
  i INTEGER;
begin
  for i in 1..9 loop
    counter := (2 * i);
    dbms_output.put_line('2 * ' || i || ' = ' || counter);
  end loop;
end;


예외처리부
declare
  counter INTEGER;
begin
  counter := 10;
  counter := counter / 0;
  dbms_output.put_line(counter);
exception when zero_divide then 
  dbms_output.put_line('errors');  
end;
  
콜렉션
varray
varray는 variable array의 약자로 고정 길이(fixed number)를 가진 배열

declare
  type varray_test is varray(3) of integer;
  varray1 varray_test; --위에서 선언한 varray_test 타입 변수
begin
  varray1 := varray_test(10, 20, 30);
  
  dbms_output.put_line(varray1(1));
  dbms_output.put_line(varray1(2));
  dbms_output.put_line(varray1(3));
end;

중첩 테이블
중첩 테이블은 varray와 흡사하지만 선언시에 전체 크기를 명시할 필요가 없음

declare
  type nested_test is table of varchar2(10);
  nested1 nested_test; --위에서 선언한 nested_test 타입의 변수
begin
  nested1 := nested_test('A', 'B', 'C', 'D');
  
  dbms_output.put_line(nested1(1));
  dbms_output.put_line(nested1(2));
  dbms_output.put_line(nested1(3));
  dbms_output.put_line(nested1(4));
end;

Associative array(index-by table)
Associative array(연관 배열)은 index-by table 이라고도 하며 키와 값이 쌍으로 구성된 콜렉션으로 
하나의 키는 하나의 값과 연관

declare
  type assoc_array_num is table of number index by pls_integer;
  --키는 pls_integer형 이며, 값은 number형인 요소들로 구성
  assoc1 assoc_array_num; --위에 선언한 assoc_array_num 타입변수
begin
  assoc1(3) := 33; --assoc_array_num의 키는 3, 값은 33
  
  dbms_output.put_line( assoc1(3));
end;


declare
  type assoc_array_str is table of varchar2(32) index by varchar2(64);
  --키는 varchar2(64)형이며, 값은 varchar2(32)형인 요소들로 구성
  assoc2 assoc_array_str;
begin
  assoc2('K') := 'Korea';
  
  dbms_output.put_line(assoc2('K'));
end;


콜렉션을 데이터베이스 객체로 생성
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

레코드
각기 다른 데이터 타입을 가질 수 있다.

declare
  type record1 is record (deptno number not null := 50, 
                                dname varchar2(14), 
                                 loc varchar2(13));
  rec1 record1;
begin
  --record1 타입의 레코드 변수 rec1의 dname 필드에 값 할당
  rec1.dname := 'RECORD';
  --record1 타입의 레코드 변수 rec1의 loc필드에 값 할당
  rec1.loc := 'SEOUL';
  
  --rec1 레코드 값을 dept 테이블에 insert
  INSERT INTO dept VALUES rec1;
  
  COMMIT;
exception when others then
  ROLLBACK;
end;


PL/SQL 문장


if문

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

case문

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

loop문

declare
  test_number integer;
  result_num integer;
begin
  test_number := 1;
  loop
    result_num := 2 * test_number;
    if result_num > 20 then
      exit; --블럭 종료
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


while - loop문

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

for - loop문

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

커서(cursor)
select문을 이용해서 결과집합을 반환받게 되는데 메모리에 만들어지고 커서(cursor)를 사용해서 이 결과집합에 접근함

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
    -- %notfound : 커서에서만 사용 가능한 속성.
    -- 더 이상 패치(할당)할 로우가 없음을 의미
    exit when emp_csr%notfound;
    dbms_output.put_line(emp_no);
  end loop;
  close emp_csr;
end;


PL/SQL 서브프로그램
내장 프로시저와 함수

함수

입력받은 값으로부터 10%의 세율을 얻는 함수
create or replace function tax(p_value in number)
    return number 
is 
begin
    return (p_value * 0.1);
end;

SELECT TAX(100) FROM dual;
SELECT sal, TAX(sal) tax, sal-TAX(sal) "실급여" FROM emp;



급여와 커미션을 합쳐서 세금을 계산
create or replace function tax2(p_sal in emp.sal%type, p_bonus emp.comm%type)
    return number
is
begin
  return ((p_sal + NVL(p_bonus, 0)) * 0.1);
end;

SELECT empno, ename, sal, comm, TAX2(sal, comm) AS tax
FROM emp;

급여(커미션 포함)에 대한 세율을 다음과 같이 정의함. 급여가 월 $1,000보다 적으면 세율을 5% 적용하며,
$1,000 이상 $2,000이하면 10%, $2,000을 초과하면 20%를 적용함
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


사원번호를 통해서 급여를 알려주는 함수
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


부서번호를 전달하면 부서명을 구할 수 있는 함수
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

[실습문제]
1) 두 숫자를 제공하면 덧셈을 해서 결과값을 변환하는 함수를 정의하시오(add_num)
create or replace function add_num(num1 integer, num2 integer)
    return integer is
begin 
  return num1 + num2;
end;

SELECT add_num(4,5) FROM dual;

2) 부서번호를 입력하면 해당 부서에서 근무하는 사원수를 반환하는 함수를 정의하시오(get_emp_count)
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

SELECT deptno, dname, get_emp_count(deptno) 사원수 FROM dept;

3) emp테이블을 이용해서 사원번호를 입력하면 해당 사원의 관리자 이름을 구하는 함수를 정의하시오(get_mgr_name)
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

SELECT empno, ename, get_mgr_name(empno) "관리자 이름" FROM emp;

4) emp 테이블의 입사일을 입력하면 근무연차를 구하는 함수를 정의하시오.(소수점 자리는 절삭 trunc) (get_info_hiredate)
create or replace function get_info_hiredate(hire_date emp.hiredate%type)
    return number is
begin
    return TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12);
end;

SELECT ename, get_info_hiredate(hiredate) 근무연차 FROM emp;

5) emp테이블을 이용해서 사원번호를 입력하면 급여등급을 구하는 함수를 정의하시오.(get_sal_grade)
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

SELECT ename, sal, get_sal_grade(empno) 급여등급 FROM emp;

6) 사원번호를 입력하면 근무부서명을 구하는 함수(find_dname)
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




프로시저
create or replace procedure hello_world 
is 
    message VARCHAR2(100);
begin
    message := 'Hello World';
    dbms_output.put_line(message);
end;

프로시저 실행
EXEC 또는 EXECUTE 프로시저명(파라미터...);

exec hello_world;

create or replace procedure hello_world(p_message IN VARCHAR2)
is
begin
    dbms_output.put_line(p_message);
end;

exec hello_world('Korea');

부서테이블에 부서정보를 입력하는 프로시저를 생성
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

사원테이블에 사원 정보를 저장
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

부서번호를 통해서 부서명과 부서의 위치 구하기
create or replace procedure output_department(p_deptno in dept.deptno%type)
is
    --변수선언
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

커서 이용하기
커서(cursor)를 이용하여 질의 수행 결과 반환되는 여러 행(결과집합)을 처리

create or replace procedure info_hiredate(p_year in varchar2)
is
    --%ROWTYPE : %ROWtype으로 데이터 타입이 지정되어 있는 사원 테이블(emp)의 
    --          하나의 행이 가지는 모든 컬럼의 데이터 타입을 가져옴
    e_emp emp%ROWTYPE;
    --커서 선언
    CURSOR emp_cur is 
        SELECT empno, ename, sal
        FROM emp
        WHERE TO_CHAR(hiredate, 'YYYY') = p_year;
begin
    OPEN emp_cur;
    loop
        fetch emp_cur into e_emp.empno, e_emp.ename, e_emp.sal;
        exit WHEN emp_cur%NOTFOUND; --행이 없으면 loop문 종료
        dbms_output.put_line(e_emp.empno || ', ' || e_emp.ename || ', ' || e_emp.sal);
    end loop;
    CLOSE emp_cur;
end;

exec info_hiredate('1981');

SALES 부서에 속한 사원의 정보 보기
create or replace procedure emp_info(p_dept dept.dname%type)
is
    cursor emp_cur is
        SELECT empno, ename
        FROM emp e JOIN dept d
        ON e.deptno = d.deptno
        WHERE dname = UPPER(p_dept);
        
        --변수 선언
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

예외처리

create or replace procedure info_hiredate2(p_syear in char := null,
                                           p_eyear in char := null)
is
    --예외 선언
    year_err EXCEPTION;
    --변수 선언
    e_emp emp%ROWTYPE;
    --커서의 선언
    cursor year_cur is
        SELECT empno, ename, hiredate
        FROM emp
        WHERE TO_CHAR(hiredate, 'YYYY') BETWEEN p_syear AND p_eyear;
begin
    --인자로 전달되는 연도가 없는 경우 예외가 발생
    if ((p_syear IS NULL) OR (p_eyear IS NULL)) then
        RAISE year_err;
    end if;

    open year_cur;
    loop
        fetch year_cur into e_emp.empno, e_emp.ename, e_emp.hiredate;
        exit when year_cur%NOTFOUND; --행이 없으면 LOOP 종료
        dbms_output.put_line(e_emp.empno ||', ' || e_emp.ename || ', ' || e_emp.hiredate);
    end loop;
    close year_cur;
    --예외처리부
    exception when year_err then
        dbms_output.put_line('시작 연도 및 마감 연도의 값을 확인하세요!');
end;

exec info_hiredate2('1980', '1981');
exec info_hiredate2();

[실습문제]

1) 업무를 입력하여 해당 업무를 수행하는 사원들의 사원번호, 이름, 급여, 업무를 출력하시오.
(프로시저명 : job_info, 커서명 : emp_cur)
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


2) 사원번호와 새 업무를 입력하면 emp 테이블의 해당 사원의 업무를 갱신할 수 있는 프로시저를 작성하시오.
(프로시저명 : change_job)
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

3) 부서 이름을 입력받으면 해당 부서의 사원에 대해 급여가 많은 순으로 정보를 제공
(프로시저 : emp_salary_info, 커서명 : emp_cur)
create or replace procedure emp_salary_info(p_dname dept.dname%type)
is
    --변수 선언
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


























