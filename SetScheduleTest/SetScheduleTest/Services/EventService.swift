//
//  EventService.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import CoreLocation

protocol EventService {
  func searchEvent(
    coordinate: CLLocationCoordinate2D,
    keyword: String?,
    range: Double,
    completion: @escaping ([Event], Error?) -> Void
  )
}
