







def_class("UILDRongYuTongListWin",UIWindowBase)









function UILDRongYuTongListWin:bindComponents()

self.noSanJia=UIObject.get(self,0)
self.scrollerView=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.gridContent=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UILDRongYuTongListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noSanJia);self.noSanJia=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gridContent);self.gridContent=nil;
end



















function UILDRongYuTongListWin:onLoaded(...)
self:bindComponents()
lundaodahuiController.req_17_26()
notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
self:onRecv()
end)
end


function UILDRongYuTongListWin:__delete()
self:unbindComponents()
end




function UILDRongYuTongListWin:onShow(argtable,afterOnloaded)
self:onRecv()
end

function UILDRongYuTongListWin:onRecv()
local data=lundaodahuiModel:getTop3Data()
local func=function(idx)
local item=self.gridContent:getChildLayoutGroupGridItem(idx-1)
self:refreshItem(item,idx,data[idx])
end
for i,v in ipairs(data)do
local newSanJiaList=self:freshSanJiaList(v.sanjieList)
v.newSanJiaList=newSanJiaList
end
self.gridContent:setChildLayoutGroupCreateItems(#data,func)
self.noSanJia:setActive(#data==0)
end

function UILDRongYuTongListWin:refreshItem(item,idx,data)
local jieshu=data.jieshu
local sanjieList=data.newSanJiaList or{}
item:SetChildText(0,FMT.fmt("第{0}届",jieshu))
item:SetChildLayoutGroupCreateItems(1,#sanjieList,function(cIdx)
local childItem=item:GetChildLayoutGroupGridItem(1,cIdx-1)
self:refreshChildItem(childItem,cIdx,sanjieList[cIdx])
end)
item:SetChildSizeDelta(2,1050,150+80*(#sanjieList-1))
end

function UILDRongYuTongListWin:freshSanJiaList(sanjieList)
local list={}
if sanjieList then
local pos1Index=1
local pos2Index=1
local pos3Index=1
for i,v in ipairs(sanjieList)do
if v.pos==1 then
list[pos1Index]=list[pos1Index]or{}
table.insert(list[pos1Index],v)
pos1Index=pos1Index+1
elseif v.pos==2 then
list[pos2Index]=list[pos2Index]or{}
table.insert(list[pos2Index],v)
pos2Index=pos2Index+1
elseif v.pos==3 then
list[pos3Index]=list[pos3Index]or{}
table.insert(list[pos3Index],v)
pos3Index=pos3Index+1
end
end
end
return list
end

local itemIndex={{0,1},{2,3},{4,5}}
function UILDRongYuTongListWin:refreshChildItem(childItem,cIdx,newSanjieData)
if next(newSanjieData)then
local t={}
for i,v in ipairs(newSanjieData)do
t[v.pos]=v
end
for i=1,3 do
if t[i]then
local serverName=loginModel:getServerName(t[i].serverId)
local name=playerModel:getOtherActorName(t[i].name)
if t[i].name==nil or t[i].name==""then
childItem:SetChildText(itemIndex[i][2],FMT.fmt("[{0}]{1}",'未知区服',name))
else
childItem:SetChildText(itemIndex[i][2],FMT.fmt("[{0}]{1}",serverName,name))
end

else
childItem:SetChildText(itemIndex[i][2],"虚位以待")
end
end
end
end


function UILDRongYuTongListWin:onHide()

end





function UILDRongYuTongListWin:onCloseBtn()
self:closeSelf()
end

