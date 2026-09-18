








UIFullWelfareController=gameState.addListener(fullScreenUI.create())

function UIFullWelfareController:onAppStart()

local function _showWindowDailySignIn(...)self:showWindowDailySignIn(...)end
local function _showWindowSevenDaySignIn(...)self:showWindowSevenDaySignIn(...)end
local function _showWindowZongmenLevelInvestor(...)self:showWindowZongmenLevelInvestor(...)end
local function _showWindowZongmenLevelInvestor2(...)self:showWindowZongmenLevelInvestor2(...)end
local function _showWindowCdKey(...)self:showWindowCdKey(...)end
local function _showWindowKaiZongZengLi(...)self:showWindowKaiZongZengLi(...)end

local function _showWindowDailyRebate(...)self:showWindowDailyRebate(...)end
local function _showWindowInvitationCode(...)self:showWindowInvitationCode(...)end
local function _showWindowXianYuanShare(...)self:showWindowXianYuanShare(...)end
local function _showWindowSheQuAct(...)self:showWindowSheQuAct(...)end
local function _showWindowSheQuAct2(...)self:showWindowSheQuAct2(...)end
local function _showWindowSheQuAct3(...)self:showWindowSheQuAct3(...)end
local function _showWindowGuanZhuAct(...)self:showWindowGuanZhuAct(...)end
local function _showWindowWeekendWelfare(...)self:showWindowWeekendWelfare(...)end
local function _showWindowXianYouZhaoHui(...)self:showWindowXianYouZhaoHui(...)end
local function _showWindowHuiGuiBangDing(...)self:showWindowHuiGuiBangDing(...)end
local function _showWindowWXGameCircle(...)self:showWindowWXGameCircle(...)end
local function _showWindowActivityCalendar(...)self:showWindowActivityCalendar(...)end
local function _showWindowWXAddReward(...)self:showWindowWXAddReward(...)end
local function _showWindowHaoPingReward(...)self:showWindowHaoPingReward(...)end
local function _showWindowChangeAct(...)self:showWindowChangeAct(...)end
local function _showWindowJiFenShangChengFT(...)self:showWindowJiFenShangChengFT(...)end
local function _showWindowChangBao(...)self:showWindowChangBao(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _initSendPro3(...)self:initSendPro3(...)end
local function _initSendPro4(...)self:initSendPro4(...)end
local function _initSendPro5(...)self:initSendPro5(...)end
local function _initSendPro6(...)self:initSendPro6(...)end
local function _initSendPro7(...)self:initSendPro7(...)end
local function _initSendPro8(...)self:initSendPro8(...)end
local function _initSendPro9(...)self:initSendPro9(...)end
local function _initSendPro10(...)self:initSendPro10(...)end
local function _initSendPro11(...)self:initSendPro11(...)end
local function _initSendPro12(...)self:initSendPro12(...)end
local function _initSendPro13(...)self:initSendPro13(...)end
local function _initSendPro14(...)self:initSendPro14(...)end
local function _initSendPro15(...)self:initSendPro15(...)end
local function _initSendPro16(...)self:initSendPro16(...)end








local menulist=
{

{tabType=FULL_TAB_TYPE.eActivityCalendar,callback=_showWindowActivityCalendar,sendCallback=_initSendPro12,reddotType=REDDIT_SUB_TYPE.sActivityCalendar,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eActivityCalendar]},

{tabType=FULL_TAB_TYPE.eDailySignIn,callback=_showWindowDailySignIn,sendCallback=_initSendPro1,reddotType=REDDIT_SUB_TYPE.sDailySignIn,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eDailySignIn]},

{tabType=FULL_TAB_TYPE.eSevenDaySignIn,callback=_showWindowSevenDaySignIn,sendCallback=_initSendPro2,reddotType=REDDIT_SUB_TYPE.sSevenDaySignIn,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eSevenDaySignIn]},

{tabType=FULL_TAB_TYPE.eWeekendWelfare,callback=_showWindowWeekendWelfare,sendCallback=_initSendPro10,reddotType=REDDIT_SUB_TYPE.sWeekendWelfare,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eWeekendWelfare]},

{tabType=FULL_TAB_TYPE.eDailyRebate,callback=_showWindowDailyRebate,sendCallback=_initSendPro7,reddotType=REDDIT_SUB_TYPE.sDailyRebate,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eDailyRebate]},

{tabType=FULL_TAB_TYPE.eZongmenLevelInvestor,callback=_showWindowZongmenLevelInvestor,sendCallback=_initSendPro3,reddotType=REDDIT_SUB_TYPE.sZongmenLevelInvestor,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eZongmenLevelInvestor]},

{tabType=FULL_TAB_TYPE.eZongmenLevelInvestor2,callback=_showWindowZongmenLevelInvestor2,reddotType=REDDIT_SUB_TYPE.sZongmenLevelInvestor2,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eZongmenLevelInvestor2]},

{tabType=FULL_TAB_TYPE.eKaiZongZengLi,callback=_showWindowKaiZongZengLi,sendCallback=_initSendPro5,reddotType=REDDIT_SUB_TYPE.sWelfareKaiZongZengLi,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eKaiZongZengLi]},




{tabType=FULL_TAB_TYPE.eCdKey,callback=_showWindowCdKey,sendCallback=_initSendPro4,reddotType=REDDIT_SUB_TYPE.sWelfareCdKey,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eCdKey]},

{tabType=FULL_TAB_TYPE.eSheQuAct,callback=_showWindowSheQuAct,getNameFun=function()return shequModel:getSheQuActName()end,reddotType=REDDIT_SUB_TYPE.eSheQuAct,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eSheQuAct]},

{tabType=FULL_TAB_TYPE.eSheQuAct2,callback=_showWindowSheQuAct2,getNameFun=function()return shequModel:getSheQuAct2Name()end,reddotType=REDDIT_SUB_TYPE.eSheQuAct2,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eSheQuAct2]},

{tabType=FULL_TAB_TYPE.eSheQuAct3,callback=_showWindowSheQuAct3,getNameFun=function()return shequModel:getSheQuAct3Name()end,reddotType=REDDIT_SUB_TYPE.eSheQuAct3,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eSheQuAct3]},

{tabType=FULL_TAB_TYPE.eYaoQingMa,callback=_showWindowInvitationCode,sendCallback=_initSendPro8,reddotType=REDDIT_SUB_TYPE.sWelfareInvitationCode,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eYaoQingMa]},

{tabType=FULL_TAB_TYPE.eXianYuanShare,callback=_showWindowXianYuanShare,sendCallback=_initSendPro9,reddotType=REDDIT_SUB_TYPE.sXianYuanShare,checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eXianYuanShare]},

{tabType=FULL_TAB_TYPE.eGuanZhuAct,callback=_showWindowGuanZhuAct,reddotType=REDDIT_SUB_TYPE.sGuanZhuAct,checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eGuanZhuAct]},

{tabType=FULL_TAB_TYPE.eXianYouZhaoHui,callback=_showWindowXianYouZhaoHui,sendCallback=_initSendPro8,reddotType=REDDIT_SUB_TYPE.sXianYouZhaoHui,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eXianYouZhaoHui]},

{tabType=FULL_TAB_TYPE.eHuiGuiBangDing,callback=_showWindowHuiGuiBangDing,sendCallback=_initSendPro8,reddotType=REDDIT_SUB_TYPE.sHuiGuiBangDing,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eHuiGuiBangDing]},

{tabType=FULL_TAB_TYPE.eWXGameCircle,callback=_showWindowWXGameCircle,getNameFun=function()return welfareModel:getWXGameCircleName()end,sendCallback=_initSendPro11,reddotType=REDDIT_SUB_TYPE.sWXGameCircle,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eWXGameCircle]},

{tabType=FULL_TAB_TYPE.eWXAddReward,callback=_showWindowWXAddReward,sendCallback=_initSendPro13,reddotType=REDDIT_SUB_TYPE.sWXAddReward,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eWXAddReward]},

{tabType=FULL_TAB_TYPE.eHaoPingYouLi,callback=_showWindowHaoPingReward,sendCallback=_initSendPro14,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eHaoPingYouLi]},

{tabType=FULL_TAB_TYPE.eChangeAct,callback=_showWindowChangeAct,sendCallback=_initSendPro15,reddotType=REDDIT_SUB_TYPE.eChangeAct,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eChangeAct]},

{tabType=FULL_TAB_TYPE.eJiFenShangChengFT,callback=_showWindowJiFenShangChengFT,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eJiFenShangChengFT]},

{tabType=FULL_TAB_TYPE.eChangeBaoZhiYin,callback=_showWindowChangBao,sendCallback=_initSendPro16,reddotType=REDDIT_SUB_TYPE.eChangeBao,
checkOpen=WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eChangeBaoZhiYin]},
}

local args=
{
skinType=fullScreenSkinType.eSkin11,
menulist=menulist,
fullType=FULL_TYPE.eWelfare,
}
self:initUI(args)
end



function UIFullWelfareController:showWindowDailySignIn(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eDailySignIn,
showBg=true,
showTopMask=true,
viewNames={'UIDailySignInWin'},
viewArgs={['UIDailySignInWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowSevenDaySignIn(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eSevenDaySignIn,
showBg=true,
showTopMask=true,
viewNames={'UISevenDaySignInWin'},
viewArgs={['UISevenDaySignInWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowZongmenLevelInvestor(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eZongmenLevelInvestor,
showBg=true,
showTopMask=true,
viewNames={'UIZongmenLevelInvestorWin'},
viewArgs={['UIZongmenLevelInvestorWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowZongmenLevelInvestor2(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eZongmenLevelInvestor2,
showBg=true,
showTopMask=true,
viewNames={'UIZongmenLevelInvestorWin2'},
viewArgs={['UIZongmenLevelInvestorWin2']=argstable or{}},

}
self:showUI(args)
return true
end


function UIFullWelfareController:showWindowCdKey(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eCdKey,
showBg=true,
showTopMask=true,
viewNames={'UIWelfareCdKeyWin'},
viewArgs={['UIWelfareCdKeyWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowKaiZongZengLi(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eKaiZongZengLi,
showBg=true,
showTopMask=true,
viewNames={'UIWelfare_kaizonggift_win'},
viewArgs={['UIWelfare_kaizonggift_win']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowLoginReward(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eLoginReward,
showBg=true,
showTopMask=true,
viewNames={'UILoginRewardWin'},
viewArgs={['UILoginRewardWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowDailyRebate(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eDailyRebate,
showBg=true,
showTopMask=true,
viewNames={'UIDailyRebateWin'},
viewArgs={['UIDailyRebateWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowInvitationCode(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eYaoQingMa,
showBg=true,
showTopMask=true,
viewNames={'UIInvitationCodeWin'},
viewArgs={['UIInvitationCodeWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowXianYuanShare(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eXianYunJieYin,
showBg=true,
showTopMask=true,
viewNames={'UIXianYuanShareWin'},
viewArgs={['UIXianYuanShareWin']=argstable or{}},
}
self:showUI(args)

return true
end

function UIFullWelfareController:showWindowSheQuAct(argstable)
local htType=houtaiModel:getSheQuActTypeOnIndex(1)
local args=
{
tabType=FULL_TAB_TYPE.eSheQuAct,
showBg=true,
showTopMask=true,
viewNames={'UISheQuActWin'},
viewArgs={['UISheQuActWin']={htType}},
}
self:showUI(args)

return true
end

function UIFullWelfareController:showWindowSheQuAct2(argstable)
local htType=houtaiModel:getSheQuActTypeOnIndex(2)
local args=
{
tabType=FULL_TAB_TYPE.eSheQuAct2,
showBg=true,
showTopMask=true,
viewNames={'UISheQuActWin'},
viewArgs={['UISheQuActWin']={htType}},
}
self:showUI(args)

return true
end

function UIFullWelfareController:showWindowSheQuAct3(argstable)
local htType=houtaiModel:getSheQuActTypeOnIndex(3)
local args=
{
tabType=FULL_TAB_TYPE.eSheQuAct3,
showBg=true,
showTopMask=true,
viewNames={'UISheQuActWin'},
viewArgs={['UISheQuActWin']={htType}},
}
self:showUI(args)

return true
end

function UIFullWelfareController:showWindowGuanZhuAct(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eGuanZhuAct,
showBg=true,
showTopMask=true,
viewNames={'UIGuanZhuActWin'},
viewArgs={['UIGuanZhuActWin']=argstable or{}},
}
self:showUI(args)

return true
end

function UIFullWelfareController:showWindowWeekendWelfare(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eWeekendWelfare,
showBg=true,
showTopMask=true,
viewNames={'UIWeekendWelfareWin'},
viewArgs={['UIWeekendWelfareWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowXianYouZhaoHui(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eXianYouZhaoHui,
showBg=true,
showTopMask=true,
viewNames={'UIXianYouZhaoHuiWin'},
viewArgs={['UIXianYouZhaoHuiWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowHuiGuiBangDing(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eHuiGuiBangDing,
showBg=true,
showTopMask=true,
viewNames={'UIHuiGuiBangDingWin'},
viewArgs={['UIHuiGuiBangDingWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowWXGameCircle(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eWXGameCircle,
showBg=true,
showTopMask=true,
viewNames={'UIWXGameCircleWin'},
viewArgs={['UIWXGameCircleWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowActivityCalendar(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eActivityCalendar,
showBg=true,
showTopMask=true,
viewNames={'UIActivityCalendarWin'},
viewArgs={['UIActivityCalendarWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowWXAddReward(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eWXAddReward,
showBg=true,
showTopMask=true,
viewNames={'UIWXAddRewardWin'},
viewArgs={['UIWXAddRewardWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowHaoPingReward(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eHaoPingYouLi,
showBg=true,
showTopMask=true,
viewNames={'UIHaoPingYouLiWin'},
viewArgs={['UIHaoPingYouLiWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowChangeAct(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eChangeAct,
showBg=true,
showTopMask=true,
viewNames={'UIChangActWin'},
viewArgs={['UIChangActWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowJiFenShangChengFT(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eJiFenShangChengFT,
showBg=true,
showTopMask=true,
viewNames={'UIJiFenShangChengWin'},
viewArgs={['UIJiFenShangChengWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullWelfareController:showWindowChangBao(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eChangeBaoZhiYin,
showBg=true,
showTopMask=true,
viewNames={'UIChangBaoActivityWin'},
viewArgs={['UIChangBaoActivityWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullWelfareController:initSendPro1()
end

function UIFullWelfareController:initSendPro2()
end

function UIFullWelfareController:initSendPro3()
end

function UIFullWelfareController:initSendPro4()
end

function UIFullWelfareController:initSendPro5()
end

function UIFullWelfareController:initSendPro6()
end

function UIFullWelfareController:initSendPro7()
end

function UIFullWelfareController:initSendPro8()
end

function UIFullWelfareController:initSendPro9()
end

function UIFullWelfareController:initSendPro10()
end

function UIFullWelfareController:initSendPro11()
end

function UIFullWelfareController:initSendPro12()
end

function UIFullWelfareController:initSendPro13()
end

function UIFullWelfareController:initSendPro14()
end
function UIFullWelfareController:initSendPro15()
end
function UIFullWelfareController:initSendPro16()
end

function UIFullWelfareController:showMainUI()



local nextCanShowFun
for i,v in ipairs(self.subMenu)do
local isOpen=true
if v.checkOpen~=nil then
isOpen=v.checkOpen()
end
if isOpen then
local reddotSubType=v.reddotType
local showFunc=v.callback
if reddotSubType then
local isreddot=reddotClassManager.get_sub_reddot(reddotSubType)
if isreddot and showFunc then
return showFunc()
end
end
if not nextCanShowFun then
nextCanShowFun=showFunc
end
end
end

if nextCanShowFun then
return nextCanShowFun()
end


UIManager.error("暂无福利活动")
end
























