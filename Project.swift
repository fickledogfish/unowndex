import ProjectDescription

let project = Project(
    name: "UnownDex",
    layers: [ .init(
        name: "Model",
        platform: .iOS,
        product: .framework,
        withUnitTests: false
    ), .init(
        name: "App",
        platform: .iOS,
        product: .app,
        dependencies: [ .target(
            name: "Model"
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
                    ) ],
                    postActions: [ .init(
                        scriptText: "swiftlint"
                    ) ],
                    runPostActionsOnFailure: false
                ),
                testAction: .targets([ TestableTarget(
                    stringLiteral: "\(name)Tests"
                ) ]),
                runAction: .runAction()
            )
        }

        func targets() -> [Target] {
            var targets = [Target]()

            targets.append(Target(
                name: name,
                platform: platform,
                product: product,
                bundleId: "com.example.\(name)",
                sources: "Sources/\(name)/**",
                dependencies: dependencies
            ))

            if withUnitTests {
                targets.append(Target(
                    name: "\(name)Tests",
                    platform: platform,
                    product: .unitTests,
                    bundleId: "com.example.\(name).Tests",
                    sources: "Tests/\(name)Tests/**",
                    dependencies: [ .target(name: name) ]
                ))
            }

            if withUITests {
                targets.append(Target(
                    name: "\(name)UITests",
                    platform: platform,
                    product: .uiTests,
                    bundleId: "com.example.\(name).UITests",
                    sources: "Tests/\(name)UITests/**",
                    dependencies: [ .target(name: name) ]
                ))
            }

            return targets
        }
    }
}
