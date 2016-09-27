//
//  NivelDoisViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 24/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class NivelCincoViewController: UIViewController {

    var managerJogo = Jogo()
    var nomeCategoria = String()
    var opcoesCarta = [String]() //imagens das cartas
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
    @IBOutlet weak var carta11: UIButton!
    @IBOutlet weak var carta12: UIButton!
    @IBOutlet weak var carta13: UIButton!
    @IBOutlet weak var carta14: UIButton!
    @IBOutlet weak var carta15: UIButton!
    @IBOutlet weak var carta16: UIButton!
    @IBOutlet weak var carta17: UIButton!
    @IBOutlet weak var carta18: UIButton!
    @IBOutlet weak var carta19: UIButton!
    @IBOutlet weak var carta20: UIButton!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if nomeCategoria == "Animais"{
            opcoesCarta = ["Cachorro.png", "Elefante.png", "Gato.png","Girafa.png", "Onca.png", "Panda.png", "Pinguim.png", "Porco.png", "Tartaruga.png", "Vaca.png", "Cachorro.png", "Elefante.png", "Gato.png","Girafa.png", "Onca.png", "Panda.png", "Pinguim.png", "Porco.png", "Tartaruga.png", "Vaca.png"]
        } else if nomeCategoria == "Frutas"{
            opcoesCarta = ["Banana.png", "Cereja.png", "Coco.png", "Laranja.png", "Limao.png", "Maca.png", "Melancia.png", "Morango.png", "Pera.png","Tomate.png", "Banana.png", "Cereja.png", "Coco.png", "Laranja.png", "Limao.png", "Maca.png", "Melancia.png", "Morango.png", "Pera.png", "Tomate.png"]
        } else {
            opcoesCarta = ["1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png", "10.png", "1-1.png", "2-1.png", "3-1.png", "4-1.png", "5-1.png", "6-1.png", "7-1.png", "8-1.png", "9-1.png", "10-1.png"]
        }
        
        cartas = [carta1, carta2, carta3, carta4, carta5, carta6, carta7, carta8, carta9, carta10, carta11, carta12, carta13, carta14, carta15, carta16, carta17, carta18, carta19, carta20]
        retorno = managerJogo.embaralhar(opcoesCarta) //retorna um array de cartas embaralhadas.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func animacaoCarta(_ sender: AnyObject) { //animação dos botões quando selecionados.
        if sender.tag != 100 {
            let img = self.imagem(sender as! UIButton).foto
            
            //enquanto houver animação todas as cartas estão sem interação
            managerJogo.interacao(cartas, status: false)
            
            //adiciona o indice do botão que foi selecionado
            selecionados.append(self.imagem(sender as! UIButton).indice)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(25) / Double(NSEC_PER_SEC)) {
                sender.setBackgroundImage(UIImage(named: img), for: UIControlState())
            }
            UIView.transition(with: sender as! UIView, duration: 0.5, options: .transitionFlipFromRight, animations: {
            }) { (finished) in
                self.jogo(sender as! UIButton)
            }
        }
    }
    
    func jogo(_ carta: UIButton){ // compara se as cartas soteadas são iguais
        
        var c = 0
        
        if selecionados.count == 1 {
            for c in cartas {
                if c == carta{
                    c.isUserInteractionEnabled = false
                } else {
                    c.isUserInteractionEnabled = true
                }
            }
        } else if selecionados.count == 2 {
            //compara as cartas pelo nome da foto
            var comparacao = self.imagem(cartas[selecionados[0]]).foto == self.imagem(cartas[selecionados[1]]).foto
            if nomeCategoria == "Números"{
                comparacao = self.imagem(cartas[selecionados[0]]).foto == self.imagem(cartas[selecionados[1]]).foto.replacingOccurrences(of: "-1.png", with: ".png") || self.imagem(cartas[selecionados[1]]).foto.replacingOccurrences(of: ".png", with: "-1.png") == self.imagem(cartas[selecionados[0]]).foto
            }
            
            if comparacao == true{
                //acertou
                acerto()
                print(cartas.count, c)
                for i in cartas{
                    if i.tag == 100{
                        c+=1
                    }
                }
                
                print(cartas.count, c)
                
            } else {
                //errou
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.erro), userInfo: nil, repeats: false)
            }
            
            if cartas.count == c {
                let chamada = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Parabens") as! GanhouViewController
                self.navigationController?.pushViewController(chamada, animated: true)
            }
        }
    }
    
    func acerto(){
        for i in selecionados{
            cartas[i].tag = 100
            managerJogo.animacaoAcerto(cartas[i])
        }
        
        managerJogo.interacao(cartas, status: true)
        selecionados.removeAll()
    }
    
    func erro(){
        for i in selecionados{
            managerJogo.animacaoErro(cartas[i])
        }
        
        managerJogo.interacao(cartas, status: true)
        selecionados.removeAll()
    }
    
    func imagem(_ sender: UIButton) -> (foto: String, indice: Int){ // retorna a imagem do botão selecionado
        var indice = ""
        var i = 0
        var j = 0
        for carta in cartas{
            if sender == carta {
                indice = self.retorno[self.cartas.index(of: carta)!]
                j = i
            }
            i+=1
        }
        return (indice, j)
    }
}
