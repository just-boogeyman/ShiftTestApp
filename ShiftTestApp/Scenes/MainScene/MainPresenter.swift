//
//  MainPresenter.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import Foundation

struct ProductModel {
	let title: String
	let price: Double
	let description: String
	let category: String
	let rate: Double
	let count: Int
	let imageUrl: String
}

protocol IMainPresenter {
	func render()
}

final class MainPresenter {
	
	private weak var view: IMainViewController!
	private let router: IMainRouter!
	private let network: INetworkManager!
	
	private var items: [Product] = []
	
	init(view: IMainViewController, router: IMainRouter, network: INetworkManager) {
		self.view = view
		self.router = router
		self.network = network
		featchItems()
	}
	
	private func featchItems() {
		network.fetch(
			[Product].self,
			url: "https://fakestoreapi.com/products"
		) { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case .success(let items):
					self?.items = items
					self?.render()
				case .failure(let failure):
					print(failure.localizedDescription)
				}
			}
		}
	}
	
	private func getProducts() -> [ProductModel] {
		items.map {
			ProductModel(
				title: $0.title,
				price: $0.price,
				description: $0.description,
				category: $0.category,
				rate: $0.rating.rate,
				count: $0.rating.count,
				imageUrl: $0.image
			)
		}
	}

}

extension MainPresenter: IMainPresenter {
	func render() {
		let items = getProducts()
		view.showProducts(items)
	}
}
