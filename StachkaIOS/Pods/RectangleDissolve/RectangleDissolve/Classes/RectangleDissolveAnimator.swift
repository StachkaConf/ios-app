//
//  RectangleDissolveAnimator.swift
//  GithubItunesViewer
//
//  Created by MIKHAIL RAKHMANOV on 12.02.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//


import Foundation
import UIKit
import CoreGraphics

enum RectangleDissolveAnimatorConstants {
    static let tempo = 1000.0
    static let animationKey = "opacity"
}

public struct RectangleDissolveAnimatorConfiguration {
    let rectanglesVertical: Int
    let rectanglesHorizontal: Int
    let batchSize: Int
    let fadeAnimationDuration: Double
    let tempo: Double

    public init(rectanglesVertical: Int,
                rectanglesHorizontal: Int,
                batchSize: Int,
                fadeAnimationDuration: Double,
                tempo: Double) {
        self.rectanglesHorizontal = rectanglesHorizontal
        self.rectanglesVertical = rectanglesVertical
        self.batchSize = batchSize
        self.fadeAnimationDuration = fadeAnimationDuration
        self.tempo = tempo
    }

}

public class RectangleDissolveAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate, CAAnimationDelegate {

    private let duration = 0.4
    private var currentAnimations = 0
    private var tempoCounter = TempoCounter()

    public var rectanglesVertical = 14
    public var rectanglesHorizontal = 8
    public var batchSize = 20
    public var fadeAnimationDuration = 0.3

    public var tempo: Double {
        set {
            tempoCounter.tempo = newValue
        }
        get {
            return tempoCounter.tempo
        }
    }

    override public init() {
        super.init()

        tempo = RectangleDissolveAnimatorConstants.tempo
    }

    public init(configuration: RectangleDissolveAnimatorConfiguration) {
        super.init()

        rectanglesVertical = configuration.rectanglesVertical
        rectanglesHorizontal = configuration.rectanglesHorizontal
        batchSize = configuration.batchSize
        fadeAnimationDuration = configuration.fadeAnimationDuration
        tempo = configuration.tempo
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from) else {
                return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)

        let animatableView = UIView(frame: fromView.bounds)

        if let image = image(fromView: fromView) {
            drawSublayers(in: animatableView.layer, from: image)
            animatableView.backgroundColor = UIColor.clear

            toView.addSubview(animatableView)
            toView.bringSubview(toFront: animatableView)
        }
        let layersCount = animatableView.layer.sublayers?.count ?? 1
        let randomIndicesInterator = BatchRandomArrayIndicesIterator(max: layersCount,
                                                                     batchSize: batchSize)

        tempoCounter.handler = { [weak self] in
            guard let strongSelf = self else {
                return
            }

            if let batch = randomIndicesInterator.next() {
                for randomIndex in batch {

                    strongSelf.currentAnimations += 1

                    let animation = strongSelf.fadeAnimation(strongSelf.fadeAnimationDuration)
                    animation.delegate = self

                    if let layers = animatableView.layer.sublayers {
                        layers[randomIndex].add(animation,
                                                forKey: RectangleDissolveAnimatorConstants.animationKey)
                    }
                }
            } else if strongSelf.currentAnimations <= 0 {
                strongSelf.tempoCounter.stop()

                animatableView.layer.sublayers?.forEach { $0.removeAllAnimations() }
                animatableView.layer.sublayers = nil
                animatableView.removeFromSuperview()

                strongSelf.tempoCounter.handler = nil
                transitionContext.completeTransition(true)
            }
        }
        tempoCounter.start()
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        currentAnimations -= 1
    }

    private func fadeAnimation(_ duration: TimeInterval) -> CABasicAnimation {
        let fadeAnimation = CABasicAnimation(keyPath: RectangleDissolveAnimatorConstants.animationKey)

        fadeAnimation.toValue = 0
        fadeAnimation.duration = duration
        fadeAnimation.fillMode = kCAFillModeForwards
        fadeAnimation.isRemovedOnCompletion = false

        return fadeAnimation
    }

    private func image(fromView view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size,
                                               false,
                                               UIScreen.main.scale)
        view.drawHierarchy(in: view.frame,
                           afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    private func drawSublayers(in layer: CALayer, from image: UIImage) {
        guard let cgImage = image.cgImage else {
            return
        }

        let configuration = RectangleCoordinatesIteratorConfiguration(screenSize: UIScreen.main.bounds.size,
                                                                      rectanglesHorizontal: rectanglesHorizontal,
                                                                      rectanglesVertical: rectanglesVertical)
        let rectangleSequence = RectangleSequence(configuration: configuration)

        let cgTransform = CGAffineTransform(scaleX: image.scale, y: image.scale)
        for rectangle in rectangleSequence {
            let cgRectangle = CGRect(origin: rectangle.origin.applying(cgTransform),
                                     size: rectangle.size.applying(cgTransform))
            let newLayer = CALayer()
            newLayer.frame = rectangle

            if let partOfImage = cgImage.cropping(to: cgRectangle) {
                newLayer.contents = partOfImage
            }
            layer.addSublayer(newLayer)
        }
    }

    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

