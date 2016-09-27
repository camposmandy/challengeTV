
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celula", for: indexPath) as! CategoriaCollectionViewCell
        
        cell.img.image = UIImage(named: categorias[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let i = (indexPath as NSIndexPath).row
        categoria = categorias[i]
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator:UIFocusAnimationCoordinator) {
        
        if let previousIndexPath = context.previouslyFocusedIndexPath,
            let cell = collectionView.cellForItem(at: previousIndexPath) {
            cell.contentView.layer.borderWidth = 0.0
            cell.contentView.layer.shadowRadius = 0.0
            cell.contentView.layer.shadowOpacity = 0
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                context.previouslyFocusedView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
        }
        
        if let indexPath = context.nextFocusedIndexPath,
            let cell = collectionView.cellForItem(at: indexPath) {
            let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "celula", for: indexPath) as! CategoriaCollectionViewCell
            
            celula.img.adjustsImageWhenAncestorFocused = true
            
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowRadius = 10.0
            cell.contentView.layer.shadowOpacity = 1
            cell.contentView.layer.shadowOffset = CGSize.zero
            collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                context.nextFocusedView?.transform = CGAffineTransform(scaleX: 1.13, y: 1.13)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as! NivelViewController
            let celula = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: celula)
            let userPost = categorias[((indexPath as NSIndexPath?)?.row)!]
            vc.c = userPost
    }
}
