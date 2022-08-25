//
//  UploadViewController.swift
//  Cloudify
//
//  Created by Mario Severino on 24/08/22.
//

import UIKit
import RxRelay
import RxCocoa

class UploadViewController: MSViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var uploadingLabel: UILabel!
    @IBOutlet var currentImageNumberLabel: UILabel!
    @IBOutlet var currentImageNameLabel: UILabel!
    @IBOutlet var currentImagePercentageLabel: UILabel!
    @IBOutlet var uploadingView: UIView!
    
    var viewModel: UploadViewModel!
    var images: [ImageCompatible]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.bindData()
        
        if let images = self.images {
            self.viewModel.upload(images: images)
        }
    }
    
    private func configureUI() {
        self.uploadingLabel.text = "upload.image.title".localized
        
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.tableView.register(UINib(nibName: "UploadedImageTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
    }
    
    private func bindData() {
        self.viewModel.currentImageName
            .bind(to: self.currentImageNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.currentImageNumber
            .bind(to: self.currentImageNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.currentImagePercentage
            .bind(to: self.currentImagePercentageLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.uploadDone
            .bind { [weak self] done in
                if done {
                    self?.uploadingView.removeFromSuperview()
                }
            }
            .disposed(by: disposeBag)
                
        self.viewModel.items.bind(to: self.tableView.rx.items(cellIdentifier: "cellId", cellType: UploadedImageTableViewCell.self)) { (row,item,cell) in
            cell.item = item
            cell.selectionStyle = .none
        }.disposed(by: self.disposeBag)
                
        self.tableView.rx.modelSelected(UploadedImage.self).subscribe(onNext: { [weak self] uploadedImage in
            self?.copyUrl(url: uploadedImage.imageUrl)
        }).disposed(by: self.disposeBag)
    }
    
    private func copyUrl(url: String) {
        UIPasteboard.general.string = url
        
        let alertController = UIAlertController(title: "alert.copy.title".localized, message: "alert.copy.message".localized, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true)
    }

}

extension UploadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}
