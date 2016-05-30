//
//  Animacao2.swift
//  challengeTV
//
//  Created by Ana Elisa Pessoa Aguiar on 30/05/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

public let kkDefaultFlakeFileName2               = "confete1"
public let kkDefaultFlakesCount2                 = 200
public let kkDefaultFlakeWidth2: Float           = 40.0
public let kkDefaultFlakeHeight2: Float          = 46.0
public let kkDefaultMinimumSize2: Float          = 0.4
public let kkDefaultMaximumSize2: Float          = 0.8
public let kkDefaultAnimationDurationMin2: Float = 6.0
public let kkDefaultAnimationDurationMax2: Float = 12.0

public class Animacao2: UIView {
    
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
        self.flakeFileName        = kkDefaultFlakeFileName2
        self.flakesCount          = kkDefaultFlakesCount2
        self.flakeWidth           = kkDefaultFlakeWidth2
        self.flakeHeight          = kkDefaultFlakeHeight2
        self.flakeMinimumSize     = kkDefaultMinimumSize2
        self.flakeMaximumSize     = kkDefaultMaximumSize2
        self.animationDurationMin = kkDefaultAnimationDurationMin2
        self.animationDurationMax = kkDefaultAnimationDurationMax2
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public func createFlakes() {
        flakesArray = [UIImageView]()
        let flakeImage: UIImage = UIImage(named: flakeFileName!)!
        for i: Int in 0 ..< flakesCount! {
            var vz: Float = 1.0 * Float(rand()) / Float(RAND_MAX)
            vz = vz < flakeMinimumSize! ? flakeMinimumSize! : vz
            vz = vz > flakeMaximumSize! ? flakeMaximumSize! : vz
            
            let vw = flakeWidth! * vz
            let vh = flakeHeight! * vz
            
            var vx = Float(frame.size.width) * Float(rand()) / Float(RAND_MAX)
            var vy = Float(frame.size.height) * 1.5 * Float(rand()) / Float(RAND_MAX)
            
            vy += Float(frame.size.height)
            vx -= vw
            
            let imageFrame = CGRectMake(CGFloat(vx), CGFloat(vy), CGFloat(vw), CGFloat(vh))
            let imageView: UIImageView = UIImageView(image: flakeImage)
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
            let timeInterval: Float = (animationDurationMax! - animationDurationMin!) * Float(rand()) / Float(RAND_MAX)
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
    
    deinit { }
    
}