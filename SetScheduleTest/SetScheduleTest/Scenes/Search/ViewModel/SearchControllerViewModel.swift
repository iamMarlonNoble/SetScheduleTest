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
  var detailsVCViewModels: [DetailsControllerViewModel] { get }
  var didUpdateEvents: (() -> Void)? { get set }
  var title: String { get }
  func searchEvent(with keyword: String)
}

class SearchControllerViewModelMock: SearchControllerViewModel {
  var title: String = ""
  
  var isLoadingHandler: ((Bool) -> Void)?
  
  var detailsVCViewModels: [DetailsControllerViewModel] = []
  
  var eventCellViewModels: [EventCellViewModel] = [
    EventCellViewModelMock(tag: 1),
    EventCellViewModelMock(tag: 2),
    EventCellViewModelMock(tag: 3)
  ]
  
  var didUpdateEvents: (() -> Void)?
  
  func searchEvent(with keyword: String) {
    
  }
}
