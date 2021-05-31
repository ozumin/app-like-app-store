//
//  ViewController.swift
//  AppStoreLike
//
//  Created by Mizuo Nagayama on 2021/05/23.
//

import UIKit

enum SectionLayoutKind: Int {
    case featured
    case mediumTable
    case smallTable
}

enum SectionKind: Int {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
}

class ViewController: UIViewController {

    var sectionLayoutList: [SectionKind: SectionLayoutKind] = [:]

    lazy var collectionView: UICollectionView = {
        let layout = self.createLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(FeaturedAppCell.self, forCellWithReuseIdentifier: "FeaturedAppCell")
        collectionView.register(MediumTableAppCell.self, forCellWithReuseIdentifier: "MediumTableAppCell")
        collectionView.register(SmallTableAppCell.self, forCellWithReuseIdentifier: "SmallTableAppCell")
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    lazy var dataSource: UICollectionViewDiffableDataSource<SectionKind, App> = {
        let dataSource = UICollectionViewDiffableDataSource<SectionKind, App>(collectionView: self.collectionView) {(collectionView: UICollectionView, indexPath: IndexPath, app: App) -> UICollectionViewCell? in

            guard let sectionKind = SectionKind(rawValue: indexPath.section),
                  let layoutKind = self.sectionLayoutList[sectionKind] else { return nil }

            switch layoutKind {
            case .featured:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedAppCell", for: indexPath)
                if let cell = cell as? FeaturedAppCell {
                    cell.configure(app: app)
                }
                return cell
            case .mediumTable:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediumTableAppCell", for: indexPath)
                if let cell = cell as? MediumTableAppCell {
                    cell.configure(app: app)
                }
                return cell
            case .smallTable:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallTableAppCell", for: indexPath)
                if let cell = cell as? SmallTableAppCell {
                    cell.configure(app: app)
                }
                return cell
            }
        }
        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)

        guard let appListList = self.loadData() else { return }
        self.initSectionLayoutList(appListList: appListList)
        self.applySnapshot(appListList: appListList)

        self.view.backgroundColor = .systemBackground
    }

    func initSectionLayoutList(appListList: [AppList]) {
        for (index, appList) in appListList.enumerated() {
            guard let sectionKind = SectionKind(rawValue: index) else { return }
            switch appList.type {
            case "featured":
                self.sectionLayoutList[sectionKind] = .featured
            case "mediumTable":
                self.sectionLayoutList[sectionKind] = .mediumTable
            case "smallTable":
                self.sectionLayoutList[sectionKind] = .smallTable
            default:
                break
            }
        }
    }

    func applySnapshot(appListList: [AppList]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, App>()
        for (index, appList) in appListList.enumerated() {
            guard let sectionLayoutKind = SectionKind(rawValue: index) else { return }
            snapshot.appendSections([sectionLayoutKind])
            snapshot.appendItems(appList.items, toSection: sectionLayoutKind)
        }
        self.dataSource.apply(snapshot)
    }

    func loadData() -> [AppList]? {
        let decoder = JSONDecoder()
        if let filepath = Bundle.main.path(forResource: "appstore", ofType: "json"),
           let jsonData = try? String(contentsOfFile: filepath).data(using: .utf8),
           let parsedData = try? decoder.decode([AppList].self, from: jsonData) {
            return parsedData
        } else {
            print("Failed to load data.")
            return nil
        }
    }

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let sectionLayoutKind = SectionKind(rawValue: sectionIndex),
                  let layoutKind = self.sectionLayoutList[sectionLayoutKind] else { return nil }

            switch layoutKind {

            case .featured:

                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.75))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.orthogonalScrollingBehavior = .groupPagingCentered

                return section

            case .mediumTable:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0 / 3))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.65))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)

                let section = NSCollectionLayoutSection(group: group)

                section.orthogonalScrollingBehavior = .groupPagingCentered
                return section

            case .smallTable:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalWidth(0.45))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
        }
        return layout
    }
}

