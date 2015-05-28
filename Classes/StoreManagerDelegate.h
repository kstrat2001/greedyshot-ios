//
//  StoreManagerDelegate.h
//  collector
//
//  Created by Kain Osterholt on 3/20/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol StoreManagerDelegate

@optional
-(void)purchaseRequested;

@optional
-(void)productsLoaded:(NSArray*)products;

@optional
-(void)productsNotAvailable;

@optional
-(void)purchaseMade:(NSString*)productID;

@optional
-(void)purchaseFailed:(NSString*)productID error:(NSError*)error;

@optional
-(void)purchaseCancelled:(NSString*)productID;

@end
