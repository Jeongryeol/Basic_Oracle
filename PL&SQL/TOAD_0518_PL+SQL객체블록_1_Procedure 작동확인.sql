exec proc_test1('������');
--Turn Output On ��, ctrl+Enter Ű

exec proc_test1_p('������',20180518);


��Procedure ��ü �ڵ� ���� // ��ö�쾾 �亯 ( Toad �󿡼� Output ����ϱ����� ����������� �� )

declare
    v_name varchar2(20) ;
    n_age  varchar2(20) ;
begin
--���α׷��ڵ���(for��, if��, SELECT��, ������ ���� �ʱ�ȭ)
    proc_test1_p('������','20190104',v_name,n_age);
    dbms_output.put_line(v_name);
    dbms_output.put_line(n_age);
end;