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
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instrucoes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionInstrucoes.dequeueReusableCellWithReuseIdentifier("cellInstrucoes", forIndexPath: indexPath) as! InstrucoesCollectionViewCell
        
        cell.imgInstrucoes.image = UIImage(named: instrucoes[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let previousIndexPath = context.previouslyFocusedIndexPath,
            let cell = collectionInstrucoes.cellForItemAtIndexPath(previousIndexPath) {
            cell.contentView.layer.borderWidth = 0.0
            cell.contentView.layer.shadowRadius = 0.0
            cell.contentView.layer.shadowOpacity = 0
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                context.previouslyFocusedView?.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
        }
        
        if let indexPath = context.nextFocusedIndexPath,
            let cell = collectionInstrucoes.cellForItemAtIndexPath(indexPath) {
            let celula = collectionInstrucoes.dequeueReusableCellWithReuseIdentifier("cellInstrucoes", forIndexPath: indexPath) as! InstrucoesCollectionViewCell
            
            celula.imgInstrucoes.adjustsImageWhenAncestorFocused = true
            
            cell.contentView.layer.shadowColor = UIColor.blackColor().CGColor
            cell.contentView.layer.shadowRadius = 10.0
            cell.contentView.layer.shadowOpacity = 1
            cell.contentView.layer.shadowOffset = CGSizeZero
            collectionInstrucoes.scrollToItemAtIndexPath(indexPath, atScrollPosition: [.CenteredHorizontally, .CenteredVertically], animated: true)
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                context.nextFocusedView?.transform = CGAffineTransformMakeScale(1.13, 1.13)
            })
            
        }
    }

}














