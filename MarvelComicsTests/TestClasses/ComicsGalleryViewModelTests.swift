//
//  ComicsGalleryViewModelTests.swift
//  MarvelComicsTests
//
//  Created by Murat Sudan on 08/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import MarvelComics

class ComicsGalleryViewModelTests: XCTestCase {
    
    var sut: ComicsGalleryViewModel?
    
    class MockComicsAPI: ComicsAPIProtocol {
        
        let success:Bool
        
        init(success: Bool) {
            self.success = success
        }
        
        func fetchComicData(onSuccess: FetchComicsCallback?, onError: FetchComicsErrorCallback?) {
            
            if success {
                
                let bundle = Bundle(for: type(of: self))
                let path = bundle.path(forResource: "ComicsGallery", ofType: "json")
                let url = URL(fileURLWithPath: path!)
                let data = try! Data(contentsOf: url )
                
                let jsonDataAll = JSON(data: data)
                let comicsJSON = jsonDataAll["data"]["results"].arrayValue
                
                var comics:[Comic] = []
                
                for comicJSON in comicsJSON {
                    let comic = Comic(comicJSON)
                    comics.append(comic)
                }
                onSuccess?(comics)
                
            } else {
                let err = NSError(domain: "eror", code: 0, userInfo: nil)
                onError?(err)
            }
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_titleIsCorrect() {
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: true))
        XCTAssertEqual(sut.title, "Comics Gallery")
    }
    
    func test_cellSizeIsSetCorrectly() {
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: true))
        let size = CGSize(width: 320, height: 90)
        XCTAssertEqual(sut.cellSize(width: size.width, height: size.height), size)
    }
    
    func test_cellTitleIsSetCorrectlyForValidData() {
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: true))
        let indexPath = IndexPath(item: 0, section: 0)
        let title = sut.cellTitle(indexPath: indexPath)
        
        XCTAssertEqual(title, "Marvel Super-Heroes (1967) ")
    }
    
    func test_cellTitleIsSetCorrectlyForNoData() {
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: false))
        let indexPath = IndexPath(item: 0, section: 0)
        let title = sut.cellTitle(indexPath: indexPath)
        XCTAssertEqual(title, "")
    }
    
    func test_cellIssueNumberTitleIsSetCorrectlyForValidData() {
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: true))
        let indexPath = IndexPath(item: 0, section: 0)
        let issueNumberTitle = sut.cellIssueNumberTitle(indexPath: indexPath)
        XCTAssertEqual(issueNumberTitle, "Issue number: 60")
    }
    
    func test_cellIssueNumberTitleIsSetCorrectlyForNoData() {
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: false))
        let indexPath = IndexPath(item: 0, section: 0)
        let issueNumberTitle = sut.cellIssueNumberTitle(indexPath: indexPath)
        XCTAssertEqual(issueNumberTitle, "")
    }
    
    func test_formattedDateStringIsSetCorrectlyForValidSupportedDate() {
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: false))
        let str = sut.formattedDateString("1997-01-01T00:00:00-0500")
        XCTAssert(str.isEmpty == false)
    }
    
    func test_formattedDateStringIsSetCorrectlyForEmptyDate() {
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: false))
        let str = sut.formattedDateString("")
        XCTAssert(str.isEmpty == true)
    }
    
    func test_formattedDateStringIsSetCorrectlyForInvalidDate() {
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: false))
        let str = sut.formattedDateString("1999-12-12")
        XCTAssert(str.isEmpty == true)
    }
    
    func test_loadImageGetsAnImageFromCache() {
        
        let expect = expectation(description: "Waiting for image")
        
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: false))
        let urlString = "http://dummy.com/image.jpg"
        let img = UIImage(named: "test-image.jpg", in: Bundle(for: type(of: self)), compatibleWith: nil)
        sut.cache.setObject(img!, forKey: urlString as AnyObject)
        
        sut.loadImage(urlString: urlString) { (img) in
            XCTAssertNotNil(img)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_loadImageGetsAnImageFromValidUrl() {
        
        let expect = expectation(description: "Waiting for image")
        
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: false))
        let urlString = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"
        
        sut.loadImage(urlString: urlString) { (img) in
            XCTAssertNotNil(img)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
    }
    
    func test_loadImageGetsAnImageFromInValidUrl() {
        
        let expect = expectation(description: "Waiting for image")
        
        let sut = ComicsGalleryViewModel(comicsAPI: MockComicsAPI(success: false))
        let urlString = "http://google.com"
        
        sut.loadImage(urlString: urlString) { (img) in
            XCTAssertNil(img)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }

}


