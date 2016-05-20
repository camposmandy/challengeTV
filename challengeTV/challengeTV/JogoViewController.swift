
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
    func embaralhar(c: Array<String>) -> Array<String> {
        var cartasEmbaralhadas: Array<String> = []
        for i in c{
                let randomico = Int( arc4random() % UInt32(c.count))
                print(i)
                cartasEmbaralhadas.append(c[randomico])
        }
        return cartasEmbaralhadas
    }
}
