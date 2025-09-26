import Foundation
import FigmaExportCore

final public class XcodeImagesExporter: XcodeImagesExporterBase {

    public func export(assets: [AssetPair<ImagePack>], append: Bool) throws -> [FileContents] {
        var result: [FileContents] = []
        
        // Skip asset generation if in code-only mode
        if !output.codeOnly {
            // Generate metadata (Assets.xcassets/Illustrations/Contents.json)
            let contentsFile = XcodeEmptyContents().makeFileContents(to: output.assetsFolderURL)
            result.append(contentsFile)

            let imageAssetsFiles = try assets.flatMap { pair -> [FileContents] in
                try pair.makeFileContents(to: output.assetsFolderURL, preservesVector: nil, renderMode: nil)
            }
            result.append(contentsOf: imageAssetsFiles)
        }

        // Always generate extensions (Swift code)
        let imageNames = assets.map { normalizeName($0.light.name) }
        let extensionFiles = try generateExtensions(names: imageNames, append: append)
        result.append(contentsOf: extensionFiles)

        return result
    }

}
