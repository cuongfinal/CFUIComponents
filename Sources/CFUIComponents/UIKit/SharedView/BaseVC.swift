//
//  BaseVC.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 26/08/2021.
//

import UIKit

open class BaseVC: UIViewController {
    private var currentLeftBarButton = [UIButton]()
    private var currentRightBarButton = [UIButton]()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIColor.GrayLight.as1ptImage()
    }
    
    public func configureNavigationVC(leftBarItems: [UIButton]? = nil,
                               rightBarItems: [UIButton]? = nil,
                               isLeftBack: Bool = false,
                               isLeftDismiss: Bool = false,
                               titleName: String? = nil) {
        //Setup right bar buttons
        if let rightBarItems = rightBarItems {
            var rightBarButtons = [UIBarButtonItem]()
            for rightButton in rightBarItems {
                rightButton.addTarget(self, action: #selector(self.rightBarButtonTapped(_:)), for: UIControl.Event.touchUpInside)
                currentRightBarButton.append(rightButton)
                rightBarButtons.append(UIBarButtonItem(customView: rightButton))
            }
            self.navigationItem.setRightBarButtonItems(rightBarButtons, animated: false)
        }
        //Setup left bar buttons
        if let leftBarItems = leftBarItems {
            var leftBarButtons = [UIBarButtonItem]()
            for leftButton in leftBarItems {
                leftButton.addTarget(self, action: #selector(self.leftBarButtonTapped(_:)), for: UIControl.Event.touchUpInside)
                currentLeftBarButton.append(leftButton)
                leftBarButtons.append(UIBarButtonItem(customView: leftButton))
            }
            self.navigationItem.setLeftBarButtonItems(leftBarButtons, animated: false)
        } else if isLeftBack {
            let close = UIImage(named: "icon-back")
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: close, style: .plain, target: self, action: #selector(goBack))
        } else if isLeftDismiss {
            let close = UIImage(named: "icon-close")
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: close, style: .plain, target: self, action: #selector(dismissVC))
        }
        
        self.navigationItem.leftBarButtonItem?.tintColor = .TextBlack
        self.navigationItem.rightBarButtonItem?.tintColor = .PrimaryColorRed
        
        //Set center title
        let lbTitle = UILabel(frame: CGRect.zero)
        lbTitle.backgroundColor = UIColor.clear
        lbTitle.font = AvenirNext.demiBold(size: 17)
        lbTitle.textAlignment = .center
        lbTitle.textColor = .TextBlack
        if let titleName = titleName {
            lbTitle.text = titleName
        } else {
            lbTitle.text = self.title
        }
        self.navigationItem.titleView = lbTitle
        lbTitle.sizeToFit()
    }
    
    @objc private func leftBarButtonTapped(_ sender: UIButton) {
        guard let btnIndex = currentLeftBarButton.firstIndex(of: sender) else { return }
        didTapOnLeftBarButton(btnIndex)
    }
    
    @objc private func rightBarButtonTapped(_ sender: UIButton) {
        guard let btnIndex = currentRightBarButton.firstIndex(of: sender) else { return }
        didTapOnRightBarButton(btnIndex)
    }
    
    open func didTapOnLeftBarButton(_ buttonIndex: Int) {
        //Override it when need to handle left button tap
    }
    open func didTapOnRightBarButton(_ buttonIndex: Int) {
        //Override it when need to handle right button tap
    }
    
    @objc open func goBack() {
        self.popViewController()
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

open class BaseVCHideNavWhenPush: BaseVC {
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}


open class BaseVCShowNavAfterPush: BaseVC {
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
