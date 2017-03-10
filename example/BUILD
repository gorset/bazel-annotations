load("@org_pubref_rules_protobuf//java:rules.bzl", "java_proto_library")

java_proto_library(
    name = "examplefail",
    protos = [
        "example.proto",
    ],
    visibility = ["//visibility:public"],
    with_grpc = True,
)

java_proto_library(
    name = "exampleworking",
    protos = [
        "example.proto",
    ],
    visibility = ["//visibility:public"],
    with_grpc = True,
    deps = ["@com_google_errorprone_error_prone_annotations//jar"],
)
