import Foundation
import FigmaExportCore

final public class XcodeIconsExporter: XcodeImagesExporterBase {

    public func export(icons: [AssetPair<ImagePack>], append: Bool) throws -> [FileContents] {
        var result: [FileContents] = []
        
        // Skip asset generation if in code-only mode
        if !output.codeOnly {
            // Generate metadata (Assets.xcassets/Icons/Contents.json)
            let contentsFile = XcodeEmptyContents().makeFileContents(to: output.assetsFolderURL)
            result.append(contentsFile)

            // Generate assets
            let assetsFolderURL = output.assetsFolderURL
            let preservesVectorRepresentation = output.preservesVectorRepresentation
            let filter = AssetsFilter(filters: preservesVectorRepresentation ?? [])
            
            let imageAssetsFiles = try icons.flatMap { imagePack -> [FileContents] in
                let preservesVector = filter.match(name: imagePack.light.name)
                return try imagePack.makeFileContents(to: assetsFolderURL, preservesVector: preservesVector, renderMode: imagePack.light.renderMode)
            }
            result.append(contentsOf: imageAssetsFiles)
        }
        
        // Always generate extensions (Swift code)
        let imageNames = icons.map { normalizeName($0.light.name) }
        let extensionFiles = try generateExtensions(names: imageNames, append: append)
        result.append(contentsOf: extensionFiles)

        return result
    }

}
