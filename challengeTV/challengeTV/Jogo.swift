//
//  Jogo.swift
//  challengeTV
//
//  Created by Amanda Campos on 25/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class Jogo: NSObject {
    
        var cartas = [String]()
        var categoria = String()
        var bolas = BolasBasqueteCaindo()
    
        //Tem a função de embaralhar as cartas do jogos para não estarem sempre na mesma posição.
        func embaralhar(c: [String]) -> [String] {
            var cartas = c
            
            for i in 0..<c.count {
                let j = Int(arc4random_uniform(UInt32(cartas.count)))
                if j != i {
                    swap(&cartas[i], &cartas[j])
                }
            }
            return cartas
        }
        
        func interacao(cartas: [UIButton], status: Bool){
            for c in cartas{
                c.userInteractionEnabled = status
            }
        }
    
    func ganhouJogo(view: UIView){
        bolas = BolasBasqueteCaindo(frame: CGRectMake(0, 0, view.frame.size.width * 2, view.frame.size.height * 2))
        bolas.flakesCount = 100
        view.insertSubview(bolas, atIndex: 1)
        bolas.startSnow()
    }
        func animacaoAcerto(sender: UIButton){
            UIView.beginAnimations("teste", context: nil)
            UIView.setAnimationDuration(1.0)
            sender.transform = CGAffineTransformMakeScale(1.8, 1.8)
            sender.alpha = 1.0
            UIView.commitAnimations()
            
            UIView.beginAnimations("teste", context: nil)
            UIView.setAnimationDuration(1.0)
            sender.transform = CGAffineTransformMakeScale(1, 1)
            sender.alpha = 1.0
            UIView.commitAnimations()
        }
        
        func animacaoErro(sender: UIButton){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 250), dispatch_get_main_queue()) {
                sender.setBackgroundImage(UIImage(named: "Parte de tras"), forState: .Normal)
            }
            UIView.transitionWithView(sender, duration: 0.5, options: .TransitionFlipFromLeft, animations: {
                }, completion: nil)
        }
        
    }

