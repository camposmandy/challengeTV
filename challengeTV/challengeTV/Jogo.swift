//
//  Jogo.swift
//  challengeTV
//
//  Created by Amanda Campos on 25/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class Jogo: NSObject {
    
    var tempo : TimeInterval = 60
    var tempoRef : TimeInterval = 60
    
    /* MARK: - Cartas */
    
    // Tem a função de embaralhar as cartas do jogos para não estarem sempre na mesma posição.
    func embaralhar(_ c: [String]) -> [String] {
        var cartas = c
        
        for i in 0..<c.count {
            let j = Int(arc4random_uniform(UInt32(cartas.count)))
            if j != i {
                swap(&cartas[i], &cartas[j])
            }
        }
        return cartas
    }
    
    // Set do estado das cartas. Se elas podem ser tocadas ou não, de acordo com a situação.
    func interacao(_ cartas: [UIButton], status: Bool){
        for c in cartas{
            c.isUserInteractionEnabled = status
        }
    }
    
    /* MARK: - Animações das cartas */
    
    func animacaoAcerto(_ sender: UIButton){
        UIView.beginAnimations("teste", context: nil)
        UIView.setAnimationDuration(1.0)
        sender.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        sender.alpha = 1.0
        UIView.commitAnimations()
        
        UIView.beginAnimations("teste", context: nil)
        UIView.setAnimationDuration(1.0)
        sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        sender.alpha = 1.0
        UIView.commitAnimations()
    }
    
    func animacaoErro(_ sender: UIButton){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(250) / Double(NSEC_PER_SEC)) {
            sender.setBackgroundImage(UIImage(named: "Parte de tras"), for: UIControlState())
        }
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            }, completion: nil)
    }
    
    /* MARK: - Barra de progresso */
    
    func atualizarTempo(_ barra: UIProgressView) -> String{
        
        // Decrementa o tempo
        tempo -= 0.1
        
        // Comparação para não mostrar números negativos
        if tempo <= 0 {
            tempo = 0
        }
        
        // Atualiza a barra
        barra.progress = Float(tempo/tempoRef)
        
        let tempoString = NSString(format: "Tempo = %.1f", tempo)
        
        // Muda a cor da barra para vermelho qnd esta perto do fim
        if barra.progress < 0.2 {
            barra.progressTintColor = UIColor.red
        }
        
        return  "\(tempoString)"
    }
    
}

