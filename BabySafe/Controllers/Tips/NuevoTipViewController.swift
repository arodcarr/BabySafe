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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func guardarButtonPressed(_ sender: Any) {
        delegate?.guardarTip(tip: Tip(title: "Titulo Prueba", description: "Descripcion", likes: 0))
        dismiss(animated: true, completion: nil)
    }
    

}
