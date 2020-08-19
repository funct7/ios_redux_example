//
//  CounterSlice.swift
//  ReSwift-Counter
//
//  Created by Joshua Park on 2020/08/19.
//  Copyright © 2020 Knowre. All rights reserved.
//

import Foundation
import ReSwift

enum Counter : Slice {
    
    enum Action : ReSwift.Action {
        case increment
        case decrement
        case incrementByAmount(Int)
    }

    struct State {
        fileprivate(set) var value: Int = 0
    }
    
    static func reducer(action: ReSwift.Action, state: State) -> State {
        guard let action = action as? Action else { return state }
        
        var state = state
        
        switch action {
        case .increment: state.value += 1
        case .decrement: state.value -= 1
        case .incrementByAmount(let amount): state.value += amount
        }
        
        return state
    }
    
    static func incrementAsync(amount: Int)
        -> (Store<AppState>) -> Void
    {
        { store in
            store.dispatch(Action.incrementByAmount(amount))
        }
    }
    
    static func selector(state: AppState) -> State { state.counter }
    
    static func merger(global: AppState, state: State) -> AppState {
        var global = global
        global.counter = state
        return global
    }
    
}
