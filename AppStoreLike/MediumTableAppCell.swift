//
//  MediumTableAppCell.swift
//  AppStoreLike
//
//  Created by Mizuo Nagayama on 2021/05/23.
//

import UIKit

class MediumTableAppCell: UICollectionViewCell {

    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return nameLabel
    }()

    let subheadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray6
        button.setTitle("入手", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 10
//        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setUpInternalViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpInternalViews() {
        let nameSubheadingVStack: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            return stackView
        }()

        let HStack: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.spacing = 10
            return stackView
        }()

        nameSubheadingVStack.addArrangedSubviews(self.nameLabel, self.subheadingLabel)

        HStack.addArrangedSubviews(self.imageView, nameSubheadingVStack, self.downloadButton, constraints:
                                    self.imageView.heightAnchor.constraint(equalTo: HStack.heightAnchor, multiplier: 0.8),
                                    self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor),
                                    self.downloadButton.widthAnchor.constraint(equalTo: HStack.widthAnchor, multiplier: 0.2),
                                    self.downloadButton.heightAnchor.constraint(equalTo: HStack.heightAnchor, multiplier: 0.3))

        self.contentView.addSubviews(HStack, constraints:
                                        HStack.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
                                     HStack.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
                                     HStack.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                                     HStack.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor))

    }

    func configure(app: App) {
        self.subheadingLabel.text = app.subheading
        self.nameLabel.text = app.name

        if let image = UIImage(named: app.image) {
            self.imageView.image = image
        } else {
            self.imageView.image = nil
        }
    }
}
