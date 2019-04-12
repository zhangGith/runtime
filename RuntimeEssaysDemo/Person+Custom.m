//
//  Person+Custom.m
//  RuntimeEssaysDemo
//
//  Created by Block on 2019/4/12.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "Person+Custom.h"
#import <objc/message.h>

@implementation Person (Custom)

- (void)setClass_name:(NSString *)class_name {
    objc_setAssociatedObject(self, "class_name", class_name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)class_name {
    return objc_getAssociatedObject(self, "class_name");
}

@end
