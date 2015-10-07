//
//  Venue.h
//  GeoLayer
//
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Contact.h"
@class Location;
@class Contact;
@interface Venue : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) BOOL verified;
@property (nonatomic, strong) NSString *url;
@property (nonatomic) BOOL hasMenu;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Contact *contact;
@end
