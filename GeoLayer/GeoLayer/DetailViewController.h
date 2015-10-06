//
//  DetailViewController.h
//  ContactList
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, assign) long selectedIndex;
@property (nonatomic, assign) NSString *selectedFirstName;
@property (nonatomic, assign) NSString *selectedLastName;
@property (nonatomic, assign) NSString *selectedPictureLarge;

@end
