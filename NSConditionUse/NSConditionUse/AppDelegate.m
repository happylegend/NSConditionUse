//
//  AppDelegate.m
//  NSConditionUse
//
//  Created by 紫冬 on 13-8-30.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize arraySource = _arraysource;
@synthesize condition = _condition;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    hasBread = NO;
    
    NSMutableArray *aArraySource = [[NSMutableArray alloc] init];
    self.arraySource = aArraySource;
    [aArraySource release];
    aArraySource = nil;
    
    NSCondition *aCondition = [[NSCondition alloc] init];
    self.condition = aCondition;
    [aCondition release];
    aCondition = nil;
    
    NSThread *produceThread = [[NSThread alloc] initWithTarget:self selector:@selector(produce) object:nil];
    NSThread *consumeThread = [[NSThread alloc] initWithTarget:self selector:@selector(consume) object:nil];
    [produceThread start];
    [consumeThread start];
    
    return YES;
}

-(void)produce
{
    while (true)
    {
        [self.condition lock];
        if (!hasBread)
        {
            NSLog(@"生产一个面包");
            hasBread = YES;
            [self.condition signal];
        }
        else
        {
            [self.condition wait];
        }
        
//        if (self.arraySource.count >= 10)
//        {
//            [self.condition wait];
//        }
//        else
//        {
//            Bread *bread = [[Bread alloc] init];
//            [self.arraySource addObject:bread];
//            [self.condition signal];
//            [bread release];
//            bread = nil;
//        }
        [self.condition unlock];
    }
}

-(void)consume
{
    while (true)
    {
        [self.condition lock];
        if (hasBread)
        {
            NSLog(@"消费一个面包");
            hasBread = NO;
            [self.condition signal];
        }
        else
        {
            [self.condition wait];
        }
        
        
//        if (self.arraySource.count == 0)
//        {
//            [self.condition wait];
//        }
//        else
//        {
//            [self.arraySource removeObjectAtIndex:self.arraySource.count - 1];
//        }
        [self.condition unlock];
    }    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
