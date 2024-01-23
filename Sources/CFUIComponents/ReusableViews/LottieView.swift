//
//  LottieView.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 22/10/2023.
//

import Foundation
import SwiftUI
import Lottie

public struct LottieView: UIViewRepresentable {
    public class ViewModel: ObservableObject {
        var animationView = LottieAnimationView()
        @Published var loopMode: LottieLoopMode
        @Published var name: String
        
        public init(name: String, loopMode: LottieLoopMode = .playOnce) {
            self.name = name
            self.loopMode = loopMode
        }
        
        public func play(fromFrame: AnimationFrameTime? = nil,
                         toFrame: AnimationFrameTime,
                         loopMode: LottieLoopMode? = nil,
                         completion: LottieCompletionBlock? = nil) {
            animationView.play(fromFrame: fromFrame, toFrame: toFrame, loopMode: loopMode, completion: completion)
        }
        
        public func play() {
            animationView.play()
        }
        
        public func pause() {
            animationView.pause()
        }
        
        public func stop() {
            animationView.stop()
        }
        
        public func changeAnimation(name: String) {
            self.name = name
        }
        
        public var currentFrame: AnimationFrameTime { animationView.currentFrame }
    }
    
    @Binding  var viewModel: ViewModel
    
    public init(viewModel: Binding<ViewModel>) {
        self._viewModel = viewModel
    }
    
    public func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        viewModel.animationView.contentMode = .scaleAspectFit
        
        viewModel.animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewModel.animationView)
        
        NSLayoutConstraint.activate([
            viewModel.animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            viewModel.animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        viewModel.animationView.animation = LottieAnimation.named(viewModel.name)
        viewModel.animationView.loopMode = viewModel.loopMode
    }
}
