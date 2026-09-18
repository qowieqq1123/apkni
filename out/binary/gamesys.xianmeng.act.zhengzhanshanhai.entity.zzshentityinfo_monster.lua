









local zzshEntityInfo_monster={}


function zzshEntityInfo_monster:onInit()
self:refreshLocalPos()
local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
local cfg=qbData:getCfg()
self.m_radius=cfg.radius
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
self.m_radius_l=baseCfg.gw*self.m_radius
self.m_rect={self.l_x-self.m_radius_l,self.l_y-self.m_radius_l,self.l_x+self.m_radius_l,self.l_y+self.m_radius_l}
self.fightEffect=cfg.fightEffect
end

function zzshEntityInfo_monster:containKey(key)
return self.data.guid==key
end

function zzshEntityInfo_monster:refreshLocalPos()
local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
self.g_x=qbData.x
self.g_y=qbData.y
local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(self.g_x,self.g_y)
self.l_x=l_x
self.l_y=l_y
end


function zzshEntityInfo_monster:checkInAOI(x1,y1,x2,y2)
if self.m_radius_l>0 then

return mathHelper.circleCrashRect(self.l_x,self.l_y,self.m_radius_l,x1,y1,x2,y2)
else

return mathHelper.posInRect(self.l_x,self.l_y,x1,y1,x2,y2)
end
end

function zzshEntityInfo_monster:getBGIconName(lv)
local abname=globalABLookup.zzshicons
local iconname=FMT.fmt('image_shanhaisjysui_{0}',lv)
return abname,iconname
end


function zzshEntityInfo_monster:onCreate(widget)
widget:SetChildLocalPos(-1,self.l_x,self.l_y,0)
local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then



return
end
local cfg=qbData:getCfg()

local monsterGroupId=cfg.monster[1]
local modelParams=comHelper.getMonsterGroupModelParams(monsterGroupId)
local size=cfg.modelSet[1]
local flipX=cfg.modelSet[2]==1
widget:SetChildUIModelShowTarget(0,modelParams.body,size,modelParams.componets,eAnimationID.stand)
widget:SetChildUIModelShowFlipX(0,flipX)
widget:SetChildLocalPos(0,cfg.modelSet[3][1],cfg.modelSet[3][2],0)

widget:SetChildButtonClick(1,function()
self:onClick()
end)
widget:SetChildSizeDelta(1,cfg.modelSet[4][1],cfg.modelSet[4][2])

widget:SetChildCanvas(2,self.sortLayer,self.sortOrder)

local uiOffset=cfg.uiOffset
widget:SetChildLocalPos(3,uiOffset[1],uiOffset[2],0)
local abname,iconname=self:getBGIconName(cfg.stage)
widget:SetChildCSImageSprite(3,abname,iconname)
widget:SetChildButtonClick(3,function()
self:onClick()
end)

widget:SetChildText(4,cfg.stage)

local name_str=qbData:getColorName()
widget:SetChildText(5,name_str)

local xmData=qbData:getXM()
local hasXM=xmData~=nil
widget:SetChildActive(6,hasXM)
if hasXM then
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(7,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(6,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(8,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

widget:SetChildActive(9,false)


if self.fightEffect~=nil then
local teamData=zhengzhanshanhaiModel:getMyPvETeam(guid,zhengzhanshanhaiModel.qbType.eMonster)
if teamData then
if zhengzhanshanhaiModel:checkPvETeamInFight(teamData)then
self:activeFightEffect(widget)
end
end
end





end


function zzshEntityInfo_monster:refreshUIScale(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local scale=self.objScale
local scale_=Vector3(scale,scale,1)
widget:SetChildScale(-1,scale_)








end

function zzshEntityInfo_monster:activeTitle(flag)
if self.m_ojbGuid==nil then return end
local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then return end
local widget=self:getWidget()
if widget==nil then return end

local isshow=flag
local detail=qbData.detail
if isshow then
if detail==nil or detail.rankNum<=0 then
isshow=false
end
end
widget:SetChildActive(9,isshow)
if isshow then
local cfg=qbData:getCfg()
local uiOffset_boss=cfg.uiOffset_boss or{0,0}
widget:SetChildLocalPos(9,uiOffset_boss[1],uiOffset_boss[2],0)
widget:SetChildCSImageSprite(9,globalABLookup.zzshicons,'image_shanhaisjui_21')
local data=detail.ranklist[1]

local serverName=loginModel:getServerName(data.serverid)
widget:SetChildText(10,FMT.fmt('[{0}]',serverName))

widget:SetChildText(11,data.guildname)
end
end

function zzshEntityInfo_monster:onMyClick()
local guid=self.data.guid
if UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','checkInSignRecordModel')then
local data={x=self.g_x,y=self.g_y}
data.guid=guid
data.entityType=self.entityType
UIManager:showWindow('UIXM_ZZSH_posInfoWin',data)
else
zhengzhanshanhaiModel:checkQingBaoDetail(guid)
end
end



function zzshEntityInfo_monster:activeFightEffect(widget)
if self.m_ojbGuid==nil then return end
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
if self.fightEffect==nil then return end

if self.fightEffectTime==nil then
self.fightEffectTime=Time.realtimeSinceStartup+self.fightEffect[7]
self.fightAttactTime=Time.realtimeSinceStartup+self.fightEffect[2]
if self.fightSpine==nil then
local modelID=self.fightEffect[3]
local size=self.fightEffect[5]
self.fightSpine=modelID
widget:SetChildUIModelShowTarget(12,modelID,size,{},eAnimationID.stand,false,false,0,nil)
widget:SetChildLocalPos(12,self.fightEffect[6][1],self.fightEffect[6][2],0)
widget:SetChildModelAnimationState(0,self.fightEffect[1])
local flipX
if self.fightEffect[4]==0 then
flipX=false
else
flipX=true
end
widget:SetChildUIModelShowFlipX(12,flipX)
end
else
self.fightEffectTime=Time.realtimeSinceStartup+self.fightEffect[7]

end
end

function zzshEntityInfo_monster:checkInFight()
return self.fightEffectTime~=nil
end

function zzshEntityInfo_monster:refreshFightEffect(widget)
if Time.realtimeSinceStartup>=self.fightAttactTime then
self.fightAttactTime=Time.realtimeSinceStartup+self.fightEffect[2]
widget:SetChildModelAnimationState(0,self.fightEffect[1])
end
end

function zzshEntityInfo_monster:clearFightEffect(widget)
if self.fightSpine~=nil then
self.fightSpine=nil
widget:SetChildUIModelRemoveTarget(12)
end
self.fightEffectTime=nil
self.fightAttactTime=nil
end




function zzshEntityInfo_monster:onReleaseWidget(widget)
self:clearFightEffect(widget)
end


function zzshEntityInfo_monster:leaveAOI()
if self.data~=nil then
local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
zhengzhanshanhaiModel:delEntityNow(self.m_ojbID)
end
end
end


function zzshEntityInfo_monster:onUpdate()
if self.data==nil then return end

local widget=self:getWidget()
if widget==nil then return end
if self.fightEffectTime then
if Time.realtimeSinceStartup>=self.fightEffectTime then
self:clearFightEffect(widget)

local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
zhengzhanshanhaiModel:delEntityNow(self.m_ojbID)
return
end
else
self:refreshFightEffect(widget)
end
end
end


function zzshEntityInfo_monster:onDelete()

end

return zzshEntityInfo_monster
