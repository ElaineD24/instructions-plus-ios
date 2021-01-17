//
//  ImagePicker.swift
//  Instructions+
//
//  Created by Yizhang Cao on 2021-01-17.
//

import SwiftUI
import MobileCoreServices
import Alamofire


struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        var videoPath: URL?

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let mediaType = info[.mediaType] as? String,
              mediaType == (kUTTypeMovie as String),
            let uiURL = info[.mediaURL] as? URL
            else { return }
            uploadVideo(videoUrl: uiURL)
            self.parent.url = uiURL
            self.parent.isShown = false
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func uploadVideo(videoUrl: URL) { // local video file path..
            let timestamp = NSDate().timeIntervalSince1970 // just for some random name.
            let endPoint = "http://192.168.1.26:3550/videos/upload"
            
            AF.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(videoUrl, withName: "video", fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
            }, to: endPoint).responseJSON { (response) in
                debugPrint(response)
            }
        }
        
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var url: URL?
    @Binding var isShown: Bool

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

}

