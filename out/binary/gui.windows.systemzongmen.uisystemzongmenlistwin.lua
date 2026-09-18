







def_class("UISystemZongMenListWin",UIWindowBase)









function UISystemZongMenListWin:bindComponents()

self.hideButton=UIButton.get(self,0)
self.ScrollView=UIObject.get(self,1)
self.NullTxt=UIText.get(self,2)
self.Content=UIObject.get(self,3)
self.icon=UIImage.get(self,4)
self.uiRoot=UIObject.get(self,5)
self.root=UIObject.get(self,6)

self.hideButton:setButtonClick(function()self:onHideButton()end)



end


function UISystemZongMenListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hideButton);self.hideButton=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.NullTxt);self.NullTxt=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this=nil
local _mainCmp={
bg=0,
name=1,
jiantou1=2,
jiantou2=3,
reddot=4,
}
local _sub1Cmp={
bg=0,
name=1,
level=2,
disBg=3,
noneTips=4,
selected=5,
reddot=6,
icon=7,
disIcon=8,
fighting=9,
surrender=10,
reward=11,
vassal=12,
cdTx=13,
strengthIcon=14,
}
local _sub2Cmp={
click=0,
name=1,
level=2,
selected=3,
disIcon=4,
}
local _mainItemName="UISystemZongMenListMainItem"
local _subItem1Name="UISystemZongMenListSubItem1"
local _subItem2Name="UISystemZongMenListSubItem2"
local _LuaComboTreeView=simple_class(LuaComboTreeView)



function UISystemZongMenListWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSystemZMOutgoerDataDelete,self.onSystemZMOutgoerDataDelete)
self:addNotify(notifyConfig.onSystemZMAdd,self.onSystemZMAdd)
self:addNotify(notifyConfig.onSystemZMDelete,self.onSystemZMDelete)
self:addNotify(notifyConfig.onSystemZMInit,self.onSystemZMInit)
self:addNotify(notifyConfig.onSystemZMOutgoerDataRefresh,self.onSystemZMOutgoerDataRefresh)
self:addNotify(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
self:addNotify(notifyConfig.onSystemZMRenownRewardFlag,self.onSystemZMRenownRewardFlag)
self:addNotify(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)


self._ScrollView=_LuaComboTreeView(self.winlua,self.ScrollView)
self._onScrollViewStart=function()
self:onScrollViewStart()
end
self._ScrollView:setStartAction(self._onScrollViewStart)
self._onMainItemRefresh=function(widget,mainIndex)
self:onMainItemRefresh(widget,mainIndex)
end
self._ScrollView:setItemRefresh(_mainItemName,self._onMainItemRefresh)
self._onSubItemRefresh1=function(widget,mainIndex,subIndex)
self:onSubItemRefresh1(widget,mainIndex,subIndex)
end
self._ScrollView:setItemRefresh(_subItem1Name,self._onSubItemRefresh1)
self._onSubItemRefresh2=function(widget,mainIndex,subIndex)
self:onSubItemRefresh2(widget,mainIndex,subIndex)
end
self._ScrollView:setItemRefresh(_subItem2Name,self._onSubItemRefresh2)

self.cdList={}
end


function UISystemZongMenListWin:__delete()
self._ScrollView:deleteSelf()

if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end

self:unbindComponents()
_this=nil
end




function UISystemZongMenListWin:onShow(argtable,afterOnloaded)
self.winlua:SwitchChildParent(self.root:getID(),worldController:isInWorld()and-1 or self.uiRoot:getID(),false)
self:updateData()
self:refreshView()
self:defaultClick()
end


function UISystemZongMenListWin:onHide()
self.selectMain=nil
self.selectSub=nil
end



function UISystemZongMenListWin:onHideButton()
worldController:resetLeftView()
end

function UISystemZongMenListWin:onScrollViewStart()

end

function UISystemZongMenListWin:defaultClick()
if#self.worlds>0 then
for i,v in ipairs(self.worlds)do
if worldModel:isSameWorld(v)then
self:onClickMainItem(i)
return
end
end
self:onClickMainItem(1)
end
end

function UISystemZongMenListWin:updateData()
local cfg=cfg_worldconfig()
self.worlds={}
self.mainNames={}
for i,v in ipairs(cfg)do
if worldBlockModel:getWorldStateCount(v.id,eWorldBlockState.OPEN)>0 then
table.insert(self.worlds,v.id)
table.insert(self.mainNames,_mainItemName)
end
end
table.sort(self.worlds)


self.list={}
self.subNames={}
for index,worldId in ipairs(self.worlds)do
local temp={}
local names={}
local zmList=systemZongMenModel:findInfoDataByWorld(worldId)
for i,v in ipairs(zmList)do
table.insert(temp,{type=1,data=v})
table.insert(names,_subItem1Name)
if systemZongMenModel:checkFightFlagOutgoerShow(v.flag)and v.yl_num>0 then
for i,v in ipairs(v.ylList)do
table.insert(temp,{type=2,data=v})
table.insert(names,_subItem2Name)
end
end
end
self.list[index]=temp
self.subNames[index]=names
end
end

function UISystemZongMenListWin:onRectChanged()

end

function UISystemZongMenListWin:refreshView()
self:clearCDTimer()
self._ScrollView:setMainData(self.mainNames)
for i,v in ipairs(self.subNames)do
self._ScrollView:setSubData(i,v)
end
self._ScrollView:refreshView()

if self.selectMain then
if not self._ScrollView:isExpanding(self.selectMain)then
self._ScrollView:expandMain(self.selectMain)
end
end
end

function UISystemZongMenListWin:onMainItemRefresh(item,mainIndex)
local isExpanded=self._ScrollView:isExpanding(mainIndex)
local world=self.worlds[mainIndex]
local area=cfgHelper.get1(cfg_worldareaconfig_get,world)
local reddot=systemZongMenModel:getWorldReddot(world)
item:SetChildText(_mainCmp.name,area.name)
item:SetChildActive(_mainCmp.jiantou1,not isExpanded)
item:SetChildActive(_mainCmp.jiantou2,isExpanded)
item:SetChildActive(_mainCmp.reddot,reddot)
item:SetChildButtonClick(_mainCmp.bg,function()
self:onClickMainItem(mainIndex)
end)
end

function UISystemZongMenListWin:onClickMainItem(mainIndex)
if self.selectMain~=mainIndex then
self.selectMain=mainIndex
self.selectSub=nil
end
self:clearCDTimer()
self._ScrollView:expandMain(mainIndex)
end

function UISystemZongMenListWin:onSubItemRefresh1(item,mainIndex,subIndex)
local data=self.list[mainIndex][subIndex].data
local icon=systemZongMenModel:getIconName(data.id,data.level)
local name=systemZongMenModel:getNameStr(data.id,data.nameIdx)
if data.flag==systemZongMenFightFlagType.eExpel then
local baseCfg=cfgHelper.get1(cfg_syssectbaseconfig_get,1)
name=FMT.fmt("<color=#8d8d8d>{0}</color>",baseCfg.ruinName)
icon=baseCfg.ruinIcon[data.worldId]or baseCfg.ruinIcon[0]
end
local isIn=data.disciple_guid>int64.zero
local selected=self._ScrollView:isExpanding(mainIndex)and self.selectSub==subIndex
local reddot=systemZongMenModel:getReddot_Renown(data.serial)
item:SetChildActive(_sub1Cmp.selected,selected)
item:SetChildCSImageIcon(_sub1Cmp.icon,icon,true)
item:SetChildActive(_sub1Cmp.reddot,reddot)
item:SetChildText(_sub1Cmp.name,name)
item:SetChildActive(_sub1Cmp.disBg,isIn)
item:SetChildActive(_sub1Cmp.noneTips,not isIn and data.flag~=systemZongMenFightFlagType.eExpel)
if isIn then
comHelper.setChildModelRawImage(item,data.disciple_guid,_sub1Cmp.disIcon,0,eHeadCenterType.eHead,0.7)
end
item:SetChildButtonClick(_sub1Cmp.bg,function()
self:onClickSubItem(mainIndex,subIndex)
end)
item:SetChildActive(_sub1Cmp.fighting,data.flag==systemZongMenFightFlagType.eBeAttacked)
item:SetChildActive(_sub1Cmp.surrender,data.flag==systemZongMenFightFlagType.eSurrender)
item:SetChildActive(_sub1Cmp.vassal,data.flag==systemZongMenFightFlagType.eVassal)

local config=cfgHelper.get1(cfg_syssectconfig_get,data.id)
if config.strengthIcon and data.flag~=systemZongMenFightFlagType.eExpel then
item:SetChildActive(_sub1Cmp.strengthIcon,true)
local spriteName=FMT.fmt("icon_zhongmenB_0{0}",config.strengthIcon)
item:SetChildCSImageSprite(_sub1Cmp.strengthIcon,globalABLookup.dashijie_component,spriteName)
else
item:SetChildIcon(_sub1Cmp.strengthIcon,"",false)
item:SetChildActive(_sub1Cmp.strengthIcon,false)
end

local itemIndex=self._ScrollView:convertShowIndex(mainIndex,subIndex)
if data.flag==systemZongMenFightFlagType.eExpel then
local func=function()
local nowTime=timeHelper.getServerShortTime()
local least=data.end_time-nowTime
if least>=0 then
local timeStr=timeHelper.format_time_stamp16(least)
item:SetChildText(_sub1Cmp.cdTx,FMT.fmt("<color=#009a00>{0}</color>消失",timeStr))
return true
else
item:SetChildText(_sub1Cmp.cdTx,"")
return false
end
end
self:addCDTimer(itemIndex,func)
else
item:SetChildText(_sub1Cmp.cdTx,"")

end
end

function UISystemZongMenListWin:onSubItemRefresh2(item,mainIndex,subIndex)
local data=self.list[mainIndex][subIndex].data
local selected=self._ScrollView:isExpanding(mainIndex)and self.selectSub==subIndex
item:SetChildActive(_sub2Cmp.selected,selected)
item:SetChildText(_sub2Cmp.name,data.disciplename)
item:SetChildText(_sub2Cmp.level,UIDiscipleModel:getJJName3(data.jingjie))
local imageInfo=UIDiscipleModel.calculationDiscipleImage(data.discipledata,data.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildModelRawImageEx(_sub2Cmp.disIcon,item,modelParams,eHeadCenterType.eHead,0.7)
item:SetChildButtonClick(_sub2Cmp.click,function()
self:onClickSubItem(mainIndex,subIndex)
end)
end

function UISystemZongMenListWin:addCDTimer(itemIndex,update)
if update()then
self.cdList[itemIndex]=update

if not self.cdTimer then
self.cdTimer=self:setTimer(1,0,function()
self:updateCDTimer()
end)
end
end
end

function UISystemZongMenListWin:updateCDTimer()
for i,v in pairs(self.cdList)do
if not v()then
self.cdList[i]=nil
end
end

if next(self.cdList)~=nil then
return
end

self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end

function UISystemZongMenListWin:deleteCDTimer(itemIndex)
self.cdList[itemIndex]=nil

if next(self.cdList)~=nil then
return
end

if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end

function UISystemZongMenListWin:clearCDTimer()
table.clear(self.cdList)
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end

function UISystemZongMenListWin:onClickSubItem(mainIndex,subIndex)
local oMain=self.selectedMain
local oSub=self.selectSub

self.selectedMain=mainIndex
self.selectSub=subIndex

if oMain~=self.selectedMain or oSub~=self.selectSub then
if oMain then
self._ScrollView:refreshItem(oMain,oSub or 0)
end
self._ScrollView:refreshItem(self.selectedMain,self.selectSub or 0)
self:onSelectData()
end
end

function UISystemZongMenListWin:onSelectData()
local data=self.list[self.selectMain]
data=data and data[self.selectSub]or nil
if data and self:checkSelectData(data)then
local itemType=data.type
local itemData=data.data
local hanle=FMT.fmt("onSelectData{0}",itemType)
self[hanle](self,itemData)
end
end

function UISystemZongMenListWin:checkSelectData(data)
return self[FMT.fmt("checkSelectData{0}",data.type)](self,data.data)
end

function UISystemZongMenListWin:checkSelectData1(data)
local infoData=systemZongMenModel:getInfoData(data.serial)
return infoData~=nil
end

function UISystemZongMenListWin:checkSelectData2(data)
local outgoerData=systemZongMenModel:getOutgoerData(data.discipleguid)
return outgoerData~=nil
end

function UISystemZongMenListWin:onSelectData1(data)
local unitKey=systemZongMenModel:convertUnitKey(data.serial)
if worldModel:isSameWorld(data.worldId)then
worldController:resetRightView()
worldController:lookAtUnit(unitKey)
else
local worldName=cfgHelper.get2(cfg_worldconfig_get,data.worldId,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local args={lookAtUnit=unitKey}
worldController:enterWorld(data.worldId,args)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end

function UISystemZongMenListWin:onSelectData2(data)
local unitKey=systemZongMenModel:convertOutgoerUnitKey(data.discipleguid)
if worldModel:isSameWorld(data.world)then
worldController:clickUnit(unitKey)

else
local worldName=cfgHelper.get2(cfg_worldconfig_get,data.world,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local args={clickUnit=unitKey}
worldController:enterWorld(data.world,args)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end

function UISystemZongMenListWin:resetView()
if not systemZongMenController:isOutgoerSceneDoing()then
self:refreshViewImp()
end
end

function UISystemZongMenListWin:refreshViewImp()
self:updateData()
self:refreshView()
end

function UISystemZongMenListWin.onSystemZMOutgoerDataDelete(guids,flag)
if#guids>0 then
_this:resetView()
end
end

function UISystemZongMenListWin.onSystemZMAdd(serial)
_this:resetView()
end

function UISystemZongMenListWin.onSystemZMDelete(serial)
_this:resetView()
end

function UISystemZongMenListWin.onSystemZMInit()
_this:resetView()
end

function UISystemZongMenListWin.onSystemZMOutgoerDataRefresh()
_this:resetView()
end

function UISystemZongMenListWin.onSystemZMMoneyNumChange(serial,eType,newVal,oldVal)
for mainIdx,list in ipairs(_this.list)do
for subIndex,temp in ipairs(list)do
if temp.type==1 and mathHelper.compareInt64(temp.data.serial,serial)then
local oRenownIndex=systemZongMenModel:getRenownIndex(temp.data.id,oldVal)
local nRenownIndex=systemZongMenModel:getRenownIndex(temp.data.id,newVal)
if oRenownIndex~=nRenownIndex then
_this._ScrollView:refreshItem(mainIdx,0)
_this._ScrollView:refreshItem(mainIdx,subIndex)
end
return
end
end
end
end

function UISystemZongMenListWin.onSystemZMRenownRewardFlag(serial,idx,old)
for mainIdx,list in ipairs(_this.list)do
for subIndex,temp in ipairs(list)do
if temp.type==1 and mathHelper.compareInt64(temp.data.serial,serial)then
_this._ScrollView:refreshItem(mainIdx,0)
_this._ScrollView:refreshItem(mainIdx,subIndex)
return
end
end
end
end

function UISystemZongMenListWin.onSystemZMFightFlagChanged(serial,oldFlag,newFlag)
local oShow=systemZongMenModel:checkFightFlagOutgoerShow(oldFlag)
local nShow=systemZongMenModel:checkFightFlagOutgoerShow(newFlag)
if oShow~=nShow then
_this:resetView()
else
for mainIdx,list in ipairs(_this.list)do
for subIndex,temp in ipairs(list)do
if temp.type==1 and mathHelper.compareInt64(temp.data.serial,serial)then
_this._ScrollView:refreshItem(mainIdx,0)
_this._ScrollView:refreshItem(mainIdx,subIndex)
return
end
end
end
end
end















