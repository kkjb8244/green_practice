-- 옥스포드 시에 거주하는 직원의 이름을 오름차순으로 출력.
SELECT e.first_name || ' ' || e.last_name "이름"
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.city = 'Oxford'
ORDER BY first_name ASC;

-- 퇴직일과 관계없이 2002년 1월 1일 이전에 근무하기 시작한 사람들의 아이디와 이름 출력
SELECT DISTINCT e.employee_id,
    (e.first_name || ' ' || e.last_name) AS "이름"
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id
AND j.start_date < '2002/01/01';

-- 시애틀에 사는 모든 사람들의 이름, 부서명, 지역id 및 도시명 조회
SELECT last_name,department_name, l.location_id,city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.city = 'Seattle';

-- 자신의 관리자보다 먼저 고용된 사원들의 이름 및 고용일 조회
SELECT e.last_name, e.employee_id, e.hire_date
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
AND e.hire_date < m.hire_date
ORDER BY e.last_name;

-- 부서명, 위치id, 각 부서별 총 사원수, 각 부서별 평균연봉 조회 (평균연봉은 소수점 2자리까지)
SELECT department_name, location_id,
COUNT (employee_id), ROUND(AVG(salary), 2) "평균 연봉"
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY department_name, location_id
ORDER BY location_id;

-- 부서번호 30이거나 90인 부서의 모든 직무 아이디 및 부서 아이디를 중복 배제하여 직무 아이디순으로 오름차순 정렬 조회
SELECT DISTINCT job_id, d.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_id IN (30,90)
ORDER BY job_id;

-- 부서, 회원, 지역 테이블에서 아래와 같이 사원번호, 이름, 직무 아이디, 부서 아이디, 부서명, 지역을 활용하여 조회
SELECT e.employee_id, e.first_name || ' ' || e.last_name "이름",
e.job_id,
e.department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d, employees e, locations l
WHERE d.department_id = e.department_id
ORDER BY d.department_id;

SELECT e.employee_id,
e.first_name || ' ' || e.last_name "이름",
e.job_id,
e.department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d INNER JOIN employees e
ON d.department_id = e.department_id
INNER JOIN locations l 
ON d.location_id = l.location_id
ORDER BY d.department_id;

SELECT e.employee_id,
e.first_name || ' ' || e.last_name "이름",
e.job_id,
e.department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d JOIN employees e
ON d.department_id = e.department_id
JOIN locations l
ON d.location_id = l.location_id
ORDER BY d.department_id;

SELECT e.employee_id,
e.first_name || ' ' || e.last_name "이름",
e.job_id,
department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d JOIN employees e
USING(department_id)
JOIN locations l
USING(location_id)
ORDER BY department_id;

-- 위의 검색 조건에 직무 아이디가 IT_PROG인 조건을 추가하여 조인으로 검색
SELECT employee_id,
first_name || ' ' || last_name "이름",
job_id,
e.department_id,
department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d, employees e, locations l
WHERE d.department_id = e.department_id
AND e.job_id = 'IT_PROG'
ORDER BY d.department_id;

SELECT e.employee_id,
e.first_name || ' ' || e.last_name "이름",
e.job_id,
e.department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d, employees e, locations l
WHERE d.department_id = e.department_id
AND d.location_id = l.location_id
AND e.job_id = 'IT_PROG'
ORDER BY d.department_id;

SELECT e.employee_id,
e.first_name || ' ' || e.last_name "이름",
e.job_id,
e.department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d INNER JOIN employees e
ON d.department_id = e.department_id and e.job_id = 'IT_PROG'
INNER JOIN locations l
ON d.location_id = l.location_id and e.job_id = 'IT_PROG'
ORDER BY d.department_id;

SELECT e.employee_id,
e.first_name || ' ' || e.last_name "이름",
e.job_id,
e.department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d INNER JOIN employees e
ON d.department_id = e.department_id
INNER JOIN locations l
ON d.location_id = l.location_id
WHERE e.job_id = 'IT_PROG'
ORDER BY d.department_id;

SELECT e.employee_id,
e.first_name || ' ' || e.last_name "이름",
e.job_id,
e.department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d JOIN employees e
ON d.department_id = e.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE e.job_id = 'IT_PROG'
ORDER BY d.department_id;

SELECT e.employee_id,
e.first_name || ' ' || e.last_name "이름",
e.job_id,
department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d JOIN employees e
USING(department_id)
JOIN locations l
USING(location_id)
WHERE e.job_id = 'IT_PROG'
ORDER BY department_id;

-- 문법은 맞지만 Natural Join의 결과는 기존과 다름
SELECT e.employee_id,
e.first_name || ' ' || e.last_name "이름",
e.job_id,
department_id,
d.department_name,
l.city || ' ' || l.state_province "지역"
FROM departments d NATURAL JOIN employees e
NATURAL JOIN locations l
WHERE e.job_id = 'IT_PROG'
ORDER BY department_id;