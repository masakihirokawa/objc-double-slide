//
//  ViewController.m
//  DoubleSlideSample
//
//  Created by Dolice on 2013/06/14.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //画面の背景を黒に設定
    self.view.backgroundColor = [UIColor blackColor];
    
    //マルチタッチを有効化する
    self.view.multipleTouchEnabled = YES;
    
    //背景が白のラベル初期化
    _label = [[UILabel alloc] init];
    _label.frame = self.view.bounds;
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"2本指でスライドしてください";
    
    //ラベルを画面に追加
    [self.view addSubview:_label];
}

//2本指でタッチしている場合はそれぞれの縦方向の移動距離を抽出
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 2) {
        NSInteger distance[2];
        int i = 0;
        for (UITouch *touch in touches) {
            CGPoint before = [touch previousLocationInView:self.view];
            CGPoint now = [touch locationInView:self.view];
            distance[i] = now.y - before.y;
            ++i;
        }
        CGPoint newPoint = _label.center;
        if (distance[0] > 0  && distance[1] > 0) {
            //両方とも下に動いているならラベルも下に動かす
            newPoint.y += MAX(distance[0], distance[1]);
        } else if (distance[0] < 0 && distance[1] < 0) {
            //両方とも上に動いているならラベルも上に動かす
            newPoint.y += MAX(distance[0], distance[1]);
        }
        _label.center = newPoint;
    }
}

@end
