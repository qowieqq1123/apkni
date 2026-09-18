







def_class("UIBuildingSuitWin",UIWindowBase)









function UIBuildingSuitWin:bindComponents()

self.background=UIObject.get(self,0)
self.addScaleBtn=UIButton.get(self,1)
self.subScaleBtn=UIButton.get(self,2)
self.buildingModel=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.effect=UIObject.get(self,5)
self.descTx=UIText.get(self,6)
self.effectTx=UIText.get(self,7)
self.activeBtn=UIButton.get(self,8)
self.buildBtn=UIButton.get(self,9)
self.gotoBtn=UIButton.get(self,10)
self.activeRewards=UIObject.get(self,11)
self.leftList=UIObject.get(self,12)
self.scaleSlider=UISlider.get(self,13)
self.activedFlag=UIObject.get(self,14)
self.nameTx=UIText.get(self,15)
self.partList=UIObject.get(self,16)
self.modelRoot=UIObject.get(self,17)

self.addScaleBtn:setButtonClick(function()self:onAddScaleBtn()end)

self.subScaleBtn:setButtonClick(function()self:onSubScaleBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.activeBtn:setButtonClick(function()self:onActiveBtn()end)

self.buildBtn:setButtonClick(function()self:onBuildBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIBuildingSuitWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.addScaleBtn);self.addScaleBtn=nil;
_UIObject_release(self.subScaleBtn);self.subScaleBtn=nil;
_UIObject_release(self.buildingModel);self.buildingModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.effectTx);self.effectTx=nil;
_UIObject_release(self.activeBtn);self.activeBtn=nil;
_UIObject_release(self.buildBtn);self.buildBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.activeRewards);self.activeRewards=nil;
_UIObject_release(self.leftList);self.leftList=nil;
_UIObject_release(self.scaleSlider);self.scaleSlider=nil;
_UIObject_release(self.activedFlag);self.activedFlag=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.partList);self.partList=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
end
















local _this=nil
local _itemCmp={
button=0,
icon=1,
black=2,
nameTx=3,
select=4,
reddot=5,
}
local _partCmp={
button=-1,
icon=0,
name=1,
num=2,
iconBg=3,
}




function UIBuildingSuitWin:onLoaded(...)
self:bindComponents()
_this=self

self.scaleMin=50
self.scaleMax=150
self.scale=100
self.winlua:SetChildLongPress(self.subScaleBtn:getID(),self.subScaleBtn:getID(),function()
self:onSubScaleBtn()
end,nil)
self.winlua:SetChildLongPress(self.addScaleBtn:getID(),self.addScaleBtn:getID(),function()
self:onAddScaleBtn()
end,nil)
self.winlua:SetChildSlider(self.scaleSlider:getID(),self.scale,self.scaleMin,self.scaleMax,function(progress)
self:setModelScale(progress)
end)
end


function UIBuildingSuitWin:__delete()
self:unbindComponents()
_this=nil
end




function UIBuildingSuitWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self:initLeftList()
if argtable and argtable.suit then
local index=self:findDataIndex(argtable.suit)
self:onClickItem(index)
else
self:onClickItem(1)
end
else
local id=argtable and argtable.suit or nil
self:refreshLeftList(id)
end
end


function UIBuildingSuitWin:onHide()

end

function UIBuildingSuitWin:onShowArgRecv(argtable)
local id=argtable and argtable.suit or nil
self:refreshLeftList(id)
end




function UIBuildingSuitWin:onCloseBtn()
self:closeSelf()
end

function UIBuildingSuitWin:onGotoBtn()
local data=self.data[self.selectIdx]
if not data.active then
if not data.enough then
local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,data.id)
for i,v in ipairs(cfg.needbuild)do
local neednum=v[2]
local havenum=zongmenBuildingSuitModel:getPartCount(data.id,i)
if neednum>havenum then
local itemId=zongmenBuildingSuitModel:findPartItemByBuilding(v[1])
gainControl:showGainWin(itemId)
UIManager.error("仙居摆件尚未集齐")
return
end
end
if cfg.needroad then
for i,v in ipairs(cfg.needroad)do
if not zongmenModel:isActiveRoad(v)then
local roadCfg=cfgHelper.get1(cfg_roadstyleconfig_get,v)
if roadCfg.activate_cost then
gainControl:showGainWin(roadCfg.activate_cost)
UIManager.error("仙居摆件尚未集齐")
return
end
end
end
end
end
else
UIManager.error("仙居已激活")
end
end


function UIBuildingSuitWin:onActiveBtn()
local data=self.data[self.selectIdx]
if not data.active then
if data.enough then
zongmenBuildingSuitController:send_3_51(data.id)
else
UIManager.error("仙居摆件尚未集齐")
end
else
UIManager.error("仙居已激活")
end
end


function UIBuildingSuitWin:onBuildBtn()
local id=self.data[self.selectIdx].id
local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,id)
if cfg.needroad then
for i,v in pairs(cfg.needroad)do
if not zongmenModel:isActiveRoad(v)then
local roadCfg=cfgHelper.get1(cfg_roadstyleconfig_get,v)
UIManager.error(FMT.fmt("{0}未激活",roadCfg.name))
return
end
end
end

if cfg.road then
for i,v in pairs(cfg.road)do
local cnt=#v
local roadCfg=cfgHelper.get1(cfg_roadstyleconfig_get,i)
if roadCfg.cost then
for j,w in ipairs(roadCfg.cost)do
local costId=w[1]
local costNum=w[2]*cnt
local haveNum=itemsModel.getCount(costId)
if haveNum<costNum then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(costId)))
gainControl:showGainWin(costId)
return
end
end
end
end
end

local ask=false
local isBlock=false
for i,v in ipairs(cfg.needbuild)do
local neednum=v[2]
local havenum,itemnum,storgenum,buildnum,buildNumList=zongmenBuildingSuitModel:getPartCount(id,i)
if neednum>havenum then
UIManager.error("仙居摆件尚未集齐")
return
elseif neednum>(itemnum+storgenum)then
local sfId=zongmenModel:getMountainId()
local sfBuildNum=buildNumList[sfId]or 0
if itemnum+storgenum+sfBuildNum<neednum then

isBlock=true
end
ask=true
end
end
if isBlock then
local str="部分摆件不在当前山峰，无法建造"
UIManager.error(str)
elseif ask then
local show_data={
type='UIDialouge',
title='提示',
content="有部分摆件已经进行摆放，是否要进行收回再进行仙居建造？",
oktext='确定',
canceltext='取消',
okcallback=function()
self:doBuild(id)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self:doBuild(id)
end
end

function UIBuildingSuitWin:doBuild(id)
local bdId=zongmenBuildingSuitModel:findSuitBuildingById(id)
UIManager:invokeUIMethod("UILayoutWin","handleFastBuildEx",bdId)
self:onCloseBtn()
end

function UIBuildingSuitWin:updateData()
if not self.data then
local cfg=cfg_buildsuitconfig()
local datas={}
for i,v in pairs(cfg)do
local active=zongmenBuildingSuitModel:getActive(i)
local show=zongmenBuildingSuitModel:checkShow(i)
if active or show then
local active=zongmenBuildingSuitModel:getActive(i)
local enough=zongmenBuildingSuitModel:checkEnough(i)
local reward=zongmenBuildingSuitModel:getReward(i)
local reddot=not reward
if not active then
reddot=enough
end
local data={
id=i,
active=active,
enough=enough,
reward=reward,
reddot=reddot,
}
table.insert(datas,data)
end
end
self.data=datas
end
table.sort(self.data,self.sortList)
end

function UIBuildingSuitWin.sortList(a,b)
if a.reddot~=b.reddot then
return a.reddot
elseif a.active~=b.active then
return a.active
else
return a.id<b.id
end
end

function UIBuildingSuitWin:initLeftList()
self:updateData()
self.leftList:setChildLayoutGroupCreateItems(#self.data,function(index)
self:initListItem(index)
end)
end

function UIBuildingSuitWin:findDataIndex(id)
for i,v in ipairs(self.data)do
if v.id==id then
return i
end
end
end

function UIBuildingSuitWin:refreshLeftList(id)
id=id and self.data[self.selectIdx].id
self.data=nil
self:updateData()
self.selectIdx=self:findDataIndex(id)
for i=1,#self.data do
self:initListItem(i)
end
local data=self.data[self.selectIdx]

self.activeBtn:setActive(not data.active and data.enough)
self.buildBtn:setActive(data.active)
self.gotoBtn:setActive(not data.active and not data.enough)

local items=self.partList:getChildLayoutGroupGridList()
local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,data.id)
for i=1,items.Count do
local item=items[i-1]
local partData=cfg.needbuild[i]
if partData then
local needNum=partData[2]
local haveNum=zongmenBuildingSuitModel:getPartCount(id,i)
item:SetChildText(_partCmp.num,FMT.fmt("{0}/{1}",haveNum,needNum))

item:SetChildGraphicGray(_partCmp.iconBg,haveNum<needNum,true,true)
else
local road=cfg.needroad[i-#cfg.needbuild]
local active=zongmenModel:isActiveRoad(road)
item:SetChildText(_partCmp.num,FMT.fmt("{0}/{1}",active and 1 or 0,1))
item:SetChildGraphicGray(_partCmp.iconBg,not active,true,true)
end
end
end

function UIBuildingSuitWin:initListItem(index)
local item=self.leftList:getChildLayoutGroupGridItem(index-1)
local id=self.data[index].id
local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,id)
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,cfg.map)
item:SetChildIcon(_itemCmp.icon,bdCfg.icon,false)
item:SetChildText(_itemCmp.nameTx,bdCfg.name)
item:SetChildButtonClick(_itemCmp.button,function()
self:onClickItem(index)
end)
self:refreshListItem(item,index)
end


function UIBuildingSuitWin:refreshListItem(item,index)
local data=self.data[index]
item:SetChildActive(_itemCmp.select,self.selectIdx==index)
item:SetChildImageExGray(_itemCmp.icon,not data.active)
item:SetChildActive(_itemCmp.reddot,data.reddot)
end

function UIBuildingSuitWin:refreshSelect(index)
local item=self.leftList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_itemCmp.select,self.selectIdx==index)
end

function UIBuildingSuitWin:onClickItem(index)
if index~=self.selectIdx then
local old=self.selectIdx
self.selectIdx=index
if old then
self:refreshSelect(old)
end
self:refreshSelect(self.selectIdx)

self:refreshSelected()
end
end

function UIBuildingSuitWin:refreshSelected()
local data=self.data[self.selectIdx]
local id=data.id
local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,id)
local bdId=zongmenBuildingSuitModel:findSuitBuildingById(id)
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
local scale=isometricMapSystem:getModelScale(bdCfg.model[1])
local active=data.active
local effectStr=homeBuffModel:getBuffDescByStateId(cfg.guild_buffs[1])
if active then
effectStr=FMT.cfmt(FONT_COLOR.eGreenColor,effectStr)
end

self.modelRoot:setChildAnchoredPos(0,0)

self.buildingModel:setChildAnchoredPosition(cfg.model_pos and Vector2.New(cfg.model_pos[1]or 0,cfg.model_pos[2]or 0)or Vector2.zero)

if api_Available_SetChildUIModelUpdateRendererSize()then
self.buildingModel:setChildUIModelShowTarget(bdCfg.model[1],scale,{},0,true,false,0,nil)
self.winlua:SetChildUIModelUpdateRendererSize(self.buildingModel:getID(),true)
else
local func=function()
self:delayDo(0.2,function()
local rt=self.buildingModel:getCommonComponent('RectTransform')
local r=rt:GetChild(0):GetChild(0):GetChild(0)
for i=1,r.childCount do
local child=r:GetChild(i-1):GetComponent("RectTransform")
child.sizeDelta=Vector2.one*1000
end
end)
end
self.buildingModel:setChildUIModelShowTarget(bdCfg.model[1],scale,{},0,true,false,0,func)
end

self.nameTx:setText(bdCfg.name)

self.descTx:setText(bdCfg.desc)
self.effectTx:setText(effectStr)
self.activeBtn:setActive(not active and data.enough)
self.gotoBtn:setActive(not data.active and not data.enough)

self.activeRewards:setChildLayoutGroupCreateItems(#cfg.rewards,function(index)
local item=self.activeRewards:getChildLayoutGroupGridItem(index-1)
local info=cfg.rewards[index]
local conf={itemid=info[1],itemcount=info[2],showCountBG=true,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)


item:SetChildActive(1,not active)
item:SetChildActive(2,active)
item:SetChildButtonClick(-1,function()
self:onClickReward(index)
end)
end)
self.activeRewards:setActive(not data.reward)
self.winlua:SetChildSliderRefresh(self.scaleSlider:getID(),math.floor((cfg.view_scale or 1)*100))

self.buildBtn:setActive(active)
local needBdCnt=#cfg.needbuild
local needRdCnt=cfg.needroad and#cfg.needroad or 0
self.partList:setChildLayoutGroupCreateItems(needBdCnt+needRdCnt,function(index)
local item=self.partList:getChildLayoutGroupGridItem(index-1)
if index<=needBdCnt then
local partData=cfg.needbuild[index]
local partBd=partData[1]
local partCfg=cfgHelper.get1(cfg_monijybuildconfig_get,partBd)
local needNum=partData[2]
local haveNum=zongmenBuildingSuitModel:getPartCount(id,index)
item:SetChildButtonClick(_partCmp.button,function()
self:onClickPart(id,index,partBd,true)
end)
item:SetChildIcon(_partCmp.icon,partCfg.icon,true)
item:SetChildText(_partCmp.name,partCfg.name)
item:SetChildText(_partCmp.num,FMT.fmt("{0}/{1}",haveNum,needNum))
item:SetChildGraphicGray(_partCmp.iconBg,haveNum<needNum,true,true)

else
local roadId=cfg.needroad[index-needBdCnt]
local roadCfg=cfgHelper.get1(cfg_roadstyleconfig_get,roadId)
local active=true
item:SetChildButtonClick(_partCmp.button,function()
self:onClickPart(id,index,roadId,false)
end)
item:SetChildIcon(_partCmp.icon,roadCfg.icon,true)
item:SetChildText(_partCmp.name,roadCfg.name)
local active=zongmenModel:isActiveRoad(roadId)
item:SetChildText(_partCmp.num,FMT.fmt("{0}/{1}",active and 1 or 0,1))
item:SetChildGraphicGray(_partCmp.iconBg,not active,true,true)
end
end)
end

function UIBuildingSuitWin:onClickPart(id,index,bdId,isBd)
if isBd then
local data=self.data[self.selectIdx]
local id=data.id
local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,id)
local partData=cfg.needbuild[index]
local needNum=partData[2]
local haveNum=zongmenBuildingSuitModel:getPartCount(id,index)
if haveNum<needNum then
local itemId=zongmenBuildingSuitModel:findPartItemByBuilding(bdId)
tipsManager.showTips({itemid=itemId,formType=TIPS_FORM_TYPE.eBuildSuit})
end
else
if not zongmenModel:isActiveRoad(bdId)then
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,bdId)
local itemId=cfg.activate_cost
tipsManager.showTips({itemid=itemId,formType=TIPS_FORM_TYPE.eBuildSuit})
end
end
end

function UIBuildingSuitWin:afterActive(suit)
local data=self.data[self.selectIdx]
if suit==data.id then
data.active=true
data.enough=true
data.reddot=not data.reward
end









table.sort(self.data,self.sortList)
for i,v in ipairs(self.data)do
if v.id==suit then
self.selectIdx=i
end
end

for i=1,#self.data do
self:initListItem(i)
end

local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,suit)
local data=self.data[self.selectIdx]

self.activeBtn:setActive(not data.active and data.enough)
self.gotoBtn:setActive(not data.active and not data.enough)

local arItems=self.activeRewards:getChildLayoutGroupGridList()
for i=1,arItems.Count do
local item=arItems[i-1]
item:SetChildActive(1,not data.active)
item:SetChildActive(2,data.active)
end

self.buildBtn:setActive(data.active)
self.effect:setChildShowEffect(10060,true)
local effectStr=homeBuffModel:getBuffDescByStateId(cfg.guild_buffs[1])
effectStr=FMT.cfmt(FONT_COLOR.eGreenColor,effectStr)
self.effectTx:setText(effectStr)

local items=self.partList:getChildLayoutGroupGridList()

for i=1,items.Count do
local item=items[i-1]
local partData=cfg.needbuild[i]
if partData then
local needNum=partData[2]
local haveNum=zongmenBuildingSuitModel:getPartCount(suit,i)
item:SetChildText(_partCmp.num,FMT.fmt("{0}/{1}",haveNum,needNum))
item:SetChildGraphicGray(_partCmp.iconBg,haveNum<needNum,true,true)
else
local road=cfg.needroad[i-#cfg.needbuild]
local active=zongmenModel:isActiveRoad(road)
item:SetChildText(_partCmp.num,FMT.fmt("{0}/{1}",active and 1 or 0,1))
item:SetChildGraphicGray(_partCmp.iconBg,not active,true,true)
end
end
end

function UIBuildingSuitWin:onSubScaleBtn()
if self.scale>self.scaleMin then
self:setModelScale(self.scale-1)
end
end

function UIBuildingSuitWin:onAddScaleBtn()
if self.scale<self.scaleMax then
self:setModelScale(self.scale+1)
end
end

function UIBuildingSuitWin:setModelScale(progress)
self.scale=progress
self.modelRoot:setScale(Vector3.one*self.scale/100)
end

function UIBuildingSuitWin:onClickReward(index)
local data=self.data[self.selectIdx]
if data.active and not data.reward then
zongmenBuildingSuitController:send_3_54(data.id)
elseif not data.active then
UIManager.error("仙居摆件尚未集齐")
else
local data=self.data[self.selectIdx]
local id=data.id
local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,id)
local info=cfg.rewards[index]
itemsComponentHelper.onItemClick(info[1])
end
end

function UIBuildingSuitWin:afterReward(suit)
local data=self.data[self.selectIdx]
if suit==data.id then
data.reward=true
data.reddot=false
self.activeRewards:setActive(false)
end

table.sort(self.data,self.sortList)
for i,v in ipairs(self.data)do
if v.id==suit then
self.selectIdx=i
end
end

for i=1,#self.data do
self:initListItem(i)
end
end