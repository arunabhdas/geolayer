//
//  Venue.h
//  GeoLayer
//
//

#import <Foundation/Foundation.h>
@class Location;
@interface Venue : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Location *location;

@end
