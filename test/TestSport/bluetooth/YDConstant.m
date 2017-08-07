//
//  YDConstant.m
//  SportsBar
//
//  Created by 张旻可 on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "YDConstant.h"

NSString *const YD_DB_NAME = @"YDDB22.db"; //数据库name
NSString *const YD_DB_IDENTIFIER = @"yd_local_YDDB22"; //数据库identifier

NSString *const YDBAND_DB_NAME = @"band_db_12.db"; //数据库name
NSString *const YDBAND_DB_IDENTIFIER = @"yd_local_band_db_12"; //数据库identifier

NSString *const YDPEDOMETER_DB_NAME = @"Yd_Pedometer_Db.db"; //数据库name
NSString *const YDPEDOMETER_DB_IDENTIFIER = @"yd_local_Yd_Pedometer_Db"; //数据库identifier

NSString *const YDTREASURE_DB_NAME = @"yd_treasure_db.db"; //数据库name
NSString *const YDTREASURE_DB_IDENTIFIER = @"yd_local_treasure_db"; //数据库identifier

NSString *const YDBodyFatScaleDbName = @"yd_body_fat_scale_db.db";
NSString *const YDBodyFatScaleDbIdentifier = @"yd_local_body_fat_scale_db";

NSString *const YDFITNESS_DB_NAME = @"fitness_db_2.db"; //数据库name
NSString *const YDFITNESS_DB_IDENTIFIER = @"yd_local_fitness_db_2"; //数据库identifier

NSString *const YDFITNESS_VIDEO_DB_NAME = @"fitness_video_db.db"; //数据库name
NSString *const YDFITNESS_VIDEO_DB_IDENTIFIER = @"yd_local_fitness_video_db"; //数据库identifier

NSString *const YDDOWNLOAD_DB_NAME = @"download_db.db"; //数据库name
NSString *const YDDOWNLOAD_DB_IDENTIFIER = @"yd_local_download_db"; //数据库identifier

NSString *const YDOPENHARDWARE_DB_NAME = @"Yd_OpenHardware_Db.db";
NSString *const YDOPENHARDWARE_DB_IDENTIFIER = @"yd_local_Yd_OpenHardware_Db";

NSString *const YDFRIEND_DB_NAME = @"yd_friend_db.db";
NSString *const YDFRIEND_DB_IDENTIFIER = @"yd_local_yd_friend_db";

NSString *const YDMESSAGECONTENT_DB_NAME = @"yd_message_content_db_test.db";
NSString *const YDMESSAGECONTENT_DB_IDENTIFIER = @"yd_local_yd_message_content_db";

NSString *const YDFITNESS_VIDEO_COURSE_UPDATE_TAG_PREF = @"yd_fitness_video_course_update_tag_pref";
NSString *const YDFITNESS_VIDEO_COURSE_DETAIL_PREF = @"yd_fitness_video_course_detail_pref";


NSString *const YD_NEW_USER_ADDED_EVENT_KEY = @"YD_NEW_USER_ADDED_EVENT_KEY"; //新用户上报事件已上报记录key

NSString *const URL_SHORT_CUT_RUN_OUTDOOR = @"com.sport.yuedong.run.outdoor";
NSString *const URL_SHORT_CUT_RUN_INDOOR = @"com.sport.yuedong.run.indoor";
NSString *const URL_SHORT_CUT_RIDE_BIKE = @"com.sport.yuedong.ride.bike";
NSString *const URL_SHORT_CUT_FIT_INDEX = @"com.sport.yuedong.fit.index";
NSString *const URL_SHORT_CUT_STEP_TREASURE = @"com.sport.yuedong.step.treasure";
NSString *const URL_SHORT_CUT_TAB_CHALLENGE = @"com.sport.yuedong.tab.challenge";


NSString *const APP_PREFERENCE_NAME = @"yuedong_app_preference"; //应用级缓存
NSString *const USER_PREFERENCE_NAME = @"yuedong_user_preference"; //用户级缓存
NSString *const USER_ME_VC_MODEL_PREFERENCE_NAME = @"yuedong_me_vc_model_preference";
NSString *const APP_AD_PREFERENCE_NAME = @"yuedong_ad_preference";
NSString *const APP_GRADE_PREFERENCE_NAME = @"yuedong_grade_preference";
NSString *const APP_AIM_PREFERENCE_NAME = @"yuedong_aim_prefrence";
NSString *const USER_FITNESS_VIDEO_PRE_NAME = @"fitness.video.preference";
NSString *const APP_IS_LOGIN_KEY = @"app_is_login_key"; //是否登录键
NSString *const APP_USER_ID_KEY = @"APP_USER_ID_KEY"; //已登录的userIdKey

NSString *const LAST_GOT_PD_TIME_KEY = @"LAST_GOT_PD_TIME_KEY";
NSString *const LAST_SEG_TOTAL_STEPS_KEY = @"LAST_SEG_TOTAL_STEPS_KEY";

NSString *const AUTO_STEP_UPDATE_T_KEY = @"AUTO_STEP_PUSH_ST_KEY";
NSString *const LAST_GET_SERVER_PD_TIME_KEY = @"LAST_GET_SERVER_PD_TIME_KEY";

NSString *const LAST_UPDATE_STEP_TIME_KEY = @"LAST_UPDATE_STEP_TIME_KEY";
NSString *const LAST_STEPS_KEY = @"LAST_STEPS_KEY";
NSString *const LAST_ADD_LOCAL_PUSH_TIME_KEY = @"LAST_ADD_LOCAL_PUSH_TIME_KEY";
NSString *const APP_VERSION_KEY = @"APP_VERSION_KEY";

NSString *const WAIT_UPLOAD_M7STEPS_ARR_KEY = @"WAIT_UPLOAD_M7STEPS_ARR_KEY";
NSString *const HUANXIN_PASSWORD_KEY = @"HUANXIN_PASSWORD_KEY";

NSString *const ACCOUNT_KEY = @"ACCOUNT_KEY";
NSString *const HUANXIN_USER_TYPE_KEY = @"HUANXIN_USER_TYPE_KEY";
NSString *const MEVC_MODEL_KEY = @"MEVC_MODEL_KEY";

NSString *const GRADE_KEY = @"GRADE_KEY";
NSString *const GRADE_SPE_TASKS_KEY = @"GRADE_SPE_TASKS_KEY";

NSString *const WX_QR_CODE_KEY = @"WX_QR_CODE_KEY";
NSString *const IS_WX_QR_CODE_AUTHORIZED_KEY = @"IS_WX_QR_CODE_AUTHORIZED_KEY";

NSString *const BAND_STEP = @"BAND_STEP";
NSString *const BAND_STEP_DATE = @"BAND_STEP_DATE";
NSString *const BAND_UP_STEP = @"BAND_UP_STEP";
NSString *const BAND_UP_STEP_DATE = @"BAND_UP_STEP_DATE";

NSString *const BAND_STEP_DIC = @"BAND_STEP_DIC";
NSString *const BAND_STEP_DATE_DIC = @"BAND_STEP_DATE_DIC";
NSString *const BAND_UP_STEP_DIC = @"BAND_UP_STEP_DIC";
NSString *const BAND_UP_STEP_DATE_DIC = @"BAND_UP_STEP_DATE_DIC";

NSString *const TEST_USER_AUTO_REPORT_LOG_DATE = @"TEST_USER_AUTO_REPORT_LOG_DATE";

/**
 * 用户偏好设置
 */
NSString *const VOICE_BROADCAST_IS_ON_KEY = @"VOICE_BROADCAST_IS_ON_KEY";
NSString *const AUTO_COUNTING_IS_ON_KEY = @"AUTO_COUNTING_IS_ON_KEY";
NSString *const USER_SHAKE_VOICE_ON_KEY = @"USER_SHAKE_VOICE_ON_KEY";

/**
 * Facebook app link: https://fb.me/566678436873642
 */
NSString *const FACEBOOK_APP_SHARE_URL = @"https://fb.me/566678436873642";

/**
 * AD
 */
NSString *const AD_INFOS_KEY = @"AD_INFOS_KEY";
NSString *const AD_INDEX_KEY = @"AD_INDEX_KEY";
NSString *const AD_INTERVAL_KEY = @"AD_INTERVAL_KEY";
NSString *const AD_LAST_SHOW_TIME_KEY = @"AD_LAST_SHOW_TIME_KEY";
NSString *const AD_ICON_INFOS_KEY = @"AD_ICON_INFOS_KEY";
NSString *const TOP_AD_ICON_INFOS_KEY = @"TOP_AD_ICON_INFOS_KEY";

NSString *const AD_SDK_OPEND = @"AD_SDK_OPEND";
NSString *const AD_SDK_SWITCH = @"AD_SDK_SWITCH";
NSString *const AD_SDK_SEC = @"AD_SDK_SEC";

/**
 *  每日红包
 */
NSString *const DAILY_AIM_REWARD_DIC_KEY = @"DAILY_AIM_REWARD_DIC_KEY";
NSString *const DAILY_AIM_REWARD_DRAW_TIME = @"DAILY_AIM_REWARD_DRAW_TIME";
NSString *const DAILY_AIM_CAN_DRAW_REWARD_TIME = @"DAILY_AIM_CAN_DRAW_REWARD_TIME";

/**
 *  分享红包
 */
NSString *const LAST_DRAW_SHARE_REWARD_TIME = @"LAST_DRAW_SHARE_REWARD_TIME";

/**
 *  记步存取方式更新key
 */
NSString *const STEPS_PREFERENCE_UPDATE_KEY = @"STEPS_PREFERENCE_UPDATE_KEY";

/**
 *  QQ运动红包奖励url key
 */
NSString *const QQ_SPORT_REWARD_URL_KEY = @"qq_sport_reward_url_key";

/**
 *  webview
 */
NSString *const WEB_OPEN_ON_SELF_KEY = @"open_on_self";
NSString *const WEB_BACK_TO_PREV_KEY = @"back_to_prev";
NSString *const WEB_BACK_TO_REFRESH_KEY = @"back_to_refresh";
NSString *const WEB_SHOW_SHARE_KEY = @"ios_show_share";
NSString *const WEB_CAN_PULL_REFRESH_KEY = @"yd_can_pull_refresh";
NSString *const WEB_BACK_TO_REFRESH_FUNC = @"yuedong.backToRefresh();";
NSString *const WEB_BACK_TO_URL_FUNC = @"yuedong.getBackUrl();";
NSString *const WEB_NETWORK_STATUS_CHANGE_FUNC = @"onNetworkStatusChange(%@)";

/**
 *  notification
 */
NSString *const NTF_APP_ORIENTATION_WILL_CHANGE = @"NTF_APP_ORIENTATION_WILL_CHANGE";
NSString *const NTF_APP_ORIENTATION_DID_CHANGED = @"NTF_APP_ORIENTATION_DID_CHANGED";
NSString *const NTF_MGR_VIDEO_PLAY_OVER = @"NTF_MGR_VIDEO_PLAY_OVER";
NSString *const NTF_MGR_VIDEO_PLAY_FAIL = @"NTF_MGR_VIDEO_PLAY_FAIL";
NSString *const NTF_MGR_AUDEO_PLAY_OVER = @"NTF_MGR_AUDEO_PLAY_OVER";

NSString *const NTF_HARDWARE_WEIGHT_DATA_UPDATE = @"NTF_HARDWARE_WEIGHT_DATA_UPDATE";

NSString *const APP_ID_TALKING_DATA = @"1372EC1AF69C3C6CEBA1A3CDDDE15BDC";


CGFloat const YDAchievementHeaderH = 155.f;
CGFloat const YDAchievementFooterH = 49.f;

// offline map download
NSString *const OFFLINE_DOWNLOADCLICKED_ITEM = @"OFFLINE_DOWNLOADCLICKED_ITEM";
NSString *const MGR_OFFLINE_DOWNLOADED_ITEM = @"MGR_OFFLINE_DOWNLOADED_ITEM";
NSString *const MGR_OFFLINE_DOWNLOADING_ITEM = @"MGR_OFFLINE_DOWNLOADING_ITEM";
NSString *const MGR_OFFLINE_DELETE_ITEM = @"MGR_OFFLINE_DELETE_ITEM";

// bg image
NSString *const ydNtfIndexBgImageUpdate = @"ydNtfIndexBgImageUpdate";
NSString *const ydNtfReloadCollectionView = @"ydNtfReloadCollectionView";
