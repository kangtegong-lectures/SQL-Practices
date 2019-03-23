select * from dba_users;

DESC SCOTT.EMP;
-- 테이블 구조/데이터 타입 보기
-- NUMBER(4) 네자리숫자
--VARCHAR2(10) 문자형 10자리까지 넣을 수 있음
--NUMBER(7,2) 정수형 5자리 소수형 2자리

SELECT *
FROM EMP
WHERE EMPNO=1001
;

INSERT INTO EMP(EMPNO, ENAME, SAL)
VALUES (1001, '홍길동', 2000)
;

ROLLBACK;

-- 전체 컬럼에 데이터 입력

INSERT INTO EMP
VALUES (1001, '홍길동', 'CLERK', 7902, TO_DATE('20180101', 'YYMMDD'), 2000, '', NULL)
;
-- ''이것도 널 NULL 이것도 널

SELECT * FROM EMP1;

INSERT INTO EMP(EMPNO, ENAME, SAL)
SELECT EMPNO,ENAME,SAL FROM EMP1
;

INSERT INTO EMP
SELECT * FROM EMP1
;
-- 이걸 여러번 삽입하면 여러번 삽입되는데
-- 이래버리면 PK가 겹칠수가 있음 물론 여기선 PK값 지정 안하긴 했다만..
-- 그래서 겹치는 PK가 있다면 "무결성 제약조건에 위배된다는 ORA-00001 오류가 뜸


SELECT *
FROM EMP
WHERE EMPNO =7369
;

UPDATE EMP 
SET ENAME ='김이박',
    JOB = 'SALESMAN'
WHERE EMPNO = 7369
;

--아래 조회할 때 문자는 왼쪽정렬 숫자는 오른쪽 정렬

DELETE FROM EMP
WHERE EMPNO = 7369
;

DELETE FROM EMP
WHERE EMPNO||'' = 7369
;
-- || 문자열 합치는 문법, '' = 문자형 NULL 
-- 결국 EMPNO가 문자열로 바뀜
-- 때문에 전체 테이블을 풀 스캔하게 된다
-- (OPTIONS = FULL)
-- 좌변을 가공하지 말 것!


SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE EMPNO = 7369
;

INSERT INTO EMP 
SELECT 1001, '홍길동', 'CLERK', 7902, TO_DATE('20180101', 'YYMMDD'), 2000, '', NULL
FROM DUAL 
;

SELECT 1 AS A, 2 AS B, 3 C, AA.* -- AA테이블의 모든 것을 갖고와라
--컬럼명에 별명설정, AS생략가능
-- 그 별명은 ORDER BY 정렬리스트에서만 줄 수 있음
FROM DUAL AA --이렇게 별명줄 수 있음
;
