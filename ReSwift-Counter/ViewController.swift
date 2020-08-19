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
    func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = inputValue
    }

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
    
    private var inputValue: String = "2" {
        didSet {
            [addButton, asyncAddButton].forEach {
                $0?.isEnabled = incrementAmount != nil
            }
        }
    }
    private var incrementAmount: Int? { Int(inputValue) }

    @IBOutlet
    private weak var countLabel: UILabel!
    
    @IBOutlet
    private weak var textField: UITextField!
    
    @IBOutlet
    private weak var addButton: UIButton!
    
    @IBOutlet
    private weak var asyncAddButton: UIButton!
    
    @IBAction
    private func decrementAction(_ sender: Any) {
        dispatch(.decrement)
    }
    
    @IBAction
    private func incrementAction(_ sender: Any) {
        dispatch(.increment)
    }
    
    @IBAction
    private func textDidChange(_ sender: UITextField) {
        inputValue = sender.text ?? ""
    }
    
    @IBAction
    private func addAction(_ sender: Any) {
        guard let amount = incrementAmount else { return }
        dispatch(.incrementByAmount(amount))
    }
    
    @IBAction
    private func asyncAddAction(_ sender: UIButton) {
        guard let amount = incrementAmount else { return }
        dispatch(Counter.incrementAsync(amount: amount))
        
        sender.backgroundColor = .systemBackground
        
        UIView.animate(
            withDuration: 1,
            animations: { sender.backgroundColor = .systemBlue },
            completion: { _ in sender.backgroundColor = .systemBackground })
    }
    
    @IBAction
    private func backgroundAction(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
}
