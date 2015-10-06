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
    //View 1
    UIImageView *contactImageView = [[UIImageView alloc] init];
    contactImageView.image = [UIImage imageNamed:@"martini"];
    [contactImageView.heightAnchor constraintEqualToConstant:200].active = true;
    [contactImageView.widthAnchor constraintEqualToConstant:180].active = true;
    UIImage *defaultImage = [UIImage imageNamed:@"martini"];
    NSURL *imageUrl = [NSURL URLWithString:[self.selectedPictureLarge stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    UITextView *firstNameTextView = [[UITextView alloc] init];
    firstNameTextView.text = self.selectedName;
    firstNameTextView.backgroundColor = [UIColor whiteColor];
    firstNameTextView.textColor = [UIColor blackColor];
    firstNameTextView.font = [UIFont systemFontOfSize:20.0f];
    firstNameTextView.returnKeyType = UIReturnKeyDone;
    firstNameTextView.textAlignment = NSTextAlignmentCenter;
    firstNameTextView.tag = 2;
    firstNameTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [firstNameTextView.heightAnchor constraintEqualToConstant:100].active = true;
    [firstNameTextView.widthAnchor constraintEqualToConstant:360].active = true;
    

    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 30;
    
    
    [stackView addArrangedSubview:contactImageView];
    [stackView addArrangedSubview:firstNameTextView];
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:stackView];
    
    
    //Layout for Stack View
    [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    // [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;
   
    // 50 pixels from the top of its superview and 40 pixels tall
   
    // align stackView from the top using https://autolayoutconstraints.com/
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[stackView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(stackView)]];
    
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
