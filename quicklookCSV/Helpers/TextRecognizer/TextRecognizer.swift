//  Created by Martin Mitrevski on 15.06.19.

import Vision
import SwiftUI
import Combine
//https://bendodson.com/weblog/2019/06/11/detecting-text-with-vnrecognizetextrequest-in-ios-13/

public struct TextRecognizer {
    @EnvironmentObject var controlCenter:ControlCenter
    @Binding var recognizedText: String
    
    private let textRecognitionWorkQueue = DispatchQueue(label: "TextRecognitionQueue",
                                                         qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    func recognizeText(from images: [CGImage], control: ControlCenter) {
        
        self.recognizedText = ""
        var tmp = ""
        let textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("The observations are of an unexpected type.")
                return
            }
            // Concatenate the recognised text from all the observations.
            let maximumCandidates = 1
            for observation in observations {
                guard let candidate = observation.topCandidates(maximumCandidates).first else { continue }
//                tmp += candidate.string + "\n"
                tmp += candidate.string + " "
            }
        }
       
        textRecognitionRequest.recognitionLevel = .accurate
        for image in images {
            let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
            
            do {
                try requestHandler.perform([textRecognitionRequest])
            } catch {
                print(error)
            }
          //  tmp += "\n\n"
           // tmp += " "
        }
        if control.addItemTextScan == true {
        control.AddItem[control.currentKey] = tmp
        }
        control.searchTerm = tmp.trimmingCharacters(in: CharacterSet.whitespaces)
        self.recognizedText = tmp.trimmingCharacters(in: CharacterSet.whitespaces)
        print(self.recognizedText)
        control.isShowingScanner = false
    }
    
}
