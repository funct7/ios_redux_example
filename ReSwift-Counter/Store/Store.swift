//
//  Store.swift
//  Redux-ReSwift
//
//  Created by Joshua Park on 2020/08/19.
//  Copyright © 2020 Knowre. All rights reserved.
//

import Foundation
import ReSwift

struct AppState : StateType {
    var counter = Counter.State()
}

private func appReducer(action: Action, state: AppState?) -> AppState {
    [Counter.self].reduce(state ?? .init()) { (state, slice) in
        slice.merger(
            global: state,
            state: slice.reducer(
                action: action,
                state: slice.selector(state: state)))
    }
}

let store = Store(
    reducer: appReducer,
    state: AppState())

