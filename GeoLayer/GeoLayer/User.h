//
//  User.h
//  GeoLayer
//

#import <Foundation/Foundation.h>
#import "Photo.h"
@class Photo;
@interface User : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) Photo *photo;

@end
