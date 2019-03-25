//
//  CameraController.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 12/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import AVFoundation
import UIKit

//---------------------------
//MARK: - Variables & Outlets
//---------------------------
class CameraController: UIViewController {

    @IBOutlet weak var activityController: UIActivityIndicatorView!

    private var _captureSession: AVCaptureSession!
    private var _previewLayer: AVCaptureVideoPreviewLayer!
    private var _coreDataService = CoreDataHelper()
    private var _service = OpenFoodFactService()
}

//---------------
//MARK: - Methods
//---------------
extension CameraController {

    @objc private func launchCaptureSession() {
        _captureSession.startRunning()
    }
    
    private func configureSession() {
        _captureSession = AVCaptureSession()

        //Setup input
        if let videoCaptureDevice = AVCaptureDevice.default(for: .video),
            let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) {
            _captureSession.addInput(videoInput)

            //Setup output
            let metadataOutput = AVCaptureMetadataOutput()
            _captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.global(qos: .userInitiated))
            metadataOutput.metadataObjectTypes = [.ean13]

            //Setup layer
            _previewLayer = AVCaptureVideoPreviewLayer(session: _captureSession)
            _previewLayer.frame = view.layer.bounds
            _previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(_previewLayer)
            
            _captureSession.startRunning()
        } else {
            failed()
        }
    }

    private func failed() {
        let action = UIAlertController(title: "Scan non supporté", message: "Votre appareil ne supporte pas la lecture d'un code barre, veuillez utilisez un appareil avec une caméra.", preferredStyle: .alert)
        action.addAction(UIAlertAction(title: "OK", style: .default))
        present(action, animated: true)
        _captureSession = nil
    }

    ///Get product with barcode from database or openfoodfact
    private func getProduct(from barCode: String) {

        DispatchQueue.main.async {
            self.activityController.startAnimating()
            self.view.bringSubviewToFront(self.activityController)
        }

        if let productRequest = try? _coreDataService.fetchProduct(from: barCode),
            let product = productRequest {
            DispatchQueue.main.async {
                self.activityController.stopAnimating()
                SHOW_PRODUCT_PAGE(product: product, controller: self)
            }
        } else {
            _service.getProduct(from: barCode) { (success, product, error) in
                self.activityController.stopAnimating()
                guard error == nil,
                    let product = product else {
                        SHOW_FAIL_POPUP(errorDescription: error!.localizedDescription, controller: self)
                        return
                }
                SHOW_PRODUCT_PAGE(product: product, controller: self)
            }
        }
    }
}

//------------------
//MARK: - Lifecycles
//------------------
extension CameraController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSession()
        NotificationCenter.default.addObserver(self, selector: #selector(launchCaptureSession), name: .popupWillDisappear, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (_captureSession?.isRunning == false) {
            _captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (_captureSession?.isRunning == true) {
            _captureSession.stopRunning()
        }
    }
}

//---------------------------------
//MARK: - Capture metadata delegate
//---------------------------------
extension CameraController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        _captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let barCodeString = readableObject.stringValue else { return }
            getProduct(from: barCodeString)
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}
