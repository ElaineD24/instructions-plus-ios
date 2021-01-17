//
//  ScannerViewCoordinator.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//

import SwiftUI
import BarcodeScanner

class ScannerViewCoordinator: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {

    private var scannerView: ScannerView
    private var apiController: APIController

    init(_ scannerView: ScannerView) {
        self.scannerView = scannerView
        self.apiController = APIController()
    }

    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print("Barcode Data: \(code)")
            print("Type: \(type)")
            let result = self.apiController.makeBarcodeRequest(code: code)
            switch result {
                case let .success(data):
                    guard let videoUrls = data else {
                        self.scannerView.videoUrls = VideoUrls()
                        controller.dismiss(animated: true, completion: nil)
                        return
                    }
                    self.scannerView.videoUrls = videoUrls
                case .failure(_):
                    self.scannerView.videoUrls = VideoUrls()
                    controller.dismiss(animated: true, completion: nil)
                    return
                
            }
            print("barcode:", code)
            controller.dismiss(animated: true, completion: nil)
        }
    }

    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print("scan failed")
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        print("Dismissed!")
        controller.dismiss(animated: true, completion: nil)
    }
}
