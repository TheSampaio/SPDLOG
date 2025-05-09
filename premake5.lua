project "spdlog"
    kind "StaticLib"
    language "C++"
    cppdialect "C++11"
    staticruntime "On"
    location "build"

    targetdir (".Out/Bin/" .. output_dir .. "%{prj.name}")
    objdir    (".Out/Obj/" .. output_dir .. "%{prj.name}")

    files { "source/**.cpp", "include/**.h" }
    includedirs { "include" }

    -- Platform-specific configurations
    filter "system:windows"
        buildoptions { "/utf-8" }
        defines { "SPDLOG_COMPILED_LIB" }

    filter "platforms:x64"
        buildoptions { "/utf-8" }


    filter "system:linux"
        defines { "SPDLOG_CLOCK_COARSE" }

    -- Compiler-specific settings
    filter "action:vs*"
        defines { "_CRT_SECURE_NO_WARNINGS" }

    -- Build shared library if needed
    if _OPTIONS["shared"] then
        kind "SharedLib"
        defines { "SPDLOG_SHARED_LIB" }
    end

    -- Optional Features
    if _OPTIONS["fmt-external"] then
        defines { "SPDLOG_FMT_EXTERNAL" }
        links { "fmt" }
    end

    if _OPTIONS["no-exceptions"] then
        defines { "SPDLOG_NO_EXCEPTIONS" }
        buildoptions { "-fno-exceptions" }
    end

    -- Precompiled header (if enabled)
    if _OPTIONS["enable-pch"] then
        pchheader "spdlog_pch.h"
        pchsource "cmake/pch.h.in"
    end

-- Define options similar to CMake options
newoption {
    trigger = "shared",
    description = "Build spdlog as a shared library"
}

newoption {
    trigger = "fmt-external",
    description = "Use an external fmt library"
}

newoption {
    trigger = "no-exceptions",
    description = "Disable exceptions in spdlog"
}

newoption {
    trigger = "enable-pch",
    description = "Enable precompiled headers"
}