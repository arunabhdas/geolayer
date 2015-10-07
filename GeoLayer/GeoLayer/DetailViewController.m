//
//  DetailViewController.m
//  ContactList
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

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
    
    // 2
    UITextView *nameTextView = [[UITextView alloc] init];
    nameTextView.text = self.selectedName;
    nameTextView.backgroundColor = [UIColor whiteColor];
    nameTextView.textColor = [UIColor blackColor];
    nameTextView.font = [UIFont systemFontOfSize:20.0f];
    nameTextView.returnKeyType = UIReturnKeyDone;
    nameTextView.textAlignment = NSTextAlignmentCenter;
    nameTextView.tag = 2;
    nameTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [nameTextView.heightAnchor constraintEqualToConstant:100].active = true;
    [nameTextView.widthAnchor constraintEqualToConstant:360].active = true;
    nameTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // 3
    UITextView *descriptionTextView = [[UITextView alloc] init];
    descriptionTextView.text = self.selectedVenue.location.address;
    descriptionTextView.backgroundColor = [UIColor whiteColor];
    descriptionTextView.textColor = [UIColor blackColor];
    descriptionTextView.font = [UIFont systemFontOfSize:20.0f];
    descriptionTextView.returnKeyType = UIReturnKeyDone;
    descriptionTextView.textAlignment = NSTextAlignmentCenter;
    descriptionTextView.tag = 3;
    descriptionTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [descriptionTextView.heightAnchor constraintEqualToConstant:100].active = true;
    [descriptionTextView.widthAnchor constraintEqualToConstant:360].active = true;
    descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 10;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [stackView addArrangedSubview:photoView];
    [stackView addArrangedSubview:nameTextView];
    [stackView addArrangedSubview:descriptionTextView];
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    // [self.view addSubview:stackView];
    [scrollView addSubview:stackView];
    
    [self.view addSubview:scrollView];
    
    //Layout for Stack View
    [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    // [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;
   
    // 50 pixels from the top of its superview and 40 pixels tall
   
    // align stackView from the top using https://autolayoutconstraints.com/
    
    NSDictionary *elementsDict = NSDictionaryOfVariableBindings(photoView, nameTextView, descriptionTextView, stackView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[stackView]" options:0 metrics:nil views:elementsDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[nameTextView]" options:0 metrics:nil views:elementsDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[descriptionTextView]" options:0 metrics:nil views:elementsDict]];
    
    
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
