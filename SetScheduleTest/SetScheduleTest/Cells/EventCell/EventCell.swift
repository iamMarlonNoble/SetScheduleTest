//
//  EventCell.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import LBTATools

class EventCell: UITableViewCell {
  var viewModel: EventCellViewModel? {
    didSet {
      setupFromViewModel()
    }
  }
  
  private let titleLabel = UILabel(
    font: UIFont.systemFont(ofSize: 20, weight: .bold),
    textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
    numberOfLines: 0
  )
  
  private let subTitle1 = UILabel(
    font: UIFont.systemFont(ofSize: 17, weight: .medium),
    textColor: #colorLiteral(red: 0.3150921271, green: 0.3150921271, blue: 0.3150921271, alpha: 1),
    numberOfLines: 1
  )
  
  private let subtitle2 = UILabel(
    font: UIFont.systemFont(ofSize: 14, weight: .regular),
    textColor: #colorLiteral(red: 0.3485637626, green: 0.3485637626, blue: 0.3485637626, alpha: 1),
    numberOfLines: 0
  )
  
  private let subtitle3 = UILabel(
    font: UIFont.systemFont(ofSize: 12, weight: .regular),
    textColor: #colorLiteral(red: 0.5878193999, green: 0.5878193999, blue: 0.5878193999, alpha: 1),
    numberOfLines: 1
  )
  
  private let mainStack = UIStackView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup

private extension EventCell {
  func setup() {
    mainStack.stack(
      titleLabel, subTitle1, subtitle2, subtitle3,
      spacing: 8,
      alignment: .fill,
      distribution: .equalSpacing
    )
    
    contentView.addSubview(mainStack)
    
    mainStack.anchor(
      top: contentView.topAnchor,
      leading: contentView.leadingAnchor,
      bottom: contentView.bottomAnchor,
      trailing: contentView.trailingAnchor,
      padding: .init(top: 15, left: 15, bottom: 15, right: 10)
    )
  }
  
  func setupFromViewModel() {
    guard let viewModel = viewModel else { return }
    
    titleLabel.text = viewModel.title
    subTitle1.text = viewModel.sub1
    subtitle2.text = viewModel.sub2
    subtitle3.text = viewModel.sub3
  }
  
}
