//
//  NivelDoisViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 24/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class NivelDoisViewController: UIViewController {

    var JManager = Jogo()
    var opcoesCarta = [String]() //imagens das cartas
    var nomeCategoria = String()
    var cartas = [UIButton]()
    var retorno = [String]()
    var selecionados = [Int]()
    var b = UIButton()
    
    @IBOutlet weak var carta1: UIButton!
    @IBOutlet weak var carta2: UIButton!
    @IBOutlet weak var carta3: UIButton!
    @IBOutlet weak var carta4: UIButton!
    @IBOutlet weak var carta5: UIButton!
    @IBOutlet weak var carta6: UIButton!
    @IBOutlet weak var carta7: UIButton!
    @IBOutlet weak var carta8: UIButton!
    @IBOutlet weak var carta9: UIButton!
    @IBOutlet weak var carta10: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if nomeCategoria == "Animais"{
            opcoesCarta = ["Cachorro.png", "Elefante.png", "Gato.png","Girafa.png", "Onca.png", "Cachorro.png", "Elefante.png", "Gato.png","Girafa.png", "Onca.png"]
        } else if nomeCategoria == "Frutas"{
            opcoesCarta = ["Banana.png", "Cereja.png", "Coco.png", "Laranja.png", "Limao.png", "Banana.png", "Cereja.png", "Coco.png", "Laranja.png", "Limao.png"]
        } else {
            opcoesCarta = ["1.png", "2.png", "3.png", "4.png", "5.png", "1-1.png", "2-1.png", "3-1.png", "4-1.png", "5-1.png"]
        }
        
        cartas = [carta1, carta2, carta3, carta4, carta5, carta6, carta7, carta8, carta9, carta10]
        retorno = JManager.embaralhar(opcoesCarta) //retorna um array de cartas embaralhadas.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func animacaoCarta(sender: AnyObject) { //animação dos botões quando selecionados.
        if sender.tag != 100 {
            let img = self.imagem(sender as! UIButton).foto
            
            //enquanto houver animação todas as cartas estão sem interação
            JManager.interacao(cartas, status: false)
            
            //adiciona o indice do botão que foi selecionado
            selecionados.append(self.imagem(sender as! UIButton).indice)
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 25), dispatch_get_main_queue()) {
                sender.setBackgroundImage(UIImage(named: img), forState: .Normal)
            }
            UIView.transitionWithView(sender as! UIView, duration: 0.5, options: .TransitionFlipFromRight, animations: {
            }) { (finished) in
                self.jogo(sender as! UIButton)
            }
        }
    }
    
    func jogo(carta: UIButton){ // compara se as cartas soteadas são iguais
        
        if selecionados.count == 1 {
            for c in cartas {
                if c == carta{
                    c.userInteractionEnabled = false
                } else {
                    c.userInteractionEnabled = true
                }
            }
        } else if selecionados.count == 2 {
            //compara as cartas pelo nome da foto
            var comparacao = self.imagem(cartas[selecionados[0]]).foto == self.imagem(cartas[selecionados[1]]).foto
            if nomeCategoria == "Números"{
                comparacao = self.imagem(cartas[selecionados[0]]).foto == self.imagem(cartas[selecionados[1]]).foto.stringByReplacingOccurrencesOfString("-1.png", withString: ".png") || self.imagem(cartas[selecionados[1]]).foto.stringByReplacingOccurrencesOfString(".png", withString: "-1.png") == self.imagem(cartas[selecionados[0]]).foto
            }
            
            if comparacao == true{
                //acertou
                var c = 0
                acerto()
                print(cartas.count, c)
                for i in cartas{
                    if i.tag == 100{
                        c+=1
                    }
                }
                print(cartas.count, c)
                
                if cartas.count == c{
                    JManager.ganhouJogo(view)
                }
                
            } else {
                //errou
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.erro), userInfo: nil, repeats: false)
            }
        }
    }
    
    func acerto(){
        for i in selecionados{
            cartas[i].tag = 100
            JManager.animacaoAcerto(cartas[i])
        }
        
        JManager.interacao(cartas, status: true)
        selecionados.removeAll()
    }
    
    func erro(){
        for i in selecionados{
            JManager.animacaoErro(cartas[i])
        }
        
        JManager.interacao(cartas, status: true)
        selecionados.removeAll()
    }
    
    func imagem(sender: UIButton) -> (foto: String, indice: Int){ // retorna a imagem do botão selecionado
        var indice = ""
        var i = 0
        var j = 0
        for carta in cartas{
            if sender == carta {
                indice = self.retorno[self.cartas.indexOf(carta)!]
                j = i
            }
            i+=1
        }
        return (indice, j)
    }
}
