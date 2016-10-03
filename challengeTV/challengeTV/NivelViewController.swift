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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "um"{
        let vc = segue.destination as! NivelUmViewController
            vc.nomeCategoria = c
        } else if segue.identifier == "dois"{
            let vc = segue.destination as! NivelDoisViewController
            vc.nomeCategoria = c
        }  else if segue.identifier == "tres"{
            let vc = segue.destination as! NivelTresViewController
            vc.nomeCategoria = c
        } else if segue.identifier == "quatro"{
            let vc = segue.destination as! NivelQuatroViewController
            vc.nomeCategoria = c
        } else {
            let vc = segue.destination as! NivelCincoViewController
            vc.nomeCategoria = c
        }
    }
}
