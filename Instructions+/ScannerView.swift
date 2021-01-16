//
//  ScannerView.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//

import SwiftUI
import BarcodeScanner

struct ScannerView: UIViewControllerRepresentable {

    func makeCoordinator() -> ScannerViewCoordinator {
        ScannerViewCoordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> BarcodeScannerViewController {
        return createAndConfigureScanner(context: context)
    }

    func updateUIViewController(_ uiViewController: BarcodeScannerViewController, context: UIViewControllerRepresentableContext<ScannerView>) {
            uiViewController.reset(animated: false)
      }

     private func createAndConfigureScanner(context: UIViewControllerRepresentableContext<ScannerView>) -> BarcodeScannerViewController {
        let barcodeVC = BarcodeScannerViewController()
        barcodeVC.codeDelegate = context.coordinator
        barcodeVC.errorDelegate = context.coordinator
        
        return barcodeVC
    }
}
