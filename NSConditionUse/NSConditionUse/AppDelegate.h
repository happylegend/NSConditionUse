//
//  AppDelegate.h
//  NSConditionUse
//
//  Created by 紫冬 on 13-8-30.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bread.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *_arraySource;
    NSCondition *_condition;
    BOOL hasBread;
}
@property(nonatomic, retain)NSMutableArray *arraySource;
@property(nonatomic, retain)NSCondition *condition;

@property (strong, nonatomic) UIWindow *window;

@end
