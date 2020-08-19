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
        
        // TODO: Refactor and use default implementations using slice
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
    
    // TODO: Refactor and use default implementations if possible
    private var state: Counter.State { Counter.selector(state: store.state) }
    
    @IBOutlet
    private weak var countLabel: UILabel!
    
    @IBOutlet
    private weak var textField: UITextField!
    
    @IBAction
    private func decrementAction(_ sender: Any) {
        dispatch(.decrement)
    }
    
    @IBAction
    private func incrementAction(_ sender: Any) {
        dispatch(.increment)
    }
    
    @IBAction
    private func addAction(_ sender: Any) {
        // TODO: Handle validation. How?
        guard let amount = Int(textField.text ?? "0") else { return }
        dispatch(.incrementByAmount(amount))
    }
    
    @IBAction
    private func asyncAddAction(_ sender: UIButton) {
        // TODO: Handle validation. How?
        guard let amount = Int(textField.text ?? "0") else { return }
        dispatch(Counter.incrementAsync(amount: amount))
        
        let color = sender.backgroundColor ?? .systemBackground
        
        UIView.animate(
            withDuration: 1,
            animations: { sender.backgroundColor = .systemBlue },
            completion: { _ in
                sender.backgroundColor = color
            })
    }
    
    @IBAction
    private func backgroundAction(_ sender: Any) {
        textField.resignFirstResponder()
    }
}
