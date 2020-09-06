//
//  main.m
//  Test
//
//  Created by huipeng on 2020/9/6.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc] init];
        [person eat];
    }
    return 0;
}
