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
    
    func logout(completion: @escaping (Result<Int, NetworkResponse>) -> Void) {
        router.request(.logout) { data, response, error in
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
    
    func checkProfile(completion: @escaping (Result<Bool, NetworkResponse>) -> Void) {
        router.request(.checkProfile) { data, response, error in
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
                    do {
                        let apiResponse = try JSONDecoder().decode(ServerResponse.self, from: responseData)
                        completion(.success(apiResponse.status == "True" ? true : false))
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
    
    func getRegions(completion: @escaping (Result<[Regions], NetworkResponse>) -> Void) {
        router.request(.getRegions) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode([Regions].self, from: responseData)
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
    
    func getCities(_ regionId: Int, completion: @escaping (Result<[Cities], NetworkResponse>) -> Void) {
        router.request(.getCities(regionId: regionId)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode([Cities].self, from: responseData)
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
    
    func getMedicalOrganizations(_ regionId: Int,
                                 completion: @escaping (Result<[MedicalOrganization], NetworkResponse>) -> Void) {
        router.request(.getMedicalOrganization(regionId: regionId)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode([MedicalOrganization].self, from: responseData)
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
    
    func getMedicalSpecializations(completion: @escaping (Result<[MedicalSpecialization], NetworkResponse>) -> Void) {
        router.request(.getMedicalSpecialization) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode([MedicalSpecialization].self, from: responseData)
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
    
    private func prepareUserForRequest(_ user: User?) -> [String: Any] {
        return [
            "first_name": user?.firstName as Any,
            "last_name": user?.lastName as Any,
            "middle_name": user?.middleName as Any,
            "phone_number": user?.phoneNumber as Any,
            "birthday": user?.birthday as Any,
            "city_id": user?.cityId as Any,
            "foto": user?.foto as Any,
            "gender": user?.gender as Any,
            "is_medic_worker": user?.isMedicWorker as Any
        ]
    }
    
    private func prepareJobForRequest(_ job: [Job]?) -> [[String: Any]] {
        var jobRequest: [[String: Any]] = []
        job?.forEach {
            jobRequest.append(["id": $0.id,
                               "job_oid": $0.organization?.oid as Any,
                               "is_main": $0.isMain as Any])
        }
        return jobRequest
    }
    
    private func prepareSpecForRequest(_ spec: [Specialization]?) -> [[String: Any]] {
        var specRequest: [[String: Any]] = []
        spec?.forEach {
            specRequest.append(["id": $0.id,
                                "spec_id": $0.specialization?.id as Any,
                                "is_main": $0.isMain as Any])
        }
        return specRequest
    }
    
    private func prepareInterestsForRequest(_ interests: [ProfileInterest]?) -> [Int] {
        var interestsRequest: [Int] = []
        interests?.forEach {
            interestsRequest.append($0.interest?.id ?? 0)
        }
        return interestsRequest
    }
    
    func updateUser(_ user: User?,
                    _ job: [Job]?,
                    _ spec: [Specialization]?,
                    _ interests: [ProfileInterest]?,
                    completion: @escaping (Result<String, NetworkResponse>) -> Void) {
        let userRequest = user != nil ? prepareUserForRequest(user) : nil
        let jobRequest = prepareJobForRequest(job)
        let specRequest = prepareSpecForRequest(spec)
        let interestsRequest = prepareInterestsForRequest(interests)
        
        router.request(.updateProfile(user: userRequest,
                                      job: jobRequest,
                                      spec: specRequest,
                                      interests: interestsRequest)) { data, response, error in
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
                                                    let apiResponse = try JSONDecoder().decode(ServerResponse.self,
                                                                                               from: responseData)
                                                    completion(.success(apiResponse.status))
                                                } catch {
                                                    completion(.failure(.unableToDecode))
                                                }
                                            case .failure(let networkFailureError):
                                                do {
                                                    let apiResponse = try JSONDecoder().decode(ServerResponse.self,
                                                                                               from: responseData)
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
