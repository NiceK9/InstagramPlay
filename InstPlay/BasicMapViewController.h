#import <UIKit/UIKit.h>

#import <GoogleMaps/GoogleMaps.h>

@interface BasicMapViewController : UIViewController<GMSMapViewDelegate>
@property(strong, nonatomic) NSNumber* latitude;
@property(strong, nonatomic) NSNumber* longitude;
@property(strong, nonatomic) NSString* titleFeed;
@property(strong, nonatomic) NSString* detailFeed;
@end
