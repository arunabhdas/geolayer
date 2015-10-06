//
//  DetailViewController.h
//  ContactList
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, assign) long selectedIndex;
@property (nonatomic, assign) NSString *selectedName;
@property (nonatomic, assign) NSString *selectedDescription;
@property (nonatomic, assign) NSString *selectedPictureLarge;

@end
