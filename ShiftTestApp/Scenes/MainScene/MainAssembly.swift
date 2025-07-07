//
//  MainAssembly.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

final class MainAssembly {
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension MainAssembly: BaseAssembly {
	func configure(with viewController: UIViewController) {
		guard let mainVC = viewController as? MainViewController else { return }
		let router = MainRouter(navigationController: navigationController)
		let network = NetworkManager()
		let presenter = MainPresenter(
			view: mainVC,
			router: router,
			network: network
		)
		
		mainVC.presenter = presenter
	}
}
