







def_class("UIXianYunGangWin",UIWindowBase)









function UIXianYunGangWin:bindComponents()

self.adItemClick=UIButton.get(self,0)
self.attrListContent=UIObject.get(self,1)
self.attrscrollview=UIObject.get(self,2)
self.backBtn=UIButton.get(self,3)
self.bagBtn=UIButton.get(self,4)
self.buildBtn=UIButton.get(self,5)
self.buildPanel=UIObject.get(self,6)
self.buildReddot=UIObject.get(self,7)
self.buildroot=UIObject.get(self,8)
self.cdProgress=UIObject.get(self,9)
self.completeBtn=UIButton.get(self,10)
self.completeReddot=UIObject.get(self,11)
self.costIcon=UIObject.get(self,12)
self.costList=UIObject.get(self,13)
self.costValue=UIText.get(self,14)
self.downroot=UIObject.get(self,15)
self.equipItem_1=UIBaseItem.get(self,16)
self.equipItem_2=UIBaseItem.get(self,17)
self.equipItem_3=UIBaseItem.get(self,18)
self.equipSlot=UIBaseItem.get(self,19)
self.icon=UIObject.get(self,20)
self.iconAds=UIImage.get(self,21)
self.leftroot=UIObject.get(self,22)
self.lock=UIObject.get(self,23)
self.mainroot=UIObject.get(self,24)
self.mbg=UIObject.get(self,25)
self.nameBtn=UIButton.get(self,26)
self.nameText=UIText.get(self,27)
self.notSkillEquipText=UIText.get(self,28)
self.payAds=UIText.get(self,29)
self.pfNamePanel=UIObject.get(self,30)
self.pifuNameText=UIText.get(self,31)
self.rightroot=UIObject.get(self,32)
self.root=UIObject.get(self,33)
self.ruleBtn=UIButton.get(self,34)
self.shipListContent=UIObject.get(self,35)
self.shipscrollview=UIObject.get(self,36)
self.skillItem_1=UIObject.get(self,37)
self.skillItem_2=UIObject.get(self,38)
self.skillItem_3=UIObject.get(self,39)
self.speedBtn=UIButton.get(self,40)
self.speedPanel=UIObject.get(self,41)
self.speedUpBtnText=UIText.get(self,42)
self.suCost=UIObject.get(self,43)
self.tabPiFuBtn=UIButton.get(self,44)
self.time2Text=UIText.get(self,45)
self.timeText=UIText.get(self,46)
self.Title=UIText.get(self,47)
self.uiroot=UIObject.get(self,48)
self.unlockBtn=UIButton.get(self,49)
self.unlockPanel=UIObject.get(self,50)
self.unlockText=UIText.get(self,51)
self.yzztpanel=UIObject.get(self,52)

self.adItemClick:setButtonClick(function()self:onAdItemClick()end)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.bagBtn:setButtonClick(function()self:onBagBtn()end)

self.buildBtn:setButtonClick(function()self:onBuildBtn()end)

self.completeBtn:setButtonClick(function()self:onCompleteBtn()end)

self.nameBtn:setButtonClick(function()self:onNameBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.speedBtn:setButtonClick(function()self:onSpeedBtn()end)

self.tabPiFuBtn:setButtonClick(function()self:onTabPiFuBtn()end)

self.unlockBtn:setButtonClick(function()self:onUnlockBtn()end)
self.equipItem={
self.equipItem_1,
self.equipItem_2,
self.equipItem_3,
}
self.skillItem={
self.skillItem_1,
self.skillItem_2,
self.skillItem_3,
}



end


function UIXianYunGangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adItemClick);self.adItemClick=nil;
_UIObject_release(self.attrListContent);self.attrListContent=nil;
_UIObject_release(self.attrscrollview);self.attrscrollview=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.bagBtn);self.bagBtn=nil;
_UIObject_release(self.buildBtn);self.buildBtn=nil;
_UIObject_release(self.buildPanel);self.buildPanel=nil;
_UIObject_release(self.buildReddot);self.buildReddot=nil;
_UIObject_release(self.buildroot);self.buildroot=nil;
_UIObject_release(self.cdProgress);self.cdProgress=nil;
_UIObject_release(self.completeBtn);self.completeBtn=nil;
_UIObject_release(self.completeReddot);self.completeReddot=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costList);self.costList=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.downroot);self.downroot=nil;
_UIObject_release(self.equipItem_1);self.equipItem_1=nil;
_UIObject_release(self.equipItem_2);self.equipItem_2=nil;
_UIObject_release(self.equipItem_3);self.equipItem_3=nil;
_UIObject_release(self.equipSlot);self.equipSlot=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.iconAds);self.iconAds=nil;
_UIObject_release(self.leftroot);self.leftroot=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.mainroot);self.mainroot=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.nameBtn);self.nameBtn=nil;
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.notSkillEquipText);self.notSkillEquipText=nil;
_UIObject_release(self.payAds);self.payAds=nil;
_UIObject_release(self.pfNamePanel);self.pfNamePanel=nil;
_UIObject_release(self.pifuNameText);self.pifuNameText=nil;
_UIObject_release(self.rightroot);self.rightroot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shipListContent);self.shipListContent=nil;
_UIObject_release(self.shipscrollview);self.shipscrollview=nil;
_UIObject_release(self.skillItem_1);self.skillItem_1=nil;
_UIObject_release(self.skillItem_2);self.skillItem_2=nil;
_UIObject_release(self.skillItem_3);self.skillItem_3=nil;
_UIObject_release(self.speedBtn);self.speedBtn=nil;
_UIObject_release(self.speedPanel);self.speedPanel=nil;
_UIObject_release(self.speedUpBtnText);self.speedUpBtnText=nil;
_UIObject_release(self.suCost);self.suCost=nil;
_UIObject_release(self.tabPiFuBtn);self.tabPiFuBtn=nil;
_UIObject_release(self.time2Text);self.time2Text=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.Title);self.Title=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.unlockBtn);self.unlockBtn=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
_UIObject_release(self.yzztpanel);self.yzztpanel=nil;
self.equipItem=nil;
self.skillItem=nil;
end


















local CmpShipSlotItemIndex={
chuzhan=0,
lock=1,
name=2,
reddot=3,
select=4,
bg=5,
}

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpLiandon=14,
cmpBtn=15,
}

local _this

local ztitemidx=
{
selfitem=0,
bg=1,
iconbg=2,
icon=3,
bg2=4,
name=5,
btn=6,
reddot=7
}


function UIXianYunGangWin:onLoaded(...)
self:bindComponents()
_this=self

self.checkList={}
self:addNotify(notifyConfig.building_event,self.on_building_event)
self.on_money_changed=function(mtype,last,curr)
if self.checkList[mtype]then
self:refresh()
return
end
end
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self.on_ad_refresh=function(mtype,last,curr)
self:refresh()
end
self:addNotify(notifyConfig.adRefresh,self.on_ad_refresh)

self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local spcfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_allow')
self.mspData=spcfg[3]
self.feedTime=self.baseCfg[speedUpMode.eFree][1]
end


function UIXianYunGangWin:__delete()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

if self.showMoney then
self.showMoney=nil
self:closeWindow('UITopMoneyWin')
end

_this=nil
end

function UIXianYunGangWin.on_building_event(etype,sfId,bdId,arg1,arg2)
local data=zongmenModel:getBuildingData(bdId)
if not data or data.build_id~=_this.selectShipData.build_id then
return
end
_this:refresh()
end

function UIXianYunGangWin:refreshMoneyPanel()
local shipData=self.selectShipData
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,shipData.build_id)
local mlist={}
for i,v in ipairs(cfg.repair_cost[1])do
if moneyConfig.isMoney(v[1])then
self.checkList[v[1]]=true
table.insert(mlist,{v[1]})
end
end
UIManager:showWindow('UITopMoneyWin',mlist)
end




function UIXianYunGangWin:onShow(argtable,afterOnloaded)
if argtable.build_id~=SLG_SYSTEM_TYPE.eXianYunGang then
local cfgs=cfg_fairylandboatconfig()
for i,v in ipairs(cfgs)do
if v.build_id==argtable.build_id then
self.selectShipIndex=i
break
end
end
else
self.selectShipIndex=1
end

self.sfId=zongmenModel:getMountainId()
self:refresh()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6007,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end

self:showYyztPanel()
end

function UIXianYunGangWin:refresh()
self:freshData()

local shipData=self.selectShipData
self.bdData=zongmenModel:findBuildingDataByID(self.sfId,shipData.build_id)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,shipData.build_id)
self.config=cfg

self.buildroot:setActive(false)
self.rightroot:setActive(false)
self.unlockPanel:setActive(false)
self.buildPanel:setActive(false)
self.speedPanel:setActive(false)
self.nameBtn:setActive(false)


local _data=isometricMapSystem:getRepairDataByID(self.sfId,shipData.build_id)
if _data then
local isOpen,tipsData=XianYunGangModel:checkRepairBuildOpen(cfg)
self.tipsData=tipsData
if not isOpen then
self.buildroot:setActive(true)
self.unlockPanel:setActive(true)

self.unlockText:setText(tipsData.desc)

else
self.buildroot:setActive(true)
self.buildPanel:setActive(true)


self:refreshBuildInfo()
end
else
if self.bdData.flag==buildingStateType.eBuilding then
self.buildroot:setActive(true)
self.speedPanel:setActive(true)


self:refreshSpeedInfo()
else
self.rightroot:setActive(true)
self.nameBtn:setActive(cfg.rename_conf~=nil)

self:refreshPanel()
end
end

self:refreshShipInfo()
self:refreshDownPanel()
self:refreshMoneyPanel()
end

function UIXianYunGangWin:refreshShipInfo()
local shipData=self.selectShipData
local _data=isometricMapSystem:getRepairDataByID(self.sfId,shipData.build_id)
local isLock=_data~=nil

self.lock:setActive(isLock)
self.icon:setActive(not isLock)
if not isLock then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.icon:getID(),false,true,false)
local selectId=UISettingModel:getCurSettingId_Type(KUANGE_TYPE.yunzhou)
local settingcfg=UISettingConfig.getCfg(KUANGE_TYPE.yunzhou,selectId)
local scale=settingcfg.xygmodelcfg.scale
local offset=settingcfg.xygmodelcfg.offset
self.icon:setChildUIModelShowTarget(settingcfg.modelId,scale,nil,eAnimationID.stand)
self.icon:setChildUIModelShowTargetOffset(offset[1],offset[2])
end

local buildName=shipData.name
if self.bdData and self.bdData.name then
buildName=self.bdData.name
end
self.nameText:setText(buildName)


self.pifuNameText:setText("")
end

function UIXianYunGangWin:refreshBuildName(name)
self.nameText:setText(name)

local item=self.shipListContent:getChildLayoutGroupGridItem(self.selectShipIndex-1)
item:SetChildText(CmpShipSlotItemIndex.name,name)
end


function UIXianYunGangWin:freshData()
local list={}
local cfgs=cfg_fairylandboatconfig()
for i,v in ipairs(cfgs)do
table.insert(list,v)
local _data=isometricMapSystem:getRepairDataByID(self.sfId,v.build_id)
if _data then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
local isOpen,tipsData=XianYunGangModel:checkRepairBuildOpen(cfg)
if not isOpen then
break
end
end
end
self.shipLen=#list
self.shipDatas=list

self.selectShipIndex=self.selectShipIndex or 1
self.selectShipData=self.shipDatas[self.selectShipIndex]

self:freshExplorationShip()
end

function UIXianYunGangWin:freshExplorationShip()
local shipDatas=self.shipDatas
local shipNumber=self.shipLen

self.shipListContent:setChildLayoutGroupCreateItems(shipNumber,function(index)
local data=shipDatas[index]
local item=self.shipListContent:getChildLayoutGroupGridItem(index-1)

self:freshSingleShip(item,data,self.selectShipIndex==index)


item:SetBaseItemClickEvent(-1,function()
local _data=isometricMapSystem:getRepairDataByID(self.sfId,data.build_id)
if _data then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isOpen,tipsData=XianYunGangModel:checkRepairBuildOpen(cfg)
if not isOpen then
local content=FMT.fmt('是否{0}',tipsData.desc)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=function()
self:unlockJump(tipsData)
end,
showclosebtn=true,
}
self.tipsDialog=UIDialogManager.newDialog(showdata)
self.tipsDialog:show()
return
end
end

local oldItem=self.shipListContent:getChildLayoutGroupGridItem(self.selectShipIndex-1)
oldItem:SetChildActive(CmpShipSlotItemIndex.select,false)
self.selectShipIndex=index
self.selectShipData=data
self:freshSingleShip(item,self.selectShipData,true)

self:refresh()
end)
end)


self.shipscrollview:setChildScrollRectEnable(true)
end

function UIXianYunGangWin:freshSingleShip(item,data,isSelect)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
item:SetChildActive(CmpShipSlotItemIndex.select,isSelect)

local dzList=xianjieModel:getXJYZChuZhenTeamList(data.id)
local fontColor='#f7f7f7'
local nameStr=data.name
local isLock=false
local isChuZhan=dzList~=nil
local isShowReddot=false

local _data=isometricMapSystem:getRepairDataByID(self.sfId,data.build_id)
if _data then
local isOpen,tipsData=XianYunGangModel:checkRepairBuildOpen(cfg)
if not isOpen then
nameStr=""
isLock=true
else
fontColor='#ffa13d'
nameStr="可建造"

isShowReddot=self:getIsCanBuild(data.build_id,false)
end
else
local bdData=zongmenModel:findBuildingDataByID(self.sfId,data.build_id)
if bdData.flag==buildingStateType.eBuilding then
fontColor='#ffe34e'
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
if cddata.complete then
isShowReddot=true
nameStr="建造完成"
else
nameStr="建造中"
if not self.timer then
self.timer={}
end
if self.timer[data.id]then
self:stopTimerByID(self.timer[data.id])
self.timer[data.id]=nil
end
self.timer[data.id]=self:setTimer(cddata.cd,1,function()
_this:stopTimerByID(_this.timer[data.id])
_this.timer[data.id]=nil
item:SetChildActive(CmpShipSlotItemIndex.reddot,true)
item:SetChildText(CmpShipSlotItemIndex.name,toColorStringX('#ffe34e',"建造完成"))
end)

end
else
if bdData and bdData.name then
nameStr=bdData.name
end
end
end

item:SetChildActive(CmpShipSlotItemIndex.lock,isLock)
item:SetChildImageExGray(CmpShipSlotItemIndex.bg,isLock)
item:SetChildActive(CmpShipSlotItemIndex.chuzhan,isChuZhan)
item:SetChildActive(CmpShipSlotItemIndex.reddot,isShowReddot)

item:SetChildText(CmpShipSlotItemIndex.name,toColorStringX(fontColor,nameStr))
end



function UIXianYunGangWin:refreshBuildInfo()
local shipData=self.selectShipData
self:refreshBuildRed(shipData.build_id)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,shipData.build_id)
local lvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,shipData.build_id,1)

local time=lvCfg.uplevel_times
self.timeText:setText(FMT.fmt("建造时间：{0}",timeHelper.format_time_stamp3(time,true)))

local costs=cfg.repair_cost[1]
local len=#costs
self.costList:setChildLayoutGroupCreateItems(len,function(index)
local reward=costs[index]
local item=self.costList:getChildLayoutGroupGridItem(index-1)
if reward then
local id=reward[1]
local count=reward[2]
local itemicon=iconHelper.getIconName(id)
item:SetChildActive(-1,true)
widgetHelper.setItemQulaity(item,id,0)
item:SetChildIcon(1,itemicon,false)
item:SetChildActive(2,count>0)
if count>0 then
local haveNum=itemsModel.getCount(id)
local numColor=haveNum>=count and'#76d81e'or'red'
item:SetChildText(3,FMT.fmt("<color={1}>{0}</color>",mathHelper.formatNumber(count),numColor))
end
item:SetChildButtonClick(-1,function()
itemsComponentHelper.onItemClick(id)
end)
else
item:SetChildActive(-1,false)
end

end)
end



function UIXianYunGangWin:refreshSpeedInfo()
self:stopCOuntDown()
self:startCountDown()
end

function UIXianYunGangWin:startCountDown()
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)

if not cddata.complete then
self.completeBtn:setActive(false)
self.completeReddot:setActive(false)
self.speedBtn:setActive(true)
self:refreshSpeedPanel(speedUpType.eUpgradeBuilding)

if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self:setChildRotation(self.completeReddot:getID(),0,0,0)
end
end

local playCheck=false
local tick=function()
if cddata.complete then
self.time2Text:setText("已完成")
self.cdProgress:setChildUIProgressbar(1,1)
self:stopCOuntDown()
self.completeBtn:setActive(true)
self.completeReddot:setActive(true)
self.speedBtn:setActive(false)

if self.reddotTweener==nil then
self:setChildRotation(self.completeReddot:getID(),0,0,0)
local tweener=self:setChildDOPunchRotation(self.completeReddot:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
self.lastTime=cddata.cd
self.time2Text:setText(FMT.fmt("剩余时间：{0}",timeHelper.format_time_stamp11(cddata.cd)))
self.cdProgress:setChildUIProgressbar(1,1)
if playCheck then
self.cdProgress:setChildUIProgressbar(cddata.dtime+1,cddata.ntime)
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)
else
playCheck=true
self.cdProgress:setChildUIProgressbar(cddata.dtime+1,cddata.ntime,false)
end
if self.lastTime<=self.feedTime and self.speedUpMode~=0 then
self:refreshSpeedPanel(self.speedup_type)
end
end
end
tick()
self:addCDUpdateFunc('YZRPCD',tick)
end

function UIXianYunGangWin:stopCOuntDown()
self:removeCDUpdateFunc('YZRPCD')
end


function UIXianYunGangWin:setSPNeedText(need,mtype)
local needText
local have=moneyModel.getMoney(mtype)
if have<need then
needText=FMT.fmt('<color=red>{0}</color>',need)
else
needText=need
end
self.costValue:setText(needText)
end

function UIXianYunGangWin:updateSPNeedText()
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

function UIXianYunGangWin:refreshSpeedPanel(typo)
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





function UIXianYunGangWin:getSortSpeedupItemList()
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


function UIXianYunGangWin:setSpeedupItemExpireTimer(expireTime)
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


function UIXianYunGangWin:clearSpeedupItemExpireTimer()
if self.speedupItemExpireTimer then
self:stopTimerByID(self.speedupItemExpireTimer)
self.speedupItemExpireTimer=nil
end
end



function UIXianYunGangWin:refreshPanel()
self:refreshEquipList()
self:refreshEquipSlot()
end

function UIXianYunGangWin:refreshDownPanel()
local shipData=self.selectShipData
local isOpen=self.bdData~=nil and self.bdData.flag~=buildingStateType.eBuilding
self.ruleBtn:setActive(isOpen)

local buffAttrs={}
local yandaotaiAttrs=yandaotaiModel:getAddrateDatasByEffectId(5)or{}
for i,v in pairs(yandaotaiAttrs)do
local attrID=i
local val=buffAttrs[attrID]or 0
buffAttrs[attrID]=val+v
end

local yzAttrList=XianYunGangModel:getYunZhouJunZhenAttrsLookup(shipData.id)
helper.getAttrRelationShipChange(yzAttrList)

local attrTypes={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
eAttributeType.eJZ_CNT_VALUE,
eAttributeType.eYZ_Speed,
eAttributeType.ePoZhen,
}
local attrTypeData={
[eAttributeType.eJZATK_PCT]={icon=6,getValue=function()
local attrVal=xianjieModel:getJZAttrLookup(eAttributeType.eJZATK_PCT)or 0
local yzAttrVal=yzAttrList[eAttributeType.eJZATK_PCT]or 0
return attrVal+yzAttrVal
end},
[eAttributeType.eJZDEF_PCT]={icon=1,getValue=function()
local attrVal=xianjieModel:getJZAttrLookup(eAttributeType.eJZDEF_PCT)or 0
local yzAttrVal=yzAttrList[eAttributeType.eJZDEF_PCT]or 0
return attrVal+yzAttrVal
end},
[eAttributeType.eJZHP_PCT]={icon=2,getValue=function()
local attrVal=xianjieModel:getJZAttrLookup(eAttributeType.eJZHP_PCT)or 0
local yzAttrVal=yzAttrList[eAttributeType.eJZHP_PCT]or 0
return attrVal+yzAttrVal
end},
[eAttributeType.eJZ_CNT_VALUE]={icon=4,name="弟子军阵",getValue=function()
return xianjieModel:getJiJieAddCount()
end},
[eAttributeType.eYZ_Speed]={icon=3,getValue=function()
local attrVal=xianjieModel:getJZAttrLookup(eAttributeType.eYZ_Speed)or 0
local yzAttrVal=yzAttrList[eAttributeType.eYZ_Speed]or 0
local notJiJieAttrVal=xianjieModel:getBuffAttribute(xjBuffEffectType.eYunZhouAttrJiaChengNotJiJie,eAttributeType.eYZ_Speed)or 0
return 10000+attrVal+yzAttrVal+notJiJieAttrVal
end},
[eAttributeType.ePoZhen]={icon=5,getValue=function()
local attrVal=xianjieModel:getJZAttrLookup(eAttributeType.ePoZhen)or 0
local yzAttrVal=yzAttrList[eAttributeType.ePoZhen]or 0
return 10000+attrVal+yzAttrVal
end},
}

self.attrListContent:setChildLayoutGroupCreateItems(#attrTypes,function(index)
local item=self.attrListContent:getChildLayoutGroupGridItem(index-1)
local attrID=attrTypes[index]

local attrValue=attrTypeData[attrID].getValue()

local attrCfg=cfgHelper.get1(cfg_attributesconfig_get,attrID)

item:SetChildText(0,attrTypeData[attrID].name or attrCfg.attrname)
item:SetChildText(1,isOpen and helper.getAttributeStrEx(attrID,attrValue)or"<color=#ca631d>???</color>")
item:SetChildCSImageSprite(2,YUNZHOU_ABNAME,FMT.fmt("icon_yunzhoushuxing_{0}",attrTypeData[attrID].icon))

item:SetChildButtonClick(-1,function()
if not isOpen then
return
end
local d={}
d.title=FMT.fmt('【{0}】',attrTypeData[attrID].name or attrCfg.attrname)
d.desc=cfgHelper.getlang(FMT.fmt("YunZhouAttrDesc_{0}",attrID))
local posVector2=item:GetChildScreenPointToLocalPointRectangle(-1)
local posX=posVector2.x+120
local posY=posVector2.y+45
d.pos={posX,posY}
if buffAttrs[attrID]and buffAttrs[attrID]>0 then
d.buffText=helper.getAttributeStrEx(attrID,buffAttrs[attrID])
end
UIManager:showWindow('UIXianYunGangAttrDescWin',d)
end)
end)
end

function UIXianYunGangWin:refreshEquipList()
for i=1,3 do
self:refreshEquipItemEx(i)
end
end

function UIXianYunGangWin:refreshEquipItemEx(idx)
local widget=self.equipItem[idx]:getChildWidgetBase()
local boatid=self.selectShipData.id
local equip=XianYunGangModel:getYunZhouComponentsPosData(boatid,idx)
local typename
if idx==1 then
typename="龙首"
elseif idx==2 then
typename="龙骨"
else
typename="阵炉"
end
widget:SetChildText(_itemWidgetIdx.cmpItemName,typename)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage


local stageStr=''
local star=stage

local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
local iconName=iconHelper.getIconName(itemid)
local reddot=yunZhouEquipsConfig.checkEquipIsCanJingLian(equip)
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)


widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildText(_itemWidgetIdx.cmpItemName,typename)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetChildButtonClick(_itemWidgetIdx.cmpBtn,function()self:onClickYunZhouComponents(idx)end)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,true)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildButtonClick(_itemWidgetIdx.cmpBtn,function()self:onClickYunZhouComponents(idx)end)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIXianYunGangWin:onClickYunZhouComponents(pos)
local boatid=self.selectShipData.id
local equip=XianYunGangModel:getYunZhouComponentsPosData(boatid,pos)
if equip then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eYunZhouComponents,itemguid=equip.itemguid,itemid=equip.itemid,attach={yzId=boatid,pos=pos}})
else
local callFunc=function()
self:showWindow("UIYunZhouComponentsGainWin",{boat_id=boatid,pos=pos})
end
XianJunYanZhenModel:showXJYZUsedDialouge({boat_id=boatid,callFunc=callFunc})
end
end

function UIXianYunGangWin:refreshEquipSlot()
local equip
self.skillList={}
self.notSkillEquipText:setActive(equip==nil)

local widget=self.equipSlot:getChildWidgetBase()
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local star=0

local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local iconName=iconHelper.getIconName(itemid)
local reddot=equipsHelper.checkEquipIsCanJingLian(itemguid)
local suitIconName=equipsHelper.getEquipSuitIcon(equip)


widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)


if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,true)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end

for i=1,3 do
self:refreshSkillSlotEx(i)
end
end

function UIXianYunGangWin:refreshSkillSlotEx(idx,showEffect)
local skillItem=self.skillItem[idx]
local item=skillItem:getChildWidgetBase()
local d=self.skillList[idx]
if d then
local skillID=d[1]
local skillLv=d[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0
item:SetChildActive(-1,true)

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

item:SetChildActive(4,not islock)
if not islock then
local c_skillLv=skillLv
if st==eSkillTipsType.eDZGFSkill then
c_skillLv=UIDiscipleModel:getSkillLv(self.disciple_guid,skillID,c_skillLv)
end
item:SetChildText(2,skillModel:getSkillLvStr(c_skillLv))
end

item:SetChildActive(5,islock)

item:SetChildText(7,skillCfg.name)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(eSkillTipsType.eDZGFSkill,skillID,skillLv)
end)
else
item:SetChildActive(-1,false)
end
end

function UIXianYunGangWin:refreshBuildRed(build_id)
local isCanBuild=self:getIsCanBuild(build_id,false)
self.buildReddot:setActive(isCanBuild)
end

function UIXianYunGangWin:getIsCanBuild(build_id,wraning)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local lvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,build_id,1)
local _data=isometricMapSystem:getRepairDataByID(self.sfId,build_id)

if not isometricMapSystem:checkRepairLevel(_data.id,_data.mapId,wraning)then
return false
end

if not isometricMapSystem:checkRepairTask(_data.id,_data.mapId,wraning)then
return false
end

if not zongmenControl:checkCondition(lvCfg,wraning,self.sfId)then
return false
end

if not isometricMapSystem:checkRepairCost(cfg,nil,wraning)then
return false
end
return true
end


function UIXianYunGangWin:onHide()

end

function UIXianYunGangWin:onSkillItemClick(skillType,skillID,skillLv)

local args={skillID=skillID,skillLv=skillLv,attend=skillType,dis_guid=self.disciple_guid,changLv=true}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end




function UIXianYunGangWin:onBagBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eYunZhouComponentsWarehouse)
end



function UIXianYunGangWin:onBuildBtn()
local shipData=self.selectShipData
local isCanBuild=self:getIsCanBuild(shipData.build_id,true)
if not isCanBuild then
return false
end
local _data=isometricMapSystem:getRepairDataByID(self.sfId,shipData.build_id)
zongmenControl:reqBuild(self.sfId,_data.id,_data.x,_data.y,_data.orientation)
end



function UIXianYunGangWin:onNameBtn()

local rename_conf=cfgHelper.get2(cfg_monijybuildconfig_get,self.bdData.build_id,'rename_conf')
if rename_conf==nil then
UIManager.error('该建筑没有改名配置')
return
end
UIManager:showWindow('UIBuildChangeNameWin',{sfId=self.sfId,bdData=self.bdData,isHideRandom=true})
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtLingShi},{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}})
end



function UIXianYunGangWin:onSpeedBtn()
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

function UIXianYunGangWin:showDialog()
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

function UIXianYunGangWin:moneySpeedUp()
local data=self.baseCfg[1]
local need,count=self:countSpeedUpNeed(data)
local moneyId=data[1]
local have=moneyModel.getMoney(moneyId)
if have>=need then
zongmenControl:reqSpeedup(speedUpMode.eMoney,count,moneyId,self.speedup_type,self.sfId,self.bdData.un_build_id)
end
end

function UIXianYunGangWin:onAdItemClick()
if self.speedup_item_id then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=self.speedup_item_id})
end
end

function UIXianYunGangWin:countSpeedUpNeed(needData)
local dtime=buildingCDControl:getCD(buildingCDType.build,self.bdData.un_build_id)
local count=math.ceil(dtime/needData[3])
local need=count*needData[2]
return need,count
end



function UIXianYunGangWin:onTabPiFuBtn()
UIManager.info('云舟皮肤功能敬请期待')
end



function UIXianYunGangWin:onUnlockBtn()
if self.config.repair_tips then
self:unlockJump(self.tipsData)
end
end

function UIXianYunGangWin:unlockJump(rtips)
local jtype=rtips.jump.jtype
if jtype==1 then
weakGuideController:beginGuide(rtips.jump.jargs[1])
elseif jtype==2 then
jumpManager:jump(rtips.jump.jargs)
end
UIManager:closeWindow('UIXianYunGangWin')

end



function UIXianYunGangWin:onBackBtn()
fullScreenUI.closeActiveUI(true)
end



function UIXianYunGangWin:onCompleteBtn()
zongmenControl:reqBuildComplete(self.sfId,self.bdData.un_build_id)
end



function UIXianYunGangWin:onRuleBtn()
local boatid=self.selectShipData.id
local czxs_max_cnt=tianShuDianController:getChuZhengXiuShiMaxCount()

local yandaotai_xs_cnt=0
local yandaotaiAttrs=yandaotaiModel:getAddrateDatasByEffectId(5)or{}
for i,v in pairs(yandaotaiAttrs)do
local attrID=tonumber(i)
if attrID==eAttributeType.eJZ_CNT_VALUE then
yandaotai_xs_cnt=v or 0
end
end

local yunZhouComponentsAttrsLookup=XianYunGangModel:getYunZhouComponentsAttrsLookup(boatid)or{}
local yunZhou_xs_cnt=yunZhouComponentsAttrsLookup[eAttributeType.eJZ_CNT_VALUE]or 0

local all_xs_cnt=czxs_max_cnt+yandaotai_xs_cnt+yunZhou_xs_cnt
local d={}
d.title='兵力上限详情'
d.datas={
{desc="云舟总兵力",value=all_xs_cnt},

{desc="天枢阁建筑",value=czxs_max_cnt},
{desc="道衍台兵法",value=yandaotai_xs_cnt},
{desc="阵旗阵法",value=yunZhou_xs_cnt},
}
UIManager:showWindow('UIXianYunGangRuleWin',d)
end



function UIXianYunGangWin:showYyztPanel()
if YunZhouZhenTuController:checkYunZhouZhenTuSystem()then
self.yzztpanel:setActive(true)
local widget=self.yzztpanel:getWidgetBase()
widget:SetChildButtonClick(1,function()
if _this==nil then return end
self:onYyztClick()
end)


self:freshYyztReddot()
else
self.yzztpanel:setActive(false)
end
end

function UIXianYunGangWin:freshYyztPanel()
local widget=self.yzztpanel:getWidgetBase()
local ztlist=cfg_yunzhouzhentuconfig()
local len=#ztlist
widget:SetChildLayoutGroupCreateItems(0,len,function(index)
local item=widget:GetChildLayoutGroupGridItem(0,index-1)
local chongshuList=ztlist[index].chongshu
self:refreshSingleZT(item,index,chongshuList)
end)
self:freshYyztReddot(widget)
end

function UIXianYunGangWin:refreshSingleZT(item,index,chongshuList)
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(index)
local isjihuo=false
local Chongidx=1
if yzztData then
isjihuo=true
Chongidx=yzztData.chongshu
end
local Chongid=chongshuList[Chongidx]



if isjihuo then
local Cfg_chongshu=cfg_zhentuchongshuconfig_get(Chongid)
local cs_name=Cfg_chongshu.name
item:SetChildActive(ztitemidx.bg2,true)
item:SetChildText(ztitemidx.name,cs_name)
item:SetChildGray(ztitemidx.icon,false)
else
item:SetChildActive(ztitemidx.bg2,false)
item:SetChildGray(ztitemidx.icon,true)
end

item:SetChildButtonClick(ztitemidx.btn,function()
if _this==nil then return end
self:onZTItemClick(index,Chongid,isjihuo)
end)
end

function UIXianYunGangWin:onZTItemClick(ztid,Chongid,isjihuo)
UIManager:showWindow('UIYunZhouZhenTuTips',{ztid=ztid})
end

function UIXianYunGangWin:freshYyztReddot()
local widget=_this.yzztpanel:getWidgetBase()
local reddot=YunZhouZhenTuModel:getYZZTAllReddot()
widget:SetChildActive(2,reddot)
end

function UIXianYunGangWin:onYyztClick()
YunZhouZhenTuController:OpenYunZhouZhenTuMainWin()
end

