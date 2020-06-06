package(default_visibility = ["//visibility:public"])

licenses(["notice"])


cc_library(
    name = "gumboquery",
    srcs = glob(["src/*.cc","src/*.h"]),
    copts = [
        "-O3",
        "-g",
        "-Wno-sign-compare",
    ],
    linkstatic = 1,
    visibility = ["//visibility:public"],
    deps = [
        '@gumbo//:gumbo'
    ],
    alwayslink = 1,
)
