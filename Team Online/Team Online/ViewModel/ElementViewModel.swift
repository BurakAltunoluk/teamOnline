//
//  MainScrenViewModel.swift
//  Team Online
//
//  Created by Burak Altunoluk on 01/10/2022.
//

import Foundation
import UIKit

struct MainViewModel {
    var mainElement: MainPageElement
    
    var title: String {
        return self.mainElement.title
    }
    
    var image: UIImage {
        return self.mainElement.image
    }
    
    init(_ element: MainPageElement){
        self.mainElement = element
    }
    
}

struct ElementListViewModel {
    var elementList =  [MainPageElement]()
    
    mutating func addElementListArray(title: String) {
        self.elementList.append(MainPageElement(title: title, image: UIImage(named: title)!))
    }
    
    mutating func setup() {
        addElementListArray(title: "Staff")
        addElementListArray(title: "Jobs")
        addElementListArray(title: "Clients")
        addElementListArray(title: "Payments")
        
    }
    
    
    func rowNumberSection() -> Int {
      return self.elementList.count
    }
                 
    func elementAtIndex(_ index: Int) -> MainViewModel {
        let element = self.elementList[index]
        return MainViewModel(element)
    }
    
    func sizeOfElement() -> CGSize {
        let x = UIScreen.main.bounds.width
        return CGSize(width: x / 2 - 20, height: x / 2 - 20)
    }
    
    func sizeOfPictureInCell(tableCell: UICollectionViewCell) -> CGRect {
        let cellWidth = tableCell.bounds.width
        let x = UIScreen.main.bounds.width
        return CGRect(x: Int(cellWidth) / 4, y: Int(cellWidth) / 4 - 20, width: Int(x) / 4, height: Int(x) / 4)
    }
    
}


