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
    var nomeCategoria = String()
    var opcoesCarta = [String]() //imagens das cartas
//    var nomeCategoria = String()
    var cartas = [UIButton]()
    var retorno = [String]()
    var selecionados = [Int]()
    var bonus = 0.0
    var timer = Timer()
    var tempo: TimeInterval = 60
    var tempoRef: TimeInterval = 60
    
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
    @IBOutlet weak var pontuacao: UILabel!
    @IBOutlet weak var barraDeProgresso: UIProgressView!
    @IBOutlet weak var tempoLbl: UILabel!

    
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
        retorno = managerJogo.embaralhar(opcoesCarta) //retorna um array de cartas embaralhadas.
    }

    override func viewWillAppear(_ animated: Bool) {
        // Barra de tempo
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(NivelDoisViewController.atualizarTempo), userInfo: nil, repeats: true)
        
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
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
    
    func atualizarTempo(){
        tempo -= 0.1
        
        if tempo <= 0 {
            tempo = 0
            
            timer.invalidate()
            
            // Fim do tempo
            let chamada = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Parabens") as! GanhouViewController
            
            chamada.score    = pontuacao.text
            chamada.mensagem = "O tempo acabou 😰"
            
            self.navigationController?.pushViewController(chamada, animated: true)
        }
        
        barraDeProgresso.progress = Float(tempo/tempoRef)
        
        let tempoString = NSString(format: "Tempo = %.1f", tempo)
        
        tempoLbl.text = "\(tempoString)"
        
        if barraDeProgresso.progress < 0.2 {
            barraDeProgresso.progressTintColor = UIColor.red
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
            
            if cartas.count == c { // quando todas as cartas forem desviradas 
               
                timer.invalidate()// para o tempo
                
                let chamada = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Parabens") as! GanhouViewController
                
                chamada.score = pontuacao.text
                chamada.mensagem = "Você ganhou! 😃"
                self.navigationController?.pushViewController(chamada, animated: true)
            }
        }
    }
    
    func acerto(){
        // Calculo pont
        bonus = tempo
        
        let conta = cartas.count  - 2
        let soma = (bonus*2)
        let cs = soma - Double(conta)
        
        pontuacao.text = NSString(format: "Pontuação = %.1f", cs) as String
        
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
