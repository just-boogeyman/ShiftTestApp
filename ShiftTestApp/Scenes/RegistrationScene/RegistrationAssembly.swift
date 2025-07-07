//
//  RegistrationAssembly.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

final class RegistrationAssembly {
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension RegistrationAssembly: BaseAssembly {
	func configure(with viewController: UIViewController) {
		guard let registrationVC = viewController as? RegistrationViewController else { return }
		let router = RegistrationRouter(navigationController: navigationController)
		let worker = RegistrationWorker()
		let presenter = RegistrationPresenter(
			view: registrationVC,
			router: router,
			worker: worker
		)
		registrationVC.presenter = presenter
	}
}
