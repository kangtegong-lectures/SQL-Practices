
----------------------------------------------------------------------------------------------------------------------------------------------------------------
5일차 : 2장 3절~4절;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 83
SELECT *
FROM EMP
WHERE MGR=7839
;

SELECT LEVEL, LPAD(' ', 4 * (LEVEL-1)) || EMPNO 사원, MGR 관리자,
		CONNECT_BY_ISLEAF ISLEAF,
		CONNECT_BY_ROOT EMPNO 시작사원, SYS_CONNECT_BY_PATH(EMPNO,'/') 경로
FROM EMP
START WITH MGR IS NULL
--START WITH EMPNO = 7876
CONNECT BY PRIOR EMPNO= MGR
--CONNECT BY PRIOR MGR= EMPNO
;

SELECT LEVEL, LPAD(' ', 4 * (LEVEL-1)) || EMPNO 사원, MGR 관리자,
		CONNECT_BY_ISLEAF ISLEAF,
		CONNECT_BY_ROOT EMPNO 시작사원, SYS_CONNECT_BY_PATH(EMPNO,'/') 경로
        , LTRIM(SYS_CONNECT_BY_PATH(EMPNO,'-'),'-') 경로
FROM EMP
WHERE CONNECT_BY_ISLEAF = 1
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO= MGR
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 84

SELECT LEVEL, LPAD(' ', 4 * (LEVEL-1)) || EMPNO 사원, MGR 관리자,
		CONNECT_BY_ISLEAF ISLEAF
FROM EMP
START WITH EMPNO = 7876
CONNECT BY PRIOR MGR = EMPNO
;

SELECT TO_DATE('20180101','YYYYMMDD')-1+ROWNUM,ROWNUM
FROM DUAL
CONNECT BY LEVEL <= 30
;

SELECT MGR, SUM(SAL)
FROM EMP
GROUP BY MGR
UNION ALL
SELECT NULL, SUM(SAL)
FROM EMP
ORDER BY 1,2
;

SELECT LV, DECODE(LV,1,MGR,NULL)  , SUM(SAL) SAL
FROM EMP
    , (SELECT LEVEL LV
        FROM DUAL
        CONNECT BY LEVEL <= 2
        )
GROUP BY LV, DECODE(LV,1,MGR,NULL)
ORDER BY 1,2
;

SELECT LV, DECODE(LV,1,MGR)
FROM EMP
    , (SELECT LEVEL LV
        FROM DUAL
        CONNECT BY LEVEL <= 2
        )
ORDER BY 1,2
;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 85

SELECT *
FROM EMP
;
-- 14개 조회
SELECT COUNT(*)
FROM EMP
;

-- JOIN 되지 않은 데이터가 있어서 13개 조회
SELECT WORKER.EMPNO 사원번호, WORKER.ENAME 사원명,WORKER.MGR,
		MANAGER.EMPNO 관리자사번, MANAGER.ENAME 관리자명
FROM EMP WORKER, EMP MANAGER
WHERE WORKER.MGR = MANAGER.EMPNO
;

-- OUTER JOIN 으로 확인
SELECT WORKER.EMPNO 사원번호, WORKER.ENAME 사원명,
		MANAGER.EMPNO 관리자사번, MANAGER.ENAME 관리자명,
		M2.EMPNO 관리자2사번, M2.ENAME 관리자2명
FROM EMP WORKER, EMP MANAGER, EMP M2
WHERE WORKER.MGR = MANAGER.EMPNO(+)
AND MANAGER.MGR = M2.EMPNO(+)
;

-- ANSI 쿼리로 OUTER JOIN
SELECT WORKER.EMPNO 사원번호, WORKER.ENAME 사원명,
		MANAGER.EMPNO 관리자사번, MANAGER.ENAME 관리자명
        ,M2.EMPNO 관리자2사번, M2.ENAME 관리자2명
FROM EMP WORKER LEFT OUTER JOIN EMP MANAGER
     ON WORKER.MGR = MANAGER.EMPNO
     LEFT OUTER JOIN EMP M2
     ON MANAGER.MGR = M2.EMPNO
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 89

SELECT PLAYER_NAME 선수명, POSITION 포지션, BACK_NO 백넘버, TEAM_ID
FROM PLAYER_T
WHERE TEAM_ID = (SELECT TEAM_ID
					FROM PLAYER_T
					WHERE PLAYER_NAME= '정남일')
ORDER BY PLAYER_NAME
;

SELECT PLAYER_NAME 선수명, POSITION 포지션, BACK_NO 백넘버, TEAM_ID
FROM PLAYER_T AA
WHERE EXISTS (SELECT 1
                FROM PLAYER_T
                WHERE TEAM_ID = AA.TEAM_ID
                AND PLAYER_NAME= '정남일')
ORDER BY PLAYER_NAME
;

SELECT *
FROM PLAYER_T
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 91

SELECT *
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO 
					FROM DEPT
                    WHERE DNAME IN ('ACCOUNTING', 'RESEARCH'))
;

SELECT *
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO 
					FROM DEPT
                    WHERE DNAME IN ('ACCOUNTING', 'RESEARCH'))
;


SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
						FROM EMP
						GROUP BY DEPTNO)
ORDER BY DEPTNO, ENAME
;

-- SAL이 같은 경우 사번이 빠른 사람으로 조회
SELECT *
FROM EMP
WHERE (DEPTNO, SAL, EMPNO) IN (
					SELECT DEPTNO, SAL, MAX(EMPNO)
					FROM EMP
					WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
											FROM EMP
											GROUP BY DEPTNO)
					GROUP BY DEPTNO, SAL)
ORDER BY DEPTNO, ENAME
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 92

SELECT E.*, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
	AND E.SAL > (SELECT AVG(SAL)
                    FROM EMP
				WHERE DEPTNO = E.DEPTNO
                 )
ORDER BY E.DEPTNO
;
30	1566.666666666666666666666666666666666667
20	2175
10	2916.666666666666666666666666666666666667
;
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 93

SELECT EMPNO
FROM (SELECT EMPNO, ENAME FROM EMP ORDER BY MGR);

SELECT MGR
FROM (SELECT EMPNO, ENAME FROM EMP ORDER BY MGR);



SELECT WORKER.EMPNO 사원번호, WORKER.ENAME 사원명,WORKER.MGR,
		MANAGER.EMPNO 관리자사번, MANAGER.ENAME 관리자명
FROM EMP WORKER, EMP MANAGER
WHERE WORKER.MGR = MANAGER.EMPNO
order by 사원번호
;

SELECT WORKER.EMPNO 사원번호, WORKER.ENAME 사원명,WORKER.MGR,
		MANAGER.EMPNO 관리자사번, MANAGER.ENAME 관리자명
FROM (SELECT * FROM EMP WHERE MGR = 7698) WORKER, EMP MANAGER
WHERE WORKER.MGR = MANAGER.EMPNO
;

SELECT WORKER.EMPNO 사원번호, WORKER.ENAME 사원명,WORKER.MGR,
		MANAGER.EMPNO 관리자사번, MANAGER.ENAME 관리자명
FROM EMP WORKER, EMP MANAGER
WHERE WORKER.MGR = MANAGER.EMPNO
    AND WORKER.MGR = 7698
;



SELECT WORKER.EMPNO 사원번호, WORKER.ENAME 사원명,WORKER.MGR,
		MANAGER.EMPNO 관리자사번, MANAGER.ENAME 관리자명
FROM (SELECT * FROM EMP WHERE ROWNUM <= 2) WORKER, EMP MANAGER
WHERE WORKER.MGR = MANAGER.EMPNO
;

SELECT WORKER.EMPNO 사원번호, WORKER.ENAME 사원명,WORKER.MGR,
		MANAGER.EMPNO 관리자사번, MANAGER.ENAME 관리자명
FROM EMP WORKER, EMP MANAGER
WHERE WORKER.MGR = MANAGER.EMPNO
  AND ROWNUM <= 2
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 94

SELECT EMPNO, ENAME,
		(SELECT DNAME FROM DEPT WHERE DEPTNO = A.DEPTNO) DNAME
FROM EMP A;

SELECT EMPNO, ENAME, 
      (SELECT GRADE FROM SALGRADE WHERE EMP.SAL BETWEEN LOSAL AND HISAL)   as GRADE
FROM   EMP;

-- 2개 이상의 행이 리턴 되면 에러
SELECT EMPNO, ENAME,
		(SELECT GRADE FROM SALGRADE WHERE EMP.SAL > LOSAL) AS GRADE
FROM EMP
;

SELECT EMPNO, ENAME,
	   GRADE
FROM EMP AA
   , SALGRADE BB
WHERE AA.SAL > BB.LOSAL
;

SELECT EMPNO, ENAME,
	   GRADE, AA.SAL , BB.LOSAL
FROM EMP AA
   , SALGRADE BB
WHERE AA.SAL > BB.LOSAL
ORDER BY EMPNO, GRADE
;

SELECT *
from EMP
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 95

-- 함수의 인자
SELECT EMPNO, ENAME,
        (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO)AS DEPARTMENT_NAME_이전,
		SUBSTR((SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO),1,3)
		AS DEPARTMENT_NAME_이후
FROM EMP E;

-- WHERE 절의 조건
SELECT EMPNO, ENAME,
        (SELECT DNAME FROM DEPT WHERE DEPTNO=E.DEPTNO) AA
      , (SELECT DNAME FROM DEPT_2 WHERE DEPTNO = E.DEPTNO) BB
FROM EMP E
WHERE (SELECT DNAME FROM DEPT WHERE DEPTNO=E.DEPTNO)
		= (SELECT DNAME FROM DEPT_2 WHERE DEPTNO = E.DEPTNO)
;

--ORDER BY 절
SELECT EMPNO, ENAME, DEPTNO
FROM EMP E
ORDER BY (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO)
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 96

-- CASE 조건 절
SELECT EMPNO, ENAME, DEPTNO,
		(CASE WHEN DEPTNO IN (SELECT DEPTNO FROM DEPT)
			THEN 'USA'
			ELSE 'OTHER COUNTRY'
		END) LOCATION
FROM EMP E
;
-- CASE 결과 절
SELECT EMPNO, ENAME, DEPTNO,
		(CASE WHEN DEPTNO = 20
			THEN(SELECT DNAME FROM DEPT WHERE DEPTNO = 10)
			ELSE(SELECT DNAME FROM DEPT WHERE DEPTNO = 30)
		END) AS NEW_DEPARTMENT
FROM EMP E
;

-- Having 절
SELECT MGR, AVG(E.SAL)
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY MGR
HAVING AVG(E.SAL) < (SELECT AVG(A.SAL)
					FROM EMP A)
;

-- HAVING을 사용하지 않는 방법
SELECT A.*
FROM (
        SELECT MGR, AVG(E.SAL) SAL
        FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO
        GROUP BY MGR) A
WHERE A.SAL < (SELECT AVG(SAL) SAL FROM EMP)
;


