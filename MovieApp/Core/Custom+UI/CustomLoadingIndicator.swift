//
//  CustomLoadingIndicator.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 04.08.23.
//


import UIKit

class CustomLoadingIndicator: UIView {
    
    // MARK: Properties
    private let circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(arcCenter: CGPoint.zero,
                                      radius: 16,
                                      startAngle: -(CGFloat.pi / 2),
                                      endAngle: -(CGFloat.pi / 2) + (2 * CGFloat.pi),
                                      clockwise: true)
        
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor(hex: "F5C518").cgColor
        circleLayer.lineWidth = 32
        circleLayer.path = bezierPath.cgPath
        
        return circleLayer
    }()
    
    private lazy var strokeAnimationGroup: CAAnimationGroup = {
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation, colorChangeAnimation]
        strokeAnimationGroup.duration = 3
        strokeAnimationGroup.repeatCount = .infinity
        strokeAnimationGroup.timingFunction = .init(name: .easeInEaseOut)
        return strokeAnimationGroup
    }()
    
    private lazy var colorChangeAnimation: CABasicAnimation = {
        let colorChangeAnimation = CABasicAnimation(keyPath: "strokeColor")
        colorChangeAnimation.fromValue = UIColor(hex: "F5C518").cgColor
        
        let primaryColorWithOpacity = UIColor(hex: "F5C518").withAlphaComponent(0.5)
        colorChangeAnimation.toValue = primaryColorWithOpacity.cgColor
        
        colorChangeAnimation.duration = 1
        colorChangeAnimation.beginTime = strokeEndAnimation.beginTime + strokeEndAnimation.duration - 0.5
        colorChangeAnimation.fillMode = .forwards
        colorChangeAnimation.isRemovedOnCompletion = false
        return colorChangeAnimation
    }()
    
    private let strokeStartAnimation: CABasicAnimation = {
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.duration = 2.5
        strokeStartAnimation.beginTime = 0.5
        
        return strokeStartAnimation
    }()
    
    private let strokeEndAnimation: CABasicAnimation = {
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.duration = 1.5
        
        return strokeEndAnimation
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupLayers() {
        layer.addSublayer(circleLayer)
    }
    
    func startAnimating() {
        circleLayer.add(strokeAnimationGroup, forKey: nil)
    }
}
