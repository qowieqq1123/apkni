







UIRoleStateManager=gameState.addListener({})

local _roleBTDict={}
local _manufactureData={}
local _otherBTDict={}
local _studentBTDict={}
local _danFangBTDict={}
local _lianqiBTDict={}

function UIRoleStateManager:onEnterState(...)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end

function UIRoleStateManager:onLeaveState(...)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
end

function UIRoleStateManager.on_home_event(etype)
if etype==homeEvent.eEnterHome then
UIRoleStateManager:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
UIRoleStateManager:onLeaveHome()
end
end

function UIRoleStateManager:onEnterHome()

end

function UIRoleStateManager:onLeaveHome()
_roleBTDict={}
_otherBTDict={}
_studentBTDict={}
_danFangBTDict={}
_lianqiBTDict={}
end



function UIRoleStateManager:createUIDisciple(fname,parent,dzId,pos,scale,data,callback,weaponslot,order)
local dzIdStr=tostring(dzId)

local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,parent,function(id)
local dzWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
dzWidget:SetChildAnchoredPosition(0,pos)





self:createDiscipleModel(dzWidget,dzId,scale,weaponslot)

local initData={
dzId=dzIdStr,
stId=id,
dzWidget=dzWidget,
dzIndex=0,
}
if data then
for k,v in pairs(data)do
initData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fname,nil,true,initData)
if order then
dzWidget:SetChildCanvasEx(initData.dzIndex,'',order)
end
callback(bt)
end)
return id
end


function UIRoleStateManager:createDiscipleModel(dzWidget,dzId,scale,weaponslot)
local info=UIDiscipleModel:getDiscipleImageInfo(dzId)
local modelParams
local weaponId
local slotName
if weaponslot then
local slotData=cfgHelper.get2(cfg_disciplevocationconfig_get,info.job,weaponslot)
weaponId=slotData[1]
slotName=slotData[2]
if slotName then
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
else
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo2(dzId,weaponId)
end
else
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
end
local dzScale=isometricMapSystem:getModelScale(modelParams.body,true)
local state=UIDiscipleModel:getDiscipleState(dzId)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
local sex=UIDiscipleModel:getDiscipleSex(dzId)
modelParams.body=sex==1 and 1114103 or 1114104
modelParams.componets=nil
dzWidget:SetChildButtonClick(2,function()
discipleSelectController.onJiuZhiClick(dzId)
end)
else
dzWidget:SetChildButtonClick(2,nil,true,0)
end
dzWidget:SetChildUIModelShowTarget(0,modelParams.body,dzScale*scale,modelParams.componets,eAnimationID.stand)
if weaponId and slotName and modelParams.hideWeapon==nil then
local outSide=cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponId,'out_side')
dzWidget:SetChildLoadSlot(0,slotName,outSide)
end
end

function UIRoleStateManager:removeUIInstance(dzBt)
if dzBt then
local stId=dzBt:getSharedVar('stId')
if stId then
_InstantiateManager.RemoveInstance(stId)
end
behaviorManager:removeBehaviorTree(dzBt)
end
end

function UIRoleStateManager:createUIDog(fname,parent,pos,scale,data,callback,order)
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDog,parent,function(id)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
stWidget:SetChildAnchoredPosition(0,pos)

stWidget:SetChildUIModelShowTarget(0,440011,scale,nil,eAnimationID.stand)

local initData={
stId=id,
stWidget=stWidget,
stIndex=0,
}
if data then
for k,v in pairs(data)do
initData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fname,nil,true,initData)
if order then
stWidget:SetChildCanvasEx(initData.stIndex,'',order)
end
callback(bt)
end)
return id
end

local function _switchWorking(owner)
local temp=owner.curRight
owner.curRight=owner.curLeft
owner.curLeft=temp
end


function UIRoleStateManager:refreshAI(owner,newDzId,oldDzId)
if newDzId and oldDzId then
local newDzIdStr=tostring(newDzId)
local oldDzIdStr=tostring(oldDzId)
if oldDzIdStr=='0'and newDzIdStr~='0'then
local newDzState=UIDiscipleModel:getDiscipleState(newDzId)
if newDzState~=DISCIPLE_STATE_TYPE.edsDispatch then
comHelper.setChildHead2(owner.curRight,newDzId,nil,nil,nil,false)
behaviorManager:resetBT(owner.curRight.bt,behaviorConfig.uiStateIdKey,1)
_switchWorking(owner)
end
elseif oldDzIdStr~='0'and newDzIdStr=='0'then
local oldDzState=UIDiscipleModel:getDiscipleState(oldDzId)
if oldDzState~=DISCIPLE_STATE_TYPE.edsDispatch then
comHelper.setChildHead2(owner.curLeft,oldDzId,nil,nil,nil,false)
behaviorManager:resetBT(owner.curLeft.bt,behaviorConfig.uiStateIdKey,2)
_switchWorking(owner)
end
elseif oldDzIdStr~='0'and newDzIdStr~='0'then
local oldDzState=UIDiscipleModel:getDiscipleState(oldDzId)
if oldDzState~=DISCIPLE_STATE_TYPE.edsDispatch then
comHelper.setChildHead2(owner.curLeft,oldDzId,nil,nil,nil,false)
behaviorManager:resetBT(owner.curLeft.bt,behaviorConfig.uiStateIdKey,2)
end
local newDzState=UIDiscipleModel:getDiscipleState(newDzId)
if newDzState~=DISCIPLE_STATE_TYPE.edsDispatch then
comHelper.setChildHead2(owner.curRight,newDzId,nil,nil,nil,false)
behaviorManager:resetBT(owner.curRight.bt,behaviorConfig.uiStateIdKey,1)
end
if oldDzState~=DISCIPLE_STATE_TYPE.edsDispatch or newDzState~=DISCIPLE_STATE_TYPE.edsDispatch then
_switchWorking(owner)
end
end
end
end

function UIRoleStateManager:setWorkingState(owner,working)
owner.curLeft.bt:setSharedVar('working',working)
end


function UIRoleStateManager:initManufactureWinDog(owner)









end

function UIRoleStateManager:setDogShareVar(dogBT)
local datas,topTypes=zongmenControl:fastManufacture({})
if#datas>0 then
dogBT:setSharedVar(behaviorConfig.uiStateIdKey,0)
else
dogBT:setSharedVar(behaviorConfig.uiStateIdKey,2)
end
end

function UIRoleStateManager:ai_speak(uid)
local data=_manufactureData[uid]
local bt=data.bt
local desc=''
local speakStr=''
if bt.file=='bt_ui_dizi'then
local workState=bt:getSharedVar('working')
if workState==0 then
desc={'好无聊哦','整点活呗'}
speakStr=desc[math.random(1,#desc)]
elseif workState==1 then
desc={'打工人，打工魂\n打工才是人上人','搬砖搬砖'}
speakStr=desc[math.random(1,#desc)]
elseif workState==2 then
desc={'磨刀不误砍柴工','正在升级建筑，别急'}
speakStr=desc[math.random(1,#desc)]
end
elseif bt.file=='bt_ui_dog'then
local uiState=bt:getSharedVar(behaviorConfig.uiStateIdKey)
if uiState==0 then
speakStr='点我一键安排生产'
elseif uiState==1 then
desc={'哈哈','汪汪'}
speakStr=desc[math.random(1,#desc)]
elseif uiState==2 then
speakStr='没有可安排的生产方案'
end
end
data.speak:setActive(true)
data.txtSay:setText(speakStr)
end

function UIRoleStateManager:ai_shutup(uid)
local data=_manufactureData[uid]
data.speak:setActive(false)
end



function UIRoleStateManager:addUIRoleBT(args)
local bt=_roleBTDict[args.model]
if bt==nil then
bt=behaviorManager:addBehaviorTree('bt_ui_dizi',args,true)
_roleBTDict[args.model]=bt
end
return bt
end


function UIRoleStateManager:addUIXueYuanBT(fname,widget,modelIdx,data)
local initData={
dzWidget=widget,
dzIndex=modelIdx,
}
if data then
for k,v in pairs(data)do
initData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fname,nil,true,initData)
return bt
end

function UIRoleStateManager:removeUIXueYuanBT(dzBt)
if dzBt then
behaviorManager:removeBehaviorTree(dzBt)
end
end


function UIRoleStateManager:addUILianDanFangBT(winlua,model)
local bt=_danFangBTDict[model]
if bt==nil then
bt=behaviorManager:addBehaviorTree('bt_ui_ldf',{winlua=winlua,model=model},true)
_danFangBTDict[model]=bt
end
return bt
end

function UIRoleStateManager:removeUILianDanFangBT(model)
model.bt:broke()
behaviorManager:removeBehaviorTree(model.bt)
_danFangBTDict[model:getID()]=nil
model.bt=nil
end


function UIRoleStateManager:addUILianQiGeBT(winlua,model)
local bt=_lianqiBTDict[model]
if bt==nil then
bt=behaviorManager:addBehaviorTree('bt_ui_lqf',{winlua=winlua,model=model},true)
_lianqiBTDict[model]=bt
end
return bt
end

function UIRoleStateManager:removeUILianQiGeBT(model)
model.bt:broke()
behaviorManager:removeBehaviorTree(model.bt)
_lianqiBTDict[model:getID()]=nil
model.bt=nil
end



function UIRoleStateManager:addUIBirdBT(winlua,index)
local key=string.format('%s_%s',winlua.gameObject.name,index)
local bt=_otherBTDict[key]
if bt==nil then
bt=behaviorManager:addBehaviorTree('bt_ui_bird',{winlua=winlua,model=index},true)
_otherBTDict[key]=bt
end
return bt
end

function UIRoleStateManager:addUIMouseBT(winlua,index)
local key=string.format('%s_%s',winlua.gameObject.name,index)
local bt=_otherBTDict[key]
if bt==nil then
bt=behaviorManager:addBehaviorTree('bt_ui_mouse',{winlua=winlua,model=index},true)
_otherBTDict[key]=bt
end
return bt
end

function UIRoleStateManager:addUISirenBT(winlua,index)
local key=string.format('%s_%s',winlua.gameObject.name,index)
local bt=_otherBTDict[key]
if bt==nil then
bt=behaviorManager:addBehaviorTree('bt_ui_siren',{winlua=winlua,model=index},true)
_otherBTDict[key]=bt
end
return bt
end

function UIRoleStateManager:addUIDogBT(args)
local key=string.format('%s_%s',args.winlua.gameObject.name,args.model)
local bt=_otherBTDict[key]
if bt==nil then
bt=behaviorManager:addBehaviorTree('bt_ui_dog',args,true)
_otherBTDict[key]=bt
end
return bt
end

function UIRoleStateManager:getOtherBTByWinlua(winlua,index)
local key=string.format('%s_%s',winlua.gameObject.name,index)
return _otherBTDict[key]
end

function UIRoleStateManager:removeUIOtherBT(winlua,model)
model.bt:broke()
behaviorManager:removeBehaviorTree(model.bt)
local key=string.format('%s_%s',winlua.gameObject.name,model:getID())
_otherBTDict[key]=nil
model.bt=nil
end


function UIRoleStateManager:haveRoleInRadius(center,radius)
for index,bt in pairs(_roleBTDict)do
local winlua=bt.args.winlua
local go=winlua:GetChildGameObject(index)
local pos=go.transform.localPosition
if radius>Vector3.Distance(pos,center)then
return true
end
end
return false
end