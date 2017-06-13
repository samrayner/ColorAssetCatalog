//
//  ColorAsset.swift
//  ColorAssetCatalog
//
//  Created by Sam Rayner on 12/06/2017.
//

struct ColorAsset {
    var idiom: UIUserInterfaceIdiom?
    var colorSpace: CGColorSpace?
    var alpha: CGFloat = 1
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0

    init?(json: [String: Any]) {
        guard let idiomString = json["idiom"] as? String else { return nil }
        idiom = idiom(string: idiomString)
        guard let color = json["color"] as? [String: Any] else { return nil }
        guard let colorSpaceString = color["color-space"] as? String else { return nil }
        colorSpace = colorSpace(string: colorSpaceString)
        guard let components = color["components"] as? [String: CGFloat] else { return nil }
        alpha = components["alpha"] ?? 1

        if let w = components["white"] {
            red = w
            green = w
            blue = w
        }

        if let r = components["red"] { red = r }
        if let g = components["green"] { green = g }
        if let b = components["blue"] { blue = b }
    }

    func idiom(string: String) -> UIUserInterfaceIdiom? {
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

    func colorSpace(string: String) -> CGColorSpace? {
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

    var cgColor: CGColor? {
        guard let colorSpace = colorSpace else { return nil }
        return CGColor(colorSpace: colorSpace, components: [red, green, blue, alpha])
    }
}
