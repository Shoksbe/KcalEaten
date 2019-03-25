//
//  FailPopUp.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 25/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

class FailPopUp: UIViewController {

    @IBOutlet weak var errorDescriptionLabel: UILabel!
    var callerController: UIViewController!
    var errorDescription: String?
}
//-----------------
//MARK: - LifeCycle
//-----------------
extension FailPopUp {
    override func viewDidLoad() {
        super.viewDidLoad()
        if errorDescription != nil {
            errorDescriptionLabel.text = errorDescription
        } else {
            errorDescriptionLabel.text = "Aucune erreur de trouvée"
        }
    }
}

//---------------
//MARK: - Actions
//---------------
extension FailPopUp {
    @IBAction func cancelButtonDidTap() {
        if callerController is CameraController {
            NotificationCenter.default.post(name: .popupWillDisappear, object: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
