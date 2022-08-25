//
//  MockUploadRepository.swift
//  Cloudify
//
//  Created by Mario Severino on 24/08/22.
//

import UIKit

class MockUploadRepository: BaseUploadRepository {
    
    func upload(image: ImageCompatible,
                maxSize: Int = 500000,
                progresHandler: @escaping (String) -> Void,
                completitionHandler: @escaping (Result<String, Error>) -> Void) {
        
    }
    

}
