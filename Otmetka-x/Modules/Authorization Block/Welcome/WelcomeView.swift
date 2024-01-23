//
//  WelcomeView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 23.01.2024.
//

import Foundation

protocol WelcomeViewControllerDelegate: AnyObject {}

final class WelcomeViewController: BaseViewController {
    
    // Dependencies
    var presenter: WelcomePresenterProtocol!
    
    override func setup() {
        
    }
}
