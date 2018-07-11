--������ ���ν����� ����
--����ڰ� �Է��� ������ ���̺� �����ϴ� �� ó���ϱ�

--result�� 1�̸� ���̺� ���� ������ ����. ( 0�� ���� ������ ��. )

--result2�� ����ڰ� �Է��� �й�(pstd_no)���� ���̺� ������ �й�(ustd_no)�� �� ���� ��� ����
--result2�� 0�̸� �� ���� ���ٴ� ���̹Ƿ� ( ��, 2-2�� 0�̵� )
--IF������ �б��ϰ� LOOP���� �������� �� �����.

CREATE OR REPLACE PROCEDURE proc_studentINS2
    (pstd_no     IN NUMBER
    ,pgrade      IN NUMBER
    ,pdepartment IN VARCHAR2
    ,psname      IN VARCHAR2
    ,result     OUT NUMBER
    )
IS --�����
    ustd_no NUMBER(8) := 0;
    result2 NUMBER(1) := 0;
    CURSOR cur_student IS
        SELECT std_no FROM student;
BEGIN --�����
    INSERT INTO student(std_no, grade, department, sname)
         VALUES(pstd_no, pgrade, pdepartment, psname);
    commit; --���ε� 1�� �ο츦 Ŀ��ó����. DB�ݿ�.
    OPEN cur_student; --Ŀ���� ������.
    LOOP --�ݺ��� ����
        FETCH cur_student INTO ustd_no; --Ŀ���� FETCH�Ͽ� ustd_no�� ������ ����
        EXIT WHEN cur_student%NOTFOUND; --Ŀ�� �� ���ȴ�?
        result2 := SIGN(pstd_no - ustd_no);--����ڰ� �Է��� �й��� DB���� ������ �й��� ��
        IF --���ǹ� ����
            result2 = 0 THEN
            result := 1;
            EXIT WHEN result2 = 1;  --PK�̸��� ���� ���� ������ �� ����
        ELSE
            result2 := 9; --�ƴϸ� 9�� ����϶� (�ǹ̾��� ����) 
        END IF; --���ǹ� ��
    END LOOP; --�ݺ��� ��
    dbms_output.put_Line('result 2: '||result2);--�����׽�Ʈ ��¿�
    CLOSE cur_student; --Ŀ���� �ݾ���.
END;

exec proc_studentINS2(18020118, 4, '��ǻ�Ͱ��а�', '�̼���', :result2);

SELECT * FROM student -- Ȯ��


