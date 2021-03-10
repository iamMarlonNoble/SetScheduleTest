//
//  SeatGeekEventService.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import CoreLocation

class SeatGeekEventService: EventService {
  func searchEvent(
    coordinate: CLLocationCoordinate2D,
    keyword: String?,
    range: Double,
    completion: @escaping ([Event], Error?) -> Void
  ) {
    var queryItems = [
      URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
      URLQueryItem(name: "lon", value: "\(coordinate.longitude)"),
      URLQueryItem(name: "range", value: "\(range)mi"),
      URLQueryItem(name: "per_page", value: "\(100)"),
    ]
    if let keyword = keyword {
      queryItems.append(.init(name: "q", value: keyword))
    }
    var urlComponents = URLComponents(string: "https://api.seatgeek.com/2/events")
    urlComponents?.queryItems = queryItems
    guard let url = urlComponents?.url,
          let authHeader = createAuthHeader()
    else { return }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Basic \(authHeader)", forHTTPHeaderField: "Authorization")
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      DispatchQueue.main.async {
        guard let data = data else { return }
        
        do {
          let eventResult = try JSONDecoder().decode(SeatGeekResult.self, from: data)
          completion(eventResult.events, nil)
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
  
  func createAuthHeader() -> String? {
    let userName = "MjE1ODM0MjF8MTYxNTI5OTU4Ni4yMDY4ODA4"
    let password = "ad769758d8da4de8fb7737a18ddda28ca89484017a039903b6938fa1e63aacbd"
    let loginTest = "\(userName):\(password)"
    guard let loginData = loginTest.data(using: .utf8) else {
      return nil
    }
    let base64LoginString = loginData.base64EncodedString()
    return base64LoginString
  }
}
