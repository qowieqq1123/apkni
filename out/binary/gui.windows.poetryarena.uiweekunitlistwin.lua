







def_class("UIWeekUnitListWin",UIWindowBase)









function UIWeekUnitListWin:bindComponents()

self.helpBtn=UIButton.get(self,0)
self.CSGUIScrollView=UIComboScrollView.get(self,1)
self.none=UIObject.get(self,2)
self.uiRoot=UIObject.get(self,3)
self.root=UIObject.get(self,4)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIWeekUnitListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.none);self.none=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this=nil
local _mainCmp={
name=0,
jiantou1=1,
jiantou2=2,
reddot=3,
}
local _subCmp={
icon=0,
name=1,
ing=2,
}

local subPrefabType=
{
common=0,
mijing=1,
yiyuhuiyou=2,
}
local abname_yyhy='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'
local abname_suo='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local subPrefab=
{
[subPrefabType.common]=
{
icon=0,
name=1,
ing=2,
progressbar=4,
adimg=5,
icongray=6,
lockimg=7,
select=8,
SetItem=function(this,win,item,data)
item:SetChildText(this.name,data.name)
item:SetChildActive(this.icon,true)
item:SetChildActive(this.icongray,false)
item:SetChildIcon(this.icon,data.icon,true)
item:SetChildActive(this.ing,data.ing)
item:SetChildActive(this.progressbar,false)
item:SetChildActive(this.adimg,false)
item:SetChildActive(this.lockimg,false)
item:SetChildActive(this.select,false)
end,
},
[subPrefabType.yiyuhuiyou]=
{
icon=0,
name=1,
ing=2,
progressbar=4,
adimg=5,
icongray=6,
lockimg=7,
select=8,
SetItem=function(this,win,item,data)
item:SetChildText(this.name,data.name)
item:SetChildActive(this.icon,false)
item:SetChildActive(this.icongray,true)
item:SetChildIcon(this.icongray,data.icon,true)
item:SetChildActive(this.ing,data.ing)
item:SetChildActive(this.progressbar,false)
item:SetChildActive(this.select,false)
if data.naduindex then

if data.yujudata and data.yujudata[1]==false then

item:SetChildActive(this.lockimg,true)
item:SetChildActive(this.adimg,false)
else
item:SetChildActive(this.lockimg,false)
item:SetChildActive(this.adimg,true)
item:SetChildCSImageSprite(this.adimg,abname_yyhy,FMT.fmt('image_yiyuhuiyound_{0}',data.naduindex))
end
end
if data.yujudata and data.yujudata[1]==false then

item:SetChildImageExGray(this.icongray,true)
else
item:SetChildImageExGray(this.icongray,false)
end
end,
},






















}



















local _listenActs={
[LIMIT_ACT_TYPE.eWenDouLeiTai]={
['subPrefabType']=subPrefabType.common,
["getListData"]=function()
return poetryArenaModel:getUnitDataList()
end,
["onClickItem"]=function(guid)
poetryArenaController.onClickUnitTab(guid)
end,
["refreshData"]=function(data)
poetryArenaModel:refreshUnitData(data)
end,
},














[LIMIT_ACT_TYPE.eYiYuHuiYou]={
['subPrefabType']=subPrefabType.yiyuhuiyou,
["getListData"]=function()
return YiYuHuiYouModel:getUnitDataList()
end,
["onClickItem"]=function(guid)


YiYuHuiYouController.onClickUnitTab(guid)
end,
["refreshData"]=function(data)
YiYuHuiYouModel:refreshUnitData(data)
end,
},
}




function UIWeekUnitListWin:onLoaded(argtable)
self:bindComponents()
_this=self
local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end

self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
self:initView(argtable)
end


function UIWeekUnitListWin:__delete()
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:unbindComponents()
_this=nil
end




function UIWeekUnitListWin:onShow(argtable,afterOnloaded)
self.winlua:SwitchChildParent(self.root:getID(),worldController:isInWorld()and-1 or self.uiRoot:getID(),false)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
end


function UIWeekUnitListWin:onHide()


end




function UIWeekUnitListWin:onHelpBtn()
UIFullTaskMainControl:showWindowLimitAct()
end

function UIWeekUnitListWin:mainClickAction(mainItem)
local mainIndex=mainItem.Index+1
if self.mainIndex~=mainIndex then
if self.mainIndex then
local mItem=self.CSGUIScrollView:getMainItem(self.mainIndex-1)
mItem:SetChildActive(_mainCmp.jiantou1,true)
mItem:SetChildActive(_mainCmp.jiantou2,false)
end
self.mainIndex=mainIndex
mainItem:SetChildActive(_mainCmp.jiantou1,false)
mainItem:SetChildActive(_mainCmp.jiantou2,true)
else
self.mainIndex=nil
mainItem:SetChildActive(_mainCmp.jiantou1,true)
mainItem:SetChildActive(_mainCmp.jiantou2,false)
end
end

function UIWeekUnitListWin:subClickAction(subItem)
local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local actId=self.actList[mainIndex]
local data=self.dataList[actId][subIndex]
local config=_listenActs[actId]

if self.subIndex then
local sItem=self.CSGUIScrollView:getSubItem(self.mainIndex-1,self.subIndex-1)
sItem:SetChildActive(8,false)
end
self.subIndex=subIndex

subItem:SetChildActive(8,true)

config.onClickItem(data.guid)
end

function UIWeekUnitListWin:mainCreateAction(mainItem)
local mainIndex=mainItem.Index+1
local selected=mainIndex==self.mainIndex
local actId=self.actList[mainIndex]
local count=#self.dataList[actId]
local nameStr=limitActivitiesModel:getActConfig(actId,"name")
local exStr=limitActivitiesModel:getActConfig(actId,"weekdesc")
if exStr then
nameStr=FMT.fmt("{0}（{1}）",nameStr,exStr)
end








mainItem:SetChildText(_mainCmp.name,nameStr)
mainItem:SetChildActive(_mainCmp.jiantou1,not selected)
mainItem:SetChildActive(_mainCmp.jiantou2,selected)
mainItem:SetChildActive(_mainCmp.reddot,false)
mainItem:SetAddExpandColumCount(count)
end

function UIWeekUnitListWin:subCreateAction(subItem)
local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1

local actId=self.actList[mainIndex]
local data=self.dataList[actId][subIndex]

local actFunc=_listenActs[actId]
local subType=actFunc.subPrefabType or subPrefabType.common
local setItemFunc=subPrefab[subType].SetItem



if setItemFunc then
subPrefab[subType]:SetItem(self,subItem,data)
end

end

function UIWeekUnitListWin:onExpandAction(index)
self.subIndex=nil
end

function UIWeekUnitListWin:initView(argtable)
self.actList={}
self.dataList={}
for id,data in pairs(_listenActs)do
if limitActivitiesModel:checkActOpen(id)and limitActivitiesModel:checkActDoing(id)then
table.insert(self.actList,id)
self.dataList[id]=data.getListData()
end
end
local cnt=#self.actList
self.CSGUIScrollView:createMainGrids(cnt,1,false)
self.none:setActive(cnt<=0)
if cnt>0 then
if argtable and argtable.act then
local index=table.findValue(self.actList,argtable.act)
if index then
self.CSGUIScrollView:clickItem(index-1)
end
else
self.CSGUIScrollView:clickItem(0)
end
end
end

function UIWeekUnitListWin.onLimitActOpen(actID,flag)
if _listenActs[actID]~=nil and limitActivitiesModel:checkActDoing(actID)then
_this:refreshView()
end
end

function UIWeekUnitListWin:refreshView()
local oldIdx=self.mainIndex
local oldAct=oldIdx and self.actList[oldIdx]or nil
local newIdx=nil
self.CSGUIScrollView:removeAllGrids()
self.actList={}
self.dataList={}
for id,data in pairs(_listenActs)do
if limitActivitiesModel:checkActOpen(id)and limitActivitiesModel:checkActDoing(id)then
table.insert(self.actList,id)
if oldAct==id then
newIdx=#self.actList
end
self.dataList[id]=data.getListData()
end
end
local cnt=#self.actList
self.CSGUIScrollView:createMainGrids(cnt,1,false)
self.none:setActive(cnt<=0)

self.mainIndex=nil
if newIdx then
self.CSGUIScrollView:clickItem(newIdx-1)
end
end

function UIWeekUnitListWin.onLimitActStateChange(actID,state)
if _listenActs[actID]~=nil and(state==limitActivitiesModel.actDoingState or state==limitActivitiesModel.actFinishState)then
_this:refreshView()
end
end

function UIWeekUnitListWin:refreshList(act)
local mIdx=nil
for i,v in ipairs(self.actList)do
if v==act then
mIdx=i
break
end
end

if mIdx then
local data=_listenActs[act]
local list=data.getListData()
self.dataList[act]=list
local mainItem=self.CSGUIScrollView:getMainItem(mIdx-1)
mainItem:SetAddExpandColumCount(#list)
if self.mainIndex==mIdx then
local subs=self.CSGUIScrollView:getSubItemsList()
if subs.Count~=#list then
self.CSGUIScrollView:rebuildSubItems(mIdx-1,#list)
else
local subItems=self.CSGUIScrollView:getSubItemsList()
for i=1,subItems.Count do
local subItem=subItems[i-1]
self:subCreateAction(subItem)
end
end
end
end
end

function UIWeekUnitListWin:refreshItem(act,guid)
if self.mainIndex and self.actList[self.mainIndex]==act then
for i,v in ipairs(self.dataList[act])do
if mathHelper.compareInt64(v.guid,guid)then
local data=_listenActs[act]
data.refreshData(v)
local subItem=self.CSGUIScrollView:getSubItem(self.mainIndex-1,i-1)
self:subCreateAction(subItem)
return
end
end
end
end