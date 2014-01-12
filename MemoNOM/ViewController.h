//
//  ViewController.h
//  MemoNOM
//
//  Created by Bruce Yinhe on 09/01/2014.
//  Copyright (c) 2014 MemoNOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *deviceTableView;
- (IBAction)wifiButtonClicked:(id)sender;
- (IBAction)bluetoothButtonClicked:(id)sender;

@end
