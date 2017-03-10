def _maven_release(repository, artifact):
    """induce jar and url name from maven coordinates."""
    parts = artifact.split(':')
    if len(parts) == 3:
        group, artifact, version = parts
    elif len(parts) == 4:
        group, artifact, classifier, version = parts
        if classifier != 'jar':
            fail('Unhandled classifier %s' % classifier)
    else:
        fail("%s:\nexpected id='groupId:artifactId:[:classifier]:version'" % artifact)

    jar = artifact.lower() + '-' + version
    url = "/".join([
        repository,
        group.replace(".", "/"),
        artifact,
        version,
        artifact + "-" + version])

    return jar, url

def _format_deps(attr, deps):
    formatted_deps = ""
    if deps:
        if len(deps) == 1:
            formatted_deps += "%s = ['%s']," % (attr, deps[0])
        else:
            formatted_deps += "%s = [\n" % attr
            for dep in deps:
                formatted_deps += "        '%s',\n" % dep
            formatted_deps += "    ],"
    return formatted_deps

def _generate_build_file(ctx, binjar, srcjar):
    srcjar_attr = ""
    if srcjar:
        srcjar_attr = "srcjar = '%s'," % srcjar
    contents = """
# DO NOT EDIT: automatically generated BUILD file for maven_jar rule {rule_name}
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    jars = ['{binjar}'],
    {srcjar_attr}
    {deps}
    {runtime_deps}
    {exports}
)
java_import(
    name = 'neverlink',
    jars = ['{binjar}'],
    neverlink = 1,
    {deps}
    {runtime_deps}
    {exports}
)
\n""".format(
        srcjar_attr = srcjar_attr,
        rule_name = ctx.name,
        binjar = binjar,
        deps = _format_deps("deps", ctx.attr.deps),
        runtime_deps = _format_deps("runtime_deps", ctx.attr.runtime_deps),
        exports = _format_deps("exports", ctx.attr.exports))
    if srcjar:
        contents += """
java_import(
    name = 'src',
    jars = ['{srcjar}'],
)
""".format(srcjar = srcjar)
    ctx.file("%s/BUILD" % ctx.path("jar"), contents, False)

def _maven_jar_impl(ctx):
    """rule to download a Maven archive."""
  
    jar, url = _maven_release(ctx.attr.repository, ctx.attr.artifact)
  
    binjar = jar + ".jar"
    binjar_path = ctx.path("/".join(["jar", binjar]))
    binurl = url + ".jar"
  
    python = ctx.which("python")
    script = ctx.path(ctx.attr._download_script)
  
    args = [python, script, binjar_path, binurl, ctx.attr.sha1]
    out = ctx.execute(args)
    if out.return_code:
        fail("failed %s: %s %s" % (" ".join(args), out.stdout, out.stderr))
  
    srcjar = None
    if ctx.attr.src_sha1 or ctx.attr.attach_source:
        srcjar = jar + "-src.jar"
        srcurl = url + "-sources.jar"
        srcjar_path = ctx.path("jar/" + srcjar)
        args = [python, script, srcjar_path, srcurl, ctx.attr.src_sha1]
        out = ctx.execute(args)
        if out.return_code:
            fail("failed %s: %s" % (args, out.stderr))
  
    _generate_build_file(ctx, binjar, srcjar)

maven_jar = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha1": attr.string(),
        "src_sha1": attr.string(),
        "_download_script": attr.label(default = Label("//maven:download.py")),
        "repository": attr.string(default = "http://repo1.maven.org/maven2"),
        "attach_source": attr.bool(default = True),
        "deps": attr.string_list(),
        "runtime_deps": attr.string_list(),
        "exports": attr.string_list(),
    },
    local = False,
    implementation = _maven_jar_impl,
)
