/*
    [������������]
    1) ��ǻ�Ͱ��а� ���л��� �����ϴ� ���̺��� �����Ͻÿ�.
        ��������� : �г�����, �̸�, �������� 3���̻� �߰� (�й��� PK)
    
    2) ��ȸü���а� ���л��� �����ϴ� ���Ը��� �����Ͻÿ�.
        ��������� : �г�����, �̸�, �������� 3���̻� �߰� (�й��� PK)
    
    3) �л������� �����ϴ� ���̺��� �����Ͻÿ�.
        ���ʼ��Է»��� : �г�����, �̸�, �а�����, �й�
    
    4) �л� ���̺��� �̹� �߰���� ������ ó���ϴ� ���ν����� �ۼ��Ͻÿ�.
        ����ó������� ���� ��ǻ�Ͱ��а� ���̺�� ��ȸü���а� ���̺� �ݿ��ؾ� �մϴ�.
        ���ν����� SELECT�� UPDATE�� �����ϵ��� �ϱ� 
    
    5) �� ���ν�����  ����Ͼ� �ϴ��� �� ������ ���Ͽ� ������ ���� �������� �ۼ��Ͻÿ�.
*/

--�л������� �����ϴ� ���ν���
--  �л����̺��� �÷��� 4���̹Ƿ� �Ķ���͵� �л������� �޾ƿ´�.
--  ���������� �߰��Ǿ��� ��, �� ����� ���� ������ �����Ѵ�. ( result )
CREATE OR REPLACE PROCEDURE proc_studentINS
(pstd_no IN NUMBER, pgrade IN NUMBER, pdepartment IN VARCHAR2, psname IN VARCHAR)--,msg OUT VARCHAR2)
IS  --�����
    ustd_no NUMBER(8) := 0;     --�л������� ����
    result NUMBER(1) := 0;
    msg VARCHAR(50) := null;
    CURSOR cur_student IS       --Ŀ������
    SELECT std_no FROM student; --�л������� ã�Ƽ� ����
BEGIN
    --�����
    INSERT INTO student(std_no, grade, department, sname)
         VALUES(pstd_no, pgrade, pdepartment, psname);
    OPEN cur_student;   --Ŀ������
    LOOP
        FETCH cur_student INTO ustd_no; --Ŀ���� ������ �л������� ���
        EXIT WHEN cur_student%NOTFOUND;
        IF  pstd_no = ustd_no THEN      --�Ķ���Ϳ� Ŀ���� �л������� ����?
            result := 1;                --�������
            msg := '�̹� �����Ͱ� �ֽ��ϴ�.';
            dbms_output.put_Line(msg);
        ELSE
            result :=-1;
            msg := 'PASS';
            dbms_output.put_Line(msg);
        END IF;
    END LOOP;
    CLOSE cur_student;  --Ŀ���ݱ�
END;

exec proc_studentINS(18020904,3,'��ȸü���а�','�׽���');

SELECT * FROM student;


--������
--�� ���ν����� ������ ����ڰ� �Է��� ������ ���̺� �����ϴ� ���� ó���ϴ� ��.
--result�� 1�̸� ���̺� ���� ������ ����. ( 0�� ���� ������ ��.)
--result2�� ����ڰ� �Է��� �й�(pstd_no)���� ���̺� ����� �й�(ustd_no)�� ������ ���� ������.
--result2�� 0�̸� �� ���� ���ٴ� ���̹Ƿ�, ( ��, 2-2�� 0���� )
--IF������ �б��ϰ� LOOP���� �������� �� �����.
CREATE OR REPLACE PROCEDURE proc_studentINS2
(pstd_no IN number, pgrade IN number, pdepartment IN varchar2, psname IN varchar2
, result OUT number)
IS
    ustd_no number(8):=0;
    result2 number(1):=0;
    cursor cur_student is
    SELECT std_no FROM student;
BEGIN
    INSERT INTO student(std_no, grade, department, sname)
    VALUES(pstd_no,pgrade,pdepartment,psname);
    commit;--���Ե� 1�� �ο츦 Ŀ�� ó����. �׷��� DB���̺� �ݿ���.
    OPEN cur_student;--Ŀ���� ������
    LOOP--�ݺ��� ����
        fetch cur_student INTO ustd_no;--Ŀ���� OPEN�߰� FETCH������. FETCH�� ������ ustd_no�� ����
        EXIT WHEN cur_student%notfound;--Ŀ���� �� ���Ҷߤ�
        result2 := SIGN(pstd_no-ustd_no);--result������ ����ڰ� �Է��� �й����� DB���� ������ �й��� ���� �� ����� ����
        IF result2=0 THEN -- �μ��� ���ٴ� ���� �ǹ��ϹǷ� result������ 1 ������
            result := 1; 
            EXIT WHEN result2=1;--PK�̹Ƿ� ���� ���� ������ �� �����Ƿ� �ݺ����� Ż����.
        ELSE
        result2 := -1;-- �����Ѵٸ� -1�� 
        END IF;
    END LOOP;--�ݺ��� 
    dbms_output.put_line('result2:'||result2);--�����׽�Ʈ �Ҷ� ����غ�.
    close cur_student;
END;

exec proc_studentINS2(18020118, 4, '��ǻ�Ͱ��а�', '�̼���', :result2);

SELECT * FROM student

EDIT COMPUTER_ENGINEERING 



--������ �հ賻�� �ۼ��ϴ� ���ν����� �ۼ��غ���
CREATE OR REPLACE PROCEDURE proc_studentACC(pstd_no IN NUMBER, msg OUT VARCHAR2)
IS
    rtot NUMBER(10,2) := 0;
    rgrade NUMBER(1) := 0;
    v_comp computer_engineering%rowtype;--�÷����� �״�� ������ ���� �� �ִ�.
BEGIN
    SELECT ce.java, ce.oracle, ce.html, stu.grade
      INTO v_comp.java, v_comp.oracle, v_comp.html, rgrade
      FROM computer_engineering ce, student stu
     WHERE ce.std_no = pstd_no
       AND ce.std_no = stu.std_no;
    rtot := v_comp.java + v_comp.oracle + v_comp.html;
    --msg := tot;--�����׽�Ʈ
    IF rtot > 0 THEN
        UPDATE computer_engineering SET tot = rtot, grade = rgrade
         WHERE std_no = pstd_no;
        COMMIT;
    END IF;
    SELECT sname, tot INTO v_comp.sname, v_comp.tot
      FROM computer_engineering
     WHERE std_no = pstd_no;
    msg := v_comp.sname||' �л��� �İ��� '||rgrade||'�г��̰� ������ '||v_comp.tot||'�Դϴ�.';
END;


exec proc_studentACC(18020118,:msg);



--Ŀ�� ���� ��޿��� ( �� �ּ� )
CREATE OR REPLACE PROCEDURE proc_studentACC2(temp IN VARCHAR2)
IS
    --�����
    rtot NUMBER(10,2):=0;
    v_comp computer_engineering%rowtype;
    CURSOR cur_comp IS
    SELECT ce.java, ce.oracle, ce.html, std.std_no, std.grade
      FROM computer_engineering ce, student std
     WHERE ce.std_no = std.std_no;
BEGIN
    --�����
    OPEN cur_comp; --Ŀ�� ����
    LOOP
        FETCH cur_comp INTO v_comp.java, v_comp.oracle
                           ,v_comp.html, v_comp.std_no, v_comp.grade;
        EXIT WHEN cur_comp%notfound;  
    
        rtot :=v_comp.java+v_comp.oracle+v_comp.html;
        dbms_output.put_line(rtot||', '||v_comp.std_no);
    
        UPDATE computer_engineering 
           SET tot   = rtot
              ,grade = v_comp.grade      
         WHERE std_no = v_comp.std_no;
         
        COMMIT;
        
    END LOOP;
    
    CLOSE cur_comp;
    
END;