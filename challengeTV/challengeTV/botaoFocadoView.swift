//
//  botaoFocadoView.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 20/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class botaoFocadoView: UIButton {

    override var canBecomeFocused : Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        if context.nextFocusedView == self {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                context.nextFocusedView!.backgroundColor = UIColor.white
                self.setTitleColor(UIColor(red: 249/255, green: 90/255, blue: 34/255, alpha: 1.0), for: .focused)
                context.nextFocusedView?.transform = CGAffineTransform(scaleX: 1.20, y: 1.20)
                
            })
        }
        
        if context.previouslyFocusedView == self {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                context.previouslyFocusedView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                context.previouslyFocusedView!.backgroundColor = UIColor(red: 249/255, green: 90/255, blue: 34/255, alpha: 1.0)
                
            })
        }
    }

}
