-- 오라클 함수
-- 1. 문자 처리 함수
-- LENGTH, LENGTHB(길이구함), SUBSTR(문자 자름), INSTR(문자 구함)
-- LPAD, RPAD(채우는 것)


--@실습문제 
-- 다음문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
SELECT LTRIM(RTRIM('982341678934509hello89798739273402', '1234567890'), '1234567890')
FROM DUAL;

--@실습문제
---- 사원명에서 성만 중복없이 사전순으로 출력하세요.
SELECT SUBSTR(EMP_NAME,1,1) "성"
FROM EMPLOYEE
ORDER BY 1 ASC;
-- 중복없이 출력
SELECT DISTINCT SUBSTR(EMP_NAME,1,1) "성"
FROM EMPLOYEE
ORDER BY 1 ASC;

-- @실습문제
-- employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 주민번호의 뒷6자리는 *처리하세요.
SELECT EMP_ID "사원번호", EMP_NAME "이름", RPAD(SUBSTR(EMP_NO,1,8), 14, '*') "주민번호", SALARY*12 "연봉"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1,3);
--                                         SUBSTR(EMP_NO, 1, 8) || '******' CONCAT과 같음
SELECT EMP_ID "사원번호", EMP_NAME "이름", CONCAT(SUBSTR(EMP_NO,1,8),('******')) "주민번호", SALARY*12 "연봉",'원'
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1,3);
--WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3'

-- 2. 숫자 처리 함수
-- MOD(NUMBER, DIVISION) 나머지구함  ROUND(반올림) TRUNC(버림) 만 소수점 지정해서 함
--@실습문제
--EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오 
--(SYSDATE를 사용하면 현재 시간 출력)
SELECT EMP_NAME, SYSDATE - HIRE_DATE "근무일수", FLOOR(SYSDATE - HIRE_DATE) "버림", ROUND(SYSDATE - HIRE_DATE) "반올림", CEIL(SYSDATE - HIRE_DATE) "올림"
FROM EMPLOYEE;
-- 3. 날짜 처리 함수

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3)
FROM EMPLOYEE;
--@실습문제
--EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오
SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "PERIOD"
FROM EMPLOYEE;
--@실습문제
--ex) EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사월의 마지막날을 조회하세요
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;
--@실습문제
--ex) EMPLOYEE 테이블에서 사원 이름, 입사 년도, 입사 월, 입사 일을 조회하시오
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||'년' "년", EXTRACT(MONTH FROM HIRE_DATE)||'월' "월", EXTRACT(DAY FROM HIRE_DATE)||'일' "일"
FROM EMPLOYEE;

--@실습문제
/*
     오늘부로 일용자씨가 군대에 끌려갑니다.
     군복무 기간이 1년 6개월을 한다라고 가정하면
     첫번째,제대일자를 구하시고,
     두번째,제대일자까지 먹어야할 짬밥의 그룻수를 구합니다.
     (단, 1일 3끼를 먹는다고 한다.)
*/
SELECT ADD_MONTHS(SYSDATE,18) "제대일자", (ADD_MONTHS(SYSDATE,18) - SYSDATE) * 3 || '그릇' "짬밥 수"
FROM DUAL;
-- 4. 형변환 함수


-- @함수 최종실습문제
--1. 직원명과 이메일 , 이메일 길이를 출력하시오
--		  이름	    이메일		이메일길이
--	ex)  홍길동 , hong@kh.or.kr   	  13
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- 이메일의 길이가 13보다 적은 데이터를 검색해보시오
SELECT * FROM EMPLOYEE
WHERE LENGTH(EMAIL) < 15;
--2. 직원의 이름과 이메일 주소중 아이디 부분만 출력하시오
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1 , 6), SUBSTR(EMAIL, 1, INSTR(EMAIL, '@', 1, 1)-1)
FROM EMPLOYEE;
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;
--3. 60년대에 태어난 직원명과 년생, 보너스 값을 출력하시오. 그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오 
--	    직원명    년생      보너스
--	ex) 선동일	    1962	    0.3
--	ex) 송은희	    1963  	    0
SELECT EMP_NAME "직원명", '19'||SUBSTR(EMP_NO,1,2) "년생" , NVL(BONUS,'0') "보너스"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,1) = '6';
--4. '010' 핸드폰 번호를 쓰지 않는 사람의 수를 출력하시오 (뒤에 단위는 명을 붙이시오) *
--	   인원
--	ex) 3명
SELECT PHONE
FROM EMPLOYEE
WHERE SUBSTR(PHONE,1,3) NOT IN ('010');
--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년 12월
--	ex) 전지연		1997년 3월
SELECT EMP_NAME "직원명" , EXTRACT(YEAR FROM HIRE_DATE)||'년 ' || EXTRACT(MONTH FROM HIRE_DATE)||'월' "입사년월"
FROM EMPLOYEE;
--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서출력 하시오
--	ex) 홍길동 771120-1******
SELECT EMP_NAME, SUBSTR(EMP_NO,1,8) || '******'
FROM EMPLOYEE;
--7. 직원명, 직급코드, 연봉(원) 조회 
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME, JOB_CODE, '￦'||12*(SALARY+ SALARY*NVL(BONUS, 0))
FROM EMPLOYEE;
--8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원중에 조회함.
--   사번 사원명 부서코드 입사일
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D9') AND EXTRACT(YEAR FROM HIRE_DATE) = '2004';
--9. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
SELECT EMP_NAME, HIRE_DATE, ROUND(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;
--10. 직원명, 부서코드, 생년월일, 나이(만) 조회 *
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
--	* 주민번호가 이상한 사람들은 제외시키고 진행 하도록(200,201,214 번 제외)
--	* HINT : NOT IN 사용
SELECT EMP_NAME, DEPT_CODE, '19'||SUBSTR(EMP_NO,1,2)||'년' || SUBSTR(EMP_NO,3,2)||'월'||SUBSTR(EMP_NO,5,2)||'일' "생년월일",ROUND((SYSDATE - TO_DATE('19'||SUBSTR(EMP_NO,1,2)|| SUBSTR(EMP_NO,3,2)||SUBSTR(EMP_NO,5,2)))/ 365) "나이(만)"
FROM EMPLOYEE
WHERE EMP_ID NOT IN ('200','201','214');
--11. 사원명과, 부서명을 출력하세요. *
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.


-- 최종 실습 문제
-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라
SELECT EMP_NAME, EMP_NO, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE ((SYSDATE - HIRE_DATE) / 365) > 5 AND ((SYSDATE - HIRE_DATE) / 365) < 10;
-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라 
--(퇴사 여부 : ENT_YN)
SELECT EMP_NAME, EMP_ID, HIRE_DATE, ENT_DATE - HIRE_DATE, ENT_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';
-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하여라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.
SELECT EMP_NAME, SALARY * 150,ROUND((SYSDATE - HIRE_DATE) / 365)
FROM EMPLOYEE
ORDER BY (SYSDATE - HIRE_DATE) / 365 ASC;
-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
SELECT EMP_NAME, EMP_NO, EMAIL, PHONE, SALARY
FROM EMPLOYEE
WHERE HIRE_DATE >= '99/01/01' AND HIRE_DATE <= '10/01/01' AND SALARY <= 2000000; 
-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.
SELECT EMP_NAME, EMP_NO, SALARY, NVL(DEPT_CODE, '없음')
FROM EMPLOYEE
WHERE SALARY >= 2000000 AND SALARY <= 3000000 AND SUBSTR(EMP_NO,3,2) = '04'
ORDER BY EMP_NO DESC;
-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
SELECT EMP_NAME, SALARY + SALARY * 0.1 * ROUND((SYSDATE - HIRE_DATE) / 1000) "특별 보너스"
FROM EMPLOYEE
WHERE BONUS IS NULL
ORDER BY EMP_NAME ASC;
