//
//  Ad.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 04/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import Foundation

struct Ad: Decodable, Equatable {
    
    let id: Int
    let category_id: Int
    let title: String
    let description: String
    let price: Double
    let images_url: ImagesUrl
    let creation_date: String
    let is_urgent: Bool
    let siret: String?
    
    var formattedPrice: String {
        return convertPriceToFormat()
    }
    
    var creationDate: Date? {
        return getDate()
    }
    
    var publicationDate: String? {
        return convertCreationDate()
    }
    
    var author: String {
        return getAuthorInfo()
    }
    
    func convertPriceToFormat() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr")
        formatter.numberStyle = .currency
        
        if let formattedPrice = formatter.string(from: NSNumber(floatLiteral: price)) {
            return formattedPrice.replacingOccurrences(of: "¤", with: "€")
        } else {
            return "error"
        }
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: creation_date)
    }
    
    func convertCreationDate() -> String? {
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "dd/MM/yy"
        
        if let adDate = creationDate {
            return "Annonce publiée le \(newFormatter.string(from: adDate))"
        } else {
            return "Pas de date de publication"
        }
    }
    
    func getAuthorInfo() -> String {
        if let siret = siret {
            return "Entreprise SIRET: \(siret)"
        } else {
            return "Particulier"
        }
    }
    
    // MARK: Equatable
    
    static func == (lhs: Ad, rhs: Ad) -> Bool {
        guard lhs.id == rhs.id else { return false }
        guard lhs.category_id == rhs.category_id else { return false }
        guard lhs.title == rhs.title else { return false }
        guard lhs.description == rhs.description else { return false }
        guard lhs.price == rhs.price else { return false }
        guard lhs.creation_date == rhs.creation_date else { return false }
        guard lhs.is_urgent == rhs.is_urgent else { return false }
        guard lhs.siret == rhs.siret else { return false }
        return true
    }
    
}
