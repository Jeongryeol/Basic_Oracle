1부터 10까지 합을 구하는 프로시저 만들기

CREATE OR REPLACE PROCEDURE proc_hap(p_end number)
IS
    n_i   number(5)  := 0;
    n_hap number(10) := 0;
BEGIN
    FOR n_i IN 1..10 LOOP
        n_hap := n_i + n_hap;
    END LOOP;
    dbms_output.put_line(n_hap);
    n_hap := 0;
    FOR n_i IN 1..10 LOOP
        IF MOD(n_i,2)=0 THEN
            n_hap := n_i + n_hap;
        END IF;
    END LOOP;
    dbms_output.put_line(n_hap);
END;


exec proc_hap (1);