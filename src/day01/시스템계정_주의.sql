-- ����� ���� ����, ���Ѻο� �� ����
CREATE USER STUDENT IDENTIFIED BY STUDENT; --��й�ȣ�� ��ҹ��ڸ� �����Ѵ�
--User STUDENT��(��) �����Ǿ����ϴ�.
-- ����: ���� -�׽�Ʈ ����:
-- ORA-01045 user STUDENT lacks create session privilege logon denied
GRANT CONNECT TO STUDENT;
--Grant��(��) �����߽��ϴ�.
GRANT RESOURCE TO STUDENT;

CREATE USER KH IDENTIFIED BY KH;

GRANT CONNECT TO KH;
GRANT RESOURCE TO KH;

GRANT CONNECT, RESOURCE TO KH;


