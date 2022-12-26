--@�ǽ�����
--kh���� ������ �� employee, job, department���̺��� �Ϻ������� ����ڿ��� �����Ϸ��� �Ѵ�.
-- ������̵�, �����, ���޸�, �μ���, �����ڸ�, �Ի����� �÷������� ��(v_emp_info)�� (�б� ��������) �����Ͽ���.


CREATE OR REPLACE VIEW v_emp_info
AS SELECT E.EMP_ID "������̵�", E.EMP_NAME "�����", JOB_NAME "���޸�", DEPT_TITLE " �μ���", A.EMP_NAME "�����ڸ�" ,E.HIRE_DATE "�Ի���"
FROM EMPLOYEE E
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON E.DEPT_CODE = DEPT_ID
LEFT JOIN EMPLOYEE A ON E.MANAGER_ID = A.EMP_ID;

DROP VIEW v_emp_info;
SELECT * FROM v_emp_info;

-- VIEW �ɼ�
-- VIEW�� ���� �Ŀ� �����ؾߵ� ��� ���� �� ������ؾ���.
-- 1. OR REPLACE
-- > ������ �䰡 �����ϸ� �並 ��������
-- 2. FORCE/NOFORCE
-- �⺻���� NOFORCE�� ����Ǿ� ����
CREATE OR REPLACE FORCE VIEW V_FORCE_SOMETHING
AS SELECT EMP_ID, EMP_NO FROM NOTHING_TBL;
-- 3. WITH CHECK OPTION
-- > WHERE�� ���ǿ� ����� �÷��� ���� �������� ���ϰ� ��.
CREATE OR REPLACE VIEW V_EMP_D5
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;
UPDATE V_EMP_D5
SET EMP_NAME = '������'
WHERE SALARY >= 800000;

UPDATE V_EMP_D5
SET DEPT_CODE = 'D2'
WHERE SALARY >= 2500000;
ROLLBACK;
-- 4. WIHE READ ONLY
-- View�����ϱ�
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WITH READ ONLY;
-- �б� �������� ����
UPDATE V_EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE EMP_ID = 200;

--@�ǽ�����
--���� ��ǰ�ֹ��� ����� ���̺� TBL_ORDER�� �����, ������ ���� �÷��� �����ϼ���
-- ORDER_NO(�ֹ�NO) : PK
-- USER_ID(�����̵�)
-- PRODUCT_ID(�ֹ���ǰ���̵�)
-- PRODUCT_CNT(�ֹ�����) 
-- ORDER_DATE : DEFAULT SYSDATE

-- ORDER_NO�� ������ SEQ_ORDER_NO�� �����, ���� �����͸� �߰��ϼ���.(����ð� ����)
-- * kang���� saewookkang��ǰ�� 5�� �ֹ��ϼ̽��ϴ�.
-- * gam���� gamjakkang��ǰ�� 30�� �ֹ��ϼ̽��ϴ�.
-- * ring���� onionring��ǰ�� 50�� �ֹ��ϼ̽��ϴ�.
CREATE TABLE TBL_ORDER(
ORDER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20),
PRODUCT_ID VARCHAR2(20),
PRODUCT_CNT NUMBER,
ORDRT_DATE DATE DEFAULT(SYSDATE)
);
ALTER TABLE ORDER_TBL RENAME TO TBL_ORDER;

CREATE SEQUENCE SEQ_ORDER_NO;

INSERT INTO TBL_ORDER VALUES(SEQ_ORDER_NO.NEXTVAL,'kang', 'seawookkang', 5, DEFAULT);
INSERT INTO TBL_ORDER VALUES(SEQ_ORDER_NO.NEXTVAL,'gam', 'gamjakkang', 30, DEFAULT);
INSERT INTO TBL_ORDER VALUES(SEQ_ORDER_NO.NEXTVAL,'ring', 'onionring', 30, DEFAULT);
SELECT SEQ_ORDER_NO.CURRVAL FROM DUAL;

ROLLBACK;

-- �ǽ�����2
--KH_MEMBER ���̺��� ����
--�÷�
--MEMBER_ID	NUNBER
--MEMBER_NAME	VARCHAR2(20)
--MEMBER_AGE	NUMBER
--MEMBER_JOIN_COM	NUMBER

--�̶� �ش� ������� ������ INSERT �ؾ� ��
--ID ���� JOIN_COM�� SEQUENCE �� �̿��Ͽ� ������ �ְ��� ��

--ID���� 500 �� ���� �����Ͽ� 10�� �����Ͽ� ���� �ϰ��� ��
--JOIN_COM ���� 1������ �����Ͽ� 1�� �����Ͽ� ���� �ؾ� ��
--(ID ���� JOIN_COM ���� MAX�� 10000���� ����)

--	MEMBER_ID	MEMBER_NAME	 MEMBER_AGE	 MEMBER_JOIN_COM	
--	500		        ȫ�浿		20		        1
--	510		        �踻��		30		        2
--	520		        �����		40		        3
--	530		        ����		24		        4

CREATE TABLE KH_MEMBER(
MEMBER_ID NUMBER,
MEMBER_NAME VARCHAR2(20),
MEMBER_AGE NUMBER,
MEMBER_JOIN_COM NUMBER
);

CREATE SEQUENCE SEQ_ID
START WITH 500 INCREMENT BY 10 MAXVALUE 10000;
CREATE SEQUENCE SEQ_JOIN_COM START WITH 1 INCREMENT BY 1 MAXVALUE 10000;
DROP SEQUENCE SQE_JOIN_COM;

SELECT * FROM USER_SEQUENCES;
INSERT INTO KH_MEMBER VALUES(SEQ_ID.NEXTVAL,'ȫ�浿', 20, SEQ_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER VALUES(SEQ_ID.NEXTVAL,'�踻��', 30, SEQ_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER VALUES(SEQ_ID.NEXTVAL,'�����', 40, SEQ_JOIN_COM.NEXTVAL);
INSERT INTO KH_MEMBER VALUES(SEQ_ID.NEXTVAL,'����', 24, SEQ_JOIN_COM.NEXTVAL);


SELECT * FROM USER_SEQUENCES;
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_TABLES;

-- ������ ��ųʸ�(DD, DATA DICTIONARY)
-- -> �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�
-- -> ������ ��ųʸ��� ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ����
-- �۾��� �� �� �����ͺ��̽� ������ ���� �ڵ����� ���ŵǴ� ���̺�
-- ����, ����ڴ� ������ ��ųʸ��� ������ ���� �����ϰų� ������ �� ����.
-- ������ ��ųʸ� �ȿ��� �߿��� ������ ���� �ֱ� ������ ����ڴ� �̸� Ȱ���ϱ� ����
-- ������ ��ųʸ� ��(�������̺�)�� ����ϰ� ��.
-- ������ ��ųʸ� ���� ����1
-- 1. USER_XXXX
-- > �ڽ�(����)�� ������ ��ü � ���� ���� ���� ��ȸ����
-- ����ڰ� �ƴ� DB���� �ڵ�����/�������ִ� ���̸� USER_���� ��ü���� �Ἥ ��ȸ��.
-- 2. ALL_XXXX
-- > �ڽ��� ������ �����ϰų� ������ �ο����� ��ü � ���� ���� ��ȸ����
-- 3. DBA_XXXX
-- > �����ͺ��̽� �����ڸ� ������ ������ ��ü � ���� ���� ��ȸ����
-- (DBA�� ��� ������ �����ϹǷ� �ᱹ DB�� �ִ� ��� ��ü�� ���� ��ȸ ����)
-- �Ϲݻ���ڴ� ������
SELECT * FROM DBA_TABLES; --�ý��� ���� ��ȸ

-- ### ROLE
-- -> ����ڿ��� ���� ���� ������ �ѹ��� �ο��� �� �ִ� �����ͺ��̽� ��ü
-- -> ����ڿ��� ������ �ο��� �� �Ѱ��� �ο��ϰ� �ȴٸ� ���� �ο� �� ȸ���� ������ �����ϹǷ� ���)
-- ex. GRANT CONNECT, RESOURCE TO KH;
-- ���Ѱ� ���õ� ��ɾ�� �ݵ�� SYSTEM���� ����!
-- CONNECT, RESOURCE ���̴�. ���� ������ �������� ���ִ�.
-- ���� �ʿ��� ������ ��� ������ �� ���ϰ� �ο�, ȸ���� �� ���ϴ�!!
-- ROLE
-- CONNECT�� : CREATE SESSION
-- RESOURCE�� : CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE
--             CREATE TRIGGER, CREATE TYPE, CREATE INDEXTYPE, CREATE OPERATOR;

-------------------------------------------- �ý��۰���, SYS�� ��ȸ�ؾ� CONNECT, RESOURCE �ѿ� ���� ������ ����
-- 1. KH���� ��ȸ�� 2. SYSTEM���� ��ȸ�ȵ� 3. KH���� �ο��޾Ұ�, SYSTEM���� �ο���������
SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'DBA'; 
SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'CONNECT'; 
CREATE ROLE ROLE_PUBLIC_EMP;
GRANT SELECT ON KH.V_EMP_INFO TO ROLE_PUBLIC_EMP;
-- �����
GRANT ROLE_PUBLIC_EMP TO ������;
--------------------------------------------
SELECT * FROM USER_SYS_PRIVS;

-- 4. INDEX
-- SQL ��ɹ��� ó���ӵ��� ����Ű�� ���ؼ� �÷��� ���ؼ� �����ϴ� ����Ŭ ��ü
-- -> key-value ���·� ������ �Ǹ� key���� �ε����� ���� �÷���, value���� ���� ����� �ּҰ��� �����.
-- * ���� : �˻��ӵ��� �������� �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü ������ ����ų �� ����.
-- * ���� : 1. �ε����� ���� �߰� ���� ������ �ʿ��ϰ�, �ε����� �����ϴµ� �ð��� �ɸ�
--         2. �������� �����۾�(INSERT/UPDATE/DELETE)�� ���� �Ͼ�� ���̺� INDEX ������ ������ �������ϰ� �߻��� �� ����.
-- SELECT�� �� ���Ǵ� BUFFER CACHE�� �÷����� �۾�
-- * � �÷��� �ε����� ����� ������?
-- �����Ͱ��� �ߺ��� ���� ���� ������ �����Ͱ��� ������ �÷��� ����� ���� ���� ����.
-- �׸��� ���� ���Ǵ� �÷��� ����� ����.
-- * ȿ������ �ε��� ��� ��
-- where���� ���� ���Ǵ� �÷��� �ε��� ����
-- > ��ü ������ �߿��� 10% ~ 15% �̳��� �����͸� �˻��ϴ� ���, �ߺ��� ���� ���� �÷��̿�����
-- > �� �� �Էµ� �������� ������ ���� �Ͼ�� �ʴ� ���
-- > �� ���̺� ����� ������ �뷮�� ����� Ŭ ���
--* ��ȿ������ �ε��� ��뿹
-- �ߺ����� ���� �÷��� ���� �ε���
-- NULL���� ���� �÷��� ���� �ε���
-- �ε��� ���� ��ȸ
SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPLOYEE';
-- �ѹ��� ������ �ʾ����� PK, UNIQUE �������� �÷��� �ڵ����� ������ �̸��� �ε����� ������
-- INDEX ����
-- CREATE INDEX �ε����� ON ���̺��(�÷���1, �÷���2, ...);
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '������';
-- ����Ŭ �÷�, Ʃ���� �� ����ϰ� F10���� ���డ����.
CREATE INDEX IDX_EMP_NAME ON EMPLOYEE(EMP_NAME);
-- INDEX ����
DROP INDEX IDX_EMP_NAME;

-- 1. VIEW
-- 2. SEQUENCE
-- 3. ROLE
-- 4. INDEX

--����4
--���� ������ ��ձ޿����� ���ų� ���� �޿��� �޴� ������ �̸�, �����ڵ�, �޿�, �޿���� ��ȸ
SELECT EMP_NAME "�̸�", JOB_CODE "�����ڵ�", SALARY "�޿�", SAL_LEVEL "�޿����"
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE A WHERE E.JOB_CODE = A.JOB_CODE GROUP BY JOB_CODE)
ORDER BY 2;  
--����5
--�μ��� ��� �޿��� 2200000 �̻��� �μ���, ��� �޿� ��ȸ
--��, ��� �޿��� �Ҽ��� ����, �μ����� ���� ��� '����'ó��
SELECT DISTINCT NVL(DEPT_TITLE, '����') "�μ���", FLOOR(AVG(SALARY)) "��ձ޿�"
FROM EMPLOYEE E LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY NVL(DEPT_TITLE, '����')
HAVING AVG(SALARY) > 2200000;

--����6
--������ ���� ��պ��� ���� �޴� ���ڻ����
--�����,���޸�,�μ���,������ �̸� ������������ ��ȸ�Ͻÿ�
--���� ��� => (�޿�+(�޿�*���ʽ�))*12    
-- �����,���޸�,�μ���,������ EMPLOYEE ���̺��� ���� ����� ������
SELECT EMP_NAME "�����", JOB_NAME "���޸�", DEPT_TITLE "�μ���", (SALARY+(SALARY*NVL(BONUS,0))) "����"
FROM EMPLOYEE E LEFT JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE JOIN JOB USING (JOB_CODE)
WHERE SALARY+(SALARY*NVL(BONUS,0)) < (SELECT AVG(SALARY+(SALARY*NVL(BONUS,0))) FROM EMPLOYEE A WHERE A.JOB_CODE = JOB_CODE) AND SUBSTR(EMP_NO, 8, 1) IN (2, 4)
ORDER BY 1 ASC;



SET SERVEROUTPUT ON;
-- SQLDeveloper�� ���ٰ� ������
-- �����ߴµ� �ȳ����� ��(DBMS_OUTPUT.PUT_LINE�����µ�..)
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

-- PL/SQL
-- > Oracle's procedual Language extension to SQL�� ����
-- > ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���ν�
-- SQL�� ������ �����Ͽ� SQL ���峻���� ������ ����, ����ó��, �ݺ�ó�� ���� ������

-- ## PL/SQL�� ����(�͸���)
-- 1. �����(����)
-- DECLARE : ������ �Ǽ��� �����ϴ� �κ�
-- 2. �����(�ʼ�)
-- BEGIN : ���, �ݸ�, �Լ� ���� �� ���� ���
-- 3. ����ó����(����)
-- EXCEPTION : ����ó�� �߻��� �ذ��ϱ� ���� ���� ���
-- END; -- �������
-- /  -- PL/SQL ���� �� ����

DECLARE 
    vId NUMBER;
BEGIN
    SELECT EMP_ID
    INTO vId
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('ID='||vId);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data!!');
END;
/

-- ## ���� ����
-- ������ [CONSTRAINT] �ڷ���(����Ʈũ��) [NOT NULL] [:=�ʱⰪ];
-- ## ������ ����
-- �Ϲݺ���, ���, %TYPE, %ROWTYPE, ���ڵ�(RECORD)
-- ## ���
-- �Ϲݺ����� �����ϳ� CONSTRAINT��� Ű���尡 �ڷ��� �տ� �ٰ�
-- ����ÿ� ���� �Ҵ������ ��.
DECLARE
    EMPNO NUMBER := 507;
    ENAME VARCHAR2(20) := '�Ͽ���';
BEGIN
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
END;
/

DECLARE
    USER_NAME VARCHAR2(20) := '�Ͽ���';
    MNAME CONSTANT VARCHAR2(20) := '�����';
BEGIN
    USER_NAME := '�̿���';
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| USER_NAME);
--    MNAME := '�����';
--    expression 'MNAME' cannot be used as an assignment target
    DBMS_OUTPUT.PUT_LINE('��� : '|| MNAME);
END;
/

-- PL/SQL������ SELECT��
-- -> SQL���� ����ϴ� ��ɾ �״�� ����� �� ������ SELECT ���� ����� ���� ����
-- ������ �Ҵ��ϱ� ���� �����
--����1)
--PL/SQL�� SELECT������ EMPLOYEE ���̺��� �ֹι�ȣ�� �̸� ��ȸ�ϱ�
DECLARE
    VEMPNO EMPLOYEE.EMP_NO%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_NO "�ֹι�ȣ", EMP_NAME "�̸�"
    INTO VEMPNO, VENAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('�ֹε�Ϲ�ȣ : '||VEMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
END;
/

--���� 2)
--������ ����� ����� �����ȣ, �̸�, �޿�, �Ի����� ����Ͻÿ�
DECLARE
   VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
   VEMPID EMPLOYEE.EMP_ID%TYPE;
   VSALARY EMPLOYEE.SALARY%TYPE;
   VHIREDATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
    INTO VEMPID, VEMPNAME, VSALARY, VHIREDATE
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('�����ȣ : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VEMPNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : '||VHIREDATE);
END;
/

--���� 3)
-- �����ȣ�� �Է� �޾Ƽ� ����� �����ȣ, �̸�, �޿�, �Ի����� ����Ͻÿ�
DECLARE
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VHIREDATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY, HIRE_DATE
    INTO VENAME,VSALARY,VHIREDATE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : '||VHIREDATE);
END;
/


--## ���� �ǽ� 1 ##
-- �ش� ����� �����ȣ�� �Է½�
-- �̸�,�μ��ڵ�,�����ڵ尡 ��µǵ��� PL/SQL�� ����� ���ÿ�.
DECLARE
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPTCODE EMPLOYEE.DEPT_CODE%TYPE;
    VJOBCODE EMPLOYEE.JOB_CODE%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_CODE, JOB_CODE
    INTO VEMPNAME, VDEPTCODE, VJOBCODE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VEMPNAME);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : '||VDEPTCODE);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||VJOBCODE);
END;
/
--## ���� �ǽ� 2 ##
-- �ش� ����� �����ȣ�� �Է½�
-- �̸�,�μ���,���޸��� ��µǵ��� PL/SQL�� ����� ���ÿ�
DECLARE
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPTTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VJOBNAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO VEMPNAME, VDEPTTITLE, VJOBNAME
    FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
    JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VEMPNAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '||VDEPTTITLE);
    DBMS_OUTPUT.PUT_LINE('���޸� : '||VJOBNAME);
END;
/

-- ### PL/SQL�� ���ù�
-- ��� ������� ����� ������� ���������� �����
-- ������ ���������� �����Ϸ��� IF���� ����ϸ��
-- IF ~ THEN ~ END IF; ��

--����) �����ȣ�� ������ ����� ���,�̸�,�޿�,���ʽ����� ����ϰ�
-- ���ʽ����� ������ '���ʽ��� ���޹��� �ʴ� ����Դϴ�' �� ����Ͻÿ�
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VBONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO VEMPID, VEMPNAME, VSALARY, VBONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VEMPNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    IF(VBONUS <> 0) 
    THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� : '||VBONUS * 100||'%');
    ELSE DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
END;
/
--����2) ��� �ڵ带 �Է� �޾����� ���,�̸�,�����ڵ�,���޸�,�Ҽ� ���� ����Ͻÿ�
--�׶�, �ҼӰ��� J1,J2 �� �ӿ���, �׿ܿ��� �Ϲ��������� ��µǰ� �Ͻÿ�
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VJOBCODE EMPLOYEE.JOB_CODE%TYPE;
    VJOBNAME JOB.JOB_NAME%TYPE;
    VTEAM VARCHAR2(12);
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
    INTO VEMPID, VEMPNAME, VJOBCODE, VJOBNAME
    FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = '&EMPID';
    IF(VJOBCODE IN ('J1','J2'))
    THEN VTEAM := '�ӿ���';
    ELSE VTEAM := '�Ϲ�����';
    END IF;
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VEMPNAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||VJOBCODE);
    DBMS_OUTPUT.PUT_LINE('���޸� : '||VJOBNAME);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : '||VTEAM);

END;
/

--## ���� �ǽ� 1 ##
-- ��� ��ȣ�� ������ �ش� ����� ��ȸ
-- �̶� �����,�μ��� �� ����Ͽ���.
-- ���� �μ��� ���ٸ� �μ����� ������� �ʰ�,
-- '�μ��� ���� ��� �Դϴ�' �� ����ϰ�
-- �μ��� �ִٸ� �μ����� ����Ͽ���.
DECLARE
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPTTI DEPARTMENT.DEPT_TITLE%TYPE;
    VDEPTCODE EMPLOYEE.DEPT_CODE%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE
    INTO VEMPNAME, VDEPTTI, VDEPTCODE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('����� : '||VEMPNAME);
    IF(VDEPTCODE IS NULL)
    THEN DBMS_OUTPUT.PUT_LINE('�μ��� ���� ����Դϴ�.');
    ELSE DBMS_OUTPUT.PUT_LINE('�μ��� : '||VDEPTTI);
    END IF;
END;
/


--## ���� �ǽ�2 ##
--����� �Է� ���� �� �޿��� ���� ����� ������ ����ϵ��� �Ͻÿ� 
--�׶� ��� ���� ���,�̸�,�޿�,�޿������ ����Ͻÿ�

--0���� ~ 99���� : F
--100���� ~ 199���� : E
--200���� ~ 299���� : D
--300���� ~ 399���� : C
--400���� ~ 499���� : B
--500���� �̻�(�׿�) : A

--ex) 200
--��� : 200
--�̸� : ������
--�޿� : 8000000
--��� : A

DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE. SALARY%TYPE;
    GRADE VARCHAR(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, DECODE(FLOOR(SALARY/1000000),0,'F',1,'E',2,'D',3,'C',4,'B','A')
    INTO VEMPID, VEMPNAME, VSALARY, GRADE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VEMPNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('��� : '||GRADE);
    IF(VSALARY BETWEEN 0 AND 999999)
    THEN DBMS_OUTPUT.PUT_LINE('��� : F');
    ELSIF(VSALARY BETWEEN 1000000 AND 1999999)
    THEN DBMS_OUTPUT.PUT_LINE('��� : E');
    ELSIF(VSALARY BETWEEN 2000000 AND 2999999)
    THEN DBMS_OUTPUT.PUT_LINE('��� : D');
    ELSIF(VSALARY BETWEEN 3000000 AND 3999999)
    THEN DBMS_OUTPUT.PUT_LINE('��� : C');
    ELSIF(VSALARY BETWEEN 4000000 AND 4999999)
    THEN DBMS_OUTPUT.PUT_LINE('��� : B');
    ELSE DBMS_OUTPUT.PUT_LINE('��� : A');
    END IF;
END;
/

DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    SGRADE VARCHAR2(3);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMPID, VENAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&�˻��һ��';
    IF(VSALARY >= 0 AND VSALARY <= 99) THEN SGRADE := 'F';
    ELSIF(VSALARY >= 100 AND VSALARY <= 199) THEN SGRADE := 'E';
    ELSIF(VSALARY >= 200 AND VSALARY <= 299) THEN SGRADE := 'D';
    ELSIF(VSALARY >= 300 AND VSALARY <= 399) THEN SGRADE := 'C';
    ELSIF(VSALARY >= 400 AND VSALARY <= 499) THEN SGRADE := 'B';
    ELSE SGRADE := 'A';
    END IF;
    DBMS_OUTPUT.PUT_LINE('��� : '|| VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '|| VSALARY);
    DBMS_OUTPUT.PUT_LINE('��� : '|| SGRADE);
END;
/

-- CASE��
-- CASE ����
--      WHEN ��1 THEN ���๮1;
--      WHEN ��2 THEN ���๮2;
--      WHEN ��3 THEN ���๮3;
--      ELSE ���๮4

DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE. SALARY%TYPE;
    GRADE VARCHAR2(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMPID, VEMPNAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    CASE FLOOR(VSALARY / 1000000)
    WHEN(0)
    THEN GRADE := 'F';
    WHEN(1)
    THEN GRADE := 'E';
    WHEN(2)
    THEN GRADE := 'D';
    WHEN(3)
    THEN GRADE := 'C';
    WHEN(4)
    THEN GRADE := 'B';
    ELSE GRADE := 'A';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VEMPNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('��� : '||GRADE);
END;
/
