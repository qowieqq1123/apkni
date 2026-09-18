







def_class("UIXJ_RPCtOneWin",UIWindowBase)









function UIXJ_RPCtOneWin:bindComponents()

self.root=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.desc=UIText.get(self,2)
self.taskScroller=UIObject.get(self,3)
self.sjbtn=UIButton.get(self,4)
self.monsterIcon=UIObject.get(self,5)
self.spinebg=UIObject.get(self,6)
self.closebtn=UIButton.get(self,7)
self.spinebg2=UIObject.get(self,8)
self.npcModel=UIObject.get(self,9)

self.sjbtn:setButtonClick(function()self:onSjbtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UIXJ_RPCtOneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.sjbtn);self.sjbtn=nil;
_UIObject_release(self.monsterIcon);self.monsterIcon=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.spinebg2);self.spinebg2=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
end
















local _this
local itemidex=
{
itemself=0,
btn=1,
choosebtn=2,
reScrollview=3,
yxzimg=4,
rwItemlist={5,6,7}
}



function UIXJ_RPCtOneWin:onLoaded(...)
self:bindComponents()
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChange)
_this=self
end


function UIXJ_RPCtOneWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChange)
_this=nil
end




function UIXJ_RPCtOneWin:onShow(argtable,afterOnloaded)
self.spinebg:setChildUIModelShowTarget(6029,1,nil,eAnimationID.enter)
self.spinebg2:setChildUIModelShowTarget(6030,1,nil,eAnimationID.enter)
local cfg_npcmodelid=2113025
self.npcModel:setChildUIModelShowTarget(cfg_npcmodelid,0.7,{},eAnimationID.stand,false,true)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.8,nil)

self.guid=argtable.guid
self.taskId=argtable.taskId
local rpdata=xianjieModel:getResPointData(self.guid)
self.cfg=rpdata:getCfg()
self.isenorgh={}
self.selectid=0
self.choiceslist=self.cfg.choices
self:freshinfo()
end


function UIXJ_RPCtOneWin:onHide()

end
function UIXJ_RPCtOneWin:onClickClose()
self:closeSelf()
end

function UIXJ_RPCtOneWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UIXJ_RPCtOneWin:onSjbtn()
if self.selectid==0 then
UIManager.info("请先选择提交方案")
return
end
if self.selectid>0 then
local haveid=self.isenorgh[self.selectid]
if haveid then
gainControl:showGainWin(haveid)
else

if self.taskId then
xianjiexianbangController:send_37_85(self.taskId,1)
end
xianjieController:send_37_98(self.guid,self.selectid)
xianjieController:closeWin('UIXianJie_RPCtCollectWin')
end
end
end

function UIXJ_RPCtOneWin:onchoosebtn(index)
if self.selectid==index then
return
end
local oldselect=self.selectid
self.selectid=index

local grids=self.taskScroller:getChildScrollViewItemWidgets()
if grids then
if oldselect-1>=0 then
local olditem=grids[oldselect-1]
if olditem then
olditem:SetChildActive(itemidex.yxzimg,false)
olditem:SetChildActive(itemidex.choosebtn,true)
end
end
local newitem=grids[self.selectid-1]
if newitem then
newitem:SetChildActive(itemidex.yxzimg,true)
newitem:SetChildActive(itemidex.choosebtn,false)
end
end
end

function UIXJ_RPCtOneWin.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if _this==nil then
return
end
_this:freshinfo()
end

function UIXJ_RPCtOneWin.onMoneyChange(moneyType,lastVal,val)
if _this==nil then
return
end
_this:freshinfo()
end

function UIXJ_RPCtOneWin:showTopMoney(datas)
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


function UIXJ_RPCtOneWin:freshinfo()
local hblist={}

self.desc:setText(self.cfg.npcdesc2[1]or"")

self.winlua:SetChildIcon(self.monsterIcon:getID(),self.cfg.headimage,true)

local choiceslist=self.choiceslist
self.taskScroller:setActive(true)
self.taskScroller:setChildScrollViewCreateGrids(#choiceslist,1)
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local choicedata=choiceslist[i]
local len2=#choicedata
local isengough=false
item:SetChildActive(itemidex.choosebtn,true)
item:SetChildActive(itemidex.yxzimg,false)


item:SetChildButtonClick(itemidex.choosebtn,function(...)
if _this==nil then return end
self:onchoosebtn(i)
end)


for idx=1,len2 do
local widget=item:GetChildWidgetBase(itemidex.rwItemlist[idx])
local data=choicedata[idx]
if data then
widget:SetChildActive(0,true)
local itemid=data[1]
local itemnum=data[2]
local itemcount=""
local havecount=0
local graynum=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end
local str2=mathHelper.formatNumber7(itemnum,nil,2)
if havecount>=itemnum then
itemcount=FMT.fmt('{0}',str2)
else
isengough=itemid
itemcount=FMT.fmt('<color=#f36666>{0}</color>',str2)
graynum=0
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(1,prop)
widget:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
end
end
self.isenorgh[i]=isengough
end
end
end
