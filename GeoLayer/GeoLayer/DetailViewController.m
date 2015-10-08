//
//  DetailViewController.m
//  ContactList
//

#define kClientId @"4HJKQ3GGLO5MJ4X14OGMKSPGVXFF34BUZ4TE0BKM032DFFKA"
#define kClientSecret @"KZ0JJL0REUQUCTT3V4RZMC5VFFHRTQVHCNEXRJOW30JPDLUN"
#define kSampleUrl @"https://api.foursquare.com/v2/venues/45ac12d6f964a5205d411fe3/photos?client_id=4HJKQ3GGLO5MJ4X14OGMKSPGVXFF34BUZ4TE0BKM032DFFKA&client_secret=KZ0JJL0REUQUCTT3V4RZMC5VFFHRTQVHCNEXRJOW30JPDLUN&v=20130815"

#import "DetailViewController.h"
#import <RestKit/RestKit.h>
#import "Item.h"
@interface DetailViewController ()

@end
static NSString *const kNotAvailable = @"Not Available";
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"========================================");
    // Do any additional setup after loading the view.
    NSLog(@"DetailViewController %@", self.selectedVenue.name);
    [self configureRestKit];
    // [self loadItems];
}



- (void)configureRestKit {
    // initialize AFNetworking HTTPClient
    
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *itemMapping = [RKObjectMapping mappingForClass:[Item class]];
    
    [itemMapping addAttributeMappingsFromArray:@[@"createdAt", @"height", @"id", @"prefix", @"suffix", @"visibility", @"width"]];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor
                                                responseDescriptorWithMapping:itemMapping
                                                method:RKRequestMethodGET pathPattern:@"/v2/venues/:id/photos"
                                                keyPath:@"response.photos.items"
                                                statusCodes:[NSIndexSet indexSetWithIndex:200]];

    /*
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor
                                                responseDescriptorWithMapping:itemMapping
                                                method:RKRequestMethodGET pathPattern:nil
                                                keyPath:@"response.photos.items"
                                                statusCodes:[NSIndexSet indexSetWithIndex:200]];
    */
    [objectManager addResponseDescriptor:responseDescriptor];
    
}
- (void)loadItems {
    NSString *clientId = kClientId;
    NSString *clientSecret = kClientSecret;
    NSString *versionString = @"20151006";
    // NSString *path = @"/v2/venues/45ac12d6f964a5205d411fe3/photos";
    NSString *path = [@"/v2/venues/" stringByAppendingString:self.selectedVenue.id];
    path = [path stringByAppendingString:@"/photos"];
    NSDictionary *queryParams = @{@"client_id": clientId,
                                  @"client_secret": clientSecret,
                                  @"v": versionString,
                                 };
        
        [[RKObjectManager sharedManager] getObjectsAtPath:path parameters:queryParams
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      self.items = mappingResult.array;
                                                      NSLog(@"------------------------mapping Result %@", mappingResult);
                                                      for (Item *item in self.items) {
                                                          NSLog(@"prefix %@", item.prefix);
                                                      }
                                                  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                      NSLog(@"what do you mean by there's no coffee");
                                                      
                                                  }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    // [self layoutAllViews];
    self.photoView = [[UIImageView alloc] init];
    self.nameTextView = [[UITextView alloc] init];
    self.phoneTextView = [[UITextView alloc] init];
    self.twitterTextView = [[UITextView alloc] init];
    self.descriptionTextView = [[UITextView alloc] init];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubview");
    [self layoutAllViews];
}

- (void)layoutAllViews {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    // 1
    self.photoView.image = [UIImage imageNamed:@"martini"];
    [self.photoView.heightAnchor constraintEqualToConstant:100].active = true;
    [self.photoView.widthAnchor constraintEqualToConstant:100].active = true;
    self.photoView.tag = 1;
    // NSURL *imageUrl = [NSURL URLWithString:[self.selectedPictureLarge stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self.photoView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // name
    self.nameTextView.text = self.selectedVenue.name;
    self.nameTextView.backgroundColor = [UIColor whiteColor];
    self.nameTextView.textColor = [UIColor blackColor];
    self.nameTextView.font = [UIFont systemFontOfSize:20.0f];
    self.nameTextView.returnKeyType = UIReturnKeyDone;
    self.nameTextView.textAlignment = NSTextAlignmentCenter;
    self.nameTextView.editable = NO;
    self.nameTextView.tag = 2;
    self.nameTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.nameTextView.heightAnchor constraintEqualToConstant:60].active = true;
    [self.nameTextView.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    self.nameTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // phone
    self.phoneTextView.text = @"Phone : ";
    if (self.selectedVenue.contact.phone.length) {
        self.phoneTextView.text = [self.phoneTextView.text stringByAppendingString:self.selectedVenue.contact.phone];
    } else {
        self.phoneTextView.text = [self.phoneTextView.text stringByAppendingString:kNotAvailable];
    }
    self.phoneTextView.backgroundColor = [UIColor whiteColor];
    self.phoneTextView.textColor = [UIColor blackColor];
    self.phoneTextView.font = [UIFont systemFontOfSize:20.0f];
    self.phoneTextView.textAlignment = NSTextAlignmentCenter;
    self.phoneTextView.editable = NO;
    self.phoneTextView.tag = 3;
    [self.phoneTextView.heightAnchor constraintEqualToConstant:50].active = true;
    [self.phoneTextView.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    self.phoneTextView.translatesAutoresizingMaskIntoConstraints = NO;
   
    // twitter
    self.twitterTextView.text = @"Twitter : ";
    if (self.selectedVenue.contact.twitter.length) {
        self.twitterTextView.text = [self.twitterTextView.text stringByAppendingString:self.selectedVenue.contact.twitter];
    } else {
        self.twitterTextView.text = [self.twitterTextView.text stringByAppendingString:kNotAvailable];
    }
    self.twitterTextView.backgroundColor = [UIColor whiteColor];
    self.twitterTextView.textColor = [UIColor blackColor];
    self.twitterTextView.font = [UIFont systemFontOfSize:20.0f];
    self.twitterTextView.textAlignment = NSTextAlignmentCenter;
    self.twitterTextView.editable = NO;
    self.twitterTextView.tag = 4;
    [self.twitterTextView.heightAnchor constraintEqualToConstant:50].active = true;
    [self.twitterTextView.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    self.twitterTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // address
    self.descriptionTextView.text = @"Address : ";
    if (self.selectedVenue.location.formattedAddress.length) {
        self.descriptionTextView.text = [self.descriptionTextView.text stringByAppendingString:self.selectedVenue.location.formattedAddress];
    } else {
        self.descriptionTextView.text = [self.descriptionTextView.text stringByAppendingString:kNotAvailable];
    }
    self.descriptionTextView.backgroundColor = [UIColor whiteColor];
    self.descriptionTextView.textColor = [UIColor blackColor];
    self.descriptionTextView.font = [UIFont systemFontOfSize:20.0f];
    self.descriptionTextView.returnKeyType = UIReturnKeyDone;
    self.descriptionTextView.textAlignment = NSTextAlignmentCenter;
    self.descriptionTextView.editable = NO;
    self.descriptionTextView.tag = 5;
    self.descriptionTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.descriptionTextView.heightAnchor constraintEqualToConstant:100].active = true;
    [self.descriptionTextView.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.distribution = UIStackViewDistributionEqualSpacing;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.spacing = 10;
    self.stackView.tag = 6;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.stackView addArrangedSubview:self.photoView];
    [self.stackView addArrangedSubview:self.nameTextView];
    [self.stackView addArrangedSubview:self.phoneTextView];
    [self.stackView addArrangedSubview:self.twitterTextView];
    [self.stackView addArrangedSubview:self.descriptionTextView];
    [self.scrollView addSubview:self.self.stackView];
    [self.view addSubview:self.scrollView];
    
    //Layout for Stack View
    [self.stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    // [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem: self.stackView
                                      attribute: NSLayoutAttributeTop
                                      relatedBy: NSLayoutRelationEqual
                                      toItem: self.view
                                      attribute: NSLayoutAttributeTop
                                      multiplier:1.0
                                      constant:80.0];
    
    [self.view addConstraint:constraint];
   
    /*
    constraint = [NSLayoutConstraint
                  constraintWithItem:phoneTextView
                  attribute: NSLayoutAttributeTop
                  relatedBy: NSLayoutRelationLessThanOrEqual
                  toItem: nameTextView
                  attribute: NSLayoutAttributeTop
                  multiplier:1.0
                  constant:50.0];
    
    [self.view addConstraint:constraint];
    */
    
    
    // align stackView from the top using https://autolayoutconstraints.com/
    /*
     NSDictionary *elementsDict = NSDictionaryOfVariableBindings(photoView, nameTextView, descriptionTextView, stackView);
     
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[stackView]" options:0 metrics:nil views:elementsDict]];
     
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[nameTextView]" options:0 metrics:nil views:elementsDict]];
     
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[descriptionTextView]" options:0 metrics:nil views:elementsDict]];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
