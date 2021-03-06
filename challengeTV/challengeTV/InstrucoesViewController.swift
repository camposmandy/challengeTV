//
//  InstrucoesViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 11/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class InstrucoesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionInstrucoes: UICollectionView!
    var instrucoes = ["Instrucao1.png", "Instrucao2.png", "Instrucao3.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionInstrucoes.delegate = self
        self.collectionInstrucoes.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instrucoes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionInstrucoes.dequeueReusableCell(withReuseIdentifier: "cellInstrucoes", for: indexPath) as! InstrucoesCollectionViewCell
        
        cell.imgInstrucoes.image = UIImage(named: instrucoes[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let previousIndexPath = context.previouslyFocusedIndexPath,
            let cell = collectionInstrucoes.cellForItem(at: previousIndexPath) {
            cell.contentView.layer.borderWidth = 0.0
            cell.contentView.layer.shadowRadius = 0.0
            cell.contentView.layer.shadowOpacity = 0
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                context.previouslyFocusedView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
        
        if let indexPath = context.nextFocusedIndexPath,
            let cell = collectionInstrucoes.cellForItem(at: indexPath) {
            let celula = collectionInstrucoes.dequeueReusableCell(withReuseIdentifier: "cellInstrucoes", for: indexPath) as! InstrucoesCollectionViewCell
            
            celula.imgInstrucoes.adjustsImageWhenAncestorFocused = true
            
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowRadius = 10.0
            cell.contentView.layer.shadowOpacity = 1
            cell.contentView.layer.shadowOffset = CGSize.zero
            collectionInstrucoes.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                context.nextFocusedView?.transform = CGAffineTransform(scaleX: 1.13, y: 1.13)
            })
            
        }
    }

}














