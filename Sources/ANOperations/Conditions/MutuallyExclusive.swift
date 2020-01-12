//
//  Copyright © 2015 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information
//
//  Modified by Andrew Podkovyrin, 2019
//

import Foundation

/// A generic condition for describing kinds of operations that may not execute concurrently.
public struct MutuallyExclusive<T>: OperationCondition {
    public static var name: String {
        return "MutuallyExclusive<\(T.self)>"
    }

    public static var isMutuallyExclusive: Bool {
        return true
    }

    public init() {}

    public func dependency(for operation: ANOperation) -> Operation? {
        return nil
    }

    public func evaluate(for operation: ANOperation, completion: @escaping (OperationConditionResult) -> Void) {
        completion(.success)
    }
}

public enum Alert {}

public typealias AlertPresentation = MutuallyExclusive<Alert>
