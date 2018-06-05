CREATE OR REPLACE FUNCTION func_yesterdaycrate(pdate varchar2)
return number
IS
tmpVar number;
BEGIN
    tmpVar :=0;
    SELECT MAX(crate) INTO tmpVar
      FROM test02
     WHERE cdate = (SELECT MAX(cdate) FROM test02 WHERE cdate < pdate);
    return tmpVar;
END;
