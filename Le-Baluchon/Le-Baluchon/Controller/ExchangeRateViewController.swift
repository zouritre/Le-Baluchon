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

extension ExchangeRateViewController {
    
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
    
    @IBOutlet weak var amountToConvertTextField: UITextField!
    
    var currencySymbols: [String] = []
    var currencySymbolsDescription: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get currencies symbol and name from API and display their names in each pickerView. Or display an alert if errors occured
        CurrencyService.shared.getCurrencies { [weak self] currencies, error  in
            
            guard let self = self else {
                return
            }
            
            if error == nil {

                guard let currencies = currencies else {
                    print("currencies is nil")
                    return
                }

                for (key, value) in currencies {
                    self.currencySymbols.append(key)
                    self.currencySymbolsDescription.append(value)
                }

                DispatchQueue.main.async {

                    self.pickerView1?.reloadAllComponents()
                    self.pickerView2?.reloadAllComponents()
                }
            }
            
            else {

                guard let error = error else {
                    print("error is nil")
                    return
                }

                DispatchQueue.main.sync {
                    self.alert(message: error)
                }
            }
        }
    }
    
    
    /// Hide the keyboard when tapping outside textfileds
    /// - Parameter sender: A tap gesture
    @IBAction func dissmissKeyboard(_ sender: UITapGestureRecognizer) {
        amountToConvertTextField.resignFirstResponder()
    }
    

}

