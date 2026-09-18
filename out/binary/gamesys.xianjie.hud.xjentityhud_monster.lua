









local xjEntityHud_monster={}


function xjEntityHud_monster:onInit()
local data=self.data
self.infoguid=data[1]
self.isSpine=self.data.isHudSpine
self.monsterData=xianjieModel:getMonsterData(self.infoguid)
local cfg=self.monsterData:getCfg()
self.monsterCfg=cfg
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
if uiOffset[3]then
table.insert(self.uiOffset,Vector2(uiOffset[3][1],uiOffset[3][2]))
else
table.insert(self.uiOffset,Vector2(0,0))
end
if uiOffset[4]then
table.insert(self.uiOffset,Vector2(uiOffset[4][1],uiOffset[4][2]))
else
table.insert(self.uiOffset,Vector2(0,0))
end
if uiOffset[5]then
table.insert(self.uiOffset,Vector2(uiOffset[5][1],uiOffset[5][2]))
else
table.insert(self.uiOffset,Vector2(0,0))
end
if uiOffset[6]then
table.insert(self.uiOffset,Vector2(uiOffset[6][1],uiOffset[6][2]))
else
table.insert(self.uiOffset,Vector2(0,0))
end
else
table.insert(self.uiOffset,Vector2(uiOffset[1],uiOffset[2]))
table.insert(self.uiOffset,Vector2(uiOffset[1],uiOffset[2]))
table.insert(self.uiOffset,Vector2(uiOffset[1],uiOffset[2]))
table.insert(self.uiOffset,Vector2(uiOffset[1],uiOffset[2]))
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
if tagOffset[3]then
table.insert(self.tagOffset,Vector3(tagOffset[3][1],tagOffset[3][2],tagOffset[3][3]))
else
table.insert(self.tagOffset,Vector3(0,0,0))
end
if tagOffset[4]then
table.insert(self.tagOffset,Vector3(tagOffset[4][1],tagOffset[4][2],tagOffset[4][3]))
else
table.insert(self.tagOffset,Vector3(0,0,0))
end
if tagOffset[5]then
table.insert(self.tagOffset,Vector3(tagOffset[5][1],tagOffset[5][2],tagOffset[5][3]))
else
table.insert(self.tagOffset,Vector3(0,0,0))
end
if tagOffset[6]then
table.insert(self.tagOffset,Vector3(tagOffset[6][1],tagOffset[6][2],tagOffset[6][3]))
else
table.insert(self.tagOffset,Vector3(0,0,0))
end
else
table.insert(self.tagOffset,Vector3(tagOffset[1],tagOffset[2],tagOffset[3]))
table.insert(self.tagOffset,Vector3(0,-tagOffset[2],0))
table.insert(self.tagOffset,Vector3(0,-tagOffset[2],0))
table.insert(self.tagOffset,Vector3(0,-tagOffset[2],0))
table.insert(self.tagOffset,Vector3(tagOffset[1],tagOffset[2],tagOffset[3]))
table.insert(self.tagOffset,Vector3(tagOffset[1],tagOffset[2],tagOffset[3]))
end
end
end


function xjEntityHud_monster:onCreateWidget(widget)
if self:isPlayCreatSpine()then
widget:SetChildActive(-1,false)
else
widget:SetChildActive(-1,true)
end
if self.monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Small or
self.monsterData.entitytype==xjServerEnityType.eMoJieMoZong_Big then
widget:SetChildActive(0,false)
widget:SetChildActive(4,false)
return
end
widget:SetChildActive(0,true)
local cfg=self.monsterCfg
local type=cfg.type or 1
local stage=cfg.stage or 1

local stage_str=FMT.fmt('{0}阶',stage)

local abname=globalABLookup.xjhudicons
local iconname=xjMonsterHUDBg[type]

if not self:isHideStage()then
widget:SetChildCSImageSprite(0,abname,iconname)
widget:SetChildText(1,stage_str)
else
widget:SetChildActive(0,false)
widget:SetChildText(1,'')
end
widget:SetChildButtonClick(0,function()
self:onClick()
end)











widget:SetChildActive(2,cfg.flag==1)
widget:SetChildActive(3,cfg.flag==2)
if self:isSpeTimeBg()then
if self.monsterData.expiresec then
widget:SetChildActive(10,self.monsterData.expiresec>0)
else
widget:SetChildActive(10,false)
end
widget:SetChildActive(4,false)
else
widget:SetChildActive(10,false)
if self.monsterData.expiresec then
widget:SetChildActive(4,self.monsterData.expiresec>0)
else
widget:SetChildActive(4,false)
end
end
self:isGuiShuBg(widget,self.monsterData)
self:isGuiShuBg2(widget,self.monsterData)
self:isShowTagBg(widget)
self:isShowSGShield(widget)

widget:SetChildActive(21,false)

local isZhenYan=false
if isZhenYan then
self:refreshFaZe(widget)
end
end

function xjEntityHud_monster:onUpdate()
local data=self.monsterData
local widget=self:getWidget()
if self:isSpeTimeBg()then
if widget and data and data.expiresec and data.expiresec>0 then
local nowTime=timeHelper.getServerShortTime()
local least=math.max(data.expiresec-nowTime,0)
local timeStr=FMT.fmt("<color=#aae252>{0}</color>后消失",timeHelper.format_time_stamp3(least))
widget:SetChildText(11,timeStr)
end
else
if widget and data and data.expiresec and data.expiresec>0 then
local nowTime=timeHelper.getServerShortTime()
local least=math.max(data.expiresec-nowTime,0)
local timeStr=FMT.fmt("{0}<color=#76D81E>后消失</color>",timeHelper.format_time_stamp3(least))
widget:SetChildText(5,timeStr)
end
end
end


function xjEntityHud_monster:onRemoveWidget(widget)
widget:SetChildIcon(0,'',false)
self.isSpine=false
end

function xjEntityHud_monster:onClick()
if not self:checkWidget()then return end
local infoguid=self.infoguid
xianjieController:openMonsterInfoWin(infoguid)
end

function xjEntityHud_monster:onSelectHandle(widget,isSelect)
if not widget then
return
end
if self.monsterData.entitytype~=xjServerEnityType.eMoJieMoZong_Small and
self.monsterData.entitytype~=xjServerEnityType.eMoJieMoZong_Big and
self.monsterData.entitytype~=xjServerEnityType.eMoJieZhenYan_Small and
self.monsterData.entitytype~=xjServerEnityType.eMoJieZhenYan_Big and
self.monsterData.entitytype~=xjServerEnityType.eMoJieZhenYan_Spe
then
widget:SetChildActive(6,false)
else


if widget and isSelect then
widget:SetChildActive(6,true)


local shield=self.monsterData.shield
local const_def=self.monsterData:getConstDefCfg()
local maxShield=const_def.shield[1]
local _shield=shield/maxShield*100
_shield=string.format("%.2f",_shield)
widget:SetChildText(9,FMT.fmt("{0}%",_shield))
widget:SetChildUIProgressbar(7,shield,maxShield,false)
else
widget:SetChildActive(6,false)
end
end


local isZhenYan=false
if isZhenYan and isSelect then
widget:SetChildActive(21,true)
else
widget:SetChildActive(21,false)
end
end

function xjEntityHud_monster:isHideStage()
if self.monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster or
self.monsterData.entitytype==xjServerEnityType.eMoJieBox or
self.monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Small or
self.monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Big or
self.monsterData.entitytype==xjServerEnityType.eMoJieZhenYan_Spe or
self.monsterData.entitytype==xjServerEnityType.eMoJieMoJunYaoMo then
return true
end




return false
end


function xjEntityHud_monster:refreshInfo()
local widget=self:getWidget()
if widget then
self:isShowSGShield(widget)
end
end

function xjEntityHud_monster:isSpeTimeBg()
if self.monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster or
self.monsterData.entitytype==xjServerEnityType.eMoJieBox then
return true
end
return false
end

function xjEntityHud_monster:isGuiShuBg(widget,monsterData)
widget:SetChildActive(12,false)
if monsterData and monsterData.entitytype==xjServerEnityType.eMoJieBox then
local xmId=monsterData.owner_guild_id
local xmName_str=monsterData.guildname or''
if xmId then
local xmData=xianjieModel:getXianMengData(xmId)
local hasXM=xmData~=nil
widget:SetChildActive(12,hasXM)
if hasXM then
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(16,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(14,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(15,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))





else
xmName_str='无'
end
widget:SetChildText(13,xmName_str)
end
end
end

function xjEntityHud_monster:isGuiShuBg2(widget,monsterData)
widget:SetChildActive(25,false)
if monsterData and monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then
local xmId=monsterData.owner_guild_id
local xmName_str=monsterData.owner_guild_name or''
local owner_actor_name=monsterData.owner_actor_name or''
if xmId then
local xmData=xianjieModel:getXianMengData(xmId)
local hasXM=xmData~=nil
widget:SetChildActive(25,hasXM)
if hasXM then
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(28,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(26,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(27,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
xmName_str='无'
end
widget:SetChildText(29,FMT.fmt('【{0}】',xmName_str))
widget:SetChildText(30,owner_actor_name)
end
end
end

function xjEntityHud_monster:isShowTagBg(widget)
widget:SetChildActive(17,false)
if self.monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then
local abname='ui/windows/mojiejieduansan/mojiejieduansan_atlas_pak.ab'
widget:SetChildCSImageSprite(17,abname,'image_shanggumohun_2')
widget:SetChildActive(17,true)
widget:SetChildButtonClick(17,function()
self:onClick()
end)
elseif self.monsterData.entitytype==xjServerEnityType.eMoJieBox then
local abname='ui/windows/mojiejieduansan/mojiejieduansan_atlas_pak.ab'
widget:SetChildCSImageSprite(17,abname,'image_shanggumohun_1')
widget:SetChildActive(17,true)
widget:SetChildButtonClick(17,function()
self:onClick()
end)
end
end

function xjEntityHud_monster:isShowSGShield(widget)
if self.monsterData.entitytype==xjServerEnityType.eMoJieShangGuMoster then
local monsterData=xianjieModel:getMonsterData(self.infoguid)
local shield=monsterData.curr_hp
local maxShield=monsterData.max_hp

if shield and maxShield then
widget:SetChildActive(18,true)
shield=mathHelper.int64_to_number(shield)
maxShield=mathHelper.int64_to_number(maxShield)

local _shield=(shield/maxShield)*100
if _shield>0 and _shield<0.01 then
_shield=0.01
end
_shield=string.format("%.2f",_shield)
widget:SetChildText(20,FMT.fmt("{0}%",_shield))
widget:SetChildUIProgressbar(18,shield,maxShield,false)
end
else
widget:SetChildActive(18,false)
end
end

function xjEntityHud_monster:refreshFaZe(widget)
self.monsterData=xianjieModel:getMonsterData(self.infoguid)
local cfg=self.monsterData:getCfg()
if cfg==nil or cfg.faze==nil then return end
local faze=cfg.faze[1]
local fazeID=faze[1]
local fazeLv=faze[2]

local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local descparm=fazeCfg.descparm
local name=fazeCfg.name
local icon=fazeCfg.image
local desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc

widget:SetChildIcon(22,icon,false)
widget:SetChildText(24,name)
widget:SetChildText(23,desc)
end



function xjEntityHud_monster:isPlayCreatSpine()
if self.isSpine then
return true
end
end

return xjEntityHud_monster