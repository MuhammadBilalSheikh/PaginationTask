//
//  ViewController.swift
//  MVVM-Clean
//
//  Created by MBS on 18/01/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapSearch(_ sender: Any) {
        if !(searchTextField.text ?? "").isEmpty {
            self.searchButtonTap()
        } else {
            // create the alert
            let alert = UIAlertController(title: "Error", message: "text is required", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }

}

extension ViewController{
    func searchButtonTap() {

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        vc?.searchText = searchTextField.text ?? ""
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
