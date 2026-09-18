
local xjEntityHud_lingshouGroup={}
local abname="ui/windows/xianjie/xianjietask_atlas_pak.ab"

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


function xjEntityHud_lingshouGroup:onInit()
local data=self.data
self.infoguid=data[1]
self.lsData=xianjieModel:getXJLingShouGroupData(self.infoguid)
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


function xjEntityHud_lingshouGroup:onCreateWidget(widget)
self:refreshInfo(widget)
end


function xjEntityHud_lingshouGroup:onRemoveWidget(widget)

end


function xjEntityHud_lingshouGroup:refreshInfo(widget)
widget=widget or self:getWidget()

local iconname=xjMonsterHUDBg[5]
widget:SetChildCSImageSprite(_widgtCmpIndex.flag,"ui/windows/xianjie/xianjiemain_hud_atlas_pak.ab",iconname)

local hpVal=self.lsData.hp/10000
widget:SetChildIconFillAmount(_widgtCmpIndex.hp,hpVal)
widget:SetChildText(_widgtCmpIndex.hptxt,string.format("%0.2f%%",hpVal*100))

self:refreshLeftTime(widget)

local xmData=xianjieModel:getXianMengData(self.lsData.ownerXMGuid)
if xmData then
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(_widgtCmpIndex.signIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(_widgtCmpIndex.signBGIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(_widgtCmpIndex.signKuangIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

local actorName=self.lsData.isMySelf and playerModel:getActorName()or otherPlayerModel:getActorData(self.data.ownerActorId).name
local name=FMT.fmt("<{0}>\n{1}",xmData and xmData.guildname or"",actorName)
widget:SetChildText(_widgtCmpIndex.infoName,name)
widget:SetChildButtonClick(_widgtCmpIndex.flag,function()
self:onClick()
end,true)
end

function xjEntityHud_lingshouGroup:refreshLeftTime(widget)
widget=widget or self:getWidget()
if widget==nil then return end
local expiresec=self.lsData.expiresec
if expiresec==nil or expiresec==0 then return end
local curTime=timeHelper.getServerShortTime()
local left=expiresec-curTime
local leftStr=timeHelper.format_time_stamp4(left)
widget:SetChildText(_widgtCmpIndex.leftTime,leftStr)
end

function xjEntityHud_lingshouGroup:onUpdate()
self:refreshLeftTime()
end

function xjEntityHud_lingshouGroup:onSelectHandle(widget,isSelected)
widget:SetChildActive(_widgtCmpIndex.layout,isSelected)
end

function xjEntityHud_lingshouGroup:onClick()
local infoguid=self.infoguid
xianjieController:openLingShouGroupInfoWin(infoguid)
end


function xjEntityHud_lingshouGroup:onDelete()

end

return xjEntityHud_lingshouGroup