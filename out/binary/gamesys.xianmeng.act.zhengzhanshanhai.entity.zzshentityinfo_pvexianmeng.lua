









local zzshEntityInfo_PvEXianMeng={}


function zzshEntityInfo_PvEXianMeng:onInit()
self.m_radius=1
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
self.m_radius_l=baseCfg.gw*self.m_radius
self:refreshLocalPos()
self.fightEffect=zhengzhanshanhaiController:getZZSHCfg('xmfightEffect')
local guid=self.data.guid
self.targetid_str=tostring(guid)
end


function zzshEntityInfo_PvEXianMeng:refreshLocalPos()
local guid=self.data.guid
local xmData=zhengzhanshanhaiModel:getXMData(guid)
self.g_x=xmData.x
self.g_y=xmData.y
local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(self.g_x,self.g_y)
self.l_x=l_x
self.l_y=l_y
self.m_rect={self.l_x-self.m_radius_l,self.l_y-self.m_radius_l,self.l_x+self.m_radius_l,self.l_y+self.m_radius_l}
end


function zzshEntityInfo_PvEXianMeng:onCreate(widget)
local guid=self.data.guid

widget:SetChildLocalPos(-1,self.l_x,self.l_y,0)
local entSet=zhengzhanshanhaiController:getZZSHCfg('xmEntitySet')

local size=entSet[1]
local hasLD=zhengzhanshanhaiModel:getLDDataByXM(guid)~=nil
local modelIcon=hasLD and'ft_1'or'xm_1'
widget:SetChildCSImageSprite(0,globalABLookup.zzshentityicons,modelIcon)
widget:SetChildScale(0,Vector3(size,size,size))
widget:SetChildLocalPos(0,entSet[2][1],entSet[2][2],0)

widget:SetChildButtonClick(1,function()
self:onClick()
end)
widget:SetChildSizeDelta(1,entSet[3][1],entSet[3][2])

widget:SetChildCanvas(2,self.sortLayer,self.sortOrder)
local xmData=zhengzhanshanhaiModel:getXMData(guid)

widget:SetChildLocalPos(3,entSet[4][1],entSet[4][2],0)
widget:SetChildButtonClick(3,function()
self:onClick()
end)

local name_str=xmData.guildname
name_str=string.addCharBetweenChars(name_str,'　',2)
widget:SetChildText(4,name_str)

local isMy=self:checkMyself()
widget:SetChildActive(5,isMy)
if isMy then
widget:SetChildLocalPos(5,entSet[5][1],entSet[5][2],0)
end


local size=zhengzhanshanhaiModel:getAttackRadius()*zhengzhanshanhaiModel.grid2CircleEffect
self.circleSize=size
self:refreshCircleSign(widget)

self:refreshFightSign(widget,xmData)


if self.fightEffect~=nil then
local targetData=zhengzhanshanhaiModel:getpvpTargetData(self.targetid_str)
if targetData then
if targetData:checkInFight()then
self:activeFightEffect(widget)
end
end
end
end


function zzshEntityInfo_PvEXianMeng:refreshUIScale(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local scale=self.objScale
local scale_=Vector3(scale,scale,1)
widget:SetChildScale(9,scale_)
widget:SetChildScale(2,scale_)








end

function zzshEntityInfo_PvEXianMeng:onRefresh()
self:refreshLocalPos()
if self.m_ojbGuid==nil then return false end
local widget=self.parent:GetChildExpandUIEx(self.m_ojbGuid)
if widget==nil then return false end

widget:SetChildLocalPos(-1,self.l_x,self.l_y,0)

local guid=self.data.guid
local hasLD=zhengzhanshanhaiModel:getLDDataByXM(guid)~=nil
local modelIcon=hasLD and'ft_1'or'xm_1'
widget:SetChildCSImageSprite(0,globalABLookup.zzshentityicons,modelIcon)

if self:checkMyself()then
self:refreshFightSign()
end
return true
end

function zzshEntityInfo_PvEXianMeng:checkMyself()
if self.isMyself==nil then
local guid=xianmengModel:myXMGuildID()
self.isMyself=mathHelper.compareInt64(guid,self.data.guid)
end
return self.isMyself
end


function zzshEntityInfo_PvEXianMeng:onReleaseWidget(widget)

widget:SetChildIcon(0,'',false)
if self.showFightSign then
self.showFightSign=nil
widget:SetChildIcon(7,'',false)
end

if self.showCircle then
self.showCircle=nil
widget:SetChildShowEffect(6,0,false)
end
self:clearFightEffect(widget)
end

function zzshEntityInfo_PvEXianMeng:onMyClick()
local guid=self.data.guid
if UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','checkInSignRecordModel')then
local data={x=self.g_x,y=self.g_y}
data.guid=guid
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
zhengzhanshanhaiController:openXMDetailInfoWin(guid)
end
end

function zzshEntityInfo_PvEXianMeng:refreshCircleSign(widget)
if self.m_ojbGuid==nil then return end
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local showCircle
if self:checkMyself()then
showCircle=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','checkInMoveModel2')
end
if showCircle then
self.showCircle=true
widget:SetChildShowEffectEx(6,10532,self.sortLayer,self.sortOrder2-1,true)
widget:SetChildScale(6,Vector3(self.circleSize,self.circleSize,self.circleSize))
else
self.showCircle=nil
widget:SetChildShowEffect(6,0,false)
end
end

function zzshEntityInfo_PvEXianMeng:refreshFightSign(widget,xmData)
if self.m_ojbGuid==nil then return end
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
if xmData==nil then
local guid=self.data.guid
xmData=zhengzhanshanhaiModel:getXMData(guid)
end
if xmData==nil then return end
local isMy=self:checkMyself()

local showFightSign=xmData:checkFigthSign()
if showFightSign then
if not isMy then
showFightSign=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','isPvPWin')==true
end
end
widget:SetChildActive(7,showFightSign)
if showFightSign then
self.showFightSign=true
local entSet=zhengzhanshanhaiController:getZZSHCfg('xmEntitySet')
widget:SetChildLocalPos(7,entSet[6][1],entSet[6][2],0)
widget:SetChildCSImageSprite(7,globalABLookup.zzshentityicons,'icon_shanhaisjbaiqi')
end
end




function zzshEntityInfo_PvEXianMeng:activeFightEffect(widget)
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
widget:SetChildUIModelShowTarget(8,modelID,size,{},eAnimationID.stand,false,false,0,nil)
widget:SetChildLocalPos(8,self.fightEffect[4][1],self.fightEffect[4][2],0)
local flipX
if self.fightEffect[2]==0 then
flipX=false
else
flipX=true
end
widget:SetChildUIModelShowFlipX(8,flipX)
end
else
self.fightEffectTime=Time.realtimeSinceStartup+zhengzhanshanhaiModel.pvpFigthtInterval
end
end

function zzshEntityInfo_PvEXianMeng:clearFightEffect(widget)
if self.fightSpine~=nil then
self.fightSpine=nil
widget:SetChildUIModelRemoveTarget(8)
end
self.fightEffectTime=nil
end




function zzshEntityInfo_PvEXianMeng:onUpdate()
if self.data==nil then return end

local widget=self:getWidget()
if widget==nil then return end
if self.fightEffectTime then
if Time.realtimeSinceStartup>=self.fightEffectTime then
self:clearFightEffect(widget)
end
end
end


function zzshEntityInfo_PvEXianMeng:onDelete()

end

return zzshEntityInfo_PvEXianMeng