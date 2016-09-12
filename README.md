# CollectionViewAdapter

This framework makes easier process of setting up collection view. Whole logic such as calculating size 
and binding data was moved to cell. Now each cell will provide own height.

Also added features like auto size (with autolayouts), vertical and horizontal margin.

> Favor composition over inheritance

The main idea is that you define an `CellViewBinder` for each data type (`CellDataHolder`). 
You just need register `CellViewBinder` in `DelegateCellManager` and 
manager will provide compatible `CellViewBinder` according data type.

# Example

In controller:

```swift
        let manager = DelegateCellManager(collectionView: collectionView)
        manager?.addBinder(Type.Small, cellViewBinder: SmallCellBinder(), shouldRegisterClass: false)
        manager?.addBinder(Type.Big, cellViewBinder: BigCellBinder(), shouldRegisterClass: false)
        manager?.addBinder(Type.Scroll, cellViewBinder: ScrollCellBinder(), shouldRegisterClass: true)
        
        var data = [CellDataHolder]()
        data.append(CellDataHolder(type: Type.Small, data: UIColor.redColor()))
        data.append(CellDataHolder(type: Type.Scroll, data: "Hello"))
        data.append(CellDataHolder(type: Type.Big, data: UIImage(named: "example")))
        data.append(CellDataHolder(type: Type.Small, data: UIColor.blueColor()))
        
        manager?.setData(data)
```
One of `CellViewBinder`s:

```swift
class BigCellBinder : CellViewBinder{
    var cellId: String {
        return "bigCell"
    }
    
    var cellClass: AnyClass {
        return BigCell.self
    }
    
    var cellAutoSize: Bool = true
    
    var cellSize: ContentSize = ContentSize.WrapContent()
    
    var cellMarginVertical: CGFloat = 10
    
    func bindData(cell: UICollectionViewCell, cellData: Any) {
        (cell as? BigCell)?.view.backgroundColor = cellData as? UIColor
    }
    
    or
    
    func collectionView(
      collectionView: UICollectionView, 
      layout collectionViewLayout: UICollectionViewLayout, 
      sizeForItemAtIndexPath indexPath: NSIndexPath) 
      -> CGSize 
    {
        let width = collectionView.frame.width
        return CGSizeMake(width , 200)
    }
}
```

In AutoSize mode `cellSize` is possible to be: `ContentSize.MatchContent()`, `ContentSize.WrapContent()` 
or `ContentSize.FixedSize(width: CGFloat, height: CGFloat)`

# Insperation

Android library: [AdapterDelegates](https://github.com/sockeqwe/AdapterDelegates) by Hannes Dorfmann
