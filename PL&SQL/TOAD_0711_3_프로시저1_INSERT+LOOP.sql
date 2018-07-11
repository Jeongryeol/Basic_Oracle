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
    (pstd_no     IN NUMBER
    ,pgrade      IN NUMBER
    ,pdepartment IN VARCHAR2
    ,psname      IN VARCHAR2
    ,msg        OUT VARCHAR2
    )
IS --�����
    ustd_no NUMBER(8) := 0; --ã�Ƴ� �л������� ��� ����
    result  NUMBER(1) := 0; --��� ��������� ����
    CURSOR cur_student IS   --Ŀ������
        SELECT std_no FROM student; --�л������� ã�Ƽ� ����
BEGIN --�����
    --�Է��� ������ ���̺� �Է��ϱ�
    INSERT INTO student(std_no, grade, department, sname)
         VALUES(pstd_no, pgrade, pdepartment, psname);
    OPEN cur_student; --Ŀ������
    LOOP --�ݺ��� ����
        FETCH cur_student INTO ustd_no; --Ŀ���� �����鼭 �л������� ����
        EXIT WHEN cur_student%NOTFOUND; --Ŀ���� ���� ���ǽ� �Է�
        IF --���ǹ� ���� 
            pstd_no = ustd_no THEN     --�Ķ���Ϳ� ���� ������ ������
            result :=  1;              --��������� �ʱ�ȭ�Ѵ�
            msg := '�̹� �����Ͱ� �ֽ��ϴ�.';
            dbms_output.put_Line(msg);
        ELSE
            result := -1;               --�׿ܿ��� �̷��� �ʱ�ȭ�Ѵ�
            msg := 'pass';
            dbms_output.put_Line(msg);
        END IF; --���ǹ� ��
    END LOOP; --�ݺ��� ��
    CLOSE cur_student; --Ŀ���ݱ�
END;


EDIT student;

--�׽�Ʈ
exec proc_studentINS(18000001,1,'��ǻ�Ͱ��а�','�׽���',:msg);

--Ȯ��
SELECT * FROM student;