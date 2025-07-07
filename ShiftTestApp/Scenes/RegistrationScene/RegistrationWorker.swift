//
//  RegistrationWorker.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import Foundation

enum RegistrationValidationError: Error, LocalizedError {
	case emptyFirstName
	case invalidFirstName
	case emptyLastName
	case invalidLastName
	case underage
	case weakPassword
	case passwordsDoNotMatch

	var errorDescription: String? {
		switch self {
		case .emptyFirstName:
			return "Имя не может быть пустым"
		case .invalidFirstName:
			return "Имя должно содержать только буквы"
		case .emptyLastName:
			return "Фамилия не может быть пустой"
		case .invalidLastName:
			return "Фамилия должна содержать только буквы"
		case .underage:
			return "Пользователю должно быть не менее 13 лет"
		case .weakPassword:
			return "Пароль должен содержать минимум 6 символов, хотя бы одну букву и цифру"
		case .passwordsDoNotMatch:
			return "Пароли не совпадают"
		}
	}
}

protocol IRegistrationWorker {
	
	/// Проверка данных регистрации
	/// - Parameters:
	///  - name: Имя пользователя
	///  - surName: Фамилия пользователя
	///  - birthDate: Дата рождения пользователя
	///  - password: пароль пользователя
	///  - confirmPassword: Подтверждение пароля

	func validate(
		name: String,
		surName: String,
		birthDate: Date,
		password: String,
		confirmPassword: String
	) -> Result<Void, RegistrationValidationError>
}

// Данная обработка ошибок приведена только в учебных целях!
// Никогда на практике нельзя говорить в чем проблема при авторизации.
// Нельзя давать подсказку про верный пароль или верный логин, так как это упрощает взлом.
//enum LoginError: Error {
//	case wrongPassword
//	case wrongLogin
//	case errorAuth
//	case emptyFields
//}

class RegistrationWorker {

	// MARK: - Private properties

	private let validLogin = "Admin"
	private let validPassword = "pa$$32!"
	
	
	// MARK: - Private helpers

	private func isValidName(_ name: String) -> Bool {
		let regex = "^[A-Za-zА-Яа-я\\-]{2,30}$"
		return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: name)
	}

	private func isAtLeast13YearsOld(_ date: Date) -> Bool {
		let calendar = Calendar.current
		guard let age = calendar.dateComponents([.year], from: date, to: Date()).year else { return false }
		return age >= 13
	}

	private func isStrongPassword(_ password: String) -> Bool {
		let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
		return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
	}
}

// MARK: - IRegistrationWorker

extension RegistrationWorker: IRegistrationWorker {
	
	func validate(
			name: String,
			surName: String,
			birthDate: Date,
			password: String,
			confirmPassword: String
		) -> Result<Void, RegistrationValidationError> {

			// Имя
			if name.isEmpty {
				return .failure(.emptyFirstName)
			}
			if !isValidName(name) {
				return .failure(.invalidFirstName)
			}

			// Фамилия
			if surName.isEmpty {
				return .failure(.emptyLastName)
			}
			if !isValidName(surName) {
				return .failure(.invalidLastName)
			}

			if !isAtLeast13YearsOld(birthDate) {
				return .failure(.underage)
			}

			if !isStrongPassword(password) {
				return .failure(.weakPassword)
			}

			if password != confirmPassword {
				return .failure(.passwordsDoNotMatch)
			}

			return .success(())
		}
}
