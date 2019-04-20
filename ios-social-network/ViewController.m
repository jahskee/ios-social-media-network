//
//  ViewController.m
//  ios-social-network
//
//  Created by Mac on 4/20/19.
//  Copyright © 2019 senapps. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UITextView *facebookTextView;
@property (weak, nonatomic) IBOutlet UITextView *moreTextView;

- (void) configureTweetTextView;
- (void) showAlertMessage: (NSString *) myMessage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureTweetTextView];
}

- (void) showAlertMessage: (NSString *) myMessage {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"TwitterShare" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style: UIAlertActionStyleDefault handler: nil];
    [alertController addAction: okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)showShareAction:(id)sender {
    if ([self.tweetTextView isFirstResponder] ) {
        [self.tweetTextView resignFirstResponder];
    }
    // define alert dialog box
    UIAlertController *actionController = [UIAlertController
        alertControllerWithTitle: @"Share"
        message: @""
        preferredStyle: UIAlertControllerStyleAlert];
    
    // define alert cancel button
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [actionController addAction:cancelAction];
    
    // define alert tweet button
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action){
                                        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                                            // Tweet out the tweet
                                            SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                            
                                            if ( [self.tweetTextView.text length] < 140) {
                                                [twitterVC setInitialText:self.tweetTextView.text];
                                            } else {
                                                NSString *shortText = [self.tweetTextView.text substringToIndex:140];
                                                [twitterVC setInitialText: shortText];
                                            }
                                            
                                            [self presentViewController:twitterVC animated:YES completion:nil];
                                        } else {
                                            // Raise some kind of objection
                                            [self showAlertMessage:@"Please sign in to twitter before you tweet"];
                                        }
                                    }];
    
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"Post to Facebook" style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action){
                                    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                                        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                                        [facebookVC setInitialText:self.tweetTextView.text];
                                        [self presentViewController:facebookVC animated:YES completion:nil];
                                        
                                     } else {
                                         [self showAlertMessage:@"Please sign in to Facebook"];
                                     }
                                }];
 
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"More" style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action){
                                   UIActivityViewController *moreVC = [[UIActivityViewController alloc]
                                   initWithActivityItems:@[self.tweetTextView.text] applicationActivities:nil];
                                   [self presentViewController:moreVC animated:YES completion:nil];
                               }];
    // add buttons to alert dialog box
    [actionController addAction:tweetAction];
    [actionController addAction:facebookAction];
    [actionController addAction:moreAction];
     [actionController addAction:cancelAction];
    // display the alert dialog box
    [self presentViewController: actionController animated: YES completion: nil];
}

- (void) configureTweetTextView {
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed: 1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha: 0.5].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;
}
@end
