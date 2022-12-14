-- 사용자 계정 생성, 권한부여 및 해제
CREATE USER STUDENT IDENTIFIED BY STUDENT; --비밀번호는 대소문자를 구분한다
--User STUDENT이(가) 생성되었습니다.
-- 상태: 실패 -테스트 실패:
-- ORA-01045 user STUDENT lacks create session privilege logon denied
GRANT CONNECT TO STUDENT;
--Grant을(를) 성공했습니다.
GRANT RESOURCE TO STUDENT;

CREATE USER KH IDENTIFIED BY KH;

GRANT CONNECT TO KH;
GRANT RESOURCE TO KH;

GRANT CONNECT, RESOURCE TO KH;


