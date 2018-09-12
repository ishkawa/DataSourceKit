# DataSourceKit

Declarative, testable data source of UICollectionView and UITableView.

![](Screenshot/declarative.png)

## Installation

Add a line `github "ishkawa/DataSourceKit"` to your Cartfile and run `carthage update`.

## Usage

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

### Declare ordered cells in conformer of CellsDeclarator

```swift
struct Data: CellsDeclarator {
    var venue: Venue
    var reviews: [Review]
    var relatedVenues: [Venue]

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
