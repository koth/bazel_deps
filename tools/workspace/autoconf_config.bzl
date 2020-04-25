# -*- python -*-

# Copyright 2018 Josh Pieper, jjp@pobox.com.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

def _autoconf_config_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)

    defines = ctx.attr.defines + [
        'PACKAGE="{}"'.format(ctx.attr.package),
        'PACKAGE_NAME="{}"'.format(ctx.attr.package),
        'PACKAGE_STRING="{} {}"'.format(ctx.attr.package, ctx.attr.version),
        'PACKAGE_TARNAME="{}"'.format(ctx.attr.package),
        'PACKAGE_URL=""',
        'PACKAGE_VERSION="{}"'.format(ctx.attr.version),
        'PACKAGE_BUGREPORT=""',
        'VERSION="{}"'.format(ctx.attr.version),
        'LT_OBJDIR="XXX"',
    ]

    arguments = [ctx.file.src.path,
                 "--prefix", ctx.attr.prefix,
                 out.path] + defines
    ctx.actions.run(
        outputs=[out],
        inputs=[ctx.file.src],
        executable=ctx.executable.autoconf_config_gen,
        arguments=arguments,
    )

    return [DefaultInfo(
        files = depset([out]),
        data_runfiles = ctx.runfiles(files = [out]),
    )]

autoconf_config = rule(
    attrs = {
        "src": attr.label(allow_single_file=True),
        "defines": attr.string_list(),
        "package": attr.string(),
        "version": attr.string(),
        "prefix": attr.string(),
        "is_executable": attr.bool(default = False),
        "autoconf_config_gen": attr.label(
            cfg = "host",
            executable = True,
            default = Label("//tools/workspace:autoconf_config_gen"),
        ),
    },
    output_to_genfiles = True,
    implementation = _autoconf_config_impl,
)

"""Perform m4 macro substitution

This creates a rule to generate a file from a source, performing m4 macro substitution.
"""


autoconf_standard_defines = [

    "ALIGNOF_DOUBLE=8",
    "ALIGNOF_STRUCT_CHAR__=1",
    "HAVE_ABSTRACT_SOCKETS",
    "HAVE_ACCEPT4",
    "HAVE_ACCESS",
    "HAVE_ACOSH",
    "HAVE_ADDRINFO",
    "HAVE_ALARM",
    "HAVE_ALLOCA",
    "HAVE_ALLOCA_H",
    "HAVE_ASINH",
    "HAVE_ASM_TYPES_H",
    "HAVE_BACKTRACE",
    "HAVE_BCOPY",
    "HAVE_BIND_TEXTDOMAIN_CODESET",
    "HAVE_BUILTIN_ATOMIC",
    "HAVE_BUILTIN_CLZ",
    "HAVE_BUILTIN_RETURN_ADDRESS",
    "HAVE_BYTESWAP_H",
    "HAVE_C99_SNPRINTF",
    "HAVE_C99_VSNPRINTF",
    "HAVE_CANONICALIZE_FILE_NAME",
    "HAVE_CHOWN",
    "HAVE_CHROOT",
    "HAVE_CLOCK",
    "HAVE_CLOCK_GETRES",
    "HAVE_CLOCK_GETTIME",
    "HAVE_CLOCK_SETTIME",
    "HAVE_COMPUTED_GOTOS",
    "HAVE_CONFSTR",
    "HAVE_COPYSIGN",
    "HAVE_CPU_SET_T",
    "HAVE_CRYPT_H",
    "HAVE_CTERMID",
    "HAVE_CTIME_R",
#    "HAVE_CXX11_ATOMIC_PRIMITIVES",
    "HAVE_DCGETTEXT",
    "HAVE_DECL_ALARM",
    "HAVE_DECL_CPU_ALLOC",
    "HAVE_DECL_ISFINITE",
    "HAVE_DECL_ISINF",
    "HAVE_DECL_ISNAN",
    "HAVE_DECL_LOCALTIME_R",
    "HAVE_DECL_RTLD_DEEPBIND",
    "HAVE_DECL_RTLD_GLOBAL",
    "HAVE_DECL_RTLD_LAZY",
    "HAVE_DECL_RTLD_LOCAL",
    "HAVE_DECL_RTLD_NODELETE",
    "HAVE_DECL_RTDL_NOLOAD",
    "HAVE_DECL_RTDL_NOW",
    "HAVE_DECL_STERERROR_R",
    "HAVE_DECL_STRCASECMP",
    "HAVE_DECL_STRDUP",
    "HAVE_DECL_STRNLEN",
    "HAVE_DECL_STRSEP",
    "HAVE_DECL_STRSIGNAL",
    "HAVE_DECL__NL_TIME_WEEK_1STDAY",
    "HAVE_DEVICE_MACROS",
    "HAVE_DEV_PTMX",
    "HAVE_DIRENT_D_TYPE",
    "HAVE_DIRENT_H",
    "HAVE_DIRFD",
    "HAVE_DLADDR",
    "HAVE_DLFCN_H",
    "HAVE_DLOPEN",
    "HAVE_DRAND48",
    "HAVE_DUP2",
    "HAVE_DYNAMIC_LOADING",
    "HAVE_EACCESS",
    "HAVE_ENDIAN_H",
    "HAVE_ENDMNTENT",
    "HAVE_ENDSERVENT",
    "HAVE_ENVIRON_DECL",
    "HAVE_EPOLL",
    "HAVE_EPOLL_CREATE1",
    "HAVE_ERF",
    "HAVE_ERFC",
    "HAVE_ERR",
    "HAVE_ERRNO_H",
    "HAVE_ERRX",
    "HAVE_ERR_H",
    "HAVE_EVENTFD",
    "HAVE_EXECINFO_H",
    "HAVE_EXECV",
    "HAVE_EXPM1",
    "HAVE_EXTERNAL",
    "HAVE_FACCESSAT",
    "HAVE_FALLBACK",
    "HAVE_FALLOCATE",
    "HAVE_FCFINI",
    "HAVE_FCHDIR",
    "HAVE_FCHMOD",
    "HAVE_FCHOWN",
    "HAVE_FCHOWNAT",
    "HAVE_FCINIT",
    "HAVE_FCNTL_H",
    "HAVE_FDATASYNC",
    "HAVE_FDOPENDIR",
    "HAVE_FECLEAREXCEPT",
    "HAVE_FEDISABLEEXCEPT",
    "HAVE_FEDIVBYZERO",
    "HAVE_FEENABLEEXCEPT",
    "HAVE_FEENABLEEXCEPT",
    "HAVE_FENV_H",
    "HAVE_FEXECVE",
    "HAVE_FGETPOS",
    "HAVE_FILENO",
    "HAVE_FINITE",
    "HAVE_FLOAT128",
    "HAVE_FLOCK",
    "HAVE_FLOCKFILE",
    "HAVE_FORK",
    "HAVE_FORKPTY",
    "HAVE_FPATHCONF",
    "HAVE_FSEEKO",
    "HAVE_FSETPOS",
    "HAVE_FSTAB_H",
    "HAVE_FSTAT",
    "HAVE_FSTATAT",
    "HAVE_FSTATFS",
    "HAVE_FSTATVFS",
    "HAVE_FSYNC",
    "HAVE_FTELLO",
    "HAVE_FTIME",
    "HAVE_FTRUNCATE",
    "HAVE_FUTIMENS",
    "HAVE_FUTIMESAT",
    "HAVE_FT_SET_VAR_BLEND_COORDINATES",
    "HAVE_FUNC",
    "HAVE_FUNC_ATTRIBUTE_ALLOC_SIZE",
    "HAVE_FUNC_ATTRIBUTE_CONST",
    "HAVE_FUNC_ATTRIBUTE_ERROR",
    "HAVE_FUNC_ATTRIBUTE_FORMAT",
    "HAVE_FUNC_ATTRIBUTE_MALLOC",
    "HAVE_FUNC_ATTRIBUTE_NORETURN",
    "HAVE_FUNC_ATTRIBUTE_PURE",
    "HAVE_FUNC_ATTRIBUTE_RETURNS_NONNULL",
    "HAVE_FUNCTION",
    "HAVE_FUNLOCKFILE",
    "HAVE_FUTEX",
    "HAVE_FUTIMENS",
    "HAVE_GAI_STRERROR",
    "HAVE_GAMMA",
    "HAVE_GCC_VECTOR_EXTENSIONS",
    "HAVE_GETADDRINFO",
    "HAVE_GETC_UNLOCKED",
    "HAVE_GETDOMAINNAME",
    "HAVE_GETDTABLESIZE",
    "HAVE_GETENTROPY",
    "HAVE_GETGID",
    "HAVE_GETGRGID_R",
    "HAVE_GETGROUPLIST",
    "HAVE_GETGROUPS",
    "HAVE_GETHOSTBYNAME_R",
    "HAVE_GETHOSTBYNAME_R_6_ARG",
    "HAVE_GETITIMER",
    "HAVE_GETLINE",
    "HAVE_GETLOADAVG",
    "HAVE_GETLOGIN",
    "HAVE_GETMNTENT_R",
    "HAVE_GETNAMEINFO",
    "HAVE_GETOPT",
    "HAVE_GETOPT_H",
    "HAVE_GETOPT_LONG",
    "HAVE_GETPAGESIZE",
    "HAVE_GETPEERNAME",
    "HAVE_GETPGID",
    "HAVE_GETPGRP",
    "HAVE_GETPID",
    "HAVE_GETPRIORITY",
    "HAVE_GETPWENT",
    "HAVE_GETPWUID_R",
    "HAVE_GETRESUID",
    # "HAVE_GETRANDOM",
    "HAVE_GETRANDOM_SYSCALL",
    "HAVE_GETRESGID",
    "HAVE_GETRESUID",
    "HAVE_GETRLIMIT",
    "HAVE_GETRUSAGE",
    "HAVE_GETSGNAM",
    "HAVE_GETSID",
    "HAVE_GETSPENT",
    "HAVE_GETSPNAM",
    "HAVE_GETTEXT",
    "HAVE_GETTIMEOFDAY",
    "HAVE_GETUID",
    "HAVE_GETUSERSHELL",
    "HAVE_GETSWD",
    "HAVE_GMP",
    "HAVE_GMTIME_R",
    "HAVE_GOOD_PRINTF",
    "HAVE_GRP_H",
    "HAVE_HASMNTOPT",
    "HAVE_HIDDEN_VISIBILITY_ATTRIBUTE",
    "HAVE_HSTRERROR",
    "HAVE_HTOLE64",
    "HAVE_HYPOT",
    "HAVE_IF_INDEXTONAME",
    "HAVE_IF_NAMETOINDEX",
    "HAVE_INET_ATON",
    "HAVE_INET_PTON",
    "HAVE_INITGROUPS",
#    "HAVE_INOTIFY_INIT",
#    "HAVE_INOTIFY_INIT1",
    "HAVE_INT64_T",
    "HAVE_INTEL_ATOMIC_PRIMITIVES",
    "HAVE_INTMAX_T",
    "HAVE_INTMAX_T=1",
    "HAVE_INTTYPES_H",
    "HAVE_INTTYPES_H_WITH_UINTMAX",
    "HAVE_IOPERM",
    "HAVE_IOPL",
    "HAVE_IP_MREQN",
    "HAVE_ISATTY",
    "HAVE_ISNAN",
    "HAVE_ISO_CODES",
    "HAVE_JRAND48",
    "HAVE_KILL",
    "HAVE_KILLPG",
    "HAVE_LANGINFO_H",
    "HAVE_LASTLOG_H",
    "HAVE_LCHOWN",
    "HAVE_LGAMMA",
    "HAVE_LIBBLKID",
    "HAVE_LIBCRYPT",
    "HAVE_LIBC_ENABLE_SECURE",
    "HAVE_LIBDL",
    "HAVE_LIBGEN_H",
    "HAVE_LIBINTL_H",
    "HAVE_LIBPNG",
    "HAVE_LIBRT",
    "HAVE_LIMITS_H",
    "HAVE_LINK",
    "HAVE_LINKAT",
    "HAVE_LINUX_BLKPG_H",
    "HAVE_LINUX_BTRFS_H",
    "HAVE_LINUX_CAN_BCM_H",
    "HAVE_LINUX_CAN_H",
    "HAVE_LINUX_CAN_RAW_FD_FRAMES",
    "HAVE_LINUX_CAN_RAW_H",
    "HAVE_LINUX_CDROM_H",
    "HAVE_LINUX_FALLOC_H",
    "HAVE_LINUX_FD_H",
    "HAVE_LINUX_MAGIC_H",
    "HAVE_LINUX_MAJOR_H",
    "HAVE_LINUX_NET_NAMESPACE_H",
    "HAVE_LINUX_NETLINK_H",
    "HAVE_LINUX_RANDOM_H",
    "HAVE_LINUX_RAW_H",
    "HAVE_LINUX_SECUREBITS_H",
    "HAVE_LINUX_TIOCL_H",
    "HAVE_LINUX_TIPC_H",
    "HAVE_LINUX_VERSION_H",
    "HAVE_LINUX_WATCHDOG_H",
    "HAVE_LLSEEK",
    "HAVE_LOCALE_H",
    "HAVE_LOCALTIME_R",
    "HAVE_LOCKF",
    "HAVE_LOFF_T",
    "HAVE_LOG1P",
    "HAVE_LOG2",
    "HAVE_LONG_DOUBLE",
    "HAVE_LONG_LONG",
    "HAVE_LONG_LONG_FORMAT",
    "HAVE_LONG_LONG_INT",
    "HAVE_LRAND48",
    "HAVE_LRINT",
    "HAVE_LRINTF",
    "HAVE_LSEEK64",
    "HAVE_LSEEK64_PROTOTYPE",
    "HAVE_LSTAT",
    "HAVE_LUTIMES",
    "HAVE_MAKEDEV",
    "HAVE_MALLOC_H",
    "HAVE_MBRTOWC",
    "HAVE_MEMALIGN",
    "HAVE_MEMCPY",
    "HAVE_MEMMOVE",
    "HAVE_MEMORY_H",
    "HAVE_MEMPCPY",
    "HAVE_MEMRCHR",
    "HAVE_MEMSET",
    "HAVE_MKDIR",
    "HAVE_MKDIRAT",
    "HAVE_MKDTEMP",
    "HAVE_MKFIFO",
    "HAVE_MKFIFOAT",
    "HAVE_MKNOD",
    "HAVE_MKNODAT",
    "HAVE_MKTIME",
    "HAVE_MKOSTEMP",
    "HAVE_MKSTEMP",
    "HAVE_MMAP",
    "HAVE_MMAP_ANON",
    "HAVE_MMAP_DEV_ZERO",
    "HAVE_MMAP_FILE",
    "HAVE_MNTENT_H",
    "HAVE_MONOTONIC_CLOCK",
    "HAVE_MPROTECT",
    "HAVE_MREMAP",
    "HAVE_NAMESPACES",
    "HAVE_NANOSLEEP",
    "HAVE_NETINET_IN_H",
    "HAVE_NETLINK",
    # "HAVE_NETPACKET_PACKET_H",
    "HAVE_NET_IF_H",
    "HAVE_NEWLOCALE",
    "HAVE_NICE",
    "HAVE_NTP_GETTIME",
    "HAVE_OPENAT",
    "HAVE_OPENPTY",
    "HAVE_OPEN_MEMSTREAM",
    "HAVE_OPEN_O_DIRECTORY",
    "HAVE_OT",
    "HAVE_PATHCONF",
    "HAVE_PATHS_H",
    "HAVE_PAUSE",
    "HAVE_PERSONALITY",
    "HAVE_PIPE2",
    "HAVE_POLL",
    "HAVE_POLL_H",
    "HAVE_POSIX_FADVISE",
    "HAVE_POSIX_FALLOCATE",
    "HAVE_POSIX_MEMALIGN",
    "HAVE_POSIX_TIMERS",
    "HAVE_PPOLL",
    "HAVE_PRCTL",
    "HAVE_PREAD",
    "HAVE_PRETTY_FUNCTION",
    "HAVE_PRLIMIT",
    "HAVE_PROGRAM_INVOCATION_SHORT_NAME",
    "HAVE_PROTOTYPES",
    "HAVE_PSELECT",
    "HAVE_PTHREAD",
    "HAVE_PTHREADS",
    "HAVE_PTHREAD_ATFORK",
    "HAVE_PTHREAD_ATTR_SETSTACKSIZE",
    "HAVE_PTHREAD_CONDATTR_SETCLOCK",
    "HAVE_PTHREAD_GNETNAME_NP",
    "HAVE_PTHREAD_H",
    "HAVE_PTHREAD_KILL",
    "HAVE_PTHREAD_PRIO_INHERIT",
    "HAVE_PTHREAD_SETNAME_NP_WITH_TID",
    "HAVE_PTHREAD_SIGMASK",
    "HAVE_PTRDIFF_T",
    "HAVE_PTY_H",
    "HAVE_PUTENV",
    "HAVE_PWRITE",
    "HAVE_QSORT_R",
    "HAVE_RAISE",
    "HAVE_RAND",
    "HAVE_RANDOM",
    "HAVE_RANDOM_R",
    "HAVE_READLINK",
    "HAVE_READLINKAT",
    "HAVE_READV",
    "HAVE_REALPATH",
    "HAVE_REBOOT",
    "HAVE_RECVMMSG",
    "HAVE_RENAMEAT",
    "HAVE_RESIZETERM",
    "HAVE_RES_INIT",
    "HAVE_RES_NCLOSE",
    "HAVE_RES_NINIT",
    "HAVE_RES_NQUERY",
    "HAVE_ROUND",
    "HAVE_RPMATCH",
    "HAVE_RTLD_GLOBAL",
    "HAVE_RTLD_LAZY",
    "HAVE_RTLD_NOW",
    "HAVE_SCANDIRAT",
    "HAVE_SCANF_MS_MODIFIER",
    "HAVE_SCHED_GETAFFINITY",
    "HAVE_SCHED_GET_PRIORITY_MAX",
    "HAVE_SCHED_H",
    "HAVE_SCHED_RR_GET_INTERVAL",
    "HAVE_SCHED_SETAFFINITY",
    "HAVE_SCHED_SETPARAM",
    "HAVE_SCHED_SETSCHEDULER",
    "HAVE_SECURE_GETENV",
    "HAVE_SELECT",
    "HAVE_SEM_GETVALUE",
    "HAVE_SEM_OPEN",
    "HAVE_SEM_TIMEDWAIT",
    "HAVE_SEM_UNLINK",
    "HAVE_SENDFILE",
    "HAVE_SENDMMSG",
    "HAVE_SENDMSG",
    "HAVE_SETEGID",
    "HAVE_SETEUID",
    "HAVE_SETENV",
    "HAVE_SETEUID",
    "HAVE_SETGID",
    "HAVE_SETGROUPS",
    "HAVE_SETHOSTNAME",
    "HAVE_SETITIMER",
    "HAVE_SETJMP_H",
    "HAVE_SETLOCALE",
    "HAVE_SETMNTENT",
    "HAVE_SETNS",
    "HAVE_SETPGID",
    "HAVE_SETPGRP",
    "HAVE_SETPRIORITY",
    "HAVE_SETREGID",
    "HAVE_SETRESGID",
    "HAVE_SETRESUID",
    "HAVE_SETREUID",
    "HAVE_SETSID",
    "HAVE_SETUID",
    "HAVE_SETTIMER",
    "HAVE_SETVBUF",
    "HAVE_SHADOW_H",
    "HAVE_SICGIFCONF_SIOCGIFFLAGS_SICGIFHWADDR",
    "HAVE_SIGACTION",
    "HAVE_SIGHANDLER_T",
    "HAVE_SIGNAL_H",
    "HAVE_SIGNALTSTACK",
    "HAVE_SIGINTERRUPT",
    "HAVE_SIGNAL_H",
    "HAVE_SIGPENDING",
    "HAVE_SIGQUEUE",
    "HAVE_SIGRELSE",
    "HAVE_SIGTIMEDWAIT",
    "HAVE_SIGWAIT",
    "HAVE_SIGWAITINFO",
    "HAVE_SIG_ATOMIC_T",
    "HAVE_SIOCGIFADDR",
    "HAVE_SNPRINTF",
    "HAVE_SOCKADDR_ALG",
    "HAVE_SOCKADDR_STORAGE",
    "HAVE_SOCKETPAIR",
    "HAVE_SOCKLEN_T",
    "HAVE_SPAWN_H",
    "HAVE_SPLICE",
    "HAVE_SRAND48",
    "HAVE_SRANDOM",
    "HAVE_SSIZE_T",
    "HAVE_SSTREAM",
    "HAVE_STAT",
    "HAVE_STATFS",
    "HAVE_STATVFS",
    "HAVE_STAT_TV_NSEC",
    "HAVE_STDBOOL_H",
    "HAVE_STDARG_PROTOTYPES",
    "HAVE_STDINT_H",
    "HAVE_STDINT_T_WITH_UINTMAX",
    "HAVE_STDIO_EXT_H",
    "HAVE_STDLIB_H",
    "HAVE_STDNORETURN_H",
    "HAVE_STD_ATOMIC",
    "HAVE_STPCPY",
    "HAVE_STRCASECMP",
    "HAVE_STRCASESTR",
    "HAVE_STRDUP",
    "HAVE_STRERROR",
    "HAVE_STRERROR_R",
    "HAVE_STRFTIME",
    "HAVE_STRING",
    "HAVE_STRINGIZE",
    "HAVE_STRINGS_H",
    "HAVE_STRING_H",
    "HAVE_STRNCASECMP",
    "HAVE_STRNDUP",
    "HAVE_STRNDUP_H",
    "HAVE_STRNLEN",
    "HAVE_STROPTS_H",
    "HAVE_STRSEP",
    "HAVE_STRSIGNAL",
    "HAVE_STRSIGNAL_DECL",
    "HAVE_STRTOD_L",
    "HAVE_STRTOK_R",
    "HAVE_STRTOL",
    "HAVE_STRTOLL_L",
    "HAVE_STRTOQ",
    "HAVE_STRTOULL_L",
    "HAVE_STRUCT_DIRENT_D_TYPE",
    "HAVE_STRUCT_ITIMERSPEC_IT_INTERVAL",
    "HAVE_STRUCT_ITIMERSPEC_IT_VALUE",
    "HAVE_STRUCT_PASSWD_PW_GECOS",
    "HAVE_STRUCT_PASSWD_PW_PASSWD",
    "HAVE_STRUCT_STAT",
    "HAVE_STRUCT_STATFS_F_BAVAIL",
    "HAVE_STRUCT_STATFS_F_FLAGS",
    "HAVE_STRUCT_STAT_ST_ATIM_TV_NSEC",
    "HAVE_STRUCT_STAT_ST_BLKSIZE",
    "HAVE_STRUCT_STAT_ST_BLOCKS",
    "HAVE_STRUCT_STAT_ST_CTIM_TV_NSEC",
    "HAVE_STRUCT_STAT_ST_MTIM",
    "HAVE_STRUCT_STAT_ST_MTIM_TV_NSEC",
    "HAVE_STRUCT_STAT_ST_RDEV",
    "HAVE_STRUCT_TERMIOS_C_LINE",
    "HAVE_STRUCT_TIMESPEC_TV_NSEC",
    "HAVE_STRUCT_TIMESPEC_TV_SEC",
    "HAVE_STRUCT_TM_TM_GMTOFF",
    "HAVE_STRUCT_TM_TM_ZONE",
    "HAVE_SWAPOFF",
    "HAVE_SWAPON",
    "HAVE_SYMLINK",
    "HAVE_SYMLINKAT",
    "HAVE_SYNC",
    "HAVE_SYSCALL_GETRANDOM",
    "HAVE_SYSCONF",
    "HAVE_SYSEXITS_H",
    "HAVE_SYSINFO",
    "HAVE_SYSLOG",
    "HAVE_SYS_EPOLL_H",
    "HAVE_SYS_FILE_H",
    "HAVE_SYS_IOCTL_H",
    "HAVE_SYS_MMAN_H",
    "HAVE_SYS_MOUNT_H",
    "HAVE_SYS_PARAM_H",
    "HAVE_SYS_POLL_H",
    "HAVE_SYS_PRCTL_H",
    # "HAVE_SYS_RANDOM_H",
    "HAVE_SYS_RESOURCE_H",
    "HAVE_SYS_SELECT_H",
    "HAVE_SYS_SENDFILE_H",
    "HAVE_SYS_SIGNALFD_H",
    "HAVE_SYS_SOCKET_H",
    "HAVE_SYS_STATFS_H",
    "HAVE_SYS_STATVFS_H",
    "HAVE_SYS_STAT_H",
    "HAVE_SYS_SWAP_H",
    "HAVE_SYS_SYSCALL_H",
    "HAVE_SYS_SYSCTL_H",
    "HAVE_SYS_SYSMACROS_H",
    "HAVE_SYS_TIMES_H",
    "HAVE_SYS_TIMEX_H",
    "HAVE_SYS_TIME_H",
    "HAVE_SYS_TTYDEFAULTS_H",
    "HAVE_SYS_TYPES_H",
    "HAVE_SYS_UIO_H",
    "HAVE_SYS_UN_H",
    "HAVE_SYS_UTSNAME_H",
    "HAVE_SYS_VFS_H",
    "HAVE_SYS_WAIT_H",
    "HAVE_SYS_XATTR_H",
    "HAVE_TCGETPGRP",
    "HAVE_TCSETPGRP",
    "HAVE_TEMPNAM",
    "HAVE_TERMIOS_H",
    "HAVE_TERM_H",
    "HAVE_TGAMMA",
    "HAVE_TIMEGM",
    "HAVE_TIMES",
    "HAVE_TIME_H",
    "HAVE_TLS",
    "HAVE_TM_GMTOFF",
    "HAVE_TM_ZONE",
    "HAVE_TMPFILE",
    "HAVE_TMPNAM",
    "HAVE_TMPNAM_R",
    "HAVE_TM_ZONE",
    "HAVE_TRUNCATE",
    "HAVE_UCDN",
    "HAVE_UCONTEXT_H",
    "HAVE_UINT64_T",
    "HAVE_UINTPTR_T",
    "HAVE_UNAME",
    "HAVE_UNISTD_H",
    "HAVE_UNIX98_PRINTF",
    "HAVE_UNLINKAT",
    "HAVE_UNSETENV",
    "HAVE_UNSHARE",
    "HAVE_UNSIGNED_LONG_LONG",
    "HAVE_UNSIGNED_LONG_LONG_INT",
    "HAVE_UPDWTMPX",
    "HAVE_USE_DEFAULT_COLORS",
    "HAVE_USLEEP",
    "HAVE_UTIMENSAT",
    "HAVE_UTIMES",
    "HAVE_UTIME_H",
    "HAVE_UTMPX_H",
    "HAVE_UTMP_H",
    "HAVE_UUIDD",
    "HAVE_VALLOC",
    "HAVE_VALUES_H",
    "HAVE_VASPRINTF",
    "HAVE_VISIBILITY",
    "HAVE_VPRINTF",
    "HAVE_VSNPRINTF",
    "HAVE_VWARNX",
    "HAVE_WAIT3",
    "HAVE_WAITID",
    "HAVE_WAITPID",
    "HAVE_WARN",
    "HAVE_WARNING_CPP_DIRECTIVE",
    "HAVE_WCHAR_H",
    "HAVE_WCHAR_T",
    "HAVE_WCRTOMB",
    "HAVE_WCSCOLL",
    "HAVE_WCSFTIME",
    "HAVE_WCSLEN",
    "HAVE_WCSNLEN",
    "HAVE_WCSXFRM",
    "HAVE_WIDECAR",
    "HAVE_WINT_T",
    "HAVE_WMEMCMP",
    "HAVE_WORKING_TZSET",
    "HAVE_WRITEV",
    "HAVE_XATTR",
    "HAVE_ZLIB",
    "HAVE__BOOL",
    "PTHREAD_SYSTEM_SCHED_SUPPORTED",
    "SIZEOF__BOOL=1",
    "SIZEOF_CHAR=1",
    "SIZEOF_FLOAT=4",
    "SIZEOF_DOUBLE=8",
    "SIZEOF_FPOS_T=16",
    "SIZEOF_INT=4",
    "SIZEOF_LONG_LONG=8",
    "SIZEOF_SHORT=2",
    "SIZEOF_WCHAR_T=4",
    "SIZEOF___INT64=0",
    "STATFS_ARGS=2",

    "STDC_HEADERS",
    "SYS_SELECT_WITH_SYS_TIME",
    "TANH_PRESERVES_ZERO_SIGN",
    "TIME_WITH_SYS_TIME",

    "_ALL_SOURCE",
    "_GNU_SOURCE",
    "_TANDEM_SOURCE",

    "_POSIX_PTHREAD_SEMANTICS",

] + select({
    "@com_github_mjbots_bazel_deps//conditions:long_double_16bytes" : [
        "SIZEOF_LONG_DOUBLE=16",
    ],
    "@com_github_mjbots_bazel_deps//conditions:long_double_8bytes" : [
        "SIZEOF_LONG_DOUBLE=8",
    ],
    "//conditions:default" : [
       "SIZEOF_LONG_DOUBLE=16",
    ],
}) + select({
    "@com_github_mjbots_bazel_deps//conditions:long_8bytes" : [
        "ALIGNOF_UNSIGNED_LONG=8",
        "SIZEOF_LONG=8",
        "SIZEOF_VOID_P=8",
        "ALIGNOF_VOID_P=8",
        "SIZEOF_PTHREAD_T=8",
        "SIZEOF_TIME_T=8",
        "SIZEOF_UINTPTR_T=8",
        "SIZEOF_OFF_T=8",
    ],
    "@com_github_mjbots_bazel_deps//conditions:long_4bytes" : [
        "ALIGNOF_UNSIGNED_LONG=4",
        "SIZEOF_LONG=4",
        "SIZEOF_VOID_P=4",
        "ALIGNOF_VOID_P=4",
        "SIZEOF_PTHREAD_T=4",
        "SIZEOF_TIME_T=4",
        "SIZEOF_UINTPTR_T=4",
        "SIZEOF_OFF_T=4",
    ],
    "//conditions:default" : [
        "ALIGNOF_UNSIGNED_LONG=8",
        "SIZEOF_LONG=8",
        "SIZEOF_VOID_P=8",
        "ALIGNOF_VOID_P=8",
        "SIZEOF_PTHREAD_T=8",
        "SIZEOF_TIME_T=8",
        "SIZEOF_UINTPTR_T=8",
        "SIZEOF_OFF_T=8",
    ],
}) + select({
    "@com_github_mjbots_bazel_deps//conditions:sizet_8bytes" : [
        "SIZEOF_SIZE_T=8",
        "SIZEOFSSIZE_T=8",
    ],
    "@com_github_mjbots_bazel_deps//conditions:sizet_4bytes" : [
        "SIZEOF_SIZE_T=4",
        "SIZEOFSSIZE_T=4",
    ],
    "//conditions:default" : [
        "SIZEOF_SIZE_T=8",
        "SIZEOFSSIZE_T=8",
    ],
}) + select({
    "@com_github_mjbots_bazel_deps//conditions:x86_64" : [
        "HAVE_DECL__I386__=0",
        "HAVE_DECL__X86_64__",
        "HAVE_CPU_X86_64",
        "TARGET_CPU=\"x86_64\"",
        "HAVE_GCC_ASM_FOR_X64",
        "HAVE_GCC_ASM_FOR_X86",
        "HAVE_SSE",
        "HAVE_SSE2",
        "HAVE_SSE41",
        "HAVE_XMMINTRIN_H",
        "HAVE_EMMINTRIN_H",
        "HAVE_SMMINTRIN_H",
    ],
    "@com_github_mjbots_bazel_deps//conditions:arm" : [
        "HAVE_CPU_ARM",
        "TARGET_CPU=\"ARM\"",
    ],
    "//conditions:default" : [
        "HAVE_DECL__I386__=0",
        "HAVE_DECL__X86_64__",
        "HAVE_CPU_X86_64",
        "TARGET_CPU=\"x86_64\"",
        "HAVE_GCC_ASM_FOR_X64",
        "HAVE_GCC_ASM_FOR_X86",
        "HAVE_SSE",
        "HAVE_SSE2",
        "HAVE_SSE41",
        "HAVE_XMMINTRIN_H",
        "HAVE_EMMINTRIN_H",
        "HAVE_SMMINTRIN_H",
    ],
})
