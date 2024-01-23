//
//  SRLoadingView.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 22/10/2023.
//

import SwiftUI
import Lottie

struct SRLoadingView: View {
    @State private var animationSingInSource: LottieView.ViewModel = .init(name: "loading-1", loopMode: .loop)
    
    init() {
        UIView.setAnimationsEnabled(false)
    }
    
    var body: some View {        
        ZStack {
            Color(.gray).opacity(0.5)
            LottieView(viewModel: $animationSingInSource).size(120)
        }
        .background(ClearBackgroundView())
        .infinityFrame()
        .ignoresSafeArea()
        .onAppear{
            animationSingInSource.play()
        }
        .onDisappear{
            UIView.setAnimationsEnabled(true)
        }
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return InnerView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    private class InnerView: UIView {
        override func didMoveToWindow() {
            super.didMoveToWindow()
            
            superview?.superview?.backgroundColor = .clear
        }
        
    }
}
