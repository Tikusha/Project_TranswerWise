//
//  LoadSiteViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 9/24/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class LoadSiteViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var webView: UIWebView!

    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSite()
    }
    
    // MARK: - Load Site
    private func loadSite() {
        let url = URL(string: "https://www.transferwise.com")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
    }
    
    // MARK: - IBActions
    @IBAction private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
