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
#import "Location.h"
#import "ItemCell.h"
#import <CoreLocation/CoreLocation.h>
#import "DetailViewController.h"
#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3
@interface MainViewController() {
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    self.locationTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(stopUpdatingLocations) userInfo:nil repeats:NO];
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

- (NSString *) deviceLocation {
    self.latlon = [NSString stringWithFormat:@"%f,%f",self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    return [NSString stringWithFormat:@"latitude %f longitude %f ", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
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
    
    // location object mapping
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    
    // define relationship mapping
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    
    
    
    
}

- (void)loadVenues:(NSString *)keyword {
    // NSString *ll = @"40.7,-74.20";
    NSString *clientId = kClientId;
    NSString *clientSecret = kClientSecret;
    NSString *versionString = @"20151006";
    
    if (keyword.length) {
        NSLog(@"%@", self.latlon);
        NSDictionary *queryParams = @{@"ll": self.latlon,
                                  @"client_id": clientId,
                                  @"client_secret": clientSecret,
                                  @"v": versionString,
                                  @"query": keyword
                                  };
    
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/search" parameters:queryParams
                                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                 self.venues = mappingResult.array;
                                                 [self.tableView reloadData];
                                             } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"what do you mean by there's no coffee");
       
        }];
    }
}
- (void) didReceiveMemoryWarning
{
    
    
}
#pragma mark - DataSource
#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}
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
   
    UILabel *mainLabel, *secondLabel;
    
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] ;
    
    UIImageView *photo;
    
    if (cell == nil)
    {
        cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        
    }
    
    Venue *venue = self.venues[indexPath.row];
    cell.mainLabel.text = venue.name;
    cell.secondaryLabel.text = venue.name;
    cell.photoView = (UIImageView *)[cell.contentView viewWithTag:PHOTO_TAG];
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
    self.selectedIndex = indexPath.row;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MainToDetailSegue"])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.selectedIndex = self.selectedIndex;
        Venue *selectedVenue = [[Venue alloc] init];
        selectedVenue = self.venues[self.selectedIndex];
        destViewController.selectedName = selectedVenue.name;
        // destViewController.selectedPictureLarge = self.selectedPictureLarge;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // [self.view endEditing:YES];
    [self.searchController.searchBar endEditing:YES];
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

#pragma mark CLLocationManagerDelegate
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation :latitude %f longitude %f ", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    self.latlon = [NSString stringWithFormat:@"%f,%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
}

- (void)stopUpdatingLocations
{
    [self.locationManager stopUpdatingLocation];
    
    [self.locationTimer invalidate];
}
@end
