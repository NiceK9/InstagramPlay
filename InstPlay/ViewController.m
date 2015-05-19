//
//  ViewController.m
//  InstPlay
//
//  Created by son hoang on 5/16/15.
//  Copyright (c) 2015 son hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "FeedsViewController.h"
#import "FullMapViewController.h"



#define KAUTHURL @"https://api.instagram.com/oauth/authorize/"
#define kAPIURl @"https://api.instagram.com/v1/users/"
#define KCLIENTID @"c5d25f0adacf4978afa8b7c9d9dc7391"
#define KCLIENTSERCRET @"1f89607e9ebb4bbdb3dbaf748f96cf40"
#define kREDIRECTURI @"http://abc.com"

#define KACCESS_TOKEN @"access_token"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    //[self.navigationController.navigationBar.backItem setTitle:@"anything"];
    
    // then call the super
    //[super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *backButton =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"Back")
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];

	[self loadURL];
}

- (CGRect)getSelfBounds {
    return CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
}

-(void)loadURL{
	NSString *fullURL = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=token",KAUTHURL,KCLIENTID,kREDIRECTURI];
    
    NSURL *url = [NSURL URLWithString:fullURL];
    UIWebView *webview=[[UIWebView alloc] initWithFrame:[self getSelfBounds]];

    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    webview.delegate = self;
    webview.scalesPageToFit = YES;
    [self.view addSubview:webview];
    [webview loadRequest:requestObj];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString* urlString = [[request URL] absoluteString];
    NSLog(@"URL STRING : %@ ",urlString);
    NSArray *UrlParts = [urlString componentsSeparatedByString:[NSString stringWithFormat:@"%@/", kREDIRECTURI]];
    if ([UrlParts count] > 1) {
        // do any of the following here
        urlString = [UrlParts objectAtIndex:1];
        NSRange accessToken = [urlString rangeOfString: @"#access_token="];
        if (accessToken.location != NSNotFound) {
            NSString* strAccessToken = [urlString substringFromIndex: NSMaxRange(accessToken)];
            // Save access token to user defaults for later use.
            // Add contant key #define KACCESS_TOKEN @”access_token” in contant //class
            [[NSUserDefaults standardUserDefaults] setValue:strAccessToken forKey: KACCESS_TOKEN]; [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"AccessToken = %@ ",strAccessToken);
            [self loadRequestForMediaData];
        }
        return NO;
    }
    return YES;
}

-(void)loadRequestForMediaData {
     NSLog(@"loadRequestForMediaData 111");
    NSString* value =[[ NSUserDefaults standardUserDefaults] valueForKey:KACCESS_TOKEN];
    NSLog(@"loadRequestForMediaData token: %@", value);
    NSString* url =[NSString stringWithFormat:@"%@self/feed/?access_token=%@",kAPIURl,value];
     NSLog(@"loadRequestForMediaData url: %@", url);
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    //https://api.instagram.com/v1/users/3/media/recent/?access_token=1946487685.c5d25f0.cdb93ed91324460e9299abccaebad934
    // Here you can handle response as well
    NSLog(@"loadRequestForMediaData 222");
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"loadRequestForMediaData 333");
    NSLog(@"Response : %@",dictResponse);
    
    FullMapViewController *controller =
    [[FullMapViewController alloc] init];
    controller.data = [dictResponse objectForKey:@"data"];
    controller.title = @"Map";
    [self.navigationController pushViewController:controller animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
