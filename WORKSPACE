git_repository(
  name = "org_pubref_rules_protobuf",
  remote = "https://github.com/pubref/rules_protobuf",
  commit = "70dd70464e951ad2c518d39cf9d4b5bf98dd16b8",
)

load("@org_pubref_rules_protobuf//java:rules.bzl", "java_proto_repositories")
load("//maven:maven_jar.bzl", "maven_jar")

maven_jar( 
    name = "io_grpc_grpc_auth",
    artifact = "io.grpc:grpc-auth:jar:1.1.2",
    sha1 = "ba323099a63ca6742988a1dd10bc53f859538d45",
    src_sha1 = "4afadbf50c0e8b1e918c1e8449aec1f005cd7382",
)
maven_jar( 
    name = "io_grpc_grpc_context",
    artifact = "io.grpc:grpc-context:jar:1.1.2",
    sha1 = "13b5ee5ae223633c5817ba446937ffb4e24e0011",
    src_sha1 = "7a0cec80b6ce15f0c3c63aabbf121457d9596372",
)
maven_jar( 
    name = "io_grpc_grpc_core",
    artifact = "io.grpc:grpc-core:jar:1.1.2",
    sha1 = "26c46b3886600f55dd5da3525e0d35d7b8fb5afa",
    src_sha1 = "3c42e7b1f9ac6eb5793a24a9580bbd8b44fe3a3c",
    exports = ["@com_google_errorprone_error_prone_annotations//jar"],
)
maven_jar(
    name = "io_grpc_grpc_netty",
    artifact = "io.grpc:grpc-netty:jar:1.1.2",
    sha1 = "0fd87fc29bd822bc31ce9f0cb379ead29f398e8c",
    src_sha1 = "aadbb55a3795d0190615770ce953c0762122bc8a",
)
maven_jar(
    name = "io_grpc_grpc_protobuf",
    artifact = "io.grpc:grpc-protobuf:jar:1.1.2",
    sha1 = "fd0428c3979718ab1c5a44d21026d03c1f3f4b3c",
    src_sha1 = "45b57cdb38104045c1973018cb5f592f1955bf9c",
)
maven_jar(
    name = "io_grpc_grpc_protobuf_lite",
    artifact = "io.grpc:grpc-protobuf-lite:jar:1.1.2",
    sha1 = "a1668f8f9f5d6778675ddb9e0c7641c3cea5f524",
    src_sha1 = "3960bd4c0aa0e2883a7d77cb5f9700f3153ee672",
)
maven_jar(
    name = "io_grpc_grpc_services",
    artifact = "io.grpc:grpc-services:jar:1.1.2",
    sha1 = "feebb37a15ccfd46fab1543655c159308acfba26",
    src_sha1 = "9678a67ceea305d6e4319780484a96369117b314",
)
maven_jar(
    name = "io_grpc_grpc_stub",
    artifact = "io.grpc:grpc-stub:jar:1.1.2",
    sha1 = "9adc5c1a55eda5952a4c49e926739fa96f265df5",
    src_sha1 = "7412510d3f53862d1bd74cc758ae602e794361f9",
)
maven_jar(
    name = "com_google_errorprone_error_prone_annotations",
    artifact = "com.google.errorprone:error_prone_annotations:2.0.18",
    sha1 = "5f65affce1684999e2f4024983835efc3504012e",
    src_sha1 = "220c1232fa6d13b427c10ccc1243a87f5f501d31",
)
maven_jar(
    name = "com_google_guava_guava",
    artifact = "com.google.guava:guava:21.0",
    sha1 = "3a3d111be1be1b745edfa7d91678a12d7ed38709",
    src_sha1 = "b9ed26b8c23fe7cd3e6b463b34e54e5c6d9536d5",
)

# Loading proto/grpc dependencies.
java_proto_repositories(excludes = [
    "io_grpc_grpc_auth",
    "io_grpc_grpc_context",
    "io_grpc_grpc_core",
    "io_grpc_grpc_netty",
    "io_grpc_grpc_protobuf",
    "io_grpc_grpc_protobuf_lite",
    "io_grpc_grpc_stub",
    "com_google_guava_guava",
])
