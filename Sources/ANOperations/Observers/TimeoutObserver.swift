//
//  Copyright (C) 2015 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information
//
//  Abstract:
//  This file shows how to implement the OperationObserver protocol.
//

import Foundation

/**
 `TimeoutObserver` is a way to make an `ANOperation` automatically time out and
 cancel after a specified time interval.
 */
public final class TimeoutObserver: OperationObserver {
    // MARK: Properties

    private let timeout: TimeInterval

    // MARK: Initialization

    public init(timeout: TimeInterval) {
        self.timeout = timeout
    }

    // MARK: OperationObserver

    public func operationDidStart(_ operation: ANOperation) {
        // When the operation starts, queue up a block to cause it to time out.
        let when = DispatchTime.now() + timeout

        DispatchQueue.global(qos: .init(qos: operation.qualityOfService)).asyncAfter(deadline: when) {
            /*
             Cancel the operation if it hasn't finished and hasn't already
             been cancelled.
             */
            if !operation.isFinished && !operation.isCancelled {
                let error = OperationError.timedOut(timeout: self.timeout)
                operation.cancelWithError(error)
            }
        }
    }

    public func operationDidCancel(_ operation: ANOperation) {
        // No op.
    }

    public func operation(_ operation: ANOperation, didProduceOperation newOperation: Operation) {
        // No op.
    }

    public func operationDidFinish(_ operation: ANOperation, errors: [Error]) {
        // No op.
    }
}
