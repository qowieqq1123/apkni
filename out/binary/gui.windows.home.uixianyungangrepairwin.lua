







def_class("UIXianYunGangRepairWin",UIWindowBase)









function UIXianYunGangRepairWin:bindComponents()

self.adItemClick=UIButton.get(self,0)
self.btnAdsSpeedup=UIButton.get(self,1)
self.cdPanel=UIObject.get(self,2)
self.cdProgress=UIObject.get(self,3)
self.completeBtn=UIButton.get(self,4)
self.costIcon=UIObject.get(self,5)
self.costList=UIObject.get(self,6)
self.costValue=UIText.get(self,7)
self.destext=UIText.get(self,8)
self.funcpanel2=UIObject.get(self,9)
self.gotoBtn=UIButton.get(self,10)
self.icon=UIObject.get(self,11)
self.iconAds=UIImage.get(self,12)
self.openTips=UIText.get(self,13)
self.payAds=UIText.get(self,14)
self.repairBtn=UIButton.get(self,15)
self.repairInfo=UIObject.get(self,16)
self.speedUpBtnText=UIText.get(self,17)
self.suCost=UIObject.get(self,18)
self.time1=UIText.get(self,19)
self.time2=UIText.get(self,20)
self.title=UIText.get(self,21)

self.adItemClick:setButtonClick(function()self:onAdItemClick()end)

self.btnAdsSpeedup:setButtonClick(function()self:onBtnAdsSpeedup()end)

self.completeBtn:setButtonClick(function()self:onCompleteBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.repairBtn:setButtonClick(function()self:onRepairBtn()end)



end


function UIXianYunGangRepairWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adItemClick);self.adItemClick=nil;
_UIObject_release(self.btnAdsSpeedup);self.btnAdsSpeedup=nil;
_UIObject_release(self.cdPanel);self.cdPanel=nil;
_UIObject_release(self.cdProgress);self.cdProgress=nil;
_UIObject_release(self.completeBtn);self.completeBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costList);self.costList=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.funcpanel2);self.funcpanel2=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.iconAds);self.iconAds=nil;
_UIObject_release(self.openTips);self.openTips=nil;
_UIObject_release(self.payAds);self.payAds=nil;
_UIObject_release(self.repairBtn);self.repairBtn=nil;
_UIObject_release(self.repairInfo);self.repairInfo=nil;
_UIObject_release(self.speedUpBtnText);self.speedUpBtnText=nil;
_UIObject_release(self.suCost);self.suCost=nil;
_UIObject_release(self.time1);self.time1=nil;
_UIObject_release(self.time2);self.time2=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this




function UIXianYunGangRepairWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.building_event,self.on_building_event)
self.on_ad_refresh=function(mtype,last,curr)
self:refresh()
end
self:addNotify(notifyConfig.adRefresh,self.on_ad_refresh)

self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local spcfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_allow')
self.mspData=spcfg[3]
self.feedTime=self.baseCfg[speedUpMode.eFree][1]
end


function UIXianYunGangRepairWin:__delete()
self:unbindComponents()

UIManager:hideWindow('UITopMoneyWin')

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

_this=nil
end

function UIXianYunGangRepairWin.on_building_event(etype,sfId,bdId,arg1,arg2)
local data=zongmenModel:getBuildingData(bdId)
if data.build_id~=_this.cfgId then
return
end
if etype==buildingEvent.buildStart or etype==buildingEvent.buildComplete
or etype==buildingEvent.levelUpStart or etype==buildingEvent.levelUpComplete then
if data.flag~=0 then
_this:refresh()
else
_this:onClickClose()
end
elseif etype==buildingEvent.speedUpComplete then
_this:refresh()
end
end




function UIXianYunGangRepairWin:onShow(argtable,afterOnloaded)
self.sfId=zongmenModel:getMountainId()
self.model=argtable[1]
self.data=argtable[2]
self:refresh()
end

function UIXianYunGangRepairWin:refresh()
local cfg
local levelCfg
if self.model==1 then
self.cdPanel:setActive(false)
cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.data.id)
self.config=cfg
levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.data.id,1)
self.level_config=levelCfg
self.cfgId=self.data.id

local isOpen,tipsData=XianYunGangModel:checkRepairBuildOpen(cfg)
self.tipsData=tipsData
if not isOpen then
self.repairInfo:setActive(false)
self.funcpanel2:setActive(true)
self.openTips:setText(tipsData.desc)
else
self.repairInfo:setActive(true)
self.funcpanel2:setActive(false)

self.time1:setText(timeHelper.format_time_stamp11(levelCfg.uplevel_times))

local costs=cfg.repair_cost[1]
local len=#costs
self.costList:setChildLayoutGroupCreateItems(len,function(index)
local reward=costs[index]
local item=self.costList:getChildLayoutGroupGridItem(index-1)
if reward then
local id=reward[1]
local count=reward[2]
local have=0
if moneyConfig.isMoney(id)then
have=moneyModel.getMoney(id)
else
have=bagModel.getItemCountById(id)
end
local colorStr=have>=count and"#65615f"or"#c82c2c"
local needStr=mathHelper.formatNumber(count)
local haveStr=mathHelper.formatNumber(have)
local itemicon=iconHelper.getIconName(id)

item:SetChildActive(-1,true)
item:SetChildIcon(0,itemicon,false)
item:SetChildText(1,FMT.fmt("<color={0}>{1}/{2}</color>",colorStr,haveStr,needStr))
else
item:SetChildActive(-1,false)
end
end)
end
else
self.bdData=self.data
self.cdPanel:setActive(true)
self.repairInfo:setActive(false)
self.funcpanel2:setActive(false)

cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.config=cfg
levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,1)
self.level_config=levelCfg
self.cfgId=self.bdData.build_id

self:stopCOuntDown()
self:startCountDown()
end


self.title:setText(cfg.name)
self.destext:setText(levelCfg.build_desc)
local repairModel=self:getRepairModel(cfg)
local scale=isometricMapSystem:getModelScale(repairModel,true)
self.icon:setChildUIModelShowTarget(repairModel,scale,nil,eAnimationID.stand)
end

function UIXianYunGangRepairWin:startCountDown()
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)

if not cddata.complete then
self.completeBtn:setActive(false)
self.btnAdsSpeedup:setActive(true)
self:refreshSpeedPanel(speedUpType.eUpgradeBuilding)
end

local playCheck=false
local tick=function()
if cddata.complete then
self.time2:setText('已完成')
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),1,1)
self:stopCOuntDown()
self.completeBtn:setActive(true)
self.btnAdsSpeedup:setActive(false)
else
self.lastTime=cddata.cd
self.time2:setText(FMT.fmt("{0}",timeHelper.format_time_stamp11(cddata.cd)))
if playCheck then
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)
else
playCheck=true
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime,false)
end
if self.lastTime<=self.feedTime and self.speedUpMode~=0 then
self:refreshSpeedPanel(self.speedup_type)
end
end
end
tick()
self:addCDUpdateFunc('XYGRPCD',tick)
end

function UIXianYunGangRepairWin:stopCOuntDown()
self:removeCDUpdateFunc('XYGRPCD')
end

function UIXianYunGangRepairWin:getRepairModel(cfg)
if cfg.sp_ui_model then
return cfg.sp_ui_model[0]
end
return cfg.repair_model[1]
end


function UIXianYunGangRepairWin:onHide()

end



function UIXianYunGangRepairWin:setSPNeedText(need,mtype)
local needText
local have=moneyModel.getMoney(mtype)
if have<need then
needText=FMT.fmt('<color=red>{0}</color>',need)
else
needText=need
end
self.costValue:setText(needText)
end

function UIXianYunGangRepairWin:updateSPNeedText()
local needData=self.baseCfg[1]
local need=self:countSpeedUpNeed(needData)
self:setSPNeedText(need,needData[1])

if self.tipsDialog then
local content=FMT.fmt('是否消耗{0}{1}立即完成建造',need,moneyModel.getMoneyName(needData[1]))
if self.tipsDialog.dialog then
self.tipsDialog.dialog:setContent(content)
end
end
end

function UIXianYunGangRepairWin:refreshSpeedPanel(typo)
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
end
end





function UIXianYunGangRepairWin:getSortSpeedupItemList()
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


function UIXianYunGangRepairWin:setSpeedupItemExpireTimer(expireTime)
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


function UIXianYunGangRepairWin:clearSpeedupItemExpireTimer()
if self.speedupItemExpireTimer then
self:stopTimerByID(self.speedupItemExpireTimer)
self.speedupItemExpireTimer=nil
end
end




function UIXianYunGangRepairWin:onAdItemClick()
if self.speedup_item_id then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=self.speedup_item_id})
end
end



function UIXianYunGangRepairWin:onBtnAdsSpeedup()
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
zongmenControl:reqSpeedup(speedUpMode.eItem,val,speedupItemId,speedupType,self.sfId,self.bdData.un_build_id)
end
end
}
UIManager:showWindow('UIBatchUseWin',args)
else
zongmenControl:reqSpeedup(speedUpMode.eItem,self.speedup_item_count,self.speedup_item_id,self.speedup_type,self.sfId,self.bdData.un_build_id)
end
else
local data=self.baseCfg[1]
local need,count=self:countSpeedUpNeed(data)
local moneyId=data[1]
local have=moneyModel.getMoney(moneyId)
if have>=need then
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eBuildingInfoCostSpeedUpTips)
if check then
self:moneySpeedUp()
else
self:showDialog()
end
else
gainControl:showGainWin(moneyId)
end
end
end

function UIXianYunGangRepairWin:showDialog()
local data=self.baseCfg[1]
local need=self:countSpeedUpNeed(data)
local content=FMT.fmt('是否消耗{0}{1}立即完成建造',need,moneyModel.getMoneyName(data[1]))
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='加速',
canceltext='取消',
allowclickBG='false',
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eBuildingInfoCostSpeedUpTips,flag)

end,
okcallback=function()
self:moneySpeedUp()
end,
closecallback=function()
self.tipsDialog=nil
end,
showclosebtn=true,
}
self.tipsDialog=UIDialogManager.newDialog(showdata)
self.tipsDialog:show()
end

function UIXianYunGangRepairWin:moneySpeedUp()
local data=self.baseCfg[1]
local need,count=self:countSpeedUpNeed(data)
local moneyId=data[1]
local have=moneyModel.getMoney(moneyId)
if have>=need then
zongmenControl:reqSpeedup(speedUpMode.eMoney,count,moneyId,self.speedup_type,self.sfId,self.bdData.un_build_id)
end
end

function UIXianYunGangRepairWin:onAdItemClick()
if self.speedup_item_id then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=self.speedup_item_id})
end
end

function UIXianYunGangRepairWin:countSpeedUpNeed(needData)
local dtime=buildingCDControl:getCD(buildingCDType.build,self.bdData.un_build_id)
local count=math.ceil(dtime/needData[3])
local need=count*needData[2]
return need,count
end



function UIXianYunGangRepairWin:onCompleteBtn()
local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuildComplete(sfId,self.data.un_build_id)

self:onClickClose()
end

function UIXianYunGangRepairWin:onClickClose()
self:closeSelf()
end

function UIXianYunGangRepairWin:onGotoBtn()
if self.tipsData then
local jtype=self.tipsData.jump.jtype
if jtype==1 then
weakGuideController:beginGuide(self.tipsData.jump.jargs[1])
elseif jtype==2 then
jumpManager:jump(self.tipsData.jump.jargs)
end
self:closeSelf()
end
end

function UIXianYunGangRepairWin:onRepairBtn()
local pass,tips=zongmenControl:checkBuildingPassRepairCondition(self.data.id)
if not pass then
UIManager.error(tips)
return
end
if not isometricMapSystem:checkRepairLevel(self.data.id,self.data.mapId,true)then
return
end

if not isometricMapSystem:checkRepairTask(self.data.id,self.data.mapId,true)then
return
end
local check,data=zongmenControl:checkCondition(self.level_config,true,self.sfId,true)
if not check then
if data[1]==3 then
local cnd=data[2]
local desc=""
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,cnd[1])
if cnd[2]>1 then
desc=string.format('需要%s级%s<color=#db3f3f>%s</color>座,是否前往?',cnd[3],bdcfg.name,cnd[2])
else
desc=string.format('需要%s等级达到<color=#db3f3f>%s级</color>,是否前往?',bdcfg.name,cnd[3])
end

local showdata=
{
type='UIDialouge',
title='提示',
content=desc,
oktext='前往',
canceltext='取消',
allowclickBG='false',
okcallback=function()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=cnd[1]}},nil,JUMP_BACK.eNomal)
end,
closecallback=function()
self.jumpDialog=nil
end,
showclosebtn=true,
}
self.jumpDialog=UIDialogManager.newDialog(showdata)
self.jumpDialog:show()
end
return
end

if not isometricMapSystem:checkRepairCost(self.config,nil,true)then
return
end

zongmenControl:reqBuild(self.sfId,self.data.id,self.data.x,self.data.y,self.data.orientation)
self:onClickClose()
end
