









local zzshEntityInfo_resource={}


function zzshEntityInfo_resource:onInit()
self:refreshLocalPos()
local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
local cfg=qbData:getCfg()
self.m_radius=cfg.radius
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
self.m_radius_l=baseCfg.gw*self.m_radius
self.m_rect={self.l_x-self.m_radius_l,self.l_y-self.m_radius_l,self.l_x+self.m_radius_l,self.l_y+self.m_radius_l}
end

function zzshEntityInfo_resource:containKey(key)
return self.data.guid==key
end

function zzshEntityInfo_resource:refreshLocalPos()
local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
self.g_x=qbData.x
self.g_y=qbData.y
local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(self.g_x,self.g_y)
self.l_x=l_x
self.l_y=l_y
end


function zzshEntityInfo_resource:checkInAOI(x1,y1,x2,y2)
if self.m_radius_l>0 then

return mathHelper.circleCrashRect(self.l_x,self.l_y,self.m_radius_l,x1,y1,x2,y2)
else

return mathHelper.posInRect(self.l_x,self.l_y,x1,y1,x2,y2)
end
end

function zzshEntityInfo_resource:getBGIconName(lv)
local abname=globalABLookup.zzshicons
local iconname=FMT.fmt('image_shanhaisjdtui_{0}',lv)
return abname,iconname
end


function zzshEntityInfo_resource:onCreate(widget)
widget:SetChildLocalPos(-1,self.l_x,self.l_y,0)
local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
local cfg=qbData:getCfg()

self.modelID=cfg.model
if self.modelID==nil then
self.modelIcon=cfg.modelIcon
end
local size=cfg.modelSet[1]
if self.modelID then
local flipX=cfg.modelSet[2]==1
widget:SetChildScale(0,Vector3(1,1,1))
widget:SetChildUIModelShowTarget(0,cfg.model,size,{},eAnimationID.stand)
widget:SetChildUIModelShowFlipX(0,flipX)
elseif self.modelIcon then
widget:SetChildCSImageSprite(0,globalABLookup.zzshentityicons,self.modelIcon)
widget:SetChildScale(0,Vector3(size,size,size))
end
widget:SetChildLocalPos(0,cfg.modelSet[3][1],cfg.modelSet[3][2],0)

widget:SetChildShowEffectEx(9,cfg.effect[1],self.sortLayer,self.sortOrder2+1,true)
widget:SetChildLocalPos(9,cfg.effect[3][1],cfg.effect[3][2],0)
local e_scale=cfg.effect[2]
widget:SetChildScale(9,Vector3(e_scale,e_scale,e_scale))

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

widget:SetChildCSImageIcon(4,moneyModel.getIconNameEx(cfg.moneytype),true)

local name_str=FMT.fmt('{0}阶',cfg.stage)
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

self:refreshCollectSign(widget)





end


function zzshEntityInfo_resource:refreshUIScale(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local scale=self.objScale
local scale_=Vector3(scale,scale,1)
widget:SetChildScale(-1,scale_)








end

function zzshEntityInfo_resource:refreshCollectSign(widget)
if self.m_ojbGuid==nil then return end
local guid=self.data.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then return end
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end

local showSign=false
local wpData=zhengzhanshanhaiModel:getMyPvEWaiPaiData(guid)
if wpData then
local teamData=wpData:getTeamData()
showSign=teamData.sec>0
end
if showSign then
if self.collectSigeModel==nil then
local cfg=qbData:getCfg()
local collectSignSet=cfg.collectSignSet
self.collectSigeModel=collectSignSet[1]
widget:SetChildUIModelShowTarget(10,self.collectSigeModel,1,{},eAnimationID.stand)
widget:SetChildLocalPos(10,collectSignSet[2][1],collectSignSet[2][2],0)
end
else
if self.collectSigeModel~=nil then
self.collectSigeModel=nil
widget:SetChildUIModelRemoveTarget(10)
end
end
end


function zzshEntityInfo_resource:onReleaseWidget(widget)

if self.modelID then
self.modelID=nil
widget:SetChildUIModelRemoveTarget(0)
elseif self.modelIcon then
self.modelIcon=nil
widget:SetChildIcon(0,'',false)
end

widget:SetChildShowEffect(9,0,false)

if self.collectSigeModel~=nil then
self.collectSigeModel=nil
widget:SetChildUIModelRemoveTarget(10)
end
end

function zzshEntityInfo_resource:onMyClick()
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


function zzshEntityInfo_resource:onDelete()

end

return zzshEntityInfo_resource
