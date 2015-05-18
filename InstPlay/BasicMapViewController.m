#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "BasicMapViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@implementation BasicMapViewController
{
    GMSMarker *feedMarker;
    UIImageView* imageView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:(CLLocationDegrees)[self.latitude doubleValue]
                                                          longitude:(CLLocationDegrees)[self.longitude doubleValue]
                                                               zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    feedMarker = [[GMSMarker alloc] init];
    feedMarker.title = self.titleFeed;
    feedMarker.snippet = self.detailFeed;
    feedMarker.position = CLLocationCoordinate2DMake((CLLocationDegrees)[self.latitude doubleValue], (CLLocationDegrees)[self.longitude doubleValue]);
    feedMarker.map = mapView;
    NSLog(@"feedMarker: %@", feedMarker);
    
    imageView = [[UIImageView alloc] init];
    NSString *your_url = @"https://instagramimages-a.akamaihd.net/profiles/profile_249677730_75sq_1370676158.jpg";
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL   URLWithString:your_url]]];
    
    self.view = mapView;
    mapView.delegate = self;
}

#pragma mark GMSMapViewDelegate

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    if (marker == feedMarker) {
        return imageView;
    }
    return nil;
}
@end
