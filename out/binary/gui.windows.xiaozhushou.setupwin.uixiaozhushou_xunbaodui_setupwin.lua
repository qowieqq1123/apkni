







def_class("UIXiaoZhuShou_XunBaoDui_SetupWin",UIWindowBase)









function UIXiaoZhuShou_XunBaoDui_SetupWin:bindComponents()

self.autoAddTili=UIToggleButton.get(self,0)
self.layout=UIObject.get(self,1)
self.root=UIObject.get(self,2)



end


function UIXiaoZhuShou_XunBaoDui_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.autoAddTili);self.autoAddTili=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIXiaoZhuShou_XunBaoDui_SetupWin:onLoaded(...)
self:bindComponents()
end


function UIXiaoZhuShou_XunBaoDui_SetupWin:__delete()
self:unbindComponents()
end




function UIXiaoZhuShou_XunBaoDui_SetupWin:onShow(argtable,afterOnloaded)
local setupData=xiaoZhuShouModel:getSetupData(XIAOZHUSHU_ENUM.xzs_Mmtxd)

local xbdResourcesPriority=setupData[xzsDataKey.xbdResourcesPriority]
local xbdTempResourcesPriority=table.weakCopy(xbdResourcesPriority)

setupData[xzsDataKey.xbdTempResourcesPriority]=xbdTempResourcesPriority

local len=#xbdResourcesPriority


self.layout:setChildLayoutGroupCreateItems(len,function(index)
local item=self.layout:getChildLayoutGroupGridItem(index-1)
local moneyid=xbdResourcesPriority[index]

item:SetChildText(0,index)

local moneyIconName=iconHelper.getIconName(moneyid)
item:SetChildIcon(1,moneyIconName,true)

local moneyName=itemsModel.getName(moneyid)
item:SetChildText(2,moneyName)

local isSelect=xbdResourcesPriority[index]~=nil
item:SetChildActive(3,isSelect)

local clickFunc=function()
local sIdx=table.findValue(xbdTempResourcesPriority,moneyid)
if sIdx then
item:SetChildActive(3,false)
item:SetChildActive(0,false)
table.remove(xbdTempResourcesPriority,sIdx)
else
table.insert(xbdTempResourcesPriority,moneyid)
item:SetChildActive(3,true)
item:SetChildActive(0,true)
item:SetChildText(0,#xbdTempResourcesPriority)
end


local grids=self.layout:getChildLayoutGroupGridList()
for gindex=1,grids.Count do
local gitem=grids[gindex-1]
local mid=xbdResourcesPriority[gindex]
local gidx=table.findValue(xbdTempResourcesPriority,mid)
if gidx then
gitem:SetChildText(0,gidx)
end
end
end
item:SetBaseItemClickEvent(-1,clickFunc)
end)

local xbdAutoRestoreCatTili=setupData[xzsDataKey.xbdAutoRestoreCatTili]
self.widget:SetChildToggle(self.autoAddTili:getID(),xbdAutoRestoreCatTili==1)
self.widget:SetChildToggleChange(self.autoAddTili:getID(),function(name,isOn,data)
setupData[xzsDataKey.xbdAutoRestoreCatTili]=isOn and 1 or 0
end)
end


function UIXiaoZhuShou_XunBaoDui_SetupWin:onHide()

end



