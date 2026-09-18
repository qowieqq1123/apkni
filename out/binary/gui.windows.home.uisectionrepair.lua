







def_class("UISectionRepair",UIWindowBase)









function UISectionRepair:bindComponents()

self.adItemClick=UIButton.get(self,0)
self.payAds=UIText.get(self,1)
self.speedUpBtnText=UIText.get(self,2)
self.btnAdsSpeedup=UIButton.get(self,3)
self.completeBtn=UIButton.get(self,4)
self.cdProgress=UIObject.get(self,5)
self.time2=UIText.get(self,6)
self.repairBtn=UIButton.get(self,7)
self.costScrollview=UIObject.get(self,8)
self.time1=UIText.get(self,9)
self.iconAds=UIImage.get(self,10)
self.icon=UIObject.get(self,11)
self.cdPanel=UIObject.get(self,12)
self.repairPanel=UIObject.get(self,13)
self.progress=UIObject.get(self,14)
self.destext=UIText.get(self,15)
self.title=UIText.get(self,16)
self.progressText=UIText.get(self,17)

self.adItemClick:setButtonClick(function()self:onAdItemClick()end)

self.btnAdsSpeedup:setButtonClick(function()self:onBtnAdsSpeedup()end)

self.completeBtn:setButtonClick(function()self:onCompleteBtn()end)

self.repairBtn:setButtonClick(function()self:onRepairBtn()end)



end


function UISectionRepair:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adItemClick);self.adItemClick=nil;
_UIObject_release(self.payAds);self.payAds=nil;
_UIObject_release(self.speedUpBtnText);self.speedUpBtnText=nil;
_UIObject_release(self.btnAdsSpeedup);self.btnAdsSpeedup=nil;
_UIObject_release(self.completeBtn);self.completeBtn=nil;
_UIObject_release(self.cdProgress);self.cdProgress=nil;
_UIObject_release(self.time2);self.time2=nil;
_UIObject_release(self.repairBtn);self.repairBtn=nil;
_UIObject_release(self.costScrollview);self.costScrollview=nil;
_UIObject_release(self.time1);self.time1=nil;
_UIObject_release(self.iconAds);self.iconAds=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.cdPanel);self.cdPanel=nil;
_UIObject_release(self.repairPanel);self.repairPanel=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.progressText);self.progressText=nil;
end
















local _this




function UISectionRepair:onLoaded(...)
self:bindComponents()

_this=self

self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')

self.costScrollview:setChildScrollViewInit(0.5,true,nil,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UISectionRepair:__delete()
self:unbindComponents()



_this=nil

UIManager:hideWindow('UITopMoneyWin')

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UISectionRepair.on_building_event(etype,sfId,bdId,arg1,arg2)
local data=zongmenModel:getBuildingData(bdId)
if data.build_id~=_this.cfgId then
return
end
if etype==buildingEvent.buildStart or etype==buildingEvent.buildComplete
or etype==buildingEvent.levelUpStart or etype==buildingEvent.levelUpComplete then
if _this.model==1 then
_this.model=2
_this.data=data
end
if data.flag~=0 then
_this:refresh()
else
_this:onClickClose()
end
elseif etype==buildingEvent.speedUpComplete then
_this:refresh(true)
end
end

function UISectionRepair:showTopMoney(datas)
if not datas then
return
end
local mlist={}
for i,v in ipairs(datas)do
if moneyConfig.isMoney(v[1])then
table.insert(mlist,{v[1],0})
end
end
UIManager:showWindow('UITopMoneyWin',mlist)
end




function UISectionRepair:onShow(argtable,afterOnloaded)
self.sfId=zongmenModel:getMountainId()
self.model=argtable[1]
self.data=argtable[2]
self:refresh()
end


function UISectionRepair:onHide()

end

function UISectionRepair:refresh(playAnim)
local id
local rlevel=1
local cddata
if self.model==1 then
id=self.data.id
else
self.bdData=self.data
id=self.data.build_id
cddata=buildingCDControl:getCDData(buildingCDType.build,self.data.un_build_id,true)
if self.data.flag>20 then
rlevel=self.data.flag-19
else
rlevel=self.data.flag-10
end
end
self.cfgId=id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local costs=cfg.repair_cost[rlevel]
self.costData=costs

self:showTopMoney(costs)

local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)
self.destext:setText(levelCfg.build_desc)
local repairModel=self:getRepairModel(cfg,rlevel)
local scale=isometricMapSystem:getModelScale(repairModel,true)
self.icon:setChildUIModelShowTarget(repairModel,scale,nil,eAnimationID.bd_stand)
self.title:setText(cfg.name)

local c1=0
local c2=#cfg.repair_cost
if self.model==2 then
c1=rlevel-1
end


self.progressText:setText(FMT.fmt('修复进度：<color=red>{0}/{1}</color>',c1,c2))

if cddata then
self.repairPanel:setActive(false)
self.cdPanel:setActive(true)

self.time2:setText(timeHelper.format_time_stamp11(cddata.cd))
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime,cddata.ntime,playAnim==true)

self.lastTime=cddata.cd

if cddata.complete then
self.completeBtn:setActive(true)
self.btnAdsSpeedup:setActive(false)
else
self.completeBtn:setActive(false)
self.btnAdsSpeedup:setActive(false)
self:refreshSpeedPanel(speedUpType.eUpgradeBuilding)
end

self:stopCOuntDown()
if not cddata.complete then
self:startCountDown()
else
self.time2:setText('已完成')
self.isFull=(c1+1)==c2
end
else
self.repairPanel:setActive(true)
self.cdPanel:setActive(false)

local len=#costs
self.costScrollview:setChildScrollViewCreateGrids(len,math.min(len,5))
local grids=self.costScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local node=grids[i]
local data=costs[i+1]
widgetHelper.setNormalRewardItem(node,0,{data[1],data[2],checkAmount=true})
end

self.time1:setText(timeHelper.format_time_stamp11(cfg.repair_time[rlevel]))
end
end

function UISectionRepair:startCountDown()
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.data.un_build_id)
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)
local tick=function()
self.lastTime=cddata.cd
self.time2:setText(timeHelper.format_time_stamp11(cddata.cd))
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)
if cddata.complete then
self:stopCOuntDown()
self:refresh()
end
end

self:addCDUpdateFunc('SRPCD',tick)
end

function UISectionRepair:stopCOuntDown()




self:removeCDUpdateFunc('SRPCD')
end

function UISectionRepair:getRepairModel(cfg,rlevel)
if cfg.sp_ui_model then
return cfg.sp_ui_model[0]
end
return cfg.repair_model[rlevel]
end





function UISectionRepair:checkCost(wraning)
for i,v in ipairs(self.costData)do
local id=v[1]
local need=v[2]
if moneyConfig.isMoney(id)then
local have=moneyModel.getMoney(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(id)))
gainControl:showGainWin(id)
end
return false,id
end
else
local have=bagModel.getItemCountById(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(id)))
gainControl:showGainWin(id)
end
return false,id
end
end
end
return true
end

function UISectionRepair:onRepairBtn()
if self:checkCost(true)then
local sfId=zongmenModel:getMountainId()
if self.model==1 then
zongmenControl:reqBuild(sfId,self.data.id,self.data.x,self.data.y,0)
else
zongmenControl:reqBuildingLevelUp(sfId,self.data.un_build_id,0,{})
end
end
end

function UISectionRepair:onCompleteBtn()
local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuildingLevelUpComplete(sfId,self.data.un_build_id)
if self.isFull then
self:onClickClose()
end
end

function UISectionRepair:onClickClose()
self:closeSelf()
end



function UISectionRepair:refreshSpeedPanel(typo)
self.speedup_type=typo
local have
local itemId
local data
local itemcfg=self.baseCfg[2]
for k,v in pairs(itemcfg)do
have=bagModel.getItemCountById(k)
if have>0 then
itemId=k
data=v
break
end
end
self.speedup_item_id=nil
if data then
local cfg=itemsConfig.getConfig(itemId)
self.iconAds:setChildIcon(iconHelper.getIconName(cfg.id),true)
self.payAds:setText(string.format('剩余：%s',have))
self.speedUpBtnText:setText(FMT.fmt('加速{0}',timeHelper.format_time_stamp11(data[2],true)))
self.speedup_item_count=1
self.speedup_item_id=itemId
self.speedup_time=data[2]
self.speedUpMode=1
self.batchTime=data[3]
return
end
self.iconAds:setSprite(globalABLookup.global,'icon_djguankanshipin')
self.payAds:setText(string.format('免费加速'))
local needtime=adControl:getSpeedUpTime()
self.speedUpBtnText:setText(FMT.fmt('加速{0}',timeHelper.format_time_stamp11(needtime,true)))
self.speedUpMode=2
end






























function UISectionRepair:onBtnAdsSpeedup()
if self.speedUpMode==1 then
if self.lastTime>self.batchTime then
local have=bagModel.getItemCountById(self.speedup_item_id)
local desc='消耗<color=#7d3b17>{0}</color>张加速符\n加速<color=#7d3b17>{1}</color>'
local max=math.min(have,math.ceil(self.lastTime/self.speedup_time))
local args={
currVal=max,
minVal=1,
maxVal=max,
itemData={self.speedup_item_id,have},
descFunc=function(val)
return FMT.fmt(desc,val,timeHelper.format_time_stamp11(self.speedup_time*val))
end,
applyFunc=function(val)
if val>0 then
zongmenControl:reqSpeedup(speedUpMode.eItem,val,self.speedup_item_id,self.speedup_type,self.sfId,self.bdData.un_build_id)
end
end
}
UIManager:showWindow('UIBatchUseWin',args)
else
zongmenControl:reqSpeedup(speedUpMode.eItem,self.speedup_item_count,self.speedup_item_id,self.speedup_type,self.sfId,self.bdData.un_build_id)
end
else
if adControl:isFullWatch()then
UIManager.error(cfgHelper.get1(cfg_lang_get,'ad_tips_1'))
else
if adControl:getHaveAdCount()>0 then

else
UIManager.error(cfgHelper.get1(cfg_lang_get,'ad_tips_2'))
end
end
end
end

function UISectionRepair:onAdItemClick()
if self.speedup_item_id then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=self.speedup_item_id})
end
end