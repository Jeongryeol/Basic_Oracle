SELECT deptno, dname, loc FROM dept


SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno FROM emp
-- ���谡 �ִ� ���̺��� ��� ����� �޾Ƶξ�� ��� ���� ������.


SELECT qna_writer, qna_date, qna_title, qna_contents, qna_count, qna_no
    FROM qnaboard
--�����͸� �����ϰ� ���� �� �����?
--������ ������ ������ �ݵ�� �޾ƾ� �Ѵ�.
--������ ��� �����ͺ��̽��� Ÿ�����ڿ��� ���ظ� �ֱ� ������ �����ϰ� �ؾ��ϴ� ������.
--�����ϴ� ����� �˾ƾ���.


DELETE FROM dept WHERE deptno = 30
--���ǿ� ���� ���� �ڷ�� ������ �� ����.


DELETE FROM dept WHERE deptno = 40
--���ȼ� �������� ���� : �ֺ���� �ڽ��� ����� ���� ������ ��ȣ��
--��������
--�θ�� �ڽİ��迡 �����ִ� ���̺��� �����Ҷ���
--���� �ڽ��� ����(emp)�ϰ� �״��� �θ�(dept)�� ������


rollback;
--�� commit�� �� �Ŀ��� ���� �Ұ��� : ���� ������ ���̺� �����͸� �����ϴ°�(commit)


DELETE FROM emp
--��ü�� �����ϴ� ���̹Ƿ� ���ϵ�ī��(*)�� �ʿ����
commit;
--commit;�� �ؾ� ���������� ������.


DELETE FROM dept
--��ü�� �����ϴ� ���̹Ƿ� ���ϵ�ī��(*)�� �ʿ����
commit;


SELECT * FROM dept

SELECT * FROM emp


SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp
-- �������� �̿��Ͽ� Ư�� ������ ���� �߷���


SELECT deptno FROM emp
MINUS
SELECT deptno FROM dept
--�������տ��� ū������ ���� ����� ����



--�����Ҷ� ��� ����?

--��������
--�θ�����(dept)���� ���� �߰��ϰ� �ڽ� ���̺�(emp)�� �߰���
--�ֳ��ϸ� ��� ���̺� �ܷ�Ű�� deptno�� �����Ƿ� �� ��ġ��