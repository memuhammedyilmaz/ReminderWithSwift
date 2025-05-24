//
//  DaysSliderView.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 16.05.2025.
//

import UIKit
import SnapKit

class DaysVC: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let collectionView: UICollectionView
    private let dateFormatter: DateFormatter
    private let visibleItems = 5

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 60, height: 60)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "d MMM"
        super.init(frame: frame)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: Date())!
        return range.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell else {
            return UICollectionViewCell()
        }
        let calendar = Calendar.current
        let currentDate = Date()
        if let date = calendar.date(byAdding: .day, value: indexPath.row, to: calendar.startOfDay(for: currentDate)) {
            let formattedDate = dateFormatter.string(from: date)
            let isToday = calendar.isDate(date, inSameDayAs: currentDate)
            cell.configure(date: formattedDate, isToday: isToday)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = 60 * visibleItems
        let totalSpacingWidth = 8 * (visibleItems - 1)
        let inset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
}

class DayCell: UICollectionViewCell {
    private let dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dateLabel.textAlignment = .center
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.layer.cornerRadius = frame.size.width / 2
        contentView.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(date: String, isToday: Bool) {
        dateLabel.text = date
        if isToday {
            dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            dateLabel.textColor = .black
        } else {
            dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            dateLabel.textColor = .lightGray
            contentView.backgroundColor = .clear
        }
    }
}
