//
//  TheRunAssembliesCollector.swift
//  TheRun
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Swinject

// MARK: - ApplicationAssembliesCollector

final class ApplicationAssembliesCollector: AssembliesCollector {

    required init() {

    }

    func collect(inContainer container: Container) {

        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)

        objc_getClassList(autoreleasingTypes, Int32(typeCount))

        for index in 0..<typeCount {
            if let assemblyType = (types[index] as? CollectableAssembly.Type) {
                let object = assemblyType.init()
                object.assemble(inContainer: container)
            }
        }

        types.deallocate()
    }
}
