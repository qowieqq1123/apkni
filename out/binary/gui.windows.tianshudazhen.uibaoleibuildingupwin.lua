







def_class("UIBaoLeiBuildingUpWin",UIWindowBase)









function UIBaoLeiBuildingUpWin:bindComponents()

self.adItemClick=UIButton.get(self,0)
self.attrCreator=UIObject.get(self,1)
self.btnAdsSpeedup=UIButton.get(self,2)
self.btnFinishUpgrade=UIButton.get(self,3)
self.btnInfo=UIButton.get(self,4)
self.buildingName=UIText.get(self,5)
self.condition_1=UIObject.get(self,6)
self.condition_2=UIObject.get(self,7)
self.condition_3=UIObject.get(self,8)
self.conditionPanel=UIObject.get(self,9)
self.conditionRoot=UIObject.get(self,10)
self.costIcon=UIObject.get(self,11)
self.costValue=UIText.get(self,12)
self.iconAds=UIImage.get(self,13)
self.levelUpPanel=UIObject.get(self,14)
self.levelUpTime=UIText.get(self,15)
self.lvUpBtn=UIButton.get(self,16)
self.materials=UIObject.get(self,17)
self.materialsItem_1=UIBaseItem.get(self,18)
self.materialsItem_2=UIBaseItem.get(self,19)
self.materialsItem_3=UIBaseItem.get(self,20)
self.materialsItem_4=UIBaseItem.get(self,21)
self.materialsItem_5=UIBaseItem.get(self,22)
self.maxLvPanel=UIObject.get(self,23)
self.maxTxt=UIText.get(self,24)
self.model=UIObject.get(self,25)
self.payAds=UIText.get(self,26)
self.sliderUpgrade=UIObject.get(self,27)
self.small_model=UIObject.get(self,28)
self.speedUpBtnText=UIText.get(self,29)
self.suCost=UIObject.get(self,30)
self.txtUpgradeBar=UIText.get(self,31)
self.upgradePanel=UIObject.get(self,32)
self.upingPanel=UIObject.get(self,33)
self.upingTxt=UIText.get(self,34)
self.warn=UIText.get(self,35)
self.warnRoot=UIObject.get(self,36)

self.adItemClick:setButtonClick(function()self:onAdItemClick()end)

self.btnAdsSpeedup:setButtonClick(function()self:onBtnAdsSpeedup()end)

self.btnFinishUpgrade:setButtonClick(function()self:onBtnFinishUpgrade()end)

self.btnInfo:setButtonClick(function()self:onBtnInfo()end)

self.lvUpBtn:setButtonClick(function()self:onLvUpBtn()end)
self.condition={
self.condition_1,
self.condition_2,
self.condition_3,
}
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
self.materialsItem_5,
}
self.small={
["model"]=self.small_model,
}



end


function UIBaoLeiBuildingUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adItemClick);self.adItemClick=nil;
_UIObject_release(self.attrCreator);self.attrCreator=nil;
_UIObject_release(self.btnAdsSpeedup);self.btnAdsSpeedup=nil;
_UIObject_release(self.btnFinishUpgrade);self.btnFinishUpgrade=nil;
_UIObject_release(self.btnInfo);self.btnInfo=nil;
_UIObject_release(self.buildingName);self.buildingName=nil;
_UIObject_release(self.condition_1);self.condition_1=nil;
_UIObject_release(self.condition_2);self.condition_2=nil;
_UIObject_release(self.condition_3);self.condition_3=nil;
_UIObject_release(self.conditionPanel);self.conditionPanel=nil;
_UIObject_release(self.conditionRoot);self.conditionRoot=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.iconAds);self.iconAds=nil;
_UIObject_release(self.levelUpPanel);self.levelUpPanel=nil;
_UIObject_release(self.levelUpTime);self.levelUpTime=nil;
_UIObject_release(self.lvUpBtn);self.lvUpBtn=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.materialsItem_5);self.materialsItem_5=nil;
_UIObject_release(self.maxLvPanel);self.maxLvPanel=nil;
_UIObject_release(self.maxTxt);self.maxTxt=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.payAds);self.payAds=nil;
_UIObject_release(self.sliderUpgrade);self.sliderUpgrade=nil;
_UIObject_release(self.small_model);self.small_model=nil;
_UIObject_release(self.speedUpBtnText);self.speedUpBtnText=nil;
_UIObject_release(self.suCost);self.suCost=nil;
_UIObject_release(self.txtUpgradeBar);self.txtUpgradeBar=nil;
_UIObject_release(self.upgradePanel);self.upgradePanel=nil;
_UIObject_release(self.upingPanel);self.upingPanel=nil;
_UIObject_release(self.upingTxt);self.upingTxt=nil;
_UIObject_release(self.warn);self.warn=nil;
_UIObject_release(self.warnRoot);self.warnRoot=nil;
self.condition=nil;
self.materialsItem=nil;
self.small=nil;
end

















local _format=string.format


function UIBaoLeiBuildingUpWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.building_event,function(...)
self:on_building_event(...)
end)
self:showWindow('UITopMoneyWin',{{eMoneyType.mtLingShi},{eMoneyType.mtTieKuang},{eMoneyType.mtZhenShi}})
self:addNotify(notifyConfig.on_money_changed,function(moneyType)
if moneyType==eMoneyType.mtLingShi or
moneyType==eMoneyType.mtTieKuang or
moneyType==eMoneyType.mtZhenShi
then
self:refreshCostPanel()
end
end)
end


function UIBaoLeiBuildingUpWin:__delete()
self:unbindComponents()
end




function UIBaoLeiBuildingUpWin:onShow(argtable,afterOnloaded)
self.sfId=mapIdType.fort
self.bdData=argtable.bdData
self.winName=argtable.winName
self.winParams=argtable.winParams
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local spcfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_allow')
self.mspData=spcfg[3]
self.feedTime=self.baseCfg[speedUpMode.eFree][1]

self.moneylist=UIManager:invokeUIMethod('UITopMoneyWin','getMoneyList')
self:refreshInfo(argtable.attrs)
end


function UIBaoLeiBuildingUpWin:onHide()

end





function UIBaoLeiBuildingUpWin:onBtnInfo()
local vis=not self.showWin
self.showWin=vis
if vis then
self:showWindow(self.winName,self.winParams)
else
self:closeWindow(self.winName)
end
end

function UIBaoLeiBuildingUpWin:onBtnFinishUpgrade()
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
end



function UIBaoLeiBuildingUpWin:onLvUpBtn()
moneySystem:countAndExchange(self.nextLvCfg.uplevel_cost,eMoneyType.mtLingYu,function()
self:handleLevelUp()
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end

function UIBaoLeiBuildingUpWin:refreshInfo(attrs)
self.attrs=attrs
self.curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)

self.warn:setText('\194\160\194\160\194\160\194\160升级【天枢大阵】可以提升大阵防护值与驻守修士的军阵属性')
local str=FMT.fmt('{0}{1}级',self.config.name,self.curLvCfg.level)
self.buildingName:setText(string.insertBreakLine(str,true))
if pfwindowslController:checkIsGameVersion_yuenan()then
self.buildingName:setText(str)
end
self:refreshPanel()


local mdata_cur=isometricMapSystem:getModelByStatus(self.bdData.build_id,self.curLvCfg.level,0,nil,nil,nil,self.bdData.un_build_id,nil,true,true)
local model=mdata_cur.model
local scale=self.config.buildinfoscale
if self.config.infooffset and self.config.infomodel then
self.model:setChildUIModelShowTarget(model,self.config.infooffset[1],nil,eAnimationID.bd_stand)
self.model:setChildUIModelShowTargetOffset(self.config.infooffset[2],self.config.infooffset[3])
self.small_model:setChildUIModelShowTarget(model,self.config.infooffset[1],nil,eAnimationID.bd_stand)
self.small_model:setChildUIModelShowTargetOffset(self.config.infooffset[2],self.config.infooffset[3])
else
self.model:setChildUIModelShowTarget(model,scale,nil,eAnimationID.bd_stand)
self.small_model:setChildUIModelShowTarget(model,scale,nil,eAnimationID.bd_stand)
end
end

function UIBaoLeiBuildingUpWin:refreshCostPanel()
if self.nextLvCfg.uplevel_times>0 then
self.levelUpTime:setText(FMT.fmt('耗时：<color={0}>{1}</color>','#171311',timeHelper.format_time_stamp4(self.nextLvCfg.uplevel_times)))
else
self.levelUpTime:setText('立即完成')
end

local cost=self.nextLvCfg.uplevel_cost or{}
for i,item in ipairs(self.materialsItem)do
if cost[i]then
item:setActive(true)
local matItemId=cost[i][1]
local needCount=cost[i][2]
local countStr=UIDanYaoModel:getItemCountStr(matItemId,needCount)
local have=UIDanYaoModel:getHaveItemCount(matItemId)
local showStage=not moneyConfig.isMoney(matItemId)
local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetActive,7)]=have<needCount
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
self:onClickMaterialItem(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
else
item:setActive(false)
end
end

self.levelUpPanel:setActive(not self.cant_upgrade)

self:refreshConditionPanel(self.nextLvCfg)

end


function UIBaoLeiBuildingUpWin:onClickMaterialItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIBaoLeiBuildingUpWin:refreshPanel()
if self.nextLvCfg then
self.maxLvPanel:setActive(false)
if self.bdData.flag==buildingStateType.eUpgrading then
self.upgradePanel:setActive(true)
self.conditionPanel:setActive(false)
self:refreshUpgradePanel()
self:refreshSpeedPanel(speedUpType.eUpgradeBuilding)
self.lvUpBtn:setActive(false)
else
self.upgradePanel:setActive(false)
self.conditionPanel:setActive(true)
self.lvUpBtn:setActive(true)
self:refreshCostPanel()
end
else
self.upgradePanel:setActive(false)
self.conditionPanel:setActive(false)
self.lvUpBtn:setActive(false)
self.maxLvPanel:setActive(true)
end

self:refreshAttrPanel()
end

function UIBaoLeiBuildingUpWin:setSPNeedText(need,mtype)
local needText
local have=moneyModel.getMoney(mtype)
if have<need then
needText=FMT.fmt('<color=red>{0}</color>',need)
else
needText=need
end
self.costValue:setText(needText)
end

function UIBaoLeiBuildingUpWin:updateSPNeedText()
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

function UIBaoLeiBuildingUpWin:refreshSpeedPanel(typo)
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

function UIBaoLeiBuildingUpWin:refreshUpgradePanel()
local beginTime=self.bdData.begintime
if beginTime>0 then


local cdd=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),cdd.dtime,cdd.ntime,false)

local isComplete=buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)
if not isComplete then
self:stopLevelUpTimer()

self.txtUpgradeBar:setText(timeHelper.format_time_stamp4(cdd.cd))
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),cdd.dtime+1,cdd.ntime)

self.lastTime=cdd.cd
self:startLevelUpTimer()
self.btnAdsSpeedup:setActive(true)
self.btnFinishUpgrade:setActive(false)
else
self:stopLevelUpTimer()
self.btnAdsSpeedup:setActive(false)
self.txtUpgradeBar:setText('升级完成')
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),1,1,false)
self.btnFinishUpgrade:setActive(true)

self.btnFinishUpgrade:setSprite(globalABLookup.global,'button_tyanniu_3')
end
end
end

function UIBaoLeiBuildingUpWin:stopLevelUpTimer()
self:removeCDUpdateFunc('UPCD')
end

function UIBaoLeiBuildingUpWin:startLevelUpTimer()
local tick=function()
local cdd=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)
local dtime=cdd.cd
self.lastTime=dtime
if dtime>0 then
self.txtUpgradeBar:setText(timeHelper.format_time_stamp4(dtime))
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),cdd.dtime+1,cdd.ntime)

if dtime<=self.feedTime and self.speedUpMode~=0 then
self:refreshSpeedPanel(self.speedup_type)
end
else
self:stopLevelUpTimer()
self:refreshUpgradePanel()
end
end
self:addCDUpdateFunc('UPCD',tick)
end

function UIBaoLeiBuildingUpWin:refreshAttrPanel()
local hasNext=self.nextLvCfg~=nil
local len=#self.attrs
self.winlua:SetChildLayoutGroupCreateItems(self.attrCreator:getID(),len,function(subIndex)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.attrCreator:getID(),subIndex-1)
local attr=self.attrs[subIndex]
local name=attr.name
widget:SetChildText(0,FMT.fmt('{0}：',name))
widget:SetChildText(3,attr.old)
if hasNext then
widget:SetChildText(1,attr.new)
widget:SetChildActive(2,true)
else
widget:SetChildText(1,'')
widget:SetChildActive(2,false)
end
end)
end

function UIBaoLeiBuildingUpWin:on_building_event(etype,sfId,ubdId,arg1,arg2)
if ubdId~=self.bdData.un_build_id then return end

if(etype==buildingEvent.levelUpStart or
etype==buildingEvent.levelUpComplete or
etype==buildingEvent.speedUpComplete)then

if etype==buildingEvent.levelUpComplete and not self:isCanLevelUp()then
self:closeSelf()
end
end
end

function UIBaoLeiBuildingUpWin:isCanLevelUp()
if self.cant_upgrade then
return false
end
if not self.nextLvCfg then
return false
end
local flag=zongmenControl:checkLevelUp(self.nextLvCfg)
if not flag then
return false
end
return true
end

function UIBaoLeiBuildingUpWin:handleLevelUp()
local flag,lvupData=zongmenControl:checkLevelUp(self.nextLvCfg,true,nil,true)
if not flag then
return
end
if self.cant_upgrade then
return
end
zongmenControl:reqBuildingLevelUp(self.sfId,self.bdData.un_build_id,0,{})
end

local showBtnTypeList={1,3,4,5}
function UIBaoLeiBuildingUpWin:refreshConditionPanel(config)
local datas=self:getLevelUpCND(config.uplevel_condition)
local count=0
for i=1,3 do
local condition=self.condition[i]
local widget=condition:getChildWidgetBase()
local data=datas[i]
if data then

local str
local bicon
local iconAb
local type=data.cfg.type
local isShowBtn=table.findValue(showBtnTypeList,type)~=nil and(not data.pass)
local arg1,arg2
if type==1 then
str=_format('需要宗门达到%d级',data.cfg.param)
widget:SetChildText(0,str)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,1)
bicon=cfg.icon
elseif type==2 then
str=_format('需要完成任务:%s',data.cfg.param)
widget:SetChildText(0,str)
elseif type==3 then





local c=cfgHelper.get1(cfg_monijybuildconfig_get,data.cfg.param[1])
arg1=data.data
arg2=c


local levelStr=_format("%d级",data.cfg.param[3])
if not data.pass then
levelStr=toColorString(FONT_COLOR.eRedColor,levelStr)
end
widget:SetChildText(0,_format('%s等级达到%s',c.name,levelStr))

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.cfg.param[1])
bicon=cfg.icon
elseif type==4 then
local param=data.cfg.param
local bookStr=mathHelper.numberToChinese(param[1])
local desc=FMT.fmt('完成谪仙令第{0}卷',bookStr)
if param[2]then
desc=FMT.fmt('{0}第{1}章',desc,param[2])
end
str=desc
widget:SetChildText(0,str)
elseif type==5 then
local desc=FMT.fmt('完成锁妖塔第{0}层',data.cfg.param)
str=desc
widget:SetChildText(0,str)
elseif type==6 then
local systemName=systemConfig.getSystemName(data.cfg.param)
local desc=FMT.fmt('解锁{0}系统',systemName)
str=desc
widget:SetChildText(0,str)
end
widget:SetChildActive(1,bicon~=nil)
widget:SetChildActive(2,data.pass)
widget:SetChildActive(3,isShowBtn)

if bicon then
if iconAb then
widget:SetChildCSImageSprite(1,iconAb,bicon)
else
widget:SetChildIcon(1,bicon,false)
end
end

if isShowBtn~=nil then
widget:SetChildButtonClick(3,function()
self:onGoToButton(data.cfg.type,arg1,arg2)
end,true)
end




if data.pass then
count=count+1
end
end
condition:setActive(data~=nil)
end
self.cant_upgrade=count<#datas

self.conditionRoot:setActive(#datas>0)

end

function UIBaoLeiBuildingUpWin:onGoToButton(ftype,arg1,arg2)
if ftype==1 then
self:onClickClose()
fullScreenUI.closeActiveUI()
UIManager:showWindow('UIZongmenInfoWin',{showback=true})
elseif ftype==3 then
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
elseif ftype==4 then
jumpManager:jump({id=JUMP_TYPE.eZheXianLing})
elseif ftype==5 then
jumpManager:jump({id=JUMP_TYPE.eShiLianTa})
end
end

function UIBaoLeiBuildingUpWin:getLevelUpCND(cfgs)
local list={}
for i,v in ipairs(cfgs)do
local data={}
data.cfg=v
data.index=i
if v.type==1 then
data.pass=zongmenModel:getLevel()>=v.param
elseif v.type==2 then
data.pass=taskModel:checkTaskFinish(v.param)
elseif v.type==3 then
local bdData
local bdDatas=zongmenModel:getBuildingDataByBdType(self.sfId,v.param[1])
local count=0
local level=v.param[3]
for _,bd in ipairs(bdDatas)do
if bd.level>=level then
count=count+1
else
bdData=bd
end
end
data.data=bdData
data.pass=count>=v.param[2]
data.count=count
data.need=v.param[2]
elseif v.type==4 then
data.pass=zheXianLingModel:checkFinish(v.param[1],v.param[2]or 0)
elseif v.type==5 then
data.pass=shiLianTaModel:getCurLayer()>v.param
end
table.insert(list,data)
end
table.sort(list,function(a,b)
if a.pass and not b.pass then
return true
elseif not a.pass and b.pass then
return false
else
return a.index<b.index
end
end)
return list
end

function UIBaoLeiBuildingUpWin:getSortSpeedupItemList()
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



function UIBaoLeiBuildingUpWin:setSpeedupItemExpireTimer(expireTime)
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


function UIBaoLeiBuildingUpWin:clearSpeedupItemExpireTimer()
if self.speedupItemExpireTimer then
self:stopTimerByID(self.speedupItemExpireTimer)
self.speedupItemExpireTimer=nil
end
end

function UIBaoLeiBuildingUpWin:onBtnAdsSpeedup()
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

function UIBaoLeiBuildingUpWin:showDialog()
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

function UIBaoLeiBuildingUpWin:moneySpeedUp()
local data=self.baseCfg[1]
local need,count=self:countSpeedUpNeed(data)
local moneyId=data[1]
local have=moneyModel.getMoney(moneyId)
if have>=need then
zongmenControl:reqSpeedup(speedUpMode.eMoney,count,moneyId,self.speedup_type,self.sfId,self.bdData.un_build_id)
end
end

function UIBaoLeiBuildingUpWin:onAdItemClick()
if self.speedup_item_id then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=self.speedup_item_id})
end
end

function UIBaoLeiBuildingUpWin:countSpeedUpNeed(needData)
local dtime=buildingCDControl:getCD(buildingCDType.build,self.bdData.un_build_id)
local count=math.ceil(dtime/needData[3])
local need=count*needData[2]
return need,count
end

function UIBaoLeiBuildingUpWin:onClickClose()
self:closeSelf()
end
