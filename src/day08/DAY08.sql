-- 문제.1 기술지원부에 속한 사람들의 사원의 이름 부서코드 급여를 출력하시오
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '기술지원부';
-- 문제.2 기술지원부에 속한 사람들 중 가장 연봉이 높은 사람의 이름 부서코드 급여를 출력하시오
SELECT EMP_NAME AS 이름, DEPT_CODE AS 부서코드, SALARY AS 급여
FROM EMPLOYEE E
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '기술지원부' 
AND SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '기술지원부');

-- 문제.3 매니저가 있는 사람중에 월급이 전체사원 평균을 넘고 사번 이름 매니저 이름 월급을 구하시오. 
SELECT EMP_ID "사번", EMP_NAME "이름", (SELECT EMP_NAME FROM EMPLOYEE A WHERE A.EMP_ID = E.MANAGER_ID) "매니저 이름", SALARY "월급"
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE) AND MANAGER_ID IS NOT NULL;

-- ## JOIN의 종류3
-- 1. 상호조인(CROSS JOIN)
-- 카테이션 곱(Cartensial product)라고도 함
-- 조인되는 테이블의 각 행들이 모두 매핑된 조인 방법
-- 다시말해, 한쪽 테이블의 모든 행과 다른쪽 테이블의 모든 행을 조인시킴
-- 모든 경우의 수를 구하므로 결과는 두 테이블의 칼럼수를 곱한 개수가 나옴.
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;
--@실습문제
--아래처럼 나오도록 하세요.
----------------------------------------------------------------
-- 사원번호    사원명     월급    평균월급    월급-평균월급
----------------------------------------------------------------
SELECT D.EMP_ID , D.EMP_NAME, D.SALARY, FLOOR(AVG(E.SALARY))"평균월급", FLOOR(D.SALARY - AVG(E.SALARY)) "월급-평균월급"
FROM EMPLOYEE D
CROSS JOIN EMPLOYEE E
GROUP BY D.EMP_ID, D.EMP_NAME, D.SALARY
ORDER BY 1 ASC;

SELECT EMP_ID, EMP_NAME, SALARY, AVG_SAL,(CASE WHEN SALARY - AVG_SAL > 0  THEN '+' END) || (SALARY - AVG_SAL) 
FROM EMPLOYEE
CROSS JOIN (SELECT FLOOR(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);
-- 2. 셀프조인(SELF JOIN)
-- 문제.3 매니저가 있는 사람중에 월급이 전체사원 평균을 넘는 직원의 사번 이름 매니저 이름 월급을 구하시오.
SELECT E.EMP_ID, E.EMP_NAME, M.MANAGER_ID, E.SALARY
FROM EMPLOYEE E
JOIN EMPLOYEE M
ON M.EMP_ID = E.MANAGER_ID;

-- 직급이 J1, J2, J3이 아닌 사원중에서 자신의 부서별 평균급여보다 많은 급여를 받는 사원출력.
-- 부서코드, 사원명, 급여, 부서별 급여평균
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT E.DEPT_CODE, EMP_NAME, SALARY, 부서별평균
FROM EMPLOYEE E
JOIN (SELECT DEPT_CODE, FLOOR(AVG(SALARY)) "부서별평균" FROM EMPLOYEE GROUP BY DEPT_CODE) A ON A.DEPT_CODE  = E.DEPT_CODE
WHERE JOB_CODE NOT IN ('J1', 'J2', 'J3') AND SALARY > 부서별평균;
-- 노옹철 송종기 선동일 정중하 유재식 심봉선
CREATE TABLE USER_DEFAULT(
    USER_NO NUMBER CONSTRAINT USER_NO_PK1 PRIMARY KEY,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_DATE DATE DEFAULT SYSDATE,
    USER_YN CHAR(1) DEFAULT 'Y'
);
-- TCL
-- 트랜젝션이란?
-- 한꺼번에 수행되어야 할 최소의 작업 단위를 말함,
-- 하나의 트랜잭션으로 이루어진 작업들은 반드시 한꺼번에 완료가 되어야 하며,
-- 그렇지 않은 경우에는 한꺼번에 취소 되어야 함
-- TCL의 종류
-- 1. COMMIT : 트랜잭션 작업이 정상 완료 되면 변경 내용을 영구히 저장 (모든 savepoint 삭제)
-- 2. ROLLBACK : 트랜잭션 작업을 모두 취소하고 가장 최근 COMMIT 시점으로 이동
-- 3. SAVEPOINT : 현재 트랜잭션 작업 시점에 이름을 저장함, 하나의 트랜잭션 안에서 구역을 나눌수 있음
-- >> ROLLBACK TO 세이브포인트명 : 트랜잭션 작업을 취소하고 savepoint 시점으로 이동


INSERT INTO USER_DEFAULT VALUES (1, '일용자', DEFAULT, DEFAULT);
INSERT INTO USER_DEFAULT VALUES (2, '이용자', DEFAULT, DEFAULT);
INSERT INTO USER_DEFAULT VALUES (3, '삼용자', DEFAULT, DEFAULT);
INSERT INTO USER_DEFAULT VALUES (4, '사용자', DEFAULT, DEFAULT);
SAVEPOINT TEMP1;
INSERT INTO USER_DEFAULT VALUES (5, '오용자', DEFAULT, DEFAULT);
INSERT INTO USER_DEFAULT VALUES (6, '육용자', DEFAULT, DEFAULT);
SELECT * FROM USER_DEFAULT;
COMMIT;
ROLLBACK TO TEMP1;
ROLLBACK;

--# DCL(Data Control Languege)
-- 데이터 제어어 --> System계정에서 해야만 함
-- DB에 대한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어
-- 무결성이란? : 정확성, 일관성을 유지하는 것
-- 사용자의 권한이나 관리자 설정 등을처리
-- DCL의 종류
-- 1. GRANT : 권한 부여
-- 2. REVOKE : 권한 회수
-- GRANT CONNECT RESOURCE TO STUDENT; -- System계정으로 연결해서 하세요!!
-- CONNECT, RESOURCE 롤이다, 롤은 권한이 여러개가 모여있다.
-- 롤은 필요한 권한을 묶어서 관리할 때 편하고 부여, 회수할 때 편하다!!
-- ROLE
-- CONNECT롤 : CREATE SESSION
-- RESOURCE롤 : CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE, CREATE TRIGGER, CREATE TYPE, CREATE INDEXTYPE, CREATE OPERATOR;


-- Oracle object
-- DB를 효율적으로 관리 또는 동작하게 하는 요소
-- Oracle object의 종류
--테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX), 패키지(PACKAGE), 
--프로시저(PROCEDUAL), 함수(FUNCTION), 트리거(TRIGGER), 동의어(SYNONYM), 
--사용자(USER)가 있다.
SELECT DISTINCT OBJECT_TYPE FROM ALL_OBJECTS;
--# VIEW
-- -> 하나 이상의 테이블에서 원하는 데이터를 선택하여 가상의 테이블을 만들어주는것
-- 다른 테이블에 있는 데이터를 보여줄 뿐이며, 데이터 자체를 포함하고 있는 곳은 아님
-- 즉, 저장장치 내에 물리적으로 존재하지 않고 가상테이블로 만들어짐
-- 물리적인 실제 테이블과의 링크 개념
-- -> 뷰를 사용하여 특정 사용자가 원본 테이블에 접근하여 모든 데이터를 보게 하는 것을 방지할 수 있음
-- 다시말해 원본 테이블이 아닌 뷰를 통한 특정 데이터만 보여지게 만듬
-- -> 뷰를 만들기 위해서는 권한이 필요함, RESOURCE롤에는 포함되어있지 않음!!!(주의)
-- GRANT CREATE VIEW TO KH; (시스템 계정에서 실행!)

CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
SELECT * FROM(SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE);
SELECT * FROM V_EMPLOYEE
WHERE EMP_ID = 200;
DROP VIEW V_EMPLOYEE;

CREATE VIEW V_EMP_READ
AS SELECT EMP_ID, DEPT_TITLE FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE;

SELECT * FROM V_EMP_READ;

UPDATE V_EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE EMP_ID = 200;

SELECT *
FROM EMPLOYEE;

-- -> VIEW는 수정 가능함!!
-- VIEW수정2
UPDATE V_EMPLOYEE
SET SALARY = 6000000
WHERE EMP_ID = 200;

-- ### 2. Sequence(시퀀스)
-- 순차적으로 정수 값을 자동으로 생성하는 객체로 자동 변호 발생기(채번기)의 역할을 함
-- CREATE SEQUENCE 시퀀스명
-- 생략가능한 옵션이 6개가 있음 START WITH, INCREMENT BY, MAXVALUE, MINVALUEM CYCLE, CACHE
SELECT * FROM USER_DEFAULT;

CREATE SEQUENCE SEQ_USERNO;
DROP SEQUENCE SEQ_USERNO;
SELECT * FROM USER_SEQUENCES;
INSERT INTO USER_DEFAULT VALUES(SEQ_USERNO.NEXTVAL, '십용자' , DEFAULT,DEFAULT);
DELETE FROM USER_DEFAULT;
SELECT * FROM USER_DEFAULT;
ROLLBACK;
-- 시퀀스로 INSERT할 때 오류가 나도 시퀀스값은 증가함!!

-- NEXTVAL, CURRVAL 사용할 수 이는 경우
-- 1. 서브쿼리가 아닌 SELECT문
-- 2. INSERT문의 SELECT절
-- 2. INSERT문의 VALUES절
-- 4. UPDATE문의 SET절

-- CURRVAL을 사용할 때 주의할 점
-- NEXTVAL을 무조건 1번 실행한 후에 CURRVAL을 할 수 있음.

--시퀀스 수정
-- START WITH값은 변경이 불가능하기 때문에 변경하려면 삭제 후 다시 생성해야함.
CREATE SEQUENCE SEQ_SAMPLE;
SELECT * FROM USER_SEQUENCES;
ALTER SEQUENCE SEQ_SAMPLE
INCREMENT BY 10;

-- 고유의 값을 사용하려면 KH001, K-0-1등의 형태로 사용함