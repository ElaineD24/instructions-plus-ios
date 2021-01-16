//
//  ScannerViewCoordinator.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//

import SwiftUI
import BarcodeScanner

class ScannerViewCoordinator: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate {

    private var scannerView: ScannerView

    init(_ scannerView: ScannerView) {
        self.scannerView = scannerView
    }

    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            // Api
            let videoUrls = VideoUrls()
            
            self.scannerView.videoUrls = videoUrls
            print("barcode:", code)
            self.scannerView.presentationMode.wrappedValue.dismiss()
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
