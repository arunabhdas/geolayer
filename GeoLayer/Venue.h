//
//  Venue.h
//  GeoLayer
//
//

#import <Foundation/Foundation.h>
@class Location;
@class Contact;
@interface Venue : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Contact *contact;

@end
