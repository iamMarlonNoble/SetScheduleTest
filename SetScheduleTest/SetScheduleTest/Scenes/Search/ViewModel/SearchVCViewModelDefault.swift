//
//  SearchVCViewModelDefault.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import Foundation

class SearchVCViewModelDefault: SearchControllerViewModel {
  var isLoadingHandler: ((Bool) -> Void)?
  
  var eventCellViewModels: [EventCellViewModel] = []
  
  var didUpdateEvents: (() -> Void)?
}
