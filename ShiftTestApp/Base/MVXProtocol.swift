//
//  MVXProtocol.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

protocol BaseAssembly {
	func configure(with viewController: UIViewController)
}

protocol BaseRouting {
	func routeTo(target: Any)
	init(navigationController: UINavigationController)
}

