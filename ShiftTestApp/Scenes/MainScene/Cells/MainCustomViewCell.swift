//
//  MainCustomViewCell.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

final class MainCustomViewCell: UIView {
	
	private let titleLabel = UILabel()
	private let priceLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let categoryLabel = UILabel()
	private let rateLabel = UILabel()
	private let countLabel = UILabel()
	private let imageView = UIImageView()
	
	private let priceCategoryStack = UIStackView()
	private let ratingStack = UIStackView()
	private let mainStack = UIStackView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Конфигурация

	func configure(with model: ProductModel) {
		titleLabel.text = model.title
		priceLabel.text = "$\(model.price)"
		descriptionLabel.text = model.description
		categoryLabel.text = model.category
		rateLabel.text = "⭐️ \(model.rate)"
		countLabel.text = "(\(model.count))"

		// Загрузка картинки
		ImageLoader.shared.loadImage(from: model.imageUrl) { [weak self] image in
			guard let image else { return }
			self?.imageView.image = image
		}
	}
}

// MARK: - Private

private extension MainCustomViewCell {
	func setupUI() {
		backgroundColor = .white
		layer.cornerRadius = 12
		layer.borderWidth = 1
		layer.borderColor = UIColor.lightGray.cgColor
		clipsToBounds = true

		setupImage()
		setupLabel()
		setupStack()

		mainStack.addArrangedSubview(imageView)
		mainStack.addArrangedSubview(titleLabel)
		mainStack.addArrangedSubview(priceCategoryStack)
		mainStack.addArrangedSubview(descriptionLabel)
		mainStack.addArrangedSubview(ratingStack)

		addSubview(mainStack)
	}
	
	func setupImage() {
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
	}
	
	func setupLabel() {
		titleLabel.font = .boldSystemFont(ofSize: 18)
		titleLabel.numberOfLines = 2
		
		priceLabel.font = .systemFont(ofSize: 16)
		priceLabel.textColor = .systemGreen

		categoryLabel.font = .systemFont(ofSize: 14)
		categoryLabel.textColor = .secondaryLabel

		descriptionLabel.font = .systemFont(ofSize: 14)
		descriptionLabel.numberOfLines = 0
		descriptionLabel.textColor = .darkGray

		rateLabel.font = .systemFont(ofSize: 14)
		rateLabel.textColor = .systemOrange

		countLabel.font = .systemFont(ofSize: 14)
		countLabel.textColor = .gray
	}
	
	func setupStack() {
		priceCategoryStack.axis = .horizontal
		priceCategoryStack.distribution = .equalSpacing
		priceCategoryStack.addArrangedSubview(priceLabel)
		priceCategoryStack.addArrangedSubview(categoryLabel)

		ratingStack.axis = .horizontal
		ratingStack.spacing = 4
		ratingStack.addArrangedSubview(rateLabel)
		ratingStack.addArrangedSubview(countLabel)

		mainStack.axis = .vertical
		mainStack.spacing = 8
		mainStack.translatesAutoresizingMaskIntoConstraints = false
	}
}

// MARK: Layout

private extension MainCustomViewCell {
	func setupConstraints() {
		NSLayoutConstraint.activate([
			mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
			mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
			mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
			mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
		])
	}
}
