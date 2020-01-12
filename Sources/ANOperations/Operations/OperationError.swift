//
//  Copyright © 2015 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information
//
//  Modified by Andrew Podkovyrin, 2019
//

import CloudKit
import Foundation

public struct OperationError: Error {
    public enum Reason {
        case negatedConditionFailed(notCondition: String)
        case noCancelledDependenciesConditionFailed(cancelled: [Operation])
        case reachabilityConditionFailed(host: URL)

        case timedOut(timeout: TimeInterval)
    }

    public let reason: Reason

    public static func negatedConditionFailed(notCondition: String) -> OperationError {
        return OperationError(.negatedConditionFailed(notCondition: notCondition))
    }

    public static func noCancelledDependenciesConditionFailed(cancelled: [Operation]) -> OperationError {
        return OperationError(.noCancelledDependenciesConditionFailed(cancelled: cancelled))
    }

    public static func reachabilityConditionFailed(host: URL) -> OperationError {
        return OperationError(.reachabilityConditionFailed(host: host))
    }

    public static func timedOut(timeout: TimeInterval) -> OperationError {
        return OperationError(.timedOut(timeout: timeout))
    }

    public init(_ reason: Reason) {
        self.reason = reason
    }
}

extension OperationError: Equatable {
    public static func == (lhs: OperationError, rhs: OperationError) -> Bool {
        switch (lhs.reason, rhs.reason) {
        case let (.negatedConditionFailed(lhs), .negatedConditionFailed(rhs)):
            return lhs == rhs
        case let (.noCancelledDependenciesConditionFailed(lhs), .noCancelledDependenciesConditionFailed(rhs)):
            return lhs == rhs
        case let (.reachabilityConditionFailed(lhs), .reachabilityConditionFailed(rhs)):
            return lhs == rhs
        case let (.timedOut(lhs), .timedOut(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}
