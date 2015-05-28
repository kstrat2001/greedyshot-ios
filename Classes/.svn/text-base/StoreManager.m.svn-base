//
//  StoreManager.m
//  collector
//
//  Created by Kain Osterholt on 3/20/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "StoreManager.h"
#import "GameSettings.h"

#define STORE_COM_TIMEOUT 15.0f

static StoreManager *sharedInstance = nil;

@implementation StoreManager

@synthesize storeDelegate;

-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        timeoutActive = false;
    }
    
    return self;
}

- (void) requestProducts
{
    if([SKPaymentQueue canMakePayments])
    {
        NSSet* productIDs = [NSSet setWithObjects:@"GreedyShot.1UP", 
                                                  @"GreedyShot.RapidFire",
                                                  @"GreedyShot.MaxOrbits",
                                                  nil];
        
        SKProductsRequest* request = [[SKProductsRequest alloc] initWithProductIdentifiers: productIDs ];
        request.delegate = self;
        [request start];
        
        timeoutActive = true;
        [self performSelector:@selector(checkTimeout:) withObject:nil afterDelay:STORE_COM_TIMEOUT];
    }
    else
    {
        [storeDelegate productsNotAvailable];
    }
}

-(void)checkTimeout:(id)sender
{
    if(timeoutActive)
    {
        [storeDelegate productsNotAvailable];
        timeoutActive = false;
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{    
    if(timeoutActive == true)
    {
        timeoutActive = false;
        [storeDelegate productsLoaded:response.products];
    }
    
    [request autorelease];
}

-(void)purchaseItem:(NSString*)productID
{
    SKMutablePayment *myPayment = [SKMutablePayment paymentWithProductIdentifier:productID];
    [[SKPaymentQueue defaultQueue] addPayment:myPayment];
    [storeDelegate purchaseRequested];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing:
                break;
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

- (void)failTransaction:(SKPaymentTransaction*)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [storeDelegate purchaseFailed:transaction.payment.productIdentifier error:transaction.error];
}

- (void)completeTransaction:(SKPaymentTransaction*)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [[GameSettings sharedInstance] purchaseItem:transaction.payment.productIdentifier];
    [storeDelegate purchaseMade:transaction.payment.productIdentifier];
}

- (void)restoreTransaction:(SKPaymentTransaction*)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [[GameSettings sharedInstance] purchaseItem:transaction.payment.productIdentifier];
    [storeDelegate purchaseMade:transaction.payment.productIdentifier];
}

#pragma mark -
#pragma mark Singleton methods


+ (StoreManager*)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[StoreManager alloc] init];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //
}

- (id)autorelease {
    return self;
}

@end
