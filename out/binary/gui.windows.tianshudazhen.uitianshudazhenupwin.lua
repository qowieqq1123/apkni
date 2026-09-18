







def_class("UITianShuDaZhenUpWin",UIWindowBase)









function UITianShuDaZhenUpWin:bindComponents()

self.attrCreator=UIObject.get(self,0)
self.buildingName=UIText.get(self,1)
self.condition1=UIObject.get(self,2)
self.condition2=UIObject.get(self,3)
self.condition3=UIObject.get(self,4)
self.conditionPanel=UIObject.get(self,5)
self.costItem1=UIObject.get(self,6)
self.costItem2=UIObject.get(self,7)
self.costItem3=UIObject.get(self,8)
self.costItem4=UIObject.get(self,9)
self.costItems=UIObject.get(self,10)
self.costPanel=UIObject.get(self,11)
self.curLv=UIText.get(self,12)
self.desText=UIText.get(self,13)
self.levelUpBtn=UIButton.get(self,14)
self.levelUpPanel=UIObject.get(self,15)
self.levelUpTime=UIText.get(self,16)
self.maxLv=UIText.get(self,17)
self.maxLvPanel=UIObject.get(self,18)
self.maxTxt=UIText.get(self,19)
self.nextLv=UIText.get(self,20)
self.previewScrollView=UILoopListView.new(self,21)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.previewScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UITianShuDaZhenUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrCreator);self.attrCreator=nil;
_UIObject_release(self.buildingName);self.buildingName=nil;
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.condition3);self.condition3=nil;
_UIObject_release(self.conditionPanel);self.conditionPanel=nil;
_UIObject_release(self.costItem1);self.costItem1=nil;
_UIObject_release(self.costItem2);self.costItem2=nil;
_UIObject_release(self.costItem3);self.costItem3=nil;
_UIObject_release(self.costItem4);self.costItem4=nil;
_UIObject_release(self.costItems);self.costItems=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.curLv);self.curLv=nil;
_UIObject_release(self.desText);self.desText=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpPanel);self.levelUpPanel=nil;
_UIObject_release(self.levelUpTime);self.levelUpTime=nil;
_UIObject_release(self.maxLv);self.maxLv=nil;
_UIObject_release(self.maxLvPanel);self.maxLvPanel=nil;
_UIObject_release(self.maxTxt);self.maxTxt=nil;
_UIObject_release(self.nextLv);self.nextLv=nil;
self.previewScrollView:deleteSelf();self.previewScrollView=nil;
end


















function UITianShuDaZhenUpWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.building_event,function(...)
self:on_building_event(...)
end)
self.cost_items={self.costItem1,self.costItem2,self.costItem3,self.costItem4}
self.conditions={
self.condition1,
self.condition2,
self.condition3,
}
end

function UITianShuDaZhenUpWin:__delete()
self:unbindComponents()
end

function UITianShuDaZhenUpWin:onShow(argtable,afterOnloaded)
self.sfId=mapIdType.fort
self.bdData=tianshudazhenModel:getBuildData()

self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.alltsdzCfgs=cfg_tianshudazhenconfig()

self:refreshInfo()
end

function UITianShuDaZhenUpWin:onHide()

end





function UITianShuDaZhenUpWin:handleLevelUp()
if self.cant_upgrade then
return
end
local flag,lvupData=zongmenControl:checkLevelUp(self.nextLvCfg,true,nil,true)
if not flag then return end
zongmenControl:reqBuildingLevelUp(self.sfId,self.bdData.un_build_id,0,{})
end

function UITianShuDaZhenUpWin:refreshInfo()
self.curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self:refreshLevelPanel()
self:refreshAttrPanel()
self:refreshPreviewPanel()
end

function UITianShuDaZhenUpWin:refreshAttrPanel()
local hasNext=self.nextLvCfg~=nil
local level=tianshudazhenModel:getLevel()
local tsdzCfg=tianshudazhenConfig.getTianshudazhenconfig(level)
local attr=tsdzCfg.attr

local hdzValue=tsdzCfg.shield

local next_tsdz_cfg=tianshudazhenConfig.getTianshudazhenconfig(level+1)
local nextAttr=next_tsdz_cfg and next_tsdz_cfg.attr
local nexthdzValue=next_tsdz_cfg and next_tsdz_cfg.shield

local len=#attr+1
self.winlua:SetChildLayoutGroupCreateItems(self.attrCreator:getID(),len,function(subIndex)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.attrCreator:getID(),subIndex-1)
local cfg
if subIndex==1 then
widget:SetChildText(0,FMT.fmt('护盾值上限：{0}',hdzValue))
if nexthdzValue then
widget:SetChildText(1,nexthdzValue)
widget:SetChildActive(2,true)
else
widget:SetChildText(1,'')
widget:SetChildActive(2,false)
end
else
local cfg=attr[subIndex-1]
local name,valstr=equipsHelper.getAttr(cfg[1],cfg[2])
widget:SetChildText(0,FMT.fmt('{0}:{1}',name,valstr))

if nextAttr then
local cfg=nextAttr[subIndex-1]
local name,valstr=equipsHelper.getAttr(cfg[1],cfg[2])
widget:SetChildText(1,valstr)
widget:SetChildActive(2,true)
else
widget:SetChildText(1,'')
widget:SetChildActive(2,false)
end
end

end)
end

function UITianShuDaZhenUpWin:refreshPreviewPanel()
self.previewScrollView:initData("item",self.alltsdzCfgs)
end

function UITianShuDaZhenUpWin:onStartAction()

end

function UITianShuDaZhenUpWin:onFreshAction(index,widget,data)
local cfg=self.alltsdzCfgs[index]
local attr=cfg.attr
widget:SetChildText(0,FMT.fmt('{0}级',cfg.id))

widget:SetChildLayoutGroupCreateItems(1,#attr,function(subIndex)
local widget1=widget:GetChildLayoutGroupGridItem(1,subIndex-1)
local cfg=attr[subIndex]
local name,valstr=equipsHelper.getAttr(cfg[1],cfg[2])
widget1:SetChildText(0,FMT.fmt('{0}:{1}',name,valstr))
end)
end

function UITianShuDaZhenUpWin:refreshLevelPanel()

self.buildingName:setText(self.config.name)
if self.nextLvCfg then
self.maxLvPanel:setActive(false)
self.costPanel:setActive(true)

self.curLv:setText(FMT.fmt('{0}级',self.curLvCfg.level))
self.nextLv:setText(FMT.fmt('{0}级',self.nextLvCfg.level))

if self.bdData.flag==buildingStateType.eUpgrading then
self.costPanel:setActive(false)
else
self.costPanel:setActive(true)
self:refreshCostPanel()
end
else
self.costPanel:setActive(false)
self.maxLvPanel:setActive(true)
self.maxLv:setText('')
end
end

function UITianShuDaZhenUpWin:refreshCostPanel()
if self.nextLvCfg.uplevel_times>0 then
self.levelUpTime:setText(FMT.fmt('耗时：<color={0}>{1}</color>','#171311',timeHelper.format_time_stamp4(self.nextLvCfg.uplevel_times)))
else
self.levelUpTime:setText('立即完成')
end

for i=1,4 do
self:setLevelUpCostText(i,self.nextLvCfg.uplevel_cost[i])
end

self:refreshConditionPanel(self.nextLvCfg)
self.conditionPanel:setActive(self.cant_upgrade or false)
self.levelUpPanel:setActive(not self.cant_upgrade)
end

function UITianShuDaZhenUpWin:setLevelUpCostText(index,cost)
local item=self.cost_items[index]
if cost then
item:setActive(true)
widgetHelper.setNormalRewardItem(self.winlua,item:getID(),{cost[1],cost[2],checkAmount=true})
else
item:setActive(false)
end
end

function UITianShuDaZhenUpWin:refreshConditionPanel(config)
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
str=FMT.fmt('需要宗门达到{0}级',data.cfg.param)
else
str=FMT.fmt('需要宗门达到{0}级（<color=green>已达成</color>）',data.cfg.param)
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
str=FMT.fmt('需要完成任务:{0}',data.cfg.param)
else
str=FMT.fmt('需要完成任务:{0}（<color=green>已达成</color>）',data.cfg.param)
end
widget:SetChildText(0,str)
widget:SetChildActive(1,false)
elseif data.cfg.type==3 then
local str
if not data.pass then
str=FMT.fmt('<color=red>{0}/{1}</color>',data.count,data.need)
else
str='<color=green>已达成</color>'
end
local c=cfgHelper.get1(cfg_monijybuildconfig_get,data.cfg.param[1])
widget:SetChildText(0,FMT.fmt('拥有{0}个{1}级{2}({3})',data.cfg.param[2],data.cfg.param[3],c.name,str))


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
self.desText:setText(self.cant_upgrade and'升级条件：'or'升级要求：')
self.conditionPanel:setActive(self.cant_upgrade)
self.costItems:setActive(not self.cant_upgrade)
end

function UITianShuDaZhenUpWin:getLevelUpCND(cfgs)
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

function UITianShuDaZhenUpWin:on_building_event(etype,sfId,ubdId,arg1,arg2)
if ubdId~=self.bdData.un_build_id then return end

if(etype==buildingEvent.levelUpStart or etype==buildingEvent.levelUpComplete)then
self:refreshLevelPanel()
if etype==buildingEvent.levelUpStart then
self:closeSelf()
end
end
end

function UITianShuDaZhenUpWin:onLevelUpBtn()
moneySystem:countAndExchange(self.nextLvCfg.uplevel_cost,eMoneyType.mtLingYu,function()
self:handleLevelUp()
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end

function UITianShuDaZhenUpWin:onGoToButton(ftype,arg1,arg2)
if ftype==1 then
fullScreenUI.closeActiveUI()
UIManager:showWindow('UIZongmenInfoWin',{showback=true})
elseif ftype==3 then
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
