//
//  EventCellViewModel.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import Foundation

protocol EventCellViewModel: AnyObject {
  var title: String { get }
  var sub1: String? { get }
  var sub2: String? { get }
  var sub3: String? { get }
  var url: URL? { get }
}

class EventCellViewModelMock: EventCellViewModel {
  var url: URL?
  
  var title: String
  
  var sub1: String?
  
  var sub2: String?
  
  var sub3: String?
  
  init(tag: Int) {
    title = "Title \(tag)"
    sub1 = "Sub1: \(tag)"
    sub2 = "Sub2: \(tag)"
    sub3 = "Sub3: \(tag)"
  }
  
}

class EventCellViewModelDefault: EventCellViewModel {
  var url: URL?
  
  var title: String = ""
  
  var sub1: String?
  
  var sub2: String?
  
  var sub3: String?
}
