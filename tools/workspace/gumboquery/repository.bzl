load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
def gumboquery_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://github.com/lazytiger/gumbo-query/archive/9a269cd94caa32f6d3ee7a203d87bdebc7d38978.tar.gz",
        ],
        sha256 = "329831d2ed7c36cf5efb85603d71978a7eeefa4baa748fca933afc80f0b98988",
        strip_prefix = "gumbo-query-9a269cd94caa32f6d3ee7a203d87bdebc7d38978",
       build_file =Label("//tools/workspace/gumboquery:package.BUILD"),
    )
