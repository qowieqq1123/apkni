




platformLogConfig={}



platformLogConfig.platformEnum=
{
Android=1,
IOS=2,
}



platformLogConfig.logType={


appStart="appStart",

comeinGame='comeinGame',

comeinGame_checkVersion='comeinGame_checkVersion',

comeinGame_downloadUpdate='comeinGame_downloadUpdate',

comeinGame_down20='comeinGame_down20',

comeinGame_down40='comeinGame_down40',

comeinGame_down60='comeinGame_down60',

comeinGame_down80='comeinGame_down80',

comeinGame_down100='comeinGame_down100',

comeinGame_reStart='comeinGame_reStart',

comeinGame_updateComplete='comeinGame_updateComplete',

initComplete='initComplete',

comeinGame_showUpdateTips='comeinGame_showUpdateTips',

sdkLoginComplete='sdkLoginComplete',

getserverListComplete='getserverListComplete',

reqLoginGame_clickGongGao='reqLoginGame_clickGongGao',

reqLoginGame_clickChoiceServer='reqLoginGame_clickChoiceServer',

reqLoginGame_clickentergame='reqLoginGame_clickentergame',

reqLoginGame='reqLoginGame',

createRole_clickCreatRole='createRole_clickCreatRole',

enterGameSuccess='enterGameSuccess',

clickFirstTask='clickFirstTask',
}

local efunCfg={
[logPoint.logType.appStart]="g20001",
[logPoint.logType.comeinGame]="g20002",
[logPoint.logType.comeinGame_down40]="g20021",
[logPoint.logType.comeinGame_down60]="g20041",
[logPoint.logType.comeinGame_down80]="g20061",
[logPoint.logType.comeinGame_down100]="g20081",
[logPoint.logType.comeinGame_updateComplete]="g30001",
[logPoint.logType.initComplete]="g30021",

[logPoint.logType.comeinGame_showUpdateTips]="g30061",
[logPoint.logType.sdkLoginComplete]="g30081",

[logPoint.logType.reqLoginGame_clickentergame]="g30141",
[logPoint.logType.reqLoginGame_clickChoiceServer]="g30121",
[logPoint.logType.reqLoginGame]="g30161",
[logPoint.logType.createRole_clickCreatRole]="g40001",
[logPoint.logType.enterGameSuccess]="g40023",
[logPoint.logType.clickFirstTask]="g47000",
}

local efunCfg_OM={
[logPoint.logType.appStart]="g20001",
[logPoint.logType.comeinGame]="g20021",
[logPoint.logType.comeinGame_checkVersion]="g20022",
[logPoint.logType.comeinGame_downloadUpdate]="g20023",
[logPoint.logType.comeinGame_down20]="g20024",
[logPoint.logType.comeinGame_down40]="g20025",
[logPoint.logType.comeinGame_down60]="g20026",
[logPoint.logType.comeinGame_down80]="g20027",
[logPoint.logType.comeinGame_down100]="g20028",
[logPoint.logType.comeinGame_reStart]="g20029",
[logPoint.logType.comeinGame_updateComplete]="g20081",
[logPoint.logType.initComplete]="g30021",

[logPoint.logType.comeinGame_showUpdateTips]="g30041",
[logPoint.logType.sdkLoginComplete]="g30042",

[logPoint.logType.reqLoginGame_clickentergame]="g30141",

[logPoint.logType.reqLoginGame]="g30161",
[logPoint.logType.createRole_clickCreatRole]="g40021",
[logPoint.logType.enterGameSuccess]="g40022",
[logPoint.logType.clickFirstTask]="g40023",
}

local yuenan={
[logPoint.logType.appStart]="custom_launch_game",
[logPoint.logType.comeinGame]="custom_updating_start",
[logPoint.logType.comeinGame_checkVersion]="custom_no_need_loading",

[logPoint.logType.comeinGame_down40]="custom_updating_pct_10",
[logPoint.logType.comeinGame_down60]=" custom_updating_pct_30",
[logPoint.logType.comeinGame_down80]="custom_updating_pct_60",
[logPoint.logType.comeinGame_down100]="custom_updating_pct_100",
[logPoint.logType.initComplete]="custom_game_notice_show",

[logPoint.logType.reqLoginGame_clickentergame]="custom_enter_game_button_click",
[logPoint.logType.createRole_clickCreatRole]="custom_create_role_success",

}




platformLogConfig.pfEventName=
{
["platformSDK_Android_yuenan"]=yuenan,
["platformSDK_iOS_FeiFang"]=yuenan,
["platformSDK_Android_HWFT"]=efunCfg,
["platformSDK_iOS_EFun"]=efunCfg,
["platformSDK_Android_HWOuMei"]=efunCfg_OM,
["platformSDK_iOS_EFun_Eu"]=efunCfg_OM,
["platformSDK_iOS_EFun_US"]=efunCfg_OM,
}










local efunOtherCfg_OM={
[logPoint.logType.appStart]="g20002",
}

platformLogConfig.pfOtherEventName=
{
["platformSDK_Android_HWOuMei"]=efunOtherCfg_OM,
["platformSDK_iOS_EFun_Eu"]=efunOtherCfg_OM,
["platformSDK_iOS_EFun_US"]=efunOtherCfg_OM,
}
