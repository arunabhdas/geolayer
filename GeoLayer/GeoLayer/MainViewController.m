//
//  MainViewController.m
//  GeoLayer
//
#define kClientId @"4HJKQ3GGLO5MJ4X14OGMKSPGVXFF34BUZ4TE0BKM032DFFKA"
#define kClientSecret @"KZ0JJL0REUQUCTT3V4RZMC5VFFHRTQVHCNEXRJOW30JPDLUN"
#define BASE_URL @"https://api.foursquare.com/v2/venues/search?client_id=4HJKQ3GGLO5MJ4X14OGMKSPGVXFF34BUZ4TE0BKM032DFFKA&client_secret=KZ0JJL0REUQUCTT3V4RZMC5VFFHRTQVHCNEXRJOW30JPDLUN&v=20130815%20&ll=40.7,-74%20&query=sushi"
#define kAppTitle @"Geo Layer"
#define kMainToDetailSegue @"MainToDetailSegue"
#import "MainViewController.h"
#import <RestKit/RestKit.h>
#import "Venue.h"
#import "ItemCell.h"
#import <MapKit/MapKit.h>

@interface MainViewController() {
   	CLLocationManager *locationManager;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    // self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90.0f)];
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ItemCell class] forCellReuseIdentifier:@"Cell"];
    self.view = self.tableView;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    /*
    self.searchController.searchBar.scopeButtonTitles = @[NSLocalizedString(@"ScopeButtonCountry", @"Country"),
                                                          NSLocalizedString(@"ScopeButtonCapital", @"Capital")
                                                          ];
    */
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    self.navigationItem.title = kAppTitle;
    
    [self configureRestKit];

    [self loadVenues:@"Pizza"];
    
}


- (void)configureRestKit {
    // initialize AFNetworking HTTPClient
    
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    
    [venueMapping addAttributeMappingsFromArray:@[@"name"]];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor
                                                responseDescriptorWithMapping:venueMapping
                                                method:RKRequestMethodGET pathPattern:@"/v2/venues/search"
                                                keyPath:@"response.venues"
                                                statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    
    
    
}

- (void)loadVenues:(NSString *)keyword {
    NSString *latLon = @"40.7,-74.20";
    NSString *clientId = kClientId;
    NSString *clientSecret = kClientSecret;
    NSString *versionString = @"20151006";
    
    NSString *queryString = @"sushi";
    if (keyword.length) {
        queryString = keyword;
    }
    
    NSDictionary *queryParams = @{@"ll": latLon,
                                  @"client_id": clientId,
                                  @"client_secret": clientSecret,
                                  @"v": versionString,
                                  @"query": queryString
                                  };
    
   [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/search" parameters:queryParams
                                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                 self.venues = mappingResult.array;
                                                 [self.tableView reloadData];
   } failure:^(RKObjectRequestOperation *operation, NSError *error) {
       NSLog(@"what do you mean by there's no coffee");
       
   }];
    
    
}
#pragma mark - DataSource
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"venues count: %ld ", [self.venues count]);
    // Return the number of rows in the section.
    return [self.venues count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    ItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] ;
    
    if (itemCell == nil)
    {
        itemCell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Venue *venue = self.venues[indexPath.row];
    itemCell.textLabel.text = venue.name;
    
    itemCell.titleLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    itemCell.descriptionLabel.text = [venue.name capitalizedString];
    itemCell.descriptionLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    itemCell.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    return itemCell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
    [self.view endEditing:YES];
    [self performSegueWithIdentifier:kMainToDetailSegue sender:self];
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([self shouldPerformSegueWithIdentifier:identifier sender:sender]) {
        [super performSegueWithIdentifier:identifier sender:sender];
    }
    // otherwise do nothing
}



#pragma mark - UIGestureRecognizerDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - UISearchBarDelegate

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    // [self loadVenues:self.searchBar.text];
    [self loadVenues:self.searchController.searchBar.text];
}
#pragma mark - UISearchResultsUpdatingDelegate
- (void) updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = self.searchController.searchBar.text;
    [self loadVenues:searchString];
    [self.tableView reloadData];
}



@end