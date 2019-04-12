//
//  Person.m
//  RuntimeEssaysDemo
//
//  Created by Block on 2019/4/12.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>
#import "Person+Custom.h"
#import "NSObject+Custom.h"

@implementation Person

- (instancetype)initWithDic:(NSDictionary *)dict {
    if (self = [super init]) {
        NSMutableArray *keys = [NSMutableArray array];
        NSMutableArray *atts = [NSMutableArray array];
        
        unsigned int outCount;
        objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];
            NSString *propertyAttri = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [atts addObject:propertyAttri];
        }
        
        free(properties);
        
        for (NSString *key in keys) {
            if ([dict valueForKey:key] == nil) {
                continue;
            }
            [self setValue:[dict valueForKey:key] forKey:key];
        }
    }
    
    return self;
}


- (void)foo {
    NSLog(@"foo");
}

- (void)dda {
    NSLog(@"ddd");
}

@end
