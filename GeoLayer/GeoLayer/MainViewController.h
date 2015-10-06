//
//  MainViewController.h
//  GeoLayer
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;
// @property (nonatomic, strong) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, strong) NSArray *venues;

@end
