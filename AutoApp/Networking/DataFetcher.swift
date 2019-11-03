//
//  DataFetcher.swift
//  CoxAutoApp
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import Foundation
import Alamofire

struct DataFetcher {
    private let dataSetId = "Z6H_0sLc1gg"
    private let headers: HTTPHeaders = ["Accept": "application/json"]
    func fetchVehicleIds(completion: @escaping ([Int]?) -> ()) {
        guard let url = URL(string: "http://api.coxauto-interview.com/api/\(dataSetId)/vehicles") else {
            completion(nil)
            return
        }
        
        Alamofire.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("request was not successful")
                    completion(nil)
                    return
                }
                print("repsonse:", response)
                guard let value = response.result.value as? [String: Any],
                    let vehicleIds = value["vehicleIds"] as? [Int] else {
                        print("Data not properly formatted")
                        completion(nil)
                        return
                }
                completion(vehicleIds)
        }
    }
    
    func fetchVehicles(with id: Int, completion: @escaping (Vehicle?,Int?) -> ()) {
        let vehicleId = String(id)
        guard let url = URL(string: "http://api.coxauto-interview.com/api/\(dataSetId)/vehicles/\(vehicleId)") else {
            completion(nil,nil)
            return
        }
        Alamofire.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("request was not successful")
                    completion(nil,nil)
                    return
                }
                print("repsonse:", response)
                guard let value = response.result.value as? [String: Any] , let year = value["year"] as? Int, let make = value["make"] as? String, let model = value["model"] as? String, let vehicleId = value["vehicleId"] as? Int, let dealerId = value["dealerId"] as? Int else {
                        print("Data not properly formatted")
                        completion(nil,nil)
                        return
                }
                let vehicle = Vehicle(year: year, make: make, model: model, vehicleId: vehicleId, dealerId: dealerId)
                
                completion(vehicle,dealerId)
        }
    }
    
    func fetchDealership(with id: Int, completion: @escaping (Dealership?) -> ()) {
        let dealerId = String(id)
        guard let url = URL(string: "http://api.coxauto-interview.com/api/\(dataSetId)/dealers/\(dealerId)") else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("request was not successful")
                    completion(nil)
                    return
                }
                print("repsonse:", response)
                guard let value = response.result.value as? [String: Any], let name = value["name"] as? String, let id = value["dealerId"] as? Int else {
                        print("Data not properly formatted")
                        completion(nil)
                        return
                }
                let dealership = Dealership(name: name, id: id)
                completion(dealership)
        }
    }
}
