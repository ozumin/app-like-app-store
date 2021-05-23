//
//  SmallTableAppCell.swift
//  AppStoreLike
//
//  Created by Mizuo Nagayama on 2021/05/23.
//

import UIKit

class SmallTableAppCell: UICollectionViewCell {

    let tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.textColor = .systemBlue
        tagLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        return tagLabel
    }()

    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        return nameLabel
    }()

    let subheadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setUpInternalViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpInternalViews() {
        self.backgroundColor = .green
        let verticalStackView: UIStackView = {
            let vertivalStackView = UIStackView()
            vertivalStackView.axis = .vertical
            vertivalStackView.distribution = .equalSpacing
            vertivalStackView.alignment = .fill
            return vertivalStackView
        }()

        verticalStackView.addArrangedSubviews(self.tagLabel, self.nameLabel, self.subheadingLabel, self.imageView, constraints:
                                                self.imageView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor),
                                              self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9 / 16))

        self.contentView.addSubviews(verticalStackView, constraints:
                                        verticalStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
                                     verticalStackView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
                                     verticalStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                                     verticalStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor))

    }

    func configure(app: App) {
        self.tagLabel.text = app.tagline
        self.subheadingLabel.text = app.subheading
        self.nameLabel.text = app.name

        if let image = UIImage(named: app.image) {
            self.imageView.image = image
        } else {
            self.imageView.image = nil
        }
    }
}
