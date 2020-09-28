//
//  MainTabViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 7/19/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.delegate = self
        UINavigationBar.appearance().prefersLargeTitles = true
//        UITabBar.appearance().backgroundColor = UIColor.white
        self.viewControllers = generateControllers()
        self.setupTabBarColor()
    }
    
    private func setupTabBarColor() {
        self.tabBar.tintColor = Constants.Color.brandBlue
        self.tabBar.layer.borderWidth = 0.3
        self.tabBar.layer.borderColor = Constants.Color.disabledGrey.cgColor
        self.tabBar.clipsToBounds = true
//        self.tabBar.isTranslucent = false
    }
    
    // MARK: - Generate controllers
    private func generateControllers() -> [UIViewController] {
        let home = setTabBarItem(vc: HomeViewController(), title: "Home", image: #imageLiteral(resourceName: "home"))
        let account = setTabBarItem(vc: AccountViewController(), title: "Account", image: #imageLiteral(resourceName: "account") )
        let send = setTabBarItem(vc: SendScreenViewController(), title: "Send", image: nil)
        let recipients = setTabBarItem(vc: RecipientViewController(), title: "Recipients", image: #imageLiteral(resourceName: "recipients") )
        let invite = setTabBarItem(vc: InviteViewController(), title: "Invite", image: #imageLiteral(resourceName: "invite") )
        
        self.setupMiddleIcon()
        return [home, account, send, recipients, invite]
    }
    
    // MARK: - Set tab bar items
    private func setTabBarItem(vc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        if let image = image {
            vc.tabBarItem.image = image
        }
        return vc
    }
    
    // MARK: - Setup middle icon
    private func setupMiddleIcon() {
        let frame = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        var shadeFrame = frame.frame
        shadeFrame.origin.y = self.view.frame.height - self.tabBar.frame.height - shadeFrame.height/2 - 35
        shadeFrame.origin.x = self.view.bounds.width/2 - shadeFrame.size.width/2
        frame.frame = shadeFrame
        frame.backgroundColor = UIColor.white
        frame.layer.cornerRadius = shadeFrame.height/2
        self.view.addSubview(frame)
        
        let roundLine = CAShapeLayer()
        roundLine.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: frame.frame.size.width, height: frame.frame.size.height)).cgPath
        roundLine.lineWidth = 0.3
        roundLine.strokeStart = 0.5
        roundLine.strokeEnd = 1.0
        roundLine.fillColor = UIColor.white.cgColor
        roundLine.strokeColor = Constants.Color.disabledGrey.cgColor
        frame.layer.addSublayer(roundLine)
        
        let middleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        var buttonFrame = middleButton.frame
        buttonFrame.origin.x = frame.bounds.width/2 - buttonFrame.size.width/2
        buttonFrame.origin.y = frame.bounds.height/2 - buttonFrame.height/2
        middleButton.frame = buttonFrame
        middleButton.backgroundColor = Constants.Color.payGreen
        middleButton.layer.cornerRadius = buttonFrame.height/2
        middleButton.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        frame.addSubview(middleButton)
        
        let middleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        var imageFrame = middleImage.frame
        imageFrame.origin.x = middleButton.bounds.width/2 - imageFrame.width/2
        imageFrame.origin.y = middleButton.bounds.height/2 - imageFrame.height/2
        middleImage.frame = imageFrame
        middleImage.layer.cornerRadius = imageFrame.height/2
        middleImage.image = UIImage(named: "send_arrow")
        middleButton.addSubview(middleImage)
    }
    
    @objc func actionButton() {
        let result = tabBarController(self, shouldSelect: SendScreenViewController())
        print(result)
    }
}

extension MainTabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: SendScreenViewController.self) {
            let vc = SendScreenViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            return false
        }
        return true
    }
}
