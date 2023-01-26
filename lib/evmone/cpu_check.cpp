
#define STRINGIFY_HELPER(X) #X
#define STRINGIFY(X) STRINGIFY_HELPER(X)

#ifdef __clang__
// Clang 16 does not support architecture levels in __builtin_cpu_supports(). Use approximations.
#if EVMONE_X86_64_ARCH_LEVEL == 2
#define CPU_FEATURE "sse4.2"
#endif
#elif __GNUC__
#define CPU_FEATURE "x86-64-v" STRINGIFY(EVMONE_X86_64_ARCH_LEVEL)
#endif

#ifndef CPU_FEATURE
#error "EVMONE_X86_64_ARCH_LEVEL: Unsupported x86-64 architecture level"
#endif

#include <cstdio>
#include <cstdlib>

static bool cpu_check = []() noexcept {
    if (!__builtin_cpu_supports(CPU_FEATURE))
    {
        std::fputs("CPU does not support " CPU_FEATURE "\n", stderr);
        std::abort();
    }
    return false;
}();
