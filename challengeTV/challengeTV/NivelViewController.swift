//
//  NivelViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 11/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class NivelViewController: UIViewController {
    
    var c = String()
    
    @IBOutlet weak var categoria: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if c == "CategoriaAnimais.png"{
            c = "Animais"
        } else if c == "CategoriaFrutas.png"{
            c = "Frutas"
        } else {
            c = "Números"
        }
        
        categoria.text = c
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let vc = segue.destinationViewController as! NivelUmViewController
        vc.nomeCategoria = c
    }
}
