//
//  Animacao.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 24/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

public let kkDefaultFlakesCount                 = 200
public let kkDefaultFlakeWidth: Float           = 40.0
public let kkDefaultFlakeHeight: Float          = 46.0
public let kkDefaultMinimumSize: Float          = 0.4
public let kkDefaultMaximumSize: Float          = 0.8
public let kkDefaultAnimationDurationMin: Float = 6.0
public let kkDefaultAnimationDurationMax: Float = 12.0

open class Animacao: UIView {
    
    open var flakesCount: Int?
    open var flakeWidth: Float?
    open var flakeHeight: Float?
    open var flakeMinimumSize: Float?
    open var flakeMaximumSize: Float?
    
    open var animationDurationMin: Float?
    open var animationDurationMax: Float?
    
    open var flakesArray: [UIImageView]?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds             = true
        self.flakesCount          = kkDefaultFlakesCount
        self.flakeWidth           = kkDefaultFlakeWidth
        self.flakeHeight          = kkDefaultFlakeHeight
        self.flakeMinimumSize     = kkDefaultMinimumSize
        self.flakeMaximumSize     = kkDefaultMaximumSize
        self.animationDurationMin = kkDefaultAnimationDurationMin
        self.animationDurationMax = kkDefaultAnimationDurationMax
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    open func createFlakes() {
        flakesArray = [UIImageView]()
    
        let arrayImagesNames = ["estrela", "estrela1"] //array de imagens que irá cair.
        
        for _ in 0..<flakesCount! {
            var vz: Float = 1.0 * Float(arc4random()) / Float(RAND_MAX)
            vz = vz < flakeMinimumSize! ? flakeMinimumSize! : vz
            vz = vz > flakeMaximumSize! ? flakeMaximumSize! : vz
            
            let vw = flakeWidth!  * vz
            let vh = flakeHeight! * vz
            
            var vx = Float(frame.size.width) * Float(arc4random()) / Float(RAND_MAX)
            var vy = Float(frame.size.height) * 1.5 * Float(arc4random()) / Float(RAND_MAX)
            
            vy += Float(frame.size.height)
            vx -= vw
            
            let imageFrame = CGRect(x: CGFloat(vx), y: CGFloat(vy), width: CGFloat(vw), height: CGFloat(vh))
            
            
            let random = Int(arc4random_uniform(UInt32(2))) //sorteia as imagens randomicamente.
            let str = arrayImagesNames[random] //recebe a imagem sorteada.
            
            let imageView: UIImageView = UIImageView(image: UIImage(named: str))
            imageView.frame = imageFrame
            imageView.isUserInteractionEnabled = false
            flakesArray?.append(imageView)
            addSubview(imageView)
        }
    }
    
    open func startSnow() {
        if flakesArray == nil {
            createFlakes()
        }
        backgroundColor = UIColor.clear
        
        let rotAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotAnimation.repeatCount = Float.infinity
        rotAnimation.autoreverses = false
        rotAnimation.toValue = 6.28318530718
        
        let theAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        theAnimation.repeatCount = Float.infinity
        theAnimation.autoreverses = false
        
        for v: UIImageView in flakesArray! {
            var p: CGPoint = v.center
            let startypos = p.y
            let endypos = frame.size.height
            p.y = endypos
            v.center = p
            let timeInterval: Float = (animationDurationMax! - animationDurationMin!) * Float(arc4random()) / Float(RAND_MAX)
            theAnimation.duration = CFTimeInterval(timeInterval + animationDurationMin!)
            theAnimation.fromValue = -startypos
            v.layer.add(theAnimation, forKey: "transform.translation.y")
            
            rotAnimation.duration = CFTimeInterval(timeInterval)
            v.layer.add(rotAnimation, forKey: "transform.rotation.y")
        }
    }
    
    open func stopSnow() {
        for v: UIImageView in flakesArray! {
            v.layer.removeAllAnimations()
        }
        flakesArray = nil
    }
    
    deinit { }
    
}
