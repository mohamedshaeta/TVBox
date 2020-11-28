//
//  BasePresenter.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit

protocol BaseViewDelegate {
    func showError(with message:String)
    func showLoading()
    func hideLoading()
}
protocol BaseModelViewDelegate: BaseViewDelegate {
    func dismissCurrentView()
}

class BasePresenter {
    var viewDelegate: BaseViewDelegate?
    func attach(to view:BaseViewDelegate)  {
        self.viewDelegate = view
    }
}

