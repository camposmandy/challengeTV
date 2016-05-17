//
//  InicialViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 11/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class InicialViewController: UIViewController {

    @IBOutlet weak var jogosButton: UIButton!
    @IBOutlet weak var instrucoesButton: UIButton!
    @IBOutlet weak var imgDemo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if instrucoesButton.selected == true {
            print("entrou")
            imgDemo.image = UIImage(named: "milkshake.png")
        } else if jogosButton.selected == true {
            print("entrou")
            imgDemo.image = UIImage(named: "bala3.png")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
