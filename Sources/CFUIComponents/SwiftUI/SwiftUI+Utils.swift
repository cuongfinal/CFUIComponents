//
//  Utils.swift
//  
//
//  Created by CuongFinal on 22/2/21.
//
// swiftlint:disable line_length

#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public struct FramePreferenceKey: PreferenceKey {
    public typealias Value = [FramePreferenceData]
    
    public static var defaultValue: [FramePreferenceData] = []
    
    public static func reduce(value: inout [FramePreferenceData], nextValue: () -> [FramePreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

public struct FramePreferenceData: Equatable {
   public let viewIdx: Int
   public let rect: CGRect
}

public struct FramePreferenceViewSetter: View {
   
    public let idx: Int
    public let geometryNameSpace: String
    
    public init(idx: Int, geometryNameSpace: String) {
        self.idx = idx
        self.geometryNameSpace = geometryNameSpace
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: FramePreferenceKey.self,
                            value: [FramePreferenceData(viewIdx: self.idx,
                                                        rect: geometry.frame(in: .named(geometryNameSpace)))])
        }
    }
}

/// An animatable modifier that is used for observing animations for a given animatable value.
public struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
    
    /// While animating, SwiftUI changes the old input value to the new target value using this property.
    /// This value is set to the old value until the animation completes.
    public var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }
    
    /// The target value for which we're observing. This value is directly set once the animation starts.
    /// During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
    private var targetValue: Value
    
    /// The completion callback which is called once the animation completes.
    private var completion: () -> Void
    
    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }
    
    /// Verifies whether the current animation is finished and calls the completion callback if true.
    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }
        
        /// Dispatching is needed to take the next runloop for the completion callback.
        /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
        DispatchQueue.main.async {
            self.completion()
        }
    }
    
    public func body(content: Content) -> some View {
        /// We're not really modifying the view so we can directly return the original input value.
        return content
    }
}

#endif
