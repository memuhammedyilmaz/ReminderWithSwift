import UIKit
import SnapKit



class CellVC: UICollectionViewCell {
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let checkButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Container View
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Title Label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        // Subtitle Label
        subtitleLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        // Check Button
        checkButton.backgroundColor = .clear
        containerView.addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        checkButton.layer.cornerRadius = 16
        checkButton.layer.borderWidth = 2.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, subtitle: String, isChecked: Bool) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        if isChecked {
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            checkButton.tintColor = .white
            checkButton.backgroundColor = .black
            containerView.layer.borderColor = UIColor.lightGray.cgColor
            titleLabel.layer.opacity = 0.5
            subtitleLabel.layer.opacity = 0.5
        } else {
            checkButton.setTitle("", for: .normal)
        }
    }
}
  
