//
//  SceneDelegate.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)

		if UserSessionManager.shared.isUserRegistered {
			let mainVC = MainViewController()
			let navigationController = getNavigationController(viewController: mainVC)
			let mainAssembly = MainAssembly(navigationController: navigationController)
			mainAssembly.configure(with: mainVC)
			window.rootViewController = navigationController

		} else {
			let vc = RegistrationViewController()
			let navigationController = getNavigationController(viewController: vc)
			let regAssembly = RegistrationAssembly(navigationController: navigationController)
			regAssembly.configure(with: vc)
			window.rootViewController = navigationController
		}
		window.makeKeyAndVisible()
		self.window = window
	}
}

func getNavigationController(viewController: UIViewController) -> UINavigationController {
	let navController = UINavigationController(rootViewController: viewController)
	navController.navigationBar.prefersLargeTitles = true
	
	let appearance = UINavigationBarAppearance()
	appearance.configureWithOpaqueBackground()
	appearance.backgroundColor = .background
		
	appearance.titleTextAttributes = [
		.foregroundColor: UIColor(resource: .textPrimary),
		.font: UIFont.systemFont(ofSize: 18, weight: .bold)
	]
	
	appearance.largeTitleTextAttributes = [
		.foregroundColor: UIColor(resource: .textPrimary),
		.font: UIFont.systemFont(ofSize: 34, weight: .bold)
	]
	
	navController.navigationBar.standardAppearance = appearance
	navController.navigationBar.scrollEdgeAppearance = appearance
	
	return navController
}


