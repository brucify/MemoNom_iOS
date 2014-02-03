//
//  ViewController.h
//  MemoNOM_iOS
//
//  Created by Bruce Yinhe on 27/01/2014.
//  Copyright (c) 2014 MemoNOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)goBonjour:(id)sender;
- (IBAction)goGoogle:(id)sender;

@end
