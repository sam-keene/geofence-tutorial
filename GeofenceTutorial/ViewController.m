//
//  ViewController.m
//  GeofenceTutorial
//
//  Created by Sam Keene on 2/18/13.
//  Copyright (c) 2013 Sam Keene. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

CLLocationManager *_locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Check to ensure location services are enabled
    if(![CLLocationManager locationServicesEnabled]) {
        //handle location services disabled
        return;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    
    if (_locationManager == nil) {
        NSLog(@"*** _locationManager == nil");
        [NSException raise:@"Location Manager Not Initialized" format:@"You must initialize location manager first."];
    }
    
    if(![CLLocationManager regionMonitoringAvailable]) {
        // location serives unavilable on device
        return;
    }
    
    NSString *title = @"Times Square NYC";
    
    CLLocationDegrees latitude = 40.755417;
    CLLocationDegrees longitude =-73.991225;
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    CLLocationDistance regionRadius = 50;
    
    CLRegion *timesSquare = [[CLRegion alloc] initCircularRegionWithCenter:centerCoordinate
                                                   radius:regionRadius
                                               identifier:title];
    
    [_locationManager startMonitoringForRegion:timesSquare];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Entered Region - %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"Exited Region - %@", region.identifier);
    UIApplication *app                = [UIApplication sharedApplication];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    if (notification == nil)
        return;
    notification.alertBody = [NSString stringWithFormat:@"You have exited Times Square"];
    notification.alertAction = @"Times Square";
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 1;
    [app presentLocalNotificationNow:notification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
