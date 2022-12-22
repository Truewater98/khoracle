-- ## ��������(SubQuery)
-- -> �ϳ��� SQL�� �ȿ� ���ԵǾ� �ִ� �� �ٸ� SQL(SELECT)
-- -> �������� ���������� �����ϴ� �������� ����
-- ### Ư¡
-- >> ���������� �������� �����ʿ� ��ġ�ؾ� ��
-- >> ���������� �ݵ�� �Ұ�ȣ�� ����� ��( SELECT .....)

-- EX) ������ ������ ������ �̸��� ����Ͽ���!!!!
SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE;
-- STEP1. ������ ������ ������ ID�� �����ΰ�?
SELECT MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '������';
-- STEP2. ������ ID�� ������ �̸��� ���Ѵ�.
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = '214';
-- ���������� �ѹ濡!!
SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '������');
-- EX2) �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ ���, �̸�, �����ڵ�, �޿��� ��ȸ�Ͻÿ�
-- STEP1 �������� ��� �޿��� ���Ѵ�
SELECT AVG(SALARY)
FROM EMPLOYEE;
-- STEP2 ��� �޿����� ���� �޿��� �޴� ������ ��ȸ�Ѵ�.
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662;
-- �ѹ濡!!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- ## ��������(Sub Query)�� ����
-- 1. ������ ��������
-- 2. ������ ��������
-- 3. ���߿� ��������
-- 4. ������ ���߿� ��������
-- 5. ��(ȣ��)�� ��������
-- 6. ��Į�� ��������
-- ### 1. ������ ��������
-- ���������� ��ȸ �����(��,����,���ڵ�)�� ������ 1�� �϶�
-- ### 2. ������ ��������
-- ���������� ��ȸ �����(��,����,���ڵ�)�� ������ �� ��
-- ������ �������� �տ��� �Ϲ� �񱳿����� ���Ұ� (IN/NOT IN, ANY, ALL, EXIST)
-- 2,1.IN
-- ������ �� ������ ��� �߿��� �ϳ��� ��ġ�ϴ� ��, OR
-- EX) �����⳪ �ڳ��� ���� �μ��� ���� ����� ���� ���
-- STEP1. ������ �μ��ڵ� ���ϰ� �ڳ��� �μ��ڵ� ���ؾ���
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('������', '�ڳ���');
-- STEP2. ���� �μ��ڵ�� ���� ���
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D9', 'D5');
-- �ѹ濡
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('������', '�ڳ���'));

--@�ǽ�����
--1. ���¿�, ������ ����� �޿����(emplyee���̺��� sal_level�÷�)�� ���� ����� ���޸�, ������� ���.
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SAL_LEVEL IN (SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN ('���¿�', '������'));

--2. Asia1������ �ٹ��ϴ� ��� �������, �μ��ڵ�, �����
SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE LOCATION_ID = (SELECT LOCAL_CODE FROM LOCATION WHERE LOCAL_NAME = 'ASIA1');

SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCAL_CODE = LOCATION_ID
WHERE LOCAL_NAME = 'ASIA1';

--2, 2 NOT IN
-- ������ �������� ��� �߿��� �ϳ��� ��ġ���� �ʴ� ��
-- #�ǽ�����
-- ������ ��ǥ, �λ����� �ƴ� ��� ����� �μ����� ���
-- STEP1 ��ǥ, �λ���, JOB_CODE ���ϱ�
SELECT JOB_CODE
FROM JOB
WHERE JOB_NAME IN ('��ǥ', '�λ���');
-- STEP2 ���� JOB_CODE �������� �ֱ�
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE NOT IN ('J1', 'J2')
ORDER BY DEPT_CODE ASC;
-- �ѹ濡
SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE
WHERE JOB_CODE NOT IN(SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN('��ǥ','�λ���'))
ORDER BY DEPT_CODE ASC;
-- ## 3. ���߿� ��������
-- ## 4. ������ ���߿� ��������
-- ## 5. ��(ȣ��)�� ��������
-- >> ���������� ���� ���������� �ְ� ���������� ������ ���� �� �����
-- �ٽ� ���������� ��ȯ�ؼ� �����ϴ� ����
-- > ���������� WHERE�� ������ ���ؼ��� ���������� ���� ����Ǵ� ����
-- > ���� ���� ���̺��� ���ڵ�(��)�� ���� ���������� ��� ���� �ٲ�
-- �����ϱ�1 : ���������� �ִ� ���� ���������� ������ ���� ��� ��������
-- �׷��� �ʰ� ���������� �ܵ����� ���Ǹ� �Ϲ� ��������
SELECT EMP_NAME, SALARY
FROM EMPLOYEE WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '��ǥ');

SELECT EMP_NAME, EMP_ID, MANAGER_ID, SALARY
FROM EMPLOYEE E WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);
-- DEPT_CODE�� ���� ����� ����Ͻÿ�.
SELECT EMP_NAME
FROM EMPLOYEE E
WHERE NOT EXISTS(SELECT 1 FROM DEPARTMENT WHERE DEPT_ID = E.DEPT_CODE);  
-- ���� ���� �޿��� �޴� ����� exists ��� ���������� �̿��ؼ� ���϶�
SELECT EMP_NAME
FROM EMPLOYEE E
WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE SALARY > E.SALARY);
SELECT EMP_NAME FROM EMPLOYEE WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);
-- ���� ���� �޿��� �޴� ����� exists ��� ���������� �̿��ؼ� ���϶�
SELECT EMP_NAME
FROM EMPLOYEE E
WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE SALARY < E.SALARY);
SELECT EMP_NAME FROM EMPLOYEE WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);
-- ������ J1, J2, J3�� �ƴ� ����߿��� �ڽ��� �μ��� ��ձ޿����� ���� �޿��� �޴� ������.
-- �μ��ڵ�, �����, �޿�, �μ��� �޿����
SELECT DEPT_CODE ,ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, EMP_NAME, SALARY, (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE D WHERE D.DEPT_CODE = E.DEPT_CODE)
FROM EMPLOYEE E
WHERE EXISTS(SELECT 1 FROM JOB WHERE JOB_CODE = JOB_CODE)
--## 6. ��Į�� ��������
-- ������� 1���� �����������, SELECT������ �����
--### 6,1 ��Į�� �������� - SELECT��
-- EX) ��� ����� ���, �̸�, �����ڻ��, �����ڸ��� ��ȸ�ϼ���
SELECT EMP_ID, EMP_NAME, MANAGER_ID, (SELECT EMP_NAME FROM EMPLOYEE M WHERE E.MANAGER_ID = M.EMP_ID)
FROM EMPLOYEE E;
--@�ǽ�����
--1. �����, �μ���, �μ��� ����ӱ��� ��Į�󼭺������� �̿��ؼ� ����ϼ���.
SELECT EMP_NAME,DEPT_TITLE, (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE A WHERE A.DEPT_CODE = D.DEPT_ID) "�μ��� ����ӱ�"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID;
--### 6,2 ��Į�� �������� - WHERE��
-- EX) �ڽ��� ���� ������ ��� �޿����� ���� �޴� ������ �̸�, ����, �޿��� ��ȸ�ϼ���

--### 6,3 ��Į�� �������� - ORDER BY
-- EX) ��� ������ ���, �̸�, �ҼӺμ��� ��ȸ�� �μ����� ������������ �����ϼ���

-- ## 7.�ζ��� ��(FROM�������� ��������)
-- FROM���� ���������� ����� ���� �ζ��κ�(INLINE VIEW)��� ��.
SELECT DEPT_ID, DEPT_TITLE
FROM (SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT);
SELECT EMP_ID, SALARY
FROM(SELECT EMP_NAME, EMP_ID, SALARY, EMP_NO FROM EMPLOYEE);

-- ** VIEW��??
-- �������̺� �ٰ��� ������ ������ ���̺�(����ڿ��� �ϳ��� ���̺�ó�� ��밡���ϰ� ��)
-- *** VIEW�� ����
-- 1. Stored View : ���������� ��밡�� -> ����Ŭ ��ü
-- 2. Inline View : FROM���� ����ϴ� ��������, 1ȸ��
SELECT * FROM EMPLOYEE;

--@�ǽ�����
--1. employee���̺��� 2010�⵵�� �Ի��� ����� ���, �����, �Ի�⵵�� �ζ��κ並 ����ؼ� ���.
SELECT *
FROM(SELECT EMP_ID, EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵" FROM EMPLOYEE)
WHERE �Ի�⵵ BETWEEN '2010' AND '2019';
--2. employee���̺��� ����� 30��, 40���� ���ڻ���� ���, �μ���, ����, ���̸� �ζ��κ並 ����ؼ� ����϶�.
-- JOIN ���
SELECT *
FROM (SELECT EMP_ID "���", DEPT_TITLE "�μ���", DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') "����",
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) "����"
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID)
WHERE ���� BETWEEN 30 AND 49 AND ���� = '��';
-- ��Į�� �������� ���
SELECT *
FROM
(SELECT EMP_ID AS ���
, (SELECT DEPT_TITLE FROM DEPARTMENT WHERE DEPT_ID = E.DEPT_CODE) AS �μ���
, DECODE(SUBSTR(EMP_NO,8,1), '1','��', '3','��','��') ����
-- 2022 - 1963 = 59
, EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS ����
FROM EMPLOYEE E)
--JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID)
WHERE ���� = '��' AND FLOOR(����/10) IN (3, 4);

-- ## �������
-- ### 1. TOP-N�м�
-- ### 2. WITH
-- ### 3. ������ ����(Hierarchical Query)
-- ### 4. ������ �Լ�
-- #### 4,1 ��ȯ �Լ�

-- ## JOIN�� ����3
-- 1. ��ȣ����(CROSS JOIN)
-- 2. ��������(SELF JOIN)

-- # ��������
-- ## 1. CHECK
-- ## 2. DEFAULT