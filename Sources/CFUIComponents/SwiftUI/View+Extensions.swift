//
//  SwiftUI+Extension.swift
//  
//
//  Created by Order Tiger on 22/2/21.
//

#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public extension UIApplication {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func showKeybroard() {
        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
    }
}

public extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        return self.clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
    
    func addDoneButton(barStyle: UIBarStyle = .default) -> some View {
        introspectTextField { uiTextField in
            uiTextField.addDoneButtonOnKeyboard(barStyle: barStyle)
        }
    }
    
    func becomeKeyboard(delay: Double) -> some View {
        introspectTextField { uiTextField in
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                uiTextField.becomeFirstResponder()
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func logger(_ vars: Any...) -> some View {
        for value in vars { print(value) }
        return EmptyView()
    }
    
    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value,
                                                       completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
    
    func animate(using animation: Animation = Animation.easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
        onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}

public extension Text {
    func apply(_ theFont: Font, _ color: Color? = nil, _ weight: Font.Weight? = nil) -> Text {
        var font = font(theFont)
        if let color = color {
           font = font.foregroundColor(color)
        }
        if let weight = weight {
           font = font.fontWeight(weight)
        }
        return font
    }
    
    func align(_ alignment: TextAlignment) -> some View {
        multilineTextAlignment(alignment)
    }
}
#endif
