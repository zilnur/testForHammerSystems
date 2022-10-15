//
//  CategoryCollectionViewCell.swift
//  testForHammer
//
//  Created by Ильнур Закиров on 15.10.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let categotyName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemPink
        view.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        view.textAlignment = .center
        return view
    }()
    
    var name: String? {
        didSet {
            if name == "pizza" {
                categotyName.text = "Пицца"
            } else if name == "rolls" {
                categotyName.text = "Роллы"
            } else if name == "dessert" {
                categotyName.text = "Десерт"
            } else if name == "drink" {
                categotyName.text = "Напитки"
            } else {
                print(name)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override var isSelected: Bool {
        didSet {
            categotyName.font = isSelected ? UIFont.systemFont(ofSize: 13, weight: .bold) : UIFont.systemFont(ofSize: 13, weight: .medium)
            contentView.backgroundColor = isSelected ? UIColor(named: "lightPink") : .white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
        contentView.addSubview(categotyName)
        [categotyName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         categotyName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ].forEach {$0.isActive = true}
    }
    
    func setValues(model: FoodModel) {
        name = model.category
    }
}
