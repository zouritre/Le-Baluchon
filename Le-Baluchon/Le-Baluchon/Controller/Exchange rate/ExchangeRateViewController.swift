//
//  ViewController.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 22/05/2022.
//

import UIKit

extension ExchangeRateViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        //get the two pickerViews to reload their components when data arrives from API
        if self.pickerView1 == nil && pickerView.tag == 1 {
            self.pickerView1 = pickerView
        }
        else if self.pickerView2 == nil && pickerView.tag == 2 {
            self.pickerView2 = pickerView
        }
        
        return self.currencySymbols.count
    }
}
extension ExchangeRateViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // set pickerViews row to display each currency name
        return self.currencySymbolsDescription[row]
    }
}

extension UIViewController {
    
    func alert(message: String) {
        
        let alertView = UIAlertController.init(title: message, message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertView, animated: true)
    }
}

class ExchangeRateViewController: UIViewController {

    /// PickerView of currency to convert
    var pickerView1: UIPickerView?
    
    /// PickerView of currency to convert to
    var pickerView2: UIPickerView?
    
    var convertFrom: String = ""
    
    var convertTo: String = ""
    
    var currencySymbols: [String] = []
    
    var currencySymbolsDescription: [String] = []
    
    @IBOutlet weak var amountToConvertTextField: UITextField!
    
    @IBOutlet weak var amountConvertedTextField: UITextField!
    
    @IBOutlet weak var currencyToConvertPickerLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var convertedCurrencyPickerLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var convertedCurrencyTextLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get currencies symbol and name from API and display their names in each pickerView. Or display an alert if errors occured
        CurrencyService.getCurrencies { [weak self] currencies, error  in
            
            guard let self = self else {
                return
            }
            
            if error == nil {

                guard let currencies = currencies else {
                    print("currencies is nil")
                    return
                }

                for (key, value) in currencies {
                    
                    //Get the currencies symbol and name separately
                    self.currencySymbols.append(key)
                    self.currencySymbolsDescription.append(value)
                }

                DispatchQueue.main.async {

                    //Hide pickers loading indicator and reload them with new datas received
                    self.currencyToConvertPickerLoading.isHidden = true
                    self.pickerView1?.reloadAllComponents()
                    
                    self.convertedCurrencyPickerLoading.isHidden = true
                    self.pickerView2?.reloadAllComponents()
                }
            }
            
            else {

                guard let error = error else {
                    print("error is nil")
                    return
                }

                DispatchQueue.main.sync {
                    
                    //Display an alert with the error encountered
                    self.alert(message: error.rawValue)
                }
            }
        }
    }
    
    
    /// Hide the keyboard when tapping outside textfileds
    /// - Parameter sender: A tap gesture
    @IBAction func dissmissKeyboard(_ sender: UITapGestureRecognizer) {
        amountToConvertTextField.resignFirstResponder()
        
        //Get the conversion if any amount have been entered
        guard let amount = amountToConvertTextField.text else {
            return
        }
        
        if amount.count > 0 {
            getConversion()
        }
        else {
            return
        }
    }
    
    /// Convert provided currency amount to the provided currency target and displays the result
    func getConversion() {
        
        guard let picker1SelectedItemIndex = pickerView1?.selectedRow(inComponent: 0) else {
            print("Couldn't retrieve picker1 selected item")
            return
        }
        convertFrom = currencySymbols[picker1SelectedItemIndex]

        guard let picker2SelectedItemIndex = pickerView2?.selectedRow(inComponent: 0) else {
            print("Couldn't retrieve picker2 selected item")
            return
        }
        convertTo = currencySymbols[picker2SelectedItemIndex]

        guard let amount = amountToConvertTextField.text else {
            print("Couldn't retrieve textfield content for conversion amount")
            return
        }
        
        //Display the loading indicator when the provided currency amount is being converted
        convertedCurrencyTextLoading.isHidden = false
        
        CurrencyService.convertCurrencies(from: convertFrom, to: convertTo, amount: amount){ [weak self] result, error in

            guard let self = self else {
                return
            }

            if error == nil && result != nil {
                
                guard let result = result else {
                    print("result is nil")
                    return
                }
                
                DispatchQueue.main.async {
                    //Hide the loading indicator when conversion result is received and displays it
                    self.convertedCurrencyTextLoading.isHidden = true
                    
                    self.amountConvertedTextField.text = String(result)
                }
            }
            else if error != nil && result == nil{
                
                DispatchQueue.main.async {

                    guard let error = error else {
                        print("conversion error is nil")
                        return
                    }
                    
                    //Display an alert if an error occured while retrieving datas
                    self.convertedCurrencyTextLoading.isHidden = true
                    
                    self.alert(message: error.rawValue)
                }
            }

        }
    }
    

}

