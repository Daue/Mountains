; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{CB8C7C5D-1F0F-4C69-AA4D-FB0B7B1B8885}
AppName=Mountains
AppVersion=1.0
;AppVerName=Names Finder 1.0
DefaultDirName={autopf}\Mountains
DisableProgramGroupPage=yes
LicenseFile=C:\Data\Projects\Qml\Mountains\instalator\license.txt
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=win64
OutputBaseFilename=mountains_instalator
SetupIconFile=C:\Data\Projects\Qml\Mountains\instalator\icon.ico
;Password=2021
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Data\Projects\Qml\Mountains\build\win64\Mountains.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Data\Projects\Qml\Mountains\build\win64\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\Mountains"; Filename: "{app}\Mountains.exe"
Name: "{autodesktop}\Mountains"; Filename: "{app}\Mountains.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\Mountains.exe"; Description: "{cm:LaunchProgram,Names Finder}"; Flags: nowait postinstall skipifsilent