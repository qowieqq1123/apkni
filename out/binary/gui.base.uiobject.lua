UIObject=simple_class()

function UIObject:__init(owner,id)
self.__owner=owner
self.__id=id
if self.init then
self:init()
end
end

function UIObject:getID()

return self.__id
end

function UIObject:onRelease()
self.__owner=nil
self.__id=nil
self.__text=nil
self.__active=nil
end

function UIObject:checkRelease()
return self.__id==nil
end

function UIObject:getTransform()
return self.__owner:getChildGameObject(self.__id).transform
end

function UIObject:getGameObject()
return self.__owner:getChildGameObject(self.__id)
end


function UIObject:setActive(active)
if self.__active~=active then
self.__active=active
self.__owner:setChildActive(self.__id,active)
end
end





function UIObject:setAnchors(xAnchors,yAnchors,xPivot,yPivot)
self.__owner:setChildAnchors(self.__id,xAnchors,yAnchors,xPivot,yPivot)
end
function UIObject:setChildPivot(pivot)
self.__owner:setChildPivot(self.__id,pivot)
end
function UIObject:setChildAnimatorEnable(flag)
self.__owner:setChildAnimatorEnable(self.__id,flag)
end



function UIObject:setAnimationID(animationID,c)
self.__owner:setChildAnimationID(self.__id,animationID,c)
end


function UIObject:setAnimationStringID(animationstring)
self.__owner:setChildAnimationStringID(self.__id,animationstring)
end


function UIObject:setAnimator(nStateID)
self.__owner:setChildAnimator(self.__id,nStateID)
end



function UIObject:setAnimatorInteger(name,id,isUseTringger)
self.__owner:setChildAnimatorInteger(self.__id,name,id,isUseTringger)
end

function UIObject:setChildAnimatorParameter(name,type,value)
self.__owner:setChildAnimatorParameter(self.__id,name,type,value)
end



function UIObject:setInteractable(active)
self.__owner:setChildInteractable(self.__id,active)
end



function UIObject:setLocalPos(x,y,z)
self.__owner:setChildLocalPos(self.__id,x,y,z)
end


function UIObject:setLocalPosX(x)
self.__owner:setChildLocalPosX(self.__id,x)
end


function UIObject:setLocalPosY(y)
self.__owner:setChildLocalPosY(self.__id,y)
end




function UIObject:setRotation(x,y,z)
self.__owner:setChildRotation(self.__id,x,y,z)
end
function UIObject:setChildDORotation(endValue,duration,mode,onComplete)
return self.__owner:setChildDORotation(self.__id,endValue,duration,mode,onComplete)
end



function UIObject:setScale(scale)
self.__owner:setChildScale(self.__id,scale)
end
function UIObject:getScale()
return self.__owner:getChildScale(self.__id)
end


function UIObject:setChildPosition(pos)
self.__owner:setChildPosition(self.__id,pos)
end

function UIObject:getChildPosition()
return self.__owner:getChildPosition(self.__id)
end

function UIObject:setChildSizeDelta(x,y)
self.__owner:setChildSizeDelta(self.__id,x,y)
end

function UIObject:setChildSizeDeltaEx(ftype,x,y)
self.__owner:setChildSizeDeltaEx(self.__id,ftype,x,y)
end

function UIObject:getChildSizeDeltaX()
return self.__owner:getChildSizeDeltaX(self.__id)
end

function UIObject:getChildSizeDeltaY()
return self.__owner:getChildSizeDeltaY(self.__id)
end

function UIObject:getChildRectWidth()
return self.__owner:getChildRectWidth(self.__id)
end

function UIObject:getChildRectHeight()
return self.__owner:getChildRectHeight(self.__id)
end



function UIObject:setChildUIScreenPos(pos)
self.__owner:setChildUIScreenPos(self.__id,pos)
end

function UIObject:setChildUIScreenPosWithOffset(posx,posy,offsetx,offsety)
self.__owner:setChildUIScreenPosWithOffset(self.__id,posx,posy,offsetx or 0,offsety or 0)
end

function UIObject:getChildUIScreenPos(useMapCamera)
return self.__owner:getChildUIScreenPos(self.__id,useMapCamera)
end

function UIObject:getChildUIScreenPos2Local(pos)
return self.__owner:getChildUIScreenPos2Local(self.__id,pos)
end



function UIObject:setChildPos(x,y,z)
self.__owner:setChildPos(self.__id,x,y,z)
end

function UIObject:setChildLocalPosition(pos)
self.__owner:setChildLocalPosition(self.__id,pos)
end



function UIObject:setGray(isGray)
self.__owner:setChildGray(self.__id,isGray)
end



function UIObject:setColor(color)
self.__owner:setChildColor(self.__id,color)
end



function UIObject:setChildTargetCellPos(pos)
self.__owner:setChildTargetCellPos(self.__id,pos)
end

function UIObject:getChildWidgetBase()
return self.__owner:getChildWidgetBase(self.__id)
end

function UIObject:setChildAnchoredPosition(pos)
self.__owner:setChildAnchoredPosition(self.__id,pos)
end

function UIObject:setChildAnchoredPos(x,y)
self.__owner:setChildAnchoredPos(self.__id,x,y)
end

function UIObject:getChildAnchoredPosition()
return self.__owner:getChildAnchoredPosition(self.__id)
end

function UIObject:getChildScreenPointToLocalPointRectangle()
return self.__owner:getChildScreenPointToLocalPointRectangle(self.__id)
end

function UIObject:setChildAnchoredPosition3D(pos)
self.__owner:setChildAnchoredPosition3D(self.__id,pos)
end

function UIObject:getChildAnchoredPosition3D()
return self.__owner:getChildAnchoredPosition3D(self.__id)
end

function UIObject:getChildLocalPosition()
return self.__owner:getChildLocalPosition(self.__id)
end

function UIObject:setChildUITouchEvent(onClick,onUp,onDown,onLongTouch)
self.__owner:setChildUITouchEvent(self.__id,onClick,onUp,onDown,onLongTouch)
end


function UIObject:setChildScrollViewInit(align,usePool,clickEvent,longTouchEvent)
self.__owner:setChildScrollViewInit(self.__id,align,usePool,clickEvent,longTouchEvent)
end

function UIObject:setChildScrollViewCreateGrids(num,col,ani)
self.__owner:setChildScrollViewCreateGrids(self.__id,num,col,ani or false)
end

function UIObject:setChildScrollViewDelayCreateGrids(num,col,delay,sNum,scroll,alignEnd,onCreateGrid)
self.__owner:setChildScrollViewDelayCreateGrids(self.__id,num,col,delay,sNum,scroll,alignEnd,onCreateGrid)
end

function UIObject:setChildScrollViewStopGridCreate()
self.__owner:setChildScrollViewStopGridCreate(self.__id)
end

function UIObject:getChildScrollViewItemWidget(gridIndex)
return self.__owner:getChildScrollViewItemWidget(self.__id,gridIndex)
end

function UIObject:getChildScrollViewItemComponent(gridIndex,name)
return self.__owner:getChildScrollViewItemComponent(self.__id,gridIndex,name)
end

function UIObject:setChildScrollViewSelectItem(gridIndex,animation,invokeAction,alignEnd)
self.__owner:setChildScrollViewSelectItem(self.__id,gridIndex,animation,invokeAction,alignEnd)
end

function UIObject:getChildScrollViewItemWidgets()
return self.__owner:getChildScrollViewItemWidgets(self.__id)
end

function UIObject:setChildScrollViewChangeItemList(sIndex,dIndex,refreshPos)
self.__owner:setChildScrollViewChangeItemList(self.__id,sIndex,dIndex,refreshPos)
end

function UIObject:setChildScrollViewMoveItemToIndexPos(sIndex,duration)
return self.__owner:setChildScrollViewMoveItemToIndexPos(self.__id,sIndex,duration)
end

function UIObject:setChildScrollViewResetContentSize(num,col)
self.__owner:setChildScrollViewResetContentSize(self.__id,num,col)
end

function UIObject:setChildScrollRectEnable(flag)
self.__owner:setChildScrollRectEnable(self.__id,flag)
end

function UIObject:setChildScrollViewTriggerScrollEvent()
self.__owner:setChildScrollViewTriggerScrollEvent(self.__id)
end





function UIObject:setChildIconFillAmount(fillValue)
self.__owner:setChildIconFillAmount(self.__id,fillValue)
end

function UIObject:getChildIconFillAmount()
return self.__owner:getChildIconFillAmount(self.__id)
end

function UIObject:setChildImageDOFillAmount(endValue,duration,onComplete)
return self.__owner:setChildImageDOFillAmount(self.__id,endValue,duration,onComplete)
end

function UIObject:setChildIcon(iconname,native)
self.__owner:setChildIcon(self.__id,iconname,native)
end

function UIObject:setCSImageSprite(abname,asset)
self.__owner:setChildCSImageSprite(self.__id,abname,asset)
end

function UIObject:setChildImageExGray(flag)
self.__owner:setChildImageExGray(self.__id,flag)
end




function UIObject:setChildUIModelShowTarget(modelID,size,componnets,animationID,stopAnim,softMask,fadeIn,action)
self.__owner:setChildUIModelShowTarget(self.__id,modelID,size,componnets,animationID,stopAnim or false,softMask or false,fadeIn or 0,action)
end
function UIObject:setChildUIModelShowTargetOffset(offsetX,offsetY)
self.__owner:setChildUIModelShowTargetOffset(self.__id,offsetX,offsetY)
end
function UIObject:setChildUIModelShowTargetScale(scale)
self.__owner:setChildUIModelShowTargetOffset(self.__id,scale)
end
function UIObject:setChildModelAnimationState(animationID,speed,action)
self.__owner:setChildModelAnimationState(self.__id,animationID,speed or 1,action or nil)
end
function UIObject:setChildUIModelRemoveTarget()
self.__owner:setChildUIModelRemoveTarget(self.__id)
end
function UIObject:setChildUIModelShowSlotDisplayIndex(slotName,displayIndex)
self.__owner:setChildUIModelShowSlotDisplayIndex(self.__id,slotName,displayIndex)
end
function UIObject:setChildUIModelShowFlipX(flipX)
self.__owner:setChildUIModelShowFlipX(self.__id,flipX)
end
function UIObject:setChildAddSkeletonSlot(targetSlotName,slotName,id)
self.__owner:setChildAddSkeletonSlot(self.__id,targetSlotName,slotName,id)
end
function UIObject:setChildUIModelMount(mountBodyID,mountSlots,mountHP,scale,offset,onMountFinish)
self.__owner:setChildUIModelMount(self.__id,mountBodyID,mountSlots,mountHP,scale,offset,onMountFinish)
end
function UIObject:setChildUIModelUnMount()
self.__owner:setChildUIModelUnMount(self.__id)
end
function UIObject:setChildUIModelShowColor(color)
self.__owner:setChildUIModelShowColor(self.__id,color)
end

function UIObject:setChildUIModelEnableInitUISpinePara(canvasGroupCompatible,PMAVertexColor)
if api_Available_SetChildUIModelEnableInitUISpinePara()then
self.__owner:setChildUIModelEnableInitUISpinePara(self.__id,canvasGroupCompatible,PMAVertexColor)
end
end

function UIObject:setChildUIModelMountSeparatorSlot(sSlotName)
if api_Available_SetChildUIModelMountSeparatorSlot()then
self.__owner:setChildUIModelMountSeparatorSlot(self.__id,sSlotName)
end
end

function UIObject:setChildUIAnimatorPrefabLoaderCreate(abname,assestNameD,callback)
self.__owner:setChildUIAnimatorPrefabLoaderCreate(self.__id,abname,assestNameD,callback)
end


function UIObject:addChildUIAnimatorPrefabEventInt(eventTime,functionName,intParam)
self.__owner:addChildUIAnimatorPrefabEventInt(self.__id,eventTime,functionName,intParam)
end

function UIObject:setChildShowEffect(effectid,show)
self.__owner:setChildShowEffect(self.__id,effectid,show)
end
function UIObject:setChildShowEffectEx(effectID,sortingLayer,sortingOrder,show)
self.__owner:setChildShowEffectEx(self.__id,effectID,sortingLayer,sortingOrder,show)
end

function UIObject:setChildDragonTarget(modelID,size,componnets,animationID,stopAnim,stopProgress,softMask,action,fadetime)
self.__owner:setChildDragonTarget(self.__id,modelID,size,componnets,animationID,stopAnim or false,stopProgress or 0,softMask or false,fadetime or 0,action)
end

function UIObject:setChildDragonSlotAction(action)
self.__owner:setChildDragonSlotAction(self.__id,action)
end

function UIObject:getChildDragonSlotTransform(slotName)
return self.__owner:getChildDragonSlotTransform(self.__id,slotName)
end




function UIObject:setChildUIPolygonImage(verticesDistancea,rot)
self.__owner:setChildUIPolygonImage(self.__id,verticesDistancea,rot)
end




function UIObject:setChildLayoutGroupCreateItems(num,callback)
self.__owner:setChildLayoutGroupCreateItems(self.__id,num,callback)
end

function UIObject:setChildLayoutGroupClearAllItems()
self.__owner:setChildLayoutGroupClearAllItems(self.__id)
end

function UIObject:getChildLayoutGroupGridList()
return self.__owner:getChildLayoutGroupGridList(self.__id)
end

function UIObject:getChildLayoutGroupGridItem(gridIdx)
return self.__owner:getChildLayoutGroupGridItem(self.__id,gridIdx)
end

function UIObject:getChildCommonLayoutGroupWidgetList()
return self.__owner:getChildCommonLayoutGroupWidgetList(self.__id)
end

function UIObject:getChildCommonLayoutGroupWidgetItem(gridIdx)
return self.__owner:getChildCommonLayoutGroupWidgetItem(self.__id,gridIdx)
end

function UIObject:setChildBlockLayoutGroupCreateItem(prefabIdx)
self.__owner:setChildBlockLayoutGroupCreateItem(self.__id,prefabIdx)
end

function UIObject:getChildLayoutGroupBlockList()
return self.__owner:getChildLayoutGroupBlockList(self.__id)
end

function UIObject:setChildLayoutGroupAddItem()
self.__owner:setChildLayoutGroupAddItem(self.__id)
end

function UIObject:setChildLayoutGroupRemoveItem()
self.__owner:setChildLayoutGroupRemoveItem(self.__id)
end

function UIObject:setChildDynamicGridCreateItems(num,callback)
self.__owner:setChildDynamicGridCreateItems(self.__id,num,callback)
end

function UIObject:getChildDynamicGridItem(gridIdx)
return self.__owner:getChildDynamicGridItem(self.__id,gridIdx)
end

function UIObject:setChildDynamicGridJump(jumpIndex,rate,moveTime)
self.__owner:setChildDynamicGridJump(self.__id,jumpIndex,rate,moveTime)
end

function UIObject:setChildDynamicGridJumpPage(page,moveTime)
self.__owner:setChildDynamicGridJumpPage(self.__id,page,moveTime)
end


function UIObject:initDragItem(cIndex,beginEvent,dragEvent,endEvent)
self.__owner:initDragItem(self.__id,cIndex,beginEvent,dragEvent,endEvent)
end
function UIObject:initDragView(beginEvent,dragEvent,endEvent)
self.__owner:initDragView(self.__id,beginEvent,dragEvent,endEvent)
end

function UIObject:addDragViewItemPos(index,x,y)
self.__owner:addDragViewItemPos(self.__id,index,x,y)
end

function UIObject:getDragViewItem(index)
return self.__owner:getDragViewItem(self.__id,index)
end




function UIObject:setChildDOAnchorPos(endValue,duration,onComplete)
return self.__owner:setChildDOAnchorPos(self.__id,endValue,duration,onComplete)
end

function UIObject:setChildDOAnchorPos3D(endValue,duration,onComplete)
return self.__owner:setChildDOAnchorPos3D(self.__id,endValue,duration,onComplete)
end

function UIObject:setChildDOAnchorPosX(endValue,duration,onComplete)
return self.__owner:setChildDOAnchorPosX(self.__id,endValue,duration,onComplete)
end

function UIObject:setChildDOAnchorPosY(endValue,duration,onComplete)
return self.__owner:setChildDOAnchorPosY(self.__id,endValue,duration,onComplete)
end

function UIObject:setChildDOSizeDelta(size,duration,onComplete)
return self.__owner:setChildDOSizeDelta(self.__id,size,duration,onComplete)
end





function UIObject:setChildLongTouch(id,time,callback)
return self.__owner:setChildLongTouch(self.__id,id,time,callback)
end

function UIObject:setChildLongPress(id,callback)
return self.__owner:setChildLongPress(self.__id,id,callback)
end

function UIObject:setChildLongPressStop()
return self.__owner:setChildLongPressStop(self.__id)
end


function UIObject:setChildCanvasGroupAlpha(alpha)
return self.__owner:setChildCanvasGroupAlpha(self.__id,alpha)
end

function UIObject:setChildCanvasGroupDOFade(endValue,duration,onComplete)
return self.__owner:setChildCanvasGroupDOFade(self.__id,endValue,duration,onComplete)
end

function UIObject:setChildCanvasGroupRaycast(enable)
self.__owner:setChildCanvasGroupRaycast(self.__id,enable)
end

function UIObject:getChildCanvas()
return self.__owner:getChildCanvas(self.__id)
end

function UIObject:setChildRemoveCanvas()
return self.__owner:setChildRemoveCanvas(self.__id)
end

function UIObject:setChildCanvas(sortLayer,sortOrder)
self.__owner:setChildCanvas(self.__id,sortLayer,sortOrder)
end

function UIObject:setChildCanvasEx(sortLayer,sortOrder)
self.__owner:setChildCanvasEx(self.__id,sortLayer,sortOrder)
end

function UIObject:getCommonComponent(name)
return self.__owner:getCommonComponent(self.__id,name)
end

function UIObject:getChildInstanceComponent(guid,name)
return self.__owner:getChildInstanceComponent(self.__id,guid,name)
end

function UIObject:setChildUIProgressbar(currVal,maxVal,withTween)
self.__owner:setChildUIProgressbar(self.__id,currVal,maxVal,withTween)
end



function UIObject:setChildDOScale(endValue,duration,onComplete)
return self.__owner:setChildDOScale(self.__id,endValue,duration,onComplete)
end
function UIObject:setChildDOScaleX(endValue,duration,onComplete)
return self.__owner:setChildDOScaleX(self.__id,endValue,duration,onComplete)
end
function UIObject:setChildDOScaleY(endValue,duration,onComplete)
return self.__owner:setChildDOScaleY(self.__id,endValue,duration,onComplete)
end
function UIObject:setChildDOScaleZ(endValue,duration,onComplete)
return self.__owner:setChildDOScaleZ(self.__id,endValue,duration,onComplete)
end
function UIObject:setChildDOMove(endValue,duration,onComplete)
return self.__owner:setChildDOMove(self.__id,endValue,duration,onComplete)
end
function UIObject:setChildDOLocalMove(endValue,duration,onComplete)
return self.__owner:setChildDOLocalMove(self.__id,endValue,duration,onComplete)
end
function UIObject:setChildDOLocalMoveX(endValue,duration,onComplete)
return self.__owner:setChildDOLocalMoveX(self.__id,endValue,duration,onComplete)
end
function UIObject:setChildDOLocalMoveY(endValue,duration,onComplete)
return self.__owner:setChildDOLocalMoveY(self.__id,endValue,duration,onComplete)
end
function UIObject:setChildDOLocalMoveZ(endValue,duration,onComplete)
return self.__owner:setChildDOLocalMoveZ(self.__id,endValue,duration,onComplete)
end
function UIObject:setChildDOPunchRotation(punch,duration,vibrato,elasticity,onComplete)
return self.__owner:setChildDOPunchRotation(self.__id,punch,duration,vibrato,elasticity,onComplete)
end


function UIObject:setChildTrendsTextPlay(txt,speed,callback)
self.__owner:setChildTrendsTextPlay(self.__id,txt,speed,callback)
end
function UIObject:setChildTrendsTextStop()
self.__owner:setChildTrendsTextStop(self.__id)
end



function UIObject:setChildDrawBrushClear()
self.__owner:setChildDrawBrushClear(self.__id)
end

function UIObject:getChildTextureCompareValue()
return self.__owner:getChildTextureCompareValue(self.__id)
end


function UIObject:setChildComboBoxInit(onChange,onClick,onSelectCheck,onShowCheck)
self.__owner:setChildComboBoxInit(self.__id,onChange,onClick,onSelectCheck,onShowCheck)
end

function UIObject:setChildComboBoxOption(select,optionArray)
self.__owner:setChildComboBoxOption(self.__id,select,optionArray)
end

function UIObject:setChildComboBoxSelect(select)
self.__owner:setChildComboBoxSelect(self.__id,select)
end

function UIObject:setChildComboBoxChangeShow(bShow)
self.__owner:setChildComboBoxChangeShow(self.__id,bShow)
end


function UIObject:addLineRendererPos(uiPos)
self.__owner:addLineRendererPos(self.__id,uiPos)
end

function UIObject:setLineRendererPos(posIndex,uiPos)
self.__owner:setLineRendererPos(self.__id,posIndex,uiPos)
end

function UIObject:removeLineRendererPos()
self.__owner:removeLineRendererPos(self.__id)
end

function UIObject:setLineRendererPositionCount(num)
self.__owner:setLineRendererPositionCount(self.__id,num)
end

function UIObject:getLineRendererPositionCount()
return self.__owner:getLineRendererPositionCount(self.__id)
end

function UIObject:setChildButtonClickWithID(func,id,removeAllListeners)
self.__owner:setChildButtonClickWithID(self.__id,func,id,removeAllListeners)
end

function UIObject:getWidgetBase()
return self.__owner:getChildWidgetBase(self.__id)
end

function UIObject:setChildSliderInit(value,min,max,callback)
self.__owner:setChildSliderInit(self.__id,value,min,max,callback)
end

function UIObject:setChildSliderValue(value)
self.__owner:setChildSliderValue(self.__id,value)
end

function UIObject:setChildDOJump(endValue,jumpPower,numJumps,duration,onComplete)
return self.__owner:setChildDOJump(self.__id,endValue,jumpPower,numJumps,duration,onComplete)
end

function UIObject:setChildGraphicGray(flag,withChildren,includeInactive)
self.__owner:setChildGraphicGray(self.__id,flag,withChildren,includeInactive)
end



function UIObject:setChildDragZoomEnable(enable)
self.__owner:setChildDragZoomEnable(self.__id,enable)
end

function UIObject:subMoveToTargetPos(targetPos,duration,disableTouch,callBack)
self.__owner:subMoveToTargetPos(self.__id,targetPos,duration,disableTouch,callBack)
end

function UIObject:setChildZoomLimit(maxScale,minScale)
self.__owner:setChildZoomLimit(self.__id,maxScale,minScale)
end

function UIObject:setChildDragStartAndEndEvent(dragStartCallBack,dragEndCallBack)
self.__owner:setChildDragStartAndEndEvent(self.__id,dragStartCallBack,dragEndCallBack)
end

function UIObject:setChildDragAndZoomEvent(oneFingerDragCallBack,twoFingerDragCallBack,zoomCallBack)
self.__owner:setChildDragAndZoomEvent(self.__id,oneFingerDragCallBack,twoFingerDragCallBack,zoomCallBack)
end





function UIObject:setChildSpineAnimation(stateID,speed,onFinish)
self.__owner:setChildSpineAnimation(self.__id,stateID,speed,onFinish)
end



function UIObject:setChildNewBieComponentId(name)
self.__owner:setChildNewBieComponentId(self.__id,name)
end




local UIObjectPool={}
local UIObjectPoolMaxCount=256
local table_remove=table.remove
local UIObject_new=UIObject.new
local UIObject_init=UIObject.__init


function UIObject.get(owner,id)

local top=table_remove(UIObjectPool)
if top then
UIObject_init(top,owner,id)
return top
end
return UIObject_new(owner,id)
end


function UIObject.release(o)
if#UIObjectPool>UIObjectPoolMaxCount then
return
end

o:onRelease()
UIObjectPool[#UIObjectPool+1]=o
end
