







def_class("UIMoJieRankRuleWin_New",UIWindowBase)









function UIMoJieRankRuleWin_New:bindComponents()

self.list=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.scrollview=UILoopListView.new(self,2)
self.title=UIText.get(self,3)
self.closeButton=UIButton.get(self,4)
self.menuGridPanel=UIObject.get(self,5)
self.mjsltime=UIText.get(self,6)

self.scrollview:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.closeButton:setButtonClick(function()UIManager:closeWindow("UIMoJieRankRuleWin_New")end)



end


function UIMoJieRankRuleWin_New:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.root);self.root=nil;
self.scrollview:deleteSelf();self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.mjsltime);self.mjsltime=nil;
end
















local _this
local ItemType={
eEmpty=0,
eDesc=1,
eRuleItem_1=2,
eRuleItem_2=3,
eRuleItem_3=4,
eRuleItem_5=5,
eRuleItem_6=6,
eRuleItem_Auto=7,
}

local prefabNames={
[ItemType.eEmpty]="emptyItem",
[ItemType.eDesc]="descItem",
[ItemType.eRuleItem_1]="ruleItem_1",
[ItemType.eRuleItem_2]="ruleItem_2",
[ItemType.eRuleItem_3]="ruleItem_3",
[ItemType.eRuleItem_5]="ruleItem_5",
[ItemType.eRuleItem_6]="ruleItem_6",
[ItemType.eRuleItem_Auto]="ruleItem_auto",
}

local refreshFuncName={
[ItemType.eEmpty]="refreshFunc_EmptyItem",
[ItemType.eDesc]="refreshFunc_DescItem",
[ItemType.eRuleItem_1]="refreshFunc_RuleItem_1",
[ItemType.eRuleItem_2]="refreshFunc_RuleItem_2",
[ItemType.eRuleItem_3]="refreshFunc_RuleItem_3",
[ItemType.eRuleItem_5]="refreshFunc_RuleItem_5",
[ItemType.eRuleItem_6]="refreshFunc_RuleItem_6",
[ItemType.eRuleItem_Auto]="refreshFunc_RuleItem_auto",
}
local menu_slot_name='button_dytab'
local rankItemCmpIndex={
bg=0,
rankText=1,
rewardScrollView=2,
}
local pageConfig=
{
[1]={
page=1,
name='仙伐榜',
checkReddot=function()
return false
end,
ranktype=1,
},
[2]={
page=2,
name='诛魔榜',
checkReddot=function()
return false
end,
ranktype=2,
},
}




function UIMoJieRankRuleWin_New:onLoaded(...)
self:bindComponents()
_this=self

self.testlist=
{
[1]=
{
{itemType=6,title="仙伐榜积分说明",txt1="每驻守演武台 <color=#ca631d>1</color> 秒= <color=#ca631d>6</color> 积分\n每驻守演武台 <color=#ca631d>1</color> 秒= <color=#ca631d>6</color> 积分\n每驻守演武台 <color=#ca631d>1</color> 秒= <color=#ca631d>6</color> 积分"},
{itemType=7,title="仙界-击破仙墟",
list=
{
"<color=#ca631d>1</color> 筑基 = <color=#ca631d>20</color> 积分",
"<color=#ca631d>2</color> 筑基 = <color=#ca631d>23</color> 积分",
"<color=#ca631d>3</color> 筑基 = <color=#ca631d>26</color> 积分",
"<color=#ca631d>4</color> 筑基 = <color=#ca631d>29</color> 积分",
"<color=#ca631d>5</color> 筑基 = <color=#ca631d>32</color> 积分",
"<color=#ca631d>6</color> 筑基 = <color=#ca631d>35</color> 积分",
"<color=#ca631d>7</color> 筑基 = <color=#ca631d>38</color> 积分",
"<color=#ca631d>8</color> 筑基 = <color=#ca631d>41</color> 积分",
"<color=#ca631d>9</color> 筑基 = <color=#ca631d>44</color> 积分",
"<color=#ca631d>10</color> 筑基 = <color=#ca631d>47</color> 积分",
"<color=#ca631d>11</color> 筑基 = <color=#ca631d>50</color> 积分",
"<color=#ca631d>12</color> 筑基 = <color=#ca631d>53</color> 积分",
}
},
},
[2]=
{
{itemType=6,title="诛魔榜积分说明",txt1="每驻守演武台 <color=#ca631d>1</color> 秒= <color=#ca631d>6</color> 积分\n每驻守演武台 <color=#ca631d>1</color> 秒= <color=#ca631d>6</color> 积分\n每驻守演武台 <color=#ca631d>1</color> 秒= <color=#ca631d>6</color> 积分"},
{itemType=7,title="仙界诛魔-击破仙墟",
list=
{
"<color=#ca631d>1</color> 筑基 = <color=#ca631d>20</color> 积分",
"<color=#ca631d>2</color> 筑基 = <color=#ca631d>23</color> 积分",
"<color=#ca631d>3</color> 筑基 = <color=#ca631d>26</color> 积分",
"<color=#ca631d>4</color> 筑基 = <color=#ca631d>29</color> 积分",
"<color=#ca631d>5</color> 筑基 = <color=#ca631d>32</color> 积分",
"<color=#ca631d>6</color> 筑基 = <color=#ca631d>35</color> 积分",
"<color=#ca631d>7</color> 筑基 = <color=#ca631d>38</color> 积分",
"<color=#ca631d>8</color> 筑基 = <color=#ca631d>41</color> 积分",
"<color=#ca631d>9</color> 筑基 = <color=#ca631d>44</color> 积分",
"<color=#ca631d>10</color> 筑基 = <color=#ca631d>47</color> 积分",
"<color=#ca631d>11</color> 筑基 = <color=#ca631d>50</color> 积分",
"<color=#ca631d>12</color> 筑基 = <color=#ca631d>53</color> 积分",
}
},
}
}
end


function UIMoJieRankRuleWin_New:__delete()
self:unbindComponents()
self:stopSelfTimerMJ()
_this=nil
end




function UIMoJieRankRuleWin_New:onShow(argtable,afterOnloaded)
local enterData=xianjieModel:getMoJieEnterData()
self.mojiecfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
self.rankType=argtable and argtable.rankType or 1
local page=1
self.showPageCfgList={}
self.pageLookup={}
for i,v in ipairs(pageConfig)do
local idx=#self.showPageCfgList+1
self.showPageCfgList[idx]=v
self.pageLookup[v.page]=idx
if self.rankType==v.ranktype then
page=v.page
end
end
local idx=self.pageLookup[page]

if afterOnloaded then
local cnt=#self.showPageCfgList
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=self.showPageCfgList[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
local func=function()
if _this==nil then return end
if isSelected then
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,isSelected)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end

self:onMenuItemClick(idx)

end


function UIMoJieRankRuleWin_New:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIMoJieRankRuleWin_New:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.showPageCfgList[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,isReddot)
end

function UIMoJieRankRuleWin_New:onMenuItemClick(idx)
local cfg=self.showPageCfgList[idx]
if cfg.page==self.curPage then
return
end
local old=self.curPage
self.curPage=cfg.page
if old~=nil then
local idx_=self.pageLookup[old]
self:refreshMenuItemSelect(nil,idx_,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self:refreshMenuPage()
end

function UIMoJieRankRuleWin_New:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=self.showPageCfgList[idx]
local ranktype=cfg.ranktype
self.rankType=ranktype
self:refresh()
end
function UIMoJieRankRuleWin_New:refresh()
local rankType=self.rankType
self.title:setText('规则说明')
local list={}
local cfgrank=self:getTypeReward(rankType)
if cfgrank then
list=cfgrank
end


if list and#list>0 then
local prefabnameList={}
for i,temp in ipairs(list)do
local name=prefabNames[temp.itemType]
if not name then
logErr("prefabNames 为 nil",temp.itemType)
return
end
table.insert(prefabnameList,name)
end
self.scrollview:initDataEx(prefabnameList,list)
else
self.scrollview:initData(nil,nil,0)
end
end

function UIMoJieRankRuleWin_New:getTypeReward(flag)
local cfgrank=self.mojiecfg.MJtipsDesc
return cfgrank[flag]
end


function UIMoJieRankRuleWin_New:freshMJSLTitle()
local endtime=xianjieController:getMoJieSaiJieTime()
if endtime then
self:MJrefreshTime(endtime)
else
self:stopSelfTimerMJ()
end
end
function UIMoJieRankRuleWin_New:MJrefreshTime(endTime)
local curTime=timeHelper.getServerShortTime()
local timeStr=FMT.fmt('{0}结算',timeHelper.format_time_stamp15(endTime-curTime))
self.mjsltime:setText(timeStr)
self:stopSelfTimerMJ()
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
timeStr=FMT.fmt('{0}结算',timeHelper.format_time_stamp15(showTime))
self.mjsltime:setText(timeStr)

if dtTime<=0 then
self:stopSelfTimerMJ()
end
end
self.timermjsl=self:setTimer(1,0,func)
end
function UIMoJieRankRuleWin_New:stopSelfTimerMJ()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end


function UIMoJieRankRuleWin_New:onHide()

end

function UIMoJieRankRuleWin_New:onFreshAction(index,widget,data)
local item=widget

local funcName=refreshFuncName[data.itemType]
if funcName and self[funcName]then
self[funcName](self,item,data)
else
logErr("UIMoJieRankRuleWin_New refreshFuncName 没有刷新方法",data.itemType)
end
end


function UIMoJieRankRuleWin_New:onStartAction()
end

function UIMoJieRankRuleWin_New:refreshFunc_EmptyItem(item,data)
item:SetChildSizeDelta(0,1070,data.hight)
end
function UIMoJieRankRuleWin_New:refreshFunc_DescItem(item,data)
item:SetChildText(2,data.desc)
item:ForceLayoutVertical(0)
local txtY=item:GetChildRectHeight(2)
local itemHiget=txtY
item:SetChildSizeDelta(0,1070,itemHiget+15)
end
function UIMoJieRankRuleWin_New:refreshFunc_RuleItem_1(item,data)
item:SetChildText(1,data.title)
item:SetChildText(2,data.txt1)
end
function UIMoJieRankRuleWin_New:refreshFunc_RuleItem_2(item,data)
item:SetChildText(1,data.title)
item:SetChildText(2,data.txt1)
item:SetChildText(3,data.txt2)
end
function UIMoJieRankRuleWin_New:refreshFunc_RuleItem_3(item,data)
item:SetChildText(1,data.title)
item:SetChildText(2,data.txt1)
item:SetChildText(3,data.txt2)
item:SetChildText(4,data.txt3)
end
function UIMoJieRankRuleWin_New:refreshFunc_RuleItem_5(item,data)
item:SetChildText(1,data.title)
item:SetChildText(2,data.txt1)
item:SetChildText(3,data.txt2)
item:SetChildText(4,data.txt3)
item:SetChildText(5,data.txt4)
item:SetChildText(6,data.txt5)
end
function UIMoJieRankRuleWin_New:refreshFunc_RuleItem_6(item,data)
item:SetChildText(1,data.title)
item:SetChildText(2,data.txt1)
end
function UIMoJieRankRuleWin_New:refreshFunc_RuleItem_auto(item,data)
item:SetChildText(1,data.title)
local list=data.list
local layouH=114
if#list>0 then
local num=math.ceil(#list/3)
item:SetChildLayoutGroupCreateItems(3,num,function(index)
local grid=item:GetChildLayoutGroupGridItem(3,index-1)
grid:SetChildActive(0,index%2==1)
for i=1,3,1 do
local dataIndex=(index-1)*3+i
local txt=list[dataIndex]
if txt then
grid:SetChildText(i,txt)
else
grid:SetChildText(i,"")
end
end
end)
layouH=64+num*50+(num-1)*18
else
item:SetChildLayoutGroupClearAllItems(3)
end
item:ForceLayoutVertical(3)

item:SetChildSizeDelta(0,1070,layouH+21)
end