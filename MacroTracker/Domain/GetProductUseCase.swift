//
//  GetProductUseCase.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 17/09/2024.
//

import Foundation
import Combine

final class GetProductUseCase {
    private let repository = ProductRepository()

    // https://github.com/twostraws/CodeScanner
    func execute(barcode: String) -> AnyPublisher<ProductResponse, Error> {
        return repository.getProduct(barcode: barcode)
    }
}

//    @State private var isShowingScanner = true

//    private func handleScan(result: Result<ScanResult, ScanError>) {
//        isShowingScanner = false
//        switch result {
//            case .success(let result):
//                viewModel.loadProduct(barcode: result.string)
//            case .failure(let error):
//                print("Scanning failed: \(error.localizedDescription)")
//        }
//    }

//        .sheet(isPresented: $isShowingScanner) {
//            CodeScannerView(codeTypes: [.ean13], scanMode: .once, simulatedData: "3017620422003", shouldVibrateOnSuccess: true, videoCaptureDevice: .default(for: .video), completion: handleScan)
//        }

