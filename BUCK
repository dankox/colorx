# A list of available rules and their signatures can be found here: https://buck2.build/docs/api/rules/

# genrule(
#     name = "hello_world",
#     out = "out.txt",
#     cmd = "echo BUILT BY BUCK2> $OUT",
# )

go_binary(
    name = "colorx",
    srcs = [
        "main.go",
    ],
    # env_go_os = "linux",
    # env_go_arg = "amd64",
)

go_binary(
    name = "colorx_linux",
    _go_toolchain = "toolchains//:go_linux",
    # _go_stdlib = "toolchains//:stdlib_linux",
    srcs = [
        "main.go",
    ],
)
