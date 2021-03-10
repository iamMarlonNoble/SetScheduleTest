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
}
