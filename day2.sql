
----------------------------------------------------------------------------------------------------------------------------------------------------------------
2일차 : 1장 3절~4절;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P21
desc EMP;

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL = 1100
;

SELECT *
FROM EMP
WHERE SAL = 1100
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P24

SELECT PLAYER_NAME 선수이름, POSITION 포지션,  BACK_NO  백넘버, HEIGHT 키, TEAM_ID
FROM PLAYER
WHERE (TEAM_ID = 'K02'  OR  TEAM_ID = 'K07')
	AND POSITION = 'MF'
	AND HEIGHT >=170
	AND HEIGHT <=180
;

SELECT  PLAYER_NAME  선수이름, POSITION  포지션, BACK_NO  백넘버, HEIGHT 키
FROM  PLAYER
WHERE  TEAM_ID  IN('K02','K07')
AND  POSITION ='MF'
AND  HEIGHT  BETWEEN  170 AND 180
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P25

SELECT ENAME, JOB, DEPTNO
FROM EMP
WHERE (JOB, DEPTNO) IN (('MANAGER',20)
                       ,('CLERK',30)
                       )
;

SELECT ENAME, JOB, DEPTNO
FROM EMP
WHERE (JOB = 'MANAGER' AND DEPTNO = 20)
   OR (JOB = 'CLERK' AND DEPTNO = 30)
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P26
SELECT *
FROM PLAYER
;

SELECT PLAYER_NAME 선수이름, POSITION 포지션, BACK_NO 백넘버, HEIGHT 키
FROM PLAYER
WHERE PLAYER_NAME LIKE '장%';
;

SELECT PLAYER_NAME 선수이름, POSITION 포지션, BACK_NO 백넘버, HEIGHT 키
FROM PLAYER
WHERE PLAYER_NAME LIKE '_발%'
--WHERE PLAYER_NAME LIKE '__장'
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P27

SELECT PLAYER_NAME 선수이름, POSITION 포지션, TEAM_ID
FROM PLAYER
WHERE POSITION IS NULL
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P28

SELECT PLAYER_NAME 선수이름, POSITION 포지션, BACK_NO 백넘버, HEIGHT 키, TEAM_ID
FROM PLAYER
WHERE TEAM_ID = 'K02'
AND  POSITION = 'MF'
AND  HEIGHT BETWEEN 175 AND 185
;

SELECT ROWNUM, PLAYER_NAME FROM PLAYER WHERE ROWNUM <= 2;

SELECT PLAYER_NAME FROM PLAYER WHERE ROWNUM < 2+1;

SELECT ROWNUM, PLAYER_NAME FROM PLAYER WHERE ROWNUM = 1;


SELECT RN, PLAYER_NAME
FROM (SELECT ROWNUM RN, PLAYER_NAME FROM PLAYER)
WHERE RN > 5
;

SELECT ROWNUM AS RN, AA.* FROM PLAYER AA
;

SELECT *
FROM (SELECT ROWNUM AS RN, AA.* FROM PLAYER AA)
WHERE RN > 5
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P32

SELECT COUNT(*) 전체_행수, COUNT(HEIGHT) "키 건수",
		MAX(HEIGHT) 최대키, MIN(HEIGHT) 최소키, ROUND(AVG(HEIGHT),2) 평균키
        , SUM(DISTINCT HEIGHT) "DISTINCT", SUM(ALL HEIGHT) "ALL"
FROM PLAYER
;

SELECT *
FROM TAB;


SELECT DISTINCT HEIGHT  
--     , TEAM_ID
FROM PLAYER
;

SELECT *
FROM PLAYER
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P35

SELECT POSITION 포지션, COUNT(*) 인원수, COUNT(HEIGHT) 키대상,
		MAX(HEIGHT) 최대키, MIN(HEIGHT) 최소키, ROUND(AVG(HEIGHT),2) 평균키	, SUM(HEIGHT)
        , NVL(SUM(HEIGHT),1) A
        , DECODE(SUM(HEIGHT),NULL,1,SUM(HEIGHT)) * 1.1 B
FROM PLAYER
GROUP BY POSITION
;

WITH TT(A) AS (
SELECT 1 FROM DUAL UNION ALL
SELECT NULL FROM DUAL UNION ALL
SELECT 2 FROM DUAL
)
SELECT SUM(NVL(A,0)), AVG(  NVL(A,0)  ), AVG(  A  )
FROM TT
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P36

SELECT POSITION 포지션, ROUND(AVG(HEIGHT),1) 평균키		
FROM PLAYER
GROUP BY POSITION
HAVING AVG(HEIGHT) >= 180
;

SELECT POSITION 포지션, ROUND(AVG(HEIGHT),2) 평균키	
    , COUNT(*) 
    , MAX(PLAYER_NAME)
FROM PLAYER
GROUP BY POSITION , PLAYER_NAME
HAVING AVG(HEIGHT) >= 180
ORDER BY 1,2
;

SELECT POSITION 포지션, HEIGHT
FROM PLAYER
WHERE HEIGHT >= 180
;

DESC PLAYER;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P37

SELECT *
FROM DEPT_SORT
;

SELECT DNAME, LOC, DEPTNO
FROM DEPT_SORT
ORDER BY DNAME ASC, LOC ASC, DEPTNO DESC;

SELECT DNAME, LOC AREA, DEPTNO
FROM DEPT_SORT
ORDER BY DECODE(LOC,'C','1','B','2','A','3','D','4','E','5','6'), DNAME , AREA, DEPTNO DESC;

SELECT DNAME, LOC, DEPTNO
FROM DEPT_SORT
ORDER BY DNAME , LOC, DEPTNO DESC;

SELECT DNAME, LOC AS AREA, DEPTNO
FROM DEPT_SORT
ORDER BY 1, AREA, 3 DESC;


SELECT *
FROM PLAYER
ORDER BY POSITION NULLS FIRST
--ORDER BY DECODE(POSITION, NULL,'0',POSITION)
--ORDER BY NVL(POSITION, '0')
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 부록
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EMP 테이블의 JOB이 어떤 것들이 있는지 확인할 때

SELECT JOB
FROM   EMP
GROUP BY JOB
ORDER BY JOB
;

SELECT DISTINCT JOB
FROM   EMP
ORDER BY JOB
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 세로 데이터를 가로로 표현할 때

-- 데이터를 집계하면 세로로 조회됨
SELECT DEPTNO, JOB 
		, ROUND(AVG(SAL)) AS AVG_SAL
FROM   EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB
;

-- DECODE문을 이용해서 가로로 만들어줌
SELECT JOB
		,DECODE(DEPTNO,10,AVG_SAL) AVG_SAL_10
		,DECODE(DEPTNO,20,AVG_SAL) AVG_SAL_20
		,DECODE(DEPTNO,30,AVG_SAL) AVG_SAL_30
FROM (
		SELECT DEPTNO, JOB 
				, ROUND(AVG(SAL)) AS AVG_SAL
		FROM   EMP
		GROUP BY DEPTNO, JOB
		ORDER BY DEPTNO, JOB
		)
ORDER BY JOB
;

-- NULL 값을 제거하기 위해 GROUP BY 해줌
SELECT JOB
		,MAX(DECODE(DEPTNO,10,AVG_SAL)) AVG_SAL_10
		,MAX(DECODE(DEPTNO,20,AVG_SAL)) AVG_SAL_20
		,MAX(DECODE(DEPTNO,30,AVG_SAL)) AVG_SAL_30
FROM (
		SELECT DEPTNO, JOB 
				, ROUND(AVG(SAL)) AS AVG_SAL
		FROM   EMP
		GROUP BY DEPTNO, JOB
		ORDER BY DEPTNO, JOB
		)
GROUP BY JOB
ORDER BY JOB
;


SELECT JOB
		,(DECODE(DEPTNO,10,AVG_SAL)) AVG_SAL_10
		,(DECODE(DEPTNO,20,AVG_SAL)) AVG_SAL_20
		,(DECODE(DEPTNO,30,AVG_SAL)) AVG_SAL_30
FROM (
		SELECT DEPTNO, JOB 
				, ROUND(AVG(SAL)) AS AVG_SAL
		FROM   EMP
		GROUP BY DEPTNO, JOB
		ORDER BY DEPTNO, JOB)
    ;



-- DEPTNO 기준으로 가로로 조회
SELECT DECODE(DEPTNO,10,'SAL_10',20,'SAL_20','SAL_30') AS DEPT
		,MIN(DECODE(JOB,'ANALYST',AVG_SAL)) AVG_ANALYST
		,MIN(DECODE(JOB,'CLERK',AVG_SAL)) AVG_CLERK
		,MIN(DECODE(JOB,'MANAGER',AVG_SAL)) AVG_MANAGER
		,MIN(DECODE(JOB,'PRESIDENT',AVG_SAL)) AVG_PRESIDENT
		,MIN(DECODE(JOB,'SALESMAN',AVG_SAL)) AVG_SALESMAN
FROM (
		SELECT DEPTNO, JOB 
				, ROUND(AVG(SAL)) AS AVG_SAL
		FROM   EMP
		GROUP BY DEPTNO, JOB
		ORDER BY DEPTNO, JOB
		)
GROUP BY DEPTNO
ORDER BY DEPTNO
;

-- 가로 세로 합계도 함께 조회
WITH AVG_JOB AS(
		SELECT JOB
				,MAX(DECODE(DEPTNO,10,AVG_SAL)) AVG_SAL_10
				,MAX(DECODE(DEPTNO,20,AVG_SAL)) AVG_SAL_20
				,MAX(DECODE(DEPTNO,30,AVG_SAL)) AVG_SAL_30
				,NVL(MAX(DECODE(DEPTNO,10,AVG_SAL)),0)
				+NVL(MAX(DECODE(DEPTNO,20,AVG_SAL)),0)
				+NVL(MAX(DECODE(DEPTNO,30,AVG_SAL)),0) AVG_sum
		FROM (
				SELECT DEPTNO, JOB 
						, ROUND(AVG(SAL)) AS AVG_SAL
				FROM   EMP
				GROUP BY DEPTNO, JOB
				ORDER BY DEPTNO, JOB
				)
		GROUP BY JOB
		ORDER BY JOB
)
SELECT JOB,  AVG_SAL_10, AVG_SAL_20, AVG_SAL_30, AVG_sum
FROM AVG_JOB
UNION ALL
SELECT 'TOTAL' , SUM(AVG_SAL_10)  , SUM(AVG_SAL_20), SUM(AVG_SAL_30), SUM(AVG_sum)
FROM AVG_JOB
ORDER BY JOB
;


