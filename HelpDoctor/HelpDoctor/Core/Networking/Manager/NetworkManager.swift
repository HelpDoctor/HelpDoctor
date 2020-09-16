//
//  NetworkManager.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import Foundation

struct NetworkManager {
    private let router = Router<HelpDoctorApi>()
    
    func registration(_ email: String,
                      completion: @escaping (_ responseCode: ServerResponse?, _ error: String?) -> Void) {
        router.request(.registration(email: email)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                do {
                    let apiResponse = try JSONDecoder().decode(ServerResponse.self, from: data!)
                    print(apiResponse)
                    completion(apiResponse, nil)
                }
                catch {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    completion(response.statusCode, nil)
//                case .failure(let networkFailureError):
//                    completion(nil, error)
//                }
            }
        }
    }
    
    func getListOfInterests(_ specCode: String?,
                            _ addSpecCode: String?,
                            completion: @escaping (_ listOfInterests: ListOfInterests?, _ error: String?) -> Void) {
        router.request(.getListOFInterests(specCode: specCode, addSpecCode: addSpecCode)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(ListOfInterests.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch DecodingError.dataCorrupted(let context) {
                        print(DecodingError.dataCorrupted(context))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        print(DecodingError.keyNotFound(key, context))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        print(DecodingError.typeMismatch(type, context))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        print(DecodingError.valueNotFound(value, context))
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getUser(completion: @escaping (_ profile: Profiles?, _ error: String?) -> Void) {
        router.request(.getProfile) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Profiles.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch DecodingError.dataCorrupted(let context) {
                        print(DecodingError.dataCorrupted(context))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        print(DecodingError.keyNotFound(key, context))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        print(DecodingError.typeMismatch(type, context))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        print(DecodingError.valueNotFound(value, context))
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    /*
    fileprivate func handleErrorCases(json: [String: Any], statusCode: Int) {
        guard let message = json["message"] as? String else {
            let error = errorWithDescription(description: "Error", code: statusCode)
            self.completionCallBack?(Result.failure(error))
            return
        }
        let error = errorWithDescription(description: message, code: statusCode)
        self.completionCallBack?(Result.failure(error))
    }
    
    fileprivate func errorWithDescription(description: String, code: Int) -> Error {
        let userInfo = [NSLocalizedDescriptionKey: description]
        return NSError(domain: "app", code: code, userInfo: userInfo) as Error
    }
 */
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}
