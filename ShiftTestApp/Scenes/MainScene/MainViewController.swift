//
//  MainViewController.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

protocol IMainViewController: AnyObject {
	func showProducts(_ products: [ProductModel])
}

final class MainViewController: UIViewController {

	var presenter: IMainPresenter?
	private var products: [ProductModel] = []

	private let tableView = UITableView()
	private let greetingButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Приветствие", for: .normal)
		button.backgroundColor = .systemBlue
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 12
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
	
	private func setup() {
		view.backgroundColor = .systemBackground
		title = "Товары"
		setupTableView()
		setupLayout()
		setupActions()
		presenter?.render()
	}

	private func setupTableView() {
		tableView.backgroundColor = .background
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 150
		view.addSubview(tableView)
		view.addSubview(greetingButton)
	}

	private func setupLayout() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: greetingButton.topAnchor, constant: -12),

			greetingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			greetingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			greetingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
			greetingButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}

	private func setupActions() {
		greetingButton.addTarget(
			self,
			action: #selector(greetingTapped),
			for: .touchUpInside
		)
	}

	@objc private func greetingTapped() {
		if let name = UserSessionManager.shared.userName {
			let alert = UIAlertController(
				title: "Привет",
				message: "Добро пожаловать, \(name)!",
				preferredStyle: .alert
			)
			alert.addAction(
				UIAlertAction(
					title: "OK",
					style: .default
				)
			)
			present(alert, animated: true)
		}
	}
}

// MARK: - View Input

extension MainViewController: IMainViewController {
	func showProducts(_ products: [ProductModel]) {
		self.products = products
		self.tableView.reloadData()
	}
}

// MARK: - UITableView DataSource / Delegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		products.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: "MainCell",
			for: indexPath
		) as? MainCell else {
			return UITableViewCell()
		}
		let product = products[indexPath.row]
		cell.configure(with: product)
		return cell
	}
}

