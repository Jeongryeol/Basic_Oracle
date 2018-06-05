--������ �纻�� ����ȭ�ϱ� ���� Ʈ���� ����
CREATE OR REPlACE TRIGGER tri_deptmgr
    after insert or update or delete on dept
    for each row
BEGIN
    if inserting then
        INSERT INTO dept_copy(deptno, dname, loc)
        VALUES(:new.deptno,:new.dname,:new.loc);
    elsif updating then
        UPDATE dept_copy SET dname=:new.dname
                            ,loc=:new.loc
         WHERE dept_copy.deptno=:old.deptno;
    elsif deleting then
        DELETE FROM dept_copy
         WHERE dept_copy.deptno=:old.deptno;
    end if;
END;

INSERT INTO dept(deptno,dname,loc) VALUES(52,'����1','����');

UPDATE dept SET dname='����2', loc='����' WHERE deptno=52;

DELETE FROM dept WHERE deptno=52;

SELECT deptno, dname , loc FROM dept_copy

