//
//  botaoFocadoView.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 20/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class botaoFocadoView: UIButton {

    override func canBecomeFocused() -> Bool {
        return true
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if context.nextFocusedView == self {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                context.nextFocusedView?.transform = CGAffineTransformMakeScale(1.20, 1.20)
            })
        }
        
        if context.previouslyFocusedView == self {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                context.previouslyFocusedView?.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
        }
    }

}
