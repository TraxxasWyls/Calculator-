//
//  RoundButton.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    private var animator = UIViewPropertyAnimator()
    @objc private func touchDown() {
        animator.stopAnimation(true)
        if tag < 11{
        backgroundColor = #colorLiteral(red: 0.4517944455, green: 0.4469253421, blue: 0.4469245672, alpha: 1)
        }
        if tag >= 11 && tag < 16{
        backgroundColor = #colorLiteral(red: 0.9839183688, green: 0.7829335332, blue: 0.5527208447, alpha: 1)
        }
        if tag >= 16{
        backgroundColor = #colorLiteral(red: 0.8367859125, green: 0.8406593204, blue: 0.8501242399, alpha: 1)
        }
    }
    @objc private func touchUp() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: {
            if self.tag < 11{
                self.backgroundColor = #colorLiteral(red: 0.195169121, green: 0.2001754642, blue: 0.2000474632, alpha: 1)
            }
            if self.tag >= 11 && self.tag < 16{
                self.backgroundColor = #colorLiteral(red: 0.9968238473, green: 0.6216773987, blue: 0.04547973722, alpha: 1)
            }
            if self.tag >= 16{
                self.backgroundColor = #colorLiteral(red: 0.6665927172, green: 0.6667093635, blue: 0.666585207, alpha: 1)
            }
        })
        animator.startAnimation()
    }
    @IBInspectable var roundButton: Bool = false {
        didSet{
            if roundButton {
                clipsToBounds = true
                layer.cornerRadius = frame.height/2
                addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
                addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton{
            clipsToBounds = true
            layer.cornerRadius = frame.height/2
        }
    }

}
