[![ci](https://github.com/gabime/spdlog/actions/workflows/linux.yml/badge.svg)](https://github.com/gabime/spdlog/actions/workflows/linux.yml)&nbsp;
[![ci](https://github.com/gabime/spdlog/actions/workflows/windows.yml/badge.svg)](https://github.com/gabime/spdlog/actions/workflows/windows.yml)&nbsp;
[![ci](https://github.com/gabime/spdlog/actions/workflows/macos.yml/badge.svg)](https://github.com/gabime/spdlog/actions/workflows/macos.yml)&nbsp;
[![Build status](https://ci.appveyor.com/api/projects/status/d2jnxclg20vd0o50?svg=true&branch=v1.x)](https://ci.appveyor.com/project/gabime/spdlog) [![Release](https://img.shields.io/github/release/gabime/spdlog.svg)](https://github.com/gabime/spdlog/releases/latest)

# SpeedLog

This is a modified version of spdlog, a fast C++ logging library under the MIT license. This fork includes some bug fixes and uses Premake5 as the build system instead of the original configuration.

## License
This project is distributed under the MIT license. See the LICENSE file for more information.

## Installation

### Header-only version
To use the header-only version, copy the `include` folder from the original spdlog repository into your build tree and compile with a C++11 (or later) compliant compiler.

## Supported Platforms
- Linux
- Windows (MSVC 2013+, Cygwin)
- macOS (Clang 3.5+)
- Android

## Features
- Header-only or compiled
- Rich feature set with support for formatting, using the excellent fmt library.
- Asynchronous logging (optional)
- Custom formatting (See Custom Formatting)
- Multi-threaded and Single-threaded loggers
- Various log targets:
  - Rotating log files
  - Daily log files
  - Console logging (with colors)
  - Syslog
  - Windows Event Log
  - Windows Debugger (OutputDebugString(..))
  - Log to Qt widgets (example)
- Easily extendable with custom log targets
- Log filtering: Set log levels at runtime or compile time.
- Backtrace support: Store debug messages in a ring buffer and display them later.
- Support for loading log levels from argv or environment variables.

## Usage

### Basic Usage
```cpp
#include "spdlog/spdlog.h"

int main() 
{
    spdlog::info("Welcome to spdlog!");
    spdlog::error("Some error message with arg: {}", 1);
    
    spdlog::warn("Easy padding in numbers like {:08d}", 12);
    spdlog::critical("Support for int: {0:d};  hex: {0:x};  oct: {0:o}; bin: {0:b}", 42);
    spdlog::info("Support for floats {:03.2f}", 1.23456);
    spdlog::info("Positional args are {1} {0}..", "too", "supported");
    spdlog::info("{:<30}", "left aligned");
    
    spdlog::set_level(spdlog::level::debug); // Set global log level to debug
    spdlog::debug("This message should be displayed..");    
    
    // Change log pattern
    spdlog::set_pattern("[%H:%M:%S %z] [%n] [%^---%L---%$] [thread %t] %v");
    
    // Compile-time log levels
    SPDLOG_TRACE("Some trace message with param {}", 42);
    SPDLOG_DEBUG("Some debug message");
}
```

## Create stdout/stderr Logger Object
```cpp
#include "spdlog/spdlog.h"
#include "spdlog/sinks/stdout_color_sinks.h"

void stdout_example()
{
    // Create a color multi-threaded logger
    auto console = spdlog::stdout_color_mt("console");    
    auto err_logger = spdlog::stderr_color_mt("stderr");    
    spdlog::get("console")->info("Loggers can be retrieved from a global registry using spdlog::get(logger_name)");
}
```
## Basic File Logger
```cpp
#include "spdlog/sinks/basic_file_sink.h"

void basic_logfile_example()
{
    try 
    {
        auto logger = spdlog::basic_logger_mt("basic_logger", "logs/basic-log.txt");
    }
    catch (const spdlog::spdlog_ex &ex)
    {
        std::cout << "Log initialization failed: " << ex.what() << std::endl;
    }
}
```
## Rotating Files
```cpp
#include "spdlog/sinks/rotating_file_sink.h"

void rotating_example()
{
    // Create a file rotating logger with 5 MB size max and 3 rotated files
    auto max_size = 1048576 * 5;
    auto max_files = 3;
    auto logger = spdlog::rotating_logger_mt("some_logger_name", "logs/rotating.txt", max_size, max_files);
}
```

## Acknowledgments
This project is a fork of spdlog, a fast and lightweight C++ logging library under the MIT License. All credit goes to Gabime for the original work on the spdlog library.