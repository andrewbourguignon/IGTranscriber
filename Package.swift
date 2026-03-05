// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "TranscriberBot",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "TranscriberBot", targets: ["TranscriberBotApp"]),
        .executable(name: "transcriber-bot-cli", targets: ["TranscriberBotCLI"])
    ],
    targets: [
        .target(
            name: "TranscriberBotCore",
            path: "Sources/TranscriberBotCore"
        ),
        .executableTarget(
            name: "TranscriberBotApp",
            dependencies: ["TranscriberBotCore"],
            path: "Sources/TranscriberBotApp"
        ),
        .executableTarget(
            name: "TranscriberBotCLI",
            dependencies: ["TranscriberBotCore"],
            path: "Sources/TranscriberBotCLI"
        )
    ]
)
