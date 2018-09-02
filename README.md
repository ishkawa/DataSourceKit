# DataSourceKit

Declarative, testable data source of UICollectionView and UITableView.

![](Screenshot/declarative.png)

## Usage

### Define kinds of cells in CellDeclaration

```swift
enum CellDeclaration: Equatable {
    case outline(Venue)
    case sectionHeader(String)
    case review(Review)
    case relatedVenue(Venue)
}
```

### Convert state to [CellDeclaration]

```swift
struct Data: CellsDeclarator {
    var venue: Venue
    var reviews: [Review]
    var relatedVenues: [Venue]

    func declareCells(_ cell: (CellDeclaration) -> Void) {
        cell(.outline(venue))

        if !reviews.isEmpty {
            cell(.sectionHeader("Reviews"))
            for review in reviews {
                cell(.review(review))
            }
        }

        if !relatedVenues.isEmpty {
            cell(.sectionHeader("Related Venues"))
            for relatedVenue in relatedVenues {
                cell(.relatedVenue(relatedVenue))
            }
        }
    }
}
```

### Let cells to conform BindableCell

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

### Bind cell declarations and actual cell types

```swift
let dataSource = CollectionViewDataSource<CellDeclaration> { cellDeclaration in
    switch cellDeclaration {
    case .outline(let venue):
        return VenueOutlineCell.makeBinder(value: venue)
    case .sectionHeader(let title):
        return SectionHeaderCell.makeBinder(value: title)
    case .review(let review):
        return ReviewCell.makeBinder(value: review)
    case .relatedVenue(let venue):
        return RelatedVenueCell.makeBinder(value: venue)
    }
}
```

### Set data source to collection view

```swift
final class VenueDetailViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    private var data: Data! {
        didSet {
            dataSource.cellDeclarations = data.cellDeclarations
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = dataSource

        data = Data(
            venue: Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
            reviews: [
                Review(authorImage: #imageLiteral(resourceName: "ishkawa"), authorName: "Yosuke Ishikawa", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                Review(authorImage: #imageLiteral(resourceName: "yamotty"), authorName: "Masatake Yamoto", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            ],
            relatedVenues: [
                Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
                Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
                Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
                Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
            ])
    }
}
```
