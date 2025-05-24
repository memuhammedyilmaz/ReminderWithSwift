import UIKit
import SnapKit

class CellVC: UICollectionViewCell {
    let containerView = UIView()
    var reminderId: UUID?
    let titleLabel = UILabel()
    let complitedCheckedLabel = UILabel()
    let checkButton = UIButton()
    var onReminderTapped: ((UUID) -> Void)?
    private let homeVM: HomeVM = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }

        complitedCheckedLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        containerView.addSubview(complitedCheckedLabel)
        complitedCheckedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.trailing.equalToSuperview().offset(-16)
        }

        checkButton.addTarget(self, action: #selector(checkReminder), for: .touchUpInside)
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

    func configure(id: UUID, title: String, complitedChecked: String, isChecked: Bool) {
        reminderId = id
        titleLabel.text = title
        complitedCheckedLabel.text = complitedChecked

        if isChecked {
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            checkButton.tintColor = .white
            checkButton.backgroundColor = .black
            containerView.layer.borderColor = UIColor.lightGray.cgColor
            titleLabel.layer.opacity = 0.5
            complitedCheckedLabel.layer.opacity = 0.5

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let currentTime = dateFormatter.string(from: Date())
            complitedCheckedLabel.text = "Completed: \(currentTime)"
        } else {
            checkButton.setImage(nil, for: .normal)
            checkButton.backgroundColor = .clear
            containerView.layer.borderColor = UIColor.black.cgColor
            titleLabel.layer.opacity = 1.0
            complitedCheckedLabel.layer.opacity = 1.0
        }
    }

    @objc private func checkReminder() {
        guard let id = reminderId else { return }
        homeVM.toggleCheck(for: id)
        onReminderTapped?(id)
    }
}
