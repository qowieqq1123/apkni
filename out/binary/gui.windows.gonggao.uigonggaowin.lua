







def_class("UIGongGaoWin",UIWindowBase)









function UIGongGaoWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.itemList=UIObject.get(self,1)
self.content=UIText.get(self,2)
self.title=UIText.get(self,3)
self.checkText=UIText.get(self,4)
self.right=UIObject.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIGongGaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.checkText);self.checkText=nil;
_UIObject_release(self.right);self.right=nil;
end
















local itemCmp={
owner=-1,
select=0,
name=1,
}

local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool


function UIGongGaoWin:onLoaded(...)
self:bindComponents()
self.defaultIdx=1
end


function UIGongGaoWin:__delete()
self:unbindComponents()
self:stopCheckTimer()
end




function UIGongGaoWin:onShow(argtable,afterOnloaded)
local callback=function(isSuccess,...)
if not isSuccess then return end
if self and not self.isClose then
self:onfresh(isSuccess,...)
end
end
gonggaoControl.requestVersion(callback)
end


function UIGongGaoWin:onHide()

end




function UIGongGaoWin:onCloseBtn()
self:closeSelf()
pfCommonHelper.closeGongGao()
end

function UIGongGaoWin:onfresh(isSuccess,info)
if not isSuccess then return end
self:freshLeftList()
self:onSelect(self.defaultIdx)
end

function UIGongGaoWin:freshInfo()
self:freshLeftList()
self:freshRight()
end

function UIGongGaoWin:freshLeftList()
local dataList=gonggaoModel.getData()
local len=#dataList
self.itemList:setChildLayoutGroupCreateItems(len,function(idx)
local index=idx
local info=dataList[index]
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(itemCmp.select,self.selectIdx==index)
item:SetChildText(itemCmp.name,info.title)
item:SetChildButtonClickWithID(itemCmp.owner,function(...)
self:onSelect(...)
end,index)
end)
end

function UIGongGaoWin:onSelect(index)
if index==self.selectIdx then return end

local lastIdx=self.selectIdx
self.selectIdx=index


if lastIdx then
local item=self.itemList:getChildLayoutGroupGridItem(lastIdx-1)
if item then
item:SetChildActive(itemCmp.select,false)
end
end
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
if item then
item:SetChildActive(itemCmp.select,true)
end

self:freshRight()
end

function UIGongGaoWin:freshRight()
if self.selectIdx==nil then return end
local data=gonggaoModel.getDataByIndex(self.selectIdx)

if data~=nil then
local textViewWidth=self.right:getChildSizeDeltaX()
local checkStr=comHelper.getCheckLayoutStr(self.checkText:getGameObject(),textViewWidth,data.content)
self.content:setText(checkStr)
self.title:setText(data.title or'')
end
end



function UIGongGaoWin:openGMWindow()
if self.openGM==false then return end
self:startOutTimer()
local num=self.click1Num or 0
num=num+1
self.click1Num=num
if num>=9 then
self.openCommand1=true
self:startOut2Timer()
end
end

function UIGongGaoWin:openGMWindow2()
if not self.openCommand1 then return end
local num=self.click2Num or 0
num=num+1
self.click2Num=num
if num==3 then
self.openCommand=true
self:stopCheckTimer()
self.checkTime=self:delayDo(1,function()
if self.openCommand then
UIManager:showWindow("UICommandWin")
end
self:stopCheckTimer()
self.openGM=false

end,true)
elseif num>3 then
self.openCommand=false
self:stopCheckTimer()
end

end

function UIGongGaoWin:startOutTimer()
self:stopOutTimer()
self.outTime=self:delayDo(1,function()
self.click1Num=0

end)
end

function UIGongGaoWin:startOut2Timer()
if self.out2Time then return end
self.out2Time=self:delayDo(5,function()
if self.openCommand1 then
self.openCommand1=false
self.openGM=false
end

end)
end

function UIGongGaoWin:stopOutTimer()
if self.outTime then
self:stopTimerByID(self.outTime)
end
self.outTime=nil
end

function UIGongGaoWin:stopOut2Timer()
if self.out2Time then
self:stopTimerByID(self.out2Time)
end
self.out2Time=nil
end

function UIGongGaoWin:stopCheckTimer()
if self.checkTime then
self:stopTimerByID(self.checkTime)
end
self.checkTime=nil
end


function UIGongGaoWin:test_freshPage()
self.selectIdx=nil
self:freshLeftList()
self:onSelect(self.defaultIdx)
end
