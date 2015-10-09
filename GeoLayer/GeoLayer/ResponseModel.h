//
//  ResponseModel.h
//  GeoLayer
//

#import "JSONModel.h"
#import "PhotosModel.h"
@class PhotosModel;
@interface ResponseModel : JSONModel
@property (nonatomic, strong) PhotosModel *photos;

@end
