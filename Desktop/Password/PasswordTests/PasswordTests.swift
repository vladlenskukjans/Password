//
//  PasswordTests.swift
//  PasswordTests
//
//  Created by Vladlens Kukjans on 28/02/2023.
//

import XCTest


@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {
    
    // Boundary conditions 8-32
    
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }
    
    func testLong() throws { //33
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123456789123456789123456789123456"))
    }
    
    func testValidShort() throws { //8
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }

    func testValidLong() throws { //32
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678912345678912345678912345"))
    }
}
    
class PasswordOtherCriteriaTests: XCTestCase {
    
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("ab cd"))
    }
    
    
    func testLengthAndSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpacesMet("12345678"))
    }
    
    func testLengthAndSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpacesMet("1234567 8"))
    }
    
    func testUppercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.upperCaseMet("A"))
    }
    
    func testUppercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.upperCaseMet("a"))
    }
    
    
    func testLowerCaseMet() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("v"))
    }
    
    func testLowerCaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("V"))
    }
    
    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("89"))
    }
    
    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("v"))
    }
    
    func testSpecialCharactersMet() throws {
        XCTAssertTrue(PasswordCriteria.specialCharactersMet("@"))
    }
    
    func testSpecialCharactersNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialCharactersMet("v"))
    }
}
