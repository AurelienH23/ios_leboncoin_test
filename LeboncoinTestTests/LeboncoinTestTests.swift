//
//  LeboncoinTestTests.swift
//  LeboncoinTestTests
//
//  Created by Aurélien Haie on 02/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import XCTest
@testable import LeboncoinTest

class LeboncoinTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: Ad
    
    func fakeAdObject(withPrice price: Double) -> Ad {
        return Ad(id: 0, category_id: 0, title: "", description: "", price: price, images_url: ImagesUrl(small: "", thumb: ""), creation_date: "", is_urgent: true, siret: nil)
    }
    
    func testPriceFormatting() {
        // check the function .formattedPrice() on a Ad object
        
        // case with 0
        XCTAssertEqual("0,00 €", fakeAdObject(withPrice: 0).formattedPrice)
        // case with 1.0
        XCTAssertEqual("1,00 €", fakeAdObject(withPrice: 1.0).formattedPrice)
        // case with 250.0
        XCTAssertEqual("250,00 €", fakeAdObject(withPrice: 250.0).formattedPrice)
        // case with 10000.0
        XCTAssertEqual("10 000,00 €", fakeAdObject(withPrice: 10000.0).formattedPrice)
        // case with 100000.0
        XCTAssertEqual("100 000,00 €", fakeAdObject(withPrice: 100000.0).formattedPrice)
        // case with 1000000.0
        XCTAssertEqual("1 000 000,00 €", fakeAdObject(withPrice: 1000000.0).formattedPrice)
    }
    
    func fakeAdObject(withDate creationDate: String) -> Ad {
        return Ad(id: 0, category_id: 0, title: "", description: "", price: 0, images_url: ImagesUrl(small: "", thumb: ""), creation_date: creationDate, is_urgent: true, siret: nil)
    }
    
    func testGetDate() {
        // check the function .getDate() on a Ad object
        
        let creationDate = "2019-11-05T15:56:59+0000"
        let ad = fakeAdObject(withDate: creationDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.date(from: creationDate)
        
        XCTAssertEqual(dateFormatter.date(from: creationDate), ad.getDate())
    }
    
    func testConvertCreationDate() {
        // check the function .convertCreationDate() on a Ad object
        
        let creationDate = "2019-11-05T15:56:59+0000"
        let ad = fakeAdObject(withDate: creationDate)
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "dd/MM/yy"
        
        XCTAssertEqual("Annonce publiée le 05/11/19", ad.publicationDate)
    }
    
    func fakeAdObject(withSiret siret: String?) -> Ad {
        return Ad(id: 0, category_id: 0, title: "", description: "", price: 0, images_url: ImagesUrl(small: "", thumb: ""), creation_date: "", is_urgent: true, siret: siret)
    }
    
    func testGetAuthorInfo() {
        // check the function .getAuthorInfo() on a Ad object
        
        let ad = fakeAdObject(withSiret: nil)
        XCTAssertEqual("Particulier", ad.author)
        
        let companyAd = fakeAdObject(withSiret: "123 323 002")
        XCTAssertEqual("Entreprise SIRET: 123 323 002", companyAd.author)
    }
    
    // MARK: AdViewModel
    
    func fakeAdObject(withDate date: String, isUrgent: Bool) -> Ad {
        return Ad(id: 0, category_id: 0, title: "", description: "", price: 0, images_url: ImagesUrl(small: nil, thumb: nil), creation_date: date, is_urgent: isUrgent, siret: nil)
    }
    
    func testOrderingAds() {
        // check the function .orderFilteredAdsByDateAndEmergency() on a Ad collection
        
        let adTestA = fakeAdObject(withDate: "2020-01-01T15:56:59+0000", isUrgent: false)
        let adTestB = fakeAdObject(withDate: "2020-01-02T15:56:59+0000", isUrgent: true)
        let adTestC = fakeAdObject(withDate: "2020-01-03T15:56:59+0000", isUrgent: false)
        let adTestD = fakeAdObject(withDate: "2020-01-04T15:56:59+0000", isUrgent: false)
        let adTestE = fakeAdObject(withDate: "2020-01-05T15:56:59+0000", isUrgent: true)
        
        let viewModel = AdViewModel()
        
        let expected = [adTestE, adTestB, adTestD, adTestC, adTestA]
        let tested = viewModel.orderFilteredAdsByDateAndEmergency([adTestA, adTestB, adTestC, adTestD, adTestE])
        XCTAssertEqual(expected, tested)
    }

}
