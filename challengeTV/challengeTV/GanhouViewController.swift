//
//  GanhouViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 24/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class GanhouViewController: UIViewController {
    
    /* MARK: - Outlet */
    @IBOutlet weak var mensagemFimJogo: UILabel!
    
    /* MARK: - Variaveis */
    var confetes : Animacao?
    var score    : String!
    var mensagem : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mensagem e tempo (falta o tempo)
        mensagemFimJogo.text = mensagem
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(GanhouViewController.tapped))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue as Int)]
        
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapped(){
        print("show")
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        confetes = Animacao(frame: CGRect(x: 0, y: 0, width: view.frame.size.width * 2, height: view.frame.size.height * 2))
        confetes?.flakesCount = 300
        view.insertSubview(confetes!, at: 1)
        confetes?.startSnow()
    }
    
    @IBAction func menu(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func niveis(_ sender: AnyObject) {
        for viewController in self.navigationController!.viewControllers {
            if let _ = viewController as? NivelViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
    
    @IBAction func jogarNovamente(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
