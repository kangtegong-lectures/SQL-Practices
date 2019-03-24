
----------------------------------------------------------------------------------------------------------------------------------------------------------------
2���� : 1�� 3��~4��;
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

SELECT PLAYER_NAME �����̸�, POSITION ������,  BACK_NO  ��ѹ�, HEIGHT Ű, TEAM_ID
FROM PLAYER
WHERE (TEAM_ID = 'K02'  OR  TEAM_ID = 'K07')
	AND POSITION = 'MF'
	AND HEIGHT >=170
	AND HEIGHT <=180
;

SELECT  PLAYER_NAME  �����̸�, POSITION  ������, BACK_NO  ��ѹ�, HEIGHT Ű
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

SELECT PLAYER_NAME �����̸�, POSITION ������, BACK_NO ��ѹ�, HEIGHT Ű
FROM PLAYER
WHERE PLAYER_NAME LIKE '��%';
;

SELECT PLAYER_NAME �����̸�, POSITION ������, BACK_NO ��ѹ�, HEIGHT Ű
FROM PLAYER
WHERE PLAYER_NAME LIKE '_��%'
--WHERE PLAYER_NAME LIKE '__��'
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P27

SELECT PLAYER_NAME �����̸�, POSITION ������, TEAM_ID
FROM PLAYER
WHERE POSITION IS NULL
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P28

SELECT PLAYER_NAME �����̸�, POSITION ������, BACK_NO ��ѹ�, HEIGHT Ű, TEAM_ID
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

SELECT COUNT(*) ��ü_���, COUNT(HEIGHT) "Ű �Ǽ�",
		MAX(HEIGHT) �ִ�Ű, MIN(HEIGHT) �ּ�Ű, ROUND(AVG(HEIGHT),2) ���Ű
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

SELECT POSITION ������, COUNT(*) �ο���, COUNT(HEIGHT) Ű���,
		MAX(HEIGHT) �ִ�Ű, MIN(HEIGHT) �ּ�Ű, ROUND(AVG(HEIGHT),2) ���Ű	, SUM(HEIGHT)
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

SELECT POSITION ������, ROUND(AVG(HEIGHT),1) ���Ű		
FROM PLAYER
GROUP BY POSITION
HAVING AVG(HEIGHT) >= 180
;

SELECT POSITION ������, ROUND(AVG(HEIGHT),2) ���Ű	
    , COUNT(*) 
    , MAX(PLAYER_NAME)
FROM PLAYER
GROUP BY POSITION , PLAYER_NAME
HAVING AVG(HEIGHT) >= 180
ORDER BY 1,2
;

SELECT POSITION ������, HEIGHT
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
-- �η�
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EMP ���̺��� JOB�� � �͵��� �ִ��� Ȯ���� ��

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
-- ���� �����͸� ���η� ǥ���� ��

-- �����͸� �����ϸ� ���η� ��ȸ��
SELECT DEPTNO, JOB 
		, ROUND(AVG(SAL)) AS AVG_SAL
FROM   EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB
;

-- DECODE���� �̿��ؼ� ���η� �������
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

-- NULL ���� �����ϱ� ���� GROUP BY ����
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



-- DEPTNO �������� ���η� ��ȸ
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

-- ���� ���� �հ赵 �Բ� ��ȸ
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


