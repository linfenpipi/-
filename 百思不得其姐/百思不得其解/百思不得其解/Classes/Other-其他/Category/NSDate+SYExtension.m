//
//  NSDate+SYExtension.m
//  百思不得其解
//
//  Created by 孙寅 on 15/8/1.
//  Copyright (c) 2015年 孙寅. All rights reserved.
//

#import "NSDate+SYExtension.h"

@implementation NSDate (SYExtension)

- (NSDateComponents *)dateFrom:(NSDate *)from
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit  unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
    
}
@end
