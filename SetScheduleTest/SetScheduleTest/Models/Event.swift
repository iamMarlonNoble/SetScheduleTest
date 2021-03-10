//
//  Event.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import Foundation

protocol Event: Decodable {
  var title: String { get }
  var category: String { get }
  var date: String? { get }
  var venue: Venue? { get }
  var url: URL? { get }
}

protocol Venue: Decodable {
  var name: String { get }
  var address: String { get }
}
