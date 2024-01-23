//
//  PopUpViewController.swift
//  UICompanent
//
//  Created by CuongFinal on 26/7/21.
//  Copyright © All rights reserved.
//
// swiftlint:disable identifier_name
import Foundation
import UIKit
import SwiftUI
import Combine

public protocol PopUpViewController: UIViewController {
    var topMargin: CGFloat { get set }
    var container: UIView { get set }
    func dismissController(completion: (() -> Void)?)
}

class PopUpViewControllerImpl: UIViewController, PopUpViewController {
    lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.delegate = self
        pan.addTarget(self, action: #selector(handleGesture(recognizer:)))
        return pan
    }()
    
    var topMargin: CGFloat = 0
    var draggable: Bool
    
    private var animator = UIViewPropertyAnimator()
    private var animationProgress: CGFloat = 0
    private var closedTransform = CGAffineTransform.identity
    
    var cancellable: Cancellable?
    
    var container: UIView = UIView()
    
    init(draggable: Bool = true) {
        self.draggable = draggable
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        
        cancellable = Publishers.keyboardObserver.sink { [weak self] state in
            switch state {
            case .hide: self?.view.frame.origin.y = 0
            case .show(let height): self?.view.frame.origin.y = UIScreen.mainMinY - height.height
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if topMargin < 102 { topMargin = 102 }
    
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leftAnchor.constraint(equalTo: view.leftAnchor),
            container.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        container.tag = 1000
        
        closedTransform = CGAffineTransform(translationX: 0, y: view.bounds.height - topMargin)
        container.transform = closedTransform
        
        startAnimationIfNeeded(open: true) {
            if self.draggable { self.container.addGestureRecognizer(self.panGestureRecognizer) }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: view)
        if !container.frame.contains(position) { dismissController() }
    }
    
    @objc
    func handleGesture(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startAnimationIfNeeded(open: false) { self.animator.isReversed.toggle() }
            animator.pauseAnimation()
            animationProgress = animator.fractionComplete
        case .changed:
            var fraction = recognizer.translation(in: container).y / closedTransform.ty
            if animator.isReversed { fraction *= -1 }
            animator.fractionComplete = fraction + animationProgress
        case .ended, .cancelled:
            let yVelocity = recognizer.velocity(in: container).y
            if !(yVelocity > 0) && !animator.isReversed {
                animator.isReversed.toggle()
            }
            if !animator.isReversed {
                animator.addCompletion { _ in self.dismiss(animated: false, completion: nil) }
            }
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0.8)
        default: break
        }
    }
    
    private func startAnimationIfNeeded(open: Bool, _ completion: (() -> Void)? = nil) {
        if animator.isRunning { return }
        animator = .init(duration: 0.7, dampingRatio: 0.85)
        animator.addAnimations {
            self.container.transform = open ? .identity : self.closedTransform
            self.view.backgroundColor = open ? UIColor.black.withAlphaComponent(0.4) : .clear
        }
        animator.addCompletion { _ in completion?() }
        animator.startAnimation()
    }
    
    @objc
    func dismissController(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.container.transform = self.closedTransform
                self.view.backgroundColor = .clear
            } completion: { _ in
                self.dismiss(animated: false, completion: completion)
            }
        }
    }
    
    deinit {
        print("deinit PopUpViewControllerImpl")
    }
}

extension PopUpViewControllerImpl: UIGestureRecognizerDelegate { }
