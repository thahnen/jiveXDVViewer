# DVStart.app: JiveX DICOM Viewer native starter

This is the macOS version of the Windows DVStart.exe file to start the application based on the

## Building the application

To build the application, run the following commands from command line:

```shell
source venv/bin/activate
pyinstaller --onefile --windowed --icon taskbarLogo.icns --name DVStart main.py
```

## Development environment

- Python 3.10.x
- packages from *requirements.txt*
