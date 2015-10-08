//
//  DetailViewController.h
//  ContactList
//

#import <UIKit/UIKit.h>
#import "Venue.h"
@interface DetailViewController : UIViewController

@property (nonatomic, assign) Venue *selectedVenue;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UITextView *nameTextView;
@property (nonatomic, strong) UITextView *phoneTextView;
@property (nonatomic, strong) UITextView *twitterTextView;
@property (nonatomic, strong) UITextView *descriptionTextView;
@end
