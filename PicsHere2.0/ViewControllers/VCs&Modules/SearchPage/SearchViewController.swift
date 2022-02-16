//
//  ViewController.swift
//  PicsHere2.0
//
//  Created by Kostya Lee on 30/12/21.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    private let searchBar = UISearchBar()
    
    private var results: [Result] = []
    
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 2
            let size = (view.frame.width * 0.5) - 2
            layout.itemSize = CGSize(width: size, height: size * 1.5)
            return layout
        }()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        self.collectionView = collectionView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            launchFetching(for: text)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        searchBar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width - 20, height: 50)
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = CGFloat(16)

    }

    func launchFetching(for query: String) {
        results = []
        collectionView?.reloadData()
        fetchPhotos(query: query)
    }

    private func fetchPhotos(query: String) {
        guard let url = Endpoint.search(for: query).url else {
            return
        }
        URLSession.shared.dataTask(with: url) {
            [weak self] ( data, response, error) in
            guard let data = data, error == nil else { return }
            self?.decodeData(from: data)
        }.resume()
    }

    private func decodeData(from data: Data) {
        do {
            let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
            DispatchQueue.main.async {
                self.results = jsonResult.results
                self.collectionView?.reloadData()
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

extension SearchViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: results[indexPath.row].urls.small)
        return cell
    }
}
