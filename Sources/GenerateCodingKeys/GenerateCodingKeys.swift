@attached(member, names: named(CodingKeys))
public macro GenerateCodingKeys() = #externalMacro(
    module: "GenerateCodingKeysMacros",
    type: "GenerateCodingKeysMacro"
)
