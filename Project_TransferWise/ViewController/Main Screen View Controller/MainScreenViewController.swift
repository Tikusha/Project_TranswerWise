//
//  ViewController.swift
//  Project_TransferWise
//
//  Created by Tiko on 7/10/20.
//  Copyright © 2020 Tiko. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var googleButton: UIButton!
    @IBOutlet private weak var lineOneView: UIView!
    @IBOutlet private weak var lineTwoView: UIView!
    @IBOutlet private weak var lineThreeView: UIView!
    @IBOutlet private weak var lineFourView: UIView!
    
    // MARK: - Properties
    private let listTexts = MoneyTexts()
    private let listImage = TransferWiseImage()
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.configuration()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.logInButton.customCornerButton(cornerRadius: 2, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        self.signInButton.customCornerButton(cornerRadius: 2, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        self.googleButton.customCornerButton(cornerRadius: 2, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        self.lineOneView.cornerView(cornerRadius: 4, borderWidth: 0.2, borderColor: Constants.Color.backgroundGrey)
        self.lineTwoView.cornerView(cornerRadius: 4, borderWidth: 0.2, borderColor: Constants.Color.backgroundGrey)
        self.lineThreeView.cornerView(cornerRadius: 4, borderWidth: 0.2, borderColor: Constants.Color.backgroundGrey)
        self.lineFourView.cornerView(cornerRadius: 4, borderWidth: 0.2, borderColor: Constants.Color.backgroundGrey)
    }
    
    private func registerCell() {
        self.collectionView.register(UINib(nibName: "TitleCell", bundle: nil), forCellWithReuseIdentifier: "TitleCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - IBActions
    @IBAction private func logIn(_ sender: Any) {
        let vc = LogInViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func register(_ sender: Any) {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate
extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pictureView.image = self.listImage.images[indexPath.row]
    }
}

// MARK: - UIScrollViewDelegate
extension MainScreenViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let random = self.listImage.images.randomElement() {
            self.pictureView.image = random
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.listTexts.largeText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as? TitleCell
        cell?.largeText.text = self.listTexts.largeText[indexPath.row]
        cell?.smallText.text = self.listTexts.smallText[indexPath.row]
        return cell!
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
}

