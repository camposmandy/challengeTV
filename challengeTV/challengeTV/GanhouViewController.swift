//
//  GanhouViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 24/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class GanhouViewController: UIViewController {
    
    var bolas: BolasBasqueteCaindo?
    var confete: Animacao2?
    var confetee: Animacao3?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(GanhouViewController.tapped))
        tapRecognizer.allowedPressTypes = [NSNumber(integer:UIPressType.Menu.rawValue)]
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapped(){
        print("show")
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
        bolas = BolasBasqueteCaindo(frame: CGRectMake(0, 0, view.frame.size.width * 2, view.frame.size.height * 2))
        bolas?.flakesCount = 100
        view.insertSubview(bolas!, atIndex: 1)
        bolas?.startSnow()
        
        confete = Animacao2(frame: CGRectMake(0, 0, view.frame.size.width * 2, view.frame.size.height * 2))
        confete?.flakesCount = 100
        view.insertSubview(confete!, atIndex: 1)
        confete?.startSnow()
        
        confetee = Animacao3(frame: CGRectMake(0, 0, view.frame.size.width * 2, view.frame.size.height * 2))
        confetee?.flakesCount = 100
        view.insertSubview(confetee!, atIndex: 1)
        confetee?.startSnow()
    }

    @IBAction func menu(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(false)
        
    }
    @IBAction func niveis(sender: AnyObject) {
        
        for viewController in self.navigationController!.viewControllers {
            if let _ = viewController as? NivelViewController {
                self.navigationController?.popToViewController(viewController, animated: false)
            }
        }
        
    }
    @IBAction func jogarNovamente(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
