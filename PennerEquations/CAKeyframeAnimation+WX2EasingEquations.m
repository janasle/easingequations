#import "CAKeyframeAnimation+WX2EasingEquations.h"

typedef id(^Interpolate)(float time);

@implementation CAKeyframeAnimation (WX2EasingEquations)

+(id)animationWithKeyPath:(NSString *)path duration:(NSTimeInterval)duration startValue:(id)start endValue:(id)end easing:(EasingEquationType)easing {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:path];
    anim.duration = duration;
    anim.values = [self calculateValuesFrom:start to:end forDuration:duration easing:[EasingEquations easingEquationForType:easing]];
    return anim;
}

+(NSArray*)calculateValuesFrom:(id)from to:(id)to forDuration:(NSTimeInterval)duration easing:(EasingEquation)easing {
    const char *type = [from objCType];
    if (strcmp(type, @encode(float)) == 0) {
        return [self generateValuesForDuration:duration easing:easing interpolate:^id(float time) {
            return @([self interpolateFrom:[from floatValue] to:[to floatValue] atTime:time]);
        }];
    }
    if (strcmp(type, @encode(CGPoint)) == 0) {
        return [self generateValuesForDuration:duration easing:easing interpolate:^id(float time) {
            return [NSValue valueWithCGPoint:CGPointMake([self interpolateFrom:[from CGPointValue].x to:[to CGPointValue].x atTime:time],
                                                         [self interpolateFrom:[from CGPointValue].y to:[to CGPointValue].y atTime:time])];
        }];
    }
    return @[from, to];
}

+(NSArray*)generateValuesForDuration:(NSTimeInterval)duration easing:(EasingEquation)easing interpolate:(Interpolate)interpolate {
    float numberOfKeyframes = ceilf(60 * duration) + 2;
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:numberOfKeyframes];
    
    for (float frame = 0; frame < numberOfKeyframes; frame++) {
        float time = easing(frame, 0, 1, numberOfKeyframes);
        [frames addObject:interpolate(time)];
    }
    return frames;
}

+(float)interpolateFrom:(float)from to:(float)to atTime:(float)time {
    return (to - from) * time + from;
}

@end
