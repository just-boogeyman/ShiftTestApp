//
//  ImageLoader.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

/// Протокол загрузчика изображений
protocol ImageLoading {
	func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}

/// Сервис загрузки изображений с кэшированием (Singleton)
final class ImageLoader {

	/// Общий экземпляр синглтона
	static let shared = ImageLoader()

	/// Кэш для хранения загруженных изображений
	private let cache = NSCache<NSURL, UIImage>()

	/// Приватный инициализатор для ограничения создания экземпляров
	private init() {}
}

extension ImageLoader: ImageLoading {
	
	/// Загрузчик изображений.
	///
	/// - Parameters:
	///   - urlString: Строка с URL, по которому необходимо загрузить изображение.
	///   - completion: Замыкание, которое будет вызвано по завершении загрузки. Возвращает `UIImage` при успехе или `nil` при ошибке.
	func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
		guard let url = URL(string: urlString) else {
			completion(nil)
			return
		}

		if let cachedImage = cache.object(forKey: url as NSURL) {
			completion(cachedImage)
			return
		}

		let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
			guard
				let data = data,
				let image = UIImage(data: data),
				error == nil
			else {
				DispatchQueue.main.async {
					completion(nil)
				}
				return
			}

			self?.cache.setObject(image, forKey: url as NSURL)

			DispatchQueue.main.async {
				completion(image)
			}
		}

		task.resume()
	}
}
