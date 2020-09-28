//
//  AccountViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/1/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var homeView: UIView!
    @IBOutlet private weak var detailView: UIView!
    @IBOutlet private weak var contactView: UIView!
    
    // MARK: - Componenets of slide
    private var sliderSettings: AccountSettingView?
    private var sliderPersonal: PersonalAccountView?
    private var sliderBackground: UIView?
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
        dismissKeyboard()
    }
    
    // MARK: - Configuration
    private func configuration() {
        let heightContact = self.contactView.frame.size.height
        let heightHome = self.homeView.frame.size.height
        let heightdetail = self.detailView.frame.size.height
        self.homeView.cornerView(cornerRadius: heightHome/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
        self.detailView.cornerView(cornerRadius: heightdetail/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
        self.contactView.cornerView(cornerRadius: heightContact/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
    }
    
    @objc func closeSlideOfSettings() {
        UIView.animate(withDuration: 0.5) {
            self.sliderBackground?.alpha = 0.0
            self.sliderSettings?.frame.origin.y = self.view.frame.size.height
        }
    }
    
    @objc func closeSlideOfPersonal() {
        UIView.animate(withDuration: 0.5) {
            self.sliderBackground?.alpha = 0.0
            self.sliderPersonal?.frame.origin.y = self.view.frame.size.height
        }
    }
    
    // MARK: - IBActions
    @IBAction private func signOut() {
        self.sliderBackground = UIView(frame: CGRect(origin: .zero, size: self.view.bounds.size))
        guard let shadow = Bundle.main.loadNibNamed("AccountSettingView", owner: nil, options: nil)?.first as? AccountSettingView else { return }
        self.sliderSettings = shadow
        self.sliderSettings?.delegate = self
        let slideHeight: CGFloat = self.view.frame.size.height/2.4
        loadSlide(sliderBackground: self.sliderBackground, slider: self.sliderSettings, slideHeight: slideHeight)
        self.sliderBackground?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeSlideOfSettings)))
    }
    
    @IBAction private func personalAccount() {
        self.sliderBackground = UIView(frame: CGRect(origin: .zero, size: self.view.bounds.size))
        guard let shadow = Bundle.main.loadNibNamed("PersonalAccountView", owner: nil, options: nil)?.first as? PersonalAccountView else { return }
        self.sliderPersonal = shadow
        self.sliderPersonal?.delegate = self
        let slideHeight: CGFloat = self.view.frame.size.height/2
        loadSlide(sliderBackground: self.sliderBackground, slider: self.sliderPersonal, slideHeight: slideHeight)
        self.sliderBackground?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeSlideOfPersonal)))
    }
    
    @IBAction func tapPiece(_ gestureRecognizer : UITapGestureRecognizer ) {
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .ended {      // Move the view down and to the right when tapped.
            let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
                gestureRecognizer.view!.center.x += 100
                gestureRecognizer.view!.center.y += 100
            })
            animator.startAnimation()
        }}
    
    @IBAction private func aboutUser() {
        let vc = AboutUserViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

extension AccountViewController: MoveOtherScreenDelegate {
    func selectLogOut() {
        self.closeSlideOfSettings()
        let vc = MainScreenViewController(nibName: "MainScreen", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

extension AccountViewController: PersonalAccountDelegate {
    func movePersonalAccount() {
        self.closeSlideOfPersonal()
        let vc = AboutUserViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func moveBusinessAccount() {
        self.closeSlideOfPersonal()
        let vc = BusinessAccountViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
