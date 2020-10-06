//
//  Calculator_Tests.swift
//  Calculator!Tests
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import XCTest
@testable import Calculator_

class Calculator_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let parser = Parser()
        let notation = Notation(basedOn: parser)
        let expressions = [
            ("(2-1*2)+-(2*5)+(-10.12+10)", -10.12),
            ("-(15.11-6/2*-(1+2))/-1*(2-6*2)", -241.1),
            ("-1*-(-1.12)/-(-1.12)+-(4)+-(-6)", 1),
            ("(6+10-4)/(1+1*2)+1", 5),
            ("14.22-(7+3*2/(2+4*3/2))", 6.47),
            ("-(-(-(-(15.11-6/2*-(1+2))/-1*(2-6*2))))", 241.1),
            ("100*10/2+16*4", 564),
            ("-1+3*(2-(1-(1))))", 5),
            ("-(2+2)*(2-4)", 8),
            ("1+3", 4),
            ("-4.2-5", -9.2),
            ("(5-",5)
        ]
        for (expression,result) in expressions{
            XCTAssertEqual (notation.calculate(expression), result, accuracy: 0.00000001, expression )
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
