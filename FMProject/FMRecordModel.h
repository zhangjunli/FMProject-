//
//  FMRecordModel.h
//  FMProject
//
//  Created by mac on 16/6/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMRecordModel : NSObject //有声内参头部model
@property (nonatomic,strong)NSString * recordTitle;
@property (nonatomic,strong)NSString * recordEnter;
@property (nonatomic,strong)NSString * recordSupport;
@property (nonatomic,strong)NSString * recordUrl;
@property (nonatomic,strong)NSString * recordDual;
@property (nonatomic,strong)NSString * recordStatus;
@property (nonatomic,strong)NSString * recordName;

@end

@interface FMCommentModel : NSObject //有声内参评论model
@property (nonatomic,strong) NSString * commentId;
@property (nonatomic,strong) NSString * commentAuthorImg;
@property (nonatomic,strong) NSString * commentAuthorId;
@property (nonatomic,strong) NSString * commentAuthorName;
@property (nonatomic,strong) NSString * commentTime;
@property (nonatomic,strong) NSString * commentPubdate;
@property (nonatomic,strong) NSString * commentSupport;
@property (nonatomic,strong) NSString * commentReference;
@property (nonatomic,strong) NSString * commentType;
@property (nonatomic,strong) NSString * commentSplitId;
@property (nonatomic,strong) NSString * commentContent;
@property (nonatomic,strong) NSMutableArray * referListArr;

@end

@interface FMReferModel : NSObject //有声内参评论引用model
@property (nonatomic,strong) NSString * referIndex;
@property (nonatomic,strong) NSString * referId;
@property (nonatomic,strong) NSString * referAuthorName;
@property (nonatomic,strong) NSString * referTime;
@property (nonatomic,strong) NSString * referPubdate;
@property (nonatomic,strong) NSString * referSupport;
@property (nonatomic,strong) NSString * referReference;
@property (nonatomic,strong) NSString * referType;
@property (nonatomic,strong) NSString * referIsDelete;
@property (nonatomic,strong) NSString * referContent;

@end
