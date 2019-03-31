----------------------------------------------------------------------------------
 1일차  연습문제
----------------------------------------------------------------------------------
1. EMP 테이블 전체 칼럼을 조회 하세요.

SELECT *
FROM EMP
;

2. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 전체 칼럼 조회
   - 부서번호(DEPTNO)가 20또는 30인 부서를 조회 하세요.

SELECT *
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30
;

SELECT *
FROM EMP
WHERE DEPTNO IN (20, 30)
;

3. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 사원명(ENAME)이 'A'로 시작하는 사원만 조회
   
SELECT *
FROM EMP
WHERE ENAME LIKE 'A%'
;
   
4. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : EMPNO, ENAME, HIREDATE, SAL, SAL + COMM (HEADING을 TOT_SAL로 출력)
   - 조회조건 : JOB이 'CLERK', 'SALESMAN', 'MANAGER' 만 조회

SELECT EMPNO, ENAME, HIREDATE, SAL, SAL + COMM AS TOT_SAL, JOB
FROM EMP
WHERE JOB IN ('CLERK', 'SALESMAN', 'MANAGER')
;

-- NULL과의 덧셈결과도 유효하도록 NVL 사용
SELECT EMPNO, ENAME, HIREDATE, SAL, SAL + NVL(COMM,0) AS TOT_SAL, JOB
FROM EMP
WHERE JOB IN ('CLERK', 'SALESMAN', 'MANAGER')
;

5. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 사원명(ENAME)이 'BLAKE'인 메니저가 관리(MGR)하는 사원만 조회

--우선 BLAKE의 사원번호를 알아낸다

SELECT *
FROM EMP
WHERE ENAME = 'BLAKE'
;

-- BLAKE의 사원번호는 7698이다
-- 그럼 이제 7698이 MANAGER인 사람들을 조회하자

SELECT *
FROM EMP
WHERE MGR = 7698
;

-- JOIN을 이용해서 편리하게 한 방에 찾아볼 수도 있다

6. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 사원명(ENAME)이 'BLAKE'인 메니저가 관리(MGR)하는 사원중
                       직무가(JOB)이 'CLERK'인 사원만 조회

SELECT *
FROM EMP
WHERE MGR = 7698 AND JOB = 'CLERK'
;

7. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 직무가(JOB)이  'CLERK'이거나  'MANAGER' 인 사원 조회

SELECT *
FROM EMP
WHERE JOB IN ('CLERK', 'MANAGER')
;

8. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 직무가(JOB)이  'CLERK'인 사원중 급여(SAL)가 1,000이하거나
                        'MANAGER'인 사원중 급여(SAL)가 2,500이상인 사원 조회

SELECT *
FROM EMP
WHERE (JOB = 'CLERK' AND SAL <= 1000) OR (JOB='MANAGER' AND SAL >= 2500)
;

9. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 커미션(COMM)이 있거나 직무(JOB)가  'MANAGER'인 사원중 
                        급여(SAL)가 2,800에서 3,000사이에 있는 사원 조회

SELECT *
FROM EMP
WHERE (COMM IS NOT NULL
-- '데이터가 있거나' == 'IS NOT NULL'
-- 아니면 COMM > 0. 사실 COMM > 0이 더 정확한 표현
    OR JOB = 'MANAGER')
    AND SAL BETWEEN 2800 AND 3000;
    

10. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 사원명(ENAME)에 'A'가 들어가는 사원중
                      부서번호(DEPTNO)가 30인 사원은 커미션(COMM)이 100이상에서 1,000이하를 받거나
                      부서번호(DEPTNO)가 30이 아닌 사원

SELECT * 
FROM EMP
WHERE ENAME LIKE '%A%' --A가 어디에 들어갈지모르니까 앞뒤로 %붙이기
    AND (EMPNO = 30 AND COMM BETWEEN 100 AND 1000
        OR
        DEPTNO != 30);

-- 괄호의 위치에 유의할 것!        
        
11. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 사원명(ENAME)이 J로 시작하면서 3번째 문자가 M or N인 사원

SELECT *
FROM EMP
WHERE ENAME LIKE 'J%'
AND (ENAME LIKE '__M%' OR ENAME LIKE '__N%')
;