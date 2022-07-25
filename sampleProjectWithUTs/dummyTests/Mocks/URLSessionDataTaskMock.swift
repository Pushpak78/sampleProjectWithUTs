//
//  URLSessionDataTaskMock.swift
//  dummyTests
//
//  Created by admin on 29/11/21.
//

import XCTest
@testable import dummy


class URLSessionDataTaskMock: URLSessionDataTask {
    var closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}
