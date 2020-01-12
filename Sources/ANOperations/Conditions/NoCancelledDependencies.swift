//
//  Copyright © 2015 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information
//
//  Modified by Andrew Podkovyrin, 2019
//

import Foundation

/**
 A condition that specifies that every dependency must have succeeded.
 If any dependency was cancelled, the target operation will be cancelled as
 well.
 */
public struct NoCancelledDependencies: OperationCondition {
    public static let name = "NoCalledDependencies"
    public static let isMutuallyExclusive = false

    public init() {
        // No op.
    }

    public func dependency(for operation: ANOperation) -> Operation? {
        return nil
    }

    public func evaluate(for operation: ANOperation, completion: @escaping (OperationConditionResult) -> Void) {
        // Verify that all of the dependencies executed.
        let cancelled = operation.dependencies.filter { $0.isCancelled }

        if cancelled.isEmpty {
            completion(.success)
        }
        else {
            // At least one dependency was cancelled; the condition was not satisfied.
            let error = OperationError.noCancelledDependenciesConditionFailed(cancelled: cancelled)
            completion(.failure(error))
        }
    }
}
