//
//  EasyMapping
//
//  Copyright (c) 2012-2014 Lucas Medeiros.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "EKSerializer.h"
#import "EKFieldMapping.h"
#import "EKPropertyHelper.h"
#import "EKTransformer.h"

@implementation EKSerializer

+ (NSDictionary *)serializeObject:(id)object withMapping:(EKObjectMapping *)mapping
{
    NSMutableDictionary *representation = [NSMutableDictionary dictionary];

    [mapping.fieldMappings enumerateKeysAndObjectsUsingBlock:^(id key, EKFieldMapping *fieldMapping, BOOL *stop) {
        [self setValueOnRepresentation:representation fromObject:object withFieldMapping:fieldMapping];
    }];
    [mapping.hasOneMappings enumerateKeysAndObjectsUsingBlock:^(id key, EKObjectMapping *objectMapping, BOOL *stop) {
        [self setHasOneMappingObjectOn:representation withObjectMapping:objectMapping fromObject:object];
    }];
    [mapping.hasManyMappings enumerateKeysAndObjectsUsingBlock:^(id key, EKObjectMapping *objectMapping, BOOL *stop) {
        [self setHasManyMappingObjectOn:representation withObjectMapping:objectMapping fromObject:object];
    }];
    
    if (mapping.rootPath.length > 0) {
        representation = [@{mapping.rootPath : representation} mutableCopy];
    }
    return representation;
}

+ (NSArray *)serializeCollection:(NSArray *)collection withMapping:(EKObjectMapping *)mapping
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (id object in collection) {
        NSDictionary *objectRepresentation = [self serializeObject:object withMapping:mapping];
        [array addObject:objectRepresentation];
    }
    
    return [NSArray arrayWithArray:array];
}

+ (void)setValueOnRepresentation:(NSMutableDictionary *)representation fromObject:(id)object withFieldMapping:(EKFieldMapping *)fieldMapping
{
    id returnedValue = [object valueForKey:fieldMapping.field];
    
    if (returnedValue) {
        
        if (fieldMapping.reverseBlock) {
            returnedValue = fieldMapping.reverseBlock(returnedValue);
        }
        [self setValue:returnedValue forKeyPath:fieldMapping.keyPath inRepresentation:representation];
    }
}

+ (void)setValue:(id)value forKeyPath:(NSString *)keyPath inRepresentation:(NSMutableDictionary *)representation {
    NSArray *keyPathComponents = [keyPath componentsSeparatedByString:@"."];
    if ([keyPathComponents count] == 1) {
        [representation setObject:value forKey:keyPath];
    } else if ([keyPathComponents count] > 1) {
        NSString *attributeKey = [keyPathComponents lastObject];
        NSMutableArray *subPaths = [NSMutableArray arrayWithArray:keyPathComponents];
        [subPaths removeLastObject];
        
        id currentPath = representation;
        for (NSString *key in subPaths) {
            id subPath = [currentPath valueForKey:key];
            if (subPath == nil) {
                subPath = [NSMutableDictionary new];
                [currentPath setValue:subPath forKey:key];
            }
            currentPath = subPath;
        }
        [currentPath setValue:value forKey:attributeKey];
    }
}

+ (void)setHasOneMappingObjectOn:(NSMutableDictionary *)representation
               withObjectMapping:(EKObjectMapping *)mapping
                      fromObject:(id)object
{
    id hasOneObject = [object valueForKey:mapping.field];
    if (hasOneObject) {
        NSDictionary *hasOneRepresentation = [self serializeObject:hasOneObject withMapping:mapping];
        [representation setObject:hasOneRepresentation forKey:mapping.keyPath];
    }
}

+ (void)setHasManyMappingObjectOn:(NSMutableDictionary *)representation
                withObjectMapping:(EKObjectMapping *)mapping
                       fromObject:(id)object
{
    id hasManyObject = [object valueForKey:mapping.field];
    if (hasManyObject) {
        NSArray *hasManyRepresentation = [self serializeCollection:hasManyObject withMapping:mapping];
        [representation setObject:hasManyRepresentation forKey:mapping.keyPath];
    }
}


@end
