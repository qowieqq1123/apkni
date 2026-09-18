







def_class("UIXianMengInviteWin",UIWindowBase)









function UIXianMengInviteWin:bindComponents()

self.xmListPanel=UIObject.get(self,0)



end


function UIXianMengInviteWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.xmListPanel);self.xmListPanel=nil;
end

















function UIXianMengInviteWin:onLoaded(...)
self:bindComponents()
end


function UIXianMengInviteWin:__delete()
self:unbindComponents()
end


function UIXianMengInviteWin:onHide()

end




function UIXianMengInviteWin:onShow(argtable,afterOnloaded)
if self.xmDataList==nil then
self.xmDataList=xianmengModel:getInvitationList()
self:refreshView()
end
end

function UIXianMengInviteWin:refreshView()
local c=#self.xmDataList
self.xmListPanel:setChildScrollViewCreateGrids(c,1)

local grids=self.xmListPanel:getChildScrollViewItemWidgets()
for i=1,c do
self:refreshXMItem(grids[i-1],i)
end
end

function UIXianMengInviteWin:refreshXMItem(item,index)
if item==nil then
item=self.xmListPanel:getChildScrollViewItemWidget(index-1)
end

local data=self.xmDataList[index]

local image=xianmengModel.splitGuildIcon(data.guildicon)
local abname=globalABLookup.xianmengicons

item:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

item:SetChildText(4,data.guildname)

item:SetChildText(5,data.guildlevel)

item:SetChildText(6,data.invitename)

item:SetChildButtonClick(0,function()
self:onItemClick(index)
end)
item:SetChildButtonClick(7,function()
self:onCommitClick(index)
end)
item:SetChildButtonClick(8,function()
self:onCancelClick(index)
end)
end

function UIXianMengInviteWin:onItemClick(index)
local data=self.xmDataList[index]
local guildid=data.guildid

xianmengController:openXMDetailInfoWin(guildid)
end

function UIXianMengInviteWin:onCommitClick(index)
local data=self.xmDataList[index]
local guildid=data.guildid




local func=function()
if self and not self.isClose then
xianmengController:reqHandelXMRequir(guildid,2)
end
end
xianmengController:checkFreeCDTimes(func)


end

function UIXianMengInviteWin:onCancelClick(index)
local data=self.xmDataList[index]
local guildid=data.guildid

xianmengController:reqHandelXMRequir(guildid,-2)
end

function UIXianMengInviteWin:onAllCancelBtn()
if#self.xmDataList>0 then
xianmengController:reqHandelXMRequir(int64.new('0'),-2)
self:closeSelf()
end
end

function UIXianMengInviteWin:rec_refresh()
self.xmDataList=xianmengModel:getInvitationList()
self:refreshView()
end