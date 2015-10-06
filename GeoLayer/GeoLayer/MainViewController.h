//
//  MainViewController.h
//  GeoLayer
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UISearchResultsUpdating, CLLocationManagerDelegate>
{
}
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, strong) NSArray *venues;
@property (nonatomic, strong) NSString *latlon;
@property (nonatomic, strong) NSTimer *locationTimer;


@end
