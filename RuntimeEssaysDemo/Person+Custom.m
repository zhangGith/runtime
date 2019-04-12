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

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, "name");
}

@end
