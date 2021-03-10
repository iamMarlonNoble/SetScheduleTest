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
  let category: String
  let start: String
  let entities: [PredictEntity]
  
}

extension PredictHQEvent: Event {
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
