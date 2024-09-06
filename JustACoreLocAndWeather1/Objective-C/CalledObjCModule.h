//
//  CalledObjCModule.h
//  JustAMultiplatformAppTest1
//
//  Created by JustMacApps.net on 07/29/2024.
//  Copyright © 2023-2024 JustMacApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JmObjCSwiftEnvBridge-Bridging-Header.h"

@interface CalledObjCModule : NSObject
- (void)initInstance;
// - (void)setObjCSwiftEnvBridge:(JmObjCSwiftEnvBridge * _Nullable)jmobjcswiftenvbridge;
- (NSString * _Nullable)getInternalVariable;
- (void)sayHello:(NSString * _Nullable)message;
@end
