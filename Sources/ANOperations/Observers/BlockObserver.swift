//
//  Copyright (C) 2015 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information
//
//  Abstract:
//  This file shows how to implement the OperationObserver protocol.
//

import Foundation

/**
 The `BlockObserver` is a way to attach arbitrary blocks to significant events
 in an `ANOperation`'s lifecycle.
 */
public final class BlockObserver: OperationObserver {
    // MARK: Properties

    private var startHandler: ((ANOperation) -> Void)?
    private var cancelHandler: ((ANOperation) -> Void)?
    private var produceHandler: ((ANOperation, Operation) -> Void)?
    private var finishHandler: ((ANOperation, [Error]) -> Void)?

    public init(startHandler: ((ANOperation) -> Void)? = nil,
                cancelHandler: ((ANOperation) -> Void)? = nil,
                produceHandler: ((ANOperation, Operation) -> Void)? = nil,
                finishHandler: ((ANOperation, [Error]) -> Void)? = nil) {
        self.startHandler = startHandler
        self.cancelHandler = cancelHandler
        self.produceHandler = produceHandler
        self.finishHandler = finishHandler
    }

    // MARK: OperationObserver

    public func operationDidStart(_ operation: ANOperation) {
        startHandler?(operation)
    }

    public func operationDidCancel(_ operation: ANOperation) {
        cancelHandler?(operation)
    }

    public func operation(_ operation: ANOperation, didProduceOperation newOperation: Operation) {
        produceHandler?(operation, newOperation)
    }

    public func operationDidFinish(_ operation: ANOperation, errors: [Error]) {
        finishHandler?(operation, errors)
        
        // cleanup
        startHandler = nil
        cancelHandler = nil
        produceHandler = nil
        finishHandler = nil
    }
}
