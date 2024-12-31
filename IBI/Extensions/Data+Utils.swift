//
//  Data+Utils.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import Foundation

extension Data {
    func parse<T: Decodable>() -> Result<T, Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedObject = try decoder.decode(T.self, from: self)
            return .success(decodedObject)
        }
        catch {
            return .failure(error)
        }
    }
}
