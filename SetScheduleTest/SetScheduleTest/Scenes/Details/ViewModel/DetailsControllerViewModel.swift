//
//  DetailsControllerViewModel.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/11/21.
//

import SwiftDate

protocol DetailsControllerViewModel {
  var title: String { get }
  var sub1: String? { get }
  var sub2: String? { get }
  var sub3: String? { get }
  var sub4: String? { get }
  var sub5: String? { get }
  var sub6: String? { get }
}

class DetailsVCViewModel {
  let event: Event
  init(event: Event) {
    self.event = event
  }
}

extension DetailsVCViewModel: DetailsControllerViewModel {
  var title: String {
    event.title
  }
  
  var sub1: String? {
    "Category: \(event.category)"
  }
  
  var sub2: String? {
    "Description"
  }
  
  var sub3: String? {
    event.description
  }
  
  var sub4: String? {
    "Venue: \(event.venue?.name ?? "")"
  }
  
  var sub5: String? {
    "Adress: \(event.venue?.address ?? "")"
  }
  
  var sub6: String? {
    "Date: \(event.date ?? "")"
  }
  
}
