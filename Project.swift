import ProjectDescription

let project = Project(
    name: "UnownDex",
    layers: [ .init(
        name: "Data",
        platform: .iOS,
        product: .framework,
        withUnitTests: false
    ), .init(
        name: "Service",
        platform: .iOS,
        product: .framework
    ), .init(
        name: "App",
        platform: .iOS,
        product: .app,
        dependencies: [ .target(
            name: "Data"
        ), .target(
            name: "Service"
        ) ]
    ) ]
)

extension Project {
    init(
        name: String,
        layers: [Layer],
        extraTargets: [Target] = [],
        extraSchemes: [Scheme] = []
    ) {
        let targets: [Target] = layers
            .map { $0.targets() }
            .reduce([], +) + extraTargets

        self.init(
            name: name,
            options: .options(
                automaticSchemesOptions: .enabled(codeCoverageEnabled: true)
            ),
            targets: targets,
            schemes: layers.map { $0.scheme } + extraSchemes
        )
    }

    struct Layer {
        let name: String
        let platform: Platform
        let product: Product
        let dependencies: [TargetDependency]
        let withUnitTests: Bool
        let withUITests: Bool

        let scheme: Scheme

        init(
            name: String,
            platform: Platform,
            product: Product,
            dependencies: [TargetDependency] = [],
            withUnitTests: Bool = true,
            withUITests: Bool = false,
            customScheme: Scheme? = nil
        ) {
            self.name = name
            self.platform = platform
            self.product = product
            self.dependencies = dependencies
            self.withUnitTests = withUnitTests
            self.withUITests = withUITests

            self.scheme = customScheme ?? Scheme(
                name: name,
                buildAction: .buildAction(
                    targets: [ .init(
                        stringLiteral: name
                    ) ]
                ),
                testAction: .targets(!withUnitTests ? [] : [ TestableTarget(
                    stringLiteral: Self.unitTestsTarget(name)
                ) ]),
                runAction: .runAction()
            )
        }

        private let scriptsBasePath = "Scripts"

        private var targetPath: String { "Sources/\(name)" }
        private var unitTestsPath: String { "Tests/\(name)" }
        private var uiTestsPath: String { "UITests/\(name)" }

        private static func target(_ name: String) -> String { name }
        private static func unitTestsTarget(_ name: String) -> String { "\(name)_Unit_Tests" }
        private static func uiTestsTarget(_ name: String) -> String { "\(name)_UI_Tests" }

        private func script(_ name: String) -> Path {
            "\(scriptsBasePath)/\(name).sh"
        }

        func targets() -> [Target] {
            var targets = [Target]()

            targets.append(Target(
                name: Self.target(name),
                platform: platform,
                product: product,
                bundleId: "com.example.\(name)",
                sources: "\(targetPath)/**",
                scripts: [ .post(
                    path: script("swiftlint"),
                    arguments: [targetPath],
                    name: "SwiftLint"
                ) ],
                dependencies: dependencies
            ))

            if withUnitTests {
                targets.append(Target(
                    name: Self.unitTestsTarget(name),
                    platform: platform,
                    product: .unitTests,
                    bundleId: "com.example.\(name).UnitTests",
                    sources: "\(unitTestsPath)/**",
                    scripts: [ .post(
                        path: script("swiftlint"),
                        arguments: [unitTestsPath],
                        name: "SwiftLint"
                    ) ],
                    dependencies: [ .target(name: name) ]
                ))
            }

            if withUITests {
                targets.append(Target(
                    name: Self.uiTestsTarget(name),
                    platform: platform,
                    product: .uiTests,
                    bundleId: "com.example.\(name).UITests",
                    sources: "\(uiTestsPath)/**",
                    scripts: [ .post(
                        path: script("swiftlint"),
                        arguments: [uiTestsPath],
                        name: "SwiftLint"
                    ) ],
                    dependencies: [ .target(name: name) ]
                ))
            }

            return targets
        }
    }
}
