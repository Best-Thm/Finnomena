//----------------- Mobile ---------------------
# Prerequisites
- flutter 2.5.3 (https://flutter.dev/docs/get-started/install)
- Android studio
# Run Code
- open vscode at project folder
- select emulator (in my case, I use `Pixel 2 API 30 (android-x86 emulator)`)
- run terminal with command 
    ```flutter run```
# Unit Test
- open vscode at project folder
- run terminal with command 
    ```flutter test```

//----------------- Web Chrome ---------------------
# Prerequisites
- flutter 2.5.3 (https://flutter.dev/docs/get-started/install)
- chrome
# Edit file for CORS Error on local
- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
- Find '--disable-extensions'
- Add '--disable-web-security'
# Run Code
- open vscode at project folder
- run terminal with command 
    ```flutter run -d chrome```
# Unit Test
- open vscode at project folder
- run terminal with command 
    ```flutter test```