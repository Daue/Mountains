rd /S /Q .\win64
mkdir .\win64
cd win64
xcopy .\..\..\..\build-Mountains-Desktop_Qt_5_15_2_MSVC2019_64bit-Release\release\Mountains.exe
c:\Qt\5.15.2\msvc2019_64\bin\windeployqt.exe --no-translations --qmldir c:\Data\Projects\Qml\Mountains\src\ Mountains.exe
