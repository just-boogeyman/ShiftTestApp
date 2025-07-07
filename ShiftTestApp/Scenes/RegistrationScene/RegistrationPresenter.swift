//
//  RegistrationPresenter.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import Foundation

protocol IRegistrationPresenter {
	func checkValid(
		name: String,
		surName: String,
		date: Date,
		password: String,
		confirmPassword: String
	)
}

final class RegistrationPresenter {
	private weak var view: IRegistrationViewController?
	private let router: IRegistrationRouter
	private let worker: IRegistrationWorker
	
	init(
		view: IRegistrationViewController,
		router: IRegistrationRouter,
		worker: IRegistrationWorker
	) {
		self.view = view
		self.router = router
		self.worker = worker
	}
}

extension RegistrationPresenter: IRegistrationPresenter {
	func checkValid(name: String, surName: String, date: Date, password: String, confirmPassword: String) {
		let result = worker.validate(
			name: name,
			surName: surName,
			birthDate: date,
			password: password,
			confirmPassword: confirmPassword
		)
		switch result {
		case .success:
			UserSessionManager.shared.saveUser(name: name)
			router.routeTo(target: RegistrationRouter.Target.nextVC)
		case .failure(let failure):
			router.routeTo(target: RegistrationRouter.Target.errorAlert(failure))
		}
	}
}
