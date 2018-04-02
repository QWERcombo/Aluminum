//
//  MessageViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MessageViewController.h"
#import "FeedbackViewController.h"
#import "SmartViewController.h"
#import "TeleServiceViewController.h"

#define Button_Width  80
#define Button_Margin  ((SCREEN_WIGHT-80*3)/6)

@interface MessageViewController ()
@property (nonatomic, assign) NSInteger lastSelected;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}

- (void)setupSubViews {
    
    SmartViewController *smart = [[SmartViewController alloc] init];
    [self addChildViewController:smart];
    [smart didMoveToParentViewController:self];
    [smart.view setFrame:CGRectMake(0, 0, SCREEN_WIGHT, self.view.height-50)];
    smart.view.tag = 777;
    [self.view addSubview:smart.view];
    
    
    [self createBottomView];
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview: bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(50));
    }];
    
    NSArray *array = @[@"智能客服",@"电话客服",@"功能反馈"];
    UIButton *lastButton = nil;
    
    for (NSInteger i=0; i<3; i++) {
        
        UIButton *button = [UIButton buttonWithTitle:[array objectAtIndex:i] andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
        [button addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        NSString *selectImg = [NSString stringWithFormat:@"Message_%ld_1", i];
        NSString *unselectImg = [NSString stringWithFormat:@"Message_%ld_0", i];
        [button setImage:IMG(unselectImg) forState:UIControlStateNormal];
        [button setImage:IMG(selectImg) forState:UIControlStateSelected];
        
        [bottomView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(Button_Width));
            make.centerY.equalTo(bottomView.mas_centerY);
            if (lastButton) {
                make.left.equalTo(lastButton.mas_right).offset(2*Button_Margin);
            } else {
                make.left.equalTo(bottomView.mas_left).offset(Button_Margin);
            }
        }];
        
        button.imageEdgeInsets = UIEdgeInsetsMake(-(button.height-button.imageView.height)/2-5, (button.width-button.imageView.width)/2, (button.height-button.imageView.height)/2, (button.width-button.imageView.width)/2);
        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.height+5, -(button.imageView.width - (button.width-button.titleLabel.width)/2), 0, (button.imageView.width - (button.width-button.titleLabel.width)/2));
        
        lastButton = button;
    }
    
    self.lastSelected = 100;
    
    
}

- (void)buttonCliker:(UIButton *)sender {
    sender.selected = !sender.selected;
    UIButton *lastBtn = [self.view viewWithTag:self.lastSelected];
    lastBtn.selected = NO;
    self.title = sender.currentTitle;
    
    UIView *showView = [self.view viewWithTag:777];
    [showView removeFromSuperview];
    
    if (sender.tag == 100) {
        SmartViewController *smart = [[SmartViewController alloc] init];
        [self addChildViewController:smart];
        [smart didMoveToParentViewController:self];
        [smart.view setFrame:CGRectMake(0, 0, SCREEN_WIGHT, self.view.height-50)];
        smart.view.tag = 777;
        [self.view addSubview:smart.view];
    } else if (sender.tag == 101) {
        TeleServiceViewController *tele = [[TeleServiceViewController alloc] init];
        [self addChildViewController:tele];
        [tele didMoveToParentViewController:self];
        [tele.view setFrame:CGRectMake(0, 0, SCREEN_WIGHT, self.view.height-50)];
        tele.view.tag = 777;
        [self.view addSubview:tele.view];
    } else {
        FeedbackViewController *feed = [[FeedbackViewController alloc] init];
        [self addChildViewController:feed];
        [feed didMoveToParentViewController:self];
        [feed.view setFrame:CGRectMake(0, 0, SCREEN_WIGHT, self.view.height-50)];
        feed.view.tag = 777;
        [self.view addSubview:feed.view];
    }
    
    self.lastSelected = sender.tag;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
