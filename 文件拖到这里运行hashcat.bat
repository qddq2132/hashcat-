@echo off
color A
setlocal enabledelayedexpansion
rem 获取脚本所在的完整目录路径  
set "SCRIPT_DIR=%~dp0"  
  
rem 切换到john文件夹  
cd "%SCRIPT_DIR%john"  

rem 建立txt文件 
echo. > hash.txt
if "%~x1"=="" (  
    echo 没有输入文件，请自行输入hash值！
)  
rem 设置变量
set "FILE=%~f1"  
set "EXTENSION=%~x1"  
rem 判断文件后缀，并使用相应程序获取哈希值。
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
title  压缩包密码破解工具hashcat脚本1.1----by小淘
echo -------------------------------------------------------------------------------------------------
rem 获取脚本所在的完整目录路径  
set "SCRIPT_DIR=%~dp0"  
  
rem 设置源文件和目标文件夹的路径  
set "SOURCE_FILE=%SCRIPT_DIR%John\hash.txt"  
set "TARGET_DIR=%SCRIPT_DIR%hashcat"  
  
rem 复制文件  
copy "%SOURCE_FILE%" "%TARGET_DIR%\"  
echo hash值已复制到了hashcat目录下


rem 从这里开始hashcat命令
echo -------------------------------------------------------------------------------------------------
echo "  _                  _                  _                                  _                   "
echo " | |__    __ _  ___ | |__    ___  __ _ | |_              _   _  _   _   __| | ___              "
echo " | '_ \  / _` |/ __|| '_ \  / __|/ _` || __|            | | | || | | | / _` |/ __|             "
echo " | | | || (_| |\__ \| | | || (__| (_| || |_             | |_| || |_| || (_| |\__ \             "
echo " |_| |_| \__,_||___/|_| |_| \___|\__,_| \__|             \__, | \__, | \__,_||___/             "
echo "                                                         |___/  |___/                          "
echo -------------------------------------------------------------------------------------------------
cd /d "%~dp0"
rem 获取脚本所在的完整目录路径  
set "SCRIPT_DIR=%~dp0"  

rem 切换到hashcat文件夹
cd "%SCRIPT_DIR%hashcat"
set "HASH_MODE="
set "file=hash.txt"  
  
:: 检查文件中是否存在"$zip2$*0*3*0*"  
findstr /m "$zip2$*0*3*0*" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=13600"   
    echo 自动判断加密方式为winzip，破解速度较快
    goto :done
)  
  
:: 检查文件中是否存在"$pkzip2$1*1*2*"  
findstr /m "$pkzip2$1*1*2*" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=17200"  
    echo 自动判断加密方式为pkzip2，破解速度极快
    goto :done
) 

:: 检查文件中是否存在"$pkzip$1*1*2*"  
findstr /m "$pkzip$1*1*2*" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=17200"  
    echo 自动判断加密方式为pkzip，破解速度极快
    goto :done
)  

:: 检查文件中是否存在"$RAR3$*1*"  
findstr /m "$RAR3$*1*" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=23800"  
    echo 自动判断加密方式为rar3，破解速度较慢
    echo 请手动删除最后一个*33之后的内容！
    C:\Windows\System32\notepad.exe hash.txt
    goto :done
)  

:: 检查文件中是否存在"rar5"  
findstr /m "rar5" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=13000"  
    echo 自动判断加密方式为rar5，破解速度较慢
    goto :done
)  

:: 检查文件中是否存在"7z"  
findstr /m "7z" "%file%" >nul  
if %errorlevel% equ 0 (  
    set "HASH_MODE=11600"  
    echo 自动判断加密方式为7-zip，破解速度极慢
    goto :done
)  
:done
if "!HASH_MODE!"=="" (   
    echo 你的文件似乎没有加密，或者是某个不支持的格式。
    echo 当然，你也可以手动输入hash值与hash模式
    echo 请查看文件夹中的hash.mhtml，知道hash模式后，请保存并关闭.txt文件！
    echo -------------------------------------------------------------------------------------------------
    C:\Windows\System32\notepad.exe hash.txt
    set /p HASH_MODE="请输入hashcat的hash模式（例如：0, 100, 1400等）:"  
)  
删空格.exe
echo -------------------------------------------------------------------------------------------------
echo 请选择密码样式
echo 0-跑字典
echo 1-纯数字
echo 2-数字+小写字母
echo 3-数字+大写字母
echo 4-纯小写字母
echo 5-纯大写字母
echo 6-自定义
echo 7-网络压缩包密码破解专用(必须指定hash模式)
echo 8-我啥也不知道
echo -------------------------------------------------------------------------------------------------
set /p CHOICE="请输入一个数字（1-8） "  
if "%CHOICE%"=="0" (  
    goto :fly0
)
if "%CHOICE%"=="6" (  
    goto :fly6
)
echo -------------------------------------------------------------------------------------------------
set /p min="请输入密码最小位数："  
set /p max="请输入密码最大位数："  
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
:: 自定义区
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
    set /p format="请输入密码的形式,例：520?l?l?l?d?d?d?d(520+3位字母+4位数字),请输入："
    if "!HASH_MODE!"=="" (  
        hashcat.exe -a 3 hash.txt "!format!" --force
    ) else ( 
        hashcat.exe -m "!HASH_MODE!" -a 3 hash.txt "!format!" --force
    )
)

:: 跑字典专用
:fly0
if "%CHOICE%"=="0" (  
    if "!HASH_MODE!"=="" (  
        hashcat.exe -a 0 --force
    ) else ( 
        hashcat.exe -m "!HASH_MODE!" -a 0 hash.txt ..\字典文件夹 --force
    )
)


endlocal
pause