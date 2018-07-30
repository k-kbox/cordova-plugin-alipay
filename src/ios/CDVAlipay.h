#import <Cordova/CDV.h>

@interface CDVAlipay : CDVPlugin 
    @property NSString *appId;
    @property NSString *callbackId;

    - (void)pay:(CDVInvokedUrlCommand*)command;
@end