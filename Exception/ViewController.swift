//
//  ViewController.swift
//  Exception
//
//  Created by Aseel Alshohatee on 3/27/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//

import UIKit
enum SsError: Error {   //Error is a protocol.
    case missing;       //.text property of UITextField was nil
    case tooShort;      //less than 9 digits
    case tooLong;       //more than 9 digits
    case badCharacter;  //only digits are allowed
    case badNumber;     //unable to store the number in an Int
}

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //number 1
//    func updateUI(_ string: String?) {
//        guard let ss: Int = convertStringToSS(string) else {
//            label.text = "It didn't work.";
//            return;
//        }
//
//        label.text = String(format: "Thank you for ss %09d.", ss);
//        textField.resignFirstResponder();
//    }
//
//    func convertStringToSS(_ string: String?) -> Int? {
//        guard let string: String = string else {
//            return nil;
//        }
//
//        guard string.count == 9 else {
//            return nil;
//        }
//
//        guard let ss: Int = Int(string) else {
//            return nil;
//        }
//
//        return ss;
//    }
    
    
    
    // number 2
    func updateUI(_ string: String?) {
        do {
            let ss: Int = try convertStringToSS(string);
            label.text = String(format: "Thank you for ss %09d.", ss);
            textField.resignFirstResponder();
        }
            
        catch SsError.tooShort {
            label.text = "Too short, try again.";
        }
            
        catch SsError.tooLong {
            label.text = "Too long, try again.";
        }
            
        catch SsError.badCharacter {
            label.text = "Only digits are allowed, try again.";
        }
            
        catch SsError.missing {
            label.text = "The UITextField malfunctioned.";
        }
            
        catch SsError.badNumber {
            label.text = "Can't store \(string!) in an Int.";
        }
            
        catch {
            label.text = "Unexpected \(error)";
        }
    }
    func convertStringToSS(_ string: String?) throws -> Int {   //no longer returns an optional
        defer{
       print("about to leave convertStringToSS(_:)"); 
        }
        guard let string: String = string else {
            throw SsError.missing;
        }
        
        if string.count < 9 {
            throw SsError.tooShort;
        }
        
        if string.count > 9 {
            throw SsError.tooLong;
        }
        
        let digits: CharacterSet = .decimalDigits;
        let nonDigits: CharacterSet = digits.inverted;
        
        if string.rangeOfCharacter(from: nonDigits) != nil {
            //The string contains a character that is not a digit.
            throw SsError.badCharacter;
        }
        
        guard let ss: Int = Int(string) else {
            throw SsError.badNumber;
        }
        
        return ss;
    }
    
    // MARK: - Action methods

    @IBAction func editingChange(_ sender: UITextField) {
        label.text = "" ;
        
    }
    
  //  @IBAction func returnKeyPressed(_ sender: UITextField) {
  //      updateUI(sender.text);
  //  }
   
   @IBAction func returnKeyPressed(_ sender: UITextField) {
        updateUI(sender.text);
    }
}

