--�� ������ ������  �հ賻�� �Է��ϴ�  ���ν����� �ۼ��غ���

CREATE OR REPLACE PROCEDURE proc_studentACC
    (pstd_no IN NUMBER
    ,msg    OUT VARCHAR2
    )
IS --�����
    rtot    NUMBER(10,2) := 0; --������ �հ踦 ������ ����
    rgrade  NUMBER(1) := 0;    --�г��� ������ ����
    v_comp computer_engineering%rowtype;--�÷����� �״�� ������ ���� �� �ִ�.
BEGIN --�����
    --equal join���� SELECT�� ��ȸ
    SELECT ce.java, ce.oracle, ce.html, stu.grade
      INTO v_comp.java, v_comp.oracle, v_comp.html, rgrade
      FROM computer_engineering ce, student stu
     WHERE ce.std_no = pstd_no
       AND ce.std_no = stu.std_no;
    
    --��ȸ�� ������ �հ谪 ���ϰ� �����ϱ�
    rtot := v_comp.java + v_comp.oracle + v_comp.html;
    --msg := tot;--�����׽�Ʈ
    
    IF --���ǹ� ����
        rtot > 0 THEN --�հ谪�� �ִٸ�
        UPDATE computer_engineering SET tot = rtot, grade = rgrade
         WHERE std_no = pstd_no;
        COMMIT; --�����ϰ� Ŀ��
    END IF; --���ǹ� ��
    
    --Ŀ������ ����� ���̺�κ��� �̸��� �հ����� �ٽ� ��ȸ�ϰ� rowtype������ ��� 
    SELECT sname, tot INTO v_comp.sname, v_comp.tot
      FROM computer_engineering
     WHERE std_no = pstd_no;
    
    --�޽����� ���
    msg := v_comp.sname||' �л��� �İ��� '||
           rgrade||'�г��̰� ������ '||
           v_comp.tot||'�Դϴ�.';
END;


exec proc_studentACC(18020118,:msg);