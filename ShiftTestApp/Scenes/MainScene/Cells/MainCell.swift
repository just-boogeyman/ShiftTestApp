//
//  MainCell.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

final class MainCell: UITableViewCell {
	
	private lazy var customView = MainCustomViewCell()
	
	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with item: ProductModel) {
		customView.configure(with: item)
	}
}

private extension MainCell {
	func setup() {
		backgroundColor = .background
		addSubview(customView)
		layout()
	}
}

private extension MainCell {
	func layout() {
		customView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			customView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			customView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
		])
	}
}
