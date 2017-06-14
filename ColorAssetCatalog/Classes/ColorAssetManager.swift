//
//  ColorAssetManager.swift
//  ColorAssetCatalog
//
//  Created by Sam Rayner on 12/06/2017.
//

class ColorAssetManager {
    static let shared = ColorAssetManager()
    var catalogName = "Colors"
    var cachingEnabled = true
    var cgColors: [String: CGColor] = [:]

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearCache), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
    }

    @objc func clearCache() {
        cgColors.removeAll()
    }

    func asset(named name: String) -> ColorAsset? {
        guard let dir = Bundle.main.resourceURL?.appendingPathComponent("\(catalogName).xcassets"),
            let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil, options: []),
            let colorset = files.first(where: { $0.lastPathComponent == "\(name).colorset" }),
            let data = try? Data(contentsOf: colorset.appendingPathComponent("Contents.json")),
            let catalog = try? JSONDecoder().decode(ColorAssetCatalog.self, from: data)
            else {
                return nil
        }

        var universalAssets: [ColorAsset] = []
        var idiomAssets: [ColorAsset] = []

        for color in catalog.colors {
            switch color.idiom {
            case UIDevice.current.userInterfaceIdiom?:
                idiomAssets.append(color)
            case .unspecified?:
                universalAssets.append(color)
            default:
                break
            }
        }

        let assets = idiomAssets + universalAssets

        if #available(iOS 10, *) {
            if UIScreen.main.traitCollection.displayGamut == .P3 {
                let p3Assets = assets.filter { $0.color.displayGamut == .P3 }
                return p3Assets.first ?? assets.first
            }
        }

        return assets.first
    }

    func cgColor(named name: String) -> CGColor? {
        if let cached = cgColors[name], cachingEnabled {
            return cached
        }

        let cgColor = asset(named: name)?.cgColor

        if cachingEnabled {
            cgColors[name] = cgColor
        }

        return cgColor
    }
}
