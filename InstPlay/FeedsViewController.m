#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "FeedsViewController.h"
#import "BasicMapViewController.h"

@implementation FeedsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
    self.tableView.autoresizingMask =
    UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  
}

#pragma mark - UITableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat: @"title header %d", section];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
        

            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    }
	
    NSInteger row = indexPath.row;
    NSLog([NSString stringWithFormat: @"row %d", row]);
    NSDictionary* data = [_data objectAtIndex:row];
    NSDictionary* user =[data objectForKey:@"user"];
    NSDictionary* caption = [data objectForKey:@"caption"];
    NSLog(@"got info");
    if(user != [NSNull null])
        cell.textLabel.text = [NSString stringWithFormat: @"[%@]", [user objectForKey:@"full_name"]];
    if(caption != [NSNull null])
        cell.detailTextLabel.text = [NSString stringWithFormat: @"%@", [caption objectForKey:@"text"]];
    NSLog(@"ended");
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // The user has chosen a sample; load it and clear the selection!
    //[self loadDemo:indexPath.section atIndex:indexPath.row];
    
    NSInteger row = indexPath.row;
    NSDictionary* data = [_data objectAtIndex:row];
    NSDictionary* location =[data objectForKey:@"location"];
    NSDictionary* user =[data objectForKey:@"user"];
    NSDictionary* caption = [data objectForKey:@"caption"];

    BasicMapViewController *controller =
    [[BasicMapViewController alloc] init];
    if(location != [NSNull null])
    {
        controller.latitude = [location objectForKey:@"latitude"];
        controller.longitude = [location objectForKey:@"longitude"];
    
    
        if(user != [NSNull null])
            controller.titleFeed = [NSString stringWithFormat: @"[%@]", [user objectForKey:@"full_name"]];
        else
            controller.titleFeed = @"";
        
        if(caption != [NSNull null])
            controller.detailFeed = [NSString stringWithFormat: @"%@", [caption objectForKey:@"text"]];
        else
            controller.detailFeed = @"";
        
        controller.title = @"Map";
        
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                        message:@"The feed has not location to show !"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
