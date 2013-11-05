#import "ViewController.h"
#import "EasingEquations.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) UIView *box;
@property (strong, nonatomic) CALayer *boxLayer;
@property (strong, nonatomic) CAShapeLayer *curveLayer;
@property (strong, nonatomic) CAShapeLayer *ball;
@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) UIButton *play;
@property (strong, nonatomic) UIView *easings;
@property (strong, nonatomic) NSArray *options;
@property (strong, nonatomic) NSString *selected;

@property (strong, nonatomic) NSMutableArray *times;
@end

@implementation ViewController

-(void)loadView {
    self.view = [UIView new];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.box = [UIView new];
    self.box.translatesAutoresizingMaskIntoConstraints = NO;
    self.box.backgroundColor = [UIColor lightGrayColor];
    
    self.ball = [CAShapeLayer layer];
    self.ball.path = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:40 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    self.ball.zPosition = -1;
    [self.ball setFillColor:[UIColor blackColor].CGColor];
    [self.box.layer addSublayer:self.ball];
    
    self.play = [UIButton buttonWithType:UIButtonTypeCustom];
    self.play.translatesAutoresizingMaskIntoConstraints = NO;
    [self.play addTarget:self action:@selector(doPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.play setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    
    self.picker = [[UIPickerView alloc] init];
    self.picker.translatesAutoresizingMaskIntoConstraints = NO;
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    [self.view addSubview:self.box];
    [self.view addSubview:self.play];
    [self.view addSubview:self.picker];
    
    self.options = [EasingEquations easingEquationsByName].allKeys;
    self.selected = self.options[0];
}

-(void)viewDidLoad {
    NSDictionary *views = @{@"box":self.box, @"play":self.play, @"picker":self.picker};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[box]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[picker(==400)]" options:0 metrics:nil views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.picker
                                                           attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeCenterX
                                                          multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[play(==70)]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[picker]-[box]-[play(==70)]|" options:0 metrics:nil views:views]];
}

-(void)viewDidLayoutSubviews {
    self.ball.position = self.box.center;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.options.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.options[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selected = self.options[row];
}

-(void)doPlay {
    [CATransaction setDisableActions:YES];
    
    self.ball.position = CGPointMake(self.box.frame.origin.x + 50, self.box.bounds.size.height - 50);
    CGPoint destination = CGPointMake(self.box.frame.origin.x + self.box.bounds.size.width - 50, self.box.bounds.origin.y + 50);
    const NSTimeInterval duration = 2;
    
    NSArray *values = [self calculateValuesFrom:[NSValue valueWithCGPoint:self.ball.position]
                                             to:[NSValue valueWithCGPoint:destination]
                                    forDuration:duration
                                         easing:[EasingEquations easingEquationForName:self.selected]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.duration = duration;
    anim.values = values;
    
    [self.ball addAnimation:anim forKey:nil];
    
    [self addCurveWithValues:self.times points:values];
    self.ball.position = destination;
}

-(void)addCurveWithValues:(NSArray*)values points:(NSArray*)points {
    [self.curveLayer removeFromSuperlayer];
    self.curveLayer = [CAShapeLayer layer];
    self.curveLayer.anchorPoint = CGPointMake(0, 0);
    self.curveLayer.path = [self pathWithValues:self.times points:points].CGPath;
    self.curveLayer.lineWidth = 3;
    self.curveLayer.strokeColor = [UIColor blackColor].CGColor;
    self.curveLayer.fillColor = [UIColor clearColor].CGColor;
    self.curveLayer.zPosition = -2;
    self.curveLayer.geometryFlipped = YES;
    self.curveLayer.bounds = self.box.layer.bounds;
    self.curveLayer.position = CGPointZero;
    [self.box.layer addSublayer:self.curveLayer];
}

-(UIBezierPath*)pathWithValues:(NSArray*)times points:(NSArray*)points
{
    const float numValues = times.count;
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSUInteger i = 0;
    for (NSNumber *number in times) {
        const float v = [number floatValue];
        CGPoint p = CGPointMake(i/numValues, v);
        if (i == 0)
            [path moveToPoint:p];
        else
            [path addLineToPoint:p];
        i++;
    }
    [path applyTransform:CGAffineTransformMakeScale(self.box.frame.size.width, self.box.frame.size.height)];
    return path;
}

//slightly modified version of EasingEquations.* to allow for curve graphing
-(NSArray*)calculateValuesFrom:(id)from to:(id)to forDuration:(NSTimeInterval)duration easing:(EasingEquation)easing {
    const char *type = [from objCType];
    if (strcmp(type, @encode(CGPoint)) == 0) {
        return [self generateCGPointValuesFrom:[from CGPointValue]  to:[to CGPointValue] forDuration:duration easing:easing];
    }
    return @[from, to];
}

-(NSArray*)generateCGPointValuesFrom:(CGPoint)from to:(CGPoint)to forDuration:(NSTimeInterval)duration easing:(EasingEquation)easing {
    float numberOfKeyframes = ceilf(60 * duration) + 1;
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:numberOfKeyframes];
    self.times = [NSMutableArray array];
    
    for (size_t frame = 0; frame < numberOfKeyframes; frame++) {
        float time = easing(frame, 0, 1, numberOfKeyframes);
        CGPoint point = CGPointMake([self interpolateFrom:from.x to:to.x atTime:time],
                                    [self interpolateFrom:from.y to:to.y atTime:time]);
        [frames addObject:[NSValue valueWithCGPoint:point]];
        [self.times addObject:@(time)];
    }
    return frames;
}

-(float)interpolateFrom:(float)from to:(float)to atTime:(float)time {
    return (to - from) * time + from;
}

@end
