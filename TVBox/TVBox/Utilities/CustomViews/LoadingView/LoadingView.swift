//
//  LoadingView.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit

class LoadingView: UIView {
    
    static let nibName = "LoadingView"
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    static func loadViewFromNib() -> LoadingView? {
        return (Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0] as! LoadingView)
    }
    func startAnimating()  {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating()  {
        activityIndicatorView.stopAnimating()
        self.removeFromSuperview()
    }
    
}
