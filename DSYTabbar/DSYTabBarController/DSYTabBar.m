//
//  DSYTabBar.m
//  DSYTabbar
//
//  Created by 邓石阳 on 2019/3/22.
//  Copyright © 2019 邓石阳. All rights reserved.
//

#import "DSYTabBar.h"

@implementation DSYTabBar

-(instancetype)init{
    self = [super init];
    if (self) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        btn.bounds = CGRectMake(0, 0, 64, 64);
        self.centerBtn = btn;
        [self addSubview:btn];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.centerBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.3);
    
    int index = 0;
    CGFloat wigth = self.bounds.size.width / 3;
    
    for (UIView* sub in self.subviews) {
        
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            sub.frame = CGRectMake(index * wigth, self.bounds.origin.y, wigth, self.bounds.size.height - 2);
            
            index++;
            
            if (index == 1) {
                index++;
            }
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.centerBtn];
        
        if ( [self.centerBtn pointInside:newPoint withEvent:event]) {
            return self.centerBtn;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else {
        return [super hitTest:point withEvent:event];
    }
}

@end
