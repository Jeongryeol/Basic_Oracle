[ �������� ]
�츮ȸ�翡�� �ٹ��ϴ� ����� �߿��� �μ���ȣ�� 30�� ������� �޿� ����� ���ϰ�
�� ��պ��� ���� �޴� ����� 10%�λ���, ���Թ޴� ����� 20%�λ��� �����Ͽ�
���̺� �ݿ��ϴ� ���ν����� �ۼ��Ͻÿ�.
    -> ���ν��� �̸� : proc_emp_update_salary();

SELECT
    t_e.empno, t_e.ename, t_e.deptno, t_e.sal
  FROM dept t_d, emp t_e
 WHERE t_d.deptno = 30 AND t_d.deptno = t_e.deptno
 
SELECT
    TO_CHAR(AVG(t_e.sal),'999,999.99')
  FROM dept t_d, emp t_e
 WHERE t_d.deptno = 30 AND t_d.deptno = t_e.deptno

CREATE OR REPLACE PROCEDURE proc_emp_update_salary(p_deptno IN NUMBER, msg OUT VARCHAR2)
IS
    t_emp emp%rowtype;
    t_dept dept%rowtype;
    n_rate number(3,1):=0;
    n_avgsal number(7,2) :=0;
    cursor c_emps--Ŀ���߰� �� SELECT���� ���� (INTO ���� ����)
    is
        SELECT empno, ename, deptno, sal
          FROM emp
         WHERE deptno = p_deptno;
BEGIN
    dbms_output.put_line('���ǿ� ���� �޿��λ��� CURSOR�� ��������ϱ�');
    SELECT AVG(sal) INTO n_avgsal
      FROM emp
     WHERE deptno = p_deptno;
    
    OPEN c_emps;
    LOOP
        fetch c_emps INTO t_emp.empno, t_emp.ename,t_emp.deptno,t_emp.sal;
        exit when c_emps%notfound;
        dbms_output.put_line(t_emp.empno||', '||t_emp.ename||', '||t_emp.deptno||', '||t_emp.sal);
        IF (t_emp.sal > n_avgsal) THEN
            n_rate := 1.1;
        ELSE
            n_rate := 1.2;
        END IF;
        msg := msg||t_emp.ename||'���� '||n_rate||'�λ���� �޿��� '||t_emp.sal*n_rate||'�Դϴ�.'||CHR(13);
        dbms_output.put_line(msg);
    END LOOP;
    
     --4.������Ʈ�� �߰��ϱ�
    UPDATE emp SET sal=t_emp.sal*n_rate
     WHERE empno=t_emp.empno--����� �����ȣ�� �ش��ϴ� ����鸸 �����Ѵ�
     --dept�� �������� �Ŵ� ��쵵 ����� ���� ��������, �߰��� �ٸ� ������ �ɷ��ִ� ��� �ùٸ��� ��ġ���� ���� �� �ִ�.
    
    --commit;--������Ʈ�� ������ DB������ �����ϰ�ʹ�.
    IF c_emps%found THEN
        dbms_output.put_line('<<<��ȸ�������>>>');
    END IF;
    IF c_emps%rowcount = 1 THEN
        dbms_output.put_line('<<<��ȸ���>>>');
        dbms_output.put_line('���'||t_emp.empno);
        dbms_output.put_line('����'||t_emp.ename);
    ELSIF c_emps%rowcount = 0 THEN
        dbms_output.put_line('<<<����>>>');
        dbms_output.put_line('<<<��ȸ�� �����Ͱ� �����ϴ�.>>>');
    ELSIF c_emps%rowcount > 1 THEN
        dbms_output.put_line('<<<����>>>');
        dbms_output.put_line('<<<��ȸ�� �����Ͱ� �ʹ� �����ϴ�.>>>');
    END IF;
    
    CLOSE c_emps;
    
END;

exec proc_emp_update_salary(30,:msg);

rollback;

--[  ��  ��  ��  ��  ]--------------------------------------------------------------------
--Ǯ�̼���
-- 1) �������� - ����� ���� ����, �λ���� ���� ����
-- 2) Ŀ������ - CURSOR IS SELECT empno, ename, sal FROM emp WHERE dept = �Ķ���Ͱ�(�μ���ȣ)
--          ��� ����� ���ϴ°��̴���, ��������� �λ���� �ٸ��⶧����
--          UPDATE������ sal�� ������ �����ϴ� ������ �����ȣ�� ��. �׷��Ƿ� 
-- 3) ��ձ��ϱ� - 1�� : ����� ���� ������ avg -> �׷��Լ� -> SELECT ... INTO ...
-- 4) Ŀ�� OPEN
-- 5) Ŀ���� ����� �����̹Ƿ� LOOP
-- 6) fetch : Ŀ���̵��� ������ ( �����ȣ, �̸�, �޿� ���� ) �����Ͽ� �������
-- 7) �޿��װ� ��ձ޿��� �� : ����? ����? 
-- 8) UPDATE
---------------------------------------------------------------------------------------