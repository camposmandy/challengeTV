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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        bolas = BolasBasqueteCaindo(frame: CGRectMake(0, 0, view.frame.size.width * 2, view.frame.size.height * 2))
        bolas?.flakesCount = 100
        view.insertSubview(bolas!, atIndex: 1)
        bolas?.startSnow()
    }

}
