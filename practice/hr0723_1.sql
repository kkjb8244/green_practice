-- 1.라스트네임이 Davies인 직원보다 늦게 고용된 사원들의 라스트네임 및 hire_date 조회
SELECT last_name, hire_date
FROM employees
WHERE hire_date >= (SELECT hire_date
                    FROM employees
                    WHERE last_name = 'Davies'
                    )
ORDER BY hire_date;

-- 2.동일한 직업을 가진 사원들의 직무 아이디와 총 인원수 조회
SELECT job_id, COUNT(employee_id)
FROM employees
GROUP BY job_id
ORDER BY job_id;

-- 3.매니저로 근무하는 사원들의 총 수를 조회
SELECT COUNT(employee_id)
FROM employees
WHERE employee_id IN (SELECT DISTINCT manager_id
                      FROM employees
                      WHERE manager_id IS NOT NULL
                      );
                      
SELECT COUNT(DISTINCT manager_id)
FROM employees;

-- 4. 사내 최대 급여와 최저 급여의 차이를 구하여 조회
SELECT (MAX(salary) - MIN(salary) || '달러') "최고/최저 급여차액"
FROM employees;

-- 5. 매니저의 사번과 그 관리자 직속 사원들 중 최저 급여를 받는 사원의 급여를 조건에 맞게 조회
-- 조건1. 매니저가 없는 사람들은 제외
-- 조건2. 최저 급여가 6000달러 미만인 경우 제외
-- 조건3. 최저 급여 기준으로 역순으로 출력
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >= 6000
ORDER BY MIN(salary) DESC;

SELECT d.department_name 부서명, COUNT(e.employee_id) 인원수
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND TO_CHAR(hire_date, 'YYYY') <= 2004
GROUP BY d.department_name;

CREATE TABLE job_grades
(
gradel_level varchar2(3) CONSTRAINT job_gra_level_pk PRIMARY KEY,
lowest_sal NUMBER,
highest_sal NUMBER
);

INSERT INTO job_grades VALUES ('A', 1000, 2999);
INSERT INTO job_grades VALUES ('B', 3000,5999);
INSERT INTO job_grades VALUES ('C', 6000, 9999);
INSERT INTO job_grades VALUES ('D', 10000, 14999);
INSERT INTO job_grades VALUES ('E', 15000, 24999);
INSERT INTO job_grades VALUES ('F', 25000, 40000);

COMMIT;