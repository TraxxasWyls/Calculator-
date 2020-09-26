//
//  CopyableLabel.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 24.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - SelectableLabel

final class SelectableLabel: UILabel {

    // MARK: - Properties

    var pasteAction: ((String) -> ())?

    private let selectionOverlay: CALayer = {
        let layer = CALayer()
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.14).cgColor
        layer.isHidden = true
        return layer
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextSelection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextSelection()
    }

    // MARK: - UILabel

    override func layoutSubviews() {
        super.layoutSubviews()
        selectionOverlay.frame = textRect()
    }

    override var canBecomeFirstResponder: Bool {
        true
    }

    override func resignFirstResponder() -> Bool {
        cancelSelection()
        return super.resignFirstResponder()
    }

    // MARK: - Private
    
    private func setupTextSelection() {
        layer.addSublayer(selectionOverlay)
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(didLongPress)
        )
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didHideMenu),
            name: UIMenuController.didHideMenuNotification,
            object: nil
        )
    }

    private func cancelSelection() {
        let menu = UIMenuController.shared
        menu.setMenuVisible(false, animated: true)
    }

    private func textRect() -> CGRect {
        let inset: CGFloat = -4
        return textRect(
            forBounds: bounds,
            limitedToNumberOfLines: numberOfLines
        ).insetBy(
            dx: 3 * inset,
            dy: -0.5 * inset
        )
    }

    private func menuForSelection() -> UIMenuController {
        let menu = UIMenuController.shared
        menu.menuItems = [
            UIMenuItem(title: "Copy", action: #selector(copyText)),
            UIMenuItem(title: "Paste", action: #selector(pasteText)),
            UIMenuItem(title: "Add", action: #selector(addText)),
            UIMenuItem(title: "Speak", action: #selector(speakText))
        ]
        return menu
    }

    // MARK: - Actions
    
    @objc private func didHideMenu(_ notification: Notification) {
        selectionOverlay.isHidden = true
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let text = text, !text.isEmpty else { return }
        becomeFirstResponder()
        let menu = menuForSelection()
        if !menu.isMenuVisible {
            selectionOverlay.isHidden = false
            menu.setTargetRect(textRect(), in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }

    @objc private func addText(_ sender: Any?) {
        cancelSelection()
        if let myString = UIPasteboard.general.string, let text = text {
            pasteAction?(text + myString)
            if text == "0" || text == "nan" || text == "inf" || text == "-inf" {
                pasteText(myString)
            } else {
                self.text = (text + myString).prepareForCreate().createOutput()
            }
        }
    }
    
    @objc private func pasteText(_ sender: Any?) {
        cancelSelection()
        if let myString = UIPasteboard.general.string {
            pasteAction?(myString)
            text = myString.prepareForCreate().createOutput()
        }
    }
    
    @objc private func copyText(_ sender: Any?) {
        cancelSelection()
        let board = UIPasteboard.general
        board.string = text
    }
    
    @objc private func speakText(_ sender: Any?) {
        cancelSelection()
        guard let text = text, !text.isEmpty else { return }
        if #available(iOS 10.0, *) {
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: .duckOthers)
        }
        let speechSynthesizer = AVSpeechSynthesizer()
        speechSynthesizer.delegate = self
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .word)
        }
        let utterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(utterance)
    }
}

// MARK: - AVSpeechSynthesizerDelegate

extension SelectableLabel: AVSpeechSynthesizerDelegate {

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        try? AVAudioSession.sharedInstance().setActive(false)
    }
}
