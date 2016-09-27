//
//  InicialViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 11/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit
import AVFoundation
import GameKit

class InicialViewController: UIViewController {
    
    /* MARK: - Outlet */
    @IBOutlet weak var instrucoes : UIButton!
    @IBOutlet weak var jogos      : UIButton!
    @IBOutlet weak var imgDemo    : UIImageView!
    @IBOutlet weak var som_image  : UIButton!
    
    /* MARK: - Variaveis */
    var musicaDeFundo: AVAudioPlayer?
    var status: Bool?
    var score: Int = 0 // Stores the score
    var gcEnabled = Bool() // Stores if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Stores the default leaderboardID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tocarmusica()
        authenticateLocalPlayer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if jogos.isFocused == true{
            imgDemo.image = UIImage(named: "BotãoJogar.png")
        } else if instrucoes.isFocused == true{
            imgDemo.image = UIImage(named: "BotãoAprender.png")
        }
    }
    
    func tocarmusica() {
        let url = Bundle.main.url(forResource: "Memorizando", withExtension: "mp3")!
        
        do {
            musicaDeFundo = try AVAudioPlayer(contentsOf: url)
            guard let player = musicaDeFundo else { return }
            status = true
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    @IBAction func musicaOnOf(_ sender: AnyObject) {
        if status == true {
            // Stop music
            guard let stop = musicaDeFundo else { return }
            status = false
            stop.stop()
            
            som_image.setImage(UIImage(named: "no_music"), for: UIControlState())
        } else {
            // Play music
            tocarmusica()
            som_image.setImage(UIImage(named: "music"), for: UIControlState())
        }
    }
    
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1 Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                // 2 Player is already euthenticated & logged in, load game center
                self.gcEnabled = true
                print("Autenticado")
//                self.show()
                
            } else {
                // 3 Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated, disabling game center")
                print(error)
            }
        }
    }
}
