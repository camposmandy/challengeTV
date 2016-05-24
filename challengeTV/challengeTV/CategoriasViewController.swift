//
//  CategoriasViewController.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 11/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class CategoriasViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var  categorias = ["CategoriaAnimais.png", "CategoriaFrutas.png", "CategoriaNumeros.png"]
    var categoria = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

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
        return categorias.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("celula", forIndexPath: indexPath) as! CategoriaCollectionViewCell
        
        cell.img.image = UIImage(named: categorias[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let i = indexPath.row
        categoria = categorias[i]
    }
 
    func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator:UIFocusAnimationCoordinator) {
        
        if let previousIndexPath = context.previouslyFocusedIndexPath,
            let cell = collectionView.cellForItemAtIndexPath(previousIndexPath) {
            cell.contentView.layer.borderWidth = 0.0
            cell.contentView.layer.shadowRadius = 0.0
            cell.contentView.layer.shadowOpacity = 0
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                context.previouslyFocusedView?.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
            
        }
        
        if let indexPath = context.nextFocusedIndexPath,
            let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            let celula = collectionView.dequeueReusableCellWithReuseIdentifier("celula", forIndexPath: indexPath) as! CategoriaCollectionViewCell
            
            celula.img.adjustsImageWhenAncestorFocused = true
            
            cell.contentView.layer.shadowColor = UIColor.blackColor().CGColor
            cell.contentView.layer.shadowRadius = 10.0
            cell.contentView.layer.shadowOpacity = 1
            cell.contentView.layer.shadowOffset = CGSizeZero
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: [.CenteredHorizontally, .CenteredVertically], animated: true)
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                context.nextFocusedView?.transform = CGAffineTransformMakeScale(1.13, 1.13)
            })
        }
    }
}
