-- ����Ŭ �Լ�
-- 1. ���� ó�� �Լ�
-- LENGTH, LENGTHB(���̱���), SUBSTR(���� �ڸ�), INSTR(���� ����)
-- LPAD, RPAD(ä��� ��)


--@�ǽ����� 
-- �������ڿ����� �յ� ��� ���ڸ� �����ϼ���.
-- '982341678934509hello89798739273402'
SELECT LTRIM(RTRIM('982341678934509hello89798739273402', '1234567890'), '1234567890')
FROM DUAL;

--@�ǽ�����
---- ������� ���� �ߺ����� ���������� ����ϼ���.
SELECT SUBSTR(EMP_NAME,1,1) "��"
FROM EMPLOYEE
ORDER BY 1 ASC;
-- �ߺ����� ���
SELECT DISTINCT SUBSTR(EMP_NAME,1,1) "��"
FROM EMPLOYEE
ORDER BY 1 ASC;

-- @�ǽ�����
-- employee ���̺��� ���ڸ� �����ȣ, �����, �ֹι�ȣ, ������ ��Ÿ������.
-- �ֹι�ȣ�� ��6�ڸ��� *ó���ϼ���.
SELECT EMP_ID "�����ȣ", EMP_NAME "�̸�", RPAD(SUBSTR(EMP_NO,1,8), 14, '*') "�ֹι�ȣ", SALARY*12 "����"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1,3);
--                                         SUBSTR(EMP_NO, 1, 8) || '******' CONCAT�� ����
SELECT EMP_ID "�����ȣ", EMP_NAME "�̸�", CONCAT(SUBSTR(EMP_NO,1,8),('******')) "�ֹι�ȣ", SALARY*12 "����",'��'
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1,3);
--WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3'

-- 2. ���� ó�� �Լ�
-- MOD(NUMBER, DIVISION) ����������  ROUND(�ݿø�) TRUNC(����) �� �Ҽ��� �����ؼ� ��
--@�ǽ�����
--EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ� 
--(SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT EMP_NAME, SYSDATE - HIRE_DATE "�ٹ��ϼ�", FLOOR(SYSDATE - HIRE_DATE) "����", ROUND(SYSDATE - HIRE_DATE) "�ݿø�", CEIL(SYSDATE - HIRE_DATE) "�ø�"
FROM EMPLOYEE;
-- 3. ��¥ ó�� �Լ�

-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի� �� 3������ �� ��¥�� ��ȸ�Ͻÿ�
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3)
FROM EMPLOYEE;
--@�ǽ�����
--EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� �������� ��ȸ�Ͻÿ�
SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "PERIOD"
FROM EMPLOYEE;
--@�ǽ�����
--ex) EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի���� ���������� ��ȸ�ϼ���
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;
--@�ǽ�����
--ex) EMPLOYEE ���̺��� ��� �̸�, �Ի� �⵵, �Ի� ��, �Ի� ���� ��ȸ�Ͻÿ�
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||'��' "��", EXTRACT(MONTH FROM HIRE_DATE)||'��' "��", EXTRACT(DAY FROM HIRE_DATE)||'��' "��"
FROM EMPLOYEE;

--@�ǽ�����
/*
     ���úη� �Ͽ��ھ��� ���뿡 �������ϴ�.
     ������ �Ⱓ�� 1�� 6������ �Ѵٶ�� �����ϸ�
     ù��°,�������ڸ� ���Ͻð�,
     �ι�°,�������ڱ��� �Ծ���� «���� �׷���� ���մϴ�.
     (��, 1�� 3���� �Դ´ٰ� �Ѵ�.)
*/
SELECT ADD_MONTHS(SYSDATE,18) "��������", (ADD_MONTHS(SYSDATE,18) - SYSDATE) * 3 || '�׸�' "«�� ��"
FROM DUAL;
-- 4. ����ȯ �Լ�


-- @�Լ� �����ǽ�����
--1. ������� �̸��� , �̸��� ���̸� ����Ͻÿ�
--		  �̸�	    �̸���		�̸��ϱ���
--	ex)  ȫ�浿 , hong@kh.or.kr   	  13
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- �̸����� ���̰� 13���� ���� �����͸� �˻��غ��ÿ�
SELECT * FROM EMPLOYEE
WHERE LENGTH(EMAIL) < 15;
--2. ������ �̸��� �̸��� �ּ��� ���̵� �κи� ����Ͻÿ�
--	ex) ���ö	no_hc
--	ex) ������	jung_jh
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1 , 6), SUBSTR(EMAIL, 1, INSTR(EMAIL, '@', 1, 1)-1)
FROM EMPLOYEE;
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;
--3. 60��뿡 �¾ ������� ���, ���ʽ� ���� ����Ͻÿ�. �׶� ���ʽ� ���� null�� ��쿡�� 0 �̶�� ��� �ǰ� ����ÿ� 
--	    ������    ���      ���ʽ�
--	ex) ������	    1962	    0.3
--	ex) ������	    1963  	    0
SELECT EMP_NAME "������", '19'||SUBSTR(EMP_NO,1,2) "���" , NVL(BONUS,'0') "���ʽ�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,1) = '6';
--4. '010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ���� ����Ͻÿ� (�ڿ� ������ ���� ���̽ÿ�) *
--	   �ο�
--	ex) 3��
SELECT PHONE
FROM EMPLOYEE
WHERE SUBSTR(PHONE,1,3) NOT IN ('010');
--5. ������� �Ի����� ����Ͻÿ� 
--	��, �Ʒ��� ���� ��µǵ��� ����� ���ÿ�
--	    ������		�Ի���
--	ex) ������		2012�� 12��
--	ex) ������		1997�� 3��
SELECT EMP_NAME "������" , EXTRACT(YEAR FROM HIRE_DATE)||'�� ' || EXTRACT(MONTH FROM HIRE_DATE)||'��' "�Ի���"
FROM EMPLOYEE;
--6. ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
--	��, �ֹι�ȣ 9��° �ڸ����� �������� '*' ���ڷ� ä������� �Ͻÿ�
--	ex) ȫ�浿 771120-1******
SELECT EMP_NAME, SUBSTR(EMP_NO,1,8) || '******'
FROM EMPLOYEE;
--7. ������, �����ڵ�, ����(��) ��ȸ 
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT EMP_NAME, JOB_CODE, '��'||12*(SALARY+ SALARY*NVL(BONUS, 0))
FROM EMPLOYEE;
--8. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� �����߿� ��ȸ��.
--   ��� ����� �μ��ڵ� �Ի���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D9') AND EXTRACT(YEAR FROM HIRE_DATE) = '2004';
--9. ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ 
--	* �ָ��� ���� , �Ҽ��� �Ʒ��� ����
SELECT EMP_NAME, HIRE_DATE, ROUND(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;
--10. ������, �μ��ڵ�, �������, ����(��) ��ȸ *
--   ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--   ���������� ������ �����Ϸ� ��µǰ� ��.
--   ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
--	* �ֹι�ȣ�� �̻��� ������� ���ܽ�Ű�� ���� �ϵ���(200,201,214 �� ����)
--	* HINT : NOT IN ���
SELECT EMP_NAME, DEPT_CODE, '19'||SUBSTR(EMP_NO,1,2)||'��' || SUBSTR(EMP_NO,3,2)||'��'||SUBSTR(EMP_NO,5,2)||'��' "�������",ROUND((SYSDATE - TO_DATE('19'||SUBSTR(EMP_NO,1,2)|| SUBSTR(EMP_NO,3,2)||SUBSTR(EMP_NO,5,2)))/ 365) "����(��)"
FROM EMPLOYEE
WHERE EMP_ID NOT IN ('200','201','214');
--11. ������, �μ����� ����ϼ���. *
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.


-- ���� �ǽ� ����
-- ����1. 
-- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���
SELECT EMP_NAME, EMP_NO, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE ((SYSDATE - HIRE_DATE) / 365) > 5 AND ((SYSDATE - HIRE_DATE) / 365) < 10;
-- ����2.
-- �������� �ƴ� ������ �̸�,�μ��ڵ�, �����, �ٹ��Ⱓ, �������� �˻��Ͽ��� 
--(��� ���� : ENT_YN)
SELECT EMP_NAME, EMP_ID, HIRE_DATE, ENT_DATE - HIRE_DATE, ENT_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';
-- ����3.
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.
SELECT EMP_NAME, SALARY * 150,ROUND((SYSDATE - HIRE_DATE) / 365)
FROM EMPLOYEE
ORDER BY (SYSDATE - HIRE_DATE) / 365 ASC;
-- ����4.
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�
SELECT EMP_NAME, EMP_NO, EMAIL, PHONE, SALARY
FROM EMPLOYEE
WHERE HIRE_DATE >= '99/01/01' AND HIRE_DATE <= '10/01/01' AND SALARY <= 2000000; 
-- ����5.
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.
SELECT EMP_NAME, EMP_NO, SALARY, NVL(DEPT_CODE, '����')
FROM EMPLOYEE
WHERE SALARY >= 2000000 AND SALARY <= 3000000 AND SUBSTR(EMP_NO,3,2) = '04'
ORDER BY EMP_NO DESC;
-- ����6.
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.
SELECT EMP_NAME, SALARY + SALARY * 0.1 * ROUND((SYSDATE - HIRE_DATE) / 1000) "Ư�� ���ʽ�"
FROM EMPLOYEE
WHERE BONUS IS NULL
ORDER BY EMP_NAME ASC;
