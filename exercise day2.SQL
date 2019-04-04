----------------------------------------------------------------------------------
 3일차  연습문제
----------------------------------------------------------------------------------
1. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 부서번호(DEPTNO), 명수 조회
   - 부서번호(DEPTNO)별로 명수를 조회하고, 부서번호 기준으로 정렬하세요.;

SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO
;

2. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 부서번호(DEPTNO), 급여(SAL) 합계 조회
   - 부서번호(DEPTNO)별로 급여(SAL)  합계를 조회하고, 
      급여가 많은 부서순으로 정렬하세요.;

SELECT DEPTNO, SUM(SAL) AS SAL_SUM
FROM EMP
GROUP BY DEPTNO
ORDER BY SAL_SUM
;


3. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 부서번호(DEPTNO), 직무(JOB), 급여(SAL) 평균 조회
   - 부서번호(DEPTNO)기준으로 직무(JOB)별로 급여(SAL) 평균을 구하고
     부서번호, 직무 기준으로 정렬하세요.

SELECT DEPTNO, JOB, AVG(SAL) AS SAL_AVG
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB
;

4. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 부서번호(DEPTNO), 직무(JOB), 급여(SAL) 평균 조회
   - 부서번호(DEPTNO)기준으로 직무(JOB)별로 급여(SAL) 평균을 구하고
     그중 부서번호(DEPTNO)가 10인 부서를 조회 하세요;

SELECT DEPTNO, JOB, AVG(SAL) AS SAL_AVG
FROM EMP
WHERE DEPTNO = 10
GROUP BY DEPTNO, JOB
--HAVING DEPTNO = 10
;
SELECT DEPTNO, JOB, AVG(SAL) AS SAL_AVG
FROM EMP
WHERE DEPTNO = 10
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
;

5. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 관리자(MGR), 급여(SAL)합계 조회
   - 관리자(MGR)별로 급여(SAL)합계를 구하여 
     합이 6000을 초과하는 괸리자를 조회 하세요;

SELECT MGR, SUM(SAL)
FROM EMP
GROUP BY MGR
HAVING SUM(SAL) > 6000
;

6. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 급여(SAL) 최대, 급여(SAL) 최소, 커미션(COMM) 최대, 커미션(COMM) 최소 조회
   - 급여(SAL) 최대, 급여(SAL) 최소, 커미션(COMM) 최대, 커미션(COMM) 최소를 구하세요.;
SELECT MAX(SAL), MIN(SAL), MAX(COMM), MIN(COMM)
FROM EMP
;


7. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 직무(JOB), 급여(SAL) 최대, 급여(SAL) 최소, 커미션(COMM) 최대, 커미션(COMM) 최소 조회
   - 직무(JOB)별로 급여(SAL) 최대, 급여(SAL) 최소, 커미션(COMM) 최대, 커미션(COMM) 최소를 구하세요.;
SELECT JOB, MAX(SAL), MIN(SAL), MAX(COMM), MIN(COMM)
FROM EMP
GROUP BY JOB
;

8. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 부서번호(DEPTNO), 급여(SAL) 최대, 급여(SAL) 최소, 커미션(COMM) 최대, 커미션(COMM) 최소 조회
   - 부서번호(DEPTNO)별로 급여(SAL) 최대, 급여(SAL) 최소, 
     커미션(COMM) 받는 사람수, 커미션(COMM) 못 받는 사람수를 구하세요.;
SELECT DEPTNO, MAX(SAL), MIN(SAL), COUNT(COMM), COUNT(*) - COUNT(COMM)
     , SUM(DECODE(COMM,NULL,1,DECODE(COMM,0,1,0)))
     , SUM(CASE WHEN COMM IS NULL OR COMM = 0 THEN 1
            ELSE 0 
       END)       
FROM EMP
GROUP BY DEPTNO
;


9. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 급여(SAL) 최대, 급여(SAL) 최소, 인원수 조회
   - 급여가 1000이하인 사원중 급여(SAL) 최대, 급여(SAL) 최소, 인원수를 구하세요.;
SELECT MAX(SAL), MIN(SAL), COUNT(*)
FROM EMP
WHERE SAL <= 1000
;

10. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 부서번호(DEPTNO), 직무(JOB), 급여(SAL) 합계 조회
   - 부서번호(DEPTNO)기준으로 직무(JOB)별로 급여(SAL) 합계를 구하고
     마지막 로우에 전체 급여합계를 조회하며 
     이때 부서번호컬럼은 NULL로 직무컬럼에는 '합계'로 표시하여 조회 하세요.;

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
WHERE DEPTNO = 10
GROUP BY DEPTNO, JOB
UNION ALL
SELECT 10, '소계', SUM(SAL)
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
WHERE DEPTNO = 20
GROUP BY DEPTNO, JOB
UNION ALL
SELECT 20, '소계', SUM(SAL)
FROM EMP
WHERE DEPTNO = 20
UNION ALL
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
WHERE DEPTNO = 30
GROUP BY DEPTNO, JOB
UNION ALL
SELECT 30, '소계', SUM(SAL)
FROM EMP
WHERE DEPTNO = 30
UNION ALL
SELECT NULL, '합계', SUM(SAL)
FROM EMP
;


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP( DEPTNO, JOB )
;


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP( (DEPTNO, JOB) )
;


