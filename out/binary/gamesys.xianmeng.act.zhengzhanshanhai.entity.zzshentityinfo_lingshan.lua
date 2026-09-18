
zzshEntityInfo_lingShan={}


function zzshEntityInfo_lingShan:onInit()
self.mountId=self.data.mountId
self.mountData=UILSZDControl:getDataById(self.mountId)
self.m_radius=self.mountData.radius
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
self.m_radius_l=baseCfg.gw*self.m_radius



self.targetid_str=tostring(-self.mountId)
self:refreshLocalPos()
self.m_rect={self.l_x-self.m_radius_l,self.l_y-self.m_radius_l,self.l_x+self.m_radius_l,self.l_y+self.m_radius_l}
end


function zzshEntityInfo_lingShan:refreshLocalPos()
self.g_x=self.mountData.x
self.g_y=self.mountData.y
local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(self.g_x,self.g_y)
self.l_x=l_x
self.l_y=l_y
end

function zzshEntityInfo_lingShan:containKey(key)
return self.data.mountId==key
end


function zzshEntityInfo_lingShan:checkInAOI(x1,y1,x2,y2)

return mathHelper.circleCrashRect(self.l_x,self.l_y,self.m_radius_l,x1,y1,x2,y2)
end

function zzshEntityInfo_lingShan:onCreate(widget)
widget:SetChildLocalPos(-1,self.l_x,self.l_y,0)
widget:SetChildUIModelShowTarget(0,self.mountData.modelId,self.mountData.scale,{},eAnimationID.stand)
widget:SetChildButtonClick(1,function()
self:onClick()
end)
local pos=widget:GetChildAnchoredPosition3D(1)
local offset=self.mountData.clickOffset
pos.x=pos.x+offset[1]
pos.y=pos.y+offset[2]
widget:SetChildAnchoredPosition3D(1,pos)
local size=self.mountData.clickSize
widget:SetChildSizeDelta(1,size[1],size[2])
self:setTeamCount(widget)




end

function zzshEntityInfo_lingShan:setTeamCount(widget)
if not widget then
widget=self:getWidget()
end
if not widget then
return
end
local num=UILSZDControl:getMountTeamNum(self.mountId)
local max=UILSZDControl:getMountMaxTeamNum(self.mountId)
widget:SetChildText(3,self.mountData.mountName)
widget:SetChildText(4,FMT.fmt('（{0}/{1}）',num,max))
end

function zzshEntityInfo_lingShan:onMyClick()
local id=zhengzhanshanhaiModel:getLunState()
if id==eZZSH_State.ePVPFight or id==eZZSH_State.ePVPStandby then
UIManager.info('山海世界正处于战争期，灵山已封山，无法进入')
return
end
if UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','checkInSignRecordModel')then
local data={x=self.g_x,y=self.g_y}
data.mountId=self.mountId
data.entityType=self.entityType
data.abname='ui/windows/lingshanzhengduo/lszd_atlas_pak.ab'
local cfg=UILSZDControl:getLingShanConfig(self.mountId)
data.icon1=cfg.mount_type==1 and'image_lingshanzhengduo_6'or'image_lingshanzhengduo_7'
UIManager:showWindow('UIXM_ZZSH_posInfoWin',data)
else
UILSZDControl:showLSZDWinEx({mountId=self.mountId},true)
end
end


function zzshEntityInfo_lingShan:refreshUIScale(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local scale=self.objScale
local scale_=Vector3(scale,scale,1)
widget:SetChildScale(-1,scale_)
end


function zzshEntityInfo_lingShan:onReleaseWidget(widget)

end


function zzshEntityInfo_lingShan:onUpdate()

end


function zzshEntityInfo_lingShan:onDelete()
self.mountData:setObjID()
end

return zzshEntityInfo_lingShan
