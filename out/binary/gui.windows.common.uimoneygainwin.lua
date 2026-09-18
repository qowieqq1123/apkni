







def_class("UIMoneyGainWin",UIWindowBase)









function UIMoneyGainWin:bindComponents()

self.desc=UIText.get(self,0)
self.descContent=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.quality=UIImage.get(self,3)
self.Icon=UIImage.get(self,4)
self.gainScrollerView=UIObject.get(self,5)
self.num=UIText.get(self,6)
self.descScrollView=UIObject.get(self,7)
self.arrow=UIObject.get(self,8)



end


function UIMoneyGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descContent);self.descContent=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.quality);self.quality=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.gainScrollerView);self.gainScrollerView=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.descScrollView);self.descScrollView=nil;
_UIObject_release(self.arrow);self.arrow=nil;
end















local _offset=10
local _errType=
{
eSystem=1,
eLevel=2,
}

function UIMoneyGainWin:onLoaded(...)
self:bindComponents()
local _OnClickItemCallback=function(...)
self:onClickItemCallback(...)
end
self.gainScrollerView:setChildScrollViewInit(-1,true,_OnClickItemCallback,nil)
self.descScrollHeight=self.winlua:GetChildSizeDeltaY(self.descScrollView:getID())
self:activeArrow(false)
end


function UIMoneyGainWin:__delete()
self:unbindComponents()
end




function UIMoneyGainWin:onShow(argtable,afterOnloaded)
local moneyType=argtable[1]
local config=itemsConfig.getConfig(moneyType)
self.config=config
local moneyName=config.name
local num=0
if moneyConfig.isMoney(moneyType)then
num=moneyModel.getMoney(moneyType)
else
num=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self.name:setText(moneyName)
self.desc:setText(config.desc)
self.num:setText(FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eOrangeDescColor,'数量：'),num))
self.Icon:setImageIcon(iconHelper.getIconName(moneyType),false)
self.winlua:SetChildQulaity(self.quality:getID(),eQualityColor.ePurple)
local showList=self:getGainList()
self.gainScrollerView:setChildScrollViewCreateGrids(#showList,1)
local grids=self.gainScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local list=showList[i]
local jump=list.jump
item:SetChildText(1,list.desc)
local canJump=jump~=nil
local unLock,errArgs=self:isUnlock(list)
local active=canJump and unLock
item:SetChildActive(2,not unLock)
item:SetChildActive(3,active)
item:SetChildButtonClick(4,function(...)
if active then
jumpManager:jump(jump)
else
if not unLock then
local errType=errArgs[1]
local errValue=errArgs[2]
if errType==_errType.eSystem then
local desc=systemModel.getOpenTips(errValue)
UIManager.error(desc)
elseif errType==_errType.eLevel then
UIManager.error(FMT.fmt('宗门等级不足{0}级',errValue))
end
else


end
end
end)
end
end


function UIMoneyGainWin:onHide()

end

function UIMoneyGainWin:isUnlock(v)
local sysid=v.sysid
local lv=v.lv
if sysid then
if not systemModel.isOpen(sysid)then
return false,{_errType.eSystem,sysid}
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false,{_errType.eLevel,lv}
end
end
return true
end

function UIMoneyGainWin:getGainList()

local produce=self.config.produce
local list=table.deepCopy(produce)
for i,v in ipairs(list)do
v.sortTag=i
local unLock=self:isUnlock(v)
if not unLock then
v.sortTag=i+10000
end
end
table.sort(list,function(a,b)return a.sortTag<b.sortTag end)
return list
end

function UIMoneyGainWin:onClickItemCallback(clickcount,index)
local showList=self:getGainList()
local list=showList[index+1]
local unLock=self:isUnlock(list)
if not unLock then
UIManager.error('未解锁')
end
end

function UIMoneyGainWin:onValueChanged()












end

function UIMoneyGainWin:activeArrow(flag)
if self.arrowFlag==flag then return end
self.arrowFlag=flag
self.arrow:setActive(flag)
end


function UIMoneyGainWin:onClickClose()
self:closeSelf()
end
