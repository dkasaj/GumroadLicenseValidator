//
//  GumroadClient.swift
//  GumroadLicenseCheck
//
//  Created by Daniel Kasaj on 07.01.2022..
//

import Foundation

/// Simple class to send requests to Gumroad's Verify License API endpoint, which does not require an OAuth application.
///
/// Class initializer is failable to ensure that the class has a product permalink.
///
/// - note: Has a configurable property `disputedPurchaseInvalidatesLicense`
public final class GumroadClient {
    let productPermalink: String

    /// Initializes only if product permalink string is not empty
    ///
    /// If your product URL is "https://gumroad.com/l/QMGY" your product permalink would be "QMGY."
    public init?(productPermalink: String) {
        guard productPermalink.isEmpty == false else { return nil }
        self.productPermalink = productPermalink
    }

    /// Checks validity of Gumroad-issued license key
    /// - Parameters:
    ///   - licenseKey: Non-empty string, preferably sanitized (remember Little Bobby Tables!)
    ///   - incrementUsesCount: Whether Gumroad should increment count of times a license has been checked
    /// - Returns: `true` only if a number of checks passed (see implementation)
    public func isLicenseKeyValid(_ licenseKey: String, incrementUsesCount: Bool = true) async -> Bool {
        guard let request = makeRequest(licenseKey: licenseKey,
                                        incrementUsesCount: incrementUsesCount) else { return false }
        let response: APIResponse? = try? await URLSession.shared.decode(for: request, dateDecodingStrategy: .iso8601)
        guard let success = response?.success, success,
              let purchase = response?.purchase else { return false }

        // Check that license key matches and purchase has not been refunded
        guard let verifiedKey = purchase.licenseKey, verifiedKey == licenseKey,
              let refunded = purchase.refunded, refunded == false
        else { return false }

        return true
    }

    /// Builds a URLRequest towards Gumroad API, which uses POST
    /// - Parameters:
    ///   - licenseKey: Non-empty string, preferably sanitized (remember Little Bobby Tables!)
    ///   - incrementUsesCount: Whether Gumroad should increment count of times a license has been checked
    /// - Returns: `URLRequest` with needed POST parameters
    func makeRequest(licenseKey: String, incrementUsesCount: Bool = true) -> URLRequest? {
        guard productPermalink.isEmpty == false, licenseKey.isEmpty == false else { return nil }
        guard let baseURL = URL(string: "https://api.gumroad.com/v2/licenses/verify"),
              var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        else { return nil }

        // Technique to avoid manually percent-encoding
        // https://stackoverflow.com/a/58356848
        components.queryItems = [
            URLQueryItem(name: "product_permalink", value: productPermalink),
            URLQueryItem(name: "license_key", value: licenseKey)
        ]
        if incrementUsesCount == false {
            components.queryItems?.append(URLQueryItem(name: "increment_uses_count", value: "false"))
        }
        guard let query = components.url?.query else { return nil }

        // Finally, build the request
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = Data(query.utf8)
        return urlRequest
    }

}
