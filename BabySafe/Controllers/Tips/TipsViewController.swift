//
//  TipsViewController.swift
//  BabySafe
//
//  Created by Anghi Rodriguez on 25/06/22.
//

import UIKit

class TipsViewController: UIViewController {
    typealias completion = (([Tip]) -> Void)
    @IBOutlet weak var tipsTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var tipsList: [Tip] = []
    
    lazy var refreshControll: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(TipsViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControll.tintColor = Constants.mainColor
        return refreshControll
    }()
    
    @objc func handleRefresh(_ refreshControll: UIRefreshControl) {
        refreshControll.endRefreshing()
        fetchTips()
    }

    override func viewDidLoad() { //se ejecuta antes de mostrar la vista al usuario
        super.viewDidLoad()
        prepareView()
        fetchTips()
    }
    
    func loading(_ value: Bool) {
        if value {
            indicatorView.isHidden = false
            indicatorView.startAnimating()
        } else {
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
        }
    }
    
    private func fetchTips() {
        loading(true)
        FirestoreManager.fetchTips { [weak self] tips in
            self?.loading(false)
            self?.tipsList = tips.sorted(by: {
                return $0.likes > $1.likes
            })
            self?.tipsTableView.reloadData()
        }
    }
    
    //configurar la vista tips para mostrar
    func prepareView() {
        title = "Tips"
        navigationController?.navigationBar.backgroundColor = Constants.mainColor
        navigationController?.navigationBar.tintColor = Constants.titleColor
        tabBarController?.tabBar.backgroundColor = Constants.mainColor
        tabBarController?.tabBar.tintColor = Constants.titleColor
        tipsTableView.delegate = self // hace referencia al objeto actual de tipsViewcontroller, dentro del table view
        tipsTableView.dataSource = self
        tipsTableView.register(UINib(nibName: "TipTableViewCell", bundle: nil), forCellReuseIdentifier: "TipTableViewCell")
        tipsTableView.addSubview(self.refreshControll)
        let addTipButton = UIBarButtonItem(image: .add , style: .plain, target: self, action: #selector(addTipButtonPressed))
        self.navigationItem.rightBarButtonItem  = addTipButton
    }
    
    @objc private func addTipButtonPressed() {
        performSegue(withIdentifier: "tipNuevoSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tipDetalleSegue" {
            guard let indexPath =  sender as? IndexPath  else {
                return
            }
            if let viewController = segue.destination as? DetalleTipViewController {
                viewController.tip = tipsList[indexPath.row]
            }
        } else if segue.identifier == "tipNuevoSegue" {
            if let navigationController = segue.destination as? UINavigationController {
                navigationController.modalPresentationStyle = .fullScreen
                if let viewController = navigationController.viewControllers.first as? NuevoTipViewController {
                    viewController.delegate = self
                }
            }
        }
    }
    
}

extension TipsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 157
            
    }
    //retornar cada celda de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TipTableViewCell", for: indexPath) as? TipTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = tipsList[indexPath.row].title
        cell.descriptionLabel.text = tipsList[indexPath.row].description
        cell.likesLabel.text = "🍼 \(tipsList[indexPath.row].likes)"
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "tipDetalleSegue", sender: indexPath)
    }
    
    
}
extension TipsViewController: NuevoTipDelegate {
    func guardarTip(tip: Tip) {
        FirestoreManager.addTip(tip: tip) { [weak self] response in
            if response {
                self?.fetchTips()
            }
        }
    }
}

extension TipsViewController: TipTableViewCellDelegate {
    func likeButtonPressed(indexPath: IndexPath?) {
        if let indexPath = indexPath {
            var tip = tipsList[indexPath.row]
            tip.likes = tip.likes + 1
            FirestoreManager.updateTip(tip: tip)
            fetchTips()
        }
    }
    
    
}


