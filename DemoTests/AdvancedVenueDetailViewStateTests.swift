//
//  AdvancedVenueDetailViewStateTests.swift
//  DemoTests
//
//  Created by Yosuke Ishikawa on 2018/09/05.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import XCTest
@testable import Demo

class AdvancedVenueDetailViewStateTests: XCTestCase {
    func testEmptyRelatedVenues() {
        let venue = Venue(photo: nil, name: "Kaminarimon")
        let review1 = Review(authorImage: nil, authorName: "Yosuke Ishikawa", body: "Foo")
        let review2 = Review(authorImage: nil, authorName: "Masatake Yamoto", body: "Bar")
        
        let data = AdvancedVenueDetailViewState(
            venue: venue,
            reviews: [
                review1,
                review2,
            ],
            relatedVenues: [])
        
        XCTAssertEqual(data.cellDeclarations, [
            .outline(venue),
            .sectionHeader("Reviews"),
            .review(review1),
            .review(review2),
        ])
    }
}
