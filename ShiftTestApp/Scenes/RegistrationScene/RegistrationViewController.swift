//
//  ViewController.swift
//  ShiftTestApp
//
//  Created by Ярослав Кочкин on 07.07.2025.
//

import UIKit

protocol IRegistrationViewController: AnyObject {
	
}

final class RegistrationViewController: UIViewController {
	
	var presenter: IRegistrationPresenter?
	
	// MARK: - Private properties

	private lazy var textFieldName: UITextField = makeTextField(text: "Имя")
	private lazy var textFieldSurname: UITextField = makeTextField(text: "Фамилия")
	private lazy var textFieldPass: UITextField = makeTextField(text: "Введите пароль")
	private lazy var textFieldConfirmPass: UITextField = makeTextField(text: "Подтвердите пароль")
	private lazy var buttonLogin: UIButton = makeButtonLogin()
	private lazy var datePicker: UIDatePicker = makePicker()
	
	private var constraints = [NSLayoutConstraint]()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		layout()
		addTextFieldTargets()
		updateButtonState()
	}
}

// MARK: - Private

private extension RegistrationViewController {
	
	func checkData() -> Bool {
		guard
			let name = textFieldName.text, !name.isEmpty,
			let surname = textFieldSurname.text, !surname.isEmpty,
			let pass = textFieldPass.text, !pass.isEmpty,
			let confirm = textFieldConfirmPass.text, !confirm.isEmpty
		else { return false }

		return true
	}
	
	func updateButtonState() {
		let allFieldsFilled = checkData()
		buttonLogin.isEnabled = allFieldsFilled
		buttonLogin.alpha = allFieldsFilled ? 1.0 : 0.5
	}
	
	func addTextFieldTargets() {
		let fields = [textFieldName, textFieldSurname, textFieldPass, textFieldConfirmPass]
		fields.forEach { $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged) }
	}
	
	@objc
	func textFieldDidChange() {
		updateButtonState()
	}

	@objc
	func registration() {
		guard let name = textFieldName.text else { return }
		guard let surname = textFieldSurname.text else { return }
		let date = datePicker.date
		guard let password = textFieldPass.text else { return }
		guard let confirmPassword = textFieldConfirmPass.text else { return }
		presenter?.checkValid(
			name: name,
			surName: surname,
			date: date,
			password: password,
			confirmPassword: confirmPassword
		)
	}
}

// MARK: - Setup UI

private extension RegistrationViewController {

	func makeTextField(text: String = "") -> UITextField {
		let textField = UITextField()

		textField.backgroundColor = .white
		textField.placeholder = text
		textField.textContentType = .none
		textField.textColor = .black
		textField.layer.borderWidth = Sizes.borderWidth
		textField.layer.cornerRadius = Sizes.cornerRadius
		textField.layer.borderColor = UIColor.lightGray.cgColor
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Sizes.Padding.half, height: textField.frame.height))
		textField.leftViewMode = .always
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.delegate = self
		textField.returnKeyType = .done
		textField.autocorrectionType = .no
		textField.spellCheckingType = .no
		textField.autocapitalizationType = .none

		return textField
	}

	func makeButtonLogin() -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.baseBackgroundColor = .red
		button.configuration?.title = "Регистрация"
		button.isEnabled = false
		button.alpha = 0.5
		button.addTarget(self, action: #selector(registration), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}
	
	func makePicker() -> UIDatePicker {
		let picker = UIDatePicker()
		
		picker.datePickerMode = .date
		picker.maximumDate = Date()
		picker.preferredDatePickerStyle = .wheels
		picker.translatesAutoresizingMaskIntoConstraints = false

		return picker
	}

	func setupUI() {
		view.backgroundColor = .background
		title = "Регистрация"
		navigationController?.navigationBar.prefersLargeTitles = true
		textFieldPass.placeholder = "Введите пароль"
		textFieldPass.isSecureTextEntry = true
		textFieldPass.passwordRules = nil
		textFieldConfirmPass.isSecureTextEntry = true
		textFieldConfirmPass.passwordRules = nil
		[
			textFieldName,
			textFieldSurname,
			textFieldPass,
			textFieldConfirmPass,
			buttonLogin,
			datePicker
		].forEach {
			view.addSubview($0)
		}
	}
}

// MARK: - Layout UI

private extension RegistrationViewController {

	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			textFieldName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textFieldName.topAnchor.constraint(equalTo: view.topAnchor, constant: thirdOfTheScreen),
			textFieldName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
			textFieldName.heightAnchor.constraint(equalToConstant: Sizes.L.height),
			
			textFieldSurname.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textFieldSurname.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: Sizes.Padding.normal),
			textFieldSurname.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
			textFieldSurname.heightAnchor.constraint(equalToConstant: Sizes.L.height),
			
			datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			datePicker.topAnchor.constraint(equalTo: textFieldSurname.bottomAnchor, constant: Sizes.Padding.normal),
			datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
			datePicker.heightAnchor.constraint(equalToConstant: 120),

			textFieldPass.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textFieldPass.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: Sizes.Padding.normal),
			textFieldPass.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
			textFieldPass.heightAnchor.constraint(equalToConstant: Sizes.L.height),
			
			textFieldConfirmPass.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textFieldConfirmPass.topAnchor.constraint(equalTo: textFieldPass.bottomAnchor, constant: Sizes.Padding.normal),
			textFieldConfirmPass.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.L.widthMultiplier),
			textFieldConfirmPass.heightAnchor.constraint(equalToConstant: Sizes.L.height),

			buttonLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			buttonLogin.topAnchor.constraint(equalTo: textFieldConfirmPass.bottomAnchor, constant: Sizes.Padding.double),
			buttonLogin.widthAnchor.constraint(equalToConstant: Sizes.L.width),
			buttonLogin.heightAnchor.constraint(equalToConstant: Sizes.L.height)
		]

		NSLayoutConstraint.activate(newConstraints)

		constraints = newConstraints
	}

	var thirdOfTheScreen: Double {
		return view.bounds.size.height / 5.0
	}
}

extension RegistrationViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}

extension RegistrationViewController: IRegistrationViewController {
	
}


