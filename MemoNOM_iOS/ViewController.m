//
//  ViewController.m
//  MemoNOM_iOS
//
//  Created by Bruce Yinhe on 27/01/2014.
//  Copyright (c) 2014 MemoNOM. All rights reserved.
//

#import "ViewController.h"
#import "SocketListener.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView;
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    myRegistrationFunction(0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBonjour:(id)sender {
}

- (IBAction)goGoogle:(id)sender {
    NSString *urlString = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:requestObject];
}

void myRegistrationFunction(uint16_t port) {
    id delegateObject;      // Assume this exists.
    NSNetService *service;
    
    service = [[NSNetService alloc] initWithDomain:@""// 1
                                              type:@"_memonom._tcp"
                                              name:@""
                                              port:port];
    if(service)
    {
        [service setDelegate:delegateObject];// 2
        [service publish];// 3
        NSLog(@"NSNetService has been published.");

    }
    else
    {
        NSLog(@"An error occurred initializing the NSNetService object.");
    }
}

@end
