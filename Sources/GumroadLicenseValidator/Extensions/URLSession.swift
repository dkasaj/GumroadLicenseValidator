//
//  URLSession.swift
//  GumroadLicenseCheck
//
//  Created by Daniel Kasaj on 07.01.2022..
//

import Foundation

extension URLSession {

    /// Fetches and decodes JSON data based on result type.
    /// Courtesy of Paul Hudson at the HackingWithSwift Live conference, Aug 2021
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        for urlRequest: URLRequest,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws -> T {
        let (data, _) = try await data(for: urlRequest)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }

}
