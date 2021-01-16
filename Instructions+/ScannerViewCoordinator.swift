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
            print("Barcode Data: \(code)")
            print("Type: \(type)")
            controller.dismiss(animated: true, completion: nil)
            ApiCall(code: code)
        }
    }

    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print("scan failed")
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        print("Dismissed!")
        controller.dismiss(animated: true, completion: nil)
    }
}
