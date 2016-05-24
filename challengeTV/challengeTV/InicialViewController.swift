//
//  InicialViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 11/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class InicialViewController: UIViewController {

    @IBOutlet weak var instrucoes: UIButton!
    @IBOutlet weak var jogos: UIButton!
    @IBOutlet weak var imgDemo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {

        if jogos.focused == true{
            imgDemo.image = UIImage(named: "BotãoJogar.png")
        } else if instrucoes.focused == true{
            imgDemo.image = UIImage(named: "BotãoAprender.png")
        }
    }
}
