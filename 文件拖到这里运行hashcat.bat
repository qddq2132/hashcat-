@echo off
color A
setlocal enabledelayedexpansion
rem ��ȡ�ű����ڵ�����Ŀ¼·��  
set "SCRIPT_DIR=%~dp0"  
  
rem �л���john�ļ���  
cd "%SCRIPT_DIR%john"  

rem ����txt�ļ� 
echo. > hash.txt
if "%~x1"=="" (  
    echo û�������ļ�������������hashֵ��
)  
rem ���ñ���
set "FILE=%~f1"  
set "EXTENSION=%~x1"  
rem �ж��ļ���׺����ʹ����Ӧ�����ȡ��ϣֵ��
if /i "!EXTENSION!"==".zip" (  
    zip2hashcat.exe "!FILE!"  > hash.txt
) else if /i "!EXTENSION!"==".rar" (  
    rar2hashcat.exe "!FILE!"  > hash.txt
) else if /i "!EXTENSION!"==".docx" (  
    office2john.exe "!FILE!"  > hash.txt
) else if /i "!EXTENSION!"==".doc" (  
    office2john.exe "!FILE!"  > hash.txt
) else if /i "!EXTENSION!"==".pdf" (  
    office2john.exe "!FILE!"  > hash.txt
) else if /i "!EXTENSION!"==".xlsx" (  
    office2john.exe "!FILE!"  > hash.txt
) else if /i "!EXTENSION!"==".7z" (  
    7z2hashcat.exe "!FILE!"  > hash.txt
) 
title  ѹ���������ƽ⹤��hashcat�ű�1.1----byС��
echo -------------------------------------------------------------------------------------------------
rem ��ȡ�ű����ڵ�����Ŀ¼·��  
set "SCRIPT_DIR=%~dp0"  
  
rem ����Դ�ļ���Ŀ���ļ��е�·��  
set "SOURCE_FILE=%SCRIPT_DIR%John\hash.txt"  
set "TARGET_DIR=%SCRIPT_DIR%hashcat"  
  
rem �����ļ�  
copy "%SOURCE_FILE%" "%TARGET_DIR%\"  
echo hashֵ�Ѹ��Ƶ���hashcatĿ¼��


rem �����￪ʼhashcat����
echo -------------------------------------------------------------------------------------------------
echo "  _                  _                  _                                  _                   "
echo " | |__    __ _  ___ | |__    ___  __ _ | |_              _   _  _   _   __| | ___              "
echo " | '_ \  / _` |/ __|| '_ \  / __|/ _` || __|            | | | || | | | / _` |/ __|             "
echo " | | | || (_| |\__ \| | | || (__| (_| || |_             | |_| || |_| || (_| |\__ \             "
echo " |_| |_| \__,_||___/|_| |_| \___|\__,_| \__|             \__, | \__, | \__,_||___/             "
echo "                                                         |___/  |___/                          "
echo -------------------------------------------------------------------------------------------------
cd /d "%~dp0"
rem ��ȡ�ű����ڵ�����Ŀ¼·��  
set "SCRIPT_DIR=%~dp0"  

rem �л���hashcat�ļ���
cd "%SCRIPT_DIR%hashcat"
set "HASH_MODE="
set "file=hash.txt"  
  
:: ����ļ����Ƿ����"$zip2$*0*3*0*"  
findstr /m "$zip2$*0*3*0*" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=13600"   
    echo �Զ��жϼ��ܷ�ʽΪwinzip���ƽ��ٶȽϿ�
    goto :done
)  
  
:: ����ļ����Ƿ����"$pkzip2$1*1*2*"  
findstr /m "$pkzip2$1*1*2*" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=17200"  
    echo �Զ��жϼ��ܷ�ʽΪpkzip2���ƽ��ٶȼ���
    goto :done
) 

:: ����ļ����Ƿ����"$pkzip$1*1*2*"  
findstr /m "$pkzip$1*1*2*" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=17200"  
    echo �Զ��жϼ��ܷ�ʽΪpkzip���ƽ��ٶȼ���
    goto :done
)  

:: ����ļ����Ƿ����"$RAR3$*1*"  
findstr /m "$RAR3$*1*" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=23800"  
    echo �Զ��жϼ��ܷ�ʽΪrar3���ƽ��ٶȽ���
    echo ���ֶ�ɾ�����һ��*33֮������ݣ�
    C:\Windows\System32\notepad.exe hash.txt
    goto :done
)  

:: ����ļ����Ƿ����"rar5"  
findstr /m "rar5" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=13000"  
    echo �Զ��жϼ��ܷ�ʽΪrar5���ƽ��ٶȽ���
    goto :done
)  

:: ����ļ����Ƿ����"7z"  
findstr /m "7z" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=11600"  
    echo �Զ��жϼ��ܷ�ʽΪ7-zip���ƽ��ٶȼ���
    goto :done
)  
:done
if "!HASH_MODE!"=="" (   
    echo ����ļ��ƺ�û�м��ܣ�������ĳ����֧�ֵĸ�ʽ��
    echo ��Ȼ����Ҳ�����ֶ�����hashֵ��hashģʽ
    echo ��鿴�ļ����е�hash.mhtml��֪��hashģʽ���뱣�沢�ر�.txt�ļ���
    echo -------------------------------------------------------------------------------------------------
    C:\Windows\System32\notepad.exe hash.txt
    set /p HASH_MODE="������hashcat��hashģʽ�����磺0, 100, 1400�ȣ�:"  
)  
ɾ�ո�.exe
echo -------------------------------------------------------------------------------------------------
echo ��ѡ��������ʽ
echo 0-���ֵ�
echo 1-������
echo 2-����+Сд��ĸ
echo 3-����+��д��ĸ
echo 4-��Сд��ĸ
echo 5-����д��ĸ
echo 6-�Զ���
echo 7-����ѹ���������ƽ�ר��(����ָ��hashģʽ)
echo 8-��ɶҲ��֪��
echo -------------------------------------------------------------------------------------------------
set /p CHOICE="������һ�����֣�1-8�� "  
if "%CHOICE%"=="0" (  
    goto :fly0
)
if "%CHOICE%"=="6" (  
    goto :fly6
)
echo -------------------------------------------------------------------------------------------------
set /p min="������������Сλ����"  
set /p max="�������������λ����"  
echo -------------------------------------------------------------------------------------------------

if "%CHOICE%"=="1" (  
    set "format=?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d?d"  
)
if "%CHOICE%"=="2" (  
    set "format=?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h?h"  
)
if "%CHOICE%"=="3" (  
    set "format=?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H?H"  
)
if "%CHOICE%"=="4" (  
    set "format=?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l?l"  
)
if "%CHOICE%"=="5" (  
    set "format=?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u?u"  
)
if "%CHOICE%"=="7" (  
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?h?h?h?h
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?h?h?h?h?h
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?l?l?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?l?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?l?l?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?l?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?l?l?l?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?l?l?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?l?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?d?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?l?l?l?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?l?l?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?l?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?d?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?l?l?l?l?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?l?l?l?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?l?l?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?l?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?d?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?d?d?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?l?l?l?l?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?l?l?l?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?l?l?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?l?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?d?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?d?d?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?l?d?d?d?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?l?l?d?d?d?d?d?d?d?d
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?d?d?d?l?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?d?d?d?d?d?d?d?d?l?l
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?h?h?h?h?h?h
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?h?h?h?h?h?h?h
    hashcat.exe -m "!HASH_MODE!" -a 3  hash.txt ?h?h?h?h?h?h?h?h
)
if "%CHOICE%"=="8" (  
    set "format=?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a?a"  
)

if "!HASH_MODE!"=="" (  
    hashcat.exe -a 3 -i --increment-min="!min!" --increment-max="!max!" hash.txt "!format!" --force
) else ( 
    hashcat.exe -m "!HASH_MODE!" -a 3 -i --increment-min="!min!" --increment-max="!max!" hash.txt "!format!" --force
)
:: �Զ�����
:fly6
if "%CHOICE%"=="6" (  
    echo -------------------------------------------------------------------------------------------------
    echo ?l  abcdefghijklmnopqrstuvwxyz [a-z]
    echo ?u  ABCDEFGHIJKLMNOPQRSTUVWXYZ [A-Z]
    echo ?d  0123456789                 [0-9]
    echo ?h  0123456789abcdef           [0-9a-f]
    echo ?H  0123456789ABCDEF           [0-9A-F]
    echo ?s  !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
    echo ?a  ?l?u?d?s
    echo ?b  0x00 - 0xff
    echo -------------------------------------------------------------------------------------------------
    set /p format="�������������ʽ,����520?l?l?l?d?d?d?d(520+3λ��ĸ+4λ����),�����룺"
    if "!HASH_MODE!"=="" (  
        hashcat.exe -a 3 hash.txt "!format!" --force
    ) else ( 
        hashcat.exe -m "!HASH_MODE!" -a 3 hash.txt "!format!" --force
    )
)

:: ���ֵ�ר��
:fly0
if "%CHOICE%"=="0" (  
    if "!HASH_MODE!"=="" (  
        hashcat.exe -a 0 --force
    ) else ( 
        hashcat.exe -m "!HASH_MODE!" -a 0 hash.txt ..\�ֵ��ļ��� --force
    )
)


endlocal
pause