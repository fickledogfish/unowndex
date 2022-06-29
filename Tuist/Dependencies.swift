import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(
            url: "https://github.com/onevcat/Kingfisher",
            requirement: .exact(Version(7, 2, 4))
        )
    ],
    platforms: [.iOS]
)
