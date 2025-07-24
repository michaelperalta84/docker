
mkdir -p backup_dmp

cd backup_dmp/
pwd

sqlplus / as sysdba

SQL> create directory export as '/u02/backup_dmp';

SQL> exit


expdp system/oraclepvla@PVLA directory=export dumpfile=exp_pvla.dmp full=y
expdp ultrasec/ultrasec@pvcurva directory=EXPORT dumpfile=exp_15072025.dmp schemas=ultrasec logfile=exp_15072025.log

select * from dba_directories

select * from dba_directories where DIRECTORY_NAME like 'DATA_PUMP_DIR';

desc dba_users;



servidor destino



chown -R oracle:oinstall /u03
chmod -R 775 /u03

#como crear un tablespace para importar data desde data pump

create bigfile tablespace ULTRASEC datafile '/opt/app/oracle/oradata/ULTRASEC.dbf' size 10m;
create bigfile tablespace ULTRASEC datafile '/opt/app/oracle/oradata/ULTRASEC.dbf' size 10m
!
create bigfile tablespace ULTRASEC datafile '/u04/app/oracle/PVPIZARRA/ULTRASEC.dbf' size 200m autoextend on;
create bigfile tablespace ULTRA_INDEX datafile '/u04/app/oracle/PVPIZARRA/ULTRA_INDEX.dbf' size 200m autoextend on;

create bigfile tablespace ULTRASEC datafile '/u04/app/oracle/oradata/PVTESTLA/ULTRASEC.dbf' size 200m autoextend on;
create bigfile tablespace ULTRA_INDEX datafile '/u04/app/oracle/oradata/PVTESTLA/ULTRA_INDEX.dbf' size 200m autoextend on;


create bigfile tablespace ULTRASEC datafile '/u07/app/oracle/oradata/PVONLINE/ULTRASEC.dbf' size 200m autoextend on;
create bigfile tablespace ULTRA_INDEX datafile '/u07/app/oracle/oradata/PVONLINE/ULTRA_INDEX.dbf' size 200m autoextend on;

create bigfile tablespace ULTRASEC datafile '/u07/app/oracle/oradata/PVCURVA/ULTRASEC.dbf' size 200m autoextend on;
create bigfile tablespace ULTRA_INDEX datafile '/u07/app/oracle/oradata/PVCURVA/ULTRA_INDEX.dbf' size 200m autoextend on;

create bigfile tablespace ULTRASEC datafile '/u07/app/oracle/oradata/PVPIZARRA/ULTRASEC.dbf' size 200m autoextend on;
create bigfile tablespace ULTRA_INDEX datafile '/u07/app/oracle/oradata/PVPIZARRA/ULTRA_INDEX.dbf' size 200m autoextend on;

create bigfile tablespace ULTRASEC datafile '/u08/app/oracle/oradata/PVMARGEN/ULTRASEC.dbf' size 200m autoextend on;
create bigfile tablespace ULTRA_INDEX datafile '/u08/app/oracle/oradata/PVMARGEN/ULTRA_INDEX.dbf' size 200m autoextend on;

create bigfile tablespace ULTRASEC datafile '/u08/app/oracle/oradata/PVDWH/ULTRASEC.dbf' size 200m autoextend on;
create bigfile tablespace ULTRA_INDEX datafile '/u08/app/oracle/oradata/PVDWH/ULTRA_INDEX.dbf' size 200m autoextend on;

#para eliminar tablespace incluyendo contenido y datafiles.
DROP TABLESPACE <tablespace name> INCLUDING CONTENTS AND DATAFILES;


SELECT file_name, tablespace_name 
FROM dba_data_files;


# como eliminar el Directory Export

SQL> drop directory export;

como crear el directory Export

SQL> create directory export as '/u04';

SQL> create directory export as '/u05';



df -h

 ps -fea | grep pmon
 
 export ORACLE_SID=PVLAQA2
 rman target /
 
RMAN> report schema;


como importar data exportada con datapum

impdp system/oraclepvla@PVNIIFTS DIRECTORY=export dumpfile=exp_pvla.dmp SCHEMAS=ULTRASEC logfile=imp_23012020.log




#como compilar los objetos en la base de datos

SQL> @?/rdbms/admin/utlrp.sql


#como alterar la base de datos open;

SQL> alter database open;

SQL> show parameter service


# iniciar la base de datos especificamente:


startup pfile='PVNIIFTS.init'

$ lsnrctl



LSNRCTL> status listener

SQL> startup mount


alter database noarchivelog;



select * from dba_objects
where STATUS ='INVALID'




CREATE DIRECTORY DUMP_FILES1 AS '/usr/apps/dumpfiles1';


###################################

Table Space

SELECT directory_name, directory_path FROM dba_directories;

select tablespace_name from dba_tablespaces;

select file_id, file_name, tablespace_name from dba_data_files;

create tablespace test datafile '/u01/app/parag/oradata/paragdb/test01.dbf'
size 10m
autoextend on next 1m
extent management local
segment space management auto
logging;


alter tablespace test add datafile '/u01/app/parag/oradata/paragdb/test01.dbf' size 10m;


Desc dba_data_files

select file_id, file_name, tablespace_name, bytes/1024/1024 "in mb" from dba_data_files;

alter database datafile 7 resize 15m;


alter database datafile '/u01/app/parag/oradata/paragdb/test01.dbf' resize 20m;


Drop tablespace test including contents and datafiles;


drop tablespace ULTRA_INDEX including contents and datafiles;

ULTRASEC.dbf

drop tablespace ULTRASEC including contents and datafiles;

select parameter,value from nls_session_parameters where parameter='NLS_LENGTH_SEMANTICS';





#Resolucion de error al import data ORA-12899: value too large for column

select parameter,value from nls_session_parameters where parameter=’NLS_LENGTH_SEMANTICS’;
alter system set nls_length_semantics=CHAR scope=both;

shutdown e startup para verificar.


ALTER USER user_name IDENTIFIED BY new_password;

ALTER USER account IDENTIFIED BY password ACCOUNT UNLOCK;



=========


SQL> select instance_name from v$instance;

SQL> select instance_name,status,startup_time from v$instance;


SQL> select username from all_users where username like 'ULTRA%'

SQL> CREATE USER ULTRASEC identified by ultrasec;

SQL> desc dba_tablespaces

SQL> select tablespace_name from dba_tablespaces ;


SQL> alter user ultrasec default tablespace ultrasec;


SQL> show parameter instance

imp system@PVCONTABLE file=PVLA_BK_2021-06-14.dmp fromuser=ULTRASEC TOUSER=ULTRASEC log=impPVLA_BK_2021-06-14.log

imp system/oraclepvla@PVNIIFTS file=backup.dmp log=import.log full=y


GRANT UNLIMITED TABLESPACE TO ultrasec;




select value from v$parameter where name='service_names';

========

# Drop database 

SQL> select name from v$datafile;
SQL> select name from v$controlfile;
SQL> select member from v$logfile;

SQL> shutdown immediate;

SQL> startup mount exclusive restrict;

SQL> drop database;




#### para error ORA 00054 resource busy and acquire with NOWAIT specified or timeout expired.

SQL> alter session set ddl_lock_timeout = 600;


#########################################################################################


1. Cómo buscar los nombre de todos los archivos de la base de datos.

VISTA: V$datafile

SQL> SELECT name FROM V$datafile;

2. Cómo buscar el grupo de redo log

VISTA: V$LOG
Obtenemos el número de los redo logs y el estado de estos ( current, active )

SQL> SELECT group#, status FROM v$log;

Obtenemos el nombre de los redo logs de la base de datos

SQL> SELECT member FROM v$log;

3. Cómo buscar los controlfiles de la base de datos

VISTA: V$CONTROLFILE
Obtenemos el nombre y ubicación de los controlfile de la base de datos con la siguiente consulta

SQL> SELECT name FROM v$controlfile;

4. Cómo obtener el nombre de la base de datos

VISTA: V$DATABASE

SQL> SELECT name from V$database;

5. Cómo listar los procesos que siguen conectados a la base de datos

VISTA: V$PROCESS

SQL> SELECT pid,username from V$process;

6. Cómo obtener el nombre de la instancia de la base de datos

VISTA: V$INSTANCE

SQL> SELECT instance_name,status V$instance;



SELECT INSTANCE_NAME, STATUS, DATABASE_STATUS FROM V$INSTANCE;

SQL> select * from v$version;

SQL> select sysdate from dual;

SYSDATE
---------
01-SEP-22

SQL> SELECT sessiontimezone FROM dual;

SESSIONTIMEZONE
---------------------------------------------------------------------------
-04:00

SQL> SELECT systimestamp FROM dual;

SYSTIMESTAMP
---------------------------------------------------------------------------
01-SEP-22 09.50.25.665169 AM -04:00


##########################################################################################################


#Agregar tablaspace a base de datos

alter tablespace ULTRA_INDEX add datafile '/oradata/PVLA/ultraindex04.dbf' size 10m autoextend on maxsize unlimited;




##########################################################################################################


#actualizacion de tabla para abrir pizarra LA Sistemas


update ultrasec.persona set fl_mercado = 2023214


##########################################################################################################


GRANT CREATE SESSION TO prosario;

SELECT * FROM session_privs;

GRANT SELECT ANY TABLE TO prosario;

grant all privileges to prosario;





###############################################################################################################



@?/audit/ORADB_10g.sql

/opt/app/oracle/product/10.2.0/audit/



GRANT SELECT ON ULTRASEC.RELA to DWHUSER;


grant select any table to prosario;



select s.sid, s.serial#, s.status, p.spid
from v$session s, v$process p
where s.username = 'ultrasec'
and p.addr (+) = s.paddr;

###############################################################################################################


#Expandir Table Space

alter tablespace ULTRASEC add datafile '/oradata2/PVLA/ultrasec03.dbf' size 10m autoextend on maxsize unlimited;

alter tablespace ULTRASEC add datafile '/u04/app/oradata/pvcontable/ULTRASEC02' size 10m autoextend on maxsize unlimited;


###############################################################################################################


SELECT a.blocking_session blocker_sid,
       a.sid blocked_sid,
       a.serial# blocked_serial,
       b.sid blocker_sid,
       b.serial# blocker_serial,
       a.event,
       a.seconds_in_wait
FROM   v$session a
       JOIN v$session b
       ON a.blocking_session = b.sid;
	   
	   
	   
	OUTPUT

blocked_sid 1180, blocked_serial 15117, blocker_sid_1, 1246 blocker_serial 1,  event log file sync



SELECT a.blocking_session blocker_sid,
       a.sid blocked_sid,
       a.serial# blocked_serial,
       a.username blocked_user,  -- Usuario bloqueado
       b.sid blocker_sid,
       b.serial# blocker_serial,
       b.username blocker_user,  -- Usuario que bloquea
       a.event,
       a.seconds_in_wait
FROM   v$session a
       JOIN v$session b
       ON a.blocking_session = b.sid;
	   
	   
################################################################################################################

-- Sesiones activas que consumen más recursos
SELECT SID, SERIAL#, STATUS, USERNAME, PROGRAM, MACHINE 
FROM V$SESSION 
WHERE STATUS = 'ACTIVE';

-- Tiempo de espera de eventos en la base de datos
SELECT EVENT, TOTAL_WAITS, TIME_WAITED 
FROM V$SYSTEM_EVENT 
ORDER BY TIME_WAITED DESC;

-- Consumo de CPU y memoria por proceso
SELECT SID, SQL_ID, CPU_TIME, ELAPSED_TIME 
FROM V$SQL 
ORDER BY CPU_TIME DESC;


####################################################################################################

Oracle AWR genera informes que contienen métricas clave de rendimiento. Para generar un informe AWR:

    Ejecutar el script AWR en SQL*Plus:

@?/rdbms/admin/awrrpt.sql


#########################################################################################################

Utiliza ASH para analizar las sesiones activas en un momento específico:

SELECT SAMPLE_TIME, SESSION_ID, SQL_ID, EVENT, BLOCKING_SESSION 
FROM V$ACTIVE_SESSION_HISTORY 
WHERE SAMPLE_TIME > SYSDATE - (1/24) -- Última hora
ORDER BY SAMPLE_TIME;

#########################################################################################################

Verificar índices no utilizados:

SELECT TABLE_NAME, INDEX_NAME, MONITORING, USED 
FROM V$OBJECT_USAGE 
WHERE USED = 'NO';




#########################################################################################################


Actualizar estadísticas: Ejecuta el paquete DBMS_STATS para optimizar el rendimiento del optimizador:

BEGIN
  DBMS_STATS.GATHER_SCHEMA_STATS('SCHEMA_NAME');
END;
/

#########################################################################################################

Utiliza la vista V$SQL para identificar SQL con tiempos de ejecución prolongados:

SELECT SQL_ID, ELAPSED_TIME, CPU_TIME, EXECUTIONS, DISK_READS, SQL_TEXT 
FROM V$SQL 
WHERE ELAPSED_TIME > 1000000 -- Más de 1 segundo
ORDER BY ELAPSED_TIME DESC;

#########################################################################################################

Consulta parámetros importantes en V$PARAMETER

SELECT NAME, VALUE 
FROM V$PARAMETER 
WHERE NAME IN ('db_cache_size', 'pga_aggregate_target', 'sga_target');



###############################Kill Session #########################################################

SQL> select 'alter system kill session ''' || sid || ',' || serial# || ''' immediate;' stmts from v$session where username = 'ULTRASEC';

STMTS
--------------------------------------------------------------------------------
alter system kill session '13,52719' immediate;
alter system kill session '130,1433' immediate;
alter system kill session '136,2216' immediate;

SQL>
SQL>
SQL> drop user ultrasec cascade;
drop user ultrasec cascade