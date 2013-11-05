#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EasingEquationType) {
    EasingEquationTypePennerLinearTween,
    EasingEquationTypePennerEaseInQuadratic,
    EasingEquationTypePennerEaseOutQuadratic,
    EasingEquationTypePennerEaseInOutQuadratic,
    EasingEquationTypePennerEaseInCubic,
    EasingEquationTypePennerEaseOutCubic,
    EasingEquationTypePennerEaseInOutCubic,
    EasingEquationTypePennerEaseInQuartic,
    EasingEquationTypePennerEaseOutQuartic,
    EasingEquationTypePennerEaseInOutQuartic,
    EasingEquationTypePennerEaseInQuintic,
    EasingEquationTypePennerEaseOutQuintic,
    EasingEquationTypePennerEaseInOutQuintic,
    EasingEquationTypePennerEaseInSine,
    EasingEquationTypePennerEaseOutSine,
    EasingEquationTypePennerEaseInOutSine,
    EasingEquationTypePennerEaseInExponential,
    EasingEquationTypePennerEaseOutExponential,
    EasingEquationTypePennerEaseInOutExponential,
    EasingEquationTypePennerEaseInCircular,
    EasingEquationTypePennerEaseOutCircular,
    EasingEquationTypePennerEaseInOutCircular
};

typedef float (*EasingEquation)(float,float,float,float);

float PennerLinearTween(float,float,float,float);
float PennerEaseInQuadratic(float,float,float,float);
float PennerEaseOutQuadratic(float,float,float,float);
float PennerEaseInOutQuadratic(float,float,float,float);
float PennerEaseInCubic(float,float,float,float);
float PennerEaseOutCubic(float,float,float,float);
float PennerEaseInOutCubic(float,float,float,float);
float PennerEaseInQuartic(float,float,float,float);
float PennerEaseOutQuartic(float,float,float,float);
float PennerEaseInOutQuartic(float,float,float,float);
float PennerEaseInQuintic(float,float,float,float);
float PennerEaseOutQuintic(float,float,float,float);
float PennerEaseInOutQuintic(float,float,float,float);
float PennerEaseInSine(float,float,float,float);
float PennerEaseOutSine(float,float,float,float);
float PennerEaseInOutSine(float,float,float,float);
float PennerEaseInExponential(float,float,float,float);
float PennerEaseOutExponential(float,float,float,float);
float PennerEaseInOutExponential(float,float,float,float);
float PennerEaseInCircular(float,float,float,float);
float PennerEaseOutCircular(float,float,float,float);
float PennerEaseInOutCircular(float,float,float,float);



@interface EasingEquations : NSObject

+(EasingEquation)easingEquationForName:(NSString*)name;
+(EasingEquation)easingEquationForType:(EasingEquationType)type;
+(NSDictionary*)easingEquationsByName;

@end
