//
//  TipsViewController.swift
//  BabySafe
//
//  Created by Anghi Rodriguez on 25/06/22.
//

import UIKit

class TipsViewController: UIViewController {

    @IBOutlet weak var tipsTableView: UITableView!
    
    let tipsList: [Tip] = Constants.tipsList

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    func prepareView() {
        title = "Tips"
        navigationController?.navigationBar.backgroundColor = Constants.mainColor
        navigationController?.navigationBar.tintColor = Constants.titleColor
        tabBarController?.tabBar.backgroundColor = Constants.mainColor
        tabBarController?.tabBar.tintColor = Constants.titleColor
        tipsTableView.delegate = self
        tipsTableView.dataSource = self
        tipsTableView.register(UINib(nibName: "TipTableViewCell", bundle: nil), forCellReuseIdentifier: "TipTableViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath =  sender as? IndexPath  else {
            return
        }
        if segue.identifier == "tipDetalleSegue" {
            if let viewController = segue.destination as? DetalleTipViewController {
                viewController.tip = tipsList[indexPath.row]
            }
        }
    }
    
}

extension TipsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
            
    }
    //retornar cada celda de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TipTableViewCell", for: indexPath) as? TipTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = tipsList[indexPath.row].title
        cell.descriptionLabel.text = tipsList[indexPath.row].description
        cell.likesLabel.text = "🍼 \(tipsList[indexPath.row].likes)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "tipDetalleSegue", sender: indexPath)
    }
    
    
}
