









local _iconBg={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}
local _children={
nameTx=0,
xmBGIcon=1,
xmIcon=2,
xmKuangIcon=3,
headKuang=4,
icon=5,
monsterFlag=6,

reward=8,
namgBg=9,
}
local xjEntityHud_MoJiang={}


function xjEntityHud_MoJiang:onInit()
self.needFollow=true

local data=xianjieModel:getMoJiangEntity(self.data.seasonType,self.data.stageIndex,self.data.build_id)
local config=data:getCfg()
local tagOffset=config.clientParam.tagOffset
self.tagOffset={}
table.insert(self.tagOffset,tagOffset[1]and mathHelper.convertArrayToVector(tagOffset[1])or Vector3.zero)
table.insert(self.tagOffset,tagOffset[2]and mathHelper.convertArrayToVector(tagOffset[2])or Vector3.zero)
table.insert(self.tagOffset,tagOffset[3]and mathHelper.convertArrayToVector(tagOffset[3])or Vector3.zero)
self.uiOffset={}
table.insert(self.uiOffset,Vector2(0,0))
table.insert(self.uiOffset,Vector2(0,0))
table.insert(self.uiOffset,Vector2(0,0))

self.husParams=config.clientParam.hudParams
end


function xjEntityHud_MoJiang:onCreateWidget(widget)
widget:SetChildButtonClick(_children.headKuang,function()
self:onClick()
end)
self:refreshInfo(widget)
end


function xjEntityHud_MoJiang:onRemoveWidget(widget)

end

function xjEntityHud_MoJiang:onClick()
xianjieController:openMoJiangWin(self.data.seasonType,self.data.stageIndex,self.data.build_id)
end

function xjEntityHud_MoJiang:refreshInfo(widget)
widget=widget or self:getWidget()
if widget==nil then return end

local data=xianjieModel:getMoJiangEntity(self.data.seasonType,self.data.stageIndex,self.data.build_id)
local dead=data.killTime>0
local cfg=data:getCfg()
widget:SetChildActive(_children.monsterFlag,not dead)
widget:SetChildActive(_children.xmBGIcon,dead)
widget:SetChildActive(_children.headKuang,false)








if dead then
local image=data.bestGuild and data.bestGuild.guildIcon>0 and xianmengModel.splitGuildIcon(data.bestGuild.guildIcon)or xianmengModel.getDefualtGuildIamge()
local abname=globalABLookup.xianmengicons
widget:SetChildCSImageSprite(_children.xmIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
widget:SetChildCSImageSprite(_children.xmBGIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
widget:SetChildCSImageSprite(_children.xmKuangIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
widget:SetChildText(_children.nameTx,data.bestGuild and data.bestGuild.guildName~=""and data.bestGuild.guildName or"神秘仙盟")
else
widget:SetChildText(_children.nameTx,cfg.name)
end

local rewardReddot=data:checkRewardReddot()
widget:SetChildActive(_children.reward,rewardReddot)
end

return xjEntityHud_MoJiang