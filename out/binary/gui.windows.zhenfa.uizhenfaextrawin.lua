







def_class("UIZhenFaExtraWin",UIWindowBase)









function UIZhenFaExtraWin:bindComponents()

self.rightBg=UIObject.get(self,0)
self.rightRoot=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.tab_1=UIButton.get(self,3)
self.tab_2=UIButton.get(self,4)
self.tabSelected_1=UIObject.get(self,5)
self.tabSelected_2=UIObject.get(self,6)
self.detailContent=UIObject.get(self,7)
self.background=UIButton.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tab_1:setButtonClick(function()self:onTab_1()end)

self.tab_2:setButtonClick(function()self:onTab_2()end)

self.background:setButtonClick(function()self:onBackground()end)
self.tab={
self.tab_1,
self.tab_2,
}
self.tabSelected={
self.tabSelected_1,
self.tabSelected_2,
}



end


function UIZhenFaExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rightBg);self.rightBg=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.tab_1);self.tab_1=nil;
_UIObject_release(self.tab_2);self.tab_2=nil;
_UIObject_release(self.tabSelected_1);self.tabSelected_1=nil;
_UIObject_release(self.tabSelected_2);self.tabSelected_2=nil;
_UIObject_release(self.detailContent);self.detailContent=nil;
_UIObject_release(self.background);self.background=nil;
self.tab=nil;
self.tabSelected=nil;
end
















local _this=nil
local itemCmp={
title=0,
content=1,
tips=2
}
local _selected=nil
local _animation=false
local delayAnimation=0.5



function UIZhenFaExtraWin:onLoaded(...)
self:bindComponents()
end


function UIZhenFaExtraWin:__delete()
self:unbindComponents()
_this=nil
_selected=nil
_animation=false
end




function UIZhenFaExtraWin:onShow(argtable,afterOnloaded)
self.zfId=argtable.zfId
self.zfLv=zhenfaModel:getZhenFaData(self.zfId)
self.totalLv=argtable.totalLv or-1
self.zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,self.zfId)

self.totalIdx={}
for i,v in pairs(self.zfCfg.buffdesc)do
table.insert(self.totalIdx,i)
end
table.sort(self.totalIdx)

self.totalCurrent=0
for i,v in ipairs(self.totalIdx)do
if v<=self.totalLv then
self.totalCurrent=i
else
break
end
end

self:onClickTab(1)

_animation=true
self.rightRoot:setChildCanvasGroupAlpha(0)
self.rightBg:setChildUIModelShowTarget(3037,1,{},100,false,false,0,function()
self.animationDelay=self:delayDo(delayAnimation,function()
self.winlua:SetChildCanvasGroupDOFade(self.rightRoot:getID(),1,0.5,function()
_animation=false
end)
end)
end)
end


function UIZhenFaExtraWin:onHide()
if self.animationDelay then
self:stopTimerByID(self.animationDelay)
self.animationDelay=nil
end
end




function UIZhenFaExtraWin:onCloseBtn()
if not _animation then
self:closeSelf()
end
end

function UIZhenFaExtraWin:onBackground()
if not _animation then
self:closeSelf()
end
end

function UIZhenFaExtraWin:onTab_1()
self:onClickTab(1)
end

function UIZhenFaExtraWin:onTab_2()
self:onClickTab(2)
end

function UIZhenFaExtraWin:onClickTab(index)
if _animation then return end
if index~=_selected then
if _selected then
self:showSelected(_selected,false)
end
_selected=index
self:showSelected(_selected,true)
self[FMT.fmt("refreshList_{0}",_selected)](self)
end
end

function UIZhenFaExtraWin:showSelected(index,show)
self.tabSelected[index]:setActive(show)
end

function UIZhenFaExtraWin:refreshList_1()
local count=#self.zfCfg.updesc
self.detailContent:setChildLayoutGroupCreateItems(count,function(index)
self:refreshListItem_1(index)
end)
self.detailContent:setChildAnchoredPosition(Vector2.zero)
self.winlua:ForceLayoutRect(self.detailContent:getID())
end

function UIZhenFaExtraWin:refreshList_2()
local count=#self.totalIdx
self.detailContent:setChildLayoutGroupCreateItems(count,function(index)
self:refreshListItem_2(index)
end)
self.detailContent:setChildAnchoredPosition(Vector2.zero)
self.winlua:ForceLayoutRect(self.detailContent:getID())
end

function UIZhenFaExtraWin:refreshListItem_1(index)
local descCfg=self.zfCfg.updesc[index]
local isCurrent=index==self.zfLv
local item=self.detailContent:getChildLayoutGroupGridItem(index-1)
local titleStr=FMT.fmt("阵法等级：{0}",index)
local contentTable={}
for i,v in ipairs(descCfg)do
table.insert(contentTable,FMT.fmt("{0}{1}",v[1],v[2]))
end
local contentStr=table.concat(contentTable,"\n")
item:SetChildActive(itemCmp.tips,isCurrent)
item:SetChildText(itemCmp.title,isCurrent and FMT.fmt("<color=#549327>{0}</color>",titleStr)or titleStr)
item:SetChildText(itemCmp.content,isCurrent and FMT.fmt("<color=#549327>{0}</color>",contentStr)or contentStr)
end

function UIZhenFaExtraWin:refreshListItem_2(index)
local level=self.totalIdx[index]
local descCfg=self.zfCfg.buffdesc[level]
local isCurrent=index==self.totalCurrent
local item=self.detailContent:getChildLayoutGroupGridItem(index-1)
local titleStr=FMT.fmt("队伍阵法等级：{0}",level)
local contentStr=table.concat(descCfg,"\n")
item:SetChildActive(itemCmp.tips,isCurrent)
item:SetChildText(itemCmp.title,isCurrent and FMT.fmt("<color=#549327>{0}</color>",titleStr)or titleStr)
item:SetChildText(itemCmp.content,isCurrent and FMT.fmt("<color=#549327>{0}</color>",contentStr)or contentStr)
end