//
//  CustomLoadingIndicator.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 04.08.23.
//


import UIKit

final class CustomLoadingIndicator: UIView {
    
    // MARK: Properties
    private let circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(arcCenter: CGPoint.zero,
                                      radius: Constants.circleRadius,
                                      startAngle: -(CGFloat.pi / 2),
                                      endAngle: -(CGFloat.pi / 2) + (2 * CGFloat.pi),
                                      clockwise: true)
        
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = Constants.strokeColor.cgColor
        circleLayer.lineWidth = Constants.lineWidth
        circleLayer.path = bezierPath.cgPath
        
        return circleLayer
    }()
    
    private lazy var strokeAnimationGroup: CAAnimationGroup = {
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation, colorChangeAnimation]
        strokeAnimationGroup.duration = Constants.animationDuration
        strokeAnimationGroup.repeatCount = .infinity
        strokeAnimationGroup.timingFunction = .init(name: .easeInEaseOut)
        return strokeAnimationGroup
    }()
    
    private lazy var colorChangeAnimation: CABasicAnimation = {
        let colorChangeAnimation = CABasicAnimation(keyPath: Constants.strokeColorKey)
        colorChangeAnimation.fromValue = Constants.primaryColor.cgColor
        
        let primaryColorWithOpacity = Constants.primaryColor.withAlphaComponent(Constants.colorOpacity)
        colorChangeAnimation.toValue = primaryColorWithOpacity.cgColor
        
        colorChangeAnimation.duration = Constants.colorChangeDuration
        colorChangeAnimation.beginTime = strokeEndAnimation.beginTime + strokeEndAnimation.duration - Constants.colorChangeBeginTimeOffset
        colorChangeAnimation.fillMode = .forwards
        colorChangeAnimation.isRemovedOnCompletion = false
        return colorChangeAnimation
    }()
    
    private let strokeStartAnimation: CABasicAnimation = {
        let strokeStartAnimation = CABasicAnimation(keyPath: Constants.keyPathforStart)
        strokeStartAnimation.fromValue = Constants.strokeStartFromValue
        strokeStartAnimation.toValue = Constants.strokeStartToValue
        strokeStartAnimation.duration = Constants.strokeStartDuration
        strokeStartAnimation.beginTime = Constants.strokeStartBeginTime
        return strokeStartAnimation
    }()
    
    private let strokeEndAnimation: CABasicAnimation = {
        let strokeEndAnimation = CABasicAnimation(keyPath: Constants.keyPathForEnd)
        strokeEndAnimation.fromValue = Constants.strokeEndFromValue
        strokeEndAnimation.toValue = Constants.strokeEndToValue
        strokeEndAnimation.duration = Constants.strokeEndDuration
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
    
    func stopAnimating() {
        circleLayer.removeAnimation(forKey: "")
    }
}

extension CustomLoadingIndicator {
    enum Constants {
        static let keyPathforStart = "strokeStart"
        static let keyPathForEnd = "strokeEnd"
        static let strokeColorKey = "strokeColor"
        static let circleRadius: CGFloat = 16
        static let strokeColor = UIColor(hex: "F5C518")
        static let lineWidth: CGFloat = 32
        static let animationDuration: CFTimeInterval = 3
        static let primaryColor = UIColor(hex: "F5C518")
        static let colorOpacity: CGFloat = 0.5
        static let colorChangeDuration: CFTimeInterval = 1
        static let colorChangeBeginTimeOffset: CFTimeInterval = 0.5
        static let strokeStartFromValue: NSNumber = 0
        static let strokeStartToValue: NSNumber = 1
        static let strokeStartDuration: CFTimeInterval = 2.5
        static let strokeStartBeginTime: CFTimeInterval = 0.5
        static let strokeEndFromValue: NSNumber = 0
        static let strokeEndToValue: NSNumber = 1
        static let strokeEndDuration: CFTimeInterval = 1.5
    }
}
