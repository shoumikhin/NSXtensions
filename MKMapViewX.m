#import "MKMapViewX.h"

#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395

@implementation MKMapView (X)

- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

- (MKCoordinateSpan)coordinateSpanWithMapView:(MKMapView *)mapView centerCoordinate:(CLLocationCoordinate2D)centerCoordinate andZoomLevel:(NSUInteger)zoomLevel
{
    double zoomScale = pow(2, 20 - zoomLevel);
    CGSize mapSize = mapView.bounds.size;
    double scaledMapWidth = mapSize.width * zoomScale;
    double scaledMapHeight = mapSize.height * zoomScale;
    
    double centerPixelX = [self longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self latitudeToPixelSpaceY:centerCoordinate.latitude];
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    CLLocationDegrees longitudeDelta = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth] - [self pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees latitudeDelta = [self pixelSpaceYToLatitude:topLeftPixelY] - [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    
    return MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
}

- (NSInteger)zoomLevel
{
    return 21 - round(log2(self.region.span.longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0 * self.bounds.size.width)));
}

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated
{
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, [self coordinateSpanWithMapView:self centerCoordinate:centerCoordinate andZoomLevel:MIN(zoomLevel, 28)]);
    
    [self setRegion:region animated:animated];
}

@end
