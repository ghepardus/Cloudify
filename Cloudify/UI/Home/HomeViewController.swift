//
//  HomeViewController.swift
//  Cloudify
//
//  Created by Mario Severino on 22/08/22.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import RxDataSources

class HomeViewController: MSViewController {
    
    @IBOutlet var countryTitleLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var photoTitleLabel: UILabel!
    @IBOutlet var countryListButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var loadButton: UIButton!
    @IBOutlet var uploadButton: UIButton!
    

    private var pickerController: UIImagePickerController?
    weak var coordinator: MainCoordinator?
    var viewModel: HomeViewModel!
    
    private var selectedImages = BehaviorRelay<[ImageCompatible]>(value: [])
    private var selectionResult = BehaviorRelay<CountryCompatible?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.bindData()
    }
    
    private func configureUI() {
        self.countryLabel.text = "home.no.contry".localized
        self.countryTitleLabel.text = "home.contry.title".localized
        self.countryListButton.setCustomTitle(title: "home.contry.list.button".localized)
        self.loadButton.setCustomTitle(title: "home.load.button".localized)
        self.uploadButton.setCustomTitle(title: "home.upload.button".localized)
        
        self.collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
    }
    
    private func bindData() {
        
        self.selectionResult
            .map { country in country?.countryName }
            .skip(1)
            .bind(to: self.countryLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.countryListButton
            .rx
            .tap
            .bind { [weak self] in self?.coordinator?.showCountryList(selection: self?.selectionResult) }
            .disposed(by: disposeBag)
        
        
        self.countryLabel
            .rx
            .observe(String.self, "text")
            .map({ text in
                    text != "home.no.contry".localized
            })
            .bind(to: self.loadButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        self.loadButton
            .rx
            .tap
            .bind { [weak self] in self?.chooseImagePickerType() }
            .disposed(by: disposeBag)
        
        self.uploadButton
            .rx
            .tap
            .bind { [weak self] in self?.upload() }
            .disposed(by: disposeBag)
        
        self.selectedImages
            .bind(to: self.collectionView.rx.items(cellIdentifier: "cellId", cellType: PhotoCollectionViewCell.self)) { (row,item,cell) in
                cell.photo.image = item.editedImage
            }
            .disposed(by: disposeBag)
        
        self.selectedImages
            .map({ !$0.isEmpty })
            .bind(to: self.uploadButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    
    private func chooseImagePickerType() {
        self.pickerController = UIImagePickerController()
        self.pickerController?.delegate = self
        self.pickerController?.allowsEditing = true
        self.pickerController?.mediaTypes = ["public.image"]
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(UIAlertAction(title: "alert.picker.camera".localized, style: .default) { [weak self] _ in
                self?.pickerController?.sourceType = .camera
                self?.loadImages()
            })
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(UIAlertAction(title: "alert.picker.photoLibrary".localized, style: .default) { [weak self] _ in
                self?.pickerController?.sourceType = .photoLibrary
                self?.loadImages()
            })
        }

        alertController.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = self.loadButton
            alertController.popoverPresentationController?.sourceRect = self.loadButton.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.present(alertController, animated: true)

    }
    
    private func loadImages() {
        guard let pickerController = pickerController else {
            return
        }
        self.present(pickerController, animated: true)
    }
    
    private func selectedImage(imageInfo: [UIImagePickerController.InfoKey : Any]) {
        var images = self.selectedImages.value
        images.append(PhotoImage(imageInfo: imageInfo))
        self.selectedImages.accept(images)
    }
    
    private func upload() {
        self.coordinator?.upload(images: self.selectedImages.value)
    }

}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.selectedImage(imageInfo: info)
        picker.dismiss(animated: true)
    }
}
