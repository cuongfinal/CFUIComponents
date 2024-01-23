//
//  UIScreen+Convenience.swift
//  UICompanent
//
//  Created by CuongFinal on 8/3/21.
//  Copyright © All rights reserved.
//
// swiftlint:disable identifier_name operator_whitespace
#if canImport(UIKit) && os(iOS)
import UIKit

public func <(lhs: Device.Size, rhs: Device.Size) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

public func >(lhs: Device.Size, rhs: Device.Size) -> Bool {
    return lhs.rawValue > rhs.rawValue
}

public func ==(lhs: Device.Size, rhs: Device.Size) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

open class Device {
    public enum DeviceType {
        case iPhone
        case iPad
        case unspecified
    }
    
    public enum Version: String {
        /*** iPhone ***/
        case iPhone8
        case iPhone8Plus
        case iPhoneXS_Max
        case iPhone11Pro_Max
        case iPhone13Mini
        case iPhone13
        case iPhone13Pro
        case iPhone13Pro_Max
        /*** simulator ***/
        case simulator
        /*** unknown ***/
        case unknown
        /*** iPad ***/
        case iPadAir4 //820x1180
        case iPadMini6 //744x1133
        case iPadPro1_97  //768x1024
        case iPadPro2_105 //834x1112
        case iPadPro5_11 //834x1194
        case iPadPro5_129 //1024x1366
        case iPad9th  //810x1080
    }
    
    public enum Size: Int, Comparable {
        case unknownSize = 0
        /// iPhone 6, 6s, 7, 8, SE 2nd gen.
        case screen4_7Inch
        /// iPhone 12 Mini
        case screen5_4Inch
        /// iPhone 6+, 6s+, 7+, 8+
        case screen5_5Inch
        /// iPhone X, Xs, 11 Pro
        case screen5_8Inch
        /// iPhone Xr, 11, 13, 13 Pro
        case screen6_1Inch
        /// iPhone Xs Max, 11 Pro Max
        case screen6_5Inch
        /// iPhone 13 Pro Max
        case screen6_7Inch
        
        ///IPad Mini 6
        case screen_8_3Inch
        ///IPad Air 2, Pro 1 Small, 5th, 6th
        case screen_9_7Inch
        ///IPad 7th, 8th, 9th
        case screen_10_2Inch
        ///IPad Pro 2 Small, Air 3
        case screen_10_5Inch
        ///IPad Air 4
        case screen_10_9Inch
        ///IPad Pro 3, 4, 5 Small
        case screen_11Inch
        ///IPad Pro 1, 2, 3, 4, 5 Large
        case screen_12_9Inch
    }
    
    public static var ipAddress: String? {
        getAddress(for: .wifi) ?? getAddress(for: .cellular)
    }
    
    static fileprivate func getVersionCode() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
        
        return versionCode
    }
    
    static public var deviceType: DeviceType {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return .iPhone
        case .pad:
            return .iPad
        default:
            return .unspecified
        }
    }
    
    public static var version: Version {
        switch getVersionCode() {
            /*** iPhone ***/
        case "iPhone10,1", "iPhone10,4":  return .iPhone8
        case "iPhone10,2", "iPhone10,5":  return .iPhone8Plus
        case "iPhone13,1":                return .iPhone13Mini
        case "iPhone13,2":                return .iPhone13
        case "iPhone13,3":                return .iPhone13Pro
        case "iPhone13,4":                return .iPhone13Pro_Max
            /*** Simulator ***/
        case "i386", "x86_64":            return .simulator
            /*** iPad  ***/
        case "iPad13,1", "iPad13,2":      return .iPadAir4
        case "iPad14,1", "iPad14,2":      return .iPadMini6
        case "iPad6,3", "iPad6,4":        return .iPadPro1_97
        case "iPad7,1", "iPad7,2":        return .iPadPro2_105
            
        case "iPad13,4", "iPad13,5",
            "iPad13,6", "iPad13,7":       return .iPadPro5_11
        case "iPad13,8", "iPad13,9":      return .iPadPro5_129
        case "iPad12,1", "iPad12,2":      return .iPad9th
            /*** Unknown***/
        default:                          return .unknown
        }
    }
    
    static public var size: Size {
        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(w, h)
        
        switch screenHeight {
        case 667:
            return UIScreen.main.scale == 3.0 ? .screen5_5Inch : .screen4_7Inch
        case 736:
            return .screen5_5Inch
        case 812:
            return Self.version == .iPhone13Mini ? .screen5_4Inch : .screen5_8Inch
        case 844:
            return .screen6_1Inch
        case 896:
            switch Self.version {
            case .iPhoneXS_Max, .iPhone11Pro_Max:
                return .screen6_5Inch
            default:
                return .screen6_1Inch
            }
        case 926:
            return .screen6_7Inch
            
        case 1133:
            return .screen_8_3Inch
        case 1024:
            return .screen_9_7Inch
        case 1080:
            return .screen_10_2Inch
        case 1180:
            return .screen_10_9Inch
        case 1112:
            return .screen_10_5Inch
        case 1194:
            return .screen_11Inch
        case 1366:
            return .screen_12_9Inch
        default:
            return .unknownSize
        }
    }
    
    static public var aspectRatioRate: CGSize {
        if self.deviceType == .iPhone {
            return self.size > .screen5_5Inch ? CGSize(width: 3, height: 6.5) : CGSize(width: 3, height: 5.36)
        } else {
            switch self.size {
            case .screen_8_3Inch:
                return CGSize(width: 3, height: 4.56)
            case .screen_9_7Inch, .screen_10_2Inch, .screen_10_5Inch, .screen_12_9Inch:
                return CGSize(width: 3, height: 4)
            case .screen_10_9Inch:
                return CGSize(width: 3, height: 4.32)
            case .screen_11Inch:
                return CGSize(width: 3, height: 4.29)
            default:
                return CGSize(width: 3, height: 4)
            }
        }
    }
    
    static func getAddress(for network: Network) -> String? {
        var address: String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if name == network.rawValue {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
    enum Network: String {
        case wifi = "en0"
        case cellular = "pdp_ip0"
    }
}

public extension UIScreen {
    
    static func mainOrigin() -> CGPoint {
        main.origin
    }
    
    static func mainWidthScaled(_ scale: CGFloat) -> CGFloat {
        main.widthScaled(scale)
    }
    
    static func mainHeightScaled(_ scale: CGFloat) -> CGFloat {
        main.heightScaled(scale)
    }
    
    static var mainWidth: CGFloat {
        main.width
    }
    
    static var mainHeight: CGFloat {
        main.height
    }
    
    static var mainMidX: CGFloat {
        main.midX
    }
    
    static var mainMidY: CGFloat {
        main.midY
    }
    
    static var mainMinX: CGFloat {
        main.minX
    }
    
    static var mainMinY: CGFloat {
        main.minY
    }
    
    static var mainMaxX: CGFloat {
        main.maxX
    }
    
    static var mainMaxY: CGFloat {
        main.maxY
    }
    
    static var mainSize: CGSize {
        main.size
    }
    
    static var safeArea: UIEdgeInsets {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets ?? .zero
    }
    
    func widthScaled(_ scale: CGFloat) -> CGFloat {
        width * scale
    }
    
    func heightScaled(_ scale: CGFloat) -> CGFloat {
        height * scale
    }
    
    var origin: CGPoint {
        bounds.origin
    }
    
    var width: CGFloat {
        bounds.width
    }
    
    var height: CGFloat {
        bounds.height
    }
    
    var size: CGSize {
        bounds.size
    }
    
    var midX: CGFloat {
        bounds.midX
    }
    
    var midY: CGFloat {
        bounds.midY
    }
    
    var minX: CGFloat {
        bounds.origin.x
    }
    
    var minY: CGFloat {
        bounds.origin.y
    }
    
    var maxX: CGFloat {
        bounds.maxX
    }
    
    var maxY: CGFloat {
        bounds.maxY
    }
    
    static func visibleViewController(baseVC: UIViewController? = nil) -> UIViewController? {
        let rootVC = baseVC ?? UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController
        
        if let nav = rootVC as? UINavigationController {
            return visibleViewController(baseVC: nav.visibleViewController)
        }
        if let tab = rootVC as? UITabBarController, let selected = tab.selectedViewController {
            return visibleViewController(baseVC: selected)
        }
        if let presented = rootVC?.presentedViewController {
            return visibleViewController(baseVC: presented)
        }
        return rootVC
    }
}

public extension UIApplication {
    class func openURL(path: String) {
        guard let url: URL = URL(string: path) else { return }
        UIApplication.shared.open(url)
    }
    
    class func dismissModalIfNeeded(animated: Bool = true) {
        UIScreen.visibleViewController()?.dismiss(animated: animated, completion: nil)
    }
    
    class func popViewControllerIfNeeded(animated: Bool = true) {
        guard let rootVC = UIScreen.visibleViewController() else { return }
        
        let tabVC: UITabBarController? = self.getController(in: rootVC)
        let nav: UINavigationController? = getController(in: tabVC?.selectedViewController ?? rootVC)
        nav?.popViewController(animated: animated)
    }
    
    class func popViewControllerTwoTimeIfNeeded(animated: Bool = true) {
        guard let rootVC = UIScreen.visibleViewController() else { return }
        
        let tabVC: UITabBarController? = self.getController(in: rootVC)
        let nav: UINavigationController? = getController(in: tabVC?.selectedViewController ?? rootVC)
        nav?.popViewController(animated: animated)
        nav?.popViewController(animated: animated)
    }
    
    class func getController<Type>(in root: UIViewController) -> Type? {
        for child in root.children {
            if let typed = child as? Type {
                return typed
            } else if let typed: Type = getController(in: child) {
                return typed
            }
        }
        return nil
    }
}

public extension UIView {
    func snapshot() -> UIImage? {
        UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: false)
        }
    }
}

extension UITextField {
    func addDoneButtonOnKeyboard(barStyle: UIBarStyle) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = barStyle
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "done".localized, style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc
    func doneButtonAction() {
        self.resignFirstResponder()
    }
}

public extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

public extension NSError {
    convenience init(message: String, code: Int = 1001) {
        self.init(domain: message, code: code, userInfo: [NSLocalizedDescriptionKey: message])
    }
}

public extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
#endif
