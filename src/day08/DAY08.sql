-- ����.1 ��������ο� ���� ������� ����� �̸� �μ��ڵ� �޿��� ����Ͻÿ�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '���������';
-- ����.2 ��������ο� ���� ����� �� ���� ������ ���� ����� �̸� �μ��ڵ� �޿��� ����Ͻÿ�
SELECT EMP_NAME AS �̸�, DEPT_CODE AS �μ��ڵ�, SALARY AS �޿�
FROM EMPLOYEE E
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '���������' 
AND SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '���������');

-- ����.3 �Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѱ� ��� �̸� �Ŵ��� �̸� ������ ���Ͻÿ�. 
SELECT EMP_ID "���", EMP_NAME "�̸�", (SELECT EMP_NAME FROM EMPLOYEE A WHERE A.EMP_ID = E.MANAGER_ID) "�Ŵ��� �̸�", SALARY "����"
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE) AND MANAGER_ID IS NOT NULL;

-- ## JOIN�� ����3
-- 1. ��ȣ����(CROSS JOIN)
-- ī���̼� ��(Cartensial product)��� ��
-- ���εǴ� ���̺��� �� ����� ��� ���ε� ���� ���
-- �ٽø���, ���� ���̺��� ��� ��� �ٸ��� ���̺��� ��� ���� ���ν�Ŵ
-- ��� ����� ���� ���ϹǷ� ����� �� ���̺��� Į������ ���� ������ ����.
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;
--@�ǽ�����
--�Ʒ�ó�� �������� �ϼ���.
----------------------------------------------------------------
-- �����ȣ    �����     ����    ��տ���    ����-��տ���
----------------------------------------------------------------
SELECT D.EMP_ID , D.EMP_NAME, D.SALARY, FLOOR(AVG(E.SALARY))"��տ���", FLOOR(D.SALARY - AVG(E.SALARY)) "����-��տ���"
FROM EMPLOYEE D
CROSS JOIN EMPLOYEE E
GROUP BY D.EMP_ID, D.EMP_NAME, D.SALARY
ORDER BY 1 ASC;

SELECT EMP_ID, EMP_NAME, SALARY, AVG_SAL,(CASE WHEN SALARY - AVG_SAL > 0  THEN '+' END) || (SALARY - AVG_SAL) 
FROM EMPLOYEE
CROSS JOIN (SELECT FLOOR(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);
-- 2. ��������(SELF JOIN)
-- ����.3 �Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѵ� ������ ��� �̸� �Ŵ��� �̸� ������ ���Ͻÿ�.
SELECT E.EMP_ID, E.EMP_NAME, M.MANAGER_ID, E.SALARY
FROM EMPLOYEE E
JOIN EMPLOYEE M
ON M.EMP_ID = E.MANAGER_ID;

-- ������ J1, J2, J3�� �ƴ� ����߿��� �ڽ��� �μ��� ��ձ޿����� ���� �޿��� �޴� ������.
-- �μ��ڵ�, �����, �޿�, �μ��� �޿����
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT E.DEPT_CODE, EMP_NAME, SALARY, �μ������
FROM EMPLOYEE E
JOIN (SELECT DEPT_CODE, FLOOR(AVG(SALARY)) "�μ������" FROM EMPLOYEE GROUP BY DEPT_CODE) A ON A.DEPT_CODE  = E.DEPT_CODE
WHERE JOB_CODE NOT IN ('J1', 'J2', 'J3') AND SALARY > �μ������;
-- ���ö ������ ������ ������ ����� �ɺ���
CREATE TABLE USER_DEFAULT(
    USER_NO NUMBER CONSTRAINT USER_NO_PK1 PRIMARY KEY,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_DATE DATE DEFAULT SYSDATE,
    USER_YN CHAR(1) DEFAULT 'Y'
);
-- TCL
-- Ʈ�������̶�?
-- �Ѳ����� ����Ǿ�� �� �ּ��� �۾� ������ ����,
-- �ϳ��� Ʈ��������� �̷���� �۾����� �ݵ�� �Ѳ����� �Ϸᰡ �Ǿ�� �ϸ�,
-- �׷��� ���� ��쿡�� �Ѳ����� ��� �Ǿ�� ��
-- TCL�� ����
-- 1. COMMIT : Ʈ����� �۾��� ���� �Ϸ� �Ǹ� ���� ������ ������ ���� (��� savepoint ����)
-- 2. ROLLBACK : Ʈ����� �۾��� ��� ����ϰ� ���� �ֱ� COMMIT �������� �̵�
-- 3. SAVEPOINT : ���� Ʈ����� �۾� ������ �̸��� ������, �ϳ��� Ʈ����� �ȿ��� ������ ������ ����
-- >> ROLLBACK TO ���̺�����Ʈ�� : Ʈ����� �۾��� ����ϰ� savepoint �������� �̵�


INSERT INTO USER_DEFAULT VALUES (1, '�Ͽ���', DEFAULT, DEFAULT);
INSERT INTO USER_DEFAULT VALUES (2, '�̿���', DEFAULT, DEFAULT);
INSERT INTO USER_DEFAULT VALUES (3, '�����', DEFAULT, DEFAULT);
INSERT INTO USER_DEFAULT VALUES (4, '�����', DEFAULT, DEFAULT);
SAVEPOINT TEMP1;
INSERT INTO USER_DEFAULT VALUES (5, '������', DEFAULT, DEFAULT);
INSERT INTO USER_DEFAULT VALUES (6, '������', DEFAULT, DEFAULT);
SELECT * FROM USER_DEFAULT;
COMMIT;
ROLLBACK TO TEMP1;
ROLLBACK;

--# DCL(Data Control Languege)
-- ������ ����� --> System�������� �ؾ߸� ��
-- DB�� ���� ����, ���Ἲ, ���� �� DBMS�� �����ϱ� ���� ���
-- ���Ἲ�̶�? : ��Ȯ��, �ϰ����� �����ϴ� ��
-- ������� �����̳� ������ ���� ����ó��
-- DCL�� ����
-- 1. GRANT : ���� �ο�
-- 2. REVOKE : ���� ȸ��
-- GRANT CONNECT RESOURCE TO STUDENT; -- System�������� �����ؼ� �ϼ���!!
-- CONNECT, RESOURCE ���̴�, ���� ������ �������� ���ִ�.
-- ���� �ʿ��� ������ ��� ������ �� ���ϰ� �ο�, ȸ���� �� ���ϴ�!!
-- ROLE
-- CONNECT�� : CREATE SESSION
-- RESOURCE�� : CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE, CREATE TRIGGER, CREATE TYPE, CREATE INDEXTYPE, CREATE OPERATOR;


-- Oracle object
-- DB�� ȿ�������� ���� �Ǵ� �����ϰ� �ϴ� ���
-- Oracle object�� ����
--���̺�(TABLE), ��(VIEW), ������(SEQUENCE), �ε���(INDEX), ��Ű��(PACKAGE), 
--���ν���(PROCEDUAL), �Լ�(FUNCTION), Ʈ����(TRIGGER), ���Ǿ�(SYNONYM), 
--�����(USER)�� �ִ�.
SELECT DISTINCT OBJECT_TYPE FROM ALL_OBJECTS;
--# VIEW
-- -> �ϳ� �̻��� ���̺��� ���ϴ� �����͸� �����Ͽ� ������ ���̺��� ������ִ°�
-- �ٸ� ���̺� �ִ� �����͸� ������ ���̸�, ������ ��ü�� �����ϰ� �ִ� ���� �ƴ�
-- ��, ������ġ ���� ���������� �������� �ʰ� �������̺�� �������
-- �������� ���� ���̺���� ��ũ ����
-- -> �並 ����Ͽ� Ư�� ����ڰ� ���� ���̺� �����Ͽ� ��� �����͸� ���� �ϴ� ���� ������ �� ����
-- �ٽø��� ���� ���̺��� �ƴ� �並 ���� Ư�� �����͸� �������� ����
-- -> �並 ����� ���ؼ��� ������ �ʿ���, RESOURCE�ѿ��� ���ԵǾ����� ����!!!(����)
-- GRANT CREATE VIEW TO KH; (�ý��� �������� ����!)

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

-- -> VIEW�� ���� ������!!
-- VIEW����2
UPDATE V_EMPLOYEE
SET SALARY = 6000000
WHERE EMP_ID = 200;

-- ### 2. Sequence(������)
-- ���������� ���� ���� �ڵ����� �����ϴ� ��ü�� �ڵ� ��ȣ �߻���(ä����)�� ������ ��
-- CREATE SEQUENCE ��������
-- ���������� �ɼ��� 6���� ���� START WITH, INCREMENT BY, MAXVALUE, MINVALUEM CYCLE, CACHE
SELECT * FROM USER_DEFAULT;

CREATE SEQUENCE SEQ_USERNO;
DROP SEQUENCE SEQ_USERNO;
SELECT * FROM USER_SEQUENCES;
INSERT INTO USER_DEFAULT VALUES(SEQ_USERNO.NEXTVAL, '�ʿ���' , DEFAULT,DEFAULT);
DELETE FROM USER_DEFAULT;
SELECT * FROM USER_DEFAULT;
ROLLBACK;
-- �������� INSERT�� �� ������ ���� ���������� ������!!

-- NEXTVAL, CURRVAL ����� �� �̴� ���
-- 1. ���������� �ƴ� SELECT��
-- 2. INSERT���� SELECT��
-- 2. INSERT���� VALUES��
-- 4. UPDATE���� SET��

-- CURRVAL�� ����� �� ������ ��
-- NEXTVAL�� ������ 1�� ������ �Ŀ� CURRVAL�� �� �� ����.

--������ ����
-- START WITH���� ������ �Ұ����ϱ� ������ �����Ϸ��� ���� �� �ٽ� �����ؾ���.
CREATE SEQUENCE SEQ_SAMPLE;
SELECT * FROM USER_SEQUENCES;
ALTER SEQUENCE SEQ_SAMPLE
INCREMENT BY 10;

-- ������ ���� ����Ϸ��� KH001, K-0-1���� ���·� �����