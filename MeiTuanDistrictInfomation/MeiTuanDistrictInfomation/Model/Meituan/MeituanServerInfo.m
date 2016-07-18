//
//  MeituanServerInfo.m
//
//  Created by 希哥  on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MeituanServerInfo.h"


NSString *const kMeituanServerInfoTraceId = @"traceId";


@interface MeituanServerInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MeituanServerInfo

@synthesize traceId = _traceId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.traceId = [self objectOrNilForKey:kMeituanServerInfoTraceId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.traceId forKey:kMeituanServerInfoTraceId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.traceId = [aDecoder decodeObjectForKey:kMeituanServerInfoTraceId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_traceId forKey:kMeituanServerInfoTraceId];
}

- (id)copyWithZone:(NSZone *)zone
{
    MeituanServerInfo *copy = [[MeituanServerInfo alloc] init];
    
    if (copy) {

        copy.traceId = [self.traceId copyWithZone:zone];
    }
    
    return copy;
}


@end
