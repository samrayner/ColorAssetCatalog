# ColorAssetCatalog

This Pod adds iOS 9+ compatibility for named colors in asset catalogs.

It extends UIColor with a new optional initializer: `UIColor(asset:)` that works in the same way as `UIColor(named:)`.

This will only work in code. **Named colors set in Interface Builder will still not work on iOS 9 or 10!**

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9+
- Xcode 9+
- Swift 4

## Installation

1. Add  `pod "ColorAssetCatalog"` to your Podfile
2. Run `pod install`
3. Add an Asset Catalog to your project called _Colors.xcassets_
4. Add a _New Copy Files Phase_ to your target that copies _Colors.xcassets_ to the _Resources_ destination (leave _Subpath_ blank)

## Notes

- Copying `Colors.xcassets` to your app's Resources directory bypasses Apple's optimisations around Asset Catalogs. Think carefully whether this solution is right for you.
- You can name your `.xcassets` file something else: declare `ColorAssetManager.shared.catalogName = "OtherName"` before using `UIColor(asset:)`.
- You can set the Bundle where your asset catalog resides: set `ColorAssetManager.shared.bundle` before using `UIColor(asset:)` or use `UIColor(asset:in:compatibleWith:)`.
- On iOS 11+, `UIColor(asset:)` just calls the native `UIColor(named:)`.
- By default, colors are lazily loaded to avoid re-parsing the asset JSON on subsequent use. Cached colors are released if the app receives a memory warning.
- You can disable in-memory caching of colors using `ColorAssetManager.shared.cachingEnabled = false`.
- Device-specific colors are supported except _Watch_ and _Mac_. You can toggle them for the Color Set in the Inspector.
- P3 (wide gamut) specific colors are supported on iOS 10+. You can toggle them for the Color Set in the Inspector.

## Author

Sam Rayner, <http://www.samrayner.com>

## License

ColorAssetCatalog is available under the MIT license. See the LICENSE file for more info.

[tw]: http://twitter.com/samrayner
