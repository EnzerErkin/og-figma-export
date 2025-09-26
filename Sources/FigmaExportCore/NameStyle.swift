import Foundation

public enum NameStyle: String, Decodable {
    case camelCase = "camelCase"
    case snakeCase = "snake_case"
    case ogVariable = "ogVariable"  // OGAssetsFetcher variable naming
}
