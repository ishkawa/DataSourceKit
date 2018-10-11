# DataSourceKit

Declarative, testable data source of UICollectionView and UITableView.

![](Screenshot/declarative.png)

## Installation

There are 2 ways to install DataSourceKit to your project.

### CocoaPods

Add a line `pod "DataSourceKit"` to your Podfile and run `pod install`.

### Carthage

Add a line `github "ishkawa/DataSourceKit"` to your Cartfile and run `carthage update`.

## Simple Usage

1. Let cells to conform BindableCell.
2. Let view controllers to conform CellsDeclarator.
3. Create an instance of CollectionViewDataSource and assign it to dataSource of UICollectionView.

### Let cells to conform BindableCell

To make cells available in DataSourceKit machanism, let cells to conform BindableCell. BindableCell is a protocol which provide interfaces for registering cell to UICollectionView and binding cell with value.

For example, following implementation indicates that ReviewCell will be registered by UINib named "ReviewCell" and reuse identifier "Review", and the cell will be binded with value Review.

```swift
extension ReviewCell: BindableCell {
    static func makeBinder(value review: Review) -> CellBinder {
        return CellBinder(
            cellType: ReviewCell.self,
            nib: UINib(nibName: "ReviewCell", bundle: nil),
            reuseIdentifier: "Review",
            configureCell: { cell in
                cell.authorImageView.image = review.authorImage
                cell.authorNameLabel.text = review.authorName
                cell.bodyLabel.text = review.body
            })
    }
}
```

### Let view controllers to conform CellsDeclarator

Next step is to declare arrangement of cells. CellsDeclarator is a protocol to do this.

Suppose we have following data in a view controller:

```swift
final class VenueDetailViewController: UIViewController {
    var venue = Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon")
    var reviews = [
        Review(authorImage: #imageLiteral(resourceName: "ishkawa"), authorName: "Yosuke Ishikawa", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        Review(authorImage: #imageLiteral(resourceName: "yamotty"), authorName: "Masatake Yamoto", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    ]

    var relatedVenues = [
        Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
        Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
        Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
        Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
    ]
}
```

To declare arrangement of cells, pass `makeBinder(value:)` of cells to `cell(_:)` in `declareCells(_:)`. Since call of `cell(_:)` will be converted to actual cell, call `cell(_:)` in the same order as you want to display cells.

Following example is the declaration of the demo which is displayed on the top of this page.

```swift
extension VenueDetailViewController: CellsDeclarator {
    func declareCells(_ cell: (CellBinder) -> Void) {
        cell(VenueOutlineCell.makeBinder(value: venue))

        if !reviews.isEmpty {
            cell(SectionHeaderCell.makeBinder(value: "Reviews"))
            for review in reviews {
                cell(ReviewCell.makeBinder(value: review))
            }
        }

        if !relatedVenues.isEmpty {
            cell(SectionHeaderCell.makeBinder(value: "Related Venues"))
            for relatedVenue in relatedVenues {
                cell(RelatedVenueCell.makeBinder(value: relatedVenue))
            }
        }
    }
}
```

In above code, it is assumed that VenueOutlineCell, SectionHeaderCell, ReviewCell and RelatedVenueCell conform to BindableCell protocol.

### Assign CollectionViewDataSource to dataSource of UICollectionView

Final step is creating instance of CollectionViewDataSource and assigning cell declarations to it.

```swift
final class VenueDetailViewController: UIViewController {
    ...

    @IBOutlet private weak var collectionView: UICollectionView!

    private let dataSource = CollectionViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.dataSource = dataSource

        dataSource.cellDeclarations = cellDeclarations
    }
}
```

cellDeclarations of view controller is computed from result of `declareCells(_:)` of the view controller. When cellDeclarations of dataSource is updated, dataSource is ready for returning new arrangement. Then, you can invoke update of UICollectionView by any of `reloadData()`, `reloadItems(at:)`, `insertItems(at:)` and `deleteItems(at:)`.
