//
//  Model.swift
//  CountOnMe
//
//  Created by Elodie Desmoulin on 02/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation


class Calculator {
    var operationStr: String = ""{
        didSet{
            NotificationCenter.default.post(name: Notification.Name("updateCalcul"), object: nil)
        }
    }
    
    var elements: [String] {
          return operationStr.split(separator: " ").map { "\($0)" }
    }
    
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveResult: Bool {
        return operationStr.firstIndex(of: "=") != nil
    }
    
    func addNumber(_ number: String){
        if expressionHaveResult {
            operationStr = ""
        }
        operationStr.append(number)
    }
    
    func addition() {
        if canAddOperator {
           result()
           operationStr.append(" + ")
        } else {
           NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Un operateur est déja mis !"]))
       }
    }
    
    func substraction() {
      if canAddOperator {
            result()
            operationStr.append(" - ")
         } else {
            NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Un operateur est déja mis !"]))
        }
    }
    
    func multiplication() {
       if canAddOperator {
            result()
            operationStr.append(" x ")
         } else {
            NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Un operateur est déja mis !"]))
        }
    }
    
    func division() {
       if canAddOperator {
            result()
            operationStr.append(" / ")
         } else {
            NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Un operateur est déja mis !"]))
        }
    }
    
    func reset() {
        operationStr = ""
    }
    
    func result() {
        if expressionHaveResult{
           if let resultat = elements.last {
                   operationStr = resultat
            }
        }
    }
    func processCalcul() {
        var operationsToReduce = elements
            
            // Iterate over operations while an operand still here
            while operationsToReduce.count > 1 {
                let left = Double(operationsToReduce[0])!
                let operand = operationsToReduce[1]
                let right = Double(operationsToReduce[2])!
                let result : Double
                switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "x": result = left * right
                case "/": result = left / right
                default: return 
                }
                
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            }
            
            operationStr.append(" = \(operationsToReduce.first!)")
        }
        
    }
