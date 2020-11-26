//
//  BaseViewController.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initAndAddloadingView()  {
        loadingView =  LoadingView.loadViewFromNib()
        loadingView?.frame = self.view.frame
        self.view.addSubview(loadingView)
    }
}
extension BaseViewController: BaseViewDelegate{
    @objc  func showError(with message: String) {
        DispatchQueue.main.async() {
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Alert Error Title"), message: message, preferredStyle:UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(alertController, animated: false, completion: nil)
        }
    }
    
    @objc  func showInformationMessage(with message: String, title: String = "") {
        DispatchQueue.main.async() {
            let alertController = UIAlertController(title:title, message: message, preferredStyle:UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(alertController, animated: false, completion: nil)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            if self.loadingView == nil {
                self.initAndAddloadingView()
            }
            self.view.bringSubviewToFront(self.loadingView)
            self.loadingView.startAnimating()
        }
    }
    
    func hideLoading() {
        if loadingView != nil {
            DispatchQueue.main.async {
                self.loadingView.stopAnimating()
                self.loadingView = nil
            }
        }
    }
    
}
