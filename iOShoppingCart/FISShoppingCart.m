//
//  FISShoppingCart.m
//  iOShoppingCart
//
//  Created by Henry Dinhofer on 6/8/16.
//  Copyright © 2016 FIS. All rights reserved.
//

#import "FISShoppingCart.h"

@implementation FISShoppingCart

-(NSUInteger)calculateTotalPriceInCents {
    NSUInteger totalPrice = 0;
    
    if ( self.items.count != 0 )
    {
        for (FISItem *selectOneItem in self.items){
            totalPrice += selectOneItem.priceInCents;
        }
    }
    
    
    return totalPrice;
}
-(void)addItem:(FISItem *)item {
    [self.items addObject:item];
    
}
-(void)removeItem:(FISItem *)item {
    for (NSUInteger i = 0; i< self.items.count; i++) {
        FISItem *inBasketItem = self.items[i];
        if ([inBasketItem.name isEqualToString:item.name]) {
            [self.items removeObjectAtIndex:i];
            break;
        }
    }
}
-(void)removeAllItemsLikeItem:(FISItem *)item {
    [self.items removeObject:item];
}
-(void)sortItemsByNameAsc {
    NSSortDescriptor *sortByNameAsc = [NSSortDescriptor
                                       sortDescriptorWithKey:@"name"
                                       ascending:YES];
    
   NSArray *sortDescriptors = [NSArray arrayWithObject:sortByNameAsc];
    NSArray *sortedArray = [self.items sortedArrayUsingDescriptors:sortDescriptors];
    self.items = [sortedArray mutableCopy];
    
}
-(void)sortItemsByNameDesc {
    NSSortDescriptor *sortByNameDesc = [NSSortDescriptor
                                       sortDescriptorWithKey:@"name"
                                       ascending:NO];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByNameDesc];
    NSArray *sortedArray = [self.items sortedArrayUsingDescriptors:sortDescriptors];
    self.items = [sortedArray mutableCopy];

}
-(void)sortItemsByPriceInCentsAsc {
    NSSortDescriptor *sortByCentsAsc = [NSSortDescriptor
                                       sortDescriptorWithKey:@"priceInCents"
                                       ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByCentsAsc];
    NSArray *sortedArray = [self.items sortedArrayUsingDescriptors:sortDescriptors];
    self.items = [sortedArray mutableCopy];

}
-(void)sortItemsByPriceInCentsDesc {
    NSSortDescriptor *sortByCentsDesc = [NSSortDescriptor
                                        sortDescriptorWithKey:@"priceInCents"
                                        ascending:NO];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByCentsDesc];
    NSArray *sortedArray = [self.items sortedArrayUsingDescriptors:sortDescriptors];
    self.items = [sortedArray mutableCopy];
    
}
-(NSArray *)allItemsWithName:(NSString *)name {
    NSPredicate *filterMatchingName = [NSPredicate predicateWithFormat:@"name CONTAINS %@", name];
    
    
    return [self.items filteredArrayUsingPredicate:filterMatchingName];
}
-(NSArray *)allItemsWithMinimumPriceInCents:(NSUInteger)cents {
    NSPredicate *filterItemsAboveMinimimPrice = [NSPredicate predicateWithFormat:@"priceInCents >= %lu", cents];
    
    
    return [self.items filteredArrayUsingPredicate:filterItemsAboveMinimimPrice];
}
-(NSArray *)allItemsWithMaximumPriceInCents:(NSUInteger)cents {
    NSPredicate *filterAffordableItemsBelowPrice = [NSPredicate predicateWithFormat:@"priceInCents <= %lu", cents];

    
    return [self.items filteredArrayUsingPredicate:filterAffordableItemsBelowPrice];
}

@end
