//
//  APIResponse.swift
//  GumroadLicenseCheck
//
//  Created by Daniel Kasaj on 07.01.2022..
//
//  swiftlint:disable identifier_name
//  swiftlint:disable nesting

import Foundation

extension GumroadClient {

    final class APIResponse: Decodable {
        let success: Bool?
        let uses: Int?
        let purchase: Purchase

        class Purchase: Decodable {
            let sellerID: String?
            let productID: String?
            let productName: String?
            let permalink: String?
            let productPermalink: String?
            let email: String?
            let price: Int?
            let gumroadFee: Int?
            let currency: String?
            let quantity: Int?
            let discoverFeeCharged: Bool?
            let canContact: Bool?
            let referrer: String?
            let orderNumber: Int?
            let saleID: String?
            let saleTimestamp: Date?
            let purchaserID: String?
            let subscriptionID: String?
            let variants: String?
            let licenseKey: String?
            let ipCountry: String?
            let recurrence: String?
            let isGiftReceiverPurchase: Bool?
            let refunded: Bool?
            let disputed: Bool?
            let disputeWon: Bool?
            let id: String?
            let createdAt: Date?
            let subscriptionEndedAt: Date?
            let subscriptionCancelledAt: Date?
            let subscriptionFailedAt: Date? // Date of inability to charge card

            enum CodingKeys: String, CodingKey {
                case sellerID = "seller_id"
                case productID = "product_id"
                case productName = "product_name"
                case permalink
                case productPermalink = "product_permalink"
                case email
                case price
                case gumroadFee = "gumroad_fee"
                case currency
                case quantity
                case discoverFeeCharged = "discover_fee_charged"
                case canContact
                case referrer
                case orderNumber = "order_number"
                case saleID = "sale_id"
                case saleTimestamp
                case purchaserID = "purchaser_id"
                case subscriptionID = "subscription_id"
                case variants
                case licenseKey = "license_key"
                case ipCountry = "ip_country"
                case recurrence
                case isGiftReceiverPurchase = "is_gift_receiver_purchase"
                case refunded
                case disputed
                case disputeWon = "dispute_won"
                case id
                case createdAt = "created_at"
                case subscriptionEndedAt = "subscription_ended_at"
                case subscriptionCancelledAt = "subscription_cancelled_at"
                case subscriptionFailedAt = "subscription_failed_at"
            }
        }
    }
}
