







def_class("UITechnologyWin",UIWindowBase)









function UITechnologyWin:bindComponents()

self.adItemClick=UIButton.get(self,0)
self.askHelpBtn=UIButton.get(self,1)
self.bgmodel=UIObject.get(self,2)
self.btnAdsSpeedup=UIButton.get(self,3)
self.btnFinishUpgrade=UIButton.get(self,4)
self.cancelBtn=UIButton.get(self,5)
self.condition1=UIObject.get(self,6)
self.condition2=UIObject.get(self,7)
self.condition3=UIObject.get(self,8)
self.conditionPanel=UIObject.get(self,9)
self.conditionText=UIText.get(self,10)
self.Content=UIObject.get(self,11)
self.costIcon=UIObject.get(self,12)
self.costPanel=UIObject.get(self,13)
self.costValue=UIText.get(self,14)
self.curDesc_1=UIText.get(self,15)
self.curDesc_2=UIText.get(self,16)
self.curDesc_3=UIText.get(self,17)
self.curLv=UIText.get(self,18)
self.desc=UIText.get(self,19)
self.effect_1=UIObject.get(self,20)
self.effect_2=UIObject.get(self,21)
self.effect_3=UIObject.get(self,22)
self.iconAds=UIImage.get(self,23)
self.itemPanel=UIObject.get(self,24)
self.levelPanel=UIObject.get(self,25)
self.levelUpBtn=UIButton.get(self,26)
self.levelUpPanel=UIObject.get(self,27)
self.levelUpTime=UIText.get(self,28)
self.maxIcon=UIImage.get(self,29)
self.maxLv=UIText.get(self,30)
self.maxLvPanel=UIObject.get(self,31)
self.nextDesc_1=UIText.get(self,32)
self.nextDesc_2=UIText.get(self,33)
self.nextDesc_3=UIText.get(self,34)
self.nextLv=UIText.get(self,35)
self.notLv=UIText.get(self,36)
self.payAds=UIText.get(self,37)
self.sliderUpgrade=UIObject.get(self,38)
self.speedUpBtnText=UIText.get(self,39)
self.speedupPanel=UIObject.get(self,40)
self.suCost=UIObject.get(self,41)
self.tabList=UIObject.get(self,42)
self.tabScrollView=UIObject.get(self,43)
self.technologyScrollView=UIObject.get(self,44)
self.title=UIText.get(self,45)
self.txtDesc_1=UIText.get(self,46)
self.txtDesc_2=UIText.get(self,47)
self.txtDesc_3=UIText.get(self,48)
self.txtDesc1=UIText.get(self,49)
self.txtUpgradeBar=UIText.get(self,50)
self.upgradePanel=UIObject.get(self,51)

self.adItemClick:setButtonClick(function()self:onAdItemClick()end)

self.askHelpBtn:setButtonClick(function()self:onAskHelpBtn()end)

self.btnAdsSpeedup:setButtonClick(function()self:onBtnAdsSpeedup()end)

self.btnFinishUpgrade:setButtonClick(function()self:onBtnFinishUpgrade()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)
self.curDesc={
self.curDesc_1,
self.curDesc_2,
self.curDesc_3,
}
self.effect={
self.effect_1,
self.effect_2,
self.effect_3,
}
self.nextDesc={
self.nextDesc_1,
self.nextDesc_2,
self.nextDesc_3,
}
self.txtDesc={
self.txtDesc_1,
self.txtDesc_2,
self.txtDesc_3,
}



end


function UITechnologyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adItemClick);self.adItemClick=nil;
_UIObject_release(self.askHelpBtn);self.askHelpBtn=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.btnAdsSpeedup);self.btnAdsSpeedup=nil;
_UIObject_release(self.btnFinishUpgrade);self.btnFinishUpgrade=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.condition3);self.condition3=nil;
_UIObject_release(self.conditionPanel);self.conditionPanel=nil;
_UIObject_release(self.conditionText);self.conditionText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.curDesc_1);self.curDesc_1=nil;
_UIObject_release(self.curDesc_2);self.curDesc_2=nil;
_UIObject_release(self.curDesc_3);self.curDesc_3=nil;
_UIObject_release(self.curLv);self.curLv=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.effect_1);self.effect_1=nil;
_UIObject_release(self.effect_2);self.effect_2=nil;
_UIObject_release(self.effect_3);self.effect_3=nil;
_UIObject_release(self.iconAds);self.iconAds=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.levelPanel);self.levelPanel=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpPanel);self.levelUpPanel=nil;
_UIObject_release(self.levelUpTime);self.levelUpTime=nil;
_UIObject_release(self.maxIcon);self.maxIcon=nil;
_UIObject_release(self.maxLv);self.maxLv=nil;
_UIObject_release(self.maxLvPanel);self.maxLvPanel=nil;
_UIObject_release(self.nextDesc_1);self.nextDesc_1=nil;
_UIObject_release(self.nextDesc_2);self.nextDesc_2=nil;
_UIObject_release(self.nextDesc_3);self.nextDesc_3=nil;
_UIObject_release(self.nextLv);self.nextLv=nil;
_UIObject_release(self.notLv);self.notLv=nil;
_UIObject_release(self.payAds);self.payAds=nil;
_UIObject_release(self.sliderUpgrade);self.sliderUpgrade=nil;
_UIObject_release(self.speedUpBtnText);self.speedUpBtnText=nil;
_UIObject_release(self.speedupPanel);self.speedupPanel=nil;
_UIObject_release(self.suCost);self.suCost=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.tabScrollView);self.tabScrollView=nil;
_UIObject_release(self.technologyScrollView);self.technologyScrollView=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.txtDesc_1);self.txtDesc_1=nil;
_UIObject_release(self.txtDesc_2);self.txtDesc_2=nil;
_UIObject_release(self.txtDesc_3);self.txtDesc_3=nil;
_UIObject_release(self.txtDesc1);self.txtDesc1=nil;
_UIObject_release(self.txtUpgradeBar);self.txtUpgradeBar=nil;
_UIObject_release(self.upgradePanel);self.upgradePanel=nil;
self.curDesc=nil;
self.effect=nil;
self.nextDesc=nil;
self.txtDesc=nil;
end
















local _this=nil




function UITechnologyWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onYingXianGe_XMHZChange,self.refreshQiuYuanBtn)

self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local spcfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_allow')
self.mspData=spcfg[9]
self.feedTime=self.baseCfg[speedUpMode.eFree][1]
self.sfId=zongmenModel:getMountainId()
self.reqTime=0
end


function UITechnologyWin:__delete()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onYingXianGe_XMHZChange,self.refreshQiuYuanBtn)
UIManager:hideWindow('UITopMoneyWin2')
_this=nil
end




function UITechnologyWin:onShow(argtable,afterOnloaded)
self.conditions={
self.condition1,
self.condition2,
self.condition3,
}

if argtable then
self.treeType=argtable.treeType
self.tabSelect=argtable.tabSelect
self.id=argtable.id
self.level=yandaotaiModel:getTechnologyListLevel(self.id)or 0
self.bdData=argtable.bdData
self.config=cfgHelper.get2(cfg_technologyconfig_get,self.id,self.level+1)
self.treeId=yandaotaiModel:getTreeIdByTypeAndTabIdx(self.treeType,self.tabSelect)
self.idList=cfgHelper.get2(cfg_technologytreeconfig_get,self.treeId,"technology_list")

if not self.config then
self.config=cfgHelper.get2(cfg_technologyconfig_get,self.id,self.level)
end

self.value2=DianFengLevelModel:getDFXianBaoBuildPercent(3)
self:refreshWin()
else
UIManager.error('衍道台数据错误，界面已关闭！！！')
self:onClickClose()
end

self:initTabList()
end


function UITechnologyWin:onHide()

end

function UITechnologyWin:initTabList()
local showLen=0
local list=yandaotaiModel:getTechnologyTabList(self.treeType)
for i,cfg in ipairs(list)do
if yandaotaiModel:getIsShowTree(cfg.id)then
showLen=showLen+1
end
end

local len=#list
if showLen>1 then
self.tabList:setActive(true)
self.tabList:setChildLayoutGroupCreateItems(len,function(index)
local widget=_this.tabList:getChildLayoutGroupGridItem(index-1)
local cfg=list[index]
local isShow=yandaotaiModel:getIsShowTree(cfg.id)
widget:SetChildActive(-1,isShow)
if isShow then
widget:SetChildActive(0,_this.tabSelect==index)
widget:SetChildText(1,cfg.name)

widget:SetChildButtonClick(2,function()
local oldWidget=_this.tabList:getChildLayoutGroupGridItem(_this.tabSelect-1)
oldWidget:SetChildActive(0,false)
widget:SetChildActive(0,true)
_this.tabSelect=index

local treeId=yandaotaiModel:getTreeIdByTypeAndTabIdx(_this.treeType,_this.tabSelect)
local idList=cfgHelper.get2(cfg_technologytreeconfig_get,treeId,"technology_list")
_this:stopLevelUpTimer()
local bdData=_this.bdData
local treeType=_this.treeType
local tabSelect=_this.tabSelect
UIManager:showWindow('UITechnologyWin',{id=idList[1],bdData=bdData,treeType=treeType,tabSelect=tabSelect})
end,true)
end
end)
else
self.tabList:setActive(false)
end
end

function UITechnologyWin:refreshLevel()
self.level=yandaotaiModel:getTechnologyListLevel(self.id)
self.config=cfgHelper.get2(cfg_technologyconfig_get,self.id,self.level+1)
if not self.config then
self.config=cfgHelper.get2(cfg_technologyconfig_get,self.id,self.level)
end

self:refreshWin()
end

function UITechnologyWin:getNeedLevel(limitLevel)
local cfg=cfg_technologybaseconfig()

if cfg then
for k,v in ipairs(cfg)do
if v.uplimit>limitLevel then
return v.id
end
end
end
return 0
end

function UITechnologyWin:refreshWin()
local cfg=self.config
local study_time=yandaotaiController.getchangeSpeed(cfg.study_time,self.value2)
self.desc:setText(cfg.nextstudy_txt or'')
self.title:setText(cfg.technology_name)
local level,limitLevel,maxLevel,isMax=yandaotaiModel:isMaxLevel(self.id)

if not isMax then
self:refreshCost()
self:refreshLevelAttr()

local time=yandaotaiModel:getStudyListTime(self.id)
if time then
local canQiuZhu=xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,9)
self.askHelpBtn:setActive(canQiuZhu)
self.cancelBtn:setActive(true)
self.costPanel:setActive(false)
self.upgradePanel:setActive(true)

self:refreshUpgradePanel(study_time)
self:refreshSpeedPanel(speedUpType.eYanDaoTai)
else
self.askHelpBtn:setActive(false)
self.cancelBtn:setActive(false)
self.costPanel:setActive(true)
self.upgradePanel:setActive(false)

local flag=yandaotaiModel:checkIsEnoughUpLevel(cfg.unlock_condition)
if flag and level>=limitLevel then flag=false end
local needLv=self:getNeedLevel(limitLevel)
if needLv==0 then flag=true end

if flag then
time=timeHelper.format_time_stamp(study_time)
self.levelUpTime:setText(time)
else
self:refreshConditionPanel(cfg.unlock_condition,needLv)
end

self.itemPanel:setActive(flag)
self.levelUpPanel:setActive(flag)
self.conditionText:setActive(not flag)
self.conditionPanel:setActive(not flag)
end
else
self:refreshMaxPanel()
end

self:initSortList()
self:refreshTechnologyList()
self.maxLvPanel:setActive(isMax)
self.levelPanel:setActive(not isMax)
end

function UITechnologyWin.refreshQiuYuanBtn()
local canQiuZhu=xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,9)
if not canQiuZhu then
_this.askHelpBtn:setActive(canQiuZhu)
end

local un_build_id=yandaotaiController:getBuildUnBulidId()
hudControl:refreshBuildingStatusHUD(un_build_id)
end

function UITechnologyWin:refreshMaxPanel()
local cfg=cfgHelper.get2(cfg_technologyconfig_get,self.id,self.level)

local iconName=cfg.winParams[1]
local txet=string.format('等级%s',self.level)
local effectList=cfg.study_effect

self.maxLv:setText(txet)
self.winlua:SetChildIcon(self.maxIcon:getID(),iconName,false)

for i=1,3 do
if effectList[i]then
local text=yandaotaiModel:getTypeAttrDesc(effectList[i])
self.txtDesc[i]:setText(text)
self.effect[i]:setActive(true)
else
self.effect[i]:setActive(false)
end
end
end

function UITechnologyWin:playTechnologyEffect(index)
local key

for k,v in ipairs(self.SortList)do
if v.id==index then
key=k
end
end

local grids=self.technologyScrollView:getChildScrollViewItemWidgets()
local item=grids[key-1]
item:SetChildActive(7,true)
item:SetChildUIModelShowTarget(7,6372,1,nil,eAnimationID.stand,false,false,0,nil)
_this:delayDo(1,function()
if not _this then return end
item:SetChildActive(7,false)
end)
end

function UITechnologyWin:initSortList()
local SortList={}

for k,id in ipairs(self.idList)do
local isUnlock=true
local sort=k+100
local level=yandaotaiModel:getTechnologyListLevel(id)or 0

if level==0 then
local cfg=cfgHelper.get2(cfg_technologyconfig_get,id,1)
isUnlock=yandaotaiModel:checkIsEnoughUpLevel(cfg.unlock_condition)
end

if level>0 then
sort=sort-90
end

if isUnlock then sort=sort-10 end

local temp={}
temp.id=id
temp.sort=sort

table.insert(SortList,temp)
end

if#SortList>0 then
table.sort(SortList,function(a,b)
if a.sort<b.sort then
return a.sort<b.sort
end
end)
end

self.SortList=SortList

end


function UITechnologyWin:refreshTechnologyList()



local list=self.SortList
local count=#list
self.technologyScrollView:setChildScrollViewCreateGrids(count,1)

local grids=self.technologyScrollView:getChildScrollViewItemWidgets()

for i=1,grids.Count do
local str
local notlevel=true
local isLock=false
local id=list[i].id
local widget=grids[i-1]
local time=yandaotaiModel:getStudyListTime(id)
local level,limitLevel,maxLevel,isMax=yandaotaiModel:isMaxLevel(id)

widget:SetChildShowEffect(6,0,false)
widget:SetChildActive(7,false)

if isMax then
str='<color=#229f00>已满级</color>'
elseif time then
local index=level+1
local cfg=cfgHelper.get2(cfg_technologyconfig_get,id,index)
local study_time=yandaotaiController.getchangeSpeed(cfg.study_time,self.value2)
local isFinish=yandaotaiModel:checkStudyisFinishTime(id,study_time)

if isFinish then
str='<color=#F6EA10>研究完成</color>'

else
str='<color=#B0FF77>研究中</color>'

end

if level==0 then level=1 end
elseif level>0 then
str=string.format("%s/%s",level,math.min(limitLevel,maxLevel))
else
str=string.format("%s/%s",level,math.min(limitLevel,maxLevel))
notlevel=false
level=level+1
end

local isSelect=true and id==self.id or false
local cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level)
local flag=yandaotaiModel:checkIsEnoughUpLevel(cfg.unlock_condition)
if not notlevel and not flag then isLock=true end

local iconName=cfg.winParams[1]

widget:SetChildText(4,str)
widget:SetChildActive(2,isLock)
widget:SetChildActive(1,isSelect)
widget:SetChildButtonEnable(0,true,isLock)
widget:SetChildIcon(0,iconName,false)
widget:SetChildButtonClick(0,function()
self:stopLevelUpTimer()
local bdData=self.bdData
local treeType=self.treeType
local tabSelect=self.tabSelect
UIManager:showWindow('UITechnologyWin',{id=id,bdData=bdData,treeType=treeType,tabSelect=tabSelect})
end)
end
end


function UITechnologyWin:refreshConditionPanel(config,level)
if not config then
config={{2,SLG_SYSTEM_TYPE.eYanDaoTai,level}}
end

for i=1,3 do
local condition=self.conditions[i]
local widget=condition:getChildWidgetBase()
local data=config[i]
local str
local callBack
local isUnlock=false

if data then
condition:setActive(true)
local color=FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor]

if data[1]==1 then
local cfg=cfgHelper.get2(cfg_technologyconfig_get,data[2],1)
local name=cfg.technology_name
local level=yandaotaiModel:getTechnologyListLevel(data[2])

if not level then level=0 end
isUnlock=true and level>=data[3]
if not isUnlock then color=FONT_COLOR_VAL[FONT_COLOR.eRedColor]end

str=string.format('%s科技等级: <color=%s>%s级</color>',name,color,data[3])
callBack=function()
self:onGoToButton(1,data[2],level)
end
elseif data[1]==2 then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data[2])
local name=cfg.name
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,data[2])
local level=bdDatas.level or 0
isUnlock=true and level>=data[3]
if not isUnlock then color=FONT_COLOR_VAL[FONT_COLOR.eRedColor]end

str=string.format('%s等级: <color=%s>%s级</color>',name,color,data[3])
callBack=function()

if data[2]==SLG_SYSTEM_TYPE.eYanDaoTai then
UIManager:invokeUIMethod('UIYanDaoTaiWin','onLevelUpBtn')
UIManager:invokeUIMethod('UIYanDaoTaiDaoZangWin','onLevelUpBtn')
self:onClickClose()
else
self:onGoToButton(2,bdDatas,cfg)
end
end
end

widget:SetChildText(0,str)
widget:SetChildActive(1,not isUnlock)
widget:SetChildActive(2,not isUnlock)
widget:SetChildActive(3,not isUnlock)
widget:SetChildActive(4,isUnlock)
widget:SetChildButtonClick(1,callBack)
else
condition:setActive(false)
end
end
end


function UITechnologyWin:onGoToButton(ftype,arg1,arg2)
if ftype==1 then
local bdData=self.bdData
local treeType=self.treeType
local tabSelect=self.tabSelect
self:stopLevelUpTimer()
self:onClickClose()

UIManager:showWindow('UITechnologyWin',{id=arg1,bdData=bdData,treeType=treeType,tabSelect=tabSelect})
elseif ftype==2 then
self:onClickClose()
fullScreenUI.closeActiveUI()
local bdData=arg1
local c=arg2
if bdData then
isometricMapSystem:openBuildingWin(bdData)
else
local rdata=isometricMapSystem:getUnlockRepairDataByID(zongmenModel:getMountainId(),c.id)
if rdata then
isometricMapSystem:moveCameraToObject(rdata.guid,false,nil)
UIManager:showWindow('UIRepairWin',rdata)
else
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild,sortType=c.buildTab,bdId=c.id,isBuild=true})
end
end
end
end


function UITechnologyWin:refreshUpgradePanel(time)
local beginTime=time
if beginTime then
local isComplete,curTime,cdTime=yandaotaiModel:checkStudyisFinishTime(self.id,time)


if not isComplete then
self:stopLevelUpTimer()

self.txtUpgradeBar:setText(timeHelper.format_time_stamp4(cdTime))
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),curTime,beginTime,false)

self.lastTime=cdTime
self:startLevelUpTimer(beginTime)
self.speedupPanel:setActive(true)
self.btnFinishUpgrade:setActive(false)
else
self:stopLevelUpTimer()
self.txtUpgradeBar:setText('研究完成')
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),1,1,false)
self.btnFinishUpgrade:setActive(true)
self.speedupPanel:setActive(false)
self.btnFinishUpgrade:setSprite(globalABLookup.global,'button_tyanniu_3')
end
end
end


function UITechnologyWin:refreshSpeedPanel(typo)
self.btnAdsSpeedup:setActive(true)

self.speedup_type=typo

local mspData=self.mspData

self.iconAds:setActive(false)
self.payAds:setActive(false)

if mspData[4]and self.lastTime and self.lastTime<=self.feedTime then
self.speedUpMode=0
self.speedUpBtnText:setText('免费加速')
self.suCost:setActive(false)
return
end

self.suCost:setActive(true)

if mspData[2]then
local have
local itemId
local data
local speedupItemList=self:getSortSpeedupItemList()
local selectSpeedupItem=speedupItemList[1]
itemId=selectSpeedupItem.itemId
have=selectSpeedupItem.itemNotExpireCount
if have and have>0 then
data=selectSpeedupItem.data
end

self.speedup_item_id=nil
if data then
local cfg=itemsConfig.getConfig(itemId)
self.costIcon:setChildIcon(iconHelper.getIconName(cfg.id),true)
self.costValue:setText(have)
self.speedUpBtnText:setText(FMT.fmt('加速{0}',timeHelper.format_time_stamp11(data[2],true)))
self.speedup_item_count=data[1]
self.speedup_item_id=itemId
self.speedup_time=data[2]
self.speedUpMode=1
self.batchTime=data[3]

local nowTime=timeHelper.getServerShortTime()
local nearestExpireTime=selectSpeedupItem.nearestExpireTime
if nearestExpireTime>=0 and nearestExpireTime-nowTime>0 then
self:setSpeedupItemExpireTimer(nearestExpireTime)
end
return
end
end

if mspData[1]then
local needData=self.baseCfg[1]
local need,count=self:countSpeedUpNeed(needData)
local moneyId=needData[1]
self:setSPNeedText(need,moneyId)
self.costIcon:setChildIcon(iconHelper.getIconName(moneyId),true)
self.speedUpBtnText:setText('立即完成')
self.speedup_item_count=count
self.speedup_item_id=moneyId
self.speedup_time=needData[3]
self.speedUpMode=2
self.batchTime=0
return
end

self.btnAdsSpeedup:setActive(false)
end


function UITechnologyWin:setSpeedupItemExpireTimer(expireTime)
self:clearSpeedupItemExpireTimer()

local timeFun=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=expireTime-nowTime
if lerp<=0 then
self:clearSpeedupItemExpireTimer()

self:refreshSpeedPanel(self.speedup_type)
return
end
end

self.speedupItemExpireTimer=self:setTimer(1,0,timeFun)
timeFun()
end


function UITechnologyWin:clearSpeedupItemExpireTimer()
if self.speedupItemExpireTimer then
self:stopTimerByID(self.speedupItemExpireTimer)
self.speedupItemExpireTimer=nil
end
end

function UITechnologyWin:countSpeedUpNeed(needData)
local study_time=yandaotaiController.getchangeSpeed(self.config.study_time,self.value2)
local isComplete,curTime,cdTime=yandaotaiModel:checkStudyisFinishTime(self.id,study_time)
local count=math.ceil(cdTime/needData[3])
local need=count*needData[2]
return need,count
end

function UITechnologyWin:setSPNeedText(need,mtype)
local needText
local have=moneyModel.getMoney(mtype)
if have<need then
needText=FMT.fmt('<color=red>{0}</color>',need)
else
needText=need
end
self.costValue:setText(needText)
end

function UITechnologyWin:updateSPNeedText()
local needData=self.baseCfg[1]
local need=self:countSpeedUpNeed(needData)
self:setSPNeedText(need,needData[1])
end

function UITechnologyWin:startLevelUpTimer(time)
local tick=function()
local isComplete,curTime,cdTime=yandaotaiModel:checkStudyisFinishTime(self.id,time)
local dtime=cdTime
local allTime=time
self.lastTime=dtime
if dtime>0 then
self.txtUpgradeBar:setText(timeHelper.format_time_stamp4(dtime))
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),curTime+1,allTime)

if dtime<=self.feedTime and self.speedUpMode~=0 then
self:refreshSpeedPanel(self.speedup_type)
if self.tipsDialog and self.tipsDialog.dialog then
self.tipsDialog.dialog:doClose()
end
end

if self.speedUpMode==2 then
self:updateSPNeedText()
end
else
self:stopLevelUpTimer()
local study_time=yandaotaiController.getchangeSpeed(self.config.study_time,self.value2)
self:refreshUpgradePanel(study_time)
end
end
self:addCDUpdateFunc('UPYDTCD',tick)
end

function UITechnologyWin:stopLevelUpTimer()
self:removeCDUpdateFunc('UPYDTCD')
end


function UITechnologyWin:refreshAttr(list,flag)
local descObj=flag and self.curDesc or self.nextDesc

for i=1,3 do
if list[i]then
local text=yandaotaiModel:getTypeAttrDesc(list[i],flag)
descObj[i]:setText(text)
descObj[i]:setActive(true)
else
descObj[i]:setActive(false)
end
end
end

function UITechnologyWin:refreshLevelAttr()
local effectList=self.config.study_effect
self:refreshAttr(effectList)

self.nextLv:setActive(not self.maxLevel)
self.curLv:setText(string.format('等级%s',self.level))
self.nextLv:setText(string.format('等级%s',self.level+1))

if self.level==0 then
self.curLv:setText(string.format('未研究'))
self.notLv:setActive(true)

local effectList={}
self:refreshAttr(effectList,true)
else
self.curLv:setActive(true)
self.notLv:setActive(false)
local config=cfgHelper.get2(cfg_technologyconfig_get,self.id,self.level)
local effectList=config.study_effect
self:refreshAttr(effectList,true)
end
end


function UITechnologyWin:refreshCost()
self.moneylist=nil
local cfg=self.config
local itemList=cfg.study_cost
if itemList then
local count=#itemList
self.itemPanel:setChildLayoutGroupCreateItems(count)

local grids=self.itemPanel:getChildLayoutGroupGridList()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local reward=itemList[i+1]

if reward then

if not self.moneylist then self.moneylist={}end
if itemsConfig.isMoney(reward[1])then
local list={reward[1]}
table.insert(self.moneylist,list)
end

local rewardNum=reward[2]
local haveNum=itemsModel.getCount(reward[1])
local gray=0
local countStr=''
local showCountBG=rewardNum>1
local probability=rewardNum==-1

if rewardNum>=1 then
if haveNum<rewardNum then
gray=1
rewardNum=mathHelper.formatNumber(rewardNum)
countStr=string.format('<color=red>%s</color>',rewardNum)
else
rewardNum=mathHelper.formatNumber(rewardNum)
countStr=string.format("%s",rewardNum)
end
end

local conf={itemid=reward[1],showCountBG=showCountBG,itemcount=countStr,showStage=probability,showname=false,itemIndex=i,gray=gray}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(2,self.onClickItem)
item:SetChildPropData(2,prop)
item:SetChildActive(0,false)
else
item:SetChildActive(1,false)
end
end


if self.moneylist and next(self.moneylist)then
local len=#self.moneylist
if len<5 then
UIManager:showWindow('UITopMoneyWin2',self.moneylist)
else
UIManager:showWindow('UITopMoneyWin2',{{self.moneylist[1]},{self.moneylist[2]},{self.moneylist[3]},{self.moneylist[4]}})
end
else
UIManager:hideWindow('UITopMoneyWin2')
end
else
self.itemPanel:setActive(false)
end
end





function UITechnologyWin:getSortSpeedupItemList()
local sortItemList={}
local itemcfg=self.baseCfg[2]
local nowTime=timeHelper.getServerShortTime()
for k,v in pairs(itemcfg)do
local itemId=k
local needCount=v[1]
local itemNotExpireCount,itemAllCount=bagModel.getNotExpireItemCountById(itemId)
local nearestExpireTime=bagModel.getNearestExpireTimeById(itemId)

local isExpire=nearestExpireTime>=0 and nearestExpireTime-nowTime<=0
local nearestExpireLerp=math.abs(nowTime-nearestExpireTime)

local weight=0
if itemNotExpireCount>=needCount then
weight=weight+100
end
if itemAllCount>=needCount then
weight=weight+1000
end
if not isExpire then
weight=weight+10000
end

local item={
itemId=itemId,
itemNotExpireCount=itemNotExpireCount,
itemAllCount=itemAllCount,
nearestExpireLerp=nearestExpireLerp,
nearestExpireTime=nearestExpireTime,
weight=weight,
data=v,
}
sortItemList[#sortItemList+1]=item
end

table.sort(sortItemList,function(a,b)
if a.weight==b.weight then
if a.nearestExpireLerp==b.nearestExpireLerp then
return a.itemId<b.itemId
else
return a.nearestExpireLerp<b.nearestExpireLerp
end
else
return a.weight>b.weight
end
end)

return sortItemList
end

function UITechnologyWin.onClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end




function UITechnologyWin:onLevelUpBtn()
if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('衍道台升级中，暂不可研究')
return
end

local level,limitLevel,maxLevel,isMax=yandaotaiModel:isMaxLevel(self.id)

if level<limitLevel then
local studyList=yandaotaiModel:getStudyList()
if studyList.starTime and studyList.id then
local config=cfgHelper.get2(cfg_technologyconfig_get,studyList.id,1)
UIManager.error(string.format('科技%s正在研究中，请先完成当前研究',config.technology_name))
end

local flag,text=yandaotaiModel:checkIsEnoughUpLevel(self.config.unlock_condition)
if flag then
local isEnough,itemId=yandaotaiModel:checkIsEnoughCost(self.config.study_cost)
if isEnough then
local time=timeHelper.getServerShortTime()
if time>self.reqTime then
self.reqTime=time
yandaotaiController.send_6_177(self.id)
else
return

end
else
gainControl:showGainWin(itemId)
end
else
UIManager.error(text)
end
else
UIManager.error("科技已达到当前等级上限")
end
end

function UITechnologyWin:onAskHelpBtn()
local params={tostring(self.id),tostring(self.level+1)}
local pstr=jsonHelper.encode(params)
xianjieController.reqQiuZhu(self.speedup_type,speedUpMode.eAskHelp,pstr)
end

function UITechnologyWin:onCancelBtn()
local cfg=cfgHelper.get2(cfg_technologyconfig_get,self.id,self.level+1)
local name=cfg.technology_name
local itemList=cfg.study_cost
local contentStr=FMT.fmt('取消研究将全额返还材料，\n已消耗的加速道具不返还')

local show_data={
type='UIDialouge',
title='提示',
itemList=itemList,
content=contentStr,
oktext='取消研究',
canceltext='关闭',
canvasindex=9,
okcallback=function()
yandaotaiController.send_6_179()
end,
}

local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UITechnologyWin:onClickClose()
self:closeSelf()
end

function UITechnologyWin:onBtnFinishUpgrade()
self:playTechnologyEffect(self.id)
self:delayDo(0.5,function()
yandaotaiController.send_6_178(1,{self.id})
end)
end

function UITechnologyWin:onBtnAdsSpeedup()
if self.speedUpMode==0 then
zongmenControl:reqSpeedup(speedUpMode.eFree,1,0,self.speedup_type,self.sfId,self.bdData.un_build_id)
elseif self.speedUpMode==1 then
if self.lastTime and self.lastTime>self.batchTime then
local have=bagModel.getNotExpireItemCountById(self.speedup_item_id)
local desc='消耗<color=#7d3b17>{0}</color>张加速符\n加速<color=#7d3b17>{1}</color>'
local max=math.min(have,math.ceil(self.lastTime/self.speedup_time))
local speedupItemId=self.speedup_item_id
local speedupItemCount=self.speedup_item_count
local speedupType=self.speedup_type
local speedupTime=self.speedup_time
local args={
currVal=max,
minVal=1,
maxVal=max,
itemData={speedupItemId,have},
descFunc=function(val)
return FMT.fmt(desc,val,timeHelper.format_time_stamp11(speedupTime*val))
end,
applyFunc=function(val)
if val>0 then

local notExpireCount=bagModel.getNotExpireItemCountById(speedupItemId)
local useCount=val*speedupItemCount
if notExpireCount<useCount then
UIManager.error(FMT.fmt('{0}已过期',itemsConfig.getItemName(speedupItemId)))
return
end
local time=timeHelper.getServerShortTime()
if time>self.reqTime then
self.reqTime=time
zongmenControl:reqSpeedup(speedUpMode.eItem,val,speedupItemId,speedupType,self.sfId,self.bdData.un_build_id)
else
return

end
end
end
}
UIManager:showWindow('UIBatchUseWin',args)
else
local time=timeHelper.getServerShortTime()
if time>self.reqTime then
self.reqTime=time
zongmenControl:reqSpeedup(speedUpMode.eItem,self.speedup_item_count,self.speedup_item_id,self.speedup_type,self.sfId,self.bdData.un_build_id)
else

return
end
end
else
local data=self.baseCfg[1]
local need,count=self:countSpeedUpNeed(data)
local moneyId=data[1]
local have=moneyModel.getMoney(moneyId)
if have>=need then
local content=FMT.fmt('是否消耗{0}{1}立即完成研究',need,moneyModel.getMoneyName(moneyId))
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='加速',
canceltext='取消',
allowclickBG='false',
okcallback=function()
self:moneySpeedUp()
end,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
else
gainControl:showGainWin(moneyId)
end
end
end

function UITechnologyWin:moneySpeedUp()
local data=self.baseCfg[1]
local need,count=self:countSpeedUpNeed(data)
local moneyId=data[1]
local have=moneyModel.getMoney(moneyId)
if have>=need then
local time=timeHelper.getServerShortTime()
if time>self.reqTime then
self.reqTime=time
zongmenControl:reqSpeedup(speedUpMode.eMoney,count,moneyId,self.speedup_type,self.sfId,self.bdData.un_build_id)
else

return
end
end
end

function UITechnologyWin:onAdItemClick()
if self.speedup_item_id then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=self.speedup_item_id})
end
end






