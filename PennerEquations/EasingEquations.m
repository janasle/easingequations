#import "EasingEquations.h"
#include <math.h>

float PennerLinearTween(float t, float b, float c, float d) {
    return c*(t/d) + b;
}

float PennerEaseInQuadratic(float t, float b, float c, float d) {
    t /= d;
	return c*t*t + b;
}

float PennerEaseOutQuadratic(float t, float b, float c, float d) {
    t /= d;
	return -c * t*(t-2) + b;
}

float PennerEaseInOutQuadratic(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return c/2*t*t + b;
	t--;
	return -c/2 * (t*(t-2) - 1) + b;
}

float PennerEaseInCubic(float t, float b, float c, float d) {
    t /= d;
	return c*t*t*t + b;
}

float PennerEaseOutCubic(float t, float b, float c, float d) {
    t /= d;
	t--;
	return c*(t*t*t + 1) + b;
}

float PennerEaseInOutCubic(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return c/2*t*t*t + b;
	t -= 2;
	return c/2*(t*t*t + 2) + b;
}

float PennerEaseInQuartic(float t, float b, float c, float d) {
    t /= d;
	return c*t*t*t*t + b;
}

float PennerEaseOutQuartic(float t, float b, float c, float d) {
    t /= d;
	t--;
	return -c * (t*t*t*t - 1) + b;
}

float PennerEaseInOutQuartic(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return c/2*t*t*t*t + b;
	t -= 2;
	return -c/2 * (t*t*t*t - 2) + b;
}

float PennerEaseInQuintic(float t, float b, float c, float d) {
    t /= d;
	return c*t*t*t*t*t + b;
}

float PennerEaseOutQuintic(float t, float b, float c, float d) {
    t /= d;
	t--;
	return c*(t*t*t*t*t + 1) + b;
}

float PennerEaseInOutQuintic(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return c/2*t*t*t*t*t + b;
	t -= 2;
	return c/2*(t*t*t*t*t + 2) + b;
}

float PennerEaseInSine(float t, float b, float c, float d) {
   return -c * cosf(t/d * (M_PI/2)) + c + b;
}
    
float PennerEaseOutSine(float t, float b, float c, float d) {
    return c * sinf(t/d * (M_PI/2)) + b;
}

float PennerEaseInOutSine(float t, float b, float c, float d) {
    return -c/2 * (cosf(M_PI*t/d) - 1) + b;
}

float PennerEaseInExponential(float t, float b, float c, float d) {
    return c * powf( 2, 10 * (t/d - 1) ) + b;
}
    
float PennerEaseOutExponential(float t, float b, float c, float d) {
    return c * ( -powf( 2, -10 * t/d ) + 1 ) + b;
}

float PennerEaseInOutExponential(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return c/2 * powf( 2, 10 * (t - 1) ) + b;
	t--;
	return c/2 * ( -powf( 2, -10 * t) + 2 ) + b;
}

float PennerEaseInCircular(float t, float b, float c, float d) {
    t /= d;
	return -c * (sqrtf(1 - t*t) - 1) + b;
}

float PennerEaseOutCircular(float t, float b, float c, float d) {
    t /= d;
	t--;
	return c * sqrtf(1 - t*t) + b;
}

float PennerEaseInOutCircular(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return -c/2 * (sqrtf(1 - t*t) - 1) + b;
	t -= 2;
	return c/2 * (sqrtf(1 - t*t) + 1) + b;
}

@implementation EasingEquations

+(EasingEquation)easingEquationForName:(NSString *)name {
    return [EasingEquations easingEquationForType:[[EasingEquations easingEquationsByName][name] intValue]];
}

+(EasingEquation)easingEquationForType:(EasingEquationType)type {
    return [[EasingEquations easingEquationsByType][@(type)] pointerValue];
}

+(NSDictionary*)easingEquationsByName {
    static NSDictionary *map;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{@"Ease In Circular": @(EasingEquationTypePennerEaseInCircular),
                @"Ease Out Circular": @(EasingEquationTypePennerEaseOutCircular),
                @"Ease In Ease Out Circular": @(EasingEquationTypePennerEaseInOutCircular),
                @"Ease In Quintic": @(EasingEquationTypePennerEaseInQuintic),
                @"Ease Out Quintic": @(EasingEquationTypePennerEaseOutQuintic),
                @"Ease In Ease Out Quintic": @(EasingEquationTypePennerEaseInOutQuintic),
                @"Ease In Quartic": @(EasingEquationTypePennerEaseInQuartic),
                @"Ease Out Quartic": @(EasingEquationTypePennerEaseOutQuartic),
                @"Ease In Ease Out Quartic": @(EasingEquationTypePennerEaseInOutQuartic),
                @"Ease In Quadratic": @(EasingEquationTypePennerEaseInQuadratic),
                @"Ease Out Quadratic": @(EasingEquationTypePennerEaseOutQuadratic),
                @"Ease In Ease Out Quadratic": @(EasingEquationTypePennerEaseInOutQuadratic),
                @"Ease In Exponential": @(EasingEquationTypePennerEaseInExponential),
                @"Ease Out Exponential": @(EasingEquationTypePennerEaseOutExponential),
                @"Ease In Ease Out Exponential": @(EasingEquationTypePennerEaseInOutExponential),
                @"Ease In Sine": @(EasingEquationTypePennerEaseInSine),
                @"Ease Out Sine": @(EasingEquationTypePennerEaseOutSine),
                @"Ease In Ease Out Sine": @(EasingEquationTypePennerEaseInOutSine),
                @"Ease In Cubic": @(EasingEquationTypePennerEaseInCubic),
                @"Ease Out Cubic": @(EasingEquationTypePennerEaseOutCubic),
                @"Ease In Ease Out Cubic": @(EasingEquationTypePennerEaseInOutCubic),
                @"Linear Tween": @(EasingEquationTypePennerLinearTween)
                };
    });
    return map;
}

+(NSDictionary*)easingEquationsByType {
    static NSDictionary *map;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{@(EasingEquationTypePennerEaseInCircular): [NSValue valueWithPointer:&PennerEaseInCircular],
                @(EasingEquationTypePennerEaseOutCircular): [NSValue valueWithPointer:&PennerEaseOutCircular],
                @(EasingEquationTypePennerEaseInOutCircular): [NSValue valueWithPointer:&PennerEaseInOutCircular],
                @(EasingEquationTypePennerEaseInQuintic): [NSValue valueWithPointer:&PennerEaseInQuintic],
                @(EasingEquationTypePennerEaseOutQuintic): [NSValue valueWithPointer:&PennerEaseOutQuintic],
                @(EasingEquationTypePennerEaseInOutQuintic): [NSValue valueWithPointer:&PennerEaseInOutQuintic],
                @(EasingEquationTypePennerEaseInQuartic): [NSValue valueWithPointer:&PennerEaseInQuartic],
                @(EasingEquationTypePennerEaseOutQuartic): [NSValue valueWithPointer:&PennerEaseOutQuartic],
                @(EasingEquationTypePennerEaseInOutQuartic): [NSValue valueWithPointer:&PennerEaseInOutQuartic],
                @(EasingEquationTypePennerEaseInQuadratic): [NSValue valueWithPointer:&PennerEaseInQuadratic],
                @(EasingEquationTypePennerEaseOutQuadratic): [NSValue valueWithPointer:&PennerEaseOutQuadratic],
                @(EasingEquationTypePennerEaseInOutQuadratic): [NSValue valueWithPointer:&PennerEaseInOutQuadratic],
                @(EasingEquationTypePennerEaseInExponential): [NSValue valueWithPointer:&PennerEaseInExponential],
                @(EasingEquationTypePennerEaseOutExponential): [NSValue valueWithPointer:&PennerEaseOutExponential],
                @(EasingEquationTypePennerEaseInOutExponential): [NSValue valueWithPointer:&PennerEaseInOutExponential],
                @(EasingEquationTypePennerEaseInSine): [NSValue valueWithPointer:&PennerEaseInSine],
                @(EasingEquationTypePennerEaseOutSine): [NSValue valueWithPointer:&PennerEaseOutSine],
                @(EasingEquationTypePennerEaseInOutSine): [NSValue valueWithPointer:&PennerEaseInOutSine],
                @(EasingEquationTypePennerEaseInCubic): [NSValue valueWithPointer:&PennerEaseInCubic],
                @(EasingEquationTypePennerEaseOutCubic): [NSValue valueWithPointer:&PennerEaseOutCubic],
                @(EasingEquationTypePennerEaseInOutCubic): [NSValue valueWithPointer:&PennerEaseInOutCubic],
                @(EasingEquationTypePennerLinearTween): [NSValue valueWithPointer:&PennerLinearTween]
                };

    });
    return map;
}

@end
