//
//  Animacao.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 24/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

public let kkDefaultFlakeFileName               = "Instrucao2"
public let kkDefaultFlakesCount                 = 200
public let kkDefaultFlakeWidth: Float           = 40.0
public let kkDefaultFlakeHeight: Float          = 46.0
public let kkDefaultMinimumSize: Float          = 0.4
public let kkDefaultMaximumSize: Float          = 0.8
public let kkDefaultAnimationDurationMin: Float = 6.0
public let kkDefaultAnimationDurationMax: Float = 12.0

public class BolasBasqueteCaindo: UIView {
    
    public var flakesCount: Int?
    public var flakeFileName: String?
    public var flakeWidth: Float?
    public var flakeHeight: Float?
    public var flakeMinimumSize: Float?
    public var flakeMaximumSize: Float?
    
    public var animationDurationMin: Float?
    public var animationDurationMax: Float?
    
    public var flakesArray: [UIImageView]?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds             = true
        self.flakeFileName        = kkDefaultFlakeFileName
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
    
    public func createFlakes() {
        flakesArray = [UIImageView]()
        var flakeImage: UIImage = UIImage(named: flakeFileName!)!
        for var i: Int = 0; i < flakesCount!; i++ {
            var vz: Float = 1.0 * Float(rand()) / Float(RAND_MAX)
            vz = vz < flakeMinimumSize! ? flakeMinimumSize! : vz
            vz = vz > flakeMaximumSize! ? flakeMaximumSize! : vz
            
            var vw = flakeWidth! * vz
            var vh = flakeHeight! * vz
            
            var vx = Float(frame.size.width) * Float(rand()) / Float(RAND_MAX)
            var vy = Float(frame.size.height) * 1.5 * Float(rand()) / Float(RAND_MAX)
            
            vy += Float(frame.size.height)
            vx -= vw
            
            var imageFrame = CGRectMake(CGFloat(vx), CGFloat(vy), CGFloat(vw), CGFloat(vh))
            var imageView: UIImageView = UIImageView(image: flakeImage)
            imageView.frame = imageFrame
            imageView.userInteractionEnabled = false
            flakesArray?.append(imageView)
            addSubview(imageView)
        }
    }
    
    public func startSnow() {
        if flakesArray == nil {
            createFlakes()
        }
        backgroundColor = UIColor.clearColor()
        
        var rotAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotAnimation.repeatCount = Float.infinity
        rotAnimation.autoreverses = false
        rotAnimation.toValue = 6.28318530718
        
        var theAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        theAnimation.repeatCount = Float.infinity
        theAnimation.autoreverses = false
        
        for v: UIImageView in flakesArray! {
            var p: CGPoint = v.center
            let startypos = p.y
            let endypos = frame.size.height
            p.y = endypos
            v.center = p
            var timeInterval: Float = (animationDurationMax! - animationDurationMin!) * Float(rand()) / Float(RAND_MAX)
            theAnimation.duration = CFTimeInterval(timeInterval + animationDurationMin!)
            theAnimation.fromValue = -startypos
            v.layer.addAnimation(theAnimation, forKey: "transform.translation.y")
            
            rotAnimation.duration = CFTimeInterval(timeInterval)
            v.layer.addAnimation(rotAnimation, forKey: "transform.rotation.y")
        }
    }
    
    public func stopSnow() {
        for v: UIImageView in flakesArray! {
            v.layer.removeAllAnimations()
        }
        flakesArray = nil
    }
    
    deinit {
    }
    
    
    
}
