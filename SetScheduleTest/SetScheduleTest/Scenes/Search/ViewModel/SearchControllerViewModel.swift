//
//  SearchControllerViewModel.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import Foundation

protocol SearchControllerViewModel: AnyObject {
  var isLoadingHandler: ((Bool) -> Void)? { get set }
  var eventCellViewModels: [EventCellViewModel] { get }
  var didUpdateEvents: (() -> Void)? { get set }
  func searchEvent(with keyword: String, range: Double)
}

class SearchControllerViewModelMock: SearchControllerViewModel {
  var isLoadingHandler: ((Bool) -> Void)?
  
  var eventCellViewModels: [EventCellViewModel] = [
    EventCellViewModelMock(tag: 1),
    EventCellViewModelMock(tag: 2),
    EventCellViewModelMock(tag: 3)
  ]
  
  var didUpdateEvents: (() -> Void)?
  
  func searchEvent(with keyword: String, range: Double) {
    
  }
}
