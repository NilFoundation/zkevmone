list(APPEND CMAKE_TRY_COMPILE_PLATFORM_VARIABLES WASI_SDK_PREFIX)

if(NOT DEFINED WASI_SDK_PREFIX)
    if(DEFINED ENV{WASI_SDK_PREFIX})
        set(WASI_SDK_PREFIX $ENV{WASI_SDK_PREFIX})
    else()
        # Set default value of WASI_SDK_PREFIX
        set(WASI_SDK_PREFIX /opt/wasi-sdk)
    endif()
else()
    set(ENV{WASI_SDK_PREFIX} ${WASI_SDK_PREFIX})
endif()

if(NOT WASI_SDK_PREFIX STREQUAL /opt/wasi-sdk)
    # Set --sysroot. Not necessary if WASI_SDK_PATH is /opt/wasi-sdk.
    set(CMAKE_SYSROOT ${WASI_SDK_PREFIX}/share/wasi-sysroot)
endif()

include(${WASI_SDK_PREFIX}/share/cmake/wasi-sdk-pthread.cmake)

# Override the default in wasi-sdk.cmake which sets it at "WASI"
# That does not exists in CMake Platforms, and as a result falls back to the host
# toolchain, which on macOS includes extra linker flags.
set(CMAKE_SYSTEM_NAME Linux)
