#import "NSURLX.h"

@implementation NSURL (X)

- (NSURL *)hostURL
{
	return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", self.scheme, self.host]];
}

@end
