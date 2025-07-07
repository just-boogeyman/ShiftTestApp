//
//  MainRouter.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

protocol IMainRouter: BaseRouting {
	
}

final class MainRouter {
	let nanavigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.nanavigationController = navigationController
	}
}

extension MainRouter: IMainRouter {
	func routeTo(target: Any) {
	}
}
