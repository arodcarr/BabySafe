//
//  NuevoTipViewController.swift
//  BabySafe
//
//  Created by Anghi Rodriguez on 26/06/22.
//

import UIKit
protocol NuevoTipDelegate {
    func guardarTip (tip: Tip)
}

class NuevoTipViewController: UIViewController {

    var delegate: NuevoTipDelegate?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func guardarButtonPressed(_ sender: Any) {
        guard let title = self.titleTextField.text,
              let description = self.descriptionTextView.text,
              !title.isEmpty,
              !description.isEmpty else {
                  return
        }
        let tip = Tip(id: nil, title:title, description: description, likes: 0)
        delegate?.guardarTip(tip: tip)
        dismiss(animated: true, completion: nil)
    }
    

}
