//
//  BuildingsFilterCell.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 31.01.2024.
//

import UIKit

typealias BuildingsFilterCellConfig = CollectionConfigurator<BuildingsFilterCell, BuildingsFilterCellViewModel>

final class BuildingsFilterCell: UITableViewCell, CellContentConfiguatorProtocol {
    typealias ViewModel = BuildingsFilterCellViewModel
    
    private lazy var collectionView: BaseCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0,
                                               left: Specs.constraints.smallConstraint,
                                               bottom: 0,
                                               right: Specs.constraints.smallConstraint)
        flowLayout.minimumLineSpacing = Specs.constraints.mediumConstraint
        flowLayout.scrollDirection = .horizontal
        let collectionView = BaseCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.setup()
        collectionView.register(ChipsFilterCell.self, 
                                forCellWithReuseIdentifier: ChipsFilterCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAppearance()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        layout()
        
    }
    
    private func layout() {
        contentView.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    func setup(with viewModel: ViewModel) {
        let dataSource = makeDataSource(from: viewModel)
        collectionView.update(dataSource: dataSource)
        collectionView.reloadData()
    }
    
    private func makeDataSource(from viewModels: ViewModel) -> CollectionDataSource {
        var dataSource = CollectionDataSource()
        var section = CollectionSection(header: nil, footer: nil)
        
        for viewModel in viewModels.filters {
            var row = ChipsFilterCell.makeCell(item: viewModel)
            row.onSelectWithCell = { cell in
                DispatchQueue.main.async {
                    if cell.counter % 2 == 0 {
                        cell.frontContentView.backgroundColor = .primary
                        cell.counter += 1
                    } else {
                        cell.frontContentView.backgroundColor = .secondaryBackground
                        cell.counter = 0
                    }
                }
                viewModels.onSelect.perform(with: viewModel.type)
            }
            section.add(row: row)
            section.lineSpacing = Specs.constraints.smallConstraint
        }
        dataSource.add(section: section)
        return dataSource
    }
    
    static func cellHeight() -> CGFloat { UITableView.automaticDimension }
    
    static func makeCell(item: ViewModel) -> TableRow {
        TableRow(reuseIdentifier: identifier,
                 config: BuildingsFilterCellConfig(item: item), 
                 height: cellHeight())
    }
}
