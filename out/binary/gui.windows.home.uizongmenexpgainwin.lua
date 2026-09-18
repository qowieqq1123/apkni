







def_class("UIZongmenExpGainWin",UIWindowBase)









function UIZongmenExpGainWin:bindComponents()

self.zmLevel=UIText.get(self,0)
self.progressbar=UIProgress.get(self,1)
self.gainScrollerView=UIObject.get(self,2)



end


function UIZongmenExpGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.zmLevel);self.zmLevel=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.gainScrollerView);self.gainScrollerView=nil;
end

















local _format=string.format


function UIZongmenExpGainWin:onLoaded(...)
self:bindComponents()
local _OnClickItemCallback=function(...)
self:onClickItemCallback(...)
end
self.gainScrollerView:setChildScrollViewInit(-1,true,_OnClickItemCallback,nil)
end


function UIZongmenExpGainWin:__delete()
self:unbindComponents()
end




function UIZongmenExpGainWin:onShow(argtable,afterOnloaded)
local level=zongmenModel:getLevel()
self.zmLevel:setText(_format('宗门等级：%s级',level))
local next_cfg=cfg_guildexpconfig_get(level+1)
local curExp=tonumber(tostring(zongmenModel:getExp()))
if next_cfg then
self.progressbar:setProgressValue(curExp,next_cfg.exp)
self.progressbar:setChildProgressText(_format('%s/%s',curExp,next_cfg.exp))
end
self.money=argtable[1]
local showList=self:getExpGainList()
self.gainScrollerView:setChildScrollViewCreateGrids(#showList,1)
local grids=self.gainScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local list=showList[i]
local jump=list.jump
item:SetChildText(1,list.desc)
local canJump=jump~=nil
local unLock=self:checkGainIsUnLock(list)
item:SetChildActive(2,not unLock)
item:SetChildActive(3,canJump and unLock)
item:SetChildButtonClick(3,function(...)
jumpManager:jump(jump)
end)
end
end


function UIZongmenExpGainWin:onHide()

end

function UIZongmenExpGainWin:checkGainIsUnLock(v)
local sysid=v.sysid
local lv=v.lv
if sysid then
if not systemModel.isOpen(sysid)then
return false
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false
end
end
return true
end

function UIZongmenExpGainWin:getExpGainList()
local config=moneyModel.getMoneyConfig(self.money)
local produce=config.produce
local list=table.deepCopy(produce)
for i,v in ipairs(list)do
v.sortTag=i
local unLock=self:checkGainIsUnLock(v)
if not unLock then
v.sortTag=i+10000
end
end
table.sort(list,function(a,b)return a.sortTag<b.sortTag end)
return list
end

function UIZongmenExpGainWin:onClickItemCallback(clickcount,index)
local showList=self:getExpGainList()
local list=showList[index+1]
local unLock=self:checkGainIsUnLock(list)
if not unLock then
UIManager.error('未解锁')
end
end



function UIZongmenExpGainWin:onClickClose()
self:closeSelf()
end