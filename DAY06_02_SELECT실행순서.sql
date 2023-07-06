/*
    SELECT 문의 실행 순서
    
    SELECT 칼럼          5
      FROM 테이블        1
     WHERE 조건          2
     GROUP BY 그룹       3
     HAVING 그룹조건     4
     ORDER BY 정렬       6
*/

-- 사원 테이블에서 부서별 연봉 평균을 조회하시오.
SELECT DEPARTMENT_ID AS DEPT_ID
     , ROUND(AVG(SALARY), 2)
  FROM EMPLOYEES E      -- 테이블의 별명은 공백으로
 GROUP BY E.DEPARTMENT_ID;      -- 'GROUP BY DEPT_ID'는 실행 순서때문에 실행X
 
-- 사원 테이블에서 부서별 연봉 평균과 사원수를 조회하시오. 부서별 사원수가 2명 이상인 부서만 조회하시오.
SELECT DEPARTMENT_ID
     , ROUND(AVG(SALARY), 2)
     , COUNT(*)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 2;
-- SELECT 'COUNT(*) AS 부서별사원수', 'HAVING 부서별사원수 >= 2'는 실행 순서때문에 실행X

SELECT DEPARTMENT_ID AS DEPT_ID
     , ROUND(AVG(SALARY), 2)
     , COUNT(*) AS 부서별사원수
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 2
 ORDER BY DEPT_ID;       -- 실행됨(실행순서O)
