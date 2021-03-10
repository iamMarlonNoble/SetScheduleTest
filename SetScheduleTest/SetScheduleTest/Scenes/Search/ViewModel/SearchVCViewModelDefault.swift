//
//  SearchVCViewModelDefault.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import CoreLocation

class SearchVCViewModelDefault: SearchControllerViewModel {
  var isLoadingHandler: ((Bool) -> Void)?
  
  var eventCellViewModels: [EventCellViewModel] = []
  
  var didUpdateEvents: (() -> Void)?
  
  private let eventService: EventService
  
  private var timer: Timer?
  
  private var keyword: String?
  
  private var range: Double {
    UserDefaults.standard.double(forKey: "range")
  }
  
  private let locationService: LocationService
  
  private var coordinates: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
  
  init(
    eventService: EventService = SeatGeekEventService(),
    locationService: LocationService = LocationServiceDefault()
  ) {
    self.eventService = eventService
    self.locationService = locationService
    
    locationService.didUpdateLocation = { [weak self] coordinates in
      self?.coordinates = coordinates
    }
    
    searchEvent(with: "")
  }
  
  func searchEvent(with keyword: String) {
    timer?.invalidate()
    
    self.keyword = keyword
    
    timer = Timer.scheduledTimer(
      timeInterval: 1,
      target: self,
      selector: #selector(fireRequest),
      userInfo: nil,
      repeats: false
    )
  }
}

// MARK: - Private Methods

private extension SearchVCViewModelDefault {
  @objc
  private func fireRequest() {
    isLoadingHandler?(true)
    eventService.searchEvent(
      coordinate: coordinates,
      keyword: keyword,
      range: range) { [weak self] (events, error) in
      self?.isLoadingHandler?(false)
      self?.foundEventsHandler(events: events)
    }
  }
  
  private func foundEventsHandler(events: [Event]) {
    eventCellViewModels = events.map { (event) -> EventCellViewModel in
      let vm = EventCellViewModelDefault()
      vm.title = event.title
      vm.sub1 = "Category: \(event.category)"
      
      if let venue = event.venue {
        vm.sub2 = "Venue: \(venue.name) - \(venue.address)"
      } else {
        vm.sub2 = "Venue: (Not Provided)"
      }
      
      vm.sub3 = "Date: \(event.date ?? "")"
      
      return vm
    }
    
    didUpdateEvents?()
  }
}
