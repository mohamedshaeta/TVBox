//
//  NetworkModelTests.swift
//  TVBoxTests
//
//  Created by Mohamed Sheta on 11/27/20.
//

import Foundation
import XCTest

@testable import TVBox
class ClientInterfacesTests: XCTestCase {
    
    func testErrorMessage_ReturnsCorrectInvalidURLErrorMessage() {
        // Given
        let invalidUrlError = ClientError.invalidURL
        let expectedErrorMessage = NSLocalizedString("An error occurred connecting to the server. You can try again..", comment: "test invalid url")
        
        // Then
        XCTAssertEqual(invalidUrlError.errorMessage(), expectedErrorMessage)
    }
    
    func testErrorMessage_ReturnsCorrectNetworkErrorMessage() {
        // Given
        let networkError = ClientError.networkError(NSError())
        let expectedErrorMessage = NSLocalizedString("It seems you\'re not connected to the internet.", comment: "test network error")
        
        // Then
        XCTAssertEqual(networkError.errorMessage(), expectedErrorMessage)
    }
    
    func testErrorMessage_ReturnsCorrectDataNotFoundMessage() {
        // Given
        let dataNotFoundError = ClientError.dataNotFound
        let expectedErrorMessage = NSLocalizedString("An error occurred with the server. You can try again.", comment: "test data not found")
        
        // Then
        XCTAssertEqual(dataNotFoundError.errorMessage(), expectedErrorMessage)
    }
    
    func testErrorMessage_ReturnsCorrectJsonParsingErrorMessage() {
        // Given
        let jsonParsingError = ClientError.jsonParsingError(NSError())
        let expectedErrorMessage = NSLocalizedString("An error occurred with the server. You can try again.", comment: "test josn parsing")
        
        // Then
        XCTAssertEqual(jsonParsingError.errorMessage(), expectedErrorMessage)
    }
    
    func testErrorMessage_ReturnsCorrectUnauthorizedErrorMessage() {
        // Given
        let unauthorizedError = ClientError.unauthorized
        let expectedErrorMessage = NSLocalizedString("Sorry, Unuthorized user", comment: "error_user")
        
        // Then
        XCTAssertEqual(unauthorizedError.errorMessage(),expectedErrorMessage)
    }
}
