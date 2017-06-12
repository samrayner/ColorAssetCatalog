# ColorAssetCatalog

This Pod adds iOS 9+ backwards compatibility for named colors in asset catalogs.

It extends UIColor with a new optional initializer: `UIColor(asset: "<name of Color Set in Colors.xcassets>")`

This will only work in code. **Named colors set in Interface Builder will still not work on iOS 9 or 10!**

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Xcode 9+
- iOS 9+

## Installation

1. Add  `pod "ColorAssetCatalog"` your Podfile
2. Run `pod install`
3. Add an Asset Catalog to your project called _Colors.xcassets_
4. Add a _New Copy Files Phase_ to your target that copies _Colors.xcassets_ to the _Resources_ destination (leave _Subpath_ blank)

## Notes

- On iOS 11+, `UIColor(asset:)` will return the native `UIColor(named:)`
- Copying `Colors.xcassets` to your app's Resources like this bypasses Apple's optimisations around Asset Catalogs. Think carefully whether this hacky solution is right for you.
- Colors are lazily loaded to avoid re-parsing the asset JSON on subsequent use. All cached colors are released when the app receives a memory warning.
- Device-specific colors are supported except _Watch_ and _Mac_. You can toggle them for the Color Set in the Inspector.
- If P3 (wide color gamut) colors are provided they are given preference (whether or not the device has a P3 display). Please tweet [@samrayner][tw] if you know of a way to detect whether a device has a P3 display at run-time.

## Author

Sam Rayner, <http://samrayner.com>

## License

ColorAssetCatalog is available under the MIT license. See the LICENSE file for more info.

[tw]: http://twitter.com/samrayner
