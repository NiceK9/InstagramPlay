#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "BasicMapViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@implementation BasicMapViewController
{
    GMSMarker *feedMarker;
    UIView* view;
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
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 330.0, 120.0)];
    CALayer *gradient = [CALayer layer];
    gradient.frame = view.bounds;
    gradient.borderColor = [[UIColor blackColor] CGColor];
    gradient.borderWidth = 2;
    gradient.cornerRadius = 5;
    gradient.masksToBounds = YES;
    gradient.backgroundColor = [[UIColor whiteColor] CGColor];
    [view.layer insertSublayer:gradient atIndex:0];
    
    CALayer *avatar = [CALayer layer];
    avatar.frame = CGRectMake(8, 8, 104.0, 104.0);
    avatar.borderColor = [[UIColor brownColor] CGColor];
    avatar.borderWidth = 4;
    //gradient.cornerRadius = 5;
    //gradient.masksToBounds = YES;
    //gradient.backgroundColor = [[UIColor whiteColor] CGColor];
    [view.layer insertSublayer:avatar atIndex:1];
 
    
    UIImageView* imageView =  [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100.0, 100.0)];
    
    
   // [imageView setImage:[UIImage imageNamed:@"sm006.png"]];
    NSString *your_url = self.urlImage;
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL   URLWithString:your_url]]];
    
    [view addSubview:imageView];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 200.0, 40.0)] ;
    title.text = self.titleFeed;
    [title setFont:[UIFont systemFontOfSize:20]];
    //title.numberOfLines = 0;
    //title.lineBreakMode = NSLineBreakByWordWrapping;
    [view addSubview:title];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, 200.0, 40.0)] ;
    label.text = self.detailFeed;
    [label setFont:[UIFont systemFontOfSize:15]];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [view addSubview:label];
    
    
    self.view = mapView;
    mapView.delegate = self;
}

#pragma mark GMSMapViewDelegate

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    if (marker == feedMarker) {
        return view;
    }
    return nil;
}
@end
