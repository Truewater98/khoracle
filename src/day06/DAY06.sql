--5. �μ��� �޿� ����� 3,000,000��(��������) �̻���  �μ��鿡 ���ؼ� �μ���, �޿������ ����ϼ���.
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000;

-- # HAVING��
-- �׷��Լ��� ���� ���ؿ� �׷쿡 ���� ������ ������ ����
-- HAVING���� ����� !! WHERE���� ���Ұ�!!!!!!!!!!

--@�ǽ�����
--1. �μ��� �ο��� 5���� ���� �μ��� �ο����� ����ϼ���.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;

--2. �μ����� ���޺� �ο����� 3���̻��� ������ �μ��ڵ�, �����ڵ�, �ο����� ����ϼ���.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(JOB_CODE) >= 3
ORDER BY 1 ASC;
--3. �Ŵ����� �����ϴ� ����� 2���̻��� �Ŵ������̵�� �����ϴ� ������� ����ϼ���.
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(MANAGER_ID) >= 2
ORDER BY 1 ASC;


--# ROLLUP�� CUBE
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1 ASC;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1 ASC;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1 ASC;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1 ASC;

-- ���տ�����
-- ������ --> INTERSECT
-- ������ --> UNION, UNION ALL
-- ������ --> MINUS
-- ������ ����
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;
-- �����տ���( ������ �ߺ�)
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;
-- �����տ���
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;
-- �����տ���
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

-- ** UNION�� ����!!
-- 1. SELECT���� �÷� ������ �ݵ�� ���ƾ� �� ORA-01789: query block has incorrect number of result columns
-- 2. �÷��� ������ Ÿ���� �޵�� ���ų� ��ȯ�����ؾ��� (EX CHAR - VARCHAR2) ORA-01790: expression must have same datatype as corresponding expression
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;
-- # ���ι�(JOIN)
-- -> ���� ���̺��� ���ڵ带 �����Ͽ� �ϳ��� ���� ǥ���� ��
-- -> ���ο� ������ ���̺��� �̿��Ͽ� �����
-- ���� �ٸ� ���̺��� ������ ���밪�� �̿������μ� �ʵ带 ������.
-- �ٽø���, ���� �ٸ� ���̺��� ������ ���밪�� �̿������μ� �ʵ带 ������.

--11. ������, �μ����� ����ϼ���. *
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
SELECT EMP_NAME, DECODE(DEPT_CODE, 'D5', '�ѹ���', 'D6', '��ȹ��', 'D9', '������')
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE;
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
-- # ���ι�
-- SELECT �÷��� FROM ���̺� JOIN ���̺� ON �÷���1 = �÷���2
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- ANSI ǥ�ر���
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;
-- ����Ŭ ���� ����

-- JOIN�� ����
-- 1. EQUI-JOIN : �Ϲ������� ���, =�� ���� ����
-- 2. NON-EQUI JOIN : ���������� �ƴ� BETWEEN AND, IS NULL, IS NOT NULL, IN , NOT IN ������ ���

-- @�ǽ�����
--1. �μ���� �������� ����ϼ���. DEPARTMENT, LOCATION ���̺� �̿�
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--2. ������ ���޸��� ����ϼ���. EMPLOYEE, JOB ���̺� �̿�
-- ��ȣ�� �ذ��� 1 : �÷��տ� ���̺�.
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- ��ȣ�� �ذ��� 2 : ���̺� ��Ī
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE E JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;
-- ��ȣ�� �ذ��� 3 : ON ��� USING ���
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE E JOIN JOB J USING (JOB_CODE);

-- 3. ������� �������� ����ϼ���. LOCATION, NATION ���̺� �̿�
SELECT LOCAL_NAME, NATIONAL_NAME
FROM LOCATION JOIN NATIONAL USING(NATIONAL_CODE);

-- ## INNER JOIN
-- ### INNER EQUI JOIN

-- ## JOIN�� ���� 2
-- INNER JOIN(��������) : �Ϲ������� ����ϴ� ����(������)
-- OUTER JOIN(�ܺ�����) : ������ (������)
-- -> 1. LEFT (OUTER) JOIN 
-- -> 2. RIGHT (OUTER) JOIN
-- -> 3. FULL (OUTER) JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--ORACLE ���� LEFT OUTER JOIN ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--ORACLE ���� RIGHT OUTER JOIN ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;


-- EX) OUTER JOIN(�ܺ�����)�� ���캸��
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, DEPT_TITLE
FROM DEPARTMENT RIGHT JOIN EMPLOYEE ON DEPT_ID = DEPT_CODE;


-- ## JOIN�� ����3
-- 1. ��ȣ����(CROSS JOIN)
-- 2. ��������(SELF JOIN)
-- 3. ��������
-- -> ���� ���� ���ι��� �ѹ��� ����� �� ����
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;
-- -> ������ �߿��ϴ�!!

--@�ǽ�����
-- 1. ������ �븮�̸鼭, ASIA ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸� ,���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
SELECT EMP_ID "���", EMP_NAME "�̸�", JOB_NAME "���޸�", DEPT_TITLE "�μ���",LOCAL_NAME "�ٹ�������", SALARY "�޿�"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE JOB_NAME = '�븮' AND LOCAL_NAME LIKE 'ASIA%';

-- �������� �ɷ��ִ� �θ����̺� ���ڵ� ��������!
DELETE FROM USER_GRADE
WHERE GRADE_CODE = 10;
--ORA-02292: integrity constraint (KH.GRADE_CODE_PK) violated - child record found
--�������. �׷��� ����� ���, �� �����ɼ��� 2�� �ִ�.
-- 1. ON DELETE SET NULL; -> �ڽ� ���̺� �����͸� NULL�� �ٲ���
-- 2. ON DELETE CASCADE; -> �ڽ����̺� �����͵� ������
ALTER TABLE USER_FOREIGNKEY
DROP CONSTRAINT GRADE_CODE_FK;
COMMIT;
--Ŀ�� �Ϸ�.
ROLLBACK;
--�ѹ� �Ϸ�.
ALTER TABLE USER_FOREIGNKEY
ADD CONSTRAINT GRADE_CODE_FK FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
ON DELETE SET NULL;

ALTER TABLE USER_FOREIGNKEY
ADD CONSTRAINT GRADE_CODE_FK FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
ON DELETE CASCADE;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='USER_FOREIGNKEY';
-- ���� ���
-- 1. �ܷ�Ű(�ڽ����̺�)�� �����ϴ� �θ����̺� �÷� �����ʹ� �⺻������ �������� �ʴ´�.
-- 2. ON DELETE SET NULL �ɼ��� �θ����̺� �����͸� �����ְ� �ڽ����̺� �����ʹ� NULL�� ���ش�
-- 3. ON DELETE CASCADE �ɼ��� �θ����̺� �����͸� �����ְ� �ڽ����̺� �����͵� �����ش�
SELECT * FROM USER_FOREIGNKEY;

--@���νǽ�����_kh
--1. 2022�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('2022/12/25'), 'DAY') FROM DUAL; 
--2. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME "�����", EMP_NO "�ֹι�ȣ", DEPT_TITLE "�μ���", JOB_NAME "���޸�"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN JOB USING (JOB_CODE)
WHERE SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 79 AND SUBSTR(EMP_NO,8,1) IN ('2','4') AND EMP_NAME LIKE '��%';
--3. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%��%';
--4. �ؿܿ����ο� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME "�����", JOB_NAME "���޸�", DEPT_CODE "�μ��ڵ�", DEPT_TITLE "�μ���"
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE LIKE '�ؿܿ���_��%';
--5. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME "�����", NVL(BONUS, 0) "���ʽ�����Ʈ", DEPT_TITLE "�μ���", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;
--6. �μ��ڵ尡 D2�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME "�����", JOB_NAME "���޸�", DEPT_TITLE "�μ���", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
WHERE DEPT_CODE = 'D2';
--7. �޿�������̺��� �ִ�޿�(MAX_SAL)���� ���� �޴� �������� �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- (������̺�� �޿�������̺��� SAL_LEVEL�÷��������� ������ ��)
SELECT EMP_NAME "�����", JOB_NAME "���޸�", SALARY "�޿�", SALARY * 12 "����"
FROM EMPLOYEE
JOIN SAL_GRADE USING(SAL_LEVEL)
JOIN JOB USING (JOB_CODE)
WHERE MAX_SAL < SALARY;
--8. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME "�����", DEPT_TITLE "�μ���", LOCAL_NAME "������", NATIONAL_NAME "������"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('�ѱ�','�Ϻ�');
--9. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� ����� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�. ��, join�� IN ����� ��
SELECT EMP_NAME "�����", JOB_NAME "���޸�", SALARY "�޿�"
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE BONUS IS NULL AND JOB_NAME IN ('����', '���');
--10. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(ENT_YN,'Y','����', 'N' , '����') "�ټӿ���" ,COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(ENT_YN,'Y','����', 'N' , '����');

CREATE TABLE TBL_SALES
(SALE_DATE   DATE  DEFAULT  SYSDATE --!����Ʈ���� ������ �ټ� �ֳ�����.
,P_NAME    VARCHAR2(20)
,P_COUNT     NUMBER
);
DROP TABLE TBL_SALES;

INSERT INTO TBL_SALES VALUES( ADD_MONTHS(SYSDATE, -2), '�����', 10);
INSERT INTO TBL_SALES VALUES( ADD_MONTHS(SYSDATE, -2)+1, '�����', 15);
INSERT INTO TBL_SALES VALUES( ADD_MONTHS(SYSDATE, -2)+2, '���ڱ�', 20);
INSERT INTO TBL_SALES VALUES( ADD_MONTHS(SYSDATE, -2)+3, '�����', 10);

INSERT INTO TBL_SALES VALUES( ADD_MONTHS(SYSDATE, -1), '������', 10);
INSERT INTO TBL_SALES VALUES( ADD_MONTHS(SYSDATE, -1)+1, '�����', 15);
INSERT INTO TBL_SALES VALUES( ADD_MONTHS(SYSDATE, -1)+2, '���ڱ�', 20);
INSERT INTO TBL_SALES VALUES( ADD_MONTHS(SYSDATE, -1)+3, '���ڱ�', 10);

INSERT INTO TBL_SALES VALUES( SYSDATE - 4, '��Ϲ���Ĩ', 30);
INSERT INTO TBL_SALES VALUES( SYSDATE - 3, '������', 15);
INSERT INTO TBL_SALES VALUES( SYSDATE - 2, '������', 10);
INSERT INTO TBL_SALES VALUES( SYSDATE - 1, '��Ϲ���Ĩ', 20);
INSERT INTO TBL_SALES VALUES( SYSDATE, '�����', 5);
INSERT INTO TBL_SALES VALUES( SYSDATE, '���ڱ�', 7);

INSERT INTO TBL_SALES VALUES( SYSDATE, '�����', 5);
INSERT INTO TBL_SALES VALUES( SYSDATE, '�����', 15);
INSERT INTO TBL_SALES VALUES( SYSDATE, '������', 10);

INSERT INTO TBL_SALES VALUES( SYSDATE, '������', 20);
INSERT INTO TBL_SALES VALUES( SYSDATE, '��Ϲ���Ĩ', 15);
INSERT INTO TBL_SALES VALUES( SYSDATE, '��Ϲ���Ĩ', 10);
INSERT INTO TBL_SALES VALUES( SYSDATE, '������', 5);

INSERT INTO TBL_SALES VALUES( SYSDATE, '�����', 10);

--2������ ���� �Ǹ� ��������
--������ �Ǹų�������
--�̹��� �Ǹų�������

--## ���̺� �ɰ���
--���̺��� �ɰ��� ����ϴ� ��찡 ����. ���� �ʿ��� ���� ����� ��찡 ����, 
--���� ������ �ð��� ������ ���� ���� �������� �ʴ´�.
--�⺻ ���̺��� ��� �����͸� �����ϰ�, 
--�������� ���� ���̺�� �����ؼ� �����ϴ� �ʿ�ÿ� ���ļ� ����. 

--1. TBL_SALES_1801 ���̺� ���� �� ����
CREATE TABLE TBL_SALES_1801
AS
SELECT *
FROM TBL_SALES
WHERE TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'yyyy-mm') = TO_CHAR(SALE_DATE,'yyyy-mm');

SELECT * FROM TBL_SALES_1801;

--2. TBL_SALES_1801 �ش����� ���� 
DELETE FROM TBL_SALES
WHERE TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYY-MM') = TO_CHAR(SALE_DATE,'YYYY-MM');

COMMIT;

--1. TBL_SALES_1712 ���̺� ���� �� ����
CREATE TABLE TBL_SALES_1712
AS
SELECT *
FROM TBL_SALES
WHERE TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'yyyy-mm') = TO_CHAR(SALE_DATE,'yyyy-mm');

SELECT * FROM TBL_SALES_1712;

--2. TBL_SALES_1712 �ش����� ���� 
DELETE FROM TBL_SALES
WHERE TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'yyyy-mm') = TO_CHAR(SALE_DATE,'yyyy-mm');

COMMIT;

-- ���� 3������ �Ǹų����� ����ϼ���.
-- ������ ��ǰ�� �� �Ǹŷ��� ����ϼ���.