//
//  UIColor+ColorAssetCatalog.swift
//  ColorAssetCatalog
//
//  Created by Sam Rayner on 12/06/2017.
//

public extension UIColor {
    public convenience init?(asset name: String) {
        if #available(iOS 11.0, *) {
            self.init(named: name)
        } else {
            guard let cgColor = ColorAssetManager.shared.cgColor(named: name) else { return nil }
            self.init(cgColor: cgColor)
        }
    }
}
