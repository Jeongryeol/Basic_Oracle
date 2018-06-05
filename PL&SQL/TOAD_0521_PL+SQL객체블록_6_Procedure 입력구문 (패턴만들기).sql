CREATE OR REPLACE PROCEDURE proc_as(p_num IN NUMBER)
is
    nui number(10) := 0;
    nuj number(10) := 0;
    msg varchar2(50);
BEGIN
    FOR nui in 1..10 LOOP
        msg := '';
        FOR nuj in nui..10 LOOP
            msg := '*'||msg;
       END LOOP;
       dbms_output.put_line(LPAD(MSG,10,' '));
    END LOOP;
END;

exec proc_as (1);