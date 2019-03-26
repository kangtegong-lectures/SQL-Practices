

SELECT *
FROM TAB;


SELECT LENGTHB('��') FROM DUAL;
SELECT LENGTHB('A') FROM DUAL;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
3���� : 1�� 5��~7��;
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

-- PK ����� 1
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
-- PK ����� 2
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

-- PK ����� 3
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

-- CHECK����
CREATE TABLE EMP_COPY3
(
    EMPNO 	NUMBER(4) NOT NULL  ,
    ENAME 	VARCHAR2(10)  	    ,
    JOB 		VARCHAR2(9)  	,
    MGR 		NUMBER(4)  		,
    HIREDATE DATE  			DEFAULT  SYSDATE ,
    SAL 		NUMBER(7,2)  	
                CONSTRAINT CHK_EMP_COPY CHECK(SAL BETWEEN 100 AND 1000)
                NOT NULL        , -- ������ �� �־��~
    COMM 	NUMBER(7,2)  	    ,
    DEPTNO 	NUMBER(2)      
);

INSERT INTO EMP_COPY3(EMPNO,SAL) VALUES(1,100);
INSERT INTO EMP_COPY3(EMPNO,SAL) VALUES(2,1000);
INSERT INTO EMP_COPY3(EMPNO,SAL) VALUES(3,500);
INSERT INTO EMP_COPY3(EMPNO,SAL) VALUES(4,50); -- �̰� Check ���ǿ� ����ǹǷ� ��������

SELECT *
FROM EMP_COPY3;

ROLLBACK;


-- �ܷ�Ű
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
-- �����͸� �����ؼ� �Է��ϱ�
-- �����͸� �����ؼ� ����ֱ�

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
-- �Ȱ��� �ο찡 �Ǽ��� �ߺ����� ������ �ϳ��� �����ϴ� ��� (�� �κ� ���ذ��ФФФ�)

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMP;

INSERT INTO EMP_COPY
SELECT * FROM EMP;

SELECT * FROM EMP_COPY;
COMMIT;

SELECT ROWID, AA.* --ROWNUM�� ���� ���� �÷�. ROWID = �ش��ϴ� Row data�� ��� ����Ǿ� �ִ��� �� ��ġ�� ������ �ִ� ��(?)
                    -- �����ʹ� �ߺ��� �� ������ ROWID�� �ߺ����� �ʴ´�!
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
; -- 28���� �����Ͱ� �����ȴ�

COMMIT;
-- �ߺ����� ���� 144���� �����Ͱ� ���´�

SELECT *
FROM EMP_COPY
;

DROP TABLE EMP_COPY CASCADE CONSTRAINT PURGE;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 56

SELECT TO_DATE('20180131','YYYYMMDD') + 1
      , TO_CHAR(TO_DATE('20180101','YYYYMMDD') + 1,'YYYY"��" MM"��" DD"��"')
      , TO_CHAR(TO_DATE('20181030','YYYYMMDD'),'D') 
      , TO_CHAR(TO_DATE('20180101','YYYYMMDD') + 1,'DAY') 
FROM DUAL
;

-- ������ ������ ������
SELECT TO_CHAR(SYSDATE,'DY') 
      , TO_CHAR(SYSDATE,'DAY') 
      , TO_CHAR(SYSDATE,'D') -- �ش����� ���° ��
FROM DUAL;

-- �̹����߿� ���° ������ Ȯ��
SELECT TO_CHAR(SYSDATE, 'W') 
, TO_CHAR(TO_DATE('20181029','YYYYMMDD'),'W')
FROM DUAL ;

-- �ϳ��� ������ ����°���� Ȯ��
SELECT TO_CHAR(SYSDATE, 'IW') 
, TO_CHAR(TO_DATE('20181029','YYYYMMDD'),'IW')  -- ��
, TO_CHAR(TO_DATE('20181028','YYYYMMDD'),'IW')  -- ��
FROM DUAL ;

SELECT TO_CHAR(TO_DATE('20171231','YYYYMMDD'), 'IW') 
      , TO_CHAR(TO_DATE('20180101','YYYYMMDD'), 'IW') 
	  , TO_CHAR(TO_DATE('20181231','YYYYMMDD'), 'IW') 
      , TO_CHAR(TO_DATE('20190101','YYYYMMDD'), 'IW') 
	  , TO_CHAR(TO_DATE('20181230','YYYYMMDD'), 'IW') 
FROM DUAL ;

-- �̹��� �Ͽ��� ������ ������ ���ϱ�
select TRUNC(SYSDATE, 'd') �̹����Ͽ���1
     , TRUNC(SYSDATE, 'd') + 6
     , TRUNC(SYSDATE, 'iw')
     , TRUNC(SYSDATE, 'iw') - 7 �����ֿ�����
from DUAL;

      SELECT TO_DATE('20180101','YYYYMMDD')+ROWNUM-1 AS DT
      FROM DUAL
      CONNECT BY LEVEL <=365;

SELECT DT, TO_CHAR(DT,'DY') DY
FROM (
      SELECT TO_DATE('20180101','YYYYMMDD')+ROWNUM-1 AS DT
      FROM DUAL
      CONNECT BY LEVEL <=365)
WHERE TO_CHAR(DT,'DY') IN ('��','��')
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

-- �� �κ� �� �����
SELECT ASCII('A')
      , CHR(65)
      , 'A"  ''
        AAA'||CHR(13)||'B' AS COL --13���� �ƽ�Ű�� ����
FROM DUAL
;

-- concat�� ���ڿ��� �� ���� ��ĥ �� �ִ�
SELECT CONCAT('ABC','abc'), 'ABC'||'abc'||'FDSA'||11212121 -- ���ڸ� �ᵵ ������ ����ȯ���� ���� ���ڷ� �ٲ�
	  , SUBSTR('ABCDEFG',2,2) -- SUBSTR�� ���ڿ��� �ڸ��� �Լ� /������ �� ��° �ڸ��κ��� �� ���� �߶�� ��� �ϴ� �� 
	  , SUBSTR('ABCDEFG',-2,2) -- �����ʺ��� �� ��° �ڸ��κ��� �� ���� �߶�� ��� �ϴ� �� (FG�� ����)
	  , SUBSTR('ABCDEFG',2) -- ���� ����
      , SUBSTR('��AS���ٶ�', 2) -- �ѱ� ���� ���� �ᵵ ��. �ѱ۵� �� ���ڷ� ��
FROM DUAL
;

    -- SUBSTRB : SUB STRING BINARY ����Ʈ�� �������� �ڸ�
    -- LENTH VS LENTHB

SELECT '18/01/01'
    , TO_DATE('20180101','YYYYMMDD')
    , TO_DATE('18/01/01')
    , TO_DATE('01012018','MMDDYYYY')
FROM DUAL
;
-- YYYYMMDD �ƴϸ� MMDDYYYY�̷��� ���� �� �� �����ֱ�

SELECT LENGTH('ABCDEFG')
	  , LENGTHB('ABCDEFG')
	  , LENGTH('�����ٶ󸶹ٻ�')
	  , LENGTHB('�����ٶ󸶹ٻ�')
FROM DUAL
;

-- ���ڿ� ���� Ȯ��
select * from sys.props$ where name='NLS_CHARACTERSET';

-- TRIM : �������� ���ڸ� ������ �Լ�
SELECT LTRIM('  ABC   abc  ') 
       , RTRIM('  ABC   abc  ')
       , TRIM('  ABC   abc  ')
       , LTRIM('xYxxxxxYZZxYZ','xY') -- Z�� ���� �������� ������ ���� �ᱹ ZZxYZ
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
      , EXTRACT( YEAR FROM SYSTIMESTAMP) ��
      , EXTRACT( MONTH FROM SYSTIMESTAMP) ��
      , EXTRACT( DAY FROM SYSTIMESTAMP) ��
      , EXTRACT( HOUR FROM SYSTIMESTAMP) �ð�
      , EXTRACT( MINUTE FROM SYSTIMESTAMP) ��
      , EXTRACT( SECOND FROM SYSTIMESTAMP) ��
	, TO_CHAR(SYSDATE, 'YYYYMMDD HH24MISS') ���ں�ȯ1       HH �ð� MI �� SS ��
FROM DUAL
;

SELECT TO_CHAR(SYSDATE,'YYYY') ��
	, TO_CHAR(SYSDATE,'MM') ��
	, TO_CHAR(SYSDATE,'DD') ��
	, TO_CHAR(SYSDATE,'HH24') ��
	, TO_CHAR(SYSDATE,'MI')	  ��
	, TO_CHAR(SYSDATE,'SS') ��
	, TO_CHAR(SYSDATE, 'YYYYMMDD HH24MISS') ���ں�ȯ1
	, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') ���ں�ȯ2
	, TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') ���ں�ȯ3
	, TO_CHAR(sysdate, 'hh24"��"mi"��"ss"��"') ���ں�ȯ4
FROM DUAL
;

SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) ��
	, TO_NUMBER(TO_CHAR(SYSDATE,'MM')) ��
	, TO_NUMBER(TO_CHAR(SYSDATE,'DD')) ��
	, TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) ��
	, TO_NUMBER(TO_CHAR(SYSDATE,'MI')) ��
	, TO_NUMBER(TO_CHAR(SYSDATE,'SS')) ��
FROM DUAL
;

SELECT SYSDATE+1
	, SYSDATE
	, SYSDATE -1
	, SYSDATE - SYSDATE -- ��ĥ�� ��ĥ ����
	, TO_DATE('20180722','YYYYMMDD') - TO_DATE('20180721','YYYYMMDD')
	, TO_DATE('20180722','YYYYMMDD') - SYSDATE
	, TO_CHAR(SYSDATE, 'HH24') ����ð�
	, TO_CHAR(SYSDATE+3/24, 'HH24') �ð�����
	, TO_CHAR(SYSDATE, 'MI') ���� ��
	, TO_CHAR(SYSDATE+1/24/60*10, 'MI') �� --�ð����� (10�� ���ϱ�)
    , TO_CHAR(SYSDATE, 'SS') ���� ��
	, TO_CHAR(SYSDATE+1/24/60/60*10, 'MI') �� --�ð�����
FROM DUAL
;

-- �߰�

-- ��¥�� TRUNC�ϱ� (��¥�� �ڸ���)


SELECT TO_CHAR(SYSDATE,'YYYYMMDD HH24MISS') A0
     , TO_CHAR(TRUNC(SYSDATE,'YYYY'),'YYYYMMDD HH24MISS') A1
     , TO_CHAR(TRUNC(SYSDATE,'MM'),'YYYYMMDD HH24MISS') A2
     , TO_CHAR(TRUNC(SYSDATE,'DD'),'YYYYMMDD HH24MISS') A3
     , TO_CHAR(TRUNC(SYSDATE,'HH24'),'YYYYMMDD HH24MISS') A4
     , TO_CHAR(TRUNC(SYSDATE,'MI'),'YYYYMMDD HH24MISS') A5
     , TO_CHAR(TRUNC(SYSDATE)+1-(1/(24*60*60)),'YYYYMMDD HH24MISS') A6 --(1/(24*60*60)) == 1��
FROM DUAL
;

-- ������ ���Ե� �����Ϻ��� �Ͽ��� ���ϱ�
SELECT TO_CHAR(SYSDATE-TO_CHAR(SYSDATE-1,'D')+1,'YYYYMMDD') as mon
     , TO_CHAR(SYSDATE-TO_CHAR(SYSDATE-1,'D')+7,'YYYYMMDD') as sun
     , TRUNC(SYSDATE-1,'DAY')+1
     , TRUNC(SYSDATE-1,'DAY')+7
     , TRUNC(SYSDATE,'DAY')
FROM DUAL
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P63

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') ����, 
       TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') ����,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') �Ͻ�,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD PM HH:MI:SS') PM,
       TO_CHAR(SYSDATE, 'YYYY. MON, DAY') ����
FROM   DUAL
;

SELECT TRIM(TO_CHAR(123456789123456789/1200,'$999,999,999,999,999,999,999,999,999.99')) ȯ���ݿ��޷�, 
       TO_CHAR(123456789.129,'L999,999,999.00') ��ȭ 
     , TO_CHAR(123456789,'999,999,999.00') ��ȭ 
     , TO_CHAR(89,'00000000') ��ȭ  -- '000000'�� ������ 0������ŭ�� �ڸ����μ� 89�� ǥ���Ѵ�. �� ������ 0 ������ŭ ǥ��
     , TRIM(TO_CHAR(89,'99999999')) ��ȭ  -- '9999999'�� ������ 9������ŭ�� �ڸ����μ� 89�� ǥ���Ѵ�. �� 9�������� ������ ������ŭ ǥ��
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

-- WITH�� : "���� �� ���������� ����� �ӽ� ���̺�"
-- WITH TEST AS : TEST��� �̸����� �ӽ� ���̺��� �����

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
; -- WITH���� ���� ������ ���ٰ� ���´�

WITH TEST(COL1, COL2, COL3) AS (
	SELECT NULL, 12, 13 FROM DUAL UNION ALL
	SELECT 21, NULL, 23 FROM DUAL UNION ALL
	SELECT 31, 32, NULL FROM DUAL
)
SELECT NVL(COL1,0), NVL(COL2,0), NVL(COL3,0)
FROM TEST
;


SELECT NULLIF('A','A'), NULLIF('A','B'), NVL(NULLIF('A','A'),'����')
FROM DUAL
;
-- ������ NULL ��ȯ
-- ���� ������ �տ� �� ��ȯ
-- ������ '����'�� ���ڿ� ���

WITH TEST(COL1, COL2, COL3) AS (
	SELECT NULL, 12, 13 FROM DUAL UNION ALL
	SELECT 21, NULL, 23 FROM DUAL UNION ALL
	SELECT 31, 32, NULL FROM DUAL
)
SELECT COALESCE(COL1, COL2, COL3)
FROM TEST
;
-- ó������ NULL�� �ƴ� �� ����ϱ�