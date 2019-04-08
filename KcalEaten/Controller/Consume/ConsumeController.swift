//
//  ConsumeController.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 19/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

//---------------------------
//MARK: - Outlets & variables
//---------------------------
class ConsumeController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var titleView: UIView!

    private let _consumeCellId = "consumeCell"
    private let _showConsumeDetailsSegueId = "showConsumeDetails"
    private var _consumeGroupedByDate = [[Consume]]()
    private var _consumesFromCoreData: [Consume]!
    private let _coreDataService = CoreDataHelper()
    private var _dateOfConsumeClicked: String!
}

//---------------
//MARK: - Methods
//---------------
extension ConsumeController {
    private func attemptToAssembleGroupedConsume() {

        _consumeGroupedByDate.removeAll()

        //Groupe consume by date
        let groupedConsume = Dictionary(grouping: _consumesFromCoreData) { (element) -> Date in
            guard let elementDate = element.date else { return Date() }
            return elementDate
        }

        //Sorte consume by date; key == date
        let sortedKeys = groupedConsume.keys.sorted(by: >)
        sortedKeys.forEach { (key) in
            let values = groupedConsume[key]
            _consumeGroupedByDate.append(values ?? [])
        }
    }
    
    private func populateTableView() {
        _consumesFromCoreData = try? _coreDataService.fetchConsume()
        attemptToAssembleGroupedConsume()
        tableview.reloadData()
    }
}

//------------------
//MARK: - Life Cycle
//------------------
extension ConsumeController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleView.isHidden = false
        populateTableView()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.topItem?.title = _dateOfConsumeClicked
    }
}

//---------------------------------------
//MARK: - Tableview dataSource & delegate
//---------------------------------------
extension ConsumeController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        //To show a default message
        if _consumeGroupedByDate.count == 0 {
            tableView.isScrollEnabled = false
            titleView.isHidden = true
            return 1
        }

        tableView.isScrollEnabled = true
        return _consumeGroupedByDate.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _consumeGroupedByDate.count > 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //Creating cell
        let cell = tableView.dequeueReusableCell(withIdentifier: _consumeCellId, for: indexPath) as! ConsumeCell

        //Set cell
        cell.setup(dayConsume: _consumeGroupedByDate[indexPath.section])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _dateOfConsumeClicked = _consumeGroupedByDate[indexPath.section].first?.date?.toString()
        
        var products = [(product:ProductObject, quantity:Int)]()
        
        _consumeGroupedByDate[indexPath.section].forEach { (consume) in
            if let product = consume.product {
                products.append((product, Int(consume.quantity)))
            }
        }

        let consumes = _consumeGroupedByDate[indexPath.section]

        performSegue(withIdentifier: _showConsumeDetailsSegueId, sender: consumes)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            _consumeGroupedByDate[indexPath.section].forEach { (consume) in
                try? _coreDataService.delete(consume: consume)
            }
            populateTableView()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //Setup container
        let container = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))

        //Setup imageView
        let titleHeigth: CGFloat = titleView.frame.height
        let imageViewWidthAndHeigth: CGFloat = container.frame.width * 0.5
        let imageView = UIImageView(frame: CGRect(x: imageViewWidthAndHeigth / 2, y: (container.frame.height / 2) - (imageViewWidthAndHeigth + titleHeigth), width: imageViewWidthAndHeigth, height: imageViewWidthAndHeigth))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "NoConsume")

        //Setup Label
        let topMarginToImageView: CGFloat = 10
        let label = UILabel(frame: CGRect(x: imageView.frame.minX, y: imageView.frame.maxY + topMarginToImageView, width: imageViewWidthAndHeigth, height: 0))
        label.text = "Auncune consommation enregistrées pour le moment."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()

        //Add subview
        container.addSubview(imageView)
        container.addSubview(label)
        
        return container
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return _consumeGroupedByDate.count == 0 ? view.bounds.height : 0
    }
}
//------------------------
//MARK: - Navigation
//------------------------
extension ConsumeController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == _showConsumeDetailsSegueId else { return }
        guard let destination = segue.destination as? ListOfProductController else { return }
        destination.consumes = sender as? [Consume] ?? nil
    }
}
