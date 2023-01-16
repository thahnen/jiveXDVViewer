"""
Main script for the DVStart.app software to start the JiveX DICOM Viewer
"""

import configparser
import os.path
import subprocess
import sys

# General application constants
app: str = "DVStart"


def get_start_attributes(_config: configparser.ConfigParser) -> tuple[str | None, str | None]:
    """
    Tries to read the "LogEnabled" and "LogFilename" configuration from section "Start" in INI file.

    :param _config: the content of INI file
    :return: content of "LogEnabled" and "LogFilename" if found, each can be None
    """

    if "Start" not in _config.sections():
        return None, None
    _log_enabled = _config["Start"]["LogEnabled"] if "LogEnabled" in _config["Start"] else None
    _log_filename = _config["Start"]["LogFilename"] if "LogFilename" in _config["Start"] else None
    return _log_enabled, _log_filename


def get_java_attributes(_config: configparser.ConfigParser) -> tuple[str | None, str | None]:
    """
    Tries to read the "ClassPath" and "MainClass" configuration from section "Java" in INI file.

    :param _config: the content of INI file
    :return: content of "ClassPath" and "MainClass" if found, each can be None
    """

    if "Java" not in _config.sections():
        return None, None
    _classpath = _config["Java"]["ClassPath"] if "ClassPath" in _config["Java"] else None
    _main_class = _config["Java"]["MainClass"] if "MainClass" in _config["Java"] else None
    return _classpath, _main_class


def get_jvm_attributes(_config: configparser.ConfigParser) -> tuple[str | None, str | None, str | None, str | None]:
    """
    Tries to read the "AutoAdjustMemUsage" and "MemorySettings" and "WorkDir" and "JVMOptions" configuration from
    section "JVM" in INI file.

    :param _config: the content of INI file
    :return: content of "AutoAdjustMemUsage" / "MemorySettings" / "WorkDir / "JVMOptions" if found, each can be None
    """

    if "Java" not in _config.sections():
        return None, None, None, None
    _auto_adjust_memory_usage = _config["JVM"]["AutoAdjustMemUsage"] if "AutoAdjustMemUsage" in _config["JVM"] else None
    _memory_settings = _config["JVM"]["MemorySettings"] if "MemorySettings" in _config["JVM"] else None
    _working_directory = _config["JVM"]["WorkDir"] if "WorkDir" in _config["JVM"] else None
    _jvm_options = _config["JVM"]["JVMOptions"] if "JVMOptions" in _config["JVM"] else None
    return _auto_adjust_memory_usage, _memory_settings, _working_directory, _jvm_options


def get_jvm_properties_attributes(_config: configparser.ConfigParser) -> dict[str, str] | None:
    """
    Tries to read the configured Java system properties passed from section "JVM_PROPERTIES" in INI file.

    :param _config: the content of INI file
    :return: all JVM properties stored in dictionary
    """

    if "JVM_PROPERTIES" not in _config.sections():
        return None
    _properties: dict[str, str] = {}
    for key in _config["JVM_PROPERTIES"]:
        _properties[key] = _config["JVM_PROPERTIES"][key]
    return _properties


# ======================================================================================================================
#                                           MAIN APPLICATION ENTRY POINT
# ======================================================================================================================
if __name__ == "__main__":
    # Get JiveX DICOM Viewer installation folder
    jivexdv = os.path.dirname(os.path.abspath(sys.argv[0]))
    if jivexdv.endswith(f"{app}.app/Contents/MacOS"):
        jivexdv = jivexdv.replace(f"{app}.app/Contents/MacOS", "")

    # Check if DVStart.ini exists in the directory
    ini_file = os.path.join(jivexdv, "DVStart.ini")
    if not os.path.isfile(ini_file):
        sys.exit(1)

    # Load content from DVStart.ini
    config = configparser.ConfigParser()
    config.read(ini_file)

    # Get necessary attributes (logging)
    log_enabled, log_filename = get_start_attributes(config)

    # Get necessary attributes (Java call)
    classpath, main_class = get_java_attributes(config)
    if classpath is None:
        sys.exit(2)
    if main_class is None:
        sys.exit(3)
    classpath = classpath.replace(";", ":")
    main_class = main_class.replace("/", ".")

    # Get necessary attributes (JVM)
    auto_adjust_memory_usage, memory_settings, working_directory, jvm_options = get_jvm_attributes(config)

    # Get JVM system properties
    properties = get_jvm_properties_attributes(config)

    # Build command
    # INFO: -Xdock:icon / -Xdock:name only work on packaged Java applications, not plain Java calls!
    # TODO: Maybe add extra class which starts com.visustt.jiveX.client.jiveXViewer.JiveXViewer which sets the tray icon
    #       or move DVStart to own Java application which just loads everything as a library and starts the application
    #       from within -> this will work with -Xdock!
    # TODO: Maybe modify JVM while JiveX DICOM Viewer is running to load the tray icon? Maybe modify the code to load
    #       the tray icon (.icns file)?
    command = f"java -cp {classpath} {main_class}"
    print(f"Command: {command}")

    ret = subprocess.run(command.split(" "), cwd=jivexdv, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    print(f"Output: {ret.stdout.decode('UTF-8')} / {ret.stderr.decode('UTF-8')}")
