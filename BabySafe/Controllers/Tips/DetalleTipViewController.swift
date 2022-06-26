//
//  DetalleTipViewController.swift
//  BabySafe
//
//  Created by Anghi Rodriguez on 26/06/22.
//

import UIKit

class DetalleTipViewController: UIViewController {
    
    var tip: Tip?
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = tip?.title
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
