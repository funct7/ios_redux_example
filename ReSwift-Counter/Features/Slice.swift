//
//  Slice.swift
//  ReSwift-Counter
//
//  Created by Joshua Park on 2020/08/19.
//  Copyright © 2020 Knowre. All rights reserved.
//

import Foundation
import ReSwift

protocol Slice {
    associatedtype GlobalState
    associatedtype SliceState
    
    static func reducer(action: ReSwift.Action, state: SliceState) -> SliceState
    static func selector(state: GlobalState) -> SliceState
    static func merger(global: GlobalState, state: SliceState) -> GlobalState
}
