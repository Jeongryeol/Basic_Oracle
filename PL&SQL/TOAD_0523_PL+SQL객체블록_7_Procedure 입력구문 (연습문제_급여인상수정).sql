[ �������� ]
    �츮ȸ�翡 �ٹ��ϴ� ����߿��� �����ȣ�� 7566�� ����� �޿��� �λ��ϰ��� �Ѵ�.
    �λ����� �� ����� �ٹ��ϴ� �μ��� ��ձ޿����� ���� �ް� ������ 10%�λ��� �����ϰ�
    ���� �ް� ������ 20%�λ��� ������ �޿����� �����ϴ� ���ν����� ��������.

    ���ν��� �̸� : proc_emp_sal_update.sql


EDIT emp

SELECT deptno FROM emp WHERE empno = 7566

SELECT deptno, avg(sal) FROM emp
 WHERE deptno=(SELECT deptno FROM emp WHERE empno = 7566)
 GROUP BY deptno

SELECT empno,ename,DECODE(SIGN(sal-(SELECT AVG(sal) FROM emp)),1,'10%�λ�',-1,'20%�λ�') AS "�λ��"
  FROM emp
 WHERE empno = 7566
 
CREATE OR REPLACE PROCEDURE proc_emp_sal_update(v_empno IN NUMBER)
IS
    v_deptno NUMBER(10);
    v_avgsal NUMBER(10);
    v_sal    NUMBER(10);
BEGIN   
    SELECT avg(sal) INTO v_avgsal FROM emp
     WHERE deptno=(SELECT deptno FROM emp WHERE empno = v_empno);
    SELECT sal INTO v_sal FROM emp WHERE empno=v_empno;
    IF( v_sal>v_avgsal )    THEN sal := v_sal*1.1;
    ELSIF( v_sal<v_avgsal ) THEN sal := v_sal*1.2;
    END IF;
    dbms_output.put_line(v_empno||'�� �λ�� �����ݾ��� '||v_sal);
END;



------[ �� �� �� �� ]--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE proc_emp_sal_update(p_empno IN NUMBER, msg OUT VARCHAR2)
IS
    v_ename VARCHAR2(30);
    n_sal NUMBER(7,2);
    n_avgsal NUMBER(9,2);
    n_rate NUMBER(3,1);
BEGIN   
    --1.�Է��� �����ȣ�� �������� ���̺�κ��� ������� ���� �о����
    SELECT ename, sal INTO v_ename, n_sal FROM emp
     WHERE empno = p_empno;
    --2.�ش�μ��� ��� �޿��� ���ϱ�
    SELECT AVG(sal) INTO n_avgsal FROM emp
     WHERE deptno = (SELECT deptno FROM emp WHERE empno = p_empno);
    --3.��ձ޿��� �ش����Ǳ޿��� ����D��
    IF (n_sal > n_avgsal) THEN
        n_rate := 1.1;
    ELSE
        n_rate := 1.2;
    END IF;
    --4.������Ʈ�� �߰��ϱ�
    UPDATE emp SET sal=sal*n_rate
     WHERE empno=p_empno;
    commit;--������Ʈ�� ������ DB������ �����ϰ�ʹ�.
    msg := v_ename||'���� '||n_rate||'�λ���� �޿��� '||n_sal*n_rate||'�Դϴ�.';
END;

--5.�׽�Ʈ�ϱ�
exec proc_emp_sal_update(7566);

SELECT * FROM emp WHERE empno = 7566;

rollback;