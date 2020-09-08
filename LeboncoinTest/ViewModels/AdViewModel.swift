//
//  AdViewModel.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 08/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class AdViewModel {
    
    // MARK: Properties
    
    var selectedFilter = 0
    
    var ads = [Ad]() {
        didSet {
            filteredAds.value = orderFilteredAdsByDateAndEmergency(ads)
        }
    }
    
    var filteredAds = Box<[Ad]>([Ad]())
    
    // MARK: Custom funcs
    
    func fetchAds(completion: @escaping () -> (), errorHandler: @escaping () -> ()) {
        let urlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
        Network.parseUrl(urlString, to: [Ad].self, completion: { (fetchedAds) in
            self.ads = fetchedAds
            completion()
        }) {
            errorHandler()
        }
    }
    
    func orderFilteredAdsByDateAndEmergency(_ selectedAds: [Ad]) -> [Ad] {
        var urgentAds = selectedAds.filter({$0.is_urgent == true})
        var otherAds = selectedAds.filter({$0.is_urgent == false})
        
        urgentAds.sort(by: {$0.creationDate! > $1.creationDate!})
        otherAds.sort(by: {$0.creationDate! > $1.creationDate!})
        
        return urgentAds + otherAds
    }
    
    func configureCell(_ cell: AdCell, at index: Int) {
        cell.ad = filteredAds.value[index]
    }
    
    func didSelectFilter(at index: Int) {
        if index == 0 {
            filteredAds.value = orderFilteredAdsByDateAndEmergency(ads)
        } else {
            filteredAds.value = orderFilteredAdsByDateAndEmergency(ads.filter({$0.category_id == index}))
        }
    }
    
}

