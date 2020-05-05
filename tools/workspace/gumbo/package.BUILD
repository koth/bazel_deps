package(default_visibility = ["//visibility:public"])

licenses(["notice"])

cc_library(
    name = "gumbo",
    includes =[
      'src'
    ],
    srcs = [
        "src/attribute.c",
        "src/char_ref.c",
        "src/error.c",
        "src/parser.c",
        "src/string_buffer.c",
        "src/string_piece.c",
        "src/tag.c",
        "src/tokenizer.c",
        "src/utf8.c",
        "src/util.c",
        "src/vector.c",
    ] + glob(["src/*.h"]),
    copts = [
        "-std=c99",
        "-O3",
        "-g",
        "-Wno-sign-compare",
    ],
    linkstatic = 1,
    visibility = ["//visibility:public"],
    deps = [
    ],
    alwayslink = 1,
)