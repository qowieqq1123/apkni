







def_class("UIWuXingDianMainWin",UIWindowBase)









function UIWuXingDianMainWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.leftPanel=UIObject.get(self,1)
self.linggenBtn=UIButton.get(self,2)
self.modelBg=UIObject.get(self,3)
self.modelTop=UIObject.get(self,4)
self.nomalRoot=UIObject.get(self,5)
self.rightPanel=UIObject.get(self,6)
self.saodangBtn=UIButton.get(self,7)
self.saodangReddot=UIObject.get(self,8)
self.sdRoot=UIObject.get(self,9)
self.selectText=UIText.get(self,10)
self.shengDianBg=UIObject.get(self,11)
self.shengDianBtn=UIObject.get(self,12)
self.shengDianReddot=UIObject.get(self,13)
self.shengDianSelect=UIObject.get(self,14)
self.tabBg=UIObject.get(self,15)
self.tabBtn=UIButton.get(self,16)
self.wuxingDianBg=UIObject.get(self,17)
self.wuxingDianBtn=UIObject.get(self,18)
self.wuxingDianSelect=UIObject.get(self,19)
self.wuxingNewReddot=UIObject.get(self,20)
self.wuxingReddot=UIObject.get(self,21)
self.wxRoot=UIObject.get(self,22)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.linggenBtn:setButtonClick(function()self:onLinggenBtn()end)

self.saodangBtn:setButtonClick(function()self:onSaodangBtn()end)

self.tabBtn:setButtonClick(function()self:onTabBtn()end)



end


function UIWuXingDianMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.linggenBtn);self.linggenBtn=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.modelTop);self.modelTop=nil;
_UIObject_release(self.nomalRoot);self.nomalRoot=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.saodangBtn);self.saodangBtn=nil;
_UIObject_release(self.saodangReddot);self.saodangReddot=nil;
_UIObject_release(self.sdRoot);self.sdRoot=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.shengDianBg);self.shengDianBg=nil;
_UIObject_release(self.shengDianBtn);self.shengDianBtn=nil;
_UIObject_release(self.shengDianReddot);self.shengDianReddot=nil;
_UIObject_release(self.shengDianSelect);self.shengDianSelect=nil;
_UIObject_release(self.tabBg);self.tabBg=nil;
_UIObject_release(self.tabBtn);self.tabBtn=nil;
_UIObject_release(self.wuxingDianBg);self.wuxingDianBg=nil;
_UIObject_release(self.wuxingDianBtn);self.wuxingDianBtn=nil;
_UIObject_release(self.wuxingDianSelect);self.wuxingDianSelect=nil;
_UIObject_release(self.wuxingNewReddot);self.wuxingNewReddot=nil;
_UIObject_release(self.wuxingReddot);self.wuxingReddot=nil;
_UIObject_release(self.wxRoot);self.wxRoot=nil;
end

















local _itemCard={0,1,2,3,4}
local _bgFMT='image_wxsdct_{0}'
local _modelList={4874,4875,4876,4877,4878}
local _effectList={10388,10389,10390,10391,10392}
local _grayABformat='ui/windows/wuxingdian/sharedtextures/wxd_men_{0}.ab'
local _grayAssetformat='wxd_men_{0}'

function UIWuXingDianMainWin:onLoaded(...)
self:bindComponents()
if verifyManager:isHideBusinessActivity()then
local obj=self:FindTransform("layout/root/#sdRoot/rightPanel/prizeBtn").gameObject
if obj then
obj:SetActive(false)
end
end
wuXingDianController:send_25_22()
end

function UIWuXingDianMainWin:__delete()
self:unbindComponents()
end








function UIWuXingDianMainWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local wxdId=argtable.wxdId
if wxdId==nil and wuXingDianModel:isOpenSDByData()then
wxdId=wuXingDianConfig.getSDType()
end
if wxdId==-1 then wxdId=nil end
if wuXingDianConfig.isSD(wxdId)and not wuXingDianModel:isOpenSDByData()then
wxdId=nil
end
self.wxdId=wxdId
local ani
if wxdId==nil or not wuXingDianConfig.isSD(wxdId)then
ani=eAnimationID.stand2
else
ani=eAnimationID.stand
end

local slayer=argtable.layer
if wxdId~=nil then
self.selectLayer=slayer
self.needjump=true
end
self.modelBg:setChildSpineAnimation(ani,1,nil)
self:stopAllTimer()
self:freshInfo()
end

function UIWuXingDianMainWin:onShowArgRecv(argtable)
argtable=argtable or{}
local wxdId=argtable.wxdId
if wxdId==nil and wuXingDianModel:isOpenSDByData()then
wxdId=wuXingDianConfig.getSDType()
end
self.wxdId=wxdId
local ani
if wxdId==nil or not wuXingDianConfig.isSD(wxdId)then
ani=eAnimationID.stand2
else
ani=eAnimationID.stand
end
self.modelBg:setChildSpineAnimation(ani,1,nil)
self:freshInfo()
end

function UIWuXingDianMainWin:onHide()

end





function UIWuXingDianMainWin:onCloseBtn()
if self.wxdId==nil then
self.closeBtn:setActive(false)
UIFullWuXingDianControl:closeUI(nil,true)
elseif not wuXingDianConfig.isSD(self.wxdId)then
local wxdId=self.wxdId
self.wxdId=nil
self:fadeoutWXInfoPanel(wxdId,0.7,function()
self:freshInfo(0.1)
end)
else
self.closeBtn:setActive(false)
UIFullWuXingDianControl:closeUI(nil,true)
end
end



function UIWuXingDianMainWin:onShengDianBtn()
if wuXingDianConfig.isSD(self.wxdId)then return end
local wxdId=wuXingDianConfig.getSDType()
local ret,args=wuXingDianModel:isWXDOpen(wxdId)
if not ret then
local tips=wuXingDianModel:getWarnTips(args)
UIManager.error(tips)
return
end
self.wxdId=wxdId
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.firstOpenWXD_SD)
self:fadeoutWXPanel(0.8,function()
self:freshInfo(0.5)
end)
end



function UIWuXingDianMainWin:onWuxingDianBtn()
if self.wxdId==nil then return end
local old=self.wxdId
self.wxdId=nil
if wuXingDianConfig.isSD(old)then
self:fadeoutSDPanel(0.8,function()
self:freshInfo(0.5)
end)
else
self:fadeoutWXPanel(0.8,function()
self:freshInfo(0.5)
end)
end
end



function UIWuXingDianMainWin:onWanfaHelp()
local descFMT='UIWuXingDianMainWin_wanfa_%s'
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=descFMT})
end

function UIWuXingDianMainWin:onPrizeBtn()
if wuXingDianConfig.isSD(self.wxdId)then
local func=function(args_)
UIFullWuXingDianControl:showWuXingDian(args_)
end
fullScreenUI.setNextActiveUICallback(func)
UIFullTotalTouZiActivityontrol:showMenuWindow({menuType=TZ_MENU_TYPE.eWXSDRewards,wxdId=self.wxdId})
return
end
UIManager:showWindow('UIWuXingDianRewardsWin',{wxdId=self.wxdId})
end

function UIWuXingDianMainWin:onFZHelp(widget,index,desc,offset)
offset=offset or Vector2.New(0,-35)
UIManager:showWindow('UIConditionTipsThree',{showType=4,
str=desc,
posWidget=widget,
posWidgetIndex=index,
pos=offset,
maxWidth=338})
end

function UIWuXingDianMainWin:onFightBtn(wxdId)
local layer
if not wuXingDianConfig.isSD(wxdId)then
local curlayer=wuXingDianModel:getCurLayer(wxdId)
layer=self.selectLayer or curlayer
if layer>curlayer then
UIManager.error(FMT.fmt('请先通关第{0}层',curlayer))
return
end
end
wuXingDianController:showPrepareWin(wxdId,layer)
end

function UIWuXingDianMainWin:onClickWXCard(wxdId)
local ret,args=wuXingDianModel:isWXDOpen(wxdId)
if not ret then
local tips=wuXingDianModel:getWarnTips(args)
UIManager.error(tips)
return
end
if self.wxdId==wxdId then return end
self.wxdId=wxdId
if wuXingDianModel:hasNewLayer(wxdId)then
wuXingDianModel:setNewLayer(wxdId)
end
self:fadeoutWXPanel(0.5,function()
self:freshInfo(0.5)
end)
end

function UIWuXingDianMainWin:onBtnArrowRight()
local wxdId=self.wxdId
if wxdId>=5 then return end
self:onClickShrink()
wxdId=wxdId+1
local ret,args=wuXingDianModel:isWXDOpen(wxdId)
if not ret then
local tips=wuXingDianModel:getWarnTips(args)
UIManager.error(tips)
return
end
self.wxdId=wxdId
self.selectLayer=nil
self:freshInfo()
end

function UIWuXingDianMainWin:onBtnArrowLeft()
local wxdId=self.wxdId
if wxdId<=1 then return end
self:onClickShrink()
wxdId=wxdId-1
local ret,args=wuXingDianModel:isWXDOpen(wxdId)
if not ret then
local tips=wuXingDianModel:getWarnTips(args)
UIManager.error(tips)
return
end
self.wxdId=wxdId
self.selectLayer=nil
self:freshInfo()
end

function UIWuXingDianMainWin:onSaodangBtn()
UIManager:showWindow('UIWuXingDianSaoDangWin')
end

function UIWuXingDianMainWin:onLinggenBtn()
UIManager.info('通关五行殿各20层后，开启灵根修炼系统')
end

function UIWuXingDianMainWin:onTabBtn()
if wuXingDianConfig.isSD(self.wxdId)then
self:onWuxingDianBtn()
else
self:onShengDianBtn()
end
end

function UIWuXingDianMainWin:onClickShrink()
if not self.wxOpenStar then return end
self.wxOpenStar=nil
local widgetRoot=self.wxRoot:getChildWidgetBase()
widgetRoot:SetChildCanvasGroupAlpha(7,1)
widgetRoot:SetChildActive(27,false)
widgetRoot:SetChildActive(29,true)
widgetRoot:SetChildButtonClick(29,function()
self:onClickExtend()
end,true)
widgetRoot:SetChildSizeDelta(30,109,200)
widgetRoot:SetChildActive(31,false)
widgetRoot:SetChildActive(36,false)
end

function UIWuXingDianMainWin:onClickExtend()
if self.wxOpenStar then return end
self.wxOpenStar=true
if self.extendDelay then
self:stopTimerByID(self.extendDelay)
end
self.extendDelay=nil
local wxdId=self.wxdId
local needjump=self.needjump==true or self.selectLayer==nil
self.needjump=false
self.selectLayer=self.selectLayer or wuXingDianModel:getCurLayer(wxdId)
local widgetRoot=self.wxRoot:getChildWidgetBase()
widgetRoot:SetChildCanvasGroupAlpha(7,0)
widgetRoot:SetChildActive(29,false)
widgetRoot:SetChildSizeDelta(30,109,574)
widgetRoot:SetChildActive(31,true)
widgetRoot:SetChildActive(36,true)
widgetRoot:SetChildButtonClick(36,function()
self:onClickShrink()
end,true)

local maxlayer=wuXingDianModel:getMaxLayer(wxdId)
widgetRoot:SetChildActive(27,true)
widgetRoot:SetChildCanvasGroupAlpha(32,1)
widgetRoot:SetChildLayoutGroupCreateItems(32,maxlayer,function(index)
local layer=index
local passStar=wuXingDianModel:getPassLayerStar(wxdId,layer)
local widget1=widgetRoot:GetChildLayoutGroupGridItem(32,index-1)
widget1:SetChildButtonClick(0,function()
self:onSelectWXStar(wxdId,layer)
end,true)
widget1:SetChildText(1,layer)

local num=0
for i=1,3 do
local pass=mathHelper.getBitValue(passStar,i-1)
if pass then

num=num+1
end
end
widget1:SetChildStarNumber(2,num)
widget1:SetChildActive(3,self.selectLayer~=layer)
widget1:SetChildActive(4,self.selectLayer==layer)
end)
if needjump then
local layer=self.selectLayer
local maxlayer=wuXingDianModel:getMaxLayer(self.wxdId)
widgetRoot:SetChildCanvasGroupAlpha(32,0)
self.extendDelay=self:delayDo(0.3,function()
widgetRoot:SetChildCanvasGroupDOFade(32,1,0.3)
end)
self:jumpIndex(layer,0.3)
end

widgetRoot:SetChildButtonClick(36,function()
self:onClickShrink()
end,true)
end

function UIWuXingDianMainWin:onClickStarBtn()
UIManager:showWindow('UIWuXingDianStarRewardsWin')
end

function UIWuXingDianMainWin:onClickSTBtn()
UIManager:showWindow('UIWuXingDianShouTongWin')
end

function UIWuXingDianMainWin:freshInfo(fadeTime)
fadeTime=fadeTime or 0
self.wxOpenStar=nil
self.nomalRoot:setActive(self.wxdId==nil)
self.sdRoot:setActive(wuXingDianConfig.isSD(self.wxdId))
self.wxRoot:setActive(self.wxdId~=nil and not wuXingDianConfig.isSD(self.wxdId))
if self.wxdId==nil then
self:freshWXPanel(fadeTime)
elseif wuXingDianConfig.isSD(self.wxdId)then
self:freshSDInfo(fadeTime)
else
self:freshWXInfo(fadeTime-0.4)
end
self:freshSelectBtn()
self:freshSaoDang()
self:freshLinggenBtn()
end

function UIWuXingDianMainWin:freshLinggenBtn()
local isOpenLinggenSys=systemModel.isOpen(SYSTEM_DEFINE.eSpiritRootStrengthen)
self.linggenBtn:setActive(not isOpenLinggenSys)
end

function UIWuXingDianMainWin:freshSaoDang()
local ret,args=wuXingDianModel:isCanSaoDang()
self.saodangReddot:setActive(ret)

local isOpenSD=wuXingDianModel:isOpenSDByData()
local rewards=wuXingDianModel:getSaoDangRewards()

self.saodangBtn:setActive(isOpenSD and args~=0 and rewards and#rewards>0 or false)
end

function UIWuXingDianMainWin:freshSelectBtn()
local isSD=wuXingDianConfig.isSD(self.wxdId)
local isOpenSD=wuXingDianModel:isOpenSDByData()
self.shengDianBg:setActive(not isSD)
self.shengDianSelect:setActive(isSD)
self.wuxingDianBg:setActive(isSD)
self.wuxingDianSelect:setActive(not isSD)
self.shengDianBg:setGray(not isOpenSD)
local sdId=wuXingDianConfig.getSDType()
local isRead=wuXingDianModel:isOpenTitle(sdId)
local reddot=isOpenSD and not isRead or
wuXingDianModel:hasAnyPrize(sdId)or
false
self.shengDianReddot:setActive(reddot)
local reddot=(isSD or self.wxdId==nil)and(wuXingDianModel:hasAnyPrize(1)or
wuXingDianModel:isCanAnyPrizeStar()or
wuXingDianModel:isCanAnyPrizeShouTong())
local reddotNew=(isSD or self.wxdId==nil)and wuXingDianModel:hasAnyNewLayer()
self.wuxingReddot:setActive(reddot and not reddotNew)
self.wuxingNewReddot:setActive(reddotNew)
end

function UIWuXingDianMainWin:freshWXPanel(fadeTime)
self.selectLayer=nil

local titleList=wuXingDianModel:getAnyOpenTitle()
if titleList then
self:delayDo(0.1,function()
if not newbieControl.isInNewbie()then
self:showWindow('UIWuXingDianOpenTitleWin',titleList)
end
end)
end
local wxdName=cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'name')
self.selectText:setText(wxdName)
local widgetRoot=self.nomalRoot:getChildWidgetBase()

self:stopTickTimer()
self:stopfadeinTimer()

if fadeTime and fadeTime>0 then
widgetRoot:SetChildCanvasGroupAlpha(13,0)

self.rightPanel:setChildCanvasGroupAlpha(0)
self.rightPanel:setChildCanvasGroupRaycast(false)
self.leftPanel:setChildCanvasGroupAlpha(0)
self.fadeinTimer=self:delayDo(fadeTime,function()
widgetRoot:SetChildCanvasGroupDOFade(13,1,0.5)

self.rightPanel:setChildCanvasGroupDOFade(1,0.5)
self.rightPanel:setChildCanvasGroupRaycast(true)
self.leftPanel:setChildCanvasGroupDOFade(1,0.5)
self:stopfadeinTimer()
end)
else
widgetRoot:SetChildCanvasGroupAlpha(13,1)

self.rightPanel:setChildCanvasGroupAlpha(1)
self.rightPanel:setChildCanvasGroupRaycast(true)
self.leftPanel:setChildCanvasGroupAlpha(1)
end

for _,i in pairs(wuXingDianBaseType)do
local wxdId=i
local widget=widgetRoot:GetChildWidgetBase(_itemCard[i])
local layer=wuXingDianModel:getFinishLayer(wxdId)
local maxlayer=wuXingDianModel:getMaxLayer(wxdId)
local ret,args=wuXingDianModel:isWXDOpen(wxdId)
local overTag=layer>=maxlayer
widget:SetChildActive(0,overTag)

widget:SetChildActive(6,ret and not overTag)
widget:SetChildText(2,ret and not overTag and FMT.fmt('{0}/{1}',layer,maxlayer)or'')

widget:SetChildButtonClick(3,function()
self:onClickWXCard(i)
end,true)
widget:SetChildActive(4,not ret)
if not ret then
local tips=wuXingDianModel:getWarnTips(args)

widget:SetChildText(5,string.insertBreakLine(tips,true))
if pfwindowslController:checkIsGameVersion_yuenan()then
widget:SetChildText(5,tips)
end
end
widget:SetChildActive(7,wuXingDianModel:isWXDOpen(wxdId)and wuXingDianModel:hasAnyPrize(wxdId))
widget:SetChildActive(11,wuXingDianModel:isWXDOpen(wxdId)and wuXingDianModel:hasNewLayer(wxdId))
if ret then
local ani=fadeTime>0 and 2156 or 0
widget:SetChildSpineAnimation(8,ani,1,nil)
widget:SetChildShowEffect(10,_effectList[i],true)
else
local ani=fadeTime>0 and 2158 or 12
widget:SetChildSpineAnimation(8,ani,1,nil)
widget:SetChildShowEffect(10,0,false)
end
end

local isOpenSD=wuXingDianModel:isOpenSDByData()
widgetRoot:SetChildActive(5,not isOpenSD)
widgetRoot:SetChildActive(7,isOpenSD)
widgetRoot:SetChildActive(12,true)
if isOpenSD then
local wxdId=wuXingDianConfig.getSDType()
local layer=wuXingDianModel:getFinishLayer(wxdId)
local maxlayer=wuXingDianModel:getMaxLayer(wxdId)
widgetRoot:SetChildText(8,FMT.fmt('层数：<color=#F7F7F7>{0}/{1}</color>',layer,maxlayer))
local tick=function()
local jie,endStamp=wuXingDianModel:getCurJie()
local left=endStamp-timeHelper.getServerLongTime()
if left>=0 then
local endStr=timeHelper.format_time_stamp3(left)
widgetRoot:SetChildText(11,FMT.fmt('本期剩余时间：{0}',endStr))
else
widgetRoot:SetChildActive(12,false)
self:stopTickTimer()
end
end
self.tickTimer=self:setTimer(1,0,tick)
tick()
else
local needLayer=cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'need_layer')
widgetRoot:SetChildText(6,FMT.fmt('五殿均通关{0}层后开启圣殿',needLayer))
end

widgetRoot:SetChildButtonClick(9,function()
self:onWanfaHelp()
end,true)

widgetRoot:SetChildButtonClick(10,function()
self:onShengDianBtn()
end,true)

end


function UIWuXingDianMainWin:freshSDInfo(fadeTime)
local wxdId=wuXingDianConfig.getSDType()
self:stopfadeinTimer()
wuXingDianModel:setOpenTitle(wxdId)
local widgetRoot=self.sdRoot:getChildWidgetBase()
if fadeTime and fadeTime>0 then
widgetRoot:SetChildCanvasGroupAlpha(15,0)
widgetRoot:SetChildCanvasGroupAlpha(17,0)
widgetRoot:SetChildCanvasGroupAlpha(18,0)
self.fadeinTimer=self:delayDo(fadeTime,function()
widgetRoot:SetChildCanvasGroupDOFade(15,1,0.5)
widgetRoot:SetChildCanvasGroupDOFade(17,1,0.5)
widgetRoot:SetChildCanvasGroupDOFade(18,1,0.5)
self.rightPanel:setChildCanvasGroupDOFade(1,0.5)
self.rightPanel:setChildCanvasGroupRaycast(true)
self.leftPanel:setChildCanvasGroupDOFade(1,0.5)
self:stopfadeinTimer()
end)
else
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.firstOpenWXD_SD)
widgetRoot:SetChildCanvasGroupAlpha(15,1)
widgetRoot:SetChildCanvasGroupAlpha(17,1)
widgetRoot:SetChildCanvasGroupAlpha(18,1)
self.rightPanel:setChildCanvasGroupAlpha(1)
self.rightPanel:setChildCanvasGroupRaycast(true)
self.leftPanel:setChildCanvasGroupAlpha(1)
end

local wxdName=cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'name')
self.selectText:setText(wxdName)
local finishlayer=wuXingDianModel:getFinishLayer(wxdId)
local maxlayer=wuXingDianModel:getMaxLayer(wxdId)
local layer=self.selectLayer or wuXingDianModel:getCurLayer(wxdId)
local groupId=wuXingDianModel:getSDGroupId()
local groupCfg=cfg_fiveelementsholytemplegroupconfig_get(groupId)
if groupCfg==nil then
local jie=wuXingDianModel:getCurJie()
loggerUtil.logErrFMT('没有找到圣殿组配置！届：{0} groupId：{1}',jie,groupId)
end
local bundleName=globalABLookup.wxdsprite
local fazbgid=groupCfg.fazbg
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
local layerCfgEx=wuXingDianModel:getLayerCfgEx(wxdId,layer)
local layer_drop_id=layerCfgEx.layer_drop_id
local rewards=cfgHelper.get2(cfg_awardconfig_get,layer_drop_id,"showItems")
local data=wuXingDianModel:getData()
local monster_group_id=wuXingDianModel:getMonsterGroupId(wxdId,layer)
local modelId=cfgHelper.get3(cfg_monstergroup_get,monster_group_id,'model',1)
local modelArgs=cfgHelper.get3(cfg_dbbodyconfig_get,modelId,'scales2',8)
if modelArgs==nil then
loggerUtil.logErrFMT('没有找到圣殿模型配置：{0}',modelId)
end

widgetRoot:SetChildText(0,layer)

widgetRoot:SetChildUIModelShowTarget(1,modelId,modelArgs[1],{},0)


widgetRoot:SetChildButtonClick(3,function()
self:onPrizeBtn()
end,true)
widgetRoot:SetChildActive(11,wuXingDianModel:hasAnyPrize(wxdId))

widgetRoot:SetChildButtonClick(19,function()
UIManager:showWindow('UIWuXingDianSDRankWin')
end,true)


local fzlist=wuXingDianModel:getShiLianFaZeList(wxdId,layer)or{}
local fzlv=layerCfgEx.train_faze_lv

local fzid1=fzlist[1]
local fzid2=fzlist[2]
local hasFZ1=fzid1~=nil
local hasFZ2=fzid2~=nil
widgetRoot:SetChildActive(10,hasFZ1 or hasFZ2)
widgetRoot:SetChildActive(12,hasFZ1)
widgetRoot:SetChildActive(13,hasFZ2)
if hasFZ1 then
iconHelper.setChildIcon(widgetRoot,12,fazbgid)
local fztips=groupCfg.fztips
local fzRuleCfg=cfgHelper.getSSlawRule(fzid1)
local desc=fztips[2]
widgetRoot:SetChildText(4,FMT.cfmt3(groupCfg.fazcolor,fztips[1]))
widgetRoot:SetChildActive(2,true)
widgetRoot:SetChildButtonClick(2,function()
self:onFZHelp(widgetRoot,2,desc)
end,true)
widgetRoot:SetChildButtonClick(12,function()
self:onFZHelp(widgetRoot,2,desc)
end)
else
widgetRoot:SetChildText(4,'')
widgetRoot:SetChildActive(2,false)
end

if layerCfg.uptitle then
widgetRoot:SetChildCSImageSprite(20,bundleName,FMT.fmt('image_shengdianjinengts_{0}',layerCfg.uptitle))
else
widgetRoot:SetChildCSImageSprite(20,'','')
end

if hasFZ2 then
local fzRuleCfg=cfgHelper.getSSlawRule(fzid2)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local desc=not hasParam and fzRuleCfg.desc or
string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
widgetRoot:SetChildIcon(5,fzRuleCfg.image,false)
widgetRoot:SetChildText(6,desc)
else
widgetRoot:SetChildIcon(5,'',false)
widgetRoot:SetChildText(6,'')
end


widgetRoot:SetChildButtonClick(7,function()
if self and not self.isClose and self.onFightBtn then
self:onFightBtn(wxdId)
end
end,true)

widgetRoot:SetChildLayoutGroupCreateItems(8,#rewards,function(index)
local data={}
local reward=rewards[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widgetRoot:GetChildLayoutGroupGridItem(8,index-1)
widgetHelper.setNormalRewardItem(widget1,-1,data)
end)

widgetRoot:SetChildActive(14,true)

widgetRoot:SetChildText(16,FMT.fmt('通关层数：<color=#f7f7f7>{0}/{1}</color>',finishlayer,maxlayer))

self:stopTickTimer()

local tick=function()
local jie,endStamp=wuXingDianModel:getCurJie()
local left=endStamp-timeHelper.getServerLongTime()
if left>=0 then
local endStr=timeHelper.format_time_stamp3(left)
widgetRoot:SetChildText(9,FMT.fmt('本期剩余时间：<color=#f7f7f7>{0}</color>',endStr))
else
widgetRoot:SetChildActive(14,false)
widgetRoot:SetChildText(9,'')
self:stopTickTimer()
end
end
self.tickTimer=self:setTimer(1,0,tick)
tick()

local isInLastTimeBySD=wuXingDianModel:isInLastTimeBySD()
widgetRoot:SetChildActive(22,isInLastTimeBySD)
self.inLastTime=isInLastTimeBySD
self:stopLastSDTimer()
local tick1=function()
local jie,endStamp=wuXingDianModel:getCurJie()
local left=endStamp-timeHelper.getServerLongTime()
local isInLastTimeBySD=wuXingDianModel:isInLastTimeBySD()
if isInLastTimeBySD and left>0 then
local endStr=timeHelper.format_time_stamp3(left)
widgetRoot:SetChildText(21,endStr)
if not self.inLastTime then
self.inLastTime=true
widgetRoot:SetChildActive(22,true)
end
else
if self.inLastTime then
widgetRoot:SetChildActive(22,false)
end
widgetRoot:SetChildText(21,'')
self.inLastTime=false
end
end
self.lastSDTimer=self:setTimer(1,0,tick1)
tick1()
end


function UIWuXingDianMainWin:freshWXInfo(fadeTime)
self:stopfadeinTimer()

if self.extendDelay then
self:stopTimerByID(self.extendDelay)
end
self.extendDelay=nil

local widgetRoot=self.wxRoot:getChildWidgetBase()

if fadeTime and fadeTime>0 then

widgetRoot:SetChildCanvasGroupAlpha(21,0)
widgetRoot:SetChildLocalPosX(19,1500)
widgetRoot:SetChildCanvasGroupAlpha(20,0)
self.fadeinTimer=self:delayDo(fadeTime,function()

widgetRoot:SetChildDOLocalMoveX(19,0,0.5)
widgetRoot:SetChildCanvasGroupDOFade(20,1,0.5)
widgetRoot:SetChildCanvasGroupDOFade(21,1,0.5)
self:stopfadeinTimer()
end)
else

widgetRoot:SetChildLocalPosX(19,0)
widgetRoot:SetChildCanvasGroupAlpha(20,1)
end
self.rightPanel:setChildCanvasGroupAlpha(0)
self.rightPanel:setChildCanvasGroupRaycast(false)
self.leftPanel:setChildCanvasGroupAlpha(0)
widgetRoot:SetChildCanvasGroupAlpha(7,1)
widgetRoot:SetChildActive(27,false)
widgetRoot:SetChildActive(29,true)
widgetRoot:SetChildButtonClick(29,function()
self:onClickExtend()
end,true)
widgetRoot:SetChildSizeDelta(30,109,200)
widgetRoot:SetChildActive(31,false)
widgetRoot:SetChildActive(36,false)

local wxdId=self.wxdId
local wxdName=cfgHelper.get2(cfg_fiveelementstempleconfig_get,wxdId,'name')
self.selectText:setText(wxdName)
local data=wuXingDianModel:getData()
local bgname=FMT.fmt(_bgFMT,wxdId)
local bundleName=globalABLookup.wxdsprite
local layer=self.selectLayer or wuXingDianModel:getCurLayer(wxdId)
local maxlayer=wuXingDianModel:getMaxLayer(wxdId)

local maxmon_id=wuXingDianModel:getMonsterGroupId(wxdId,maxlayer)
local max_mon_name=cfgHelper.get2(cfg_monstergroup_get,maxmon_id,'name')
local maxModelId=cfgHelper.get3(cfg_monstergroup_get,maxmon_id,'model',1)
local maxModelArgs=cfgHelper.get3(cfg_dbbodyconfig_get,maxModelId,'scales2',8)
if maxModelArgs==nil then
loggerUtil.logErrFMT('没有找到五行殿最高层模型配置：{0}',maxModelId)
end

local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
local layer_drop_id=layerCfg.layer_drop_id
local mon_id=wuXingDianModel:getMonsterGroupId(wxdId,layer)
local rewards=cfgHelper.get2(cfg_awardconfig_get,layer_drop_id,"showItems")
local modelId=cfgHelper.get3(cfg_monstergroup_get,mon_id,'model',1)
local modelArgs=cfgHelper.get3(cfg_dbbodyconfig_get,modelId,'scales2',8)
if modelArgs==nil then
loggerUtil.logErrFMT('没有找到五行殿模型配置：{0}',modelId)
end
widgetRoot:SetChildCSImageSprite(14,bundleName,bgname)


widgetRoot:SetChildActive(2,wxdId>1)
widgetRoot:SetChildButtonClick(2,function()
self:onBtnArrowLeft()
end,true)
widgetRoot:SetChildActive(1,wxdId<5)
widgetRoot:SetChildButtonClick(1,function()
self:onBtnArrowRight()
end,true)

widgetRoot:SetChildActive(3,true)
widgetRoot:SetChildButtonClick(3,function()
self:onPrizeBtn()
end,true)
widgetRoot:SetChildActive(13,wuXingDianModel:hasAnyPrize(wxdId))

local fzlist=wuXingDianModel:getShiLianFaZeList(wxdId,layer)or{}
local fzinfo1=fzlist[1]
local fzinfo2=fzlist[2]
local hasFZ1=fzinfo1~=nil
local hasFZ2=fzinfo2~=nil
widgetRoot:SetChildActive(12,hasFZ1 or hasFZ2)
widgetRoot:SetChildActive(15,hasFZ1)
widgetRoot:SetChildActive(16,hasFZ2)
if hasFZ1 then
local fzid=fzinfo1[1]
local fzlv=fzinfo1[2]
local wxdCfg=cfg_fiveelementstempleconfig_get(wxdId)
local fazbgid=wxdCfg.fazbg
local fzRuleCfg=cfgHelper.getSSlawRule(fzid)
local desc=wxdCfg.fztips[2]
iconHelper.setChildIcon(widgetRoot,15,fazbgid)
widgetRoot:SetChildText(4,FMT.cfmt3(wxdCfg.fazcolor,wxdCfg.fztips[1]))
widgetRoot:SetChildActive(11,true)
widgetRoot:SetChildButtonClick(11,function()
self:onFZHelp(widgetRoot,37,desc)
end,true)
widgetRoot:SetChildButtonClick(15,function()
self:onFZHelp(widgetRoot,37,desc)
end)
else
widgetRoot:SetChildText(4,'')
widgetRoot:SetChildActive(11,false)
end

if hasFZ2 then
local fzid=fzinfo2[1]
local fzlv=fzinfo2[2]
local fzRuleCfg=cfgHelper.getSSlawRule(fzid)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local desc=not hasParam and fzRuleCfg.desc or
string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
widgetRoot:SetChildIcon(5,fzRuleCfg.image,false)
widgetRoot:SetChildText(6,desc)
else
widgetRoot:SetChildIcon(5,'',false)
widgetRoot:SetChildText(6,'')
end


widgetRoot:SetChildText(7,layer)

widgetRoot:SetChildButtonClick(8,function()
self:onFightBtn(wxdId)
end,true)

widgetRoot:SetChildLayoutGroupCreateItems(9,#rewards,function(index)
local data={}
local reward=rewards[index]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widgetRoot:GetChildLayoutGroupGridItem(9,index-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
end)

widgetRoot:SetChildUIModelShowTarget(10,modelId,modelArgs[1],{},0)
widgetRoot:SetChildUIModelShowTargetOffset(10,modelArgs[2]or 0,modelArgs[3]or 0)

local passStar=wuXingDianModel:getPassLayerStar(wxdId,layer)

local num=0
for i=1,3 do
local pass=mathHelper.getBitValue(passStar,i-1)
if pass then
num=num+1

end
end
widgetRoot:SetChildStarNumber(28,num)
widgetRoot:SetChildActive(24,wuXingDianModel:isCanAnyPrizeStar())
widgetRoot:SetChildActive(26,wuXingDianModel:isCanAnyPrizeShouTong())

local allStar=wuXingDianModel:getAllStar()
local tagretId=wuXingDianModel:getCurrentMaxStar(allStar)
local targetStar=cfgHelper.get2(cfg_fiveelementstemplestarconfig_get,tagretId,'star')
widgetRoot:SetChildText(25,FMT.fmt('{0}/<color=#f1ce78>{1}星</color>',allStar,targetStar))
widgetRoot:SetChildButtonClick(22,function()
self:onClickStarBtn()
end,true)

widgetRoot:SetChildButtonClick(23,function()
self:onClickSTBtn()
end,true)

local grandPrizeLayer=wuXingDianModel:getNextGrandPrizeLayer(wxdId,layer)
widgetRoot:SetChildActive(35,grandPrizeLayer~=nil)
if grandPrizeLayer then
widgetRoot:SetChildText(33,FMT.fmt('第{0}层',grandPrizeLayer))
local data={}
local itemid=wuXingDianModel:getLayerCfg(wxdId,grandPrizeLayer).grandprize
data[1]=itemid
data[2]=1

widgetHelper.setNormalRewardItem(widgetRoot,34,data)
local widget1=widgetRoot:GetChildWidgetBase(34)
widget1:SetChildActive(2,false)
end


local cardWidget=widgetRoot:GetChildWidgetBase(0)
cardWidget:SetChildText(0,max_mon_name)
cardWidget:SetChildUIModelShowTarget(1,maxModelId,maxModelArgs[1],{},0)

if fadeTime and fadeTime>0 then
local model=_modelList[wxdId]
if self.infomodel~=model then
self.infomodel=model
cardWidget:SetChildUIModelShowTarget(2,model,1,{},2156)
else
cardWidget:SetChildModelAnimationState(2,2156)
end
else
cardWidget:SetChildUIModelShowTarget(2,_modelList[wxdId],1,{},0)
end
cardWidget:SetChildShowEffect(3,_effectList[wxdId],true)

newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.firstOpenWXD_WD)
end

function UIWuXingDianMainWin:jumpIndex(layer,delay)
local maxlayer=wuXingDianModel:getMaxLayer(self.wxdId)
if maxlayer<=layer then return end
local jump=function()
if self==nil or self.isClose then return end
local widgetRoot=self.wxRoot:getChildWidgetBase()
local r=layer
local viewHeight=433
local contentHeight=widgetRoot:GetChildSizeDeltaY(32)
local itemHeight=80
local posY=(r-1)*itemHeight
if posY<=0 then posY=0 end
local div=contentHeight-viewHeight
if div<0 then div=0 end
if posY>div then posY=div end
widgetRoot:SetChildAnchoredPos(32,0,posY)
end
if self.jumpTimer then
self:stopTimerByID(self.jumpTimer)
end
self.jumpTimer=self:delayDo(delay,function()
jump()
end)
end

function UIWuXingDianMainWin:onSelectWXStar(wxdId,layer)
if self.wxdId~=wxdId or self.selectLayer==layer then return end
local old=self.selectLayer
self.selectLayer=layer
local widgetRoot=self.wxRoot:getChildWidgetBase()
if old then
local widget1=widgetRoot:GetChildLayoutGroupGridItem(32,old-1)
widget1:SetChildActive(4,false)
widget1:SetChildActive(3,true)
end
local widget1=widgetRoot:GetChildLayoutGroupGridItem(32,layer-1)
widget1:SetChildActive(4,true)
widget1:SetChildActive(3,false)
self:freshWXInfo()
self.wxOpenStar=nil
end

function UIWuXingDianMainWin:fadeoutWXPanel(delay,callback)
self:stopfadeoutTimer()
if self.jumpTimer then
self:stopTimerByID(self.jumpTimer)
end
self.jumpTimer=nil

if self.extendDelay then
self:stopTimerByID(self.extendDelay)
end
self.extendDelay=nil

self.selectLayer=nil
local widgetRoot=self.nomalRoot:getChildWidgetBase()
widgetRoot:SetChildCanvasGroupDOFade(13,0,delay)

for _,wxdId in pairs(wuXingDianBaseType)do
local i=wxdId
local widget=widgetRoot:GetChildWidgetBase(_itemCard[i])
local ret=wuXingDianModel:isWXDOpen(wxdId)
local ani=ret and 2157 or 2159
widget:SetChildSpineAnimation(8,ani,1,nil)
widget:SetChildShowEffect(10,0,false)
end
self.rightPanel:setChildCanvasGroupDOFade(0,delay)
self.rightPanel:setChildCanvasGroupRaycast(false)
self.leftPanel:setChildCanvasGroupDOFade(0,delay)
if wuXingDianConfig.isSD(self.wxdId)then
self.modelBg:setChildSpineAnimation(2040,1,nil)
self.modelTop:setChildUIModelShowTarget(4873,1,{},2020)
end
if delay>0 then
self.fadeoutTimer=self:delayDo(delay,function()
callback()
self:stopfadeoutTimer()
end)
else
callback()
end
end

function UIWuXingDianMainWin:fadeoutWXInfoPanel(wxdId,delay,callback)
self:stopfadeoutTimer()
if self.jumpTimer then
self:stopTimerByID(self.jumpTimer)
end
local widgetRoot=self.wxRoot:getChildWidgetBase()
local cardWidget=widgetRoot:GetChildWidgetBase(0)
local model=_modelList[wxdId]
if self.infomodel~=model then
self.infomodel=model
cardWidget:SetChildUIModelShowTarget(2,model,1,{},2157)
else
cardWidget:SetChildModelAnimationState(2,2157)
end
cardWidget:SetChildShowEffect(3,0,false)
widgetRoot:SetChildCanvasGroupDOFade(21,0,0.2)
widgetRoot:SetChildDOLocalMoveX(19,1500,delay)
widgetRoot:SetChildCanvasGroupDOFade(20,0,delay)
self.rightPanel:setChildCanvasGroupAlpha(0)
self.rightPanel:setChildCanvasGroupRaycast(false)
self.leftPanel:setChildCanvasGroupAlpha(0)
if delay>0 then
self.fadeoutTimer=self:delayDo(delay,function()
callback()
self:stopfadeoutTimer()
end)
else
callback()
end
end

function UIWuXingDianMainWin:fadeoutSDPanel(delay,callback)
self:stopfadeoutTimer()
local widgetRoot=self.sdRoot:getChildWidgetBase()
widgetRoot:SetChildCanvasGroupDOFade(15,0,delay)
widgetRoot:SetChildCanvasGroupDOFade(17,0,delay)
widgetRoot:SetChildCanvasGroupDOFade(18,0,delay)
self.modelBg:setChildSpineAnimation(2045,1,nil)
self.rightPanel:setChildCanvasGroupDOFade(0,delay)
self.rightPanel:setChildCanvasGroupRaycast(false)
self.leftPanel:setChildCanvasGroupDOFade(0,delay)
self.modelTop:setChildUIModelShowTarget(4873,1,{},2020)
if delay>0 then
self.fadeoutTimer=self:delayDo(delay,function()
callback()
self:stopfadeoutTimer()
end)
else
callback()
end
end

function UIWuXingDianMainWin:onFreshReddot()
local widgetRoot=self.nomalRoot:getChildWidgetBase()
for _,i in pairs(wuXingDianBaseType)do
local _wxdId=i
local widget=widgetRoot:GetChildWidgetBase(_itemCard[i])
widget:SetChildActive(7,wuXingDianModel:isWXDOpen(_wxdId)and wuXingDianModel:hasAnyPrize(_wxdId))
end
local widgetRoot=self.sdRoot:getChildWidgetBase()
widgetRoot:SetChildActive(11,wuXingDianModel:hasAnyPrize(0))

if self.wxdId and not wuXingDianConfig.isSD(self.wxdId)then
local widgetRoot=self.wxRoot:getChildWidgetBase()
widgetRoot:SetChildActive(13,wuXingDianModel:hasAnyPrize(self.wxdId))
end
end

function UIWuXingDianMainWin:onShouTongFresh()
local widgetRoot=self.wxRoot:getChildWidgetBase()
widgetRoot:SetChildActive(24,wuXingDianModel:isCanAnyPrizeStar())
widgetRoot:SetChildActive(26,wuXingDianModel:isCanAnyPrizeShouTong())
self:freshSelectBtn()
end

function UIWuXingDianMainWin:onTouZi()
self:onFreshReddot()
self:freshSelectBtn()
end

function UIWuXingDianMainWin:onPrize()
self:onFreshReddot()
self:freshSelectBtn()
end

function UIWuXingDianMainWin:stopLastSDTimer()
if self.lastSDTimer then
self:stopTimerByID(self.lastSDTimer)
end
self.lastSDTimer=nil
end

function UIWuXingDianMainWin:stopTickTimer()
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
self.tickTimer=nil
end

function UIWuXingDianMainWin:stopfadeinTimer()
if self.fadeinTimer then
self:stopTimerByID(self.fadeinTimer)
end
self.fadeinTimer=nil
end

function UIWuXingDianMainWin:stopfadeoutTimer()
if self.fadeoutTimer then
self:stopTimerByID(self.fadeoutTimer)
end
self.fadeoutTimer=nil
end
