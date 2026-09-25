import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct GenerateCodingKeysMacro: MemberMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let properties = declaration.memberBlock.members.compactMap { member -> String? in
            guard let variable = member.decl.as(VariableDeclSyntax.self),
                  let binding = variable.bindings.first,
                  let identifier = binding.pattern.as(IdentifierPatternSyntax.self) else {
                return nil
            }
            
            return identifier.identifier.text
        }

        let codingKeyCases = properties.map { propertyName in
            let codingKey = snakeCase(propertyName)
            return "case \(propertyName) = \"\(codingKey)\""
        }

        let codingKeys: DeclSyntax = """
        enum CodingKeys: String, CodingKey {
            \(raw: codingKeyCases.joined(separator: "\n"))
        }
        """
        
        return [codingKeys]
    }
    
    private static func snakeCase(_ name: String) -> String {
        var result = ""
        
        for character in name {
            if character.isUppercase {
                result += "_"
                result += character.lowercased()
            } else {
                result += String(character)
            }
        }
        return result
    }
}

@main
struct GenerateCodingKeysPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        GenerateCodingKeysMacro.self
    ]
}
