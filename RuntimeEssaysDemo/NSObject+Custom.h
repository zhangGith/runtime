//
//  NSObject+Custom.h
//  RuntimeEssaysDemo
//
//  Created by Block on 2019/4/12.
//  Copyright © 2019年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Custom)

- (void)bk_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)bk_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context;

@end
