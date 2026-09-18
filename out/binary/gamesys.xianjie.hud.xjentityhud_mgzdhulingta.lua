









local xjEntityHud_MGZDHuLingTa={}


function xjEntityHud_MGZDHuLingTa:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0)}
local data=self.data
self.buildID=data[1]
self.showOccupyList={}
end


function xjEntityHud_MGZDHuLingTa:onCreateWidget(widget)
return self:initShow(widget)
end


function xjEntityHud_MGZDHuLingTa:onRemoveWidget(widget)

end

function xjEntityHud_MGZDHuLingTa:initShow(widget)
widget:SetChildActive(2,false)


self:refreshXMName(widget)


widget:SetChildButtonClick(3,function()
return self:onClick()
end,true)
end

function xjEntityHud_MGZDHuLingTa:refreshXMName(widget)
local xyName="暂无归属"
local buildData=xianjieModel:getMGZDBuildServerData(self.buildID)

if buildData and mathHelper.validInt64(buildData.xmGuid)then
xyName=buildData.xmName
local isSelf=xianmengModel:compareTwoGuildID(xianmengModel:myXMGuildID(),buildData.xmGuid)
if isSelf then
xyName=FMT.cfmt(FONT_COLOR.eGreenColor,xyName)
else
xyName=FMT.cfmt(FONT_COLOR.eRedColor,xyName)
end
end
widget:SetChildText(0,xyName)
end


function xjEntityHud_MGZDHuLingTa:refreshInfo()
local widget=self:getWidget()
if widget then
self:refreshXMName(widget)
end
end

function xjEntityHud_MGZDHuLingTa:resetShow()
local widget=self:getWidget()
if widget then
return self:initShow(widget)
end
end

function xjEntityHud_MGZDHuLingTa:onClick()
if not self:checkWidget()then return end
xianjieController:openMGZDHuLingTaInfoWin(self.buildID)
end


function xjEntityHud_MGZDHuLingTa:onDelete()

end


function xjEntityHud_MGZDHuLingTa:onUpdate()
local widget=self:getWidget()
if widget then
self:refreshXMName(widget)
if self.isShowRankPanel then
self:refreshTime(widget)
end
end
end

return xjEntityHud_MGZDHuLingTa