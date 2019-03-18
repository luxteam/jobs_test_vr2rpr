set PATH=c:\python35\;c:\python35\scripts\;%PATH%
set FILE_FILTER=%1
set TESTS_FILTER="%2"

python ..\jobs_launcher\executeTests.py --test_filter %TESTS_FILTER% --file_filter %FILE_FILTER% --execute_stages 2 3 4 --tests_root ..\jobs --work_root ..\Work\Results --work_dir vr2rpr --cmd_variables Tool "C:\Program Files\Autodesk\3ds Max 2019\3dsmax.exe" ResPath "C:\TestResources\VrayAssets"