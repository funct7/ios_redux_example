//
//  ViewController.swift
//  ReSwift
//
//  Created by Joshua Park on 2020/08/18.
//  Copyright © 2020 Knowre. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
    
    // MARK: Implement - Store subsccriber
    
    func newState(state: Counter.State) {
        countLabel.text = "\(state.value)"
    }

    // MARK: Inherited

    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) {
            $0.select { Counter.selector(state: $0) }
        }
    }
    
    override
    func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    // MARK: Private
    
    private var state: Counter.State { Counter.selector(state: store.state) }
    
    private func dispatch(_ action: Counter.Action) {
        store.dispatch(action)
    }
    
    @IBOutlet
    private weak var countLabel: UILabel!
    
    @IBAction
    private func decrementAction(_ sender: Any) {
        dispatch(.decrement)
    }
    
    @IBAction
    private func incrementAction(_ sender: Any) {
        dispatch(.increment)
    }
    
}
