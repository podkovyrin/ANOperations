//
//  CompletionObserver.swift
//  CloudKitNotes
//
//  Created by Andrew Podkovyrin on 16/05/2019.
//  Copyright © 2019 AP. All rights reserved.
//

import Foundation

public final class CompletionObserver: OperationObserver {
    private var completion: ((ANOperation, [Error]) -> Void)?

    public init(_ completion: @escaping (ANOperation, [Error]) -> Void) {
        self.completion = completion
    }

    // MARK: OperationObserver

    public func operationDidStart(_ operation: ANOperation) {}

    public func operationDidCancel(_ operation: ANOperation) {}

    public func operation(_ operation: ANOperation, didProduceOperation newOperation: Operation) {}

    public func operationDidFinish(_ operation: ANOperation, errors: [Error]) {
        DispatchQueue.main.async {
            self.completion?(operation, errors)
            self.completion = nil
        }
    }
}
