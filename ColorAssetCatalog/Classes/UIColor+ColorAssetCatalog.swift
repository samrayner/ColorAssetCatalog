//
//  UIColor+ColorAssetCatalog.swift
//  ColorAssetCatalog
//
//  Created by Sam Rayner on 12/06/2017.
//

public extension UIColor {
    /**
     Loads a color from an asset catalog.
     On iOS 11 this aliases init(named:).
     On iOS 9 or 10 this uses ColorAssetManager.

     You can configure the asset catalog to use:

     ```
     ColorAssetManager.shared.catalogName = "MyColors"
     ```

     - Parameter name: The name of the color in the asset catalog.
     - Returns: A UIColor or nil if a color is not found of that name.
     */
    public convenience init?(asset name: String) {
        if #available(iOS 11.0, *) {
            self.init(named: name)
        } else {
            guard let cgColor = ColorAssetManager.shared.cgColor(named: name) else { return nil }
            self.init(cgColor: cgColor)
        }
    }

    /**
     Loads a color from an asset catalog.
     On iOS 11 this aliases init(named:in:compatibleWith:).
     On iOS 9 or 10 this uses ColorAssetManager.

     You can configure the asset catalog to look for colors:

     ```
     ColorAssetManager.shared.catalogName = "MyColors"
     ```

     - Parameter name: The name of the color in the asset catalog.
     - Returns: A UIColor or nil if a color is not found of that name.
     */
    public convenience init?(asset name: String, in bundle: Bundle?, compatibleWith traitCollection: UITraitCollection?) {
        if #available(iOS 11.0, *) {
            self.init(named: name, in: bundle, compatibleWith: traitCollection)
        } else {
            let originalBundle = ColorAssetManager.shared.bundle
            ColorAssetManager.shared.bundle = bundle
            guard let cgColor = ColorAssetManager.shared.cgColor(named: name) else { return nil }
            self.init(cgColor: cgColor)
            ColorAssetManager.shared.bundle = originalBundle
        }
    }
}
