���ڿ��� �Ϻθ� �����ִ� �Լ�
SUBSTR(char,n);   --char������ n��° �ڸ����� ���ڿ� ������ �����ش�.
SUBSTR(char,n,m); --char������ n��° �縮���� m��° �ڸ����� ���ڿ��� �����ش�.
**B �� ���̸� ����Ʈ�� ����Ͽ� ����Ѵ�.

SELECT substr('ORACLE JAVA',1,3)--���ڸ� �߶� ǥ����
      ,substr('ORACLE JAVA',1,2)
      ,substr('ORACLE JAVA',0,2)
      ,substr('ORACLE JAVA',3)
      ,substr('ORACLE JAVA',5)
      ,substrb('�̼���',1,3)
      ,substrb('�̼���',1,2)
      ,substrb('�̼���',1,1)
  FROM dual;
  

���ڿ��� ���̸� �����ִ� �Լ�
LENGTH(char) --char������ ���̸� ������ش�.
LENGTHB(char) --char���ڸ� ����Ʈ�� ��ȯ�Ͽ� ���̸� ������ش�. (�ѱ��� 2����Ʈ, ������ 1����Ʈ)

SELECT length('����Ŭ Project'), lengthb('����Ŭ Project')
  FROM dual; 
  
  


[��������] ������ �̸��� �Է¹޾Ƽ� ���� �达�� �����Ŵ��� �达�Դϴ�. ���...
        �����Ŵ��� �̾�, ȫ��, �ھ��� �ƴմϴ�.
        
CREATE OR REPLACE PROCEDURE proc_test4(p_name IN varchar2, msg OUT varchar2)
IS
    v_tmp varchar2(50);
BEGIN
    v_tmp := substr(p_name,1,1);--�̸����� ù���� ���� �����Ͽ� v_tmp�ʱ�ȭ��Ŵ[:=]�� ����Ŭ������ ���Կ�����
    dbms_output.put_line(v_tmp);--���
    IF '��'=v_tmp THEN
        msg:=p_name||'���� �达�Դϴ�.';
    ELSIF '��'=v_tmp THEN
        msg:=p_name||'���� �̾��Դϴ�.';
    ELSIF '��'=v_tmp THEN
        msg:=p_name||'���� �ھ��Դϴ�.';
    ELSE
        msg:=p_name||'���� �达, �̾�,�ھ��� �ƴմϴ�.';
    END IF;--��쿡���� msg�� �ʱ�ȭ
    dbms_output.put_line(msg);--���
END;


exec proc_test4('ȫ��ǥ',:msg);
