#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "FullMapViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@implementation FullMapViewController
{
    NSMutableArray* viewMapMarker;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	int count = [_data count];
	viewMapMarker = [[NSMutableArray alloc] init];
   // NSMutableArray *personsArray = [[NSMutableArray alloc] initWithCapacity:40];
   // [personsArray indexOfObject:<#(id)#>
    
    GMSCameraPosition *camera;
    GMSMapView *mapView;
    bool initFirst = false;
    
	for(int row = 0; row < count; row++) {
		NSDictionary* data = [_data objectAtIndex:row];
		NSDictionary* location =[data objectForKey:@"location"];
		NSDictionary* user =[data objectForKey:@"user"];
		NSDictionary* caption = [data objectForKey:@"caption"];
		NSDictionary* images = [data objectForKey:@"images"];

		
		if(location != [NSNull null])
		{
			NSString* latitude = [location objectForKey:@"latitude"];
			NSString* longitude = [location objectForKey:@"longitude"];
		
		
			NSString* titleFeed = @"";
			if(user != [NSNull null])
				titleFeed = [NSString stringWithFormat: @"[%@]", [user objectForKey:@"full_name"]];
				
			NSString* detailFeed = @"";			
			if(caption != [NSNull null])
				detailFeed = [caption objectForKey:@"text"];
				
			NSString* urlImage = @"";			
			if(images != [NSNull null])
				urlImage = [[images objectForKey:@"thumbnail"] objectForKey:@"url"];
			
			if(initFirst == false)
			{
				camera = [GMSCameraPosition cameraWithLatitude:(CLLocationDegrees)[latitude doubleValue]
																	  longitude:(CLLocationDegrees)[longitude doubleValue]
																		   zoom:15];
				mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
                
                
                self.view = mapView;
                mapView.delegate = self;

				initFirst = true;
			}

			
			GMSMarker* feedMarker = [[GMSMarker alloc] init];
			feedMarker.title = titleFeed;
			feedMarker.snippet = detailFeed;
			feedMarker.position = CLLocationCoordinate2DMake((CLLocationDegrees)[latitude doubleValue], (CLLocationDegrees)[longitude doubleValue]);
			feedMarker.map = mapView;
			NSLog(@"feedMarker: %@", feedMarker);
			
			UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 330.0, 120.0)];
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
			NSString *your_url = urlImage;
			imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL   URLWithString:your_url]]];
			
			[view addSubview:imageView];
			
			
			UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 200.0, 30.0)] ;
			title.text = titleFeed;
			[title setFont:[UIFont systemFontOfSize:20]];
			//title.numberOfLines = 0;
			//title.lineBreakMode = NSLineBreakByWordWrapping;
			[view addSubview:title];
			
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, 200.0, 100.0)] ;
			label.text = detailFeed;
			[label setFont:[UIFont systemFontOfSize:15]];
			label.numberOfLines = 0;
			label.lineBreakMode = NSLineBreakByWordWrapping;
			[view addSubview:label];
			
			//[viewMapMarker setObject:view forKey:feedMarker];
            [viewMapMarker addObject:feedMarker];
            [viewMapMarker addObject:view];
            
		}

        
	}


}

#pragma mark GMSMapViewDelegate

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
        //UIView * view = [viewMapMarker objectForKey:marker];
    int indexMarker = [viewMapMarker indexOfObject:marker];
    UIView * view =[viewMapMarker objectAtIndex:indexMarker+1];
    return view;
}
@end
