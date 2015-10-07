//
//  DetailViewController.m
//  ContactList
//


#import "DetailViewController.h"

@interface DetailViewController ()

@end
static NSString *const kNotAvailable = @"Not Available";
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"DetailViewController %ld", self.selectedIndex);
    NSLog(@"DetailViewController %@", self.selectedName);
}

- (void) viewWillAppear:(BOOL)animated {

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
    nameTextView.tag = 2;
    nameTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [nameTextView.heightAnchor constraintEqualToConstant:100].active = true;
    [nameTextView.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    nameTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
   
    // phone
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"Phone : ";
    if (self.selectedVenue.contact.phone.length) {
        phoneLabel.text = [phoneLabel.text stringByAppendingString:self.selectedVenue.contact.phone];
    } else {
        phoneLabel.text = [phoneLabel.text stringByAppendingString:kNotAvailable];
    }
    phoneLabel.backgroundColor = [UIColor whiteColor];
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.font = [UIFont systemFontOfSize:20.0f];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.tag = 3;
    [phoneLabel.heightAnchor constraintEqualToConstant:100].active = true;
    [phoneLabel.widthAnchor constraintGreaterThanOrEqualToConstant:360].active = true;
    phoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // address
    UITextView *descriptionTextView = [[UITextView alloc] init];
    descriptionTextView.text = @"Address : ";
    if (self.selectedVenue.location.address.length) {
        descriptionTextView.text = [descriptionTextView.text stringByAppendingString:self.selectedVenue.location.address];
    } else {
        descriptionTextView.text = [descriptionTextView.text stringByAppendingString:kNotAvailable];
    }
    descriptionTextView.backgroundColor = [UIColor whiteColor];
    descriptionTextView.textColor = [UIColor blackColor];
    descriptionTextView.font = [UIFont systemFontOfSize:20.0f];
    descriptionTextView.returnKeyType = UIReturnKeyDone;
    descriptionTextView.textAlignment = NSTextAlignmentCenter;
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
    [stackView addArrangedSubview:phoneLabel];
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
    
    constraint = [NSLayoutConstraint
                                      constraintWithItem:phoneLabel
                                      attribute: NSLayoutAttributeTop
                                      relatedBy: NSLayoutRelationLessThanOrEqual
                                      toItem: nameTextView
                                      attribute: NSLayoutAttributeTop
                                      multiplier:1.0
                                      constant:50.0];

    [self.view addConstraint:constraint];
    
    
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
