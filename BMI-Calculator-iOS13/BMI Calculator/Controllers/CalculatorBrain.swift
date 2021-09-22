//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by prem on 10/09/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
struct CalculatorBrain
{
    var bmi : BMI?
    func getBMIValue() -> String
    {
        let bmiTo1Decimal = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiTo1Decimal
    }
    func getAdvice() -> String
    {
        return bmi?.advice ?? "No Advice Needed"
    }
    func getColor() -> UIColor
    {
        return bmi?.color ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    mutating func calculateBMI(weight:Float,height:Float)
    {
        let bmiValue = weight / (height * height)
        if bmiValue < 18.5
        {
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        } else if bmiValue < 24.5
        {
            bmi = BMI(value: bmiValue, advice: "Fit as Fiddle!", color : #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        } else
        {
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
        }
    }
}
