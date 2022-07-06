//
//  ViewFunctions.swift
//  Viper
//
//  Created by Rafael Oliveira on 05/07/22.
//

import Foundation

public protocol ViewFunctions{
    func setup()
    func setupHierarchy()
    func setupConstraints()
    func additional()
}

extension ViewFunctions{
    func setup(){
        setupHierarchy()
        setupConstraints()
        additional()
    }
    
    func additional() { }
}
