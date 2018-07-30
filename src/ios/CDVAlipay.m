#import "CDVAlipay.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation CDVAlipay

@synthesize appId, callbackId;

-(void)pluginInitialize
{
    self.appId = [[self.commandDelegate settings] objectForKey:@"alipayid"];
    NSLog(@"cordova-plugin-alipay has been initialized. APP_ID: %@.", self.appId);
}

- (void)pay:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    NSString* orderString = [command.arguments objectAtIndex:0];

    NSLog(@"cordova-plugin-alipay pay. OrderInfo: %@.", orderString);

    if (!orderString) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:orderString]
            callbackId:self.callbackId];
    }

    NSString* appScheme = [NSString stringWithFormat:@"ali%@", self.appId];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        CDVPluginResult* pluginResult;
        
        if ([[resultDic objectForKey:@"resultStatus"]  isEqual: @"9000"]) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDic];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:resultDic]; 
        }

        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
        
    }];
}

@end