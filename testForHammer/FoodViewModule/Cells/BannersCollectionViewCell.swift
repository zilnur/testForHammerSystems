//
//  BannersCollectionViewCell.swift
//  testForHammer
//
//  Created by Ильнур Закиров on 15.10.2022.
//

import UIKit

class BannersCollectionViewCell: UICollectionViewCell {
    
    let bannerImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "banner"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(bannerImageView)
        bannerImageView.anchors(top: contentView.topAnchor,
                                leading: contentView.leadingAnchor,
                                bottom: contentView.bottomAnchor,
                                trailing: contentView.trailingAnchor)
    }
}
