//
//  UIButton+block.m
//  DynaConnect
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 Dynabook. All rights reserved.
//

#import "UIButton+block.h"

#import <objc/runtime.h>
 
static const char keyActionBlock;
 
@implementation UIButton (block)
 
@dynamic actionBlock;
 
- (void)addAction:(ActionBlock)action
{
    [self addControlEvents:UIControlEventTouchUpInside Action:action];
}
 
- (void)addControlEvents:(UIControlEvents)controlEvents Action:(ActionBlock)action
{
    if (!action) {
        return;
    }
    objc_setAssociatedObject(self, &keyActionBlock, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonTarget) forControlEvents:controlEvents];
}
 
- (void)buttonTarget
{
    ActionBlock action = (ActionBlock)objc_getAssociatedObject(self, &keyActionBlock);
    if (action){
        action(self);
    }
}
 
- (void)setActionBlock:(ActionBlock)actionBlock
{
    [self addAction:actionBlock];
}
 
-(ActionBlock)actionBlock
{
    return objc_getAssociatedObject(self, &keyActionBlock);
}
 
@end
