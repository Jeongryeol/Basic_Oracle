--Ŀ�� ���뺻

CREATE OR REPLACE PROCEDURE proc_studentACC2(temp IN VARCHAR2)
IS
    --�����
    rtot NUMBER(10,2):=0;--������ ���� ���� ����
    v_comp computer_engineering%rowtype;
    --Ŀ���� ������
    CURSOR cur_comp IS --Ŀ�� fetch�� �÷����� �����.
    SELECT ce.java, ce.oracle, ce.html, std.std_no, std.grade
      FROM computer_engineering ce, student std
      --������ ����Ͽ� update�� �ʿ��� �й��� �г� ���� �߰���.
      --�г������� student�� �����Ƿ� ���� ���̺� �ִ� �й����� equal join��.
     WHERE ce.std_no = std.std_no;
      --������ 2�� �̻��϶� where���� ������ īŸ�þ��� ���� �ɸ�
      --�׷��� �����Ⱚ ���Ե�.(equals join�� ���ʿ� �ִ� ������ ��µ�.)
BEGIN
    --�����
    OPEN cur_comp; --Ŀ�� ����
    LOOP
    --select..into ��� fetch..into�� �����
        --������ : �ݺ��� �ȿ��� ���� n���� ��ȸ�ؼ� ���� ���� �� ����.
        --��ȭ �¼��� �����Ѵٵ簡? ȯ�ڵ鿡 ���� ������ ���� �˻縦 �Ѵٵ簡?
        --�츮ȸ�� ���� ��ü�� ���� �޿��� �����Ѵٵ簡? �� ��.....
        --fetch�� Ŀ���̸� �׸��� into �ڿ� ���� �߰��� ��.........
        FETCH cur_comp INTO v_comp.java
                           ,v_comp.oracle
                           ,v_comp.html
                           ,v_comp.std_no
                           ,v_comp.grade;
    --���� ���� ���� �ڵ� ������ �߰��Ұ�.-������ �ٿ�� �� ����.
    --��� �ٿ��� �Ǵ°� �ƴ����� �ڿ��� ��� ���̸� memory overflow��������.
        EXIT WHEN cur_comp%notfound;  
    
    --������ ���� �� ���� �����. ���ϱ� �����ڸ� ����Ͽ� ���� ������ ���� ó��
        rtot :=v_comp.java+v_comp.oracle+v_comp.html;
        dbms_output.put_line(rtot||', '||v_comp.std_no);--��� 
    
    --n�ǿ� ���� �����ؾ� �ϹǷ� update���� �ݵ�� �ݺ��� �ȿ� �ۼ��ؾ� ��.
        UPDATE computer_engineering 
           SET tot   = rtot
              ,grade = v_comp.grade      
    --������ ����� �ѻ��, �ѻ���� ���� ó���̹Ƿ� �ݵ�� ������ �߰��� ��.
         WHERE std_no = v_comp.std_no;
         
        COMMIT;--������ �� Ŀ��ó�� �� ��.
        
    END LOOP;
    
    CLOSE cur_comp;--Ŀ�� �ݱ�
    
END;



