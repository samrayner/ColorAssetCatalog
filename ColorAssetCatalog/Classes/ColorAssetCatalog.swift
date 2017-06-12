//
//  ColorAssetCatalog.swift
//  ColorAssetCatalog
//
//  Created by Sam Rayner on 12/06/2017.
//

class ColorAssetCatalog {
    static let shared = ColorAssetCatalog()
    var catalogName = "Colors"
    var cachingEnabled = true
    var cgColors: [String: CGColor] = [:]

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearCache), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
    }

    @objc func clearCache() {
        cgColors.removeAll()
    }

    static func idiom(string: String) -> UIUserInterfaceIdiom? {
        switch string {
        case "universal":
            return .unspecified
        case "iphone":
            return .phone
        case "ipad":
            return .pad
        case "tv":
            return .tv
        default:
            return nil
        }
    }

    static func colorSpace(string: String) -> CGColorSpace? {
        switch string {
        case "srgb":
            return CGColorSpace(name: CGColorSpace.sRGB)
        case "display-P3":
            if #available(iOS 9.3, *) {
                return CGColorSpace(name: CGColorSpace.displayP3)
            } else {
                return CGColorSpace(name: CGColorSpace.sRGB)
            }
        case "gray-gamma-22":
            return CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)
        case "extended-gray":
            if #available(iOS 10.0, *) {
                return CGColorSpace(name: CGColorSpace.extendedGray)
            } else {
                return CGColorSpace(name: CGColorSpace.genericGrayGamma2_2)
            }
        case "extended-srgb":
            if #available(iOS 10.0, *) {
                return CGColorSpace(name: CGColorSpace.extendedSRGB)
            } else {
                return CGColorSpace(name: CGColorSpace.sRGB)
            }
        case "extended-linear-srgb":
            if #available(iOS 10.0, *) {
                return CGColorSpace(name: CGColorSpace.extendedLinearSRGB)
            } else {
                return CGColorSpace(name: CGColorSpace.genericRGBLinear)
            }
        default:
            return CGColorSpace(name: CGColorSpace.sRGB)
        }
    }

    func asset(named name: String) -> ColorAsset? {
        guard let catalog = Bundle.main.resourceURL?.appendingPathComponent("\(catalogName).xcassets"),
            let files = try? FileManager.default.contentsOfDirectory(at: catalog, includingPropertiesForKeys: nil, options: []),
            let colorset = files.first(where: { $0.lastPathComponent == "\(name).colorset" }),
            let data = try? Data(contentsOf: colorset.appendingPathComponent("Contents.json")),
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonColors = (json as? [String: Any])?["colors"] as? [[String: Any]]
            else {
                return nil
        }

        var universalAsset: ColorAsset?
        var idiomAsset: ColorAsset?

        for colorJson in jsonColors {
            guard let color = ColorAsset(json: colorJson) else { continue }
            switch color.idiom {
            case UIDevice.current.userInterfaceIdiom?:
                idiomAsset = color
            case .unspecified?:
                universalAsset = color
            default:
                break
            }
        }

        return idiomAsset ?? universalAsset
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
