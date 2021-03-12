//
//  SeatGeekResult.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import SwiftDate

struct SeatGeekResult: Decodable {
  let events: [SeatGeekEvent]
}

struct SeatGeekEvent {
  let title: String
  let type: String
  let sgDescription: String?
  let sgVenue: SeatGeekVenue
  let sgDate: String
  let sgUrl: String
  
  private enum CodingKeys: String, CodingKey {
    case
      title,
      type,
      sgDescription = "description",
      sgVenue = "venue",
      sgDate = "datetime_utc",
      sgUrl = "url"
  }
}

extension SeatGeekEvent: Event {
  var category: String {
    type.replacingOccurrences(of: "_", with: " ").capitalized
  }
  
  var description: String? {
    sgDescription
  }
  
  var date: String? {
    sgDate.toDate()?.toString(.dateTime(.short))
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
