#import <QuartzCore/QuartzCore.h>
#import "EasingEquations.h"

@interface CAKeyframeAnimation (WX2EasingEquations)
+(id)animationWithKeyPath:(NSString *)path duration:(NSTimeInterval)duration startValue:(id)start endValue:(id)end easing:(EasingEquationType)easing;
@end
