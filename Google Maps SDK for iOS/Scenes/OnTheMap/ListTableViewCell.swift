//
//  ListTableViewCell.swift
//  optima
//
//  Created by Тауекел on 16.01.2024.
//

import UIKit
import SnapKit

final class ListTableViewCell: UITableViewCell {
    // MARK: - Properties
    var item: Item? {
        didSet {
            itemImage.image = AppImages(
                rawValue: item?.logoImage ?? "terminal"
            )?.uiImage
            titleLabel.text = item?.title
            subtitleLabel.text = item?.subtitle
            distanceLabel.text = item?.distance
        }
    }
    var hidesTopSeparator = false
    var hidesBottomSeparator = false
    
    private func updateSeparatorVisibility() {
        let topSeparator = subviews.first {
            $0.frame.minY == 0 && $0.frame.height <= 1
        }
        let bottomSeparator = subviews.first {
            $0.frame.minY >= bounds.maxY - 1 && $0.frame.height <= 1
        }
        topSeparator?.isHidden = hidesTopSeparator
        bottomSeparator?.isHidden = hidesBottomSeparator
    }
    
    // MARK: - UI
    private lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = AppColor.black.uiColor
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.primaryGrey.uiColor
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var distanceView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = AppColor.primaryGreyMid.uiColor
        return view
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.primaryDark.uiColor
        label.font = AppFont.medium.s12()
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSeparatorVisibility()
        distanceView.layer.cornerRadius = 12
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(subtitleLabel)
        distanceView.addSubview(distanceLabel)
        addSubview(itemImage)
        addSubview(infoStack)
        addSubview(distanceView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        itemImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
            make.height.width.equalTo(40)
        }
        infoStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(itemImage.snp.trailing).offset(16)
        }
        distanceView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(distanceView.snp.top).offset(4)
            make.bottom.equalTo(distanceView.snp.bottom).offset(-4)
            make.leading.equalTo(distanceView.snp.leading).offset(8)
            make.trailing.equalTo(distanceView.snp.trailing).offset(-8)
        }
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.item = nil
    }
}
