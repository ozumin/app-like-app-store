//
//  SmallTableAppCell.swift
//  AppStoreLike
//
//  Created by Mizuo Nagayama on 2021/05/23.
//

import UIKit

class SmallTableAppCell: UICollectionViewCell {

    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return nameLabel
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
        self.contentView.addSubviews(self.imageView, self.nameLabel, constraints:
                                        self.imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
                                     self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9 / 16),
                                     self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 5),
                                     self.nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                                     self.nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor))

    }

    func configure(app: App) {
        self.nameLabel.text = app.name

        if let image = UIImage(named: app.image) {
            self.imageView.image = image
        } else {
            self.imageView.image = nil
        }
    }
}
