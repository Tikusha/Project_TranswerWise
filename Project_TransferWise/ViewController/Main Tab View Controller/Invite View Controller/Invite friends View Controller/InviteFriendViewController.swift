//
//  InviteFriendViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 8/14/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit
import MessageUI

class InviteFriendViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var inviteViaEmailButton: UIButton!
    @IBOutlet private weak var inviteViaSMSButton: UIButton!
    @IBOutlet private weak var copyLinkButton: UIButton!
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.inviteViaEmailButton.customCornerButton(cornerRadius: 3, borderWidth: 1, borderColor: Constants.Color.brandBlue)
        self.inviteViaSMSButton.customCornerButton(cornerRadius: 3, borderWidth: 1, borderColor: Constants.Color.brandBlue)
        self.copyLinkButton.customCornerButton(cornerRadius: 3, borderWidth: 1, borderColor: Constants.Color.brandBlue)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print(Constant.cencalled)
            self.dismiss(animated: true, completion: nil)
        case .failed:
            print(Constant.failed)
            self.dismiss(animated: true, completion: nil)
        case .sent:
            print(Constant.sent)
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    @IBAction private func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func shareLink(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [" "], applicationActivities:  nil)
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            completed ? print(Constant.completed) : print(Constant.cencalled)
        }
        present(activityController, animated: true) {
            print(Constant.presented)
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = Constant.inviteMessage + Constant.link
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            print("sent massage to number")
        }
    }
    
    @IBAction func copyLink() {
        UIButton.animate(
            withDuration: 1.0,
            delay: 5.0,
            options: .curveEaseIn,
            animations: {
                self.copyLinkButton.setTitle(Constant.copied, for: .normal)
            }
        )
    }
    
    @IBAction private func copyText() {
        UIPasteboard.general.string = Constant.link
    }
}

extension InviteFriendViewController {
    enum Constant {
        static let copied = "Copied"
        static let completed = "completed"
        static let cencalled = "cencaled"
        static let presented = "presented"
        static let failed = "failed"
        static let sent = "sent"
        static let inviteMessage = "I've been using TransferWise to send money abroad. really easy and a lot cheaper than the bank! I got you a free transfer using my invite link: "
        static let link = "https://transferwise.com/invite/is/e6ecea"
    }
}
