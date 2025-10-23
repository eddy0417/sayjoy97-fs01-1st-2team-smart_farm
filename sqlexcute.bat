@echo off 
REM ==== ���� ====
set "MYSQL=C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
REM PATH�� mysql�� ������ �� ���� set "MYSQL=mysql" �� �ٲ㵵 �˴ϴ�.
set HOST=localhost
set USER=root
set PASS=1234
set DB=project_smartfarm

REM ==== bat ���� ��ġ �������� �̵� ====
cd /d "%~dp0"

REM ==== SQL ��� ====
set SQL_DIR=src\sql

REM 1) DB ���� (DB ������ ����)
echo [1/5] create_database
"%MYSQL%" -h %HOST% -u %USER% -p%PASS% < "%SQL_DIR%\project_smartfarm_create_database.sql" || goto :err

REM 2) DB ����/���� Ȯ��
"%MYSQL%" -h %HOST% -u %USER% -p%PASS% -e "USE %DB%;" || goto :no_db

REM 3) ���̺� ����
echo [2/5] create_table
"%MYSQL%" -h %HOST% -u %USER% -p%PASS% < "%SQL_DIR%\project_smartfarm_create_table.sql" || goto :err

REM 4) ��� ������
echo [3/5] insert_device_specs
"%MYSQL%" -h %HOST% -u %USER% -p%PASS% < "%SQL_DIR%\project_smartfarm_insert_device_specs.sql" || goto :err

REM 5) ����̽� ������
echo [4/5] insert_devices
"%MYSQL%" -h %HOST% -u %USER% -p%PASS% < "%SQL_DIR%\project_smartfarm_insert_devices.sql" || goto :err

REM 6) ���� �׽�Ʈ ������ (�����, �۹�, ����, �α�)
echo [5/5] insert_dummy_data
"%MYSQL%" -h %HOST% -u %USER% -p%PASS% < "%SQL_DIR%\project_smartfarm_insert_dummy_data.sql" || goto :err

echo === ��ü �Ϸ� ===
goto :end

:no_db
echo ������ DB(%DB%)�� USE ����. DB�� Ȯ�� �ʿ�.
goto :end

:err
echo ���� �߻�. ���� �ܰ� �α� Ȯ��.
:end
pause
