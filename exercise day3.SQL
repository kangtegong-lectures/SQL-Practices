----------------------------------------------------------------------------------
 4����  ��������
----------------------------------------------------------------------------------
��) FROM DUAL�� �̿��Ͽ� SELECT �ϼ���

1. 2018�� 4�� 1���� ���������� SELECT �ϼ���;
SELECT TO_DATE('20180401','YYYYMMDD')
FROM DUAL
;

2. SYSDATE�� �̿��Ͽ� �̹��� 1���� SELECT �ϼ���;
SELECT SYSDATE, TRUNC(SYSDATE,'MM')
     , TO_DATE(TO_CHAR(SYSDATE,'YYYYMM')||'01','YYYYMMDD')
FROM DUAL
;

3. SYSDATE�� �̿��Ͽ� �̹��� ������ SELECT �ϼ���;
SELECT SYSDATE
     , LAST_DAY(SYSDATE)
     , TRUNC(ADD_MONTHS(SYSDATE,1),'MM')-1
FROM DUAL
;

4. ' aB �׽�Ʈ 12 ' ���ڸ� ��������
   ù��° �÷� ��ü ����
   �ι�° �÷� �����̽��� ������ ���̸� SELECT �ϼ���;
SELECT LENGTH(' aB �׽�Ʈ 12 '), LENGTH(REPLACE(' aB �׽�Ʈ 12 ',' ',NULL))
FROM DUAL
;

5. ���� 1234567890�� õ�������� ,�� �־ SELECT �ϼ���
  ���) 1,234,567,890;
SELECT 1234567890
    , TRIM(TO_CHAR(1234567890,'999,999,999,999,999,999'))
FROM DUAL
;

6. EMP ���̺��� �Ʒ��� ���ǿ� �°� ��ȸ �ϼ���.
   - Į�� : ��ü Į�� ��ȸ
   - ��ȸ���� : ��������(HIREDATE)�� 1981�⵵�� ����� ��ȸ �ϼ���.;
SELECT *
FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810101 000000','YYYYMMDD HH24MISS')
                   AND TO_DATE('19811231 235959','YYYYMMDD HH24MISS')
;

-- �ε��� ��� ����
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE,'YYYY') = '1981'
;

DESC EMP;

7. EMP ���̺��� �Ʒ��� ���ǿ� �°� ��ȸ �ϼ���.
   - Į�� : ��ü Į�� ��ȸ
   - ��ȸ���� : ��������(HIREDATE)�� 1981��2���̰ų�  1987�� 5���� ����� ��ȸ �ϼ���.;
SELECT *
FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810201 000000','YYYYMMDD HH24MISS')
                   AND ADD_MONTHS(TO_DATE('19810201 000000','YYYYMMDD HH24MISS'),1)-1/24/60/60
   OR HIREDATE BETWEEN TO_DATE('19870501 000000','YYYYMMDD HH24MISS')
                   AND TO_DATE('19870531 235959','YYYYMMDD HH24MISS')
;

8. EMP ���̺��� �Ʒ��� ���ǿ� �°� ��ȸ �ϼ���.
   - Į�� : ENAME, ����(JOB) ��ȸ
   - ��ȸ���� : ��ü ����� ����(JOB)�� ANALYST�� '�м���', CLERK�� '�繫��', MANAGER�� '������'
		PRESIDENT�� '�μ���', SALESMAN�� '����'�� ��ü�Ͽ� ��ȸ;
SELECT ENAME, JOB
     , CASE WHEN JOB='ANALYST' THEN '�м���'
            WHEN JOB='CLERK' THEN '�繫��'
            WHEN JOB='MANAGER' THEN '������'
            WHEN JOB='PRESIDENT' THEN '�μ���'
            WHEN JOB='SALESMAN' THEN '����'
       ELSE '��Ÿ'
       END AS JOB_NM
     , CASE JOB WHEN 'ANALYST' THEN '�м���'
            WHEN 'CLERK' THEN '�繫��'
            WHEN 'MANAGER' THEN '������'
            WHEN 'PRESIDENT' THEN '�μ���'
            WHEN 'SALESMAN' THEN '����'
       ELSE '��Ÿ'
       END AS JOB_NM2
    , DECODE(JOB,'ANALYST', '�м���', 'CLERK', '�繫��', 'MANAGER', '������',
		         'PRESIDENT', '�μ���', 'SALESMAN', '����','��Ÿ') JNM
FROM EMP
;

9. EMP ���̺��� �Ʒ��� ���ǿ� �°� ��ȸ �ϼ���.
   - Į�� : DEPTNO, JOB
   - ��ȸ���� : �μ���ȣ(DEPTNO)���� ����(JOB)�� � ���� �ִ��� �ϳ����� ��ȸ �ϸ鼭
			�μ���ȣ(DEPTNO), ����(JOB) �������� ���������� �μ��� ������ MANAGER�� ������
			�� �μ����� ���ʿ� ���� �ϼ���.(�Ʒ� ����� ���� ��ȸ �ϼ���);
SELECT DEPTNO, JOB
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB
;SELECT DEPTNO, JOB
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB
;


SELECT DEPTNO, JOB, CASE WHEN JOB = 'MANAGER' THEN '1'
                      WHEN JOB = 'PRESIDENT' THEN '2'
                      ELSE JOB
                      END
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, CASE WHEN JOB = 'MANAGER' THEN '1'
                      WHEN JOB = 'PRESIDENT' THEN '2'
                      ELSE JOB
                      END
;



;
���)
DEPTNO	JOB  
	10		MANAGER
	10		CLERK
	10		PRESIDENT
	20		MANAGER
	20		ANALYST
	20		CLERK
	30		MANAGER
	30		CLERK
	30		SALESMAN
;

