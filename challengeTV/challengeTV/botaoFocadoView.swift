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
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        if context.nextFocusedView == self {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                context.nextFocusedView!.backgroundColor = UIColor.whiteColor()
                self.setTitleColor(UIColor(red: 249/255, green: 90/255, blue: 34/255, alpha: 1.0), forState: .Focused)
                context.nextFocusedView?.transform = CGAffineTransformMakeScale(1.20, 1.20)
                
            })
        }
        
        if context.previouslyFocusedView == self {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                context.previouslyFocusedView?.transform = CGAffineTransformMakeScale(1.0, 1.0)
                context.previouslyFocusedView!.backgroundColor = UIColor(red: 249/255, green: 90/255, blue: 34/255, alpha: 1.0)
            })
        }
    }

}
