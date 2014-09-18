//
//  IGAppDelegate.m
//  TestingLocationNotRunning
//
//  Created by Ivan on 01/08/14.
//  Copyright (c) 2014 Ivan Gonzalez. All rights reserved.
//

#import "IGAppDelegate.h"

@implementation IGAppDelegate
@synthesize locManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self sendNoti:@"START"];
    [self initLoc];
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey])
    {
        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:100 identifier:@"FORCE"];
        [self locationManager:self.locManager didExitRegion:region];
    }
    return YES;
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [self sendNoti:@"EXIT"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (CLRegion *monitored in [manager monitoredRegions])
    {
        [array addObject:monitored];
        [manager stopMonitoringForRegion:monitored];
    }
    manager = nil;
    [self initLoc];
    [self startsRegion];
    if (([[locManager monitoredRegions] count] == 0))
    {
        for (CLRegion *monitored in array)
        {
            [locManager startMonitoringForRegion:monitored];
        }
        CLLocationManager *clLocAux = [[CLLocation alloc] init];
        [clLocAux startMonitoringSignificantLocationChanges];
    }
    else
    {
        exit(0);
    }
}

-(void)startsRegion
{
    int errorI = 0;
    while ([[locManager monitoredRegions] count] < 9)
    {
        ++errorI;
        if (errorI == 4)
        {
            CLLocationManager *clLocAux = [[CLLocation alloc] init];
            [clLocAux startMonitoringSignificantLocationChanges];
            break;
        }
        [self createRegions];
    }
    sleep(2);
}

-(void)createRegions
{
    CLCircularRegion *regionCircular100 = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:100 identifier:@"TEST100"];
    [locManager startMonitoringForRegion:regionCircular100];
    CLCircularRegion *regionCircular500 = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:500 identifier:@"TEST500"];
    [locManager startMonitoringForRegion:regionCircular500];
    CLCircularRegion *regionCircular1000 = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:1000 identifier:@"TEST1000"];
    [locManager startMonitoringForRegion:regionCircular1000];
    CLCircularRegion *regionCircular1500 = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:1500 identifier:@"TEST1500"];
    [locManager startMonitoringForRegion:regionCircular1500];
    CLCircularRegion *regionCircular2000 = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:2000 identifier:@"TEST2000"];
    [locManager startMonitoringForRegion:regionCircular2000];
    CLCircularRegion *regionCircular3000 = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:3000 identifier:@"TEST3000"];
    [locManager startMonitoringForRegion:regionCircular3000];
    CLCircularRegion *regionCircular4000 = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:4000 identifier:@"TEST4000"];
    [locManager startMonitoringForRegion:regionCircular4000];
    CLCircularRegion *regionCircular5000 = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:5000 identifier:@"TEST5000"];
    [locManager startMonitoringForRegion:regionCircular5000];
    CLCircularRegion *regionCircular10000 = [[CLCircularRegion alloc] initWithCenter:locManager.location.coordinate radius:10000 identifier:@"TEST10000"];
    [locManager startMonitoringForRegion:regionCircular10000];
}

-(void)sendNoti:(NSString *)mensaje
{
    UILocalNotification *reminder = [[UILocalNotification alloc] init];
    [reminder setFireDate:[NSDate date]];
    [reminder setTimeZone:[NSTimeZone localTimeZone]];
    [reminder setHasAction:YES];
    [reminder setAlertAction:@"Show"];
//    [reminder setSoundName:@"bell.mp3"];
    [reminder setAlertBody:mensaje];
    [[UIApplication sharedApplication] scheduleLocalNotification:reminder];
}

-(void)initLoc
{
    locManager = [CLLocationManager new];
    locManager.delegate = self;
    [locManager startUpdatingLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self startsRegion];
}

@end
