







def_class("UIBuildingInfoWin",UIWindowBase)








function UIBuildingInfoWin:bindComponents()

self.adItemClick=UIButton.get(self,0)
self.btnAdsSpeedup=UIButton.get(self,1)
self.btnFinishUpgrade=UIButton.get(self,2)
self.buildingName=UIText.get(self,3)
self.condition1=UIObject.get(self,4)
self.condition2=UIObject.get(self,5)
self.condition3=UIObject.get(self,6)
self.conditionPanel=UIObject.get(self,7)
self.content=UIObject.get(self,8)
self.content1=UIObject.get(self,9)
self.content2=UIObject.get(self,10)
self.content3=UIObject.get(self,11)
self.cost1=UIObject.get(self,12)
self.cost2=UIObject.get(self,13)
self.cost3=UIObject.get(self,14)
self.costIcon=UIObject.get(self,15)
self.costItem1=UIObject.get(self,16)
self.costItem2=UIObject.get(self,17)
self.costItem3=UIObject.get(self,18)
self.costItems=UIObject.get(self,19)
self.costPanel=UIObject.get(self,20)
self.costValue=UIText.get(self,21)
self.curIcon=UIObject.get(self,22)
self.curLv=UIText.get(self,23)
self.desText=UIText.get(self,24)
self.feishengtaiPanel=UIObject.get(self,25)
self.feishengtaiSpeedup=UIButton.get(self,26)
self.iconAds=UIImage.get(self,27)
self.imgCost1=UIImage.get(self,28)
self.imgCost2=UIImage.get(self,29)
self.imgCost3=UIImage.get(self,30)
self.itemroot=UIObject.get(self,31)
self.itemspeed1=UIBaseItem.get(self,32)
self.itemspeed2=UIBaseItem.get(self,33)
self.itemspeed3=UIBaseItem.get(self,34)
self.levelPanel=UIObject.get(self,35)
self.levelUpBtn=UIButton.get(self,36)
self.levelUpBtnTxt=UIText.get(self,37)
self.levelUpPanel=UIObject.get(self,38)
self.levelUpTime=UIText.get(self,39)
self.maxIcon=UIObject.get(self,40)
self.maxLv=UIText.get(self,41)
self.maxLvPanel=UIObject.get(self,42)
self.nextIcon=UIObject.get(self,43)
self.nextLv=UIText.get(self,44)
self.payAds=UIText.get(self,45)
self.scrollView=UIObject.get(self,46)
self.sliderUpgrade=UIObject.get(self,47)
self.speedUpBtnText=UIText.get(self,48)
self.speedupPanel=UIObject.get(self,49)
self.suCost=UIObject.get(self,50)
self.txtCost1=UIText.get(self,51)
self.txtCost2=UIText.get(self,52)
self.txtCost3=UIText.get(self,53)
self.txtDesc1=UIText.get(self,54)
self.txtDesc2=UIText.get(self,55)
self.txtDesc3=UIText.get(self,56)
self.txtUpgradeBar=UIText.get(self,57)
self.upgradePanel=UIObject.get(self,58)

self.adItemClick:setButtonClick(function()self:onAdItemClick()end)

self.btnAdsSpeedup:setButtonClick(function()self:onBtnAdsSpeedup()end)

self.btnFinishUpgrade:setButtonClick(function()self:onBtnFinishUpgrade()end)

self.feishengtaiSpeedup:setButtonClick(function()self:onFeishengtaiSpeedup()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)



end


function UIBuildingInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adItemClick);self.adItemClick=nil;
_UIObject_release(self.btnAdsSpeedup);self.btnAdsSpeedup=nil;
_UIObject_release(self.btnFinishUpgrade);self.btnFinishUpgrade=nil;
_UIObject_release(self.buildingName);self.buildingName=nil;
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.condition3);self.condition3=nil;
_UIObject_release(self.conditionPanel);self.conditionPanel=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.content1);self.content1=nil;
_UIObject_release(self.content2);self.content2=nil;
_UIObject_release(self.content3);self.content3=nil;
_UIObject_release(self.cost1);self.cost1=nil;
_UIObject_release(self.cost2);self.cost2=nil;
_UIObject_release(self.cost3);self.cost3=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costItem1);self.costItem1=nil;
_UIObject_release(self.costItem2);self.costItem2=nil;
_UIObject_release(self.costItem3);self.costItem3=nil;
_UIObject_release(self.costItems);self.costItems=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.curIcon);self.curIcon=nil;
_UIObject_release(self.curLv);self.curLv=nil;
_UIObject_release(self.desText);self.desText=nil;
_UIObject_release(self.feishengtaiPanel);self.feishengtaiPanel=nil;
_UIObject_release(self.feishengtaiSpeedup);self.feishengtaiSpeedup=nil;
_UIObject_release(self.iconAds);self.iconAds=nil;
_UIObject_release(self.imgCost1);self.imgCost1=nil;
_UIObject_release(self.imgCost2);self.imgCost2=nil;
_UIObject_release(self.imgCost3);self.imgCost3=nil;
_UIObject_release(self.itemroot);self.itemroot=nil;
_UIObject_release(self.itemspeed1);self.itemspeed1=nil;
_UIObject_release(self.itemspeed2);self.itemspeed2=nil;
_UIObject_release(self.itemspeed3);self.itemspeed3=nil;
_UIObject_release(self.levelPanel);self.levelPanel=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnTxt);self.levelUpBtnTxt=nil;
_UIObject_release(self.levelUpPanel);self.levelUpPanel=nil;
_UIObject_release(self.levelUpTime);self.levelUpTime=nil;
_UIObject_release(self.maxIcon);self.maxIcon=nil;
_UIObject_release(self.maxLv);self.maxLv=nil;
_UIObject_release(self.maxLvPanel);self.maxLvPanel=nil;
_UIObject_release(self.nextIcon);self.nextIcon=nil;
_UIObject_release(self.nextLv);self.nextLv=nil;
_UIObject_release(self.payAds);self.payAds=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.sliderUpgrade);self.sliderUpgrade=nil;
_UIObject_release(self.speedUpBtnText);self.speedUpBtnText=nil;
_UIObject_release(self.speedupPanel);self.speedupPanel=nil;
_UIObject_release(self.suCost);self.suCost=nil;
_UIObject_release(self.txtCost1);self.txtCost1=nil;
_UIObject_release(self.txtCost2);self.txtCost2=nil;
_UIObject_release(self.txtCost3);self.txtCost3=nil;
_UIObject_release(self.txtDesc1);self.txtDesc1=nil;
_UIObject_release(self.txtDesc2);self.txtDesc2=nil;
_UIObject_release(self.txtDesc3);self.txtDesc3=nil;
_UIObject_release(self.txtUpgradeBar);self.txtUpgradeBar=nil;
_UIObject_release(self.upgradePanel);self.upgradePanel=nil;
end


















local _this
local _format=string.format

local _item_cmp_index={
img_select=0,
txt_name=1,
txt_tips=2,
img_unlock=3,
img_lock=4,
}


function UIBuildingInfoWin:onLoaded(...)
self:bindComponents()
_this=self



self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

self._onItemListChanged=function(...)self:onItemListChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self._onItemListChanged)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.adRefresh,self.on_ad_refresh)

self.checkList={}
self.on_money_changed=function(mtype,last,curr)
if self.checkList[mtype]then
self:refreshCostPanel()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)

self.moneylist=UIManager:invokeUIMethod('UITopMoneyWin','getMoneyList')
end

function UIBuildingInfoWin:onItemListChanged(argsTable)
for i,v in ipairs(argsTable)do

if self.checkList[v[3]]then
self:refreshCostPanel()
return
end
end
end


function UIBuildingInfoWin:__delete()
self:clearSpeedupItemExpireTimer()
self:unbindComponents()



notifySystem:removelistener(notifyConfig.on_item_list_changed,self._onItemListChanged)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.adRefresh,self.on_ad_refresh)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)

if self.moneylist then
UIManager:showWindow('UITopMoneyWin',self.moneylist)
else
UIManager:hideWindow('UITopMoneyWin')
end
_this=nil
end

function UIBuildingInfoWin:refreshAfterItemUse(utype,arg1,arg2)
self:refreshLevelPanel()
end

function UIBuildingInfoWin:refreshMoneyPanel()
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
if not nextLvCfg then
nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
end
local mlist={}
for i,v in ipairs(nextLvCfg.uplevel_cost)do
self.checkList[v[1]]=true
if moneyConfig.isMoney(v[1])then
table.insert(mlist,{v[1]})
end
end
UIManager:showWindow('UITopMoneyWin',mlist)
end




function UIBuildingInfoWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
self.sfId=zongmenModel:getMountainId()
self.costs={
self.cost1,self.txtCost1,self.imgCost1,
self.cost2,self.txtCost2,self.imgCost2,
self.cost3,self.txtCost3,self.imgCost3,
}
self.contents={
self.content1,self.txtDesc1,
self.content2,self.txtDesc2,
self.content3,self.txtDesc3,
}
self.conditions={
self.condition1,
self.condition2,
self.condition3,
}
self.cost_items={self.costItem1,self.costItem2,self.costItem3}
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.allLvCfg=cfgHelper.get1(cfg_monijybuilduplvlconfig_get,self.bdData.build_id)
self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local spcfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_allow')
self.mspData=spcfg[3]

self.feedTime=self.baseCfg[speedUpMode.eFree][1]

self:refreshLevelPanel()
self:refreshRightPanel()

end

function UIBuildingInfoWin:refreshLevelPanel()
self:refreshMoneyPanel()

local maxLevel=zongmenModel:getBuildLimitMaxLv(self.bdData.build_id)
local isMaxLevel=self.bdData.level>=maxLevel
self.curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self.buildingName:setText(self.config.name)

local scale=self.config.buildinfoscale
local skinId=self.bdData.build_appearance_id
if skinId and skinId~=0 then

local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
if skinCfg and skinCfg.buildinfoscale then
scale=skinCfg.buildinfoscale
end
end

if(not isMaxLevel)and self.nextLvCfg then
self.maxLvPanel:setActive(false)

local mdata_cur=isometricMapSystem:getModelByStatus(self.bdData.build_id,self.curLvCfg.level,0,nil,nil,nil,self.bdData.un_build_id,nil,true,true)
local mdata_next=isometricMapSystem:getModelByStatus(self.bdData.build_id,self.nextLvCfg.level,0,nil,nil,nil,self.bdData.un_build_id,nil,true,true)
local model=mdata_cur.model

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.curIcon:getID(),true,true,true)
end
if self.config.infooffset and self.config.infomodel then
self.curIcon:setChildUIModelShowTarget(model,self.config.infooffset[1],nil,eAnimationID.stand)
self.curIcon:setChildUIModelShowTargetOffset(self.config.infooffset[2],self.config.infooffset[3])
else
self.curIcon:setChildUIModelShowTarget(model,scale,nil,eAnimationID.stand)
end

model=mdata_next.model


if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.nextIcon:getID(),true,true,true)
end
if self.config.infooffset and self.config.infomodel then
self.nextIcon:setChildUIModelShowTarget(model,self.config.infooffset[1],nil,eAnimationID.stand)
self.nextIcon:setChildUIModelShowTargetOffset(self.config.infooffset[2],self.config.infooffset[3])
else
self.nextIcon:setChildUIModelShowTarget(model,scale,nil,eAnimationID.stand)
end
self.curLv:setText(_format('%s级',self.curLvCfg.level))
self.nextLv:setText(_format('%s级',self.nextLvCfg.level))

self.levelPanel:setActive(true)
if self.bdData.flag==buildingStateType.eUpgrading then
self.upgradePanel:setActive(true)
self.costPanel:setActive(false)
self:refreshUpgradePanel()
self:refreshSpeedPanel(speedUpType.eUpgradeBuilding)
else
self.upgradePanel:setActive(false)
self.costPanel:setActive(true)
self:refreshCostPanel()
end
else
self.levelPanel:setActive(false)
self.maxLvPanel:setActive(true)
if self.config.infooffset and self.config.infomodel then
self.maxIcon:setChildUIModelShowTarget(self.config.infomodel[self.curLvCfg.level],self.config.infooffset[1],nil,eAnimationID.stand)
self.maxIcon:setChildUIModelShowTargetOffset(self.config.infooffset[2],self.config.infooffset[3])
else
self.maxIcon:setChildUIModelShowTarget(self.config.model[self.curLvCfg.level],scale,nil,eAnimationID.stand)
end

self.maxLv:setText(_format('%s级',self.curLvCfg.level))
end
end


function UIBuildingInfoWin:refreshRightPanel()
local count=zongmenModel:getBuildLimitMaxLv(self.bdData.build_id)
self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),count>5)
self.scrollView:setChildScrollViewCreateGrids(count,1)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.allLvCfg[i]
local is_select=data.level<=self.curLvCfg.level
item:SetChildActive(_item_cmp_index.img_select,is_select)
item:SetChildActive(_item_cmp_index.img_unlock,is_select)
item:SetChildActive(_item_cmp_index.img_lock,not is_select)
item:SetChildText(_item_cmp_index.txt_name,_format('<color=#217e00>%s级</color>',data.level))
local desc=data.build_info
item:SetChildText(_item_cmp_index.txt_tips,desc)
end

local isComplete=buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)
local imgName=isComplete and'button_tyanniu_3'or'button_tyanniu_1'
self.btnFinishUpgrade:setSprite(globalABLookup.global,imgName)

if count>5 then
local jumpIdx=Mathf.Max(1,self.bdData.level-3)
local posy=(jumpIdx-1)*73+(jumpIdx-1)*3
self.content:setChildAnchoredPos(15,posy)
end
end

function UIBuildingInfoWin:getLevelUpCND(cfgs)
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

function UIBuildingInfoWin:refreshConditionPanel(config)
local datas=self:getLevelUpCND(config.uplevel_condition)
local count=0
for i=1,3 do
local condition=self.conditions[i]
local widget=condition:getChildWidgetBase()
local data=datas[i]
if data then

if data.cfg.type==1 then
local str
if not data.pass then
str=_format('需要宗门达到%d级',data.cfg.param)
else
str=_format('需要宗门达到%d级（<color=green>已达成</color>）',data.cfg.param)
end
widget:SetChildText(0,str)
widget:SetChildActive(1,true)
if not data.pass then
widget:SetChildButtonClick(1,function()
self:onGoToButton(data.cfg.type)
end)
end
elseif data.cfg.type==2 then
local str
if not data.pass then
str=_format('需要完成任务:%s',data.cfg.param)
else
str=_format('需要完成任务:%s（<color=green>已达成</color>）',data.cfg.param)
end
widget:SetChildText(0,str)
widget:SetChildActive(1,false)
elseif data.cfg.type==3 then
local str
if not data.pass then
str=_format('<color=red>%s/%s</color>',data.count,data.need)
else
str='<color=green>已达成</color>'
end
local c=cfgHelper.get1(cfg_monijybuildconfig_get,data.cfg.param[1])
widget:SetChildText(0,_format('拥有%s个%s级%s(%s)',data.cfg.param[2],data.cfg.param[3],c.name,str))


if not data.pass then
widget:SetChildButtonClick(1,function()
self:onGoToButton(data.cfg.type,data.data,c)
end)
end



elseif data.cfg.type==4 then
local str
local param=data.cfg.param
local bookStr=mathHelper.numberToChinese(param[1])
local desc=FMT.fmt('完成谪仙令第{0}卷',bookStr)
if param[2]then
desc=FMT.fmt('{0}第{1}章',desc,param[2])
end
if not data.pass then
str=desc
widget:SetChildActive(1,true)
widget:SetChildButtonClick(1,function()
self:onGoToButton(data.cfg.type)
end)
else
str=FMT.fmt('{0}{1}',desc,'<color=green>已达成</color>')
widget:SetChildActive(1,false)
end
widget:SetChildText(0,str)
elseif data.cfg.type==5 then
local str
local desc=FMT.fmt('完成锁妖塔第{0}层',data.cfg.param)
if not data.pass then
str=desc
widget:SetChildActive(1,true)
widget:SetChildButtonClick(1,function()
self:onGoToButton(data.cfg.type)
end)
else
str=FMT.fmt('{0}{1}',desc,'<color=green>已达成</color>')
widget:SetChildActive(1,false)
end
widget:SetChildText(0,str)
end
widget:SetChildActive(1,not data.pass)
widget:SetChildActive(2,not data.pass)
widget:SetChildActive(3,not data.pass)
widget:SetChildActive(4,data.pass)
if data.pass then
count=count+1
end
end
condition:setActive(data~=nil)
end
self.cant_upgrade=count<#datas
self.desText:setText(self.cant_upgrade and'升级条件：'or'升级消耗：')
self.conditionPanel:setActive(self.cant_upgrade)
self.costItems:setActive(not self.cant_upgrade)
end

function UIBuildingInfoWin:onGoToButton(ftype,arg1,arg2)
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

function UIBuildingInfoWin:onLevelUpBtn()
moneySystem:countAndExchange(self.nextLvCfg.uplevel_cost,eMoneyType.mtLingYu,function()
self:handleLevelUp()
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end

function UIBuildingInfoWin:handleLevelUp()




if self.cant_upgrade then
return
end
local flag,lvupData=zongmenControl:checkLevelUp(self.nextLvCfg,true,nil,true)
if not flag then
if lvupData~=nil and lvupData[1]==0 then

UIDiscipleController.doTriggerSomething(dzTriggerDoSomething.ePrivateMoney,{lvupData[2],lvupData[3]})
end
return
end
zongmenControl:reqBuildingLevelUp(self.sfId,self.bdData.un_build_id,0,{})
end

function UIBuildingInfoWin:setLevelUpCostText(index,cost)
local item=self.cost_items[index]
if cost then
item:setActive(true)
widgetHelper.setNormalRewardItem(self.winlua,item:getID(),{cost[1],cost[2],checkAmount=true})
else
item:setActive(false)
end
end

function UIBuildingInfoWin:setLevelUpDescText(index,desc)
if desc then
self.contents[index]:setActive(true)
self.contents[index+1]:setText(desc)
end
end

function UIBuildingInfoWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple then
if _this.wait_building_levelup_mgr then
_this.wait_building_levelup_mgr=nil
zongmenControl:reqBuildingLevelUp(_this.sfId,_this.bdData.un_build_id,1,{_this.bdData.dizi_id})
_this:onClickClose()
end
elseif etype==buildingEvent.speedUpComplete then
_this:refreshLevelPanel()
elseif etype==buildingEvent.levelUpStart or etype==buildingEvent.levelUpComplete then
if etype==buildingEvent.levelUpStart then
local bdData=zongmenModel:getBuildingData(bdId)
if bdData and bdData.build_id==SLG_SYSTEM_TYPE.eDuoRen then
local needLookMaking=cfgHelper.get3(cfg_monijyhomelvexlconfig_get,SLG_SYSTEM_TYPE.eDuoRen,bdData.level,'needLookMaking')
if needLookMaking then
local sfId=mapIdType.zhufeng
local targetPos_x=bdData.x
local targetPos_y=bdData.y
local sfCallBack=function(flag_)
if flag_ then

local temppos=_MapManager.ToVector3Int(targetPos_x,targetPos_y,0)
local mapId=zongmenModel:getMountainId()
local pos=_MapManager.GetCellCenterWorld(mapId,temppos,mapLayer.Data)
isometricMapSystem:moveCameraToPosition(pos,true,nil)
end
end
_this:onClickClose()
UIFullDuoRenControl:closeUI()
cameraMoveController:Begin({eSceneType.eZongmen,sfId},nil,sfCallBack)
return
end
end
end
_this:refreshLevelPanel()
_this:refreshRightPanel()
if etype==buildingEvent.levelUpComplete and not _this:isCanLevelUp()then
_this:onClickClose()
end
end
end

function UIBuildingInfoWin.on_ad_refresh()
_this:refreshLevelPanel()
end


function UIBuildingInfoWin:OnEnable()

end


function UIBuildingInfoWin:OnDisable()

end



function UIBuildingInfoWin:isCanLevelUp()
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

function UIBuildingInfoWin:onClickClose()
self:closeSelf()
end

function UIBuildingInfoWin:refreshUpgradePanel()
local beginTime=self.bdData.begintime
if beginTime>0 then


local cdd=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),cdd.dtime,cdd.ntime,false)

local isComplete=buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)

if self.bdData.feishengtai and not isComplete then
self:stopLevelUpTimer()
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),cdd.dtime+1,cdd.ntime)
self.lastTime=cdd.cd
self.txtUpgradeBar:setText(timeHelper.format_time_stamp4(cdd.cd))
self:startLevelUpTimer()

self.feishengtaiPanel:setActive(true)
self.speedupPanel:setActive(true)
self.btnFinishUpgrade:setActive(false)
elseif not isComplete then
self:stopLevelUpTimer()

self.txtUpgradeBar:setText(timeHelper.format_time_stamp4(cdd.cd))
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),cdd.dtime+1,cdd.ntime)

self.lastTime=cdd.cd
self:startLevelUpTimer()
self.speedupPanel:setActive(true)
self.btnFinishUpgrade:setActive(false)
self.feishengtaiPanel:setActive(false)
else
self:stopLevelUpTimer()
self.txtUpgradeBar:setText('升级完成')
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),1,1,false)
self.btnFinishUpgrade:setActive(true)
self.speedupPanel:setActive(false)
self.feishengtaiPanel:setActive(false)
self.btnFinishUpgrade:setSprite(globalABLookup.global,'button_tyanniu_3')
end
end
end

function UIBuildingInfoWin:refreshCostPanel()
if self.nextLvCfg.uplevel_times>0 then
self.levelUpTime:setText(FMT.fmt('耗时：<color={0}>{1}</color>','#171311',timeHelper.format_time_stamp4(self.nextLvCfg.uplevel_times)))
else
self.levelUpTime:setText('立即完成')
end

for i=1,3 do
self:setLevelUpCostText(i,self.nextLvCfg.uplevel_cost[i])
end

self:refreshConditionPanel(self.nextLvCfg)
self.conditionPanel:setActive(self.cant_upgrade or false)
self.levelUpPanel:setActive(not self.cant_upgrade)

local upLevelBtnTxtStr="升级"









self.levelUpBtnTxt:setText(upLevelBtnTxtStr)
end

function UIBuildingInfoWin:startLevelUpTimer()
local tick=function()
local cdd=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)
local dtime=cdd.cd
self.lastTime=dtime
if dtime>0 then
self.txtUpgradeBar:setText(timeHelper.format_time_stamp4(dtime))
self.winlua:SetChildUIProgressbar(self.sliderUpgrade:getID(),cdd.dtime+1,cdd.ntime)

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
self:refreshUpgradePanel()
end
end
self:addCDUpdateFunc('UPCD',tick)
end

function UIBuildingInfoWin:stopLevelUpTimer()
self:removeCDUpdateFunc('UPCD')
end

function UIBuildingInfoWin:stopAdsTimer()
if self.adsTimer then
self:stopTimerByID(self.adsTimer)
self.adsTimer=nil
end
end

function UIBuildingInfoWin:onBtnFinishUpgrade()
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
end

function UIBuildingInfoWin:countSpeedUpNeed(needData)
local dtime=buildingCDControl:getCD(buildingCDType.build,self.bdData.un_build_id)
local count=math.ceil(dtime/needData[3])
local need=count*needData[2]
return need,count
end

function UIBuildingInfoWin:setSPNeedText(need,mtype)
local needText
local have=moneyModel.getMoney(mtype)
if have<need then
needText=FMT.fmt('<color=red>{0}</color>',need)
else
needText=need
end
self.costValue:setText(needText)
end

function UIBuildingInfoWin:updateSPNeedText()
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

function UIBuildingInfoWin:refreshSpeedPanel(typo)
self.speedup_type=typo

local mspData=self.mspData

self.iconAds:setActive(false)
self.payAds:setActive(false)

if mspData[4]and self.lastTime and self.lastTime<=self.feedTime then
self.speedUpMode=0
self.speedUpBtnText:setText('免费加速')
self.suCost:setActive(false)
weakGuideController:beginGuide(1182)
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

local level=zongmenModel:getLevel()
if level<=10 and have>100 then
weakGuideController:beginGuide(1182)
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





function UIBuildingInfoWin:getSortSpeedupItemList()
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

function UIBuildingInfoWin:startAdTimer()
local btime=adControl:getBeginCDTime()
if not btime then
return
end
local rtime=adControl:getRefreshTime()
local stime=gameUtilityModel.getServerShortTime()
local count=rtime-stime
if count>0 then
self:clearAdTimer()
self.speedUpBtnText:setText(FMT.fmt('等待{0}',timeHelper.format_time_stamp11(count,true)))
self.adtimer=self:setTimer(1,count+3,function()
stime=gameUtilityModel.getServerShortTime()
if stime>=rtime then
self:clearAdTimer()
return
end
self.speedUpBtnText:setText(FMT.fmt('等待{0}',timeHelper.format_time_stamp11(rtime-stime,true)))
end)
end
end

function UIBuildingInfoWin:clearAdTimer()
if self.adtimer then
self:stopTimerByID(self.adtimer)
self.adtimer=nil
end
end


function UIBuildingInfoWin:setSpeedupItemExpireTimer(expireTime)
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


function UIBuildingInfoWin:clearSpeedupItemExpireTimer()
if self.speedupItemExpireTimer then
self:stopTimerByID(self.speedupItemExpireTimer)
self.speedupItemExpireTimer=nil
end
end

function UIBuildingInfoWin:onBtnAdsSpeedup()
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

function UIBuildingInfoWin:moneySpeedUp()
local data=self.baseCfg[1]
local need,count=self:countSpeedUpNeed(data)
local moneyId=data[1]
local have=moneyModel.getMoney(moneyId)
if have>=need then
zongmenControl:reqSpeedup(speedUpMode.eMoney,count,moneyId,self.speedup_type,self.sfId,self.bdData.un_build_id)
end
end

function UIBuildingInfoWin:onAdItemClick()
if self.speedup_item_id then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=self.speedup_item_id})
end
end

function UIBuildingInfoWin:showDialog()
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

function UIBuildingInfoWin:onFeishengtaiSpeedup()
UIManager:showWindow("UIFlyupward_speed",{bdData=self.bdData,flag=2})
end
