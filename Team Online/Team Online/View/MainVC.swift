//
//  ViewController.swift
//  Team Online
//
//  Created by Burak Altunoluk on 29/09/2022.
//

import UIKit

final class MainVC: UIViewController {
    
    private var elementListViewModel = ElementListViewModel()
    @IBOutlet private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementListViewModel.setup()
    }
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementListViewModel.rowNumberSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionViewCell
        
        cell.cellImageView.frame = elementListViewModel.sizeOfPictureInCell(tableCell: cell)
        cell.cellImageView.image = elementListViewModel.elementAtIndex(indexPath.row).image
        cell.cellTitle.text = elementListViewModel.elementAtIndex(indexPath.row).title
        cell.layer.cornerRadius = 5
        return cell
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return elementListViewModel.sizeOfElement()
    }
}

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: elementListViewModel.elementList[indexPath.row].title, sender: nil)
    }
}
