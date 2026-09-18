







def_class("UITipTextMoney",UIWindowBase)









function UITipTextMoney:bindComponents()

self.panel=UIObject.get(self,0)



end


function UITipTextMoney:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.panel);self.panel=nil;
end
















local this
local isDelayList={}
local playDataList={}
local waitIndexList={}

local CmpInfoItemIndex={
root=0,
icon=1,
text=2,
}




function UITipTextMoney:onLoaded(...)
self:bindComponents()
end


function UITipTextMoney:__delete()
self:unbindComponents()
end




function UITipTextMoney:onShow(argtable,afterOnloaded)
this=self
self:refresh()
end

function UITipTextMoney:refresh()
for k,v in pairs(moneySystem.moneyList)do
if not isDelayList[k]then
self:refreshDelay(k)
end
end
end

function UITipTextMoney:refreshDelay(moneyType)
if not waitIndexList[moneyType]then
waitIndexList[moneyType]=0
end
if moneySystem.moneyList[moneyType][waitIndexList[moneyType]+1]~=nil then
isDelayList[moneyType]=true
waitIndexList[moneyType]=waitIndexList[moneyType]+1
local data=table.deepCopy(moneySystem.moneyList[moneyType][waitIndexList[moneyType]])
this:refreshInfoList(data)
moneySystem.moneyList[moneyType][waitIndexList[moneyType]].isAnimEnd=true
this:delayDo(0.2,function()this:refreshDelay(moneyType)end)
else
isDelayList[moneyType]=false
end
end

function UITipTextMoney:refreshInfoList(data)
local item
local curIndex
for i=1,#playDataList do
if playDataList[i].isAnimEnd then
curIndex=i
playDataList[curIndex]=data
item=self.panel:getChildLayoutGroupGridItem(curIndex-1)
break
end
end
if not curIndex then
playDataList[#playDataList+1]=data
end

if not curIndex then
this.panel:setChildLayoutGroupCreateItems(#playDataList,function(index)
this:refreshInfoItem(index,playDataList[index],#playDataList==index)
end)
elseif not item then
this.panel:setChildLayoutGroupCreateItems(#playDataList,function(index)
this:refreshInfoItem(index,playDataList[index],curIndex==index)
end)
else
this:refreshInfoItem(curIndex,playDataList[curIndex],true)
end
end

function UITipTextMoney:refreshInfoItem(index,data,isPlay)
local item=this.panel:getChildLayoutGroupGridItem(index-1)

if data and isPlay then
item:SetChildIcon(CmpInfoItemIndex.icon,data.icon,false)
item:SetChildText(CmpInfoItemIndex.text,data.text)

if data.pos then
item:SetChildPosition(CmpInfoItemIndex.root,data.pos)
end

local curPos=item:GetChildPosition(CmpInfoItemIndex.root)
item:SetChildLocalPosY(CmpInfoItemIndex.root,curPos.y-125)
item:SetChildCanvasGroupAlpha(CmpInfoItemIndex.root,0)

local func1=function()
playDataList[index].isAnimEnd=true
this:closeMoneyTips()
end
local tweener=item:SetChildDOLocalMoveY(CmpInfoItemIndex.root,curPos.y,0.6,func1)
tweener:SetEase(_Ease.Linear)
local tweener1=item:SetChildCanvasGroupDOFade(CmpInfoItemIndex.root,1,0.15)
tweener1:SetEase(_Ease.Linear)
local func2=function()
local tweener2=item:SetChildCanvasGroupDOFade(CmpInfoItemIndex.root,0,0.3)
tweener2:SetEase(_Ease.Linear)
end
self:delayDo(0.3,func2)
end
end

function UITipTextMoney:closeMoneyTips()
local isAllClose=true
for k,v in ipairs(playDataList)do
if not v.isAnimEnd then
isAllClose=false
break
end
end
for k,v in pairs(moneySystem.moneyList)do
local isClose=true
for kk,vv in ipairs(v)do
if not isClose or not vv.isAnimEnd then
isClose=false
isAllClose=false
break
end
end
if isClose then
waitIndexList[k]=0
moneySystem.moneyList[k]={}
end
end
if isAllClose then
waitIndexList={}
playDataList={}
moneySystem.moneyList={}
UIManager:closeWindow('UITipTextMoney')
end
end


function UITipTextMoney:onHide()

end



