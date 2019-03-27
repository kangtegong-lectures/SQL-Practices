
----------------------------------------------------------------------------------------------------------------------------------------------------------------
4���� : 2�� 1��~2��;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P71

-- 4
SELECT TEAM_ID ���ڵ�, PLAYER_NAME ������, POSITION ������,
		BACK_NO ��ѹ�, HEIGHT Ű
FROM PLAYER
WHERE TEAM_ID = 'K02'
UNION all
-- 6
SELECT TEAM_ID ���ڵ�, PLAYER_NAME ������, POSITION ������,
		BACK_NO ��ѹ�, HEIGHT Ű
FROM PLAYER
WHERE POSITION = 'MF'
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P72

-- 4
SELECT TEAM_ID ���ڵ�, PLAYER_NAME ������, POSITION ������,
		BACK_NO ��ѹ�, HEIGHT Ű
FROM PLAYER
WHERE TEAM_ID = 'K02'
--MINUS --������
INTERSECT  --������
-- 6
SELECT TEAM_ID ���ڵ�, PLAYER_NAME ������, POSITION ������,
		BACK_NO ��ѹ�, HEIGHT Ű
FROM PLAYER
WHERE POSITION = 'MF'
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 75
SELECT PLAYER.PLAYER_NAME, PLAYER.BACK_NO, PLAYER.TEAM_ID, 
       TEAM.TEAM_ID, TEAM.TEAM_NAME,  TEAM.REGION_NAME
FROM   PLAYER,TEAM
WHERE PLAYER.TEAM_ID = TEAM.TEAM_ID
;

SELECT *
FROM PLAYER
;


SELECT *
FROM TEAM
;

-- Alias ����
SELECT P.PLAYER_NAME ������, P.BACK_NO ��ѹ�, P.TEAM_ID ���ڵ�, 
       T.TEAM_NAME ����,     T.REGION_NAME ������
FROM   PLAYER P,   TEAM T
WHERE  P.TEAM_ID = T.TEAM_ID;

-- �߰� ���� Ȱ�� ����
SELECT P.PLAYER_NAME ������, P.BACK_NO ��ѹ�, 
       T.REGION_NAME ������, T.TEAM_NAME ����
FROM   PLAYER P,    TEAM T
WHERE  P.TEAM_ID  = T.TEAM_ID
AND    P.POSITION = 'GK'
ORDER  BY P.BACK_NO;


SELECT DEPTNO, DNAME, LOC
FROM DEPT
;

SELECT EMPNO, ENAME, JOB, MGR,
		HIREDATE, SAL, COMM, DEPTNO
FROM EMP
;

-- EQUI  JOIN
SELECT EMP.EMPNO, EMP.ENAME, EMP.JOB, EMP.MGR,
		EMP.HIREDATE, EMP.SAL, EMP.COMM, EMP.DEPTNO,
		DEPT.DEPTNO, DEPT.DNAME, DEPT.LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMP.EMPNO, DEPT.DEPTNO
;

-- Alias ����
SELECT P.EMPNO, P.ENAME, P.JOB, P.MGR,
		P.HIREDATE, P.SAL, P.COMM, P.DEPTNO,
		T.DEPTNO, T.DNAME, T.LOC
FROM EMP P, DEPT T
WHERE P.DEPTNO = T.DEPTNO
;

-- �߰� ���� Ȱ�� ����
SELECT P.EMPNO, P.ENAME, P.JOB, P.MGR,
		P.HIREDATE, P.SAL, P.COMM, P.DEPTNO,
		T.DEPTNO, T.DNAME, T.LOC
FROM EMP P, DEPT T
WHERE P.DEPTNO = T.DEPTNO
	AND P.JOB = 'CLERK'
ORDER BY P.EMPNO
;

SELECT T.*, P.EMPNO, P.ENAME, P.JOB, P.MGR
FROM EMP P, DEPT T
WHERE P.DEPTNO = T.DEPTNO
  AND P.JOB = 'CLERK'
ORDER BY P.EMPNO
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 76


SELECT *
FROM JOB_NM
;

SELECT P.EMPNO ���, P.ENAME �̸�, 
		J.JOB_NAME ������,
		T.DNAME �μ���
FROM EMP P, DEPT T, JOB_NM J
WHERE P.DEPTNO = T.DEPTNO
	AND P.JOB = J.JOB
ORDER BY �̸�
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 77

WITH SALGRADE (GRADE, LOSAL, HISAL) AS (
		SELECT 1,	700,		1200 FROM DUAL UNION ALL
		SELECT 2,	1201,	1400 FROM DUAL UNION ALL
		SELECT 3,	1401,	2000 FROM DUAL UNION ALL
		SELECT 4,	2001,	3000 FROM DUAL UNION ALL
		SELECT 5,	3001,	9999 FROM DUAL
);


SELECT E.ENAME �����, E.SAL �޿�, S.GRADE �޿����
    , S.LOSAL, S.HISAL
FROM EMP E, SALGRADE S
WHERE 1=1
  AND E.JOB = 'CLERK'
  AND E.SAL > S.LOSAL
--  AND E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY 1,2,3
;

SELECT E.ENAME �����, E.SAL �޿�
    , MAX(S.GRADE) �޿����
    , SUM(S.LOSAL), AVG(S.HISAL)
FROM EMP E, SALGRADE S
WHERE 1=1
  AND E.JOB = 'CLERK'
  AND E.SAL > S.LOSAL   
GROUP BY E.ENAME, E.SAL 
ORDER BY 1,2,3
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 79

SELECT *
FROM JOB_NM_OUT
;

SELECT P.EMPNO ���, P.ENAME �̸�, J.JOB_NAME ������
FROM EMP P,  JOB_NM_OUT J
WHERE P.JOB = J.JOB(+)
  AND P.DEPTNO = 10
;

SELECT P.EMPNO ���, P.ENAME �̸�, J.JOB_NAME ������
FROM EMP P LEFT OUTER JOIN JOB_NM_OUT J
	 ON P.JOB = J.JOB
WHERE P.DEPTNO = 10
;

SELECT P.EMPNO ���, P.ENAME �̸�, J.JOB_NAME ������, P.JOB , J.JOB
FROM EMP P FULL OUTER JOIN JOB_NM_OUT J
	 ON P.JOB = J.JOB
    AND P.JOB = 'CLERK'
;

SELECT *
FROM EMP
WHERE JOB = 'CLERK'
;