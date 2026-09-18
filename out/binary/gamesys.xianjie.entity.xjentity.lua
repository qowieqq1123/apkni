









local xjEntity={}

function xjEntity:__init(entityType,data)
self.entityType=entityType
self.data=data or{}
self.lodLevel=self.data.lodLevel
local cfg=cfgHelper.get1(cfg_xianjieentityconfig_get,entityType)
if self.lodLevel==nil or self.lodLevel<-1 then
self.lodLevel=cfg.lodLevel
if self.data.lodLevel~=self.lodLevel then
self.data.lodLevel=self.lodLevel
end
end
xpcall(function()
self:onInit()
end,function(err)
loggerUtil.logErrFMT('xjEntity onInit err!{0}',err)
end)
local lodLevelRange=nil
self.hud1LodLevel=100
if cfg.hud1~=nil or cfg.hud2~=nil then
if cfg.hud1~=nil and cfg.hud1[3]<self.lodLevel then
self.hud1LodLevel=cfg.hud1[3]
lodLevelRange={cfg.hud1[3],self.lodLevel}
else
lodLevelRange={self.lodLevel}
end
if cfg.hud2~=nil then
table.insert(lodLevelRange,cfg.hud2[3])
end
end
self.lodLevelRange=lodLevelRange
end




function xjEntity:onInit()



end

function xjEntity:getKey()
return self.m_key
end

function xjEntity:getEntityChildType()
return self.xjicontype
end

function xjEntity:getData()
return self.data
end

function xjEntity:getPos()
return self.pos
end


function xjEntity:getGridPos()
local pos=self.pos
return xianjieController:worldPos2WorldGridPos(pos.x,pos.z)
end


function xjEntity:getGridSize()
local size=self.size
return xianjieController:worldSize2GridSize(size.x,size.y)
end


function xjEntity:crashRect(x,y,w,h)
if self.pos~=nil then
return mathHelper.rectCrashRect2(self.pos.x,self.pos.z,self.size.x,self.size.y,x,y,w,h)
elseif self.posList~=nil then
for i=2,#self.posList do
local pos1=self.posList[i-1]
local pos2=self.posList[i]
if mathHelper.lineCrashRect2(pos1.x,pos1.z,pos2.x,pos2.z,x,y,w,h)then
return true
end
end
return false
end
return false
end


function xjEntity:crashAOI()
if self.pos~=nil then
return xianjieController:checkRectInAOI(self.pos,self.size)
elseif self.posList~=nil then
for i=2,#self.posList do
if xianjieController:checkLineInAOI(self.posList[i-1],self.posList[i])then
return true
end
end
return false
end
return false
end

function xjEntity:getName()
return self.ent_name
end

function xjEntity:containType(entityType)
return self.entityType==entityType
end

function xjEntity:checkWidget()
return self.m_widgetID~=nil
end

function xjEntity:getWidget()
if self.m_widgetID then
local widget=xianjieController:getEntityWidget(self.m_widgetID)
if widget==nil then



end
return widget
end
end

function xjEntity:createWidgetCache(widgetID)
if widgetID<0 then



end
local widget=xianjieController:getEntityWidget(widgetID)
if widget then
self.m_widgetID=widgetID
widget:SetChildActive(-1,true)
if self.playBornAnim then
local func=function()
local widgetID_=self.m_widgetID
if widgetID_ and widgetID_>0 then
local widget_=xianjieController:getEntityWidget(widgetID_)
if widget_ then
self:createWidget(widgetID_,widget_)
end
end
end
self:playBornAnim(func)
else
self:createWidget(widgetID,widget)
end
end
end








function xjEntity:createWidget(widgetID,widget)
if self.canSelect then
if self.isSelectMark then
self:onSelect(widget,true)
else
self:onSelect(widget,false)
end
end
self:onCreateWidget(widget)

if self.hudID~=nil then
local entHud=xianjieController:getEntityHud(self.hudID)
if entHud and not entHud:checkWidget()then
new_xjEntityHudWidget(entHud)
end
end
if self.hudExID~=nil then
local entHud=xianjieController:getEntityHud(self.hudExID)
if entHud and not entHud:checkWidget()then
new_xjEntityHudWidget(entHud)
end
end









end


function xjEntity:onCreateWidget(widget)

end

function xjEntity:removeWidget(widgetID,widget)

self:removeHud()
self:removeHudEx()
self:removeMyLines(true)
if self.canSelect then
self:onSelectHandle(widget,false)
end
local widgetID_=self.m_widgetID
if widgetID_~=nil and not self.lockRemove then
self.lockRemove=true
if widgetID_~=widgetID then



local widget_=xianjieController:getEntityWidget(widgetID_)
if widget_ then
self:onRemoveWidget(widget_)
else



end
end


if widget then
self:onRemoveWidget(widget)
end
self:onEnterPool()

self.m_widgetID=nil
self.lockRemove=nil
end
end


function xjEntity:onEnterPool()

end


function xjEntity:onRemoveWidget(widget)

end


function xjEntity:playDeadAnim()
xianjieController:removeEntity(self:getKey())
end





function xjEntity:checkLOD()
return true
end



function xjEntity:checkLogicShow()
return true
end



function xjEntity:changeLOD(inAOI,curLODLevel,logicShow)
if inAOI==nil then
inAOI=self.inAOI_mark
curLODLevel=self.curLODLevel_mark
logicShow=self.logicShow_mark
else
self.inAOI_mark=inAOI
self.curLODLevel_mark=curLODLevel
self.logicShow_mark=logicShow
end
if inAOI==nil then return end
if inAOI then

local hudTypeNew=nil
local cfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
if(self.lodLevel==-1 or curLODLevel<=self.lodLevel)and logicShow then
if cfg.hud1 and(self.ismy or curLODLevel<=self.hud1LodLevel)then
hudTypeNew=1
end
elseif cfg.hud2~=nil and curLODLevel>self.lodLevel and curLODLevel<=cfg.hud2[3]then
if self:checkHUD2()then
hudTypeNew=2
end
end
if hudTypeNew then
local check=self:checkLOD()
if not check then
hudTypeNew=nil
end
end

if hudTypeNew~=self.hudType then
if hudTypeNew~=nil then
self:removeHud()
local hudID=xianjieController:addEntityHud(hudTypeNew,self.entityType,self.m_key,self.data)
if hudID then
self.hudID=hudID
self.hudType=hudTypeNew
else
self.hudMark=hudTypeNew
end
else
self:removeHud()
self:removeHudEx()
end
end
else

self:removeHud()
self:removeHudEx()
end
end




function xjEntity:getHudBindingTransform()
local widget=self:getWidget()
if widget then
local obj=widget:GetChildGameObject(0)
if obj then
return obj.transform
else
return widget.transform
end
end
end


function xjEntity:checkHUD2()


return xianjieModel:checkFilterHUD2Record(self.entityType,self.xjicontype)
end

function xjEntity:checkHudMark(hudType)
if hudType then
if self.hudMark==hudType then
self.hudMark=nil
self.hudID=xianjieController:addEntityHudImp(hudType,self.entityType,self.m_key,self.data)
self.hudType=hudType
assert(self.hudID~=nil)
return true
end
end
return false
end

function xjEntity:checkHudExMark(hudType)
if hudType then
if self.hudMarkEx==hudType then
self.hudMarkEx=nil
self.hudExID=xianjieController:addEntityHudExImp(hudType,self.entityType,self.m_key,self.data)
assert(self.hudExID~=nil)
return true
end
end
return false
end


function xjEntity:addHudEx()
self:removeHudEx()
local hudType=3
local hudExID=xianjieController:addEntityHudExImp(hudType,self.entityType,self.m_key,self.data)
if hudExID then
self.hudExID=hudExID
else
self.hudMarkEx=hudType
end
end

function xjEntity:removeHud()
local hudID=self.hudID
if hudID~=nil then

self.hudID=nil
self.hudType=nil
xianjieController:removeEntityHud(hudID,self.m_key)
end
self.hudMark=nil
end

function xjEntity:removeHudEx()
local hudExID=self.hudExID
if hudExID~=nil then

self.hudExID=nil
xianjieController:removeEntityHudEx(hudExID,self.m_key)

end
self.hudMarkEx=nil
end

function xjEntity:invokeEntityHudFunc(funcName,...)
if self.hudID~=nil then
xianjieController:invokeEntityHudFunc(self.hudID,funcName,...)
end
end

function xjEntity:getHud()
if self.hudID~=nil then
return xianjieController:getEntityHud(self.hudID)
end
end



function xjEntity:addLineImp(prefabType,layer,speed,boxParams)

local teamHandle=self:getTeamHandle()
local enemyTypo=teamHandle.enemyType

if enemyTypo==xjEnemyType.eSelf or enemyTypo==xjEnemyType.eAllies then
xianjieController.lineRealCount=xianjieController.lineRealCount+1
self:drawPosListToLines(prefabType,nil,speed,layer,boxParams)
else
if xianjieController.lineRealCount>xianjieController.maxShowLine then

xianjieController.lineDrawCache[self]={self,speed,boxParams}
else
xianjieController.lineRealCount=xianjieController.lineRealCount+1
self:drawPosListToLines(prefabType,nil,speed,layer,boxParams)
end
end
end

function xjEntity:drawPosListToLines(prefabType,color,speed,layer,boxParams)
local linePos=self.linePosList
if linePos~=nil then
if deviceHelper.getAPILevel()>=360 then
self.linekeys=xianjieController:drawLines2(prefabType,linePos,color,speed,layer,boxParams)
else
local linekeys={}
local c=0
for i=1,#linePos,2 do
local key=xianjieController:drawLine(prefabType,linePos[i],linePos[i+1],color,speed,layer,boxParams)
c=c+1
linekeys[c]=key
end
self.linekeys=linekeys
end
else
self.linekeys=xianjieController:drawLines(prefabType,self.posList,color,speed,layer,boxParams)
end
end

function xjEntity:drawMyLines(speed,boxParams)
self:removeMyLines(false)
local teamHandle=self:getTeamHandle()
local prefabType=teamHandle:getLineColor()
local layer=helper.LAYER_ACTOR
self:addLineImp(prefabType,layer,speed,boxParams)
end

function xjEntity:drawMyLines2(prefabType,speed,boxParams)
self:removeMyLines(false)
local layer=helper.LAYER_ACTOR
self:addLineImp(prefabType,layer,speed,boxParams)
end

function xjEntity:hasLine()
return self.linekeys~=nil
end

function xjEntity:setLinesSpeed(speed)
if self.linekeys then
xianjieController:setLinesSpeed(self.linekeys,speed)
else
local info=xianjieController.lineDrawCache[self]
if info~=nil then
info[2]=speed
end
end
end

function xjEntity:removeMyLines(fetchCache)
if self.linekeys then
xianjieController:removeLines(self.linekeys)
self.linekeys=nil
xianjieController.lineRealCount=xianjieController.lineRealCount-1
xianjieController.lineDrawCache[self]=nil
if fetchCache and xianjieController.lineRealCount<=xianjieController.maxShowLine then
local ent=next(xianjieController.lineDrawCache)
if ent~=nil then
local info=xianjieController.lineDrawCache[ent]
xianjieController.lineDrawCache[ent]=nil
xianjieController.lineRealCount=xianjieController.lineRealCount+1
local layer=helper.LAYER_ACTOR
local teamHandle=ent:getTeamHandle()
local prefabType=teamHandle:getLineColor()
ent:drawPosListToLines(prefabType,nil,info[2],layer,info[3])
end
end
else

xianjieController.lineDrawCache[self]=nil
end
end




function xjEntity:handleBoxParams(...)
local boxParams={...}
table.insert(boxParams,self.entityType)
table.insert(boxParams,self.m_key)
return boxParams
end



function xjEntity:onClick(boxParams,clickPos)
self:onMyClick(boxParams,clickPos)
end


function xjEntity:onMyClick(boxParams,clickPos)

end


function xjEntity:onClickGrid()

self:onMyClick()
end



function xjEntity:checkCanSelect()
return self.canSelect,self.isSelected
end

function xjEntity:onSelect(widget,isSelect)
if not self.canSelect then return end
if widget==nil then
widget=self:getWidget()
end
self.isSelected=isSelect
if widget then
self.isSelectMark=nil
self:onSelectHandle(widget,isSelect)

if self.hudID~=nil then
xianjieController:invokeEntityHudFunc(self.hudID,'onSelect',nil,isSelect)
end
if self.hudExID~=nil then
xianjieController:invokeEntityHudFunc(self.hudExID,'onSelect',nil,isSelect)
end
else
self.isSelectMark=isSelect
end
end


function xjEntity:onSelectHandle(widget,isSelect)

end



function xjEntity:playSpriteAnimation(widget,index,aniStr,offset,scale,sortingLayer,sortOrder)
widget=widget or self:getWidget()
if widget==nil then return false end
widget:SetChildSpriteRendererAnimationStringID(index,aniStr,true)
widget:SetChildSpriteRendererSortingLayer(index,sortingLayer,sortOrder)
if scale then
widget:SetChildScale(index,scale)
end
if offset then
widget:SetChildLocalPosition(index,offset)
end
return true
end

function xjEntity:stopSpriteAnimation(widget,index)
widget=widget or self:getWidget()
if widget==nil then return false end
widget:SetChildSpriteRendererAnimationEffect(index,-1)
return true
end












function xjEntity:__delete()

if self.m_key==nil then return end
self:removeHud()
self:removeHudEx()
self:removeMyLines(true)
local widgetID=self.m_widgetID
if widgetID~=nil and not self.lockRemove then
self.lockRemove=true
local widget_=xianjieController:getEntityWidget(widgetID)
if widget_ then
self:onRemoveWidget(widget_)
end

self.m_widgetID=nil
self.lockRemove=nil
end
xpcall(function()
self:onDelete()
end,function(err)
loggerUtil.logErrFMT('xjEntity onDelete err!{0}',err)
end)
end


function xjEntity:onDelete()

end



xjEntityParentType={
eBase=0,
eTeam=1,
eNotHandleTeam=2,
}


local xjEntityParentConfig={
[xjEntityParentType.eTeam]='lua.gamesys.xianjie.entity.xjTeamEntity',
[xjEntityParentType.eNotHandleTeam]='lua.gamesys.xianjie.entity.xjNotHandleTeamEntity',
}


local xjEntityTypeParentLookup={
[XJ_ENTITY_TYPE.eSearchTeam]=xjEntityParentType.eTeam,
[XJ_ENTITY_TYPE.ePlotTeam]=xjEntityParentType.eTeam,
[XJ_ENTITY_TYPE.eMarchTeam]=xjEntityParentType.eTeam,
[XJ_ENTITY_TYPE.eRPMarchTeam]=xjEntityParentType.eTeam,
[XJ_ENTITY_TYPE.eMoJunBoxTeam]=xjEntityParentType.eTeam,
[XJ_ENTITY_TYPE.eCaravanEscortTeam]=xjEntityParentType.eNotHandleTeam,
}

local xjEntityParentLookup={}

local eKey=0
local get_entityKey=function()
eKey=eKey+1
return eKey
end
local num=50
local pool={}
local poollp={}
local fileLookup={}
local entLookup={}

function check_xjEntityLookup()
if next(entLookup)then



return false
end
return true
end

function clear_xjEntityLookup()
entLookup={}
end

function new_xjEntity(entityType,data)
local newT
if#pool>0 then
newT=table.remove(pool)
poollp[newT]=nil
else
newT={}
local mT={




__index=xjEntity,
}
setmetatable(newT,mT)







end
local cfg=cfgHelper.get1(cfg_xianjieentityconfig_get,entityType)
if not cfg then
logErr(FMT.fmt('实体类型{0}不存在配置'))
end
local childname=cfg.luafilename
if childname then
local child=fileLookup[entityType]
local filename=FMT.fmt('lua.gamesys.xianjie.entity.{0}',childname)
if child==nil then
child=xianjieHelper.require(filename,fileLookup,entityType)
end
if child==nil then



return
end
local parentType=xjEntityTypeParentLookup[entityType]or xjEntityParentType.eBase
if parentType~=xjEntityParentType.eBase then
local parent=xjEntityParentLookup[parentType]
if parent==nil then
local pname=xjEntityParentConfig[parentType]
parent=require(pname)
if parent==nil then



else
xjEntityParentLookup[parentType]=parent
end
end
if parent then
for k,v in pairs(parent)do
newT[k]=v
end
end
end
for k,v in pairs(child)do
newT[k]=v
end
end
local key=get_entityKey()
newT.m_key=key
entLookup[key]=newT
newT:__init(entityType,data)
return newT
end

function release_xjEntity(ent)
if ent==nil then return end
local key=ent.m_key
if poollp[ent]~=nil then



return
end
ent:__delete()
entLookup[key]=nil
local temp={}

for k,v in pairs(ent)do
temp[k]=true
end
for k,v in pairs(temp)do
ent[k]=nil
end
if#pool>=num then
return
end
poollp[ent]=true
table.insert(pool,ent)
end
