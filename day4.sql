
----------------------------------------------------------------------------------------------------------------------------------------------------------------
4일차 : 2장 1절~2절;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P71

-- 4
SELECT TEAM_ID 팀코드, PLAYER_NAME 선수명, POSITION 포지션,
		BACK_NO 백넘버, HEIGHT 키
FROM PLAYER
WHERE TEAM_ID = 'K02'
UNION all
-- 6
SELECT TEAM_ID 팀코드, PLAYER_NAME 선수명, POSITION 포지션,
		BACK_NO 백넘버, HEIGHT 키
FROM PLAYER
WHERE POSITION = 'MF'
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P72

-- 4
SELECT TEAM_ID 팀코드, PLAYER_NAME 선수명, POSITION 포지션,
		BACK_NO 백넘버, HEIGHT 키
FROM PLAYER
WHERE TEAM_ID = 'K02'
--MINUS --차집합
INTERSECT  --교집합
-- 6
SELECT TEAM_ID 팀코드, PLAYER_NAME 선수명, POSITION 포지션,
		BACK_NO 백넘버, HEIGHT 키
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

-- Alias 적용
SELECT P.PLAYER_NAME 선수명, P.BACK_NO 백넘버, P.TEAM_ID 팀코드, 
       T.TEAM_NAME 팀명,     T.REGION_NAME 연고지
FROM   PLAYER P,   TEAM T
WHERE  P.TEAM_ID = T.TEAM_ID;

-- 추가 조건 활용 가능
SELECT P.PLAYER_NAME 선수명, P.BACK_NO 백넘버, 
       T.REGION_NAME 연고지, T.TEAM_NAME 팀명
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

-- Alias 적용
SELECT P.EMPNO, P.ENAME, P.JOB, P.MGR,
		P.HIREDATE, P.SAL, P.COMM, P.DEPTNO,
		T.DEPTNO, T.DNAME, T.LOC
FROM EMP P, DEPT T
WHERE P.DEPTNO = T.DEPTNO
;

-- 추가 조건 활용 가능
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

SELECT P.EMPNO 사번, P.ENAME 이름, 
		J.JOB_NAME 담당업무,
		T.DNAME 부서명
FROM EMP P, DEPT T, JOB_NM J
WHERE P.DEPTNO = T.DEPTNO
	AND P.JOB = J.JOB
ORDER BY 이름
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


SELECT E.ENAME 사원명, E.SAL 급여, S.GRADE 급여등급
    , S.LOSAL, S.HISAL
FROM EMP E, SALGRADE S
WHERE 1=1
  AND E.JOB = 'CLERK'
  AND E.SAL > S.LOSAL
--  AND E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY 1,2,3
;

SELECT E.ENAME 사원명, E.SAL 급여
    , MAX(S.GRADE) 급여등급
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

SELECT P.EMPNO 사번, P.ENAME 이름, J.JOB_NAME 담당업무
FROM EMP P,  JOB_NM_OUT J
WHERE P.JOB = J.JOB(+)
  AND P.DEPTNO = 10
;

SELECT P.EMPNO 사번, P.ENAME 이름, J.JOB_NAME 담당업무
FROM EMP P LEFT OUTER JOIN JOB_NM_OUT J
	 ON P.JOB = J.JOB
WHERE P.DEPTNO = 10
;

SELECT P.EMPNO 사번, P.ENAME 이름, J.JOB_NAME 담당업무, P.JOB , J.JOB
FROM EMP P FULL OUTER JOIN JOB_NM_OUT J
	 ON P.JOB = J.JOB
    AND P.JOB = 'CLERK'
;

SELECT *
FROM EMP
WHERE JOB = 'CLERK'
;