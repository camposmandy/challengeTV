
//
//  JogoViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 11/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class JogoViewController: NSObject {

    var cartas = [String]()

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
}
