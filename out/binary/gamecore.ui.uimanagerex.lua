












local _uiConfig=
{
['UIDownloadLogWin']=true,
['UIDownloadButtonWin']=true,
['UILogin']=true,
['UILoading']=true,
['UICommonLoadingCloud']=true,
['UIReconnectWin']=true,

['UIGMWin']=true,
['UIHUDWin']=true,
['UIMain']=true,
['UIMainBottomWin']=true,
['UIBuildingMsgWin']=true,
['UIWorldWin']=true,

['UIWorldHUDWin']=true,
['UIWorldSymbolWin']=true,
['UIWorldUnit']=true,
['UIWorldFunctionButtonWin']=true,

['UIWorldUnitListWin2']=true,
['UIWorldExperienceWin']=true,
['UIMysteryHUDWin']=true,
['UIPlotBlackWin']=true,
['UITaskListWin']=true,
['UIFightPrepareLoading']=true,
['UIFightMainHUD']=true,
['UIFlyIconWin']=true,
['UIMysteryListWin']=true,
['UIXianZhanMapWin']=true,
['UICommandWin']=true,
['UIWeakGuideTwoWin']=true,
['UIWeakGuideOneWin']=true,
['UIAssetLoadEnterWin']=true,
['UIMoneyDetailWin']=true,
['UIHomeBuffWin']=true,
['UIXM_XMDG_MapWin']=true,
['UIXM_XMDG_MapNoneWin']=true,
['UIXianTuChengJiuTipsWin']=true,

['UIWorldBossWin']=true,
['UIMysteryEnterWin']=true,
['UIMysteryEnterZiYuanWin']=true,
['UIWorldBigBossActivityChallengeWIn']=true,
['UINPCInteractWin']=true,
['UIWorldXiuZhenJiaZuInfoWin']=true,
['UIMainXMInfoWin']=true,
['UIMainXMTaskWin']=true,
['UIMainBottomWin']=true,
['UIMainFuncBtnWin']=true,
['UIChuanSongZhenBlockWin']=true,

['UIXianJieMainWin']=true,
['UIXianJieHudWin']=true,

['UIShuiYinWin']=true,
['UIAirMiniGameHUDWin']=true,
['UIWebViewWin']=true,
['UIXianJie_ZMttackerWin']=true,
['UIPlotDecorationWin']=true,
['UIXiaoZhuShouWin']=true,
['UIMoJieMoJunAttackTipsWin']=true,




}


local _noPauseTimer=
{
['UIReconnectWin']=true,
}


local _loginStateIgnoreAll=
{
['UILogin']=true,
}

function UIManager:isCanPauseTimer(name)
return not _noPauseTimer[name]
end

function UIManager:addIgonreWindow(name)
_uiConfig[name]=true
end

function UIManager:forbidCloseByAll(name)
return _loginStateIgnoreAll[name]
end

function UIManager:showWindow(name,...)
if _uiConfig[name]then
return UIManager:showWindowImp(name,...)
end
return baseFullScreenUI:showWindow(name,...)
end

function UIManager:closeWindow(name,forceClose)
if _uiConfig[name]then
return UIManager:closeWindowImp(name,forceClose)
end
return baseFullScreenUI:closeWindow(name,forceClose)
end

function UIManager:hideWindow(name)
if _uiConfig[name]then
return UIManager:hideWindowImp(name)
end
return baseFullScreenUI:hideWindow(name)
end


function UIManager:setArgs(name,args)
self._args[name]=args
end

function UIManager:getArgs(name)
return self._args[name]
end

function UIManager:freshBackArgs(name)
self:setBackArgs(name,self._args[name])
end

function UIManager:setBackArgs(name,args)
self._backargs[name]=args
end

function UIManager:getBackArgs(name)
return self._backargs[name]
end




