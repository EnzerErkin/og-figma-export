# og-figma-export

Otto Group's customized fork of FigmaExport for the Blossom iOS monorepo.

Export colors, typography, icons and images from Figma to Swift code and Xcode asset catalogs.

## Overview

This tool exports design assets from Figma files to generate:
- **Swift code**: `OGColors.generated.swift`, `OGFonts.generated.swift`, `OGImages.generated.swift`
- **Asset catalogs**: Per-app `Assets.xcassets` files
- **Typography labels**: Custom UILabel classes with proper styling

## Setup

### Prerequisites

1. **Figma Personal Access Token**: Add to `.env-vars` file:
   ```bash
   FIGMA_PERSONAL_TOKEN=your_token_here
   ```
   Generate token at: https://www.figma.com/developers/api#access-tokens

2. **Build the tool**:
   ```bash
   make build-figma-export
   ```

## Usage

### Master Design Export (OGKit)

Export shared Swift files from master design system:

```bash
make refresh-design-master-assets
```

This generates:
- `UICatalog/Sources/CodeGenerated/OGColors.generated.swift` (17+ colors)
- `UICatalog/Sources/CodeGenerated/OGImages.generated.swift` (100+ icons/images/logos)
- `UICatalog/Sources/CodeGenerated/OGFonts.generated.swift` (24+ typography styles)
- `UICatalog/Sources/CodeGenerated/Typography/` (Label classes)

### Per-App Asset Export

Export app-specific assets to asset catalogs:

```bash
make refresh-assets target=LAS  # or SHE, MAN, etc.
```

### Individual Export Commands

Test specific asset types:

```bash
make test-figma-colors      # Test color export
make test-figma-icons       # Test icon export  
make test-figma-images      # Test image export
make test-figma-typography  # Test typography export
```

## Configuration

### Master Design Config

File: `figma-config/OGKit.yaml`
- Exports Swift code only (no assets)
- Uses master Figma design file
- Generates shared code for all apps

### Per-App Configs

Files: `figma-config/LAS.yaml`, `figma-config/SHE.yaml`, etc.
- Export assets only (no Swift code)
- Populate app-specific asset catalogs
- Use app-specific Figma files

## Templates

Custom Stencil templates located in:
```
og-figma-export/Sources/XcodeExport/Resources/
├── OGColors/OGColors.stencil
├── OGFonts/OGFonts.stencil
├── OGImages/OGImages.stencil
└── ...
```

## Output Structure

### Swift Code (Master Design)
```
UICatalog/Sources/CodeGenerated/
├── OGColors.generated.swift     # Color variables
├── OGImages.generated.swift     # Image assets  
├── OGFonts.generated.swift      # Typography enum
└── Typography/
    ├── Label.swift              # Custom label classes
    └── LabelStyle.swift         # Styling helpers
```

### Asset Catalogs (Per-App)
```
Apps/LAS/Resources/Assets.xcassets/
├── Colors/
├── Icons/
└── Images/
```

## Generated Code Examples

### Colors
```swift
public enum OGColors {
    public static let accentDanger = OGColorAsset("AccentDanger")
    public static let backgroundPrimary = OGColorAsset("BackgroundPrimary")
    // ...
}
```

### Images
```swift
public enum OGImages {
    public static let icon24x24Account = OGImageAsset("icon24x24Account")
    public static let logoNavigationBar = OGImageAsset("logoNavigationBar")
    // ...
}
```

### Typography
```swift
public enum OGFonts {
    case buttonLabelM
    case headlineXL
    case copyL
    // ...
}
```

## Design Requirements

### Colors
- Use Figma color styles or variables
- Follow naming convention: `AccentDanger`, `BackgroundPrimary`

### Icons
- Place in "Icons" frame in Figma Components
- Naming: `icon24x24Account`, `icon16x16Search`
- Export as PDF with template rendering

### Images
- Place in "Illustrations" or "Images & Logos" frames
- Support both illustrations and logos
- Export as PNG

### Typography
- Use Figma text styles
- Proper font families and sizing
- Line height and letter spacing support

## Troubleshooting

### Empty Output
- Ensure Figma components are published to team library
- Check frame names match configuration
- Verify `FIGMA_PERSONAL_TOKEN` is valid

### Build Issues
```bash
# Clean and rebuild
cd og-figma-export
swift build --clean
swift build -c release
```

### Template Issues
- Check Stencil template syntax
- Verify variable names match exporter context
- Rebuild after template changes: `make build-figma-export`

## Development

This fork includes Otto Group specific customizations:
- Custom Stencil templates for OG design system
- Merged icon/image/logo export pipeline  
- Enhanced asset naming conventions
- Integration with Blossom monorepo structure

## Links

- [Figma API Documentation](https://www.figma.com/developers/api)
- [Original FigmaExport](https://github.com/RedMadRobot/figma-export)
- [Stencil Template Engine](https://stencil.fuller.li/)