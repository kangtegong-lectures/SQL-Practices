

SELECT *
FROM TAB;


SELECT LENGTHB('한') FROM DUAL;
SELECT LENGTHB('A') FROM DUAL;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
3일차 : 1장 5절~7절;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P40

CREATE TABLE EMP_COPY
(
    EMPNO 	NUMBER(4) NOT NULL  ,
    ENAME 	VARCHAR2(10)  	    ,
    JOB 		VARCHAR2(9)  	,
    MGR 		NUMBER(4)  		,
    HIREDATE DATE  			    ,
    SAL 		NUMBER(7,2)  	,
    COMM 	NUMBER(7,2)  	    ,
    DEPTNO 	NUMBER(2)           ,    
    CONSTRAINT PK_EMP_COPY PRIMARY KEY(EMPNO)
);

SELECT *
FROM EMP_COPY
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P41

DROP TABLE EMP_COPY1 PURGE;

-- PK 만들기 1
CREATE TABLE EMP_COPY1
(
    EMPNO 	NUMBER(4) CONSTRAINT PK_EMP_COPY PRIMARY KEY,
    ENAME 	VARCHAR2(10)  	    ,
    JOB 		VARCHAR2(9)  	,
    MGR 		NUMBER(4)  		,
    HIREDATE DATE  			    ,
    SAL 		NUMBER(7,2)  	,
    COMM 	NUMBER(7,2)  	    ,
    DEPTNO 	NUMBER(2)  
);


SELECT * FROM EMP_COPY2;
-- PK 만들기 2
CREATE TABLE EMP_COPY2
(
    EMPNO 	NUMBER(4) NOT NULL  ,
    ENAME 	VARCHAR2(10)  	    ,
    JOB 		VARCHAR2(9)  	,
    MGR 		NUMBER(4)  		,
    HIREDATE DATE  			    ,
    SAL 		NUMBER(7,2)  	,
    COMM 	NUMBER(7,2)  	    ,
    DEPTNO 	NUMBER(2)  
);

-- PK 만들기 3
ALTER TABLE EMP_COPY2
	DROP CONSTRAINT  PK_EMP_COPY2;

ALTER TABLE EMP_COPY2
	ADD CONSTRAINT  PK_EMP_COPY2 PRIMARY KEY (EMPNO);

INSERT INTO EMP_COPY2(EMPNO) VALUES(1);
INSERT INTO EMP_COPY2(EMPNO) VALUES(2);
INSERT INTO EMP_COPY2(EMPNO) VALUES(1);

SELECT *
FROM EMP_COPY2
;

ROLLBACK;


DROP TABLE EMP_COPY1 PURGE;
DROP TABLE EMP_COPY2 PURGE;

-- CHECK조건
CREATE TABLE EMP_COPY3
(
    EMPNO 	NUMBER(4) NOT NULL  ,
    ENAME 	VARCHAR2(10)  	    ,
    JOB 		VARCHAR2(9)  	,
    MGR 		NUMBER(4)  		,
    HIREDATE DATE  			DEFAULT  SYSDATE ,
    SAL 		NUMBER(7,2)  	
                CONSTRAINT CHK_EMP_COPY CHECK(SAL BETWEEN 100 AND 1000)
                NOT NULL        , -- 데이터 꼭 넣어라~
    COMM 	NUMBER(7,2)  	    ,
    DEPTNO 	NUMBER(2)      
);

INSERT INTO EMP_COPY3(EMPNO,SAL) VALUES(1,100);
INSERT INTO EMP_COPY3(EMPNO,SAL) VALUES(2,1000);
INSERT INTO EMP_COPY3(EMPNO,SAL) VALUES(3,500);
INSERT INTO EMP_COPY3(EMPNO,SAL) VALUES(4,50); -- 이건 Check 조건에 위배되므로 에러난다

SELECT *
FROM EMP_COPY3;

ROLLBACK;


-- 외래키
--DROP TABLE DEPT_01 PURGE;
CREATE TABLE DEPT_01 (
	DEPTNO NUMBER(2) CONSTRAINT PK_DEPT01 PRIMARY KEY, 
	DNAME 	VARCHAR2(14) , 
	LOC 	VARCHAR2(13) 
) ; 


--DROP TABLE EMP_01 PURGE;
CREATE TABLE EMP_01 (
	EMPNO NUMBER(4) CONSTRAINT PK_EMP01 PRIMARY KEY, 
	ENAME 	VARCHAR2(10), 
	JOB 	VARCHAR2(9) , 
	MGR 	NUMBER(4)   , 
	HIREDATE 	DATE    , 
	SAL 	NUMBER(7,2) , 
	COMM 	NUMBER(7,2) , 
	DEPTNO NUMBER(2) 
    CONSTRAINT FK_DEPTNO01 REFERENCES DEPT_01
); 

INSERT INTO DEPT_01
SELECT * FROM DEPT;

INSERT INTO EMP_01
SELECT * FROM EMP;

COMMIT;

INSERT INTO EMP_01(EMPNO, DEPTNO) VALUES(10,10);
INSERT INTO EMP_01(EMPNO, DEPTNO) VALUES(20,50);

SELECT *
FROM EMP_01
;
SELECT *
FROM DEPT_01
;

ROLLBACK;

DELETE DEPT_01
WHERE DEPTNO = 10
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P42

DROP TABLE EMP_COPY4 PURGE;

CREATE TABLE EMP_COPY4
AS
SELECT *
FROM EMP_01
;

SELECT *
FROM EMP_COPY4
;

DESC EMP_COPY4;
DESC EMP_01;


CREATE TABLE EMP_COPY5
AS
SELECT *
FROM EMP
where 1=2
;

SELECT *
FROM EMP_COPY5
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P43
SELECT *
FROM DEPT_01;

DROP TABLE DEPT_01 ;

DROP TABLE DEPT_01 PURGE;

DROP TABLE DEPT_01 CASCADE CONSTRAINT ;

DROP TABLE EMP_01 PURGE;

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMP
;

SELECT *
FROM EMP_COPY
;

TRUNCATE TABLE EMP_COPY;

ROLLBACK;

DROP TABLE EMP_COPY PURGE;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 데이터를 변형해서 입력하기
-- 데이터를 가공해서 집어넣기

INSERT INTO EMP_COPY
;
CREATE TABLE EMP_COPY
AS
SELECT EMPNO - 5000    AS EMPNO
		,ENAME
		,JOB
		,MGR
		,HIREDATE
		,SAL
		,400    AS COMM
		,DEPTNO
FROM EMP
;

SELECT *
FROM EMP_COPY
;

ROLLBACK;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 똑같은 로우가 실수로 중복으로 들어갔을때 하나만 삭제하는 방법 (이 부분 이해가ㅠㅠㅠㅠ)

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMP;

INSERT INTO EMP_COPY
SELECT * FROM EMP;

SELECT * FROM EMP_COPY;
COMMIT;

SELECT ROWID, AA.* --ROWNUM과 같은 수도 컬럼. ROWID = 해당하는 Row data가 어디에 저장되어 있는지 그 위치를 가지고 있는 것(?)
                    -- 데이터는 중복될 수 있지만 ROWID는 중복되지 않는다!
FROM EMP_COPY AA
ORDER BY EMPNO
;


SELECT MAX(ROWID), EMPNO
FROM EMP_COPY
GROUP BY EMPNO
;

SELECT *
FROM EMP_COPY
WHERE ROWID IN (SELECT MAX(ROWID)
				FROM EMP_COPY
				GROUP BY EMPNO)
;

DELETE EMP_COPY
WHERE ROWID NOT IN (SELECT MAX(ROWID)
				FROM EMP_COPY
				GROUP BY EMPNO)
; -- 28개의 데이터가 삭제된다

COMMIT;
-- 중복되지 않은 144개의 데이터가 남는다

SELECT *
FROM EMP_COPY
;

DROP TABLE EMP_COPY CASCADE CONSTRAINT PURGE;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 56

SELECT TO_DATE('20180131','YYYYMMDD') + 1
      , TO_CHAR(TO_DATE('20180101','YYYYMMDD') + 1,'YYYY"년" MM"월" DD"일"')
      , TO_CHAR(TO_DATE('20181030','YYYYMMDD'),'D') 
      , TO_CHAR(TO_DATE('20180101','YYYYMMDD') + 1,'DAY') 
FROM DUAL
;

-- 오늘의 요일을 가져옴
SELECT TO_CHAR(SYSDATE,'DY') 
      , TO_CHAR(SYSDATE,'DAY') 
      , TO_CHAR(SYSDATE,'D') -- 해당주의 몇번째 날
FROM DUAL;

-- 이번달중에 몇번째 주인지 확인
SELECT TO_CHAR(SYSDATE, 'W') 
, TO_CHAR(TO_DATE('20181029','YYYYMMDD'),'W')
FROM DUAL ;

-- 일년중 오늘이 몇주째인지 확인
SELECT TO_CHAR(SYSDATE, 'IW') 
, TO_CHAR(TO_DATE('20181029','YYYYMMDD'),'IW')  -- 월
, TO_CHAR(TO_DATE('20181028','YYYYMMDD'),'IW')  -- 일
FROM DUAL ;

SELECT TO_CHAR(TO_DATE('20171231','YYYYMMDD'), 'IW') 
      , TO_CHAR(TO_DATE('20180101','YYYYMMDD'), 'IW') 
	  , TO_CHAR(TO_DATE('20181231','YYYYMMDD'), 'IW') 
      , TO_CHAR(TO_DATE('20190101','YYYYMMDD'), 'IW') 
	  , TO_CHAR(TO_DATE('20181230','YYYYMMDD'), 'IW') 
FROM DUAL ;

-- 이번주 일요일 지난주 월요일 구하기
select TRUNC(SYSDATE, 'd') 이번주일요일1
     , TRUNC(SYSDATE, 'd') + 6
     , TRUNC(SYSDATE, 'iw')
     , TRUNC(SYSDATE, 'iw') - 7 지난주월요일
from DUAL;

      SELECT TO_DATE('20180101','YYYYMMDD')+ROWNUM-1 AS DT
      FROM DUAL
      CONNECT BY LEVEL <=365;

SELECT DT, TO_CHAR(DT,'DY') DY
FROM (
      SELECT TO_DATE('20180101','YYYYMMDD')+ROWNUM-1 AS DT
      FROM DUAL
      CONNECT BY LEVEL <=365)
WHERE TO_CHAR(DT,'DY') IN ('토','일')
;



select TRUNC(SYSDATE, 'DD') AS A
    , TO_CHAR(TRUNC(SYSDATE, 'DD'),'YYYYMMDD HH24MISS')
    , TO_CHAR(SYSDATE,'YYYYMMDD HH24MISS')
    , TRUNC(SYSDATE, 'MM')
    , TRUNC(SYSDATE, 'YYYY')
    , TRUNC(11.999,2)
    , TRUNC(11.999)
from DUAL;
  

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 59

SELECT LOWER('AaBbcC')
      , UPPER('AaBbcC')
FROM DUAL
;

-- 이 부분 좀 어려움
SELECT ASCII('A')
      , CHR(65)
      , 'A"  ''
        AAA'||CHR(13)||'B' AS COL --13번은 아스키로 엔터
FROM DUAL
;

-- concat은 문자열을 두 개만 합칠 수 있다
SELECT CONCAT('ABC','abc'), 'ABC'||'abc'||'FDSA'||11212121 -- 숫자를 써도 묵시적 형변환으로 인해 숫자로 바뀜
	  , SUBSTR('ABCDEFG',2,2) -- SUBSTR은 문자열을 자르는 함수 /왼쪽의 두 번째 자리로부터 두 개를 잘라라 라고 하는 뜻 
	  , SUBSTR('ABCDEFG',-2,2) -- 오른쪽부터 두 번째 자리로부터 두 개를 잘라라 라고 하는 뜻 (FG가 나옴)
	  , SUBSTR('ABCDEFG',2) -- 생략 가능
      , SUBSTR('가AS나다라마', 2) -- 한글 영어 같이 써도 됨. 한글도 한 글자로 봄
FROM DUAL
;

    -- SUBSTRB : SUB STRING BINARY 바이트를 기준으로 자름
    -- LENTH VS LENTHB

SELECT '18/01/01'
    , TO_DATE('20180101','YYYYMMDD')
    , TO_DATE('18/01/01')
    , TO_DATE('01012018','MMDDYYYY')
FROM DUAL
;
-- YYYYMMDD 아니면 MMDDYYYY이렇게 형식 꼭 잘 맞춰주기

SELECT LENGTH('ABCDEFG')
	  , LENGTHB('ABCDEFG')
	  , LENGTH('가나다라마바사')
	  , LENGTHB('가나다라마바사')
FROM DUAL
;

-- 문자열 설정 확인
select * from sys.props$ where name='NLS_CHARACTERSET';

-- TRIM : 쓸데없는 문자를 날리는 함수
SELECT LTRIM('  ABC   abc  ') 
       , RTRIM('  ABC   abc  ')
       , TRIM('  ABC   abc  ')
       , LTRIM('xYxxxxxYZZxYZ','xY') -- Z를 만난 순간부터 지우지 않음 결국 ZZxYZ
       , RTRIM('XXYYzzYZXXXxxx','Xx')
       , TRIM('x' FROM 'xxYYZZxYZxx')
       , REPLACE('  ABC   abc  ',' ',NULL)
       , REPLACE('xxYYZZxXYZxx','xY')
       , REPLACE(REPLACE('xxYYZZxXYZxx','xY'),'xY')
FROM DUAL   
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 61

SELECT ABS(-5)
FROM DUAL
;

SELECT SIGN(-20), SIGN(0), SIGN(20)
FROM DUAL
;

SELECT 7/3, TRUNC(7/3), MOD(7,3), 7 - TRUNC(7/3)*3
FROM DUAL
;

SELECT CEIL(38.123), CEIL(-38.123)
FROM DUAL
;

SELECT FLOOR(38.123), FLOOR(-38.123)
FROM DUAL
;

SELECT ROUND(38.5235,3), ROUND(38.5235,1), ROUND(38.5235,0), ROUND(38.5235)
FROM DUAL
;

SELECT TRUNC(38.5235,3), TRUNC(38.5235,1), TRUNC(38.5235,0), TRUNC(38.5235)
FROM DUAL
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 62

SELECT SYSDATE
FROM DUAL
;

SELECT EXTRACT( YEAR FROM SYSDATE)
      , EXTRACT( MONTH FROM SYSDATE)
      , EXTRACT( DAY FROM SYSDATE)
      , EXTRACT( YEAR FROM SYSTIMESTAMP) 년
      , EXTRACT( MONTH FROM SYSTIMESTAMP) 월
      , EXTRACT( DAY FROM SYSTIMESTAMP) 일
      , EXTRACT( HOUR FROM SYSTIMESTAMP) 시간
      , EXTRACT( MINUTE FROM SYSTIMESTAMP) 분
      , EXTRACT( SECOND FROM SYSTIMESTAMP) 초
	, TO_CHAR(SYSDATE, 'YYYYMMDD HH24MISS') 일자변환1       HH 시간 MI 분 SS 초
FROM DUAL
;

SELECT TO_CHAR(SYSDATE,'YYYY') 년
	, TO_CHAR(SYSDATE,'MM') 월
	, TO_CHAR(SYSDATE,'DD') 일
	, TO_CHAR(SYSDATE,'HH24') 시
	, TO_CHAR(SYSDATE,'MI')	  분
	, TO_CHAR(SYSDATE,'SS') 초
	, TO_CHAR(SYSDATE, 'YYYYMMDD HH24MISS') 일자변환1
	, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') 일자변환2
	, TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') 일자변환3
	, TO_CHAR(sysdate, 'hh24"시"mi"분"ss"초"') 일자변환4
FROM DUAL
;

SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) 년
	, TO_NUMBER(TO_CHAR(SYSDATE,'MM')) 월
	, TO_NUMBER(TO_CHAR(SYSDATE,'DD')) 일
	, TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) 시
	, TO_NUMBER(TO_CHAR(SYSDATE,'MI')) 분
	, TO_NUMBER(TO_CHAR(SYSDATE,'SS')) 초
FROM DUAL
;

SELECT SYSDATE+1
	, SYSDATE
	, SYSDATE -1
	, SYSDATE - SYSDATE -- 며칠과 며칠 사이
	, TO_DATE('20180722','YYYYMMDD') - TO_DATE('20180721','YYYYMMDD')
	, TO_DATE('20180722','YYYYMMDD') - SYSDATE
	, TO_CHAR(SYSDATE, 'HH24') 현재시간
	, TO_CHAR(SYSDATE+3/24, 'HH24') 시간연산
	, TO_CHAR(SYSDATE, 'MI') 현재 분
	, TO_CHAR(SYSDATE+1/24/60*10, 'MI') 분 --시간연산 (10분 더하기)
    , TO_CHAR(SYSDATE, 'SS') 현재 초
	, TO_CHAR(SYSDATE+1/24/60/60*10, 'MI') 초 --시간연산
FROM DUAL
;

-- 추가

-- 날짜를 TRUNC하기 (날짜를 자르기)


SELECT TO_CHAR(SYSDATE,'YYYYMMDD HH24MISS') A0
     , TO_CHAR(TRUNC(SYSDATE,'YYYY'),'YYYYMMDD HH24MISS') A1
     , TO_CHAR(TRUNC(SYSDATE,'MM'),'YYYYMMDD HH24MISS') A2
     , TO_CHAR(TRUNC(SYSDATE,'DD'),'YYYYMMDD HH24MISS') A3
     , TO_CHAR(TRUNC(SYSDATE,'HH24'),'YYYYMMDD HH24MISS') A4
     , TO_CHAR(TRUNC(SYSDATE,'MI'),'YYYYMMDD HH24MISS') A5
     , TO_CHAR(TRUNC(SYSDATE)+1-(1/(24*60*60)),'YYYYMMDD HH24MISS') A6 --(1/(24*60*60)) == 1초
FROM DUAL
;

-- 오늘이 포함된 월요일부터 일요일 구하기
SELECT TO_CHAR(SYSDATE-TO_CHAR(SYSDATE-1,'D')+1,'YYYYMMDD') as mon
     , TO_CHAR(SYSDATE-TO_CHAR(SYSDATE-1,'D')+7,'YYYYMMDD') as sun
     , TRUNC(SYSDATE-1,'DAY')+1
     , TRUNC(SYSDATE-1,'DAY')+7
     , TRUNC(SYSDATE,'DAY')
FROM DUAL
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P63

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') 숫자, 
       TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') 날자,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') 일시,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD PM HH:MI:SS') PM,
       TO_CHAR(SYSDATE, 'YYYY. MON, DAY') 문자
FROM   DUAL
;

SELECT TRIM(TO_CHAR(123456789123456789/1200,'$999,999,999,999,999,999,999,999,999.99')) 환율반영달러, 
       TO_CHAR(123456789.129,'L999,999,999.00') 원화 
     , TO_CHAR(123456789,'999,999,999.00') 원화 
     , TO_CHAR(89,'00000000') 원화  -- '000000'은 무조건 0갯수만큼의 자릿수로서 89를 표현한다. 단 무조건 0 갯수만큼 표현
     , TRIM(TO_CHAR(89,'99999999')) 원화  -- '9999999'은 무조건 9갯수만큼의 자릿수로서 89를 표현한다. 단 9갯수보다 적으면 적은만큼 표현
FROM   DUAL
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P64

SELECT ENAME, SAL,
      CASE WHEN SAL > 2000
	        THEN SAL
			ELSE 2000
       END AS REVISED_SALARY
FROM EMP
;


SELECT ENAME, SAL,
      CASE WHEN SAL >= 3000 THEN 'HIGH'
	       WHEN SAL >= 1000 THEN 'MID'
			ELSE 'LOW'
       END AS SALARY_GRADE
FROM EMP
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P65

SELECT ENAME, SAL,
      CASE WHEN SAL >= 2000 
	       THEN 1000
		   ELSE (CASE WHEN SAL >= 1000 
		        THEN 500
                ELSE 0
                END)
       END AS BONUS
FROM EMP
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P66
SELECT NULL+2
      , NULL-2
	  , NULL*2
	  , NULL/2
FROM DUAL
;

-- WITH문 : "지금 이 쿼리에서만 사용할 임시 테이블"
-- WITH TEST AS : TEST라는 이름으로 임시 테이블을 만든다

WITH TEST AS (
	SELECT NULL COL1, 12 COL2, 13 COL3 FROM DUAL UNION ALL
	SELECT 21, NULL, 23 FROM DUAL UNION ALL
	SELECT 31, 32, NULL FROM DUAL
)
SELECT *
FROM TEST
;

SELECT *
FROM TEST
; -- WITH문이 없기 때문에 없다고 나온다

WITH TEST(COL1, COL2, COL3) AS (
	SELECT NULL, 12, 13 FROM DUAL UNION ALL
	SELECT 21, NULL, 23 FROM DUAL UNION ALL
	SELECT 31, 32, NULL FROM DUAL
)
SELECT NVL(COL1,0), NVL(COL2,0), NVL(COL3,0)
FROM TEST
;


SELECT NULLIF('A','A'), NULLIF('A','B'), NVL(NULLIF('A','A'),'같다')
FROM DUAL
;
-- 같으면 NULL 반환
-- 같지 않으면 앞에 거 반환
-- 같으면 '같다'는 문자열 출력

WITH TEST(COL1, COL2, COL3) AS (
	SELECT NULL, 12, 13 FROM DUAL UNION ALL
	SELECT 21, NULL, 23 FROM DUAL UNION ALL
	SELECT 31, 32, NULL FROM DUAL
)
SELECT COALESCE(COL1, COL2, COL3)
FROM TEST
;
-- 처음으로 NULL이 아닌 값 출력하기