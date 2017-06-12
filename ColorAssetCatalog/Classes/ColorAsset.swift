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
        idiom = ColorAssetCatalog.idiom(string: idiomString)
        guard let color = json["color"] as? [String: Any] else { return nil }
        guard let colorSpaceString = color["color-space"] as? String else { return nil }
        colorSpace = ColorAssetCatalog.colorSpace(string: colorSpaceString)
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

    var cgColor: CGColor? {
        guard let colorSpace = colorSpace else { return nil }
        return CGColor(colorSpace: colorSpace, components: [red, green, blue, alpha])
    }
}
