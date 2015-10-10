//
//  RandomUser.h
//  GeoLayer
//

#import "JSONModel.h"
#import "Name.h"
#import "RandomUserLocation.h"
#import "Picture.h"
@class Name;
@class RandomUserLocation;
@class Picture;
@interface RandomUser : NSObject
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) Name *name;
@property (nonatomic, strong) RandomUserLocation *location;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *salt;
@property (nonatomic, strong) NSString *md5;
@property (nonatomic, strong) NSString *sha1;
@property (nonatomic, strong) NSString *sha256;
@property (nonatomic, strong) NSNumber *registered;
@property (nonatomic, strong) NSNumber *dob;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *cell;
@property (nonatomic, strong) NSString *NINO;
@property (nonatomic, strong) Picture *picture;

@end
