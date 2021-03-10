//
//  PredictHQEventService.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import CoreLocation

class PredictHQEventService: EventService {
  func searchEvent(
    coordinate: CLLocationCoordinate2D,
    keyword: String?,
    range: Double,
    completion: @escaping ([Event], Error?) -> Void
  ) {
    let intRange = Int(range)
    var queryItems = [
      URLQueryItem(name: "within", value: "\(intRange)mi@\(coordinate.latitude),\(coordinate.longitude)"),
    ]
    if let keyword = keyword {
      queryItems.append(.init(name: "q", value: keyword))
    }
    var urlComponents = URLComponents(string: "https://api.predicthq.com/v1/events/")
    urlComponents?.queryItems = queryItems
    guard let url = urlComponents?.url else { return }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      DispatchQueue.main.async {
        guard let data = data else { return }
        do {
          let eventResult = try JSONDecoder().decode(PredictHQResult.self, from: data)
          completion(eventResult.results, nil)
        } catch let DecodingError.dataCorrupted(context) {
          print(context)
        } catch let DecodingError.keyNotFound(key, context) {
          print("Key '\(key)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
          print("Value '\(value)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
          print("Type '\(type)' mismatch:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch {
          print("error: ", error)
        }
      }
    }.resume()
  }
  
  private let token = "enohqHZQowUNxdHeJppu88dCfELPX3306fesFoDp"
}
