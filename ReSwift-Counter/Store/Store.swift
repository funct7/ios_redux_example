//
//  Store.swift
//  Redux-ReSwift
//
//  Created by Joshua Park on 2020/08/19.
//  Copyright © 2020 Knowre. All rights reserved.
//

import Foundation
import ReSwift
import ReSwift_Thunk

struct AppState : StateType {
    var counter = Counter.State()
}

private func appReducer(action: Action, state: AppState?) -> AppState {
    [Counter.self].reduce(state ?? .init()) { (state, slice) in
        // TODO: Refactor into linear style code
        slice.merger(
            global: state,
            state: slice.reducer(
                action: action,
                state: slice.selector(state: state)))
    }
}

private let thunkMiddleware: Middleware<AppState> = createThunkMiddleware()

let store = Store(
    reducer: appReducer,
    state: AppState(),
    middleware: [thunkMiddleware])

