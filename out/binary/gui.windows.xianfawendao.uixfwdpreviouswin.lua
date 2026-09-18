







def_class("UIXFWDPreviousWin",UIWindowBase)









function UIXFWDPreviousWin:bindComponents()

self.noSanJia=UIObject.get(self,0)
self.scrollerView=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.gridContent=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXFWDPreviousWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noSanJia);self.noSanJia=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gridContent);self.gridContent=nil;
end



















function UIXFWDPreviousWin:onLoaded(...)
self:bindComponents()
end


function UIXFWDPreviousWin:__delete()
self:unbindComponents()
end




function UIXFWDPreviousWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UIXFWDPreviousWin:getDatas()
local datas=UIXianFaWenDaoControl:getPreviousData()or{}
local list={}
for i,v in ipairs(datas)do
local sdata={session=v.session}
if v.list then
local ldata
for ii,vv in ipairs(v.list)do
if vv.rank==1 then
ldata={}
table.insert(sdata,ldata)
end
table.insert(ldata,vv)
end
end
table.insert(list,sdata)
end
table.sort(list,function(a,b)
return a.session>b.session
end)
return list
end

function UIXFWDPreviousWin:refresh()
local datas=self:getDatas()
local func=function(index)
local item=self.gridContent:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
item:SetChildText(0,FMT.fmt("第{0}届",data.session))
item:SetChildLayoutGroupCreateItems(1,#data,function(cIdx)
local childItem=item:GetChildLayoutGroupGridItem(1,cIdx-1)
self:refreshChildItem(childItem,data[cIdx])
end)
item:SetChildSizeDelta(2,1050,150+80*(#data-1))
end
local len=#datas
self.gridContent:setChildLayoutGroupCreateItems(len,func)
self.noSanJia:setActive(len==0)
end

local itemIndex={{0,1},{2,3},{4,5}}
function UIXFWDPreviousWin:refreshChildItem(item,data)
for i=1,3 do
local td=data[i]
if td then
local serverName=loginModel:getServerName(td.serverid)
item:SetChildText(itemIndex[i][2],FMT.fmt("[{0}]{1}",serverName,td.actorname))
else
item:SetChildText(itemIndex[i][2],"虚位以待")
end
end
end


function UIXFWDPreviousWin:onHide()

end





function UIXFWDPreviousWin:onCloseBtn()
self:closeSelf()
end

