//
//  SettingsViewController.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import LBTATools

class SettingsViewController: UIViewController {
  
  var didSaveSettings: (() -> Void)?
  
  private let rangeLabel = UILabel(text: "Distance to search (mi):")
  private let rangeTextField = UITextField()
  private let rangeStack = UIStackView()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup

private extension SettingsViewController {
  func setup() {
    title = "Settings"
    
    setupUI()
    setupRightBarButtonItem()
  }
  
  func setupRightBarButtonItem() {
    navigationItem.rightBarButtonItem = .init(
      title: "Save",
      style: .done,
      target: self,
      action: #selector(saveHandler)
    )
  }
  
  func setupUI() {
    view.backgroundColor = UIColor.systemGroupedBackground
    
    rangeTextField.placeholder = "0000"
    rangeTextField.backgroundColor = .white
    rangeTextField.withHeight(30)
    rangeTextField.keyboardType = .decimalPad
    
    rangeStack.addArrangedSubview(rangeLabel)
    rangeStack.addArrangedSubview(rangeTextField)
    rangeStack.axis = .vertical
    rangeStack.spacing = 7
    
    view.addSubview(rangeStack)
    
    let safeArea = view.safeAreaLayoutGuide
    rangeStack.anchor(
      top: safeArea.topAnchor,
      leading: safeArea.leadingAnchor,
      bottom: nil,
      trailing: safeArea.trailingAnchor,
      padding: .init(top: 20, left: 15, bottom: 0, right: 15)
    )
  }
}

// MARK: - Handlers

private extension SettingsViewController {
  @objc
  func saveHandler() {
    if let range = rangeTextField.text, let doubleRange = Double(range) {
      UserDefaults.standard.setValue(doubleRange, forKey: "range")
    }
    
    didSaveSettings?()
    
    navigationController?.popViewController(animated: true)
  }
}
