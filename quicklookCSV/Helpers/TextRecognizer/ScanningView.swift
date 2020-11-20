//  Created by Martin Mitrevski on 15.06.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import SwiftUI
import UIKit
import VisionKit
import Combine

struct ScanningView: UIViewControllerRepresentable {
    
    @Binding var recognizedText: String
    @EnvironmentObject var controlCenter: ControlCenter
    
    typealias UIViewControllerType = VNDocumentCameraViewController
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(recognizedText: $recognizedText, controlCenter: _controlCenter)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScanningView>) -> VNDocumentCameraViewController {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = context.coordinator
        return documentCameraViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<ScanningView>) {
        
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        @EnvironmentObject var controlCenter: ControlCenter
        var recognizedText: Binding<String>
        private let textRecognizer: TextRecognizer
        
        init(recognizedText: Binding<String>, controlCenter: EnvironmentObject<ControlCenter>) {
            self.recognizedText = recognizedText
            textRecognizer = TextRecognizer(recognizedText: recognizedText)
            _controlCenter = controlCenter
        }
                
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            var images = [CGImage]()
            for pageIndex in 0 ..< scan.pageCount {
                let image = scan.imageOfPage(at: pageIndex)
                if let cgImage = image.cgImage {
                    images.append(cgImage)
                }
            }
            textRecognizer.recognizeText(from: images, control: controlCenter)
            controller.navigationController?.popViewController(animated: true)
        }
        
    }

}
