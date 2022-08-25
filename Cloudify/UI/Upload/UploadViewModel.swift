//
//  UploadViewModel.swift
//  Cloudify
//
//  Created by Mario Severino on 24/08/22.
//

import RxRelay

class UploadViewModel: MSViewModel {
    
    let currentImageName = BehaviorRelay<String>(value: "-")
    let currentImagePercentage = BehaviorRelay<String>(value: "-")
    let currentImageNumber = BehaviorRelay<String>(value: "-")
    let uploadDone = BehaviorRelay<Bool>(value: false)
    let items = PublishRelay<[UploadedImage]>()
    var uploadedImages: [UploadedImage] = []
    
    let uploadRepository: BaseUploadRepository
    
    private var totalNumberImages:Int = 0
    private var innerCurrentImageNumber = 0
    
    init(uploadRepository: BaseUploadRepository) {
        self.uploadRepository = uploadRepository
    }
    
    func upload(images: [ImageCompatible]) {
        
        if images.isEmpty { return }
        
        self.totalNumberImages = images.count
        
        let image = images[self.innerCurrentImageNumber]
        
        self.innerCurrentImageNumber += 1
        
        self.currentImageName.accept(image.imageName ?? "-")
        self.currentImageNumber.accept("\(self.innerCurrentImageNumber)/\(self.totalNumberImages)")
        
        self.uploadRepository.upload(image: image, maxSize: 500000)
        { [weak self] percentage in
            self?.currentImagePercentage.accept(percentage)
        } completitionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let url):
                if let uploadedImage = image.editedImage,
                   let uploadedImageName = image.imageName {
                    self.uploadedImages.append(UploadedImage(image: uploadedImage, imageName: uploadedImageName, imageUrl: url))
                }
                if self.totalNumberImages == self.innerCurrentImageNumber {
                    self.uploadDone.accept(true)
                    self.items.accept(self.uploadedImages)
                    return }
                self.upload(images: images)
            case .failure(let error):
                print(error)
            }
            
        }
                
    }

}
