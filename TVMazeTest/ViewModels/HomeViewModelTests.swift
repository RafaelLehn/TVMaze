//
//  HomeViewModelTests.swift
//  TVMazeTests
//
//  Created by Ana Luiza on 3/23/23.
//

import XCTest
@testable import TVMaze

class HomeViewModelTests: XCTestCase {
    var viewModel: DetailViewModel?

    override func setUp() {
        super.setUp()
        viewModel = DetailViewModel()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testGetSeasons() {
    }

}
