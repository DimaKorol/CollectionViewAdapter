//
//  ViewController.swift
//  Test
//
//  Created by Dima Korolev on 18/09/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import UIKit
import CollectionViewAdapter

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var manager : DelegateCellManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = DelegateCellManager(collectionView: collectionView)
        manager?.addBinder(0, cellViewBinder: SmallCellBinder(), shouldRegisterCellId: false)
        manager?.addBinder(1, cellViewBinder: BigCellBinder(), shouldRegisterCellId: false)
        manager?.addBinder(2, cellViewBinder: TextCellBinder(), shouldRegisterCellId: false)
        manager?.addBinder(3, cellViewBinder: ProgramCell(), shouldRegisterCellId: true)
        manager?.setData(getTestData())
    }
    
    func getTestData() -> [CellDataHolder]{
        var data = [CellDataHolder]()
        data.append(CellDataHolder(type: 1, data: UIColor.red))
        data.append(CellDataHolder(type: 3, data: ""))
        data.append(CellDataHolder(type: 3, data: ""))
        data.append(CellDataHolder(type: 0, data: ""))
        data.append(CellDataHolder(type: 0, data: ""))
        data.append(CellDataHolder(type: 0, data: ""))
        data.append(CellDataHolder(type: 2, data: ""))
        data.append(CellDataHolder(type: 1, data: UIColor.yellow))
        data.append(CellDataHolder(type: 1, data: UIColor.blue))
//        data.append(CellDataHolder(type: 2, data: ""))
        data.append(CellDataHolder(type: 0, data: ""))
        data.append(CellDataHolder(type: 0, data: ""))
        data.append(CellDataHolder(type: 0, data: ""))
        data.append(CellDataHolder(type: 1, data: UIColor.orange))
        data.append(CellDataHolder(type: 2, data: ""))
        data.append(CellDataHolder(type: 2, data: ""))
        data.append(CellDataHolder(type: 1, data: UIColor.black))
        return data
    }
    
}


class SmallCellBinder : UICollectionViewCell, CellViewBinder{
    var cellId: String {
        return "smallCell"
    }
    
    var cellClass: AnyClass {
        return type(of: self)
    }
    
    func bindData(_ cell: UICollectionViewCell, cellData: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10
        return CGSize(width: width , height: width)
    }
}

class BigCellBinder : UICollectionViewCell, CellViewBinder{
    var cellId: String {
        return "bigCell"
    }
    
    var cellClass: AnyClass {
        return type(of: self)
    }
    
    func bindData(_ cell: UICollectionViewCell, cellData: Any) {
        (cell as? BigCellBinder)?.contentView.backgroundColor = cellData as? UIColor
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width , height: 200)
    }
}

class TextCellBinder : UICollectionViewCell, CellViewBinder{
    var cellId: String {
        return "textCell"
    }
    
    var cellClass: AnyClass {
        return type(of: self)
    }
    
    var cellAutoSize: Bool = true
//
    var cellSize: ContentSize = ContentSize.WrapContent()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(_ cell: UICollectionViewCell, cellData: Any) {
        (cell as? BigCellBinder)?.contentView.backgroundColor = cellData as? UIColor
        
        (self.contentView.subviews.first as? UILabel)?.preferredMaxLayoutWidth = 200
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width , height: 100)
    }
}

class ProgramCell : DelegateCollectionCell{
    override var cellId: String {
        return "programCell"
    }
    
    override func awakeFromNib() {
        let label = UILabel()
        label.text = "Program"
        self.contentView.addSubview(label)
    }
    
    override func bindData(_ cellData: Any) {
        self.contentView.backgroundColor = UIColor.cyan
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 10
        return CGSize(width: width , height: width)
    }
}


