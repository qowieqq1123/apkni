









local zzshEntityInfo_lingdi={}


function zzshEntityInfo_lingdi:onInit()
local cfgID=self.data.cfgID
local ldData=zhengzhanshanhaiModel:getLDData(cfgID)
self.m_radius=ldData.radius
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
self.m_radius_l=baseCfg.gw*self.m_radius

local cfg=zhengzhanshanhaiModel:getLingDiCfg(cfgID)
self.fightEffect=cfg.fightEffect
self.targetid_str=tostring(-cfgID)
self:refreshLocalPos(ldData)
self.m_rect={self.l_x-self.m_radius_l,self.l_y-self.m_radius_l,self.l_x+self.m_radius_l,self.l_y+self.m_radius_l}
end


function zzshEntityInfo_lingdi:refreshLocalPos(ldData)
self.g_x=ldData.x
self.g_y=ldData.y
local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(self.g_x,self.g_y)
self.l_x=l_x
self.l_y=l_y
end

function zzshEntityInfo_lingdi:containKey(key)
return self.data.cfgID==key
end


function zzshEntityInfo_lingdi:checkInAOI(x1,y1,x2,y2)

return mathHelper.circleCrashRect(self.l_x,self.l_y,self.m_radius_l,x1,y1,x2,y2)
end


function zzshEntityInfo_lingdi:onCreate(widget)
widget:SetChildLocalPos(-1,self.l_x,self.l_y,0)
local cfgID=self.data.cfgID
local cfg=zhengzhanshanhaiModel:getLingDiCfg(cfgID)

self:changeXM(widget)

widget:SetChildShowEffectEx(1,cfg.effectSet[1],self.sortLayer,self.sortOrder2-1,true)
widget:SetChildLocalPos(1,cfg.effectSet[3][1],cfg.effectSet[3][2],0)
local e_scale=cfg.effectSet[2]
widget:SetChildScale(1,Vector3(e_scale,e_scale,e_scale))

widget:SetChildButtonClick(3,function()
self:onClick()
end)
widget:SetChildSizeDelta(3,cfg.effectSet[4][1],cfg.effectSet[4][2])

widget:SetChildCanvas(4,self.sortLayer,self.sortOrder)

local uiOffset=cfg.uiOffset
widget:SetChildLocalPos(5,uiOffset[1],uiOffset[2],0)
widget:SetChildButtonClick(5,function()
self:onClick()
end)

widget:SetChildText(6,cfg.name)


if self.fightEffect~=nil then
local targetData=zhengzhanshanhaiModel:getpvpTargetData(self.targetid_str)
if targetData then
if targetData:checkInFight()then
self:activeFightEffect(widget)
end
end
end
end


function zzshEntityInfo_lingdi:refreshUIScale(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end

local scale=self.itemScale
local scale_=Vector3(scale,scale,1)
widget:SetChildScale(5,scale_)

if self.hasXM then
scale=self.objScale
scale_=Vector3(scale,scale,1)
widget:SetChildScale(11,scale_)
widget:SetChildScale(7,scale_)
end
end

function zzshEntityInfo_lingdi:getMyXMData()
local cfgID=self.data.cfgID
local xmData
if UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','isPvPWin',2)then
local targetData=zhengzhanshanhaiModel:getpvpTargetData(self.targetid_str)
if targetData then
local winner=targetData:findWinner()
if winner then
xmData=zhengzhanshanhaiModel:getXMData(winner)
end
end
end
if xmData==nil then
local ldData=zhengzhanshanhaiModel:getLDData(cfgID)
if ldData then
xmData=ldData:getXM()
end
end
return xmData
end

function zzshEntityInfo_lingdi:changeXM(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local xmData=self:getMyXMData()
local hasXM=xmData~=nil
self.hasXM=hasXM


local circleSize=self.m_radius*zhengzhanshanhaiModel.grid2CircleEffect
local circleEff
local isMy=false
if hasXM then
isMy=xmData:checkMyXM()
if isMy then
circleEff=10533
else
circleEff=10534
end
else
circleEff=10532
end
self.circleEff=circleEff
self.circleSize=circleSize
self:refreshCircleSign(widget)

local showXM=hasXM
widget:SetChildActive(2,showXM)
widget:SetChildActive(7,showXM)
if showXM then
local entSet=zhengzhanshanhaiController:getZZSHCfg('xmEntitySet')

local size=entSet[1]
widget:SetChildCSImageSprite(2,globalABLookup.zzshentityicons,'xm_1')
widget:SetChildScale(2,Vector3(size,size,size))
widget:SetChildLocalPos(2,entSet[2][1],entSet[2][2],0)

widget:SetChildLocalPos(8,entSet[4][1],entSet[4][2],0)

local name_str=xmData.guildname
name_str=string.addCharBetweenChars(name_str,'　',2)
widget:SetChildText(9,name_str)

widget:SetChildActive(10,isMy)
if isMy then
widget:SetChildLocalPos(10,entSet[5][1],entSet[5][2],0)
end
end
end

function zzshEntityInfo_lingdi:onMyClick()
if not UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','isPlayingWin')then
return
end
local cfgID=self.data.cfgID
if UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','checkInSignRecordModel')then
local data={x=self.g_x,y=self.g_y}
data.cfgID=cfgID
data.entityType=self.entityType
UIManager:showWindow('UIXM_ZZSH_posInfoWin',data)
else
if UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','isPvPWin',2)then
local targetData=zhengzhanshanhaiModel:getpvpTargetData(self.targetid_str)
if targetData and targetData:checkInFight()then
local idx=targetData:getShowIndex()
zhengzhanshanhaiModel:checkOpenPvPAttackDataWin(targetData.targetid,idx)
return
end
end

local ldData=zhengzhanshanhaiModel:getLDData(cfgID)
local hasXM=ldData and ldData:getXM()
if hasXM then
local l_x=self.l_x
local l_y=self.l_y
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',self.g_x,self.g_y,0,false,0,function()
local moveX,moveY=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','uiLocalPos2UIPos',l_x,l_y)
if moveX then
UIManager:showWindow('UIXM_ZZSH_ldSelectWin',{cfgID=cfgID,moveX=moveX,moveY=moveY})
end
end)
else
UIManager:showWindow('UIXM_ZZSH_lindiWin',{cfgID=cfgID})
end
end
end

function zzshEntityInfo_lingdi:refreshCircleSign(widget)
if self.m_ojbGuid==nil then return end
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local showCircle=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','checkInMoveModel')
if showCircle then
self.showCircle=true
widget:SetChildShowEffectEx(0,self.circleEff,self.sortLayer,self.sortOrder2-1,true)
widget:SetChildScale(0,Vector3(self.circleSize,self.circleSize,self.circleSize))
else
self.showCircle=nil
widget:SetChildShowEffect(0,0,false)
end
end




function zzshEntityInfo_lingdi:activeFightEffect(widget)
if self.m_ojbGuid==nil then return end
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
if self.fightEffect==nil then return end

if self.fightEffectTime==nil then
self.fightEffectTime=Time.realtimeSinceStartup+zhengzhanshanhaiModel.pvpFigthtInterval
if self.fightSpine==nil then
local modelID=self.fightEffect[1]
local size=self.fightEffect[3]
self.fightSpine=modelID
widget:SetChildUIModelShowTarget(12,modelID,size,{},eAnimationID.stand,false,false,0,nil)
widget:SetChildLocalPos(12,self.fightEffect[4][1],self.fightEffect[4][2],0)
local flipX
if self.fightEffect[2]==0 then
flipX=false
else
flipX=true
end
widget:SetChildUIModelShowFlipX(12,flipX)
end
else
self.fightEffectTime=Time.realtimeSinceStartup+zhengzhanshanhaiModel.pvpFigthtInterval
end
end

function zzshEntityInfo_lingdi:clearFightEffect(widget)
if self.fightSpine~=nil then
self.fightSpine=nil
widget:SetChildUIModelRemoveTarget(12)
end
self.fightEffectTime=nil
end




function zzshEntityInfo_lingdi:onReleaseWidget(widget)

widget:SetChildShowEffect(1,0,false)

widget:SetChildIcon(2,'',false)

if self.showCircle then
self.showCircle=nil
widget:SetChildShowEffect(0,0,false)
end
self:clearFightEffect(widget)
end


function zzshEntityInfo_lingdi:onUpdate()
if self.data==nil then return end

local widget=self:getWidget()
if widget==nil then return end
if self.fightEffectTime then
if Time.realtimeSinceStartup>=self.fightEffectTime then
self:clearFightEffect(widget)

self:changeXM(widget)
local cfgID=self.data.cfgID
UIManager:invokeUIMethod('UIXM_ZZSH_lindiWin','changeXM',cfgID)
end
end
end


function zzshEntityInfo_lingdi:onDelete()

end

return zzshEntityInfo_lingdi