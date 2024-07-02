load("@prelude//go:toolchain.bzl", "GoToolchainInfo")
load("@prelude//utils:cmd_script.bzl", "ScriptOs", "cmd_script")

def _cc_go_toolchain_impl(ctx):
    is_windows = ctx.attrs.go_os == "windows"
    script_os = ScriptOs("windows" if is_windows else "unix")
    go = "go.exe" if is_windows else "go"

    return [
        DefaultInfo(),
        GoToolchainInfo(
            assembler = RunInfo(cmd_script(ctx, "asm", cmd_args(go, "tool", "asm"), script_os)),
            cgo = RunInfo(cmd_script(ctx, "cgo", cmd_args(go, "tool", "cgo"), script_os)),
            cgo_wrapper = ctx.attrs.cgo_wrapper[RunInfo],
            concat_files = ctx.attrs.concat_files[RunInfo],
            compiler = RunInfo(cmd_script(ctx, "compile", cmd_args(go, "tool", "compile"), script_os)),
            cover = RunInfo(cmd_script(ctx, "cover", cmd_args(go, "tool", "cover"), script_os)),
            cxx_toolchain_for_linking = None,
            env_go_arch = ctx.attrs.go_arch,
            env_go_os = ctx.attrs.go_os,
            external_linker_flags = [],
            gen_stdlib_importcfg = ctx.attrs.gen_stdlib_importcfg[RunInfo],
            go = RunInfo(cmd_script(ctx, "go", cmd_args(go), script_os)),
            go_wrapper = ctx.attrs.go_wrapper[RunInfo],
            linker = RunInfo(cmd_script(ctx, "link", cmd_args(go, "tool", "link"), script_os)),
            packer = RunInfo(cmd_script(ctx, "pack", cmd_args(go, "tool", "pack"), script_os)),
            tags = [],
            linker_flags = [],
            assembler_flags = [],
            compiler_flags = [],
        ),
    ]

cc_go_toolchain = rule(
    impl = _cc_go_toolchain_impl,
    doc = """Example cross-compile go toolchain rule (WIP). Usage:
  cc_go_toolchain(
      name = "go-cc",
      visibility = ["PUBLIC"],
      go_os = "linux",
      go_arch = "amd64",
  )""",
    attrs = {
        "cgo_wrapper": attrs.default_only(attrs.dep(providers = [RunInfo], default = "prelude//go/tools:cgo_wrapper")),
        "concat_files": attrs.default_only(attrs.dep(providers = [RunInfo], default = "prelude//go/tools:concat_files")),
        "gen_stdlib_importcfg": attrs.default_only(attrs.dep(providers = [RunInfo], default = "prelude//go/tools:gen_stdlib_importcfg")),
        "go_wrapper": attrs.default_only(attrs.dep(providers = [RunInfo], default = "prelude//go/tools:go_wrapper")),
        "go_os": attrs.string(),
        "go_arch": attrs.string(),
    },
    is_toolchain_rule = True,
)
