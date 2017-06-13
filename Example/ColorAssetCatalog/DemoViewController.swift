//
//  DemoViewController.swift
//  ColorAssetCatalog
//
//  Created by Sam Rayner on 06/12/2017.
//  Copyright (c) 2017 Sam Rayner. All rights reserved.
//

import UIKit
import ColorAssetCatalog

class DemoViewController: UIViewController {
    let colorNames = ["universal", "device-specific", "p3", "missing"]

    var currentColorName: String? {
        didSet {
            guard let currentColorName = currentColorName else { return }
            navigationItem.title = currentColorName
            view.backgroundColor = UIColor(asset: currentColorName)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        advanceColor()
    }

    @objc func didTap(_ sender: UITapGestureRecognizer) {
        advanceColor()
    }

    func nextColorName() -> String? {
        guard let currentColorName = currentColorName else { return colorNames.first }
        let currentIndex = colorNames.index(of: currentColorName) ?? 0
        let nextIndex = (currentIndex >= colorNames.count - 1) ? 0 : currentIndex + 1
        return colorNames[nextIndex]
    }

    func advanceColor() {
        currentColorName = nextColorName()
    }
}
