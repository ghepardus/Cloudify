//
//  UploadRepository.swift
//  Cloudify
//
//  Created by Mario Severino on 24/08/22.
//

import UIKit
import Alamofire

class UploadRepository: BaseUploadRepository {

    func upload(image: ImageCompatible,
                maxSize: Int,
                progresHandler: @escaping (String) -> Void,
                completitionHandler: @escaping (Result<String, Error>) -> Void) {
        if let editedImage = image.editedImage,
           let imageData = editedImage.reduceImageData(maxSize: maxSize) {
            
            AF.upload(multipartFormData: { multipart in
                multipart.append("fileupload".data(using: .utf8)!, withName: "reqtype")
                multipart.append(imageData, withName: "fileToUpload", fileName: "file.jpeg", mimeType: "image/jpeg")
            }, to: "https://catbox.moe/user/api.php")
            .uploadProgress(queue: .main, closure: { progress in
                let percentage = Int(progress.fractionCompleted * 100)
                progresHandler("\(percentage) %")
            })
            .responseString(completionHandler: { data in
                switch data.result {
                case .success(let value):
                    completitionHandler(.success(value))
                case let .failure(error):
                    completitionHandler(.failure(error))
                }
            })
        }
    }
    
}
