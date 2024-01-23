//
//  UIViewController+Utilities.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 26/08/2021.
//

import UIKit

public extension UIViewController {
    
    func createNavBarButton(_ image: UIImage?, title: String? = nil) -> UIButton? {
        let iconButton = UIButton(type: .custom)
        if let title = title {
            iconButton.setTitle(title, for: .normal)
            iconButton.titleLabel?.font = AvenirNext.demiBold(size: 17)
            iconButton.setTitleColor(.TextBlack, for: .normal)
            iconButton.setTitleColor(.GrayDark, for: .disabled)
            return iconButton
        }
        if let image = image {
            iconButton.frame.size = image.size
            iconButton.setBackgroundImage(image, for: .normal)
            return iconButton
        }
        return nil
    }
    
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func presentWithNavigation(_ target: UIViewController?) {
        var navigationController: UINavigationController?
        if let target = target {
            navigationController = UINavigationController(rootViewController: target)
        }
        if let navigationController = navigationController {
            self.navigationController?.present(navigationController,
                                               animated: true)
        }
    }
    
    
    func push(_ target: UIViewController?) {
        if let target = target {
            self.navigationController?.pushViewController(target, animated: true)
        }
    }
    
    func pushWithCompleted(viewController: UIViewController?, canBack: Bool,
                           completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.push(viewController)
        CATransaction.commit()
    }
    
    func pushMultiVC(_ target: [UIViewController]) {
        self.navigationController?.setViewControllers(target, animated: true)
    }
    
    func popViewController() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    func popWithCompleted(navCtrl: UINavigationController?, animated: Bool,
                          completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navCtrl?.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    //MARK: Alert Function
    func showGeneralErrorAlert() {
        self.showWarningAlert(localizedString("alert_general_error_title"), message: localizedString("alert_general_error_content"), cancelTitle: "OK", completedClosure: nil)
    }
    
    func showWarningAlert(_ title: String = localizedString("alert_notice_title"), message: String?, cancelTitle: String, completedClosure: (() -> Void)?) {
        let warningAlert = AlertVC.shared.warningAlert(title, message: message, cancelTitle: cancelTitle, completedClosure: completedClosure)
        self.present(warningAlert, animated: true, completion: nil)
    }
    
    func showConfirmAlert(_ title: String?, message: String?, cancelTitle: String, confirmTitle: String, completedClosure: CompletedClosure, confirmClosure: ConfirmClosure) {
        let confirmAlert = AlertVC.shared.confirmAlert(title, message: message, cancelTitle: cancelTitle, confirmTitle: confirmTitle, completedClosure: completedClosure, confirmClosure: confirmClosure)
        self.present(confirmAlert, animated: true, completion: nil)
    }
}
