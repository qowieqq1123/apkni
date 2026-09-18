









local xjEntity_battleAtk={}


function xjEntity_battleAtk:onInit()
self:initData()
end

function xjEntity_battleAtk:initData()
local data=self.data
self.targetDataID=data.targetDataID
self.teamHandleID=data.teamHandleID
self.size=data.size
self.pos=data.pos

local teamHandle=xianjieController:getXJTeamHandle(self.teamHandleID)
local movePath=teamHandle:getMyMovePath()
local n=#movePath
self.sPos=movePath[n-1]:getWorldPos()
self.ePos=movePath[n]:getWorldPos()
self.modelset=teamHandle:getMarchTeamModelSet()
self.isMyWaiPai=teamHandle:checkMyWaiPai()
self.faceTo=data.faceTo
local teamEntityKey=data.teamEntityKey
local ent=xianjieController:getEntity(teamEntityKey)
if ent then
ent:standbyFight()
self.teamEntityKey=teamEntityKey
end
end


function xjEntity_battleAtk:onCreateWidget(widget)
if self.teamEntityKey==nil then
self:refreshTeamModel(widget)
end
self:refreshAttackModel(widget)

if self.isMyWaiPai and self.faceTo then
self:modelFlipX()
end
end

function xjEntity_battleAtk:refreshTeamModel(widget)
local sPos=self.sPos
local ePos=self.ePos
local size=self.size
local stateID,flipX,flipY
local realAngle=0
local normalAngle=0
local modelset=self.modelset
local pos

stateID,flipX,flipY=xianjieModel.getMarchTeamModelState(sPos,ePos)
local attackOffsetX=modelset.attackOffset[1]
local attackOffsetZ=modelset.attackOffset[2]

local rot=math.atan2(sPos.z-ePos.z,sPos.x-ePos.x)
realAngle=math.deg(rot)
local index=math.floor((realAngle+22.5)/45)
normalAngle=index*45
local ox=(size.x+attackOffsetX)*math.cos(rot)
local oy=(size.y+attackOffsetZ)*math.sin(rot)
local oz=(size.y+attackOffsetZ)*math.sin(rot)

pos=Vector3.New(ox+ePos.x,ePos.y,oz+ePos.z)

local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams()
local modelID=modelset.modelID
local modelScale=modelset.scale
widget:SetChildSceneEntityCreateModel(0,modelID,{},'Entity',entCfg.sortOrder,modelScale,nil,false)
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)

widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),1)
widget:SetChildPosition(0,pos)

widget:SetChildSceneEntityPlayAnimation(0,stateID,1,nil)
widget:SetChildSceneEntityFlipXY(0,flipX,flipY)
widget:SetChildRotation(0,45,0,realAngle-normalAngle)
end


function xjEntity_battleAtk:modelFlipX()
local tagEntKey
local targetData=xianjieController:getXJClass(self.targetDataID)
if targetData then
tagEntKey=targetData:getEntityKey()
end
if tagEntKey then
local flipX=self.sPos.x>self.ePos.x
xianjieController:invokeEntityFunc(tagEntKey,'modelFlipX',nil,flipX)
end
end


local angleActionMap=
{
[-4]={eAnimationID.jz_left_enter2stand,true,false,"jz_left_enter2stand"},
[-3]={eAnimationID.jz_leftup_enter2stand,true,false,"jz_leftup_enter2stand"},
[-2]={eAnimationID.jz_up_enter2stand,false,false,"jz_up_enter2stand"},
[-1]={eAnimationID.jz_leftup_enter2stand,false,false,"jz_leftup_enter2stand"},
[0]={eAnimationID.jz_left_enter2stand,false,false,"jz_left_enter2stand"},
[1]={eAnimationID.jz_leftdown_enter2stand,false,false,"jz_leftdown_enter2stand"},
[2]={eAnimationID.jz_up_enter2stand,false,true,"jz_up_enter2stand"},
[3]={eAnimationID.jz_leftdown_enter2stand,true,false,"jz_leftdown_enter2stand"},
[4]={eAnimationID.jz_left_enter2stand,true,false,"jz_left_enter2stand"},
}

function xjEntity_battleAtk:refreshAttackModel(widget)
local sPos=self.sPos
local ePos=self.ePos
local size=self.size
local modelset=self.modelset


local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)

local rx=sPos.x-ePos.x
local ry=sPos.z-ePos.z

local modelID=modelset.fightModelID
local effectScale=modelset.fightModelScale
widget:SetChildSceneEntityCreateModel(1,modelID,{},'Entity',entCfg.sortOrder,effectScale,nil,false)

local radians=math.atan2(ry,rx)
local realAngle=math.deg(radians)
local index=math.floor((realAngle+22.5)/45)
local normalAngle=45*index
local attackOffsetX=modelset.attackOffset[1]+size.x
local attackOffsetY=modelset.attackOffset[2]+size.y

local offsetX=attackOffsetX*math.cos(radians)
local offsetY=attackOffsetY*math.sin(radians)*math.sin(math.pi/4)
local offsetZ=attackOffsetY*math.sin(radians)
widget:SetChildPosition(1,Vector3.New(ePos.x+offsetX,ePos.y,ePos.z+offsetZ))
widget:SetChildRotation(1,45,0,realAngle-normalAngle)
local actionInfo=angleActionMap[index]
if actionInfo~=nil then
widget:SetChildSceneEntityPlayAnimation(1,actionInfo[1]or 0,1,nil)
widget:SetChildSceneEntityFlipXY(1,actionInfo[2],actionInfo[3])
end
end


function xjEntity_battleAtk:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
widget:SetChildRotation(0,0,0,0)
widget:SetChildSceneEntityRemoveModel(1)
widget:SetChildRotation(1,0,0,0)
end


function xjEntity_battleAtk:onMyClick(boxParams,clickPos)

end

function xjEntity_battleAtk:onDelete()

end

return xjEntity_battleAtk