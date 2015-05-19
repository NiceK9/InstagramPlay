#import <UIKit/UIKit.h>

#import <GoogleMaps/GoogleMaps.h>

@interface FullMapViewController : UIViewController<GMSMapViewDelegate>

@property(strong, nonatomic) NSArray *data;

@end
