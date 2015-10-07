//
//  DetailViewController.h
//  ContactList
//

#import <UIKit/UIKit.h>
#import "Venue.h"
@interface DetailViewController : UIViewController

@property (nonatomic, assign) long selectedIndex;
@property (nonatomic, assign) NSString *selectedName;
@property (nonatomic, assign) Venue *selectedVenue;
@end
