//
//  CategoryCell.swift
//  PicsHere2.0
//
//  Created by Kostya Lee on 01/01/22.
//

import Foundation
import UIKit

class CategoryCell: UICollectionViewCell {
    var CustomImageView = UIImageView()
    static let identifier = "CategoryCell"

//    var label: UILabel {
//        let label = UILabel(frame: CGRect(x: self.frame.size.width * 0.24 , y: 50, width: 100, height: 100))
//        label.text = "title"
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.textColor = .darkGray
//        return label
//    }
    func setupImageView() {
        addSubview(CustomImageView)
        CustomImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        CustomImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        CustomImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        CustomImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.CustomImageView.contentMode = .scaleAspectFit
        self.layer.accessibilityPath?.stroke(with: .color, alpha: 1)
        self.tintColor = .systemGray
    }

    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        CustomImageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        CustomImageView.image = nil
    }
}
