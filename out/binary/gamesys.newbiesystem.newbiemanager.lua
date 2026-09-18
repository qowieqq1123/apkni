





newbieManager=gameState.addListener({})

local _instance=CS.NewBieManager.Instance
local _startMark=_instance.StartMaskX
local _revertMask=_instance.RevertMask
local _startWorldPosMask=_instance.StartWorldPosMask
local _clickTarget=_instance.ClickTarget
local _getMarkTargetSize=_instance.GetMarkTargetSize
local _hasNewBieComponent=_instance.HasNewBieComponent
local _hasNewBieActiveComponent=_instance.HasNewBieActiveComponent
local _disableBloker=_instance.DisableBloker
local _enableBloker=_instance.EnableBloker
local _enableMask=_instance.EnableMask
local _addClickAction=_instance.AddClickAction
local _removeClickAction=_instance.RemoveClickAction



local _setSortLayer=_instance.SetSortLayer
local _resetSortLayer=_instance.ResetSortLayer

local _setUITransformTopWithCamera=_instance.SetUITransformTopWithCamera
local _setUITransformTop=_instance.SetUITransformTop
local _resetUITransformTop=_instance.ResetUITransformTop


local _setEntityTransformTop=_instance.SetEntityTransformTop
local _resetEntityTransformTop=_instance.ResetEntityTransformTop

local _resetTopCamera=_instance.ResetNewbieTop

local _hexMapManager=CS.HexagonMapManagerInterface

local _clickBlockAction

local _isEnableBlock=false


function newbieManager:onAppStart()
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildEvent)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)

end





function newbieManager:onEnterState()
_clickBlockAction=nil
CS.BindWidget(newbieManager.getWidget(),newbieManager)
end

function newbieManager:onLeaveState()
_clickBlockAction=nil
end


function newbieManager:onAwake()
CS.BindWidget(newbieManager.getWidget(),newbieManager)
end

function newbieManager:onClick(cmpId,name)
newbieControl.onClick(cmpId)
end

function newbieManager:onClickFinished(cmpId)
newbieControl.onClickFinished(cmpId)
end


function newbieManager:onClickBlock(screenPos)
newbieControl.log('点击黑幕')
newbieControl.tryClickEntity(screenPos)
if _clickBlockAction then
_clickBlockAction()
end
_clickBlockAction=nil
end

function newbieManager:onAddComponent(cmpId)
newbieControl.log('启用指引控件：',cmpId)
newbieControl.enableUIComponent(cmpId)
end

function newbieManager:onRemoveComponent(cmpId)
newbieControl.log('删除指引控件：',cmpId)
newbieControl.disableUIComponent(cmpId)
end

function newbieManager:onSkipClick()
newbieControl.disableBloker()
newbieControl.interruptNewbie()
end


function newbieManager.startNewbie(...)
return newbieControl.startNewbie(...)
end


function newbieManager.skipNewbie()
newbieControl.interruptNewbie()
end

function newbieManager:getNewbieId()
local ret=newbieControl.getNewbieId()
return ret
end

function newbieManager.startMask(cmpId,delay,duration,leftoffset,topoffset,rightoffset,bottomoffset)
if delay==nil then delay=0 end
if duration==nil then duration=1 end
if leftoffset==nil then leftoffset=0 end
if topoffset==nil then topoffset=0 end
if rightoffset==nil then rightoffset=0 end
if bottomoffset==nil then bottomoffset=0 end
_startMark(_instance,cmpId,delay,duration,leftoffset,topoffset,rightoffset,bottomoffset)
end


function newbieManager.startEntityMask(entityinfo)
local entityType=entityinfo.entityType
if entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eBuild then
local rect=entityinfo.rect
local pos=Vector2(rect.x,rect.z)
local pos1=Vector2(rect.w,rect.y)
_startWorldPosMask(_instance,pos,pos1,0)
end
end

function newbieManager.enableMask(flag)
_enableMask(_instance,flag)
end

function newbieManager.stopMask()
newbieManager.startMask('')
end

function newbieManager.revertMask()
_revertMask(_instance)
end

function newbieManager.finishNewBieComponent(cmpId)
newbieManager.removeClickAction(cmpId)
newbieManager.resetSortLayer(cmpId)
newbieManager.resetUITransformTop(cmpId)
end

function newbieManager.addClickAction(cmpId)

_addClickAction(_instance,cmpId)
end

function newbieManager.removeClickAction(cmpId)

_removeClickAction(_instance,cmpId)
end

function newbieManager.setBlockAction(action)
_clickBlockAction=action
end

function newbieManager.getTargetSize(cmpId)
return _getMarkTargetSize(_instance,cmpId)
end

function newbieManager.clickUITarget(cmpId)
_clickTarget(_instance,cmpId)
end

function newbieManager.hasNewBieComponent(cmpId)
return _hasNewBieComponent(_instance,cmpId)
end

function newbieManager.hasNewBieActiveComponent(cmpId)
return _hasNewBieActiveComponent(_instance,cmpId)
end

function newbieManager.enableBloker()
if _isEnableBlock then return end
_isEnableBlock=true

_enableBloker(_instance)
end

function newbieManager.disableBloker()
if not _isEnableBlock then return end
_isEnableBlock=false

_disableBloker(_instance)
end





function newbieManager.setSortLayer(cmpId,layer,order)

_setSortLayer(_instance,cmpId,layer,order)
end

function newbieManager.resetSortLayer(cmpId)

_resetSortLayer(_instance,cmpId)
end


function newbieManager.setUITransformTopWithCamera(cmpId,camera)

_setUITransformTopWithCamera(_instance,cmpId,camera)
end

function newbieManager.setUITransformTop(cmpId)

_setUITransformTop(_instance,cmpId)
end

function newbieManager.resetUITransformTop(cmpId)

_resetUITransformTop(_instance,cmpId)
end


function newbieManager.setEntityTransformTop(guid,camera)

_setEntityTransformTop(_instance,guid,camera)
end

function newbieManager.resetEntityTransformTop(guid)

_resetEntityTransformTop(_instance,guid)
end

function newbieManager.resetEntityTopCamera()
_resetTopCamera(_instance)
end





function newbieManager.getWidget()
return _instance.WidgetBase
end

function newbieManager.setSkipActive(skip)
local widget=newbieManager.getWidget()
widget:SetChildActive(2,not skip)
end

function newbieManager:onSkipClick()

newbieManager.skipNewbie()
end

function newbieManager:OnStart()

end

function newbieManager.onBuildEvent(typo,arg1,arg2,arg3)
if typo==buildingEvent.zongmenLevelUp then
local level=arg1
newbieManager.startNewbie(NEW_BIE_CND_TYPE.eLevel,level)
elseif typo==buildingEvent.storageBuilding then




end
end

function newbieManager.onTaskChange(taskid,taskstate)
local typo=newbieConfig.getTaskNewBieType(taskstate)
newbieManager.startNewbie(typo,taskid,taskstate)
end

function newbieManager.onWorldBlockStateChanged(world,block,state)
if state==worldBlockModel.BLOCKSTATE.OPEN then
newbieManager.startNewbie(NEW_BIE_CND_TYPE.eWorldBlock,world,block)
end
end
