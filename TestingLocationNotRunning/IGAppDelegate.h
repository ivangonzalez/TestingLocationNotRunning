//
//  IGAppDelegate.h
//  TestingLocationNotRunning
//
//  Created by Ivan on 01/08/14.
//  Copyright (c) 2014 Ivan Gonzalez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface IGAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locManager;

@end
