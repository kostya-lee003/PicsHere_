//
//  RecommendationsViewController.swift
//  PicsHere2.0
//
//  Created by Kostya Lee on 30/12/21.
//

import UIKit

class RecommendationsViewController: NetworkCollectionViewManager {
    
    private let recommendations = ["sport", "music", "news", "art", "games", "races", "animals"]

    init() {
        super.init(collectionVL: RecommendationsViewController.createLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 20
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.2)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 20
                
                section.orthogonalScrollingBehavior = .continuous
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.7)))
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 40, leading: 14, bottom: 0, trailing: 5)

                return section
            }
        }
        layout.configuration.scrollDirection = .vertical
        return layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        navigationItem.title = "Recommendations"
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: RecommendationsViewController.createLayout())
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(RecCollectionViewCell.self, forCellWithReuseIdentifier: RecCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

}

extension RecommendationsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? recommendations.count : results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            cell.CustomImageView.image = UIImage(named: recommendations[indexPath.row])
            cell.setupImageView()
            return cell
        } else {
            let imageUrlString = results[indexPath.row].urls.small
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecCollectionViewCell.identifier, for: indexPath) as? RecCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: imageUrlString)
            return cell
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            launchFetching(for: recommendations[indexPath.row])
        } else {
            print("Selected cyan")
        }
    }
}

