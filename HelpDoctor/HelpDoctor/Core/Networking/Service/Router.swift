//
//  Router.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 14.09.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        switch route.taskMethod {
        case .upload(source: let source):
            do {
                let request = try self.buildRequest(from: route)
                task = session.uploadTask(with: request,
                                          from: self.createData(source),
                                          completionHandler: { data, response, error in
                                            completion(data, response, error) })
//                print(self.createData(source)?.base64EncodedString())
            } catch {
                completion(nil, nil, error)
            }
        default:
            do {
                let request = try self.buildRequest(from: route)
                task = session.dataTask(with: request,
                                        completionHandler: { data, response, error in
                                            completion(data, response, error) })
//                print(request.httpBody?.base64EncodedString())
//                print(request.url)
            } catch {
                completion(nil, nil, error)
            }
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    fileprivate func createData(_ source: URL) -> Data? {
        do {
            let data = try Data(contentsOf: source)
            let fileName = source.path
            var mimeType: NetworkMimeType?
            switch source.pathExtension.lowercased() {
            case "heic":
                mimeType = .heic
            case "jpeg":
                mimeType = .jpeg
            case "jpg":
                mimeType = .jpg
            case "png":
                mimeType = .png
            case "pdf":
                mimeType = .pdf
            default:
                break
            }
            let boundary = Session.instance.boundary
            var body = Data()
            let encoding: UInt = String.Encoding.utf8.rawValue
            guard let fileType = mimeType?.rawValue else { return nil }
            if let boundaryStartData = "--\(boundary)\r\n".data(using: String.Encoding(rawValue: encoding)),
               let fileNameData = "Content-Disposition:form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding(rawValue: encoding)),
               let contentTypeData = "Content-Type: \(fileType)\r\n\r\n".data(using: String.Encoding(rawValue: encoding)),
               let endLineData = "\r\n".data(using: String.Encoding(rawValue: encoding)),
               let boundaryEndData = "--\(boundary)--\r\n".data(using: String.Encoding(rawValue: encoding)) {
                body.append(boundaryStartData)
                body.append(fileNameData)
                body.append(contentTypeData)
                body.append(data)
                body.append(endLineData)
                body.append(boundaryEndData)
            }
            return body
        } catch {
            return nil
        }
    }
    
}
