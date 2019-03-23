select * from dba_users;

DESC SCOTT.EMP;
-- ���̺� ����/������ Ÿ�� ����
-- NUMBER(4) ���ڸ�����
--VARCHAR2(10) ������ 10�ڸ����� ���� �� ����
--NUMBER(7,2) ������ 5�ڸ� �Ҽ��� 2�ڸ�

SELECT *
FROM EMP
WHERE EMPNO=1001
;

INSERT INTO EMP(EMPNO, ENAME, SAL)
VALUES (1001, 'ȫ�浿', 2000)
;

ROLLBACK;

-- ��ü �÷��� ������ �Է�

INSERT INTO EMP
VALUES (1001, 'ȫ�浿', 'CLERK', 7902, TO_DATE('20180101', 'YYMMDD'), 2000, '', NULL)
;
-- ''�̰͵� �� NULL �̰͵� ��

SELECT * FROM EMP1;

INSERT INTO EMP(EMPNO, ENAME, SAL)
SELECT EMPNO,ENAME,SAL FROM EMP1
;

INSERT INTO EMP
SELECT * FROM EMP1
;
-- �̰� ������ �����ϸ� ������ ���ԵǴµ�
-- �̷������� PK�� ��ĥ���� ���� ���� ���⼱ PK�� ���� ���ϱ� �ߴٸ�..
-- �׷��� ��ġ�� PK�� �ִٸ� "���Ἲ �������ǿ� ����ȴٴ� ORA-00001 ������ ��


SELECT *
FROM EMP
WHERE EMPNO =7369
;

UPDATE EMP 
SET ENAME ='���̹�',
    JOB = 'SALESMAN'
WHERE EMPNO = 7369
;

--�Ʒ� ��ȸ�� �� ���ڴ� �������� ���ڴ� ������ ����

DELETE FROM EMP
WHERE EMPNO = 7369
;

DELETE FROM EMP
WHERE EMPNO||'' = 7369
;
-- || ���ڿ� ��ġ�� ����, '' = ������ NULL 
-- �ᱹ EMPNO�� ���ڿ��� �ٲ�
-- ������ ��ü ���̺��� Ǯ ��ĵ�ϰ� �ȴ�
-- (OPTIONS = FULL)
-- �º��� �������� �� ��!


SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE EMPNO = 7369
;

INSERT INTO EMP 
SELECT 1001, 'ȫ�浿', 'CLERK', 7902, TO_DATE('20180101', 'YYMMDD'), 2000, '', NULL
FROM DUAL 
;

SELECT 1 AS A, 2 AS B, 3 C, AA.* -- AA���̺��� ��� ���� ����Ͷ�
--�÷��� ������, AS��������
-- �� ������ ORDER BY ���ĸ���Ʈ������ �� �� ����
FROM DUAL AA --�̷��� ������ �� ����
;
