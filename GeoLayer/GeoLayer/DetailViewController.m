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
    NSLog(@"DetailViewController %ld", self.selectedIndex);
    NSLog(@"DetailViewController %@", self.selectedName);
    self.selectedId = self.selectedVenue.id;
    [self configureRestKit];
    [self loadItems];
}

- (void)configureRestKit {
    // initialize AFNetworking HTTPClient
    
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    NSString *selId = self.selectedId;
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
    NSString *path = [@"/v2/venues/" stringByAppendingString:self.selectedId];
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

}

- (void)viewWillLayoutSubviews {
    [self layoutAllViews];
}

- (void)layoutAllViews {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    // 1
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = [UIImage imageNamed:@"martini"];
    [photoView.heightAnchor constraintEqualToConstant:100].active = true;
    [photoView.widthAnchor constraintEqualToConstant:100].active = true;
    UIImage *defaultImage = [UIImage imageNamed:@"martini"];
    // NSURL *imageUrl = [NSURL URLWithString:[self.selectedPictureLarge stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    photoView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // name
    UITextView *nameTextView = [[UITextView alloc] init];
    nameTextView.text = self.selectedVenue.name;
    nameTextView.backgroundColor = [UIColor whiteColor];
    nameTextView.textColor = [UIColor blackColor];
    nameTextView.font = [UIFont systemFontOfSize:20.0f];
    nameTextView.returnKeyType = UIReturnKeyDone;
    nameTextView.textAlignment = NSTextAlignmentCenter;
    nameTextView.editable = NO;
    nameTextView.tag = 2;
    nameTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [nameTextView.heightAnchor constraintEqualToConstant:60].active = true;
    [nameTextView.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    nameTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // phone
    UITextView *phoneTextView = [[UITextView alloc] init];
    phoneTextView.text = @"Phone : ";
    if (self.selectedVenue.contact.phone.length) {
        phoneTextView.text = [phoneTextView.text stringByAppendingString:self.selectedVenue.contact.phone];
    } else {
        phoneTextView.text = [phoneTextView.text stringByAppendingString:kNotAvailable];
    }
    phoneTextView.backgroundColor = [UIColor whiteColor];
    phoneTextView.textColor = [UIColor blackColor];
    phoneTextView.font = [UIFont systemFontOfSize:20.0f];
    phoneTextView.textAlignment = NSTextAlignmentCenter;
    phoneTextView.editable = NO;
    phoneTextView.tag = 3;
    [phoneTextView.heightAnchor constraintEqualToConstant:50].active = true;
    [phoneTextView.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    phoneTextView.translatesAutoresizingMaskIntoConstraints = NO;
   
    // twitter
    UITextView *twitterTextView = [[UITextView alloc] init];
    twitterTextView.text = @"Twitter : ";
    if (self.selectedVenue.contact.twitter.length) {
        twitterTextView.text = [twitterTextView.text stringByAppendingString:self.selectedVenue.contact.twitter];
    } else {
        twitterTextView.text = [twitterTextView.text stringByAppendingString:kNotAvailable];
    }
    twitterTextView.backgroundColor = [UIColor whiteColor];
    twitterTextView.textColor = [UIColor blackColor];
    twitterTextView.font = [UIFont systemFontOfSize:20.0f];
    twitterTextView.textAlignment = NSTextAlignmentCenter;
    twitterTextView.editable = NO;
    twitterTextView.tag = 3;
    [twitterTextView.heightAnchor constraintEqualToConstant:50].active = true;
    [twitterTextView.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    twitterTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // address
    UITextView *descriptionTextView = [[UITextView alloc] init];
    descriptionTextView.text = @"Address : ";
    if (self.selectedVenue.location.formattedAddress.length) {
        descriptionTextView.text = [descriptionTextView.text stringByAppendingString:self.selectedVenue.location.formattedAddress];
    } else {
        descriptionTextView.text = [descriptionTextView.text stringByAppendingString:kNotAvailable];
    }
    descriptionTextView.backgroundColor = [UIColor whiteColor];
    descriptionTextView.textColor = [UIColor blackColor];
    descriptionTextView.font = [UIFont systemFontOfSize:20.0f];
    descriptionTextView.returnKeyType = UIReturnKeyDone;
    descriptionTextView.textAlignment = NSTextAlignmentCenter;
    descriptionTextView.editable = NO;
    descriptionTextView.tag = 4;
    descriptionTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [descriptionTextView.heightAnchor constraintEqualToConstant:100].active = true;
    [descriptionTextView.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 10;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [stackView addArrangedSubview:photoView];
    [stackView addArrangedSubview:nameTextView];
    [stackView addArrangedSubview:phoneTextView];
    [stackView addArrangedSubview:twitterTextView];
    [stackView addArrangedSubview:descriptionTextView];
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    // [self.view addSubview:stackView];
    [scrollView addSubview:stackView];
    
    [self.view addSubview:scrollView];
    
    //Layout for Stack View
    [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    // [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem: stackView
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
