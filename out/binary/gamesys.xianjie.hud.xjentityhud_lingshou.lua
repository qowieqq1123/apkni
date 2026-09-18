
local xjEntityHud_lingshou={}

local _widgtCmpIndex={
flag=0,
hp=1,
hpLayout=2,
hptxt=3,
infoLayout=4,
layout=5,
leftTime=6,
signBGIcon=7,
signIcon=8,
signKuangIcon=9,
itemLayout=10,
infoName=11,
}


function xjEntityHud_lingshou:onInit()
local data=self.data
self.infoguid=data[1]
self.lsData=xianjieModel:getXJLingShouData(self.infoguid)
local cfg=self.lsData:getCfg()
self.lsCfg=cfg
self.xjicontype=cfg.xjFilterType
self.needFollow=true

local uiOffset=cfg.uiOffset
local tagOffset=cfg.tagOffset
if uiOffset then
local ismulti=type(uiOffset[1])=='table'
self.uiOffset={}
if ismulti then
table.insert(self.uiOffset,Vector2(uiOffset[1][1],uiOffset[1][2]))
table.insert(self.uiOffset,Vector2(uiOffset[2][1],uiOffset[2][2]))
else
table.insert(self.uiOffset,Vector2(uiOffset[1],uiOffset[2]))
table.insert(self.uiOffset,Vector2(uiOffset[1],uiOffset[2]))
end
end
if tagOffset then
local ismulti=type(tagOffset[1])=='table'
self.tagOffset={}
if ismulti then
table.insert(self.tagOffset,Vector3(tagOffset[1][1],tagOffset[1][2],tagOffset[1][3]))
table.insert(self.tagOffset,Vector3(tagOffset[2][1],tagOffset[2][2],tagOffset[2][3]))
else
table.insert(self.tagOffset,Vector3(tagOffset[1],tagOffset[2],tagOffset[3]))
table.insert(self.tagOffset,Vector3(0,-tagOffset[2],0))
end
end
end


function xjEntityHud_lingshou:onCreateWidget(widget)
self:refreshInfo(widget)
end


function xjEntityHud_lingshou:onRemoveWidget(widget)

end


function xjEntityHud_lingshou:refreshInfo(widget)
widget=widget or self:getWidget()

local iconname=xjMonsterHUDBg[5]
widget:SetChildCSImageSprite(_widgtCmpIndex.flag,"ui/windows/xianjie/xianjiemain_hud_atlas_pak.ab",iconname)

widget:SetChildActive(_widgtCmpIndex.hpLayout,false)

self:refreshLeftTime(widget)

local xmData=xianjieModel:getXianMengData(self.lsData.ownerXMGuid)
if xmData then
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(_widgtCmpIndex.signIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(_widgtCmpIndex.signBGIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(_widgtCmpIndex.signKuangIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

local actorName="未知祖师"
if self.lsData.isMySelf then
actorName=playerModel:getActorName()
else
local zmData=xianjieModel:getZongMenData(self.lsData.ownerActorId)
if zmData then
actorName=zmData.actorname
end
end

local name=FMT.fmt("<{0}>\n{1}",xmData and xmData.guildname or"",actorName)
widget:SetChildText(_widgtCmpIndex.infoName,name)
widget:SetChildButtonClick(_widgtCmpIndex.flag,function()
self:onClick()
end,true)
end

function xjEntityHud_lingshou:refreshLeftTime(widget)
widget=widget or self:getWidget()
if widget==nil then return end
local expiresec=self.lsData.expiresec
if expiresec==nil or expiresec==0 then return end
local curTime=timeHelper.getServerShortTime()
local left=expiresec-curTime
local leftStr=timeHelper.format_time_stamp4(left)
widget:SetChildText(_widgtCmpIndex.leftTime,leftStr)
end

function xjEntityHud_lingshou:onUpdate()
self:refreshLeftTime()
end

function xjEntityHud_lingshou:onSelectHandle(widget,isSelected)
widget:SetChildActive(_widgtCmpIndex.layout,isSelected)
end

function xjEntityHud_lingshou:onClick()
local infoguid=self.infoguid
xianjieController:openLingShouInfoWin(infoguid)
end


function xjEntityHud_lingshou:onDelete()

end

return xjEntityHud_lingshou