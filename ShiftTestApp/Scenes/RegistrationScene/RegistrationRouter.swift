//
//  RegistrationRouter.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

protocol IRegistrationRouter: BaseRouting {
	
}

final class RegistrationRouter {
	
	enum Target {
		case errorAlert(RegistrationValidationError)
		case nextVC
	}
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension RegistrationRouter: IRegistrationRouter {
	func routeTo(target: Any) {
		guard let target = target as? RegistrationRouter.Target else { return }
		
		switch target {
		case .errorAlert(let error):
			let alert = UIAlertController(
				title: "Ошибка регистрации",
				message: error.localizedDescription,
				preferredStyle: .alert
			)
			alert.addAction(
				UIAlertAction(
					title: "Ок",
					style: .default,
					handler: nil
				)
			)
			navigationController.present(alert, animated: true)
		case .nextVC:
			let mainVC = MainViewController()
			let mainAssembly = MainAssembly(navigationController: navigationController)
			mainAssembly.configure(with: mainVC)
			
			mainVC.modalPresentationStyle = .fullScreen
			navigationController.pushViewController(mainVC, animated: true)
		}
	}
}

