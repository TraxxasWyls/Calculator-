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

    @IBInspectable var roundButton: Bool = false {
        didSet{
            if roundButton {
                clipsToBounds = true
                layer.cornerRadius = frame.height/2
                
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
