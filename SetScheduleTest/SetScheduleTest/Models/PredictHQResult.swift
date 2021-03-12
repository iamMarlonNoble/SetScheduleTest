//
//  PredictHQResult.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/11/21.
//

import Foundation

struct PredictHQResult: Decodable {
  let results: [PredictHQEvent]
}

struct PredictHQEvent {
  let title: String
  let predictCategory: String
  let start: String
  let entities: [PredictEntity]
  let description: String?
  
  private enum CodingKeys: String, CodingKey {
    case title,
         predictCategory = "category",
         start,
         entities,
         description
  }
}

extension PredictHQEvent: Event {
  
  var category: String {
    predictCategory.capitalized
  }
  
  var date: String? {
    start.toDate()?.toString(.dateTime(.short))
  }
  
  var venue: Venue? {
    entities.first
  }
  
  var url: URL? {
    nil
  }
}

struct PredictEntity: Venue {
  
  let name: String
  let formattedAddress: String
  
  var address: String {
    formattedAddress
  }
  
  private enum CodingKeys: String, CodingKey {
    case name,
         formattedAddress = "formatted_address"
  }
}
