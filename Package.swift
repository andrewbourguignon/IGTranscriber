// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "IGTranscriber",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "IGTranscriber", targets: ["IGTranscriberApp"]),
        .executable(name: "transcribe-cli", targets: ["TranscribeCLI"])
    ],
    targets: [
        .target(
            name: "IGTranscriberCore",
            path: "Sources/IGTranscriberCore"
        ),
        .executableTarget(
            name: "IGTranscriberApp",
            dependencies: ["IGTranscriberCore"],
            path: "Sources/IGTranscriberApp"
        ),
        .executableTarget(
            name: "TranscribeCLI",
            dependencies: ["IGTranscriberCore"],
            path: "Sources/TranscribeCLI"
        )
    ]
)
