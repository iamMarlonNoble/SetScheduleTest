//
//  SeatGeekResult.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import Foundation

struct SeatGeekResult: Decodable {
  let events: [SeatGeekEvent]
}

struct SeatGeekEvent {
  let title: String
  let type: String
  let sgVenue: SeatGeekVenue
  let sgDate: String
  let sgUrl: String
  
  private enum CodingKeys: String, CodingKey {
    case
      title,
      type,
      sgVenue = "venue",
      sgDate = "datetime_utc",
      sgUrl = "url"
  }
}

extension SeatGeekEvent: Event {
  var category: String {
    type
  }
  
  var date: String? {
    sgDate
  }
  
  var venue: Venue? {
    sgVenue
  }
  
  var url: URL? {
    URL(string: sgUrl)
  }
}

struct SeatGeekVenue: Venue {
  var name: String
  var sgAddress: String?
  
  var address: String {
    sgAddress ?? ""
  }
  
  private enum CodingKeys: String, CodingKey {
    case
      name,
      sgAddress = "address"
  }
}
