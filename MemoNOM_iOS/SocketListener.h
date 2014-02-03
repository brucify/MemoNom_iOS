//
//  SocketListener.h
//  MemoNOM_iOS
//
//  Created by Bruce Yinhe on 02/02/2014.
//  Copyright (c) 2014 MemoNOM. All rights reserved.
//

#import "AppDelegate.h"

@interface SocketListener : AppDelegate

void AcceptCallBack(
    CFSocketRef socket,
    CFSocketCallBackType type,
    CFDataRef address,
    const void *data,
    void *info);

- (void)createAndListen;
@end
