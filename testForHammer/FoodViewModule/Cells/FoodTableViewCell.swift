import UIKit

enum Position {
    case first
    case last
}

class FoodTableViewCell: UITableViewCell {
    
    private let foodImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 17)
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = .lightGray
        view.numberOfLines = 3
        return view
    }()
    
    let priceBorederView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 13)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.cornerRadius = 0
    }
    
    func setupViews() {
        contentView.backgroundColor = .white
        [foodImageView, nameLabel, descriptionLabel, priceBorederView, priceLabel].forEach(contentView.addSubview(_:))
        foodImageView.anchors(top: contentView.topAnchor,
                              leading: contentView.leadingAnchor,
                              bottom: contentView.bottomAnchor,
                              trailing: nil,
                              padding: UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 0),
                              size: CGSize(width: 132, height: 132))
        nameLabel.anchors(top: contentView.topAnchor,
                          leading: foodImageView.trailingAnchor,
                          bottom: nil,
                          trailing: nil,
                          padding: UIEdgeInsets(top: 32, left: 32, bottom: 0, right: 0))
        descriptionLabel.anchors(top: nameLabel.bottomAnchor,
                                 leading: foodImageView.trailingAnchor,
                                 bottom: nil,
                                 trailing: contentView.trailingAnchor,
                                 padding: UIEdgeInsets(top: 8, left: 32, bottom: 0, right: 24))
        priceLabel.anchors(top: descriptionLabel.bottomAnchor,
                           leading: nil,
                           bottom: nil,
                           trailing: contentView.trailingAnchor,
                           padding: UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 42))
        priceBorederView.anchors(top: priceLabel.topAnchor,
                                 leading: priceLabel.leadingAnchor,
                                 bottom: priceLabel.bottomAnchor,
                                 trailing: priceLabel.trailingAnchor,
                                 padding: UIEdgeInsets(top: -8, left: -18, bottom: -8, right: -18))
    }
    
    func configCorners(position: Position) {
        switch position {
        case .first:
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            contentView.layer.cornerRadius = 16
        case .last:
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            contentView.layer.cornerRadius = 16
        }
    }
    
    func setValues(model: FoodModel) {
        foodImageView.image = UIImage(named: model.category)
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        priceLabel.text = "от \(model.price) р"
    }
}
