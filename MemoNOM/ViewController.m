//
//  ViewController.m
//  MemoNOM
//
//  Created by Bruce Yinhe on 09/01/2014.
//  Copyright (c) 2014 MemoNOM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)wifiButtonClicked:(id)sender {
    NSString *urlString = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:url];
    

}

- (IBAction)bluetoothButtonClicked:(id)sender {
}
@end
