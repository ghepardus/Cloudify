//
//  BaseUploadRepository.swift
//  Cloudify
//
//  Created by Mario Severino on 24/08/22.
//

protocol BaseUploadRepository {
    func upload(image: ImageCompatible,
                maxSize: Int, //Byte
                progresHandler: @escaping (String) -> Void,
                completitionHandler: @escaping (Result<String, Error>) -> Void)
}
