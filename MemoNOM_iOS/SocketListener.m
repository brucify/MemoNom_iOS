//
//  SocketListener.m
//  MemoNOM_iOS
//
//  Created by Bruce Yinhe on 02/02/2014.
//  Copyright (c) 2014 MemoNOM. All rights reserved.
//

#import "SocketListener.h"

#include <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>

@implementation SocketListener


- (CFSocketRef)createSocket {
    
    
    CFSocketRef myipv4cfsock = CFSocketCreate(
                                              kCFAllocatorDefault,
                                              PF_INET,
                                              SOCK_STREAM,
                                              IPPROTO_TCP,
                                              kCFSocketAcceptCallBack, handleConnect, NULL);
    
    struct sockaddr_in sin;
    
    memset(&sin, 0, sizeof(sin));
    sin.sin_len = sizeof(sin);
    sin.sin_family = AF_INET; /* Address family */
    sin.sin_port = htons(0); /* Or a specific port */
    sin.sin_addr.s_addr= INADDR_ANY;
    
    CFDataRef sincfd = CFDataCreate(
                                    kCFAllocatorDefault,
                                    (UInt8 *)&sin,
                                    sizeof(sin));
    
    CFSocketSetAddress(myipv4cfsock, sincfd);
    CFRelease(sincfd);
    
    
    CFRunLoopSourceRef socketsource = CFSocketCreateRunLoopSource(
                                                                  kCFAllocatorDefault,
                                                                  myipv4cfsock,
                                                                  0);
    
    CFRunLoopAddSource(
                       CFRunLoopGetCurrent(),
                       socketsource,
                       kCFRunLoopDefaultMode);

    return myipv4cfsock;
}

void handleConnect(
                   CFSocketRef socket,
                   CFSocketCallBackType type,
                   CFDataRef address,
                   const void *data,
                   void *info) {
    
    CFReadStreamRef readStream = NULL;
    CFWriteStreamRef writeStream = NULL;
    CFIndex bytes;
    UInt8 buffer[128];
    UInt8 recv_len = 0, send_len = 0;
    
    /* The native socket, used for various operations */
    CFSocketNativeHandle sock = *(CFSocketNativeHandle *) data;
    
    /* The punch line we stored in the socket context */
    char *punchline = info;
    
    /* Create the read and write streams for the socket */
    CFStreamCreatePairWithSocket(kCFAllocatorDefault, sock,
                                 &readStream, &writeStream);
    
    if (!readStream || !writeStream) {
        close(sock);
        fprintf(stderr, "CFStreamCreatePairWithSocket() failed\n");
        return;
    }
    
    CFReadStreamOpen(readStream);
    CFWriteStreamOpen(writeStream);
    
    /* Wait for the client to finish sending the joke; wait for newline */
    memset(buffer, 0, sizeof(buffer));
    while (!strchr((char *) buffer, '\n') && recv_len < sizeof(buffer)) {
        bytes = CFReadStreamRead(readStream, buffer + recv_len,
                                 sizeof(buffer) - recv_len);
        if (bytes < 0) {
            fprintf(stderr, "CFReadStreamRead() failed: %d\n", bytes);
            close(sock);
            return;
        }
        recv_len += bytes;
    }
    
    /* Send the punchline */
    while (send_len < (strlen(punchline+1))) {
        if (CFWriteStreamCanAcceptBytes(writeStream)) {
            bytes = CFWriteStreamWrite(writeStream,
                                       (unsigned char *) punchline + send_len,
                                       (strlen((punchline)+1) - send_len) );
            if (bytes < 0) {
                fprintf(stderr, "CFWriteStreamWrite() failed\n");
                close(sock);
                return;
            }
            send_len += bytes;
        }
        close(sock);
        CFReadStreamClose(readStream);
        CFWriteStreamClose(writeStream);
        return;
    }
    
    
}

@end
