//
//  ViewControllerTests.swift
//  PasswordTests
//
//  Created by Vladlens Kukjans on 28/02/2023.
//
import XCTest

@testable import Password

class ViewControllerTests_NewPassword_Validation: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    let invalidPassword = "12345Aa+"
    
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }

    /*
     Here we trigger those criteria blocks by entering text,
     clicking the reset password button, and then checking
     the error label text for the right message.
     */
    
    func testEmptyPassword() throws {
        vc.newPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter your password")
    }
    
    func testInvalidPassword() throws {
        vc.newPasswordText = invalidPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
    }

    func testCriteriaNotMet() throws {
        vc.newPasswordText = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Your password must meet the requirements below")
    }

    func testValidPassword() throws {
        vc.newPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "")
        
    }
}

class ViewControllerTests_Confirm_Password_Validation: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.confirmPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Enter your password.")
    }
    
    
    
    let matchingPasswords = "12345678Aa!"
    let notMatchingPasswords = "12345678Aa"
    
    
    func testNotMatchingPasswords() throws {
        vc.newPasswordText = matchingPasswords
        vc.confirmPasswordText = notMatchingPasswords
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text, "Passwords do not match.")
    }
    
    func testMatchingPassword() throws {
        vc.newPasswordText = matchingPasswords
        vc.confirmPasswordText = matchingPasswords
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "")
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text, "")
    }
}

class ViewControllerTests_Show_Alert: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testShowSuccess() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())

        XCTAssertNotNil(vc.alert)
       //XCTAssertEqual(vc.alert!.title, "Success") // Optional
    }

    func testShowError() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())

        XCTAssertNil(vc.alert)
    }
}
