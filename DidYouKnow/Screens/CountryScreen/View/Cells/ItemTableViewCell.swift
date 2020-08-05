//
//  ItemTableViewCell.swift
//  DidYouKnow
//
//  Created by Rajasekhar on 05/08/20.
//  Copyright © 2020 Rajasekhar. All rights reserved.
//

import UIKit
import Anchorage
import SDWebImage

class ItemTableViewCell: UITableViewCell {
    var item: ItemModel?
    let avatarView: AvatarView = {
        let avatarView = AvatarView(frame: .zero)
        avatarView.contentMode = .scaleAspectFill
        avatarView.clipsToBounds = true
        avatarView.backgroundColor = .white
        return avatarView
    }()
    let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    func configureCell(item: ItemModel?) {
        self.item = item
        self.contentView.addSubview(avatarView)
        self.contentView.addSubview(itemTitleLabel)
        avatarView.leadingAnchor == contentView.leadingAnchor + 8
        avatarView.widthAnchor == 50.0
        avatarView.heightAnchor == 50.0
        avatarView.centerYAnchor == contentView.centerYAnchor
        avatarView.topAnchor >= contentView.topAnchor + 8
        itemTitleLabel.leadingAnchor == avatarView.trailingAnchor + 8
        itemTitleLabel.topAnchor == contentView.topAnchor + 8
        itemTitleLabel.trailingAnchor == contentView.trailingAnchor - 8
        itemTitleLabel.bottomAnchor == contentView.bottomAnchor - 8
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        avatarView.image = nil
        if let url = URL(string: item?.imageHref ?? "") {
            avatarView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            avatarView.sd_setImage(with: url,
                                   placeholderImage: nil,
                                   options: [],
                                   progress: nil) { [weak self] (image, _, _, _) in
                                    if image == nil {
                                        self?.avatarView.image = UIImage(named: "noimage")
                                    }
            }
        }
        else {
            avatarView.image = UIImage(named: "noimage")
        }
        var str = String()
        if let title = item?.title {
            str = title
        }
        let titleStr = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        let description =
            NSAttributedString(string: ( item?.description ?? "").isEmpty ? "" : "\n" + (item?.description ?? ""),
                               attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)])
        titleStr.append(description)
        itemTitleLabel.attributedText = titleStr
    }
}
