//
//  AssembliesCollector.swift
//  TheRun
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Swinject

private let collectToken = "com.incetro.Daily.Collector"

// MARK: - AssembliesCollector

protocol AssembliesCollector {

    init()

    /// Collect all Application assemblies in container
    ///
    /// - Parameters:
    ///   - container: container for collection
    func collect(inContainer container: Container)
}

extension AssembliesCollector {

    /// Collect all Application assemblies
    func collect() {
            self.collect(inContainer: AssembliesHolder.container)
    }

    // Collect all Application assemblies
    static func collect() {
        Self().collect()
    }

    /// Collect all Application assemblies in container
    ///
    /// - Parameters:
    ///   - container: container for collection
    static func collect(in container: Container) {
        Self().collect(inContainer: container)
    }
}
