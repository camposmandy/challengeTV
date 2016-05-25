//
//  NivelDoisViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 24/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class NivelDoisViewController: UIViewController {

    var managerJogo = Jogo()
    var opcoesCarta = [String]() //imagens das cartas
    var cartas = [UIButton]()
    var retorno = [String]()
    var status = Bool()
    var selecionados = [Int]()
    var b = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        opcoesCarta = ["Panda.png", "Cachorro.png", "Gato.png", "Cachorro.png", "Gato.png", "Panda.png"]
        //cartas = [carta1, carta2, carta3, carta4, carta5, carta6]
        retorno = managerJogo.embaralhar(opcoesCarta) //retorna um array de cartas embaralhadas.
        
    }

    override func didReceiveMemoryWarning()
    {       super.didReceiveMemoryWarning()     }
    
    @IBAction func animacaoCarta(sender: AnyObject) { //animação dos botões quando selecionados.
        if sender.tag != 100 {
            status = false
            let img = self.imagem(sender as! UIButton).foto
            //enquanto houver animação todas as cartas estão sem interação
            interacao()
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
            if self.imagem(cartas[selecionados[0]]).foto == self.imagem(cartas[selecionados[1]]).foto{
                //acertou
                acerto()
                print("uhul")
            } else {
                //errou
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.erro), userInfo: nil, repeats: false)
                print("quase :(")
            }
        }
    }
    
    func interacao(){
        for c in cartas{
            c.userInteractionEnabled = status
        }
    }
    
    func acerto(){
        for i in selecionados{
            cartas[i].tag = 100
            animacaoAcerto(cartas[i])
        }
        
        status = true
        interacao()
        selecionados.removeAll()
    }
    
    func erro(){
        for i in selecionados{
            animacaoErro(cartas[i])
        }
        status = true
        interacao()
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
    
    func animacaoAcerto(sender: UIButton){
        UIView.beginAnimations("teste", context: nil)
        UIView.setAnimationDuration(1.0)
        sender.transform = CGAffineTransformMakeScale(1.8, 1.8)
        sender.alpha = 1.0
        UIView.commitAnimations()
        
        UIView.beginAnimations("teste", context: nil)
        UIView.setAnimationDuration(1.0)
        sender.transform = CGAffineTransformMakeScale(1, 1)
        sender.alpha = 1.0
        UIView.commitAnimations()
    }
    
    func animacaoErro(sender: UIButton){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 250), dispatch_get_main_queue()) {
            sender.setBackgroundImage(UIImage(named: "Parte de tras"), forState: .Normal)
        }
        UIView.transitionWithView(sender, duration: 0.5, options: .TransitionFlipFromLeft, animations: {
            }, completion: nil)
    }
    
    

}
