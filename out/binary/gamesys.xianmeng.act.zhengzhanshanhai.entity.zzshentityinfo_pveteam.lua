









local zzshEntityInfo_PvETeam={}


function zzshEntityInfo_PvETeam:onInit()
self.only_key=self.data.only_key
local teamData=zhengzhanshanhaiModel:getPvETeam(self.only_key)
self:refreshLocalPos(teamData)
self.m_line={self.l_x,self.l_y,self.l_e_x,self.l_e_y}
self.infotype=teamData:get_infotype()
self.isMy=teamData:isMyXMTeam()
self.rectAOI={}
end

function zzshEntityInfo_PvETeam:refreshLocalPos(teamData)
self.g_x=teamData.x
self.g_y=teamData.y
self.l_x=teamData.l_x
self.l_y=teamData.l_y
local e_x,e_y=teamData:getEndGridPos()
self.e_x=e_x
self.e_y=e_y
self.l_e_x=teamData.l_e_x
self.l_e_y=teamData.l_e_y
end

function zzshEntityInfo_PvETeam:refreshAOI(x1,y1,x2,y2,mapScale)
self.rectAOI[1]=x1
self.rectAOI[2]=y1
self.rectAOI[3]=x2
self.rectAOI[4]=y2
self.rectAOI[5]=mapScale
end

function zzshEntityInfo_PvETeam:refreshAOIEx()
local rect=self.rectAOI
if rect[1]then
if self:checkInAOI(rect[1],rect[2],rect[3],rect[4])then
local changeScale=self:changeMapScale(rect[5])
if self.m_ojbGuid==nil then
new_zzshEntityObj(self)
else
if changeScale then
self:refreshUIScale()
end
end
else
release_zzshEntityObj(self)
end
else
release_zzshEntityObj(self)
end
end


function zzshEntityInfo_PvETeam:checkInAOI(x1,y1,x2,y2)
local teamData=zhengzhanshanhaiModel:getPvETeam(self.only_key)
if teamData then
if mathHelper.lineCrashRect(self.l_x,self.l_y,self.l_e_x,self.l_e_y,x1,y1,x2,y2)then
return true
end
end
return false
end


function zzshEntityInfo_PvETeam:onCreate(widget)






local teamData=zhengzhanshanhaiModel:getPvETeam(self.only_key)
local l_x=self.l_x
local l_y=self.l_y
local l_e_x=self.l_e_x
local l_e_y=self.l_e_y

widget:SetChildLocalPos(-1,l_x,l_y,0)

local c_x,c_y=teamData:getCurLocalPos()
local l_c_x=c_x-l_x
local l_c_y=c_y-l_y
widget:SetChildLocalPos(7,l_c_x,l_c_y,0)

local modelID
local entSet
if self.infotype==zhengzhanshanhaiModel.qbType.eMonster then
modelID=4602
entSet=zhengzhanshanhaiController:getZZSHCfg('pveJianEntitySet')
else
modelID=4601
entSet=zhengzhanshanhaiController:getZZSHCfg('pveCollectEntitySet')
end
local size=entSet[1]
widget:SetChildUIModelShowTarget(0,modelID,size,{},eAnimationID.stand,false,false,0,nil)
widget:SetChildLocalPos(0,entSet[2][1],entSet[2][2],0)
local flipX
if l_x<=l_e_x then
flipX=false
else
flipX=true
end
widget:SetChildUIModelShowFlipX(0,flipX)
widget:SetChildCanvas(0,self.sortLayer,self.sortOrder2+1)

widget:SetChildCanvas(1,self.sortLayer,self.sortOrder+1)

self:refreshTime(widget,teamData)

local dis=mathHelper.distance(l_x,l_y,l_e_x,l_e_y)

widget:SetChildSizeDelta(6,dis,22)
widget:SetChildCanvas(6,self.sortLayer,self.sortOrder3+1)
widget:SetChildButtonClick(6,function()
self:onClick()
end)

local lineAB,lineIcon
if self.isMy then
if zhengzhanshanhaiModel:checkInMyWaiPai(teamData.guid)then
lineAB,lineIcon=xianmengdigongModel:getLineIcon(1)
else
lineAB,lineIcon=xianmengdigongModel:getLineIcon(3)
end
else
lineAB,lineIcon=xianmengdigongModel:getLineIcon(2)
end
widget:SetChildCSImageSprite(5,lineAB,lineIcon)
widget:SetChildSizeDelta(5,dis,11)
if deviceHelper.getAPILevel()>=70 then
widget:SetChildUVImageScrollSprite(5,0,-0.5,false)
end

local v={1.0,0}
local v2={l_e_x-l_x,l_e_y-l_y}


local dot_v=v[1]*v2[1]+v[2]*v2[2]
local l_A=1.0
local l_B=math.sqrt(v2[1]*v2[1]+v2[2]*v2[2])
local angle=math.acos(dot_v/(l_A*l_B))
local angle_deg=math.deg(angle)

if l_y>l_e_y then
angle_deg=-angle_deg
end
widget:SetChildRotation(5,0,0,angle_deg)
widget:SetChildRotation(6,0,0,angle_deg)

self:doLine(widget,teamData)
end


function zzshEntityInfo_PvETeam:refreshUIScale(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end

local scale=self.objScale
local scale_=Vector3(scale,scale,1)
widget:SetChildScale(7,scale_)
end

function zzshEntityInfo_PvETeam:refreshTime(widget,teamData)

local time_str
local showIcon
local state,time=teamData:getState()
if time>=0 then
time_str=timeHelper.format_time_stamp3(time)
showIcon=true
if time==0 then

local qbData=zhengzhanshanhaiModel:getQingBaoData(teamData.guid)
if qbData~=nil and qbData.ojbID then
zhengzhanshanhaiModel:invokeFunc(qbData.ojbID,'activeFightEffect')
end
end
else
time_str='战斗中'
showIcon=false
end
widget:SetChildText(4,time_str)
widget:SetChildActive(3,showIcon)
end

function zzshEntityInfo_PvETeam:doLine(widget,teamData)
self:clearTweener()
local c_x,c_y,move,lerp_move,lerp_time=teamData:getCurLocalPos()
if lerp_time>0 then


local l_e_x=teamData.l_e_x
local l_e_y=teamData.l_e_y
local l_x=self.l_x
local l_y=self.l_y

local l_e_x_=l_e_x-l_x
local l_e_y_=l_e_y-l_y
local ease_=DG.Tweening.Ease.Linear
self.moveTweener1=widget:SetChildDOAnchorPos(7,Vector2.New(l_e_x_,l_e_y_),lerp_time)
self.moveTweener1:SetEase(ease_)
end
end


function zzshEntityInfo_PvETeam:onReleaseWidget(widget)

widget:SetChildIcon(5,'',false)
self:clearTweener()
end

function zzshEntityInfo_PvETeam:onMyClick()
if self.only_key==nil then return end
local teamData=zhengzhanshanhaiModel:getPvETeam(self.only_key)
if teamData~=nil then
zhengzhanshanhaiModel:checkQingBaoDetail(teamData.guid)
end
end


function zzshEntityInfo_PvETeam:onUpdate()
if self.only_key==nil then return end
self:refreshAOIEx()

local teamData=zhengzhanshanhaiModel:getPvETeam(self.only_key)
if teamData~=nil then
local widget=self:getWidget()
if widget~=nil then
self:refreshTime(widget,teamData)
end


local check=zhengzhanshanhaiModel:checkPvETeamShowEntity(self.infotype,teamData.sec)
if not check then
zhengzhanshanhaiModel:delEntityNow(teamData.ojbID)
end
end
end

function zzshEntityInfo_PvETeam:clearTweener()
if self.moveTweener1~=nil then
self.moveTweener1:Complete()
self.moveTweener1:Kill()
self.moveTweener1=nil
end
end


function zzshEntityInfo_PvETeam:onDelete()

end

return zzshEntityInfo_PvETeam
