//
//  MKMapViewX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <MapKit/MapKit.h>

@interface MKMapView (X)

/**
 Get the current Google Maps zoom level.
 
 @return Current zoom level from 0 (the whole world) to 21+ (individual buildings).
 */
- (NSInteger)zoomLevel;

/**
 Move map view to some location with a particular zoom level.
 
 @param centerCoordinate Central location.
 @param zoomLevel Google Maps zoom level from 0 (the whole world) to 21+ (individual buildings).
 @param animated Animate movement or not.
 */
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;

@end
