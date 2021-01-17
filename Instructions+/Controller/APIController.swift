//
//  APIController.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//

import Foundation
import BarcodeScanner

class APIController {
    final var PATH = "/videos/video"
    func makeBarcodeRequest(code: String) -> Result<VideoUrls?, NetworkError> {
        guard let url = URL(string: Constant.HOST + PATH + "?barcode=" + code) else { return .failure(.url) }
        
        var requestRet: Result<VideoUrls?, NetworkError>!
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) { result in
            switch result {
            case let .success((data, _)):
                do {
                    print(data)
                    let decoder = JSONDecoder()
                    let urlList = try decoder.decode(StringList.self, from: data)
                    let urls = VideoUrls(urls: urlList.videos)
                    requestRet = .success(urls)
                } catch {
                    requestRet = .failure(.dataFormat)
                }
            case let .failure(error):
                requestRet = .failure(error)
            }
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return requestRet
    }
}

extension URLSession {
    func dataTask(with url: URL, completion: @escaping (Result<(Data, URLResponse), NetworkError>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { data, response, error in
            if error != nil {
//                Logger.error(error)
                completion(.failure(.server))
                return
            }
            guard let response = response, let data = data else {
                completion(.failure(.server))
                return
            }
            completion(.success((data, response)))
        }
    }
}

func ApiCall(code: String) -> VideoUrls {
    let apiController = APIController()
    // Here it's running in the forground, later maybe change it to the background with another thread. For know-how, see comments in APIController
    let result = apiController.makeBarcodeRequest(code: code)
    switch result {
    case let .success(data):
        guard let videourls = data else {
//            Logger.error("failed")
            return VideoUrls()
        }
        return videourls
    case .failure(_):
//        Logger.error(error)
        return VideoUrls()
    }
}



