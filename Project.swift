import ProjectDescription

let project = Project(
    name: "UnownDex",
    layers: [ .init(
        name: "Data",
        platform: .iOS,
        product: .framework
    ), .init(
        name: "Service",
        platform: .iOS,
        product: .framework
    ), .init(
        name: "UIComponents",
        platform: .iOS,
        product: .framework,
        dependencies: [ .external(
            name: "Kingfisher"
        ), .target(
            name: "Data"
        ) ],
        withUnitTests: false,
        withUITests: false
    ), .init(
        name: "App",
        platform: .iOS,
        product: .app,
        dependencies: [ .target(
            name: "Data"
        ), .target(
            name: "Service"
        ), .target(
            name: "UIComponents"
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
                    stringLiteral: Self.targetName(for: .unitTests, with: name)
                ) ]),
                runAction: .runAction()
            )
        }

        private static func targetName(for product: Product, with name: String) -> String {
            switch product {
            case .framework, .app:
                return "\(name)"

            case .unitTests:
                return "\(name)_Unit_Tests"

            case .uiTests:
                return "\(name)_UI_Tests"

            default:
                fatalError()
            }
        }

        private static func bundleId(for product: Product, with name: String) -> String {
            let targetName = Self
                .targetName(for: product, with: name)
                .replacingOccurrences(of: "_", with: "-")

            return "com.example.\(targetName)"
        }

        private static func path(for product: Product, with name: String) -> String {
            switch product {
            case .framework, .app:
                return "Sources/\(name)"

            case .unitTests:
                return "Tests/\(name)"

            case .uiTests:
                return "UITests/\(name)"

            default:
                fatalError()
            }
        }

        private func script(_ name: String) -> Path {
            "Scripts/\(name).sh"
        }

        func targets() -> [Target] {
            var targets = [Target]()

            targets.append(Target(
                name: Self.targetName(for: product, with: name),
                platform: platform,
                product: product,
                bundleId: Self.bundleId(for: product, with: name),
                sources: "\(Self.path(for: product, with: name))/**",
                scripts: [ .post(
                    path: script("swiftlint"),
                    arguments: [Self.path(for: product, with: name)],
                    name: "SwiftLint"
                ) ],
                dependencies: dependencies
            ))

            if withUnitTests {
                targets.append(Target(
                    name: Self.targetName(for: .unitTests, with: name),
                    platform: platform,
                    product: .unitTests,
                    bundleId: Self.bundleId(for: .unitTests, with: name),
                    sources: "\(Self.path(for: .unitTests, with: name))/**",
                    scripts: [ .post(
                        path: script("swiftlint"),
                        arguments: [Self.path(for: .unitTests, with: name)],
                        name: "SwiftLint"
                    ) ],
                    dependencies: [ .target(name: name) ]
                ))
            }

            if withUITests {
                targets.append(Target(
                    name: Self.targetName(for: .uiTests, with: name),
                    platform: platform,
                    product: .uiTests,
                    bundleId: Self.bundleId(for: .uiTests, with: name),
                    sources: "\(Self.path(for: .uiTests, with: name)))/**",
                    scripts: [ .post(
                        path: script("swiftlint"),
                        arguments: [Self.path(for: .uiTests, with: name)],
                        name: "SwiftLint"
                    ) ],
                    dependencies: [ .target(name: name) ]
                ))
            }

            return targets
        }
    }
}
