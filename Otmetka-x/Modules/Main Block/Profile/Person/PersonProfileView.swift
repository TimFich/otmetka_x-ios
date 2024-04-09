//
//  ProfileView.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import UIKit
import SnapKit

protocol PersonProfileViewControllerDelegate: AnyObject {
    
}

final class PersonProfileViewController: BaseViewController, PersonProfileViewControllerDelegate {
    
    // Dependencies
    var presenter: PersonProfilePresenterProtocol!
    
    // UI
    let button: UIButton = {
        let button = UIButton()
        button.onTouchUpInside {
            MainCoordinator.shared.logout()
        }
        button.customizePrimary()
        button.setTitle("Выйти", for: .normal)
        return button
    }()
    
    override func setup() {
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .systemBackground
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        navigationItem.title = R.string.localizable.profileTitle()
        tabBarItem = UITabBarItem(title: R.string.localizable.profileTitle(),
                                  image: R.image.profile(),
                                  selectedImage: R.image.profile())
    }
    
    override func layout() {
        super.layout()
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(Specs.constraints.mediumConstraint)
        }
    }
}
