







def_class("UIShouLanSelectWin",UIWindowBase)









function UIShouLanSelectWin:bindComponents()

self.infoPanel=UIObject.get(self,0)
self.lockPanel=UIObject.get(self,1)
self.buildScrollview=UIObject.get(self,2)
self.leftPanel=UIObject.get(self,3)
self.rightPanel=UIObject.get(self,4)
self.need1=UIObject.get(self,5)
self.need2=UIObject.get(self,6)
self.applyBtn=UIButton.get(self,7)
self.buildModel=UIObject.get(self,8)
self.name=UIText.get(self,9)
self.emScrollView=UIObject.get(self,10)
self.costIcon=UIObject.get(self,11)
self.costValue=UIText.get(self,12)
self.addExp=UIText.get(self,13)
self.rwScrollView=UIObject.get(self,14)
self.unlockBtn=UIButton.get(self,15)
self.closeBtn=UIButton.get(self,16)
self.costPanel=UIObject.get(self,17)
self.costGroup=UIObject.get(self,18)
self.emText=UIText.get(self,19)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.unlockBtn:setButtonClick(function()self:onUnlockBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIShouLanSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.buildScrollview);self.buildScrollview=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.need1);self.need1=nil;
_UIObject_release(self.need2);self.need2=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.buildModel);self.buildModel=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.emScrollView);self.emScrollView=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.addExp);self.addExp=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.unlockBtn);self.unlockBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costGroup);self.costGroup=nil;
_UIObject_release(self.emText);self.emText=nil;
end
















local _itemIndex={
name=0,
icon=1,
need=2,
tips=3,
lock=4,
effect=5,
select=6,
root=7,
}

local _this




function UIShouLanSelectWin:onLoaded(...)
self:bindComponents()

_this=self

self.buildScrollview:setChildScrollViewInit(1,true,self.on_item_click,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.emScrollView:setChildScrollViewInit(0,true,self.on_element_click,nil)

self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end

function UIShouLanSelectWin.on_element_click(num,index)
local data=_this.elementData[index+1]
local widget=_this.emScrollView:getChildScrollViewItemWidget(index)
local pos=widget:GetChildUIScreenPos(0)
UIShouLanControl:showElementInfoWin(pos,{0,-35},data[2],data[1]==1)
end

function UIShouLanSelectWin.on_item_click(clicknum,index)
_this:OnSelectItem(index)
end

function UIShouLanSelectWin:OnSelectItem(index,refresh)
if _this.currSelect==index and not refresh then
return
end
if self.currSelect then
local item=self.buildScrollview:getChildScrollViewItemWidget(self.currSelect)

item:SetChildActive(_itemIndex.select,false)
end
self.currSelect=index
local item=self.buildScrollview:getChildScrollViewItemWidget(self.currSelect)

item:SetChildActive(_itemIndex.select,true)

local cfg=self.cfgs[index+1]
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,cfg.id)
local isUnlock=UIShouLanModel:isShouLanUnlock(cfg.id)
if isUnlock then
self.infoPanel:setActive(true)
self.lockPanel:setActive(false)

local panel=self.rightPanel:getChildWidgetBase()
self:setInfo(panel,cfg)

local costs=slcfg.translate_cost or{}
self:SetCostText(self.need1:getID(),self.winlua,costs[1])
self:SetCostText(self.need2:getID(),self.winlua,costs[2])
local hasCost=next(costs)~=nil
self.costPanel:setActive(hasCost)
else
self.infoPanel:setActive(false)
self.lockPanel:setActive(true)

self.name:setText(cfg.name)




local modelID=self:getBuildModelId(cfg.id)
local scale=isometricMapSystem:getModelScale(modelID,true)
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.buildModel:getID(),true,true,true)
end

local buildType=cfg.build_type
if buildType==SLG_SYSTEM_TYPE.eShouLan1 then

scale=slcfg.uiModelScale and slcfg.uiModelScale*0.875 or scale*0.7
else

scale=slcfg.uiModelScale and slcfg.uiModelScale*0.6875 or scale*0.55
end

local offset=slcfg.uiModelOffset or{0,0}
self.buildModel:setChildUIModelShowTarget(modelID,scale,nil,eAnimationID.stand)
self.buildModel:setChildUIModelShowTargetOffset(offset[1],offset[2])

local costList=slcfg.keep_cost


local costCount=#costList
self.costGroup:setChildLayoutGroupCreateItems(costCount,function(index)
local widget=self.costGroup:getChildLayoutGroupGridItem(index-1)
local cost=costList[index]
if cost then
widget:SetChildActive(-1,true)
widget:SetChildIcon(0,iconHelper.getIconName(cost[1]),false)
widget:SetChildText(1,FMT.fmt('{0}/年',cost[2]))
end
end)

self.addExp:setText(FMT.fmt('{0}点境界修为/年',slcfg.add_xiuwei))

self.elementData=feedingSystem:getElementDataSL(cfg.id,2)
feedingSystem:setElementList(self.winlua,self.emScrollView:getID(),self.elementData)
local isShowNotEMTip=#self.elementData<=0
self.emText:setActive(isShowNotEMTip)

local costs=slcfg.unlock_cost
self.rwScrollView:setChildScrollViewCreateGrids(#costs,0)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local itemWidget=grids[i]
local data=costs[i+1]
local itemId=data[1]
local needCount=data[2]
local hasCount=itemsModel.getCount(itemId)
local countStr
if hasCount<needCount then

countStr=FMT.fmt("<color=#c82c2c>{0}</color>",mathHelper.formatNumber(needCount))
else

countStr=mathHelper.formatNumber(needCount)
end

local showCountBG=true
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
return self:onClickRewardItem(...)
end)
end
end
end

function UIShouLanSelectWin.on_item_list_changed(args)
if _this==nil then return end
for i,v in ipairs(args)do
local itemid=v[3]
if _this.costItemLookup[itemid]then
return _this:OnSelectItem(_this.currSelect,true)
end
end
end

function UIShouLanSelectWin.on_money_changed(moneyType,oldVal,newVal)
if _this==nil then return end
if _this.costItemLookup[moneyType]then
return _this:OnSelectItem(_this.currSelect,true)
end
end


function UIShouLanSelectWin:__delete()
self:unbindComponents()
_this=nil
self:closeWindow('UITopMoneyWin2')
end




function UIShouLanSelectWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
self:InitBuildingList()
self:initCostItemList()

self:showWindow("UITopMoneyWin2",{moneys=self.costItemList,offsetX=0,offsetY=-25})

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
local panel=self.leftPanel:getChildWidgetBase()
self:setInfo(panel,cfg)

self:OnSelectItem(0)
end


function UIShouLanSelectWin:onHide()
self:closeWindow('UITopMoneyWin2')
end

function UIShouLanSelectWin:setInfo(panel,cfg)
panel:SetChildIcon(0,cfg.icon,true)
panel:SetChildText(1,cfg.name)
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,cfg.id)
panel:SetChildText(2,FMT.fmt('{0}点境界修为/年',slcfg.add_xiuwei))
panel:SetChildScrollViewInit(3,0,true,nil,nil)
local attrData=feedingSystem:getElementDataSL(cfg.id,2)
feedingSystem:setElementList(panel,3,attrData)

local isShowNotEMTip=#attrData<=0
panel:SetChildActive(4,isShowNotEMTip)

local costList=slcfg.keep_cost


local costCount=#costList
panel:SetChildLayoutGroupCreateItems(5,costCount,function(index)
local widget=panel:GetChildLayoutGroupGridItem(5,index-1)
local cost=costList[index]
if cost then
widget:SetChildActive(-1,true)
widget:SetChildIcon(0,iconHelper.getIconName(cost[1]),false)
widget:SetChildText(1,FMT.fmt('{0}/年',cost[2]))
end
end)

end

function UIShouLanSelectWin:GetBuildingConfigs()
local scfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
local cfgs=cfg_monijybuildconfig()
local level=zongmenModel:getLevel()
local stype=self.bdData.build_id
local list={}
for k,v in pairs(cfgs)do
if level>=v.show_level and v.win_type==8 then
if scfg.build_type==v.build_type then
table.insert(list,v)
end
end
end
for i,v in ipairs(list)do
if v.id==stype then
table.remove(list,i)
break
end
end
table.sort(list,function(a,b)
return a.id<b.id
end)
return list
end


function UIShouLanSelectWin:InitBuildingList()
self.cfgs=self:GetBuildingConfigs()
local len=#self.cfgs
self.buildScrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.buildScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
if i<len then
local cfg=self.cfgs[i+1]
local item=grids[i]
self:setItem(i,item,cfg)
end
end
end

function UIShouLanSelectWin:initCostItemList()
local costList={}
local costList_lookup={}
if self.cfgs and next(self.cfgs)~=nil then
for _,cfg in ipairs(self.cfgs)do
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,cfg.id)
local unlockCost=slcfg.unlock_cost
if unlockCost then
for i,v in ipairs(unlockCost)do
local itemId=v[1]
if not costList_lookup[itemId]then
costList_lookup[itemId]=true
table.insert(costList,{itemId})
end
end
end

local translateCost=slcfg.translate_cost
if translateCost then
for i,v in ipairs(translateCost)do
local itemId=v[1]
if not costList_lookup[itemId]then
costList_lookup[itemId]=true
table.insert(costList,{itemId})
end
end
end
end
end

self.costItemList=costList
self.costItemLookup=costList_lookup
end

function UIShouLanSelectWin:GetCondition(data,ctype)
for i,v in ipairs(data)do
if v.type==ctype then
return v.param
end
end
end

function UIShouLanSelectWin:setItem(index,item,cfg)

local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,1)
item:SetChildText(_itemIndex.name,cfg.name)
item:SetChildIcon(_itemIndex.icon,cfg.icon,true)
item:SetChildActive(_itemIndex.need,false)
item:SetChildActive(_itemIndex.select,self.currSelect and index==self.currSelect or false)

local isUnlock=UIShouLanModel:isShouLanUnlock(cfg.id)
item:SetChildActive(_itemIndex.lock,not isUnlock)
local cnd=lcfg.uplevel_condition[1]
local cndLv=self:GetCondition(lcfg.uplevel_condition,1)
if cndLv and cndLv>zongmenModel:getLevel()then

item:SetChildText(_itemIndex.tips,string.format('<color=#db3f3f>需要宗门达到%s级</color>',cndLv))
else
cnd=self:GetCondition(lcfg.uplevel_condition,3)
local sfId=zongmenModel:getMountainId()
local check,ncount=zongmenModel:checkBuildingWithCondition(sfId,cnd)
if cnd and not check then

local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,cnd[1])
item:SetChildText(5,string.format('%s级%s<color=#db3f3f>%s/%s</color>座',cnd[3],bdcfg.name,ncount,cnd[2]))
else



item:SetChildText(_itemIndex.tips,'')
end
end

end

function UIShouLanSelectWin:SetCostText(index,item,cost)
if not cost then
item:SetChildActive(index,false)
return
end
item:SetChildActive(index,true)
local node=item:GetChildWidgetBase(index)
local mtype=cost[1]
local need=cost[2]
local have=moneyModel.getMoney(mtype)
local enough=have>=need
if enough then
node:SetChildText(0,string.format('消耗:%s',mathHelper.formatNumber(need)))
else
node:SetChildText(0,string.format('消耗:<color=red>%s</color>',mathHelper.formatNumber(need)))
end
node:SetChildIcon(1,iconHelper.getIconName(mtype),false)
end

function UIShouLanSelectWin:unlockShouLan(slId)
local index
local cfg
for i,v in ipairs(self.cfgs)do
if v.id==slId then
index=i-1
cfg=v
end
end

if not index then
return
end

local item=self.buildScrollview:getChildScrollViewItemWidget(index)
self:setItem(index,item,cfg)


self:OnSelectItem(self.currSelect,true)
end

function UIShouLanSelectWin:getBuildModelId(build_id,level)
level=level or 1
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
if bdCfg.sp_ui_model then
if bdCfg.sp_ui_model[level]then
return bdCfg.sp_ui_model[level]
else
local showLv
for lv,cfg in pairs(bdCfg.sp_ui_model)do
if level>=lv then
if not showLv or lv>showLv then
showLv=lv
end
end
end
return bdCfg.sp_ui_model[showLv]
end
end
end




function UIShouLanSelectWin:onApplyBtn()
local cfg=self.cfgs[self.currSelect+1]
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,cfg.id)
local costs=slcfg.translate_cost
if not costs or zongmenControl:checkEnough(costs,true)then
UIShouLanControl:reqChangeShouLanStyle(self.bdData.un_build_id,cfg.id)
self:onCloseClick()
end
end

function UIShouLanSelectWin:onUnlockBtn()
local cfg=self.cfgs[self.currSelect+1]
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,cfg.id)
local costs=slcfg.unlock_cost
if not costs or zongmenControl:checkEnough(costs,true)then
UIShouLanControl:reqUnloclShouLan(cfg.id)
end
end

function UIShouLanSelectWin:onCloseBtn()
return self:onCloseClick()
end

function UIShouLanSelectWin:onCloseClick()
self:closeSelf()
end

function UIShouLanSelectWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end