//
//  NSObject+Custom.m
//  RuntimeEssaysDemo
//
//  Created by Block on 2019/4/12.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "NSObject+Custom.h"
#import <objc/message.h>

@implementation NSObject (Custom)

- (void)bk_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    //拿到当前类名，在前面加上 NSKVONotifying_ 前缀创建一个新的类名
    NSString *oldClassName = NSStringFromClass(self.class);
    NSString *newClassName = [NSString stringWithFormat:@"NSKVONotifying_%@", oldClassName];
    //创建一个当前类的子类，并以新类名命名
    Class NewClass = objc_allocateClassPair(self.class, newClassName.UTF8String, 0);
    //为这个新类添加一个方法
    class_addMethod(NewClass, @selector(setName:), (IMP)setName, "v@:@");
    //把新创建的子类注册进运行时环境，使其可用
    objc_registerClassPair(NewClass);
    //把调用 my_addObserver 方法的对象的 isa 指针设置为新创建的子类
    object_setClass(self, NewClass);
    //把观察者关联到 self 上，使得可以在 setName 函数中取出
    objc_setAssociatedObject(self, "name", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)bk_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

void setName(id self, SEL _cmd, NSString *str) {
    Ivar ivar = class_getInstanceVariable([self class], "name");
    object_setIvar(self, ivar, str);
    NSObject *observer = objc_getAssociatedObject(self, "name");
    if ([observer respondsToSelector:@selector(bk_observeValueForKeyPath:ofObject:change:context:)]) {
        [observer bk_observeValueForKeyPath:@"name" ofObject:self change:@{NSKeyValueChangeNewKey : str} context:nil];
    }
}

@end
