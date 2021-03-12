//
//  DetailsViewController.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/11/21.
//

import LBTATools

class DetailsViewController: LBTAFormController {
  private let viewModel: DetailsControllerViewModel
  
  private let titleLabel = UILabel(
    font: UIFont.systemFont(ofSize: 30, weight: .bold),
    textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
    textAlignment: .center,
    numberOfLines: 0)
  
  private let sub1Label = UILabel(
    font: UIFont.systemFont(ofSize: 15, weight: .regular),
    textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
  
  private let sub2Label = UILabel(
    font: UIFont.systemFont(ofSize: 20, weight: .medium),
    textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
  
  private let sub3Label = UILabel(
    font: UIFont.systemFont(ofSize: 15, weight: .medium),
    textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
  
  private let sub4Label = UILabel(
    font: UIFont.systemFont(ofSize: 15, weight: .regular),
    textColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
  
  private let sub5Label = UILabel(
    font: UIFont.systemFont(ofSize: 15, weight: .medium),
    textColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
  
  private let sub6Label = UILabel(
    font: UIFont.systemFont(ofSize: 15, weight: .medium),
    textColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
  
  private let titleAndCategoryStack = UIStackView()
  private let descriptionStack = UIStackView()
  private let otherDetailsStack = UIStackView()
  private let mainStack = UIStackView()
  
  init(viewModel: DetailsControllerViewModel) {
    self.viewModel = viewModel
    super.init(alignment: .top)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup
private extension DetailsViewController {
  
  
  func setup() {
    
    let labels = [
      titleLabel, sub2Label, sub3Label, sub4Label, sub5Label, sub6Label
    ]
    labels.forEach { (label) in
      label.textAlignment = .left
      label.numberOfLines = 0
    }
    
    let stackViews = [
      titleAndCategoryStack, descriptionStack, otherDetailsStack
    ]
    
    stackViews.forEach { (stackView) in
      stackView.alignment = .fill
      stackView.distribution = .equalSpacing
    }
    
    view.backgroundColor = .white
    setupViewModel()
    
    titleAndCategoryStack.stack(
      titleLabel,sub1Label
    )
    descriptionStack.stack(
      sub2Label, sub3Label,
      spacing: 10
    )
    otherDetailsStack.stack(
      sub4Label, sub5Label, sub6Label,
      spacing: 10
    )
    mainStack.stack(
      titleAndCategoryStack, descriptionStack, otherDetailsStack,
      spacing: 30,
      alignment: .fill,
      distribution: .equalSpacing
    )
    scrollView.alwaysBounceVertical = true
    formContainerStackView.layoutMargins = .init(top: 50, left: 20, bottom: 50, right: 20)
    formContainerStackView.addArrangedSubview(mainStack)
  }
  
  func setupViewModel() {
    titleLabel.text = viewModel.title
    sub1Label.text = viewModel.sub1
    sub2Label.text = viewModel.sub2
    sub3Label.text = viewModel.sub3
    sub4Label.text = viewModel.sub4
    sub5Label.text = viewModel.sub5
    sub6Label.text = viewModel.sub6
  }
}
