load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
def gumbo_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://github.com/google/gumbo-parser/archive/aa91b27b02c0c80c482e24348a457ed7c3c088e0.tar.gz",
        ],
        sha256 = "f2d899ad9f96da1461710148dc1dc84c8519d9ec342d70bdb7a2c1f61dba3678",
        strip_prefix = "gumbo-parser-aa91b27b02c0c80c482e24348a457ed7c3c088e0",
       build_file =Label("//tools/workspace/gumbo:package.BUILD"),
    )
