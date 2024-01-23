//
//  SwiftUI-Introspect.swift
//  UICompanent
//
//  Created by CuongFinal on 9/3/21.
//  Copyright © All rights reserved.
//

// swiftlint:disable line_length
// swiftlint:disable generic_type_name
// swiftlint:disable file_length

#if canImport(UIKit) && os(iOS)

import SwiftUI
import UIKit

public typealias PlatformView = UIView
public typealias PlatformViewController = UIViewController

/// Utility methods to inspect the UIKit view hierarchy.
public enum Introspect {
    
    /// Finds a subview of the specified type.
    /// This method will recursively look for this view.
    /// Returns nil if it can't find a view of the specified type.
    public static func findChild<AnyViewType: PlatformView>(
        ofType type: AnyViewType.Type,
        in root: PlatformView
    ) -> AnyViewType? {
        for subview in root.subviews {
            if let typed = subview as? AnyViewType {
                return typed
            } else if let typed = findChild(ofType: type, in: subview) {
                return typed
            }
        }
        return nil
    }
    
    /// Finds a child view controller of the specified type.
    /// This method will recursively look for this child.
    /// Returns nil if it can't find a view of the specified type.
    public static func findChild<AnyViewControllerType: PlatformViewController>(
        ofType type: AnyViewControllerType.Type,
        in root: PlatformViewController
    ) -> AnyViewControllerType? {
        for child in root.children {
            if let typed = child as? AnyViewControllerType {
                return typed
            } else if let typed = findChild(ofType: type, in: child) {
                return typed
            }
        }
        return nil
    }
    
    /// Finds a previous sibling that contains a view of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    public static func previousSibling<AnyViewType: PlatformView>(
        containing type: AnyViewType.Type,
        from entry: PlatformView
    ) -> AnyViewType? {
        
        guard let superview = entry.superview,
              let entryIndex = superview.subviews.firstIndex(of: entry),
              entryIndex > 0
        else {
            return nil
        }
        
        for subview in superview.subviews[0..<entryIndex].reversed() {
            if let typed = findChild(ofType: type, in: subview) {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a previous sibling that is of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    public static func previousSibling<AnyViewType: PlatformView>(
        ofType type: AnyViewType.Type,
        from entry: PlatformView
    ) -> AnyViewType? {
        
        guard let superview = entry.superview,
              let entryIndex = superview.subviews.firstIndex(of: entry),
              entryIndex > 0
        else {
            return nil
        }
        
        for subview in superview.subviews[0..<entryIndex].reversed() {
            if let typed = subview as? AnyViewType {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a previous sibling that contains a view controller of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    @available(macOS, unavailable)
    public static func previousSibling<AnyViewControllerType: PlatformViewController>(
        containing type: AnyViewControllerType.Type,
        from entry: PlatformViewController
    ) -> AnyViewControllerType? {
        
        guard let parent = entry.parent,
              let entryIndex = parent.children.firstIndex(of: entry),
              entryIndex > 0
        else {
            return nil
        }
        
        for child in parent.children[0..<entryIndex].reversed() {
            if let typed = findChild(ofType: type, in: child) {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a previous sibling that is a view controller of the specified type.
    /// This method does not inspect siblings recursively.
    /// Returns nil if no sibling is of the specified type.
    public static func previousSibling<AnyViewControllerType: PlatformViewController>(
        ofType type: AnyViewControllerType.Type,
        from entry: PlatformViewController
    ) -> AnyViewControllerType? {
        
        guard let parent = entry.parent,
              let entryIndex = parent.children.firstIndex(of: entry),
              entryIndex > 0
        else {
            return nil
        }
        
        for child in parent.children[0..<entryIndex].reversed() {
            if let typed = child as? AnyViewControllerType {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a next sibling that contains a view of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    public static func nextSibling<AnyViewType: PlatformView>(
        containing type: AnyViewType.Type,
        from entry: PlatformView
    ) -> AnyViewType? {
        
        guard let superview = entry.superview,
              let entryIndex = superview.subviews.firstIndex(of: entry)
        else {
            return nil
        }
        
        for subview in superview.subviews[entryIndex..<superview.subviews.endIndex] {
            if let typed = findChild(ofType: type, in: subview) {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds a next sibling that if of the specified type.
    /// This method inspects siblings recursively.
    /// Returns nil if no sibling contains the specified type.
    public static func nextSibling<AnyViewType: PlatformView>(
        ofType type: AnyViewType.Type,
        from entry: PlatformView
    ) -> AnyViewType? {
        
        guard let superview = entry.superview,
              let entryIndex = superview.subviews.firstIndex(of: entry)
        else {
            return nil
        }
        
        for subview in superview.subviews[entryIndex..<superview.subviews.endIndex] {
            if let typed = subview as? AnyViewType {
                return typed
            }
        }
        
        return nil
    }
    
    /// Finds an ancestor of the specified type.
    /// If it reaches the top of the view without finding the specified view type, it returns nil.
    public static func findAncestor<AnyViewType: PlatformView>(ofType type: AnyViewType.Type, from entry: PlatformView) -> AnyViewType? {
        var superview = entry.superview
        while let supV = superview {
            if let typed = supV as? AnyViewType {
                return typed
            }
            superview = supV.superview
        }
        return nil
    }
    
    /// Finds the hosting view of a specific subview.
    /// Hosting views generally contain subviews for one specific SwiftUI element.
    /// For instance, if there are multiple text fields in a VStack, the hosting view will contain those text fields (and their host views, see below).
    /// Returns nil if it couldn't find a hosting view. This should never happen when called with an IntrospectionView.
    public static func findHostingView(from entry: PlatformView) -> PlatformView? {
        var superview = entry.superview
        while let supV = superview {
            if NSStringFromClass(type(of: supV)).contains("HostingView") {
                return supV
            }
            superview = supV.superview
        }
        return nil
    }
    
    /// Finds the view host of a specific view.
    /// SwiftUI wraps each UIView within a ViewHost, then within a HostingView.
    /// Returns nil if it couldn't find a view host. This should never happen when called with an IntrospectionView.
    public static func findViewHost(from entry: PlatformView) -> PlatformView? {
        var superview = entry.superview
        while let supV = superview {
            if NSStringFromClass(type(of: supV)).contains("ViewHost") {
                return supV
            }
            superview = supV.superview
        }
        return nil
    }
}

public enum TargetViewSelector {
    public static func siblingContaining<TargetView: PlatformView>(from entry: PlatformView) -> TargetView? {
        guard let viewHost = Introspect.findViewHost(from: entry) else {
            return nil
        }
        return Introspect.previousSibling(containing: TargetView.self, from: viewHost)
    }
    
    public static func siblingOfType<TargetView: PlatformView>(from entry: PlatformView) -> TargetView? {
        guard let viewHost = Introspect.findViewHost(from: entry) else {
            return nil
        }
        return Introspect.previousSibling(ofType: TargetView.self, from: viewHost)
    }
    
    public static func ancestorOrSiblingContaining<TargetView: PlatformView>(from entry: PlatformView) -> TargetView? {
        if let tableView = Introspect.findAncestor(ofType: TargetView.self, from: entry) {
            return tableView
        }
        return siblingContaining(from: entry)
    }
    
    public static func ancestorOrSiblingOfType<TargetView: PlatformView>(from entry: PlatformView) -> TargetView? {
        if let tableView = Introspect.findAncestor(ofType: TargetView.self, from: entry) {
            return tableView
        }
        return siblingOfType(from: entry)
    }
}

// MARK: - IntrospectionUIView
/// Introspection UIView that is inserted alongside the target view.
@available(iOS 13.0, *)
public class IntrospectionUIView: UIView {
    
    required init() {
        super.init(frame: .zero)
        isHidden = true
        isUserInteractionEnabled = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Introspection View that is injected into the UIKit hierarchy alongside the target view.
/// After `updateUIView` is called, it calls `selector` to find the target view, then `customize` when the target view is found.
public struct UIKitIntrospectionView<TargetViewType: UIView>: UIViewRepresentable {
    
    /// Method that introspects the view hierarchy to find the target view.
    /// First argument is the introspection view itself, which is contained in a view host alongside the target view.
    let selector: (IntrospectionUIView) -> TargetViewType?
    
    /// User-provided customization method for the target view.
    let customize: (TargetViewType) -> Void
    
    public init(
        selector: @escaping (IntrospectionUIView) -> TargetViewType?,
        customize: @escaping (TargetViewType) -> Void
    ) {
        self.selector = selector
        self.customize = customize
    }
    
    public func makeUIView(context: UIViewRepresentableContext<UIKitIntrospectionView>) -> IntrospectionUIView {
        let view = IntrospectionUIView()
        view.accessibilityLabel = "IntrospectionUIView<\(TargetViewType.self)>"
        return view
    }
    
    /// When `updateUiView` is called after creating the Introspection view, it is not yet in the UIKit hierarchy.
    /// At this point, `introspectionView.superview.superview` is nil and we can't access the target UIKit view.
    /// To workaround this, we wait until the runloop is done inserting the introspection view in the hierarchy, then run the selector.
    /// Finding the target view fails silently if the selector yield no result. This happens when `updateUIView`
    /// gets called when the introspection view gets removed from the hierarchy.
    public func updateUIView(_ uiView: IntrospectionUIView, context: UIViewRepresentableContext<UIKitIntrospectionView>) {
        DispatchQueue.main.async {
            guard let targetView = self.selector(uiView) else {
                return
            }
            self.customize(targetView)
        }
    }
}

// MARK: - ViewExtensions
extension View {
    public func inject<SomeView>(_ view: SomeView) -> some View where SomeView: View {
        return overlay(view.frame(width: 0, height: 0))
    }
}

extension View {
    
    /// Finds a `TargetView` from a `SwiftUI.View`
    public func introspect<TargetView: UIView>(
        selector: @escaping (IntrospectionUIView) -> TargetView?,
        customize: @escaping (TargetView) -> Void
    ) -> some View {
        return inject(UIKitIntrospectionView(
            selector: selector,
            customize: customize
        ))
    }
    
    /// Finds a `UINavigationController` from any view embedded in a `SwiftUI.NavigationView`.
    public func introspectNavigationController(customize: @escaping (UINavigationController) -> Void) -> some View {
        return inject(UIKitIntrospectionViewController(
            selector: { introspectionViewController in
                
                // Search in ancestors
                if let navigationController = introspectionViewController.navigationController {
                    return navigationController
                }
                
                // Search in siblings
                return Introspect.previousSibling(containing: UINavigationController.self, from: introspectionViewController)
            },
            customize: customize
        ))
    }
    
    /// Finds a `UITabBarController` from any SwiftUI view embedded in a `SwiftUI.TabView`
    public func introspectTabBarController(customize: @escaping (UITabBarController) -> Void) -> some View {
        return inject(UIKitIntrospectionViewController(
            selector: { introspectionViewController in
                
                // Search in ancestors
                if let navigationController = introspectionViewController.tabBarController {
                    return navigationController
                }
                
                // Search in siblings
                return Introspect.previousSibling(ofType: UITabBarController.self, from: introspectionViewController)
            },
            customize: customize
        ))
    }
    
    /// Finds a `UITableView` from a `SwiftUI.List`, or `SwiftUI.List` child.
    public func introspectTableView(customize: @escaping (UITableView) -> Void) -> some View {
        return introspect(selector: TargetViewSelector.ancestorOrSiblingContaining, customize: customize)
    }
    
    /// Finds a `UIScrollView` from a `SwiftUI.ScrollView`, or `SwiftUI.ScrollView` child.
    public func introspectScrollView(customize: @escaping (UIScrollView) -> Void) -> some View {
        if #available(iOS 14.0, tvOS 14.0, macOS 11.0, *) {
            return introspect(selector: TargetViewSelector.ancestorOrSiblingOfType, customize: customize)
        } else {
            return introspect(selector: TargetViewSelector.ancestorOrSiblingContaining, customize: customize)
        }
    }
    
    /// Finds the containing `UIViewController` of a SwiftUI view.
    public func introspectViewController(customize: @escaping (UIViewController) -> Void) -> some View {
        return inject(UIKitIntrospectionViewController(
            selector: { $0.parent },
            customize: customize
        ))
    }
    
    /// Finds a `UITextField` from a `SwiftUI.TextField`
    public func introspectTextField(customize: @escaping (UITextField) -> Void) -> some View {
        return introspect(selector: TargetViewSelector.siblingContaining, customize: customize)
    }
    //
    //    /// Finds a `UISwitch` from a `SwiftUI.Toggle`
    //    @available(tvOS, unavailable)
    //    public func introspectSwitch(customize: @escaping (UISwitch) -> ()) -> some View {
    //        return introspect(selector: TargetViewSelector.siblingContaining, customize: customize)
    //    }
    //
    //    /// Finds a `UISlider` from a `SwiftUI.Slider`
    //    @available(tvOS, unavailable)
    //    public func introspectSlider(customize: @escaping (UISlider) -> ()) -> some View {
    //        return introspect(selector: TargetViewSelector.siblingContaining, customize: customize)
    //    }
    //
    //    /// Finds a `UIStepper` from a `SwiftUI.Stepper`
    //    @available(tvOS, unavailable)
    //    public func introspectStepper(customize: @escaping (UIStepper) -> ()) -> some View {
    //        return introspect(selector: TargetViewSelector.siblingContaining, customize: customize)
    //    }
    //
    //    /// Finds a `UIDatePicker` from a `SwiftUI.DatePicker`
    //    @available(tvOS, unavailable)
    //    public func introspectDatePicker(customize: @escaping (UIDatePicker) -> ()) -> some View {
    //        return introspect(selector: TargetViewSelector.siblingContaining, customize: customize)
    //    }
    //
    //    /// Finds a `UISegmentedControl` from a `SwiftUI.Picker` with style `SegmentedPickerStyle`
    //    public func introspectSegmentedControl(customize: @escaping (UISegmentedControl) -> ()) -> some View {
    //        return introspect(selector: TargetViewSelector.siblingContaining, customize: customize)
    //    }
}

/// Introspection UIViewController that is inserted alongside the target view controller.
@available(iOS 13.0, tvOS 13.0, macOS 10.15.0, *)
public class IntrospectionUIViewController: UIViewController {
    required init() {
        super.init(nibName: nil, bundle: nil)
        view = IntrospectionUIView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// This is the same logic as IntrospectionView but for view controllers. Please see details above.
@available(iOS 13.0, tvOS 13.0, macOS 10.15.0, *)
public struct UIKitIntrospectionViewController<TargetViewControllerType: UIViewController>: UIViewControllerRepresentable {
    
    let selector: (IntrospectionUIViewController) -> TargetViewControllerType?
    let customize: (TargetViewControllerType) -> Void
    
    public init(
        selector: @escaping (UIViewController) -> TargetViewControllerType?,
        customize: @escaping (TargetViewControllerType) -> Void
    ) {
        self.selector = selector
        self.customize = customize
    }
    
    public func makeUIViewController(
        context: UIViewControllerRepresentableContext<UIKitIntrospectionViewController>
    ) -> IntrospectionUIViewController {
        let viewController = IntrospectionUIViewController()
        viewController.accessibilityLabel = "IntrospectionUIViewController<\(TargetViewControllerType.self)>"
        viewController.view.accessibilityLabel = "IntrospectionUIView<\(TargetViewControllerType.self)>"
        return viewController
    }
    
    public func updateUIViewController(
        _ uiViewController: IntrospectionUIViewController,
        context: UIViewControllerRepresentableContext<UIKitIntrospectionViewController>
    ) {
        DispatchQueue.main.async {
            guard let targetView = self.selector(uiViewController) else {
                return
            }
            self.customize(targetView)
        }
    }
}
#endif
