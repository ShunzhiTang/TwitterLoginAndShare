//
//  ViewController.m
//  TSZTwitterLoginAndShare
//
//  Created by tang on 16/3/8.
//  Copyright © 2016年 shunzhitang. All rights reserved.
//

#import "ViewController.h"

#import <TwitterKit/TwitterKit.h>

@interface ViewController ()

@property (nonatomic , strong) NSString *userID;

@property (nonatomic , strong) NSString *userName;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        
        if (session) {
            // Callback for login success or failure. The TWTRSession
            // is also available on the [Twitter sharedInstance]
            // singleton.
            //
            // Here we pop an alert just to give an example of how
            // to read Twitter user info out of a TWTRSession.
            //
            // TODO: Remove alert and use the TWTRSession's userID
            // with your app's user model
            NSString *message = [NSString stringWithFormat:@"@%@ logged in! (%@)",
                                 [session userName], [session userID]];
            
            self.userName = [session userName];
            self.userID = [session userID];
            
            
            NSLog(@"%@" , message);
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged in!"
//                                                            message:message
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
        } else {
            NSLog(@"Login error: %@", [error localizedDescription]);
        }
    }];
    
    // TODO: Change where the log in button is positioned in your view
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];
    




}



- (IBAction)clickLoadTweet:(id)sender {
    
   NSString *userID = [Twitter sharedInstance].sessionStore.session.userID;
    
    NSLog(@"%@" , userID);
    TWTRComposer *composer = [[TWTRComposer alloc] init];
    
    [composer setText:@"just setting up my Fabric"];
    [composer setImage:[UIImage imageNamed:@"chile"]];
    
    // Called from a UIViewController
    [composer showFromViewController:self completion:^(TWTRComposerResult result) {
        

        if (result == TWTRComposerResultCancelled) {
            
            NSLog(@"Tweet composition cancelled");
        }
        else {
            NSLog(@"Sending Tweet!");
        }
    }];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
