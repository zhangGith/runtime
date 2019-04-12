//
//  ViewController.m
//  RuntimeEssaysDemo
//
//  Created by Block on 2019/4/12.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "Person.h"
#import "Person+Custom.h"

@interface ViewController ()

@end

@implementation ViewController

+ (void)initialize {
    SEL swizzledSel = @selector(viewDidLoad);
    SEL customSel = @selector(customLoad);
    
    Class class = [self class];
    
    Method customMethod = class_getInstanceMethod(class, customSel);
    Method swizzMethod = class_getInstanceMethod(class, swizzledSel);
    
    BOOL didAddMethod = class_addMethod(class, swizzledSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
    } else {
        method_exchangeImplementations(customMethod, swizzMethod);
    }
    
}

- (void)viewDidLoad {
    
    NSLog(@"==>%s", __FUNCTION__);
    
    [super viewDidLoad];
/*
    [self performSelector:@selector(foo)];
    
    Person *per = [Person new];
    per.name = @"123";
    NSLog(@"%@", per.name);
*/

}

- (void)customLoad {
    NSLog(@"==>dddadd%s", __FUNCTION__);

}


/*

void fooMethod(id obj, SEL _cmd) {
    NSLog(@"foo method");
}

//动态添加方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(foo)) {
////        class_addMethod([self class], sel, (IMP)fooMethod, "v@:");
        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

//转换接受者
- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(foo)) {
//        return [Person new];
//    }
    return [super forwardingTargetForSelector:aSelector];
}

//完整消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(foo)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    Person *p = [Person new];
    if ([p respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:p];
    } else {
        [self doesNotRecognizeSelector:sel];
    }
    
}
 */

@end
