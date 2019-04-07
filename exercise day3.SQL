----------------------------------------------------------------------------------
 4일차  연습문제
----------------------------------------------------------------------------------
주) FROM DUAL을 이용하여 SELECT 하세요

1. 2018년 4월 1일을 날자형으로 SELECT 하세요;
SELECT TO_DATE('20180401','YYYYMMDD')
FROM DUAL
;

2. SYSDATE를 이용하여 이번달 1일을 SELECT 하세요;
SELECT SYSDATE, TRUNC(SYSDATE,'MM')
     , TO_DATE(TO_CHAR(SYSDATE,'YYYYMM')||'01','YYYYMMDD')
FROM DUAL
;

3. SYSDATE를 이용하여 이번달 말일을 SELECT 하세요;
SELECT SYSDATE
     , LAST_DAY(SYSDATE)
     , TRUNC(ADD_MONTHS(SYSDATE,1),'MM')-1
FROM DUAL
;

4. ' aB 테스트 12 ' 문자를 기준으로
   첫번째 컬럼 전체 길이
   두번째 컬럼 스페이스를 제외한 길이를 SELECT 하세요;
SELECT LENGTH(' aB 테스트 12 '), LENGTH(REPLACE(' aB 테스트 12 ',' ',NULL))
FROM DUAL
;

5. 숫자 1234567890에 천단위마다 ,를 넣어서 SELECT 하세요
  결과) 1,234,567,890;
SELECT 1234567890
    , TRIM(TO_CHAR(1234567890,'999,999,999,999,999,999'))
FROM DUAL
;

6. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 고용일자(HIREDATE)가 1981년도인 사원만 조회 하세요.;
SELECT *
FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810101 000000','YYYYMMDD HH24MISS')
                   AND TO_DATE('19811231 235959','YYYYMMDD HH24MISS')
;

-- 인덱스 사용 못함
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE,'YYYY') = '1981'
;

DESC EMP;

7. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : 전체 칼럼 조회
   - 조회조건 : 고용일자(HIREDATE)가 1981년2월이거나  1987년 5월인 사원만 조회 하세요.;
SELECT *
FROM EMP
WHERE HIREDATE BETWEEN TO_DATE('19810201 000000','YYYYMMDD HH24MISS')
                   AND ADD_MONTHS(TO_DATE('19810201 000000','YYYYMMDD HH24MISS'),1)-1/24/60/60
   OR HIREDATE BETWEEN TO_DATE('19870501 000000','YYYYMMDD HH24MISS')
                   AND TO_DATE('19870531 235959','YYYYMMDD HH24MISS')
;

8. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : ENAME, 직무(JOB) 조회
   - 조회조건 : 전체 사원의 직무(JOB)가 ANALYST는 '분석가', CLERK은 '사무직', MANAGER는 '관리자'
		PRESIDENT는 '부서장', SALESMAN는 '영업'로 교체하여 조회;
SELECT ENAME, JOB
     , CASE WHEN JOB='ANALYST' THEN '분석가'
            WHEN JOB='CLERK' THEN '사무직'
            WHEN JOB='MANAGER' THEN '관리자'
            WHEN JOB='PRESIDENT' THEN '부서장'
            WHEN JOB='SALESMAN' THEN '영업'
       ELSE '기타'
       END AS JOB_NM
     , CASE JOB WHEN 'ANALYST' THEN '분석가'
            WHEN 'CLERK' THEN '사무직'
            WHEN 'MANAGER' THEN '관리자'
            WHEN 'PRESIDENT' THEN '부서장'
            WHEN 'SALESMAN' THEN '영업'
       ELSE '기타'
       END AS JOB_NM2
    , DECODE(JOB,'ANALYST', '분석가', 'CLERK', '사무직', 'MANAGER', '관리자',
		         'PRESIDENT', '부서장', 'SALESMAN', '영업','기타') JNM
FROM EMP
;

9. EMP 테이블을 아래의 조건에 맞게 조회 하세요.
   - 칼럼 : DEPTNO, JOB
   - 조회조건 : 부서번호(DEPTNO)별로 직무(JOB)가 어떤 것이 있는지 하나씩만 조회 하면서
			부서번호(DEPTNO), 직무(JOB) 기준으로 정렬하지만 부서에 직무가 MANAGER인 직무는
			각 부서에서 위쪽에 정렬 하세요.(아래 결과와 같이 조회 하세요);
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
결과)
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


