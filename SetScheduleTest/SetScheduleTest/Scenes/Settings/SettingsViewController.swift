//
//  SettingsViewController.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import LBTATools

class SettingsViewController: UIViewController {
  
  var didSaveSettings: (() -> Void)?
  
  /// Range field
  private let rangeLabel = UILabel(text: "Distance to search (mi):", font: .systemFont(ofSize: 14), textColor: .secondaryLabel)
  private let rangeTextField = UITextField()
  private let rangeStack = UIStackView()
  
  /// Location field
  private let locationLabel = UILabel(text: "Your current location:", font: .systemFont(ofSize: 14), textColor: .secondaryLabel)
  private let locationLabelValue = UILabel(font: .systemFont(ofSize: 17))
  private let locationStack = UIStackView()
  
  /// Host field
  private let hostLabel = UILabel(text: "Host API:", font: .systemFont(ofSize: 14), textColor: .secondaryLabel)
  private let hostSegmentedControl = UISegmentedControl(items: ["SeatGeek", "PredictHQ"])
  private let hostStack = UIStackView()
  
  private let mainStack = UIStackView()
  
  // TODO: - Add ViewModel
  
  let locationService: LocationService
  
  init(locationService: LocationService = LocationServiceDefault()) {
    self.locationService = locationService
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
    view.backgroundColor = UIColor.systemGroupedBackground
    
    setupDistanceUI()
    setupLocationUI()
    setupHostUI()
    setupRightBarButtonItem()
    setupInitialValues()
    setupLocationService()
  }
  
  func setupInitialValues() {
    let range = UserDefaults.standard.double(forKey: "range")
    rangeTextField.text = "\(range)"
    
    hostSegmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "host")
  }
  
  func setupLocationService() {
    locationService.didUpdateLocation = { [weak self] coordinates in
      self?.locationLabelValue.text = "Lat: \(coordinates.latitude), Lon: \(coordinates.longitude)"
    }
  }
  
  func setupRightBarButtonItem() {
    navigationItem.rightBarButtonItem = .init(
      title: "Save",
      style: .done,
      target: self,
      action: #selector(saveHandler)
    )
  }
  
  func setupDistanceUI() {
    rangeTextField.placeholder = "0000"
    rangeTextField.backgroundColor = .white
    rangeTextField.withHeight(30)
    rangeTextField.keyboardType = .decimalPad
    
    rangeStack.addArrangedSubview(rangeLabel)
    rangeStack.addArrangedSubview(rangeTextField)
    rangeStack.axis = .vertical
    rangeStack.spacing = 7
    
    mainStack.addArrangedSubview(rangeStack)
  }
  
  func setupLocationUI() {
    locationStack.stack(
      locationLabel,
      locationLabelValue,
      spacing: 5,
      alignment: .leading,
      distribution: .equalSpacing
    )
    
    mainStack.addArrangedSubview(locationStack)
    mainStack.axis = .vertical
    mainStack.spacing = 40
    
    view.addSubview(mainStack)
    
    let safeArea = view.safeAreaLayoutGuide
    mainStack.anchor(
      top: safeArea.topAnchor,
      leading: safeArea.leadingAnchor,
      bottom: nil,
      trailing: safeArea.trailingAnchor,
      padding: .init(top: 40, left: 15, bottom: 0, right: 15)
    )
  }
  
  func setupHostUI() {
    hostStack.stack(
      hostLabel, hostSegmentedControl,
      spacing: 5,
      alignment: .fill,
      distribution: .equalSpacing
    )
    
    mainStack.addArrangedSubview(hostStack)
  }
}

// MARK: - Handlers

private extension SettingsViewController {
  @objc
  func saveHandler() {
    if let range = rangeTextField.text, let doubleRange = Double(range) {
      UserDefaults.standard.setValue(doubleRange, forKey: "range")
    }
    
    UserDefaults.standard.setValue(hostSegmentedControl.selectedSegmentIndex, forKey: "host")
    
    didSaveSettings?()
    
    navigationController?.popViewController(animated: true)
  }
}
