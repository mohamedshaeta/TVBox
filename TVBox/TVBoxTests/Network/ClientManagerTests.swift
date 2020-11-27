//
//  ClientManagerTests.swift
//  TVBoxTests
//
//  Created by Mohamed Sheta on 11/27/20.
//

import Foundation
import XCTest

@testable import TVBox
class ClientManagerTests: XCTestCase {
    
    func testValidRequest_ValidResponse() {
        //given

        let dependencyRegistryMock = DependencyRegistryMock()
        let urlSessionMock = URLSessionMock()
        urlSessionMock.validJsonFormat = true
        dependencyRegistryMock.urlSession = urlSessionMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        
        var response: Any?
        //when
        let expect = expectation(description: "Fetching..")
        clientManager.dataRequest(with: AuthenticationRequestMock.fetchGuestSessionId, responseObjectType: AuthenticationResponse.self) { (result) in
            switch result {
            case .success(let tmpResponse):
                response = tmpResponse
            case .failure(let error):
                print(error)
            }

            expect.fulfill()
        }
        waitForExpectations(timeout: 10)
        //then

        XCTAssertNotNil(response)
        XCTAssertTrue(response is AuthenticationResponse)
        XCTAssertTrue((response as! AuthenticationResponse).success!)
    }
    
    
    func testLoadInvalidJson_InvalidJsonClientError() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let urlSessionMock = URLSessionMock()
        urlSessionMock.validJsonFormat = false
        dependencyRegistryMock.urlSession = urlSessionMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        var response: Any?
        //when
        let expect = expectation(description: "Logging In")
        clientManager.dataRequest(with: AuthenticationRequestMock.fetchGuestSessionId, responseObjectType: AuthenticationResponse.self) { (result) in
            switch result {
            case .success(let tmpResponse):
                response = tmpResponse
            case .failure(let error):
                response = error
            }
            
            expect.fulfill()
        }
        waitForExpectations(timeout: 10)
        //then
        
        XCTAssertNotNil(response)
        XCTAssertTrue(response is ClientError)
        XCTAssertEqual((response as! ClientError).errorMessage(), NSLocalizedString("An error occurred with the server. You can try again.", comment: "error_server"))
    }
    
    func testLoadEmptyResponse_DataNotFoundClientError() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let urlSessionMock = URLSessionMock()
        urlSessionMock.responseNotFound = true
        dependencyRegistryMock.urlSession = urlSessionMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        
        var response: Any?
        //when
        let expect = expectation(description: "Fetching..")
        clientManager.dataRequest(with: AuthenticationRequestMock.fetchGuestSessionId, responseObjectType: AuthenticationResponse.self) { (result) in
            switch result {
            case .success(let tmpResponse):
                response = tmpResponse
            case .failure(let error):
                response = error
            }
            
            expect.fulfill()
        }
        waitForExpectations(timeout: 10)
        //then
        
        XCTAssertNotNil(response)
        XCTAssertTrue(response is ClientError)
        XCTAssertEqual((response as! ClientError).errorMessage(), NSLocalizedString("An error occurred with the server. You can try again.", comment: "error_server"))
    }
    
    func testLoadEmptyData_DataNotFoundClientError() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let urlSessionMock = URLSessionMock()
        urlSessionMock.dataNotFound = true
        dependencyRegistryMock.urlSession = urlSessionMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        var response: Any?
        //when
        let expect = expectation(description: "Fetching..")
        clientManager.dataRequest(with: AuthenticationRequestMock.fetchGuestSessionId, responseObjectType: AuthenticationResponse.self) { (result) in
            switch result {
            case .success(let tmpResponse):
                response = tmpResponse
            case .failure(let error):
                response = error
            }
            
            expect.fulfill()
        }
        waitForExpectations(timeout: 10)
        //then
        
        XCTAssertNotNil(response)
        XCTAssertTrue(response is ClientError)
        XCTAssertEqual((response as! ClientError).errorMessage(), NSLocalizedString("An error occurred with the server. You can try again.", comment: "error_server"))
    }
    
    func testLoadInternalServerError_DataNotFoundClientError() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let urlSessionMock = URLSessionMock()
        urlSessionMock.internalServerError = true
        dependencyRegistryMock.urlSession = urlSessionMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        
        var response: Any?
        //when
        let expect = expectation(description: "Fetching..")
        clientManager.dataRequest(with: AuthenticationRequestMock.fetchGuestSessionId, responseObjectType: AuthenticationResponse.self) { (result) in
            switch result {
            case .success(let tmpResponse):
                response = tmpResponse
            case .failure(let error):
                response = error
            }
            
            expect.fulfill()
        }
        waitForExpectations(timeout: 10)
        //then
        
        XCTAssertNotNil(response)
        XCTAssertTrue(response is ClientError)
        XCTAssertEqual((response as! ClientError).errorMessage(), NSLocalizedString("An error occurred with the server. You can try again.", comment: "error_server"))
    }
    
    func testNoNetwork_NeworkError() {
        //given
        let dependencyRegistryMock = DependencyRegistryMock()
        let urlSessionMock = URLSessionMock()
        urlSessionMock.noNetwork = true
        dependencyRegistryMock.urlSession = urlSessionMock
        DependencyRegistry.sharedInstance = dependencyRegistryMock
        let clientManager = DependencyRegistry.sharedInstance.getClientManager()
        
        var response: Any?
        //when
        let expect = expectation(description: "Fetching..")
        clientManager.dataRequest(with: AuthenticationRequestMock.fetchGuestSessionId, responseObjectType: AuthenticationResponse.self) { (result) in
            switch result {
            case .success(let tmpResponse):
                response = tmpResponse
            case .failure(let error):
                response = error
            }
            
            expect.fulfill()
        }
        waitForExpectations(timeout: 10)
        //then
        
        XCTAssertNotNil(response)
        XCTAssertTrue(response is ClientError)
        XCTAssertEqual((response as! ClientError).errorMessage(), NSLocalizedString("It seems you\'re not connected to the internet.", comment: "error_server"))
    }
    
    func testLoadInvalidFormatURL_InvalidURLClientError() {
    }
    
}
fileprivate class DependencyRegistryMock: DependencyRegistry {
    
    var urlSession: URLSession!
    
    override func getURLSession() -> URLSession {
        return urlSession
    }
}

class URLSessionMock: URLSession {
    var validJsonFormat: Bool = false
    var dataNotFound: Bool = false
    var responseNotFound: Bool = false
    var noNetwork: Bool = false
    var unauthorized: Bool = false
    var internalServerError: Bool = false
    
    override init() {}
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if noNetwork {
            completionHandler(nil,nil, ErrorMock())
            
        } else {
            var fileName: String = "test_valid_response"
            if validJsonFormat {
                fileName = "test_valid_response"
            }else {
                fileName = "test_invalid_response"
            }
            
            var data: Data?
            if dataNotFound == false {
                do {
                    let bundle = Bundle(for: type(of: self))
                    if let url = bundle.url(forResource: fileName, withExtension: "json") {
                        data = try Data(contentsOf: url)
                    }
                    
                }catch{
                    print(error)
                }
            }else {
                data = nil
            }
            
            if responseNotFound {
                completionHandler(data, nil, nil)
            }else {
                let httpResponse = HTTPURLResponseMock( unauthorized: unauthorized, internalserverError: internalServerError)
                
                completionHandler(data, httpResponse, nil)
            }
        }
        return URLSession.shared.dataTask(with: request)
    }
}

class HTTPURLResponseMock: HTTPURLResponse {

    init?(unauthorized: Bool, internalserverError: Bool) {
        if unauthorized {
             super.init(url: URL(fileURLWithPath: ""), statusCode: 401, httpVersion: nil, headerFields: nil)
        }else if internalserverError {
             super.init(url: URL(fileURLWithPath: ""), statusCode: 500, httpVersion: nil, headerFields: nil)
        }else {
             super.init(url: URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ErrorMock: Error {
    init() {
    }
}

enum AuthenticationRequestMock: Request {
    
    case fetchGuestSessionId
    
    var path: String {
        switch self {
        case .fetchGuestSessionId:
            return "authentication/guest_session/new?api_key=\(Keys.Moviedb_API_Key)"
        }
    }
    
    var parameters: Any? {
        switch self {
        case .fetchGuestSessionId:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .fetchGuestSessionId:
            return "get"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}




