//
//  StoreManager.h
//  collector
//
//  Created by Kain Osterholt on 3/20/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#import "StoreManagerDelegate.h"

@interface StoreManager : NSObject  <SKProductsRequestDelegate,
                                    SKPaymentTransactionObserver>
{
    id <StoreManagerDelegate> storeDelegate;
    bool timeoutActive;
}

@property (nonatomic, assign) id <StoreManagerDelegate> storeDelegate;
- (void) requestProducts;

- (void)purchaseItem:(NSString*)productID;
- (void)failTransaction:(SKPaymentTransaction*)transaction;
- (void)completeTransaction:(SKPaymentTransaction*)transaction;
- (void)restoreTransaction:(SKPaymentTransaction*)transaction;

// Singleton
+ (StoreManager*)sharedInstance;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;

@end
