//
//  NetworkManager.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import Foundation

/// Перечисление возможных ошибок сети.
enum NetworkError: Error {
	/// Невалидный URL.
	case invalidURL
	/// Нет полученных данных от сервера.
	case noData
	/// Ошибка при декодировании данных.
	case decodingError
}

/// Протокол сетевого менеджера, определяющий метод для выполнения сетевых запросов.
protocol INetworkManager {
	
	/// Выполняет сетевой запрос и декодирует полученные данные в заданный тип.
	///
	/// - Parameters:
	///   - type: Тип данных, который необходимо получить. Должен соответствовать `Decodable`.
	///   - url: Строка с URL-адресом запроса.
	///   - completion: Замыкание, вызываемое после завершения запроса.
	///                 Возвращает `Result` с успешно декодированным объектом или ошибкой `NetworkError`.
	func fetch<T: Decodable>(
		_ type: T.Type,
		url: String,
		completion: @escaping (Result<T, NetworkError>) -> Void
	)
}

/// Реализация `IMainNetworkManager`, использующая `URLSession` для сетевых запросов.
final class NetworkManager: INetworkManager {

	/// Выполняет HTTP-запрос по переданному URL и возвращает результат в виде указанного `Decodable`-типа.
	///
	/// - Parameters:
	///   - type: Тип модели, в который нужно декодировать JSON.
	///   - url: Строка с URL-адресом, по которому будет выполнен запрос.
	///   - completion: Замыкание, вызываемое при завершении запроса. Возвращает `Result` с объектом типа `T` или `NetworkError`.
	func fetch<T>(
		_ type: T.Type,
		url: String,
		completion: @escaping (Result<T, NetworkError>) -> Void
	) where T: Decodable {
		guard let url = URL(string: url) else {
			completion(.failure(.invalidURL))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data = data else {
				completion(.failure(.noData))
				return
			}
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let type = try decoder.decode(T.self, from: data)
				
				DispatchQueue.main.async {
					completion(.success(type))
				}
			} catch {
				completion(.failure(.decodingError))
			}
		}.resume()
	}
}
