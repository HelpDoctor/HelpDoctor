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
                      completion: @escaping (Result<Int, NetworkResponse>) -> Void) {
        router.request(.registration(email: email)) { data, response, error in
            if error != nil {
                completion(.failure(.noNetwork))
            }
            if let response = response as? HTTPURLResponse {
                guard let responseData = data else {
                    completion(.failure(.noData))
                    return
                }
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    completion(.success(response.statusCode))
                case .failure(let networkFailureError):
                    do {
                        let apiResponse = try JSONDecoder().decode(ServerResponse.self, from: responseData)
                        completion(.failure(.customError(textError: apiResponse.status)))
                    } catch {
                        completion(.failure(networkFailureError))
                    }
                }
            }
        }
    }
    
    func recovery(_ email: String,
                  completion: @escaping (Result<Int, NetworkResponse>) -> Void) {
        router.request(.recovery(email: email)) { data, response, error in
            if error != nil {
                completion(.failure(.noNetwork))
            }
            if let response = response as? HTTPURLResponse {
                guard let responseData = data else {
                    completion(.failure(.noData))
                    return
                }
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    completion(.success(response.statusCode))
                case .failure(let networkFailureError):
                    do {
                        let apiResponse = try JSONDecoder().decode(ServerResponse.self, from: responseData)
                        completion(.failure(.customError(textError: apiResponse.status)))
                    } catch {
                        completion(.failure(networkFailureError))
                    }
                }
            }
        }
    }
    
    func deleteUser(completion: @escaping (Result<Int, NetworkResponse>) -> Void) {
        router.request(.deleteUser) { data, response, error in
            if error != nil {
                completion(.failure(.noNetwork))
            }
            if let response = response as? HTTPURLResponse {
                guard let responseData = data else {
                    completion(.failure(.noData))
                    return
                }
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    completion(.success(response.statusCode))
                case .failure(let networkFailureError):
                    do {
                        let apiResponse = try JSONDecoder().decode(ServerResponse.self, from: responseData)
                        completion(.failure(.customError(textError: apiResponse.status)))
                    } catch {
                        completion(.failure(networkFailureError))
                    }
                }
            }
        }
    }
    
    func login(_ email: String, _ password: String, completion: @escaping (Result<String, NetworkResponse>) -> Void) {
        router.request(.login(email: email, password: password)) { data, response, error in
            if error != nil {
                completion(.failure(.noNetwork))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                guard let responseData = data else {
                    completion(.failure(.noData))
                    return
                }
                switch result {
                case .success:
                    do {
                        let apiResponse = try JSONDecoder().decode(ServerResponse.self, from: responseData)
                        guard let token = apiResponse.token else {
                            completion(.failure(.noData))
                            return
                        }
                        Auth_Info.instance.token = token
                        KeychainWrapper.default.set(token, forKey: "myToken")
                        completion(.success(token))
                    } catch DecodingError.dataCorrupted(let context) {
                        print(DecodingError.dataCorrupted(context))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        print(DecodingError.keyNotFound(key, context))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        print(DecodingError.typeMismatch(type, context))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        print(DecodingError.valueNotFound(value, context))
                    } catch {
                        completion(.failure(.unableToDecode))
                    }
                case .failure(let networkFailureError):
                    do {
                        let apiResponse = try JSONDecoder().decode(ServerResponse.self, from: responseData)
                        completion(.failure(.customError(textError: apiResponse.status)))
                    } catch {
                        completion(.failure(networkFailureError))
                    }
                }
            }
        }
    }
    
    func getListOfInterests(_ specCode: String?,
                            _ addSpecCode: String?,
                            completion: @escaping (Result<ListOfInterests, NetworkResponse>) -> Void) {
        router.request(.getListOFInterests(specCode: specCode, addSpecCode: addSpecCode)) { data, response, error in
            if error != nil {
                completion(.failure(.noNetwork))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(.noData))
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(ListOfInterests.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch DecodingError.dataCorrupted(let context) {
                        print(DecodingError.dataCorrupted(context))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        print(DecodingError.keyNotFound(key, context))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        print(DecodingError.typeMismatch(type, context))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        print(DecodingError.valueNotFound(value, context))
                    } catch {
                        completion(.failure(.unableToDecode))
                    }
                case .failure(let networkFailureError):
                    completion(.failure(networkFailureError))
                }
            }
        }
    }
    
    func getUser(completion: @escaping (Result<Profiles, NetworkResponse>) -> Void) {
        router.request(.getProfile) { data, response, error in
            if error != nil {
                completion(.failure(.noNetwork))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                guard let responseData = data else {
                    completion(.failure(.noData))
                    return
                }
                switch result {
                case .success:
                    do {
                        let apiResponse = try JSONDecoder().decode(Profiles.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch DecodingError.dataCorrupted(let context) {
                        print(DecodingError.dataCorrupted(context))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        print(DecodingError.keyNotFound(key, context))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        print(DecodingError.typeMismatch(type, context))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        print(DecodingError.valueNotFound(value, context))
                    } catch {
                        completion(.failure(.unableToDecode))
                    }
                case .failure(let networkFailureError):
                    do {
                        let apiResponse = try JSONDecoder().decode(ServerResponse.self, from: responseData)
                        completion(.failure(.customError(textError: apiResponse.status)))
                    } catch {
                        completion(.failure(networkFailureError))
                    }
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Int, NetworkResponse> {
        switch response.statusCode {
        case 200...299:
            return .success(response.statusCode)
        case 401...500:
            return .failure(.authenticationError)
        case 501...599:
            return .failure(.badRequest)
        case 600:
            return .failure(.outdated)
        default:
            return .failure(.failed)
        }
    }
    
}

enum NetworkResponse: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case noNetwork
    case customError(textError: String?)
    
    var description: String {
        switch self {
        case .success:
            return "Success"
        case .authenticationError:
            return "You need to be authenticated first."
        case .badRequest:
            return "Bad request."
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response."
        case .noNetwork:
            return "Please check your network connection."
        case .customError(textError: let textError):
            return "\(textError ?? "Error")"
        }
    }
}
