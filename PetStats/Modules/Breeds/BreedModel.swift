//
//  Model.swift
//  PetStats
//
//  Created by Fabio Lindemberg on 23/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

class BaseModel {
    
    let apiKey = "0ae36cdd-e38c-453b-a749-908645d07e87"
    let baseUrl = "https://api.thedogapi.com/v1/%@?api_key=%@"
    
    func request(endPoint: String, parameters: [String:Any]?, completionHandler: @escaping (_ data: Data?,_ error: Error?)->Void ) {
        
        let url = URL(string: String(format: baseUrl, endPoint, apiKey))!
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            let code = (response as! HTTPURLResponse).statusCode

            guard code == 200 else {
                completionHandler(nil, APIError.exception(message: "Status code: \(code)with message: \(HTTPURLResponse.localizedString(forStatusCode: code))"))
                return
            }
            
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(data, error)
            
        }).resume()
    }
}

class BreedModel: BaseModel {
    
    
    func getBreeds(completionHandler: @escaping (_ breeds: [Breed],_ error: Error?)->Void) {
        let endPoint = "breeds"
        request(endPoint: endPoint, parameters: nil) { data, error in
            
            guard error == nil else {
                completionHandler([], error)
                return
            }
            
            do {
                let breeds = try JSONDecoder().decode([Breed].self, from: data!)
                completionHandler(breeds, nil)
            } catch {
                completionHandler([], error)
            }
        }
    }
    
    func getImageInfo(by breedId: Int, completionHandler: @escaping (_ imageInfo: ImageInfo?,_ error: Error?) -> Void) {
        
        let endPoint = "images/search"
        let parameter = [
                            "breed_id": breedId,
                            "category_ids": 1
            ] as [String : Any]
        
        request(endPoint: endPoint, parameters: parameter) { data, error in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            do {
                let imagesInfo = try JSONDecoder().decode([ImageInfo].self, from: data!)
                completionHandler(imagesInfo.first, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
    func getImage(by imageId: Int, completionHandler: @escaping (_ imageInfo: ImageInfo?,_ error: Error?) -> Void) {
        
        let endPoint = "images/\(imageId)"
        
        request(endPoint: endPoint, parameters: nil) { data, error in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            do {
                let imagesInfo = try JSONDecoder().decode([ImageInfo].self, from: data!)
                completionHandler(imagesInfo.first, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }

}

enum APIError: Error {
    case exception(message: String)
}
