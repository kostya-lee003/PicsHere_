//
//  NetworkManager.swift
//  PicsHere2.0
//
//  Created by Kostya Lee on 02/01/22.
//

import UIKit

class NetworkCollectionViewManager: UICollectionViewController {
    
    internal var results: [Result] = []
    
    init(collectionVL: UICollectionViewLayout) {
        super.init(collectionViewLayout: collectionVL)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
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
