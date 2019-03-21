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
    private var _consumeGroupedByDate = [[Consume]]()
    private var _consumesFromCoreData: [Consume]!
    private let _coreDataService = CoreDataHelper()
    
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
            //Formatting the date in medium version and conversion to a string
            let dateString = elementDate.toString()
            //Creation of a medium date from the string
            let date = dateString.toDate()
            return date
        }

        //Sorte consume by date; key == date
        let sortedKeys = groupedConsume.keys.sorted(by: >)
        sortedKeys.forEach { (key) in
            let values = groupedConsume[key]
            _consumeGroupedByDate.append(values ?? [])
        }
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
        _consumesFromCoreData = try? _coreDataService.fetchConsume()
        attemptToAssembleGroupedConsume()
        tableview.reloadData()
    }
}

//---------------------------------------
//MARK: - Tableview dataSource & delegate
//---------------------------------------
extension ConsumeController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return _consumeGroupedByDate.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //Creating cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "consumeCell", for: indexPath) as! ConsumeCell


        //Date for consume
        let dateString = _consumeGroupedByDate[indexPath.section].first?.date?.toString() ?? ""

        //calculating the total number of calories consumed for this date
        var countOfCalorie = 0.0
        _consumeGroupedByDate[indexPath.section].forEach { (consume) in
            countOfCalorie += (consume.product?.kCalByGrams)! * Double(consume.quantity)
        }

        //calculation of the number of products consumed on this date
        var quantityOfProduct = 0
        quantityOfProduct += _consumeGroupedByDate[indexPath.section].count

        //Set cell
        cell.setup(dateString: dateString, countOfCalorie: countOfCalorie, quantityOfProduct :quantityOfProduct)

        return cell
    }
}
