//
//  FittableFontLabel.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 28.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

// MARK: - FittableFontLabel

// An UILabel subclass allowing you to automatize the process of adjusting the font size.
open class FittableFontLabel: UILabel {

    // MARK: - Properties

    /// If true, the font size will be adjusted each
    /// time that the text or the frame change.
    public var autoAdjustFontSize: Bool = true

    /// The biggest font size to use during drawing.
    /// The default value is the current font size
    public var maxFontSize: CGFloat = .nan

    /// The scale factor that determines the smallest
    /// font size to use during drawing. The default value is 0.1
    public var minFontScale: CGFloat = .nan

    /// Left inset value
    public var leftInset: CGFloat = 0

    /// Right inset value
    public var rightInset: CGFloat = 0

    /// Top inset value
    public var topInset: CGFloat = 0

    /// Bottom inset value
    public var bottomInset: CGFloat = 0

    // MARK: - UILabel

    open override var text: String? {
        didSet {
            adjustFontSize()
        }
    }

    open override var frame: CGRect {
        didSet {
            adjustFontSize()
        }
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        adjustFontSize()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        adjustFontSize()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        adjustFontSize()
    }

    open override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    // MARK: - Private

    private func adjustFontSize() {
        if autoAdjustFontSize {
            fontSizeToFit(maxFontSize: maxFontSize, minFontScale: minFontScale)
        }
    }
}

