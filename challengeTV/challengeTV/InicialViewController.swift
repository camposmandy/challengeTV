//
//  InicialViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 11/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit
import AVFoundation

class InicialViewController: UIViewController {

    @IBOutlet weak var instrucoes: UIButton!
    @IBOutlet weak var jogos: UIButton!
    @IBOutlet weak var imgDemo: UIImageView!
    
    var musicaDeFundo: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tocarmusica()
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
    
    func tocarmusica() {
        let url = NSBundle.mainBundle().URLForResource("Memorizando", withExtension: "mp3")!
        
        do {
            musicaDeFundo = try AVAudioPlayer(contentsOfURL: url)
            guard let player = musicaDeFundo else { return }
            
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
}
