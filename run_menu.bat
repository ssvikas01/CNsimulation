@echo off
setlocal EnableDelayedExpansion
title Energy-Aware Routing Simulator (WSN)
cd /d "%~dp0"

:MENU
cls
echo ===============================================================================
echo       ENERGY-AWARE ROUTING PROTOCOL SIMULATOR FOR WSNs
echo       Author: S S Vikas (24BLC1021)
echo ===============================================================================
echo.
echo   [1] Launch Interactive Streamlit Web GUI (Recommended)
echo   [2] Run Quick Base Simulation (CLI)
echo   [3] Run Paired Comparison Experiment (Shortest Path vs Energy-Aware)
echo   [4] Run Full Test Suite (pytest - 239 tests)
echo   [5] List All Available Experiments
echo   [6] Exit
echo.
echo ===============================================================================
set /p "CHOICE=Enter your choice (1-6): "

rem Determine Python executable (prefer local virtual environment)
if exist ".venv\Scripts\python.exe" (
    set "PY=.venv\Scripts\python.exe"
) else (
    where py >nul 2>nul
    if not errorlevel 1 (
        set "PY=py"
    ) else (
        set "PY=python"
    )
)

if "%CHOICE%"=="1" goto GUI
if "%CHOICE%"=="2" goto RUN_SIM
if "%CHOICE%"=="3" goto RUN_EXP
if "%CHOICE%"=="4" goto RUN_TESTS
if "%CHOICE%"=="5" goto LIST_EXP
if "%CHOICE%"=="6" goto EXIT
echo Invalid choice. Please enter a number between 1 and 6.
timeout /t 2 >nul
goto MENU

:GUI
cls
echo Starting Streamlit Dashboard...
echo Keep this window open. Press Ctrl+C to stop the dashboard.
%PY% -m streamlit run src/energy_routing/dashboard.py
pause
goto MENU

:RUN_SIM
cls
echo Running single simulation with default configs/base.yaml...
%PY% -m energy_routing.main run --config configs/base.yaml
echo.
pause
goto MENU

:RUN_EXP
cls
echo Running paired comparison experiment across 5 seeds...
%PY% -m energy_routing.main experiment --name routing_comparison --base-config configs/base.yaml
echo.
pause
goto MENU

:RUN_TESTS
cls
echo Running full test suite (pytest)...
%PY% -m pytest tests/ -v
echo.
pause
goto MENU

:LIST_EXP
cls
echo Available experiment suites:
%PY% -m energy_routing.main list-experiments
echo.
pause
goto MENU

:EXIT
echo Exiting. Have a great day!
endlocal
exit /b 0
