//
//  ExchangeRates.swift
//  PocketMoney
//
//  Created by Nathaniel Law on 3/29/24.
//

import Foundation

struct ExchangeRates: Codable {
    let disclaimer: String
    let license: String
    let timestamp: Float
    let base: String
    let rates: CurrencyConversions
}
