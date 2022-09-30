//
//  Networking.swift
//  TestMap
//
//  Created by admin on 30.09.2022.
//

import Foundation

struct Coordinate {
    var latitude: Double
    var longitude: Double
}

class Networking {
    static let shared = Networking()
    
    func getGasStation(coordinate: Coordinate, complition: @escaping (ChargerModel) -> Void) {
        
        let (ne, sw) = calculateLocations(coordinateCenter: coordinate, radiusInMeters: 10)
        
        let url = "https://airelectric.de/api/getstations.php?&ne_lat=\(ne.latitude)&ne_lng=\(ne.longitude)&sw_lat=\(sw.latitude)&sw_lng=\(sw.longitude)&min_power=100&freecharging=false&freeparking=false&open_twentyfourseven=false&exclude_faults=false&plugs=Typ1%2CTyp2%2CTyp3%2CCCS%2CCHAdeMO%2CSchuko%2CTesla+Supercharger%2CTesla+Supercharger+CCS%2CCEE+Blau%2CCEE+Rot%2CCEE%2B&barrierfree=false&startkey=0"
        
        loadJson(fromURLString: url) { (result) in
            switch result {
            case .success(let data):
                print("success")
                guard
                    let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue),
                    let chargeModel = try? JSONDecoder().decode(ChargerModel.self, from: data)
                else { return }
                complition(chargeModel)
            case .failure(let error):
                print(error)
            }
        }

    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    
    private func calculateLocations(coordinateCenter: Coordinate, radiusInMeters: Double) -> (Coordinate, Coordinate) {
        let distanceFromCenterToCorner = radiusInMeters * sqrt(2.0)
        let distansLat = radiusInMeters / 111.04
        
        
        
        let southwestCorner = SphericalUtil.computeOffset(from: coordinateCenter, distance: distanceFromCenterToCorner, heading: 225.0)
        let northeastCorner = SphericalUtil.computeOffset(from: coordinateCenter, distance: distanceFromCenterToCorner, heading: 45.0)
        return (Coordinate(latitude: coordinateCenter.latitude + distansLat, longitude: coordinateCenter.longitude + distansLat), Coordinate(latitude: coordinateCenter.latitude - distansLat, longitude: coordinateCenter.longitude - distansLat))
    }
}
