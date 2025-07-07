//
//  UserSessionManager.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import Foundation

/// Менеджер пользовательской сессии, отвечающий за сохранение и проверку статуса регистрации.
/// Использует `UserDefaults` для локального хранения данных.
final class UserSessionManager {
	/// Singleton-экземпляр для глобального доступа к пользовательской сессии.
	static let shared = UserSessionManager()

	/// Приватный инициализатор, чтобы запретить создание дополнительных экземпляров.
	private init() {}

	/// Проверяет, зарегистрирован ли пользователь.
	///
	/// - Returns: `true`, если имя пользователя сохранено в `UserDefaults`, иначе `false`.
	var isUserRegistered: Bool {
		UserDefaults.standard.string(forKey: "userName") != nil
	}

	/// Сохраняет имя пользователя в `UserDefaults`.
	///
	/// - Parameter name: Имя пользователя, которое нужно сохранить.
	func saveUser(name: String) {
		UserDefaults.standard.set(name, forKey: "userName")
	}

	/// Удаляет данные пользователя из `UserDefaults`, фактически "разлогинивая" его.
	func logout() {
		UserDefaults.standard.removeObject(forKey: "userName")
	}
}
