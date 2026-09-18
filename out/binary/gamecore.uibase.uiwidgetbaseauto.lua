





function UIWidgetBase:get_WorldPos()
return self.widget:get_WorldPos()
end



function UIWidgetBase:set_WorldPos(value)
self.widget:set_WorldPos(value)
end


function UIWidgetBase:getChildTransformArrayLength()
return self.widget:GetChildTransformArrayLength()
end



function UIWidgetBase:getChildItemBase(index)
return self.widget:GetChildItemBase(index)
end





function UIWidgetBase:setSpriteAtlas(obj,iconPath,nativeSize)
self.widget:SetSpriteAtlas(obj,iconPath,nativeSize)
end



function UIWidgetBase:setLuaTable(table)
self.widget:SetLuaTable(table)
end


function UIWidgetBase:clearLuaTable()
self.widget:ClearLuaTable()
end







function UIWidgetBase:captureScreenBlurImage(index,cameraTra,iteration,spread,rtRate)
self.widget:CaptureScreenBlurImage(index,cameraTra,iteration,spread,rtRate)
end







function UIWidgetBase:enableCaptureScreenBlur(index,cameraTra,reset,iteration,spread)
self.widget:EnableCaptureScreenBlur(index,cameraTra,reset,iteration,spread)
end




function UIWidgetBase:disableCaptureScreenBlur(index,cameraTra)
self.widget:DisableCaptureScreenBlur(index,cameraTra)
end









function UIWidgetBase:enableCaptureScreen(index,cameraTra,reset,iteration,spread,rtrate,callback)
self.widget:EnableCaptureScreen(index,cameraTra,reset,iteration,spread,rtrate,callback)
end







function UIWidgetBase:setChildCaptureTexture(index,cameraTra,waterSpriteIndex,offsetX,offsetY)
self.widget:SetChildCaptureTexture(index,cameraTra,waterSpriteIndex,offsetX,offsetY)
end




function UIWidgetBase:saveTextue(index,savePath)
self.widget:SaveTextue(index,savePath)
end






function UIWidgetBase:croppingTexture(outImageIndex,cameraTra,leftDownPointIndex,callback)
self.widget:CroppingTexture(outImageIndex,cameraTra,leftDownPointIndex,callback)
end







function UIWidgetBase:setChildFightRenderToImage(index,enable,width,height,canvasIndex)
self.widget:SetChildFightRenderToImage(index,enable,width,height,canvasIndex)
end



function UIWidgetBase:getChildComboScrollViewIsExpending(index)
return self.widget:GetChildComboScrollViewIsExpending(index)
end






function UIWidgetBase:setChildComboScrollViewCreateGrids(index,row,colum,setContentZero)
self.widget:SetChildComboScrollViewCreateGrids(index,row,colum,setContentZero)
end



function UIWidgetBase:setChildComboScrollViewRemoveAllGrids(index)
self.widget:SetChildComboScrollViewRemoveAllGrids(index)
end




function UIWidgetBase:clickChildComboScrollViewMainItem(index,mainIndex)
self.widget:ClickChildComboScrollViewMainItem(index,mainIndex)
end




function UIWidgetBase:getChildComboScrollViewMainItem(index,mainIndex)
return self.widget:GetChildComboScrollViewMainItem(index,mainIndex)
end








function UIWidgetBase:setChildComboScrollViewActions(index,mainItemClickCB,subItemClickCB,onMainItemCreatedCB,onSubItemCreatedCB,onExpandCB)
self.widget:SetChildComboScrollViewActions(index,mainItemClickCB,subItemClickCB,onMainItemCreatedCB,onSubItemCreatedCB,onExpandCB)
end






function UIWidgetBase:setChildComboScrollViewRebuildGrids(index,mainIndex,subItemCount,action)
return self.widget:SetChildComboScrollViewRebuildGrids(index,mainIndex,subItemCount,action)
end



function UIWidgetBase:getChildComboScrollViewAllMainItemList(index)
return self.widget:GetChildComboScrollViewAllMainItemList(index)
end



function UIWidgetBase:getChildComboScrollViewAllSubItemList(index)
return self.widget:GetChildComboScrollViewAllSubItemList(index)
end





function UIWidgetBase:getChildComboScrollViewSubItemWidget(index,mainIndex,subIndex)
return self.widget:GetChildComboScrollViewSubItemWidget(index,mainIndex,subIndex)
end




function UIWidgetBase:setChildUIBaseScrollClickAction(viewIndex,e)
self.widget:SetChildUIBaseScrollClickAction(viewIndex,e)
end




function UIWidgetBase:setChildUIBaseScrollLongAction(viewIndex,e)
self.widget:SetChildUIBaseScrollLongAction(viewIndex,e)
end




function UIWidgetBase:setChildUIBaseScrollBindAction(viewIndex,e)
self.widget:SetChildUIBaseScrollBindAction(viewIndex,e)
end



function UIWidgetBase:setChildUIBaseScrollClearItems(viewIndex)
self.widget:SetChildUIBaseScrollClearItems(viewIndex)
end



function UIWidgetBase:setChildStopAllCoroutines(viewIndex)
self.widget:SetChildStopAllCoroutines(viewIndex)
end




function UIWidgetBase:setChildUIBaseScrollPropData(viewIndex,propData)
self.widget:SetChildUIBaseScrollPropData(viewIndex,propData)
end





function UIWidgetBase:setChildUIBaseScrollReplacePropData(viewIndex,startIdx,propData)
self.widget:SetChildUIBaseScrollReplacePropData(viewIndex,startIdx,propData)
end






function UIWidgetBase:setChildUIBaseScrollData(viewIndex,index,key,val)
self.widget:SetChildUIBaseScrollData(viewIndex,index,key,val)
end




function UIWidgetBase:setChildUIBaseScrollRecylePropData(viewIndex,propData)
self.widget:SetChildUIBaseScrollRecylePropData(viewIndex,propData)
end





function UIWidgetBase:setChildUIBaseScrollClearPropData(viewIndex,startIdx,endIdx)
self.widget:SetChildUIBaseScrollClearPropData(viewIndex,startIdx,endIdx)
end







function UIWidgetBase:setChildUIBaseScrollGridsByNum(viewIndex,tNum,row,colum,setZero)
self.widget:SetChildUIBaseScrollGridsByNum(viewIndex,tNum,row,colum,setZero)
end




function UIWidgetBase:getChildUIScrollBaseItemById(viewIndex,id)
return self.widget:GetChildUIScrollBaseItemById(viewIndex,id)
end




function UIWidgetBase:getChildUIScrollBaseItemByIndex(viewIndex,index)
return self.widget:GetChildUIScrollBaseItemByIndex(viewIndex,index)
end






function UIWidgetBase:setUIScrollViewBaseItemByIndex(viewIndex,index,key,val)
self.widget:SetUIScrollViewBaseItemByIndex(viewIndex,index,key,val)
end




function UIWidgetBase:setUIScrollViewBaseItemFresh(viewIndex,index)
self.widget:SetUIScrollViewBaseItemFresh(viewIndex,index)
end




function UIWidgetBase:setUIScrollViewBaseItemFreshById(viewIndex,id)
self.widget:SetUIScrollViewBaseItemFreshById(viewIndex,id)
end




function UIWidgetBase:setUIScrollViewBaseItemFreshByGUID(viewIndex,guid)
self.widget:SetUIScrollViewBaseItemFreshByGUID(viewIndex,guid)
end





function UIWidgetBase:setUIScrollViewBaseItemProp(viewIndex,index,prop)
self.widget:SetUIScrollViewBaseItemProp(viewIndex,index,prop)
end




function UIWidgetBase:checkUIScrollViewBaseItemInViewRect(viewIndex,index)
return self.widget:CheckUIScrollViewBaseItemInViewRect(viewIndex,index)
end





function UIWidgetBase:setUIScrollViewBaseBtnClickAction(viewIndex,btnIdx,action)
self.widget:SetUIScrollViewBaseBtnClickAction(viewIndex,btnIdx,action)
end





function UIWidgetBase:setUIScrollViewBaseItemAction(viewIndex,createAction,freshAction)
self.widget:SetUIScrollViewBaseItemAction(viewIndex,createAction,freshAction)
end




function UIWidgetBase:setUIScrollViewBaseJumpItem(viewIndex,jumpIndex)
self.widget:SetUIScrollViewBaseJumpItem(viewIndex,jumpIndex)
end




function UIWidgetBase:setUIScrollViewBaseJumpToLockX(viewIndex,jumpIndex)
self.widget:SetUIScrollViewBaseJumpToLockX(viewIndex,jumpIndex)
end




function UIWidgetBase:setUIScrollViewBaseJumpToLockY(viewIndex,jumpIndex)
self.widget:SetUIScrollViewBaseJumpToLockY(viewIndex,jumpIndex)
end




function UIWidgetBase:getUIScrollViewBaseCheckInShow(viewIndex,index)
return self.widget:GetUIScrollViewBaseCheckInShow(viewIndex,index)
end




function UIWidgetBase:setBaseItemChildID(index,id)
self.widget:SetBaseItemChildID(index,id)
end




function UIWidgetBase:setBaseItemChildGUID(index,guid)
self.widget:SetBaseItemChildGUID(index,guid)
end




function UIWidgetBase:setBaseItemChildIndex(index,idx)
self.widget:SetBaseItemChildIndex(index,idx)
end




function UIWidgetBase:setBaseItemChildAttach(index,attach)
self.widget:SetBaseItemChildAttach(index,attach)
end




function UIWidgetBase:setBaseItemClickEvent(index,action)
self.widget:SetBaseItemClickEvent(index,action)
end




function UIWidgetBase:setBaseItemLongTouchEvent(index,longAction)
self.widget:SetBaseItemLongTouchEvent(index,longAction)
end



function UIWidgetBase:getChildCSGUIBaseItem(index)
return self.widget:GetChildCSGUIBaseItem(index)
end




function UIWidgetBase:setChildSlowScrollClickAction(viewIndex,e)
self.widget:SetChildSlowScrollClickAction(viewIndex,e)
end




function UIWidgetBase:setChildSlowScrollLongAction(viewIndex,e)
self.widget:SetChildSlowScrollLongAction(viewIndex,e)
end



function UIWidgetBase:refreshSlowScrollAllItems(viewIndex)
self.widget:RefreshSlowScrollAllItems(viewIndex)
end




function UIWidgetBase:setChildSlowScrollBindAction(viewIndex,e)
self.widget:SetChildSlowScrollBindAction(viewIndex,e)
end




function UIWidgetBase:freshChildSlowScrollItem(viewIndex,index)
self.widget:FreshChildSlowScrollItem(viewIndex,index)
end




function UIWidgetBase:freshChildSlowScrollItemByGUID(viewIndex,guid)
self.widget:FreshChildSlowScrollItemByGUID(viewIndex,guid)
end







function UIWidgetBase:freshChildSlowScrollGrids(viewIndex,tNum,row,column,setZero)
self.widget:FreshChildSlowScrollGrids(viewIndex,tNum,row,column,setZero)
end




function UIWidgetBase:getChildSlowScrollItemById(viewIndex,id)
return self.widget:GetChildSlowScrollItemById(viewIndex,id)
end




function UIWidgetBase:getChildSlowScrollItemByIndex(viewIndex,index)
return self.widget:GetChildSlowScrollItemByIndex(viewIndex,index)
end




function UIWidgetBase:jumpChildSlowScrollItem(viewIndex,index)
self.widget:JumpChildSlowScrollItem(viewIndex,index)
end



function UIWidgetBase:clearChildSlowScrollItems(viewIndex)
self.widget:ClearChildSlowScrollItems(viewIndex)
end



function UIWidgetBase:setPropData(propData)
self.widget:SetPropData(propData)
end




function UIWidgetBase:setChildPropData(index,propData)
self.widget:SetChildPropData(index,propData)
end





function UIWidgetBase:setChildItemData(index,key,val)
self.widget:SetChildItemData(index,key,val)
end




function UIWidgetBase:setItemData(key,val)
self.widget:SetItemData(key,val)
end





function UIWidgetBase:setChildCommonItemSign(index,type,callback)
return self.widget:SetChildCommonItemSign(index,type,callback)
end



function UIWidgetBase:getChildUILoopListView(index)
return self.widget:GetChildUILoopListView(index)
end



function UIWidgetBase:getChildLoopListView2(index)
return self.widget:GetChildLoopListView2(index)
end



function UIWidgetBase:getChildUILoopTreeView(index)
return self.widget:GetChildUILoopTreeView(index)
end



function UIWidgetBase:getChildLoopTreeView(index)
return self.widget:GetChildLoopTreeView(index)
end




function UIWidgetBase:setChildDropDownChangeAction(index,action)
self.widget:SetChildDropDownChangeAction(index,action)
end



function UIWidgetBase:getChildDropDownItemText(index)
return self.widget:GetChildDropDownItemText(index)
end



function UIWidgetBase:getChildDropDownCaptionText(index)
return self.widget:GetChildDropDownCaptionText(index)
end




function UIWidgetBase:setChildDropDownItemText(index,txt)
self.widget:SetChildDropDownItemText(index,txt)
end




function UIWidgetBase:setChildDropDownCaptionText(index,txt)
self.widget:SetChildDropDownCaptionText(index,txt)
end




function UIWidgetBase:setChildDropDownOption(index,optionArray)
self.widget:SetChildDropDownOption(index,optionArray)
end




function UIWidgetBase:addChildDropDownOption(index,text)
self.widget:AddChildDropDownOption(index,text)
end



function UIWidgetBase:setChildDropDownClearOption(index)
self.widget:SetChildDropDownClearOption(index)
end




function UIWidgetBase:setChildDropDownValue(index,val)
self.widget:SetChildDropDownValue(index,val)
end



function UIWidgetBase:getChildDropDownValue(index)
return self.widget:GetChildDropDownValue(index)
end



function UIWidgetBase:setChildDropDownShowList(index)
self.widget:SetChildDropDownShowList(index)
end



function UIWidgetBase:setChildDropDownHideList(index)
self.widget:SetChildDropDownHideList(index)
end




function UIWidgetBase:getChildDropDownItemWidget(index,idx)
return self.widget:GetChildDropDownItemWidget(index,idx)
end




function UIWidgetBase:setChildDropDownClickAction(index,action)
self.widget:SetChildDropDownClickAction(index,action)
end




function UIWidgetBase:setChildDropDownSubmitAction(index,action)
self.widget:SetChildDropDownSubmitAction(index,action)
end




function UIWidgetBase:setChildDropDownCancelAction(index,action)
self.widget:SetChildDropDownCancelAction(index,action)
end




function UIWidgetBase:setChildDropDownLayoutedAction(index,action)
self.widget:SetChildDropDownLayoutedAction(index,action)
end




function UIWidgetBase:setChildDropDownCreatedAction(index,action)
self.widget:SetChildDropDownCreatedAction(index,action)
end







function UIWidgetBase:setChildComboBoxInit(index,onChange,onClick,onSelectCheck,onShowCheck)
self.widget:SetChildComboBoxInit(index,onChange,onClick,onSelectCheck,onShowCheck)
end





function UIWidgetBase:setChildComboBoxOption(index,select,optionArray)
self.widget:SetChildComboBoxOption(index,select,optionArray)
end




function UIWidgetBase:setChildComboBoxSelect(index,select)
self.widget:SetChildComboBoxSelect(index,select)
end




function UIWidgetBase:setChildComboBoxChangeShow(index,bShow)
self.widget:SetChildComboBoxChangeShow(index,bShow)
end




function UIWidgetBase:setChildScrollRectEnable(index,flag)
self.widget:SetChildScrollRectEnable(index,flag)
end



function UIWidgetBase:setStopChildScrollRect(index)
self.widget:SetStopChildScrollRect(index)
end




function UIWidgetBase:getChildScrollRectNormalizedPosition(index,isHorizontal)
return self.widget:GetChildScrollRectNormalizedPosition(index,isHorizontal)
end





function UIWidgetBase:setChildScrollRectNormalizedPosition(index,isHorizontal,value)
self.widget:SetChildScrollRectNormalizedPosition(index,isHorizontal,value)
end








function UIWidgetBase:setChildScrollRectNormalizedPosTo(index,value,speed,delay,ease,onComplete)
self.widget:SetChildScrollRectNormalizedPosTo(index,value,speed,delay,ease,onComplete)
end




function UIWidgetBase:setChildTargetCellPos(index,pos)
self.widget:SetChildTargetCellPos(index,pos)
end




function UIWidgetBase:setCanvasIndex(index,canvasIndex)
self.widget:SetCanvasIndex(index,canvasIndex)
end




function UIWidgetBase:setCanvasLayerOrder(index,order)
self.widget:SetCanvasLayerOrder(index,order)
end





function UIWidgetBase:setChildCanvas(index,sortLayer,sortOrder)
self.widget:SetChildCanvas(index,sortLayer,sortOrder)
end





function UIWidgetBase:setChildCanvasEx(index,sortLayer,sortOrder)
self.widget:SetChildCanvasEx(index,sortLayer,sortOrder)
end



function UIWidgetBase:setChildRemoveCanvas(index)
self.widget:SetChildRemoveCanvas(index)
end



function UIWidgetBase:getChildCanvas(index)
return self.widget:GetChildCanvas(index)
end





function UIWidgetBase:setChildSizeDelta(index,x,y)
self.widget:SetChildSizeDelta(index,x,y)
end






function UIWidgetBase:setChildSizeDeltaEx(index,ftype,x,y)
self.widget:SetChildSizeDeltaEx(index,ftype,x,y)
end



function UIWidgetBase:getChildSizeDeltaX(index)
return self.widget:GetChildSizeDeltaX(index)
end



function UIWidgetBase:getChildSizeDeltaY(index)
return self.widget:GetChildSizeDeltaY(index)
end



function UIWidgetBase:getChildRectWidth(index)
return self.widget:GetChildRectWidth(index)
end



function UIWidgetBase:getChildRectHeight(index)
return self.widget:GetChildRectHeight(index)
end







function UIWidgetBase:setChildRectByStretch(index,left,top,right,bottom)
self.widget:SetChildRectByStretch(index,left,top,right,bottom)
end







function UIWidgetBase:setChildAttachRectOffset(index,left,top,right,bottom)
self.widget:SetChildAttachRectOffset(index,left,top,right,bottom)
end








function UIWidgetBase:setChildAttachRectThreeOffset(index,offsetX,offsetY,centerX,centerY,guid)
self.widget:SetChildAttachRectThreeOffset(index,offsetX,offsetY,centerX,centerY,guid)
end



function UIWidgetBase:freshChildLayoutRectThree(index)
self.widget:FreshChildLayoutRectThree(index)
end








function UIWidgetBase:setLayoutRect(destindex,targetindex,offsetX,offsetY,centerX,centerY)
self.widget:SetLayoutRect(destindex,targetindex,offsetX,offsetY,centerX,centerY)
end







function UIWidgetBase:playURLVideo(index,url,fileName,loop,key)
self.widget:PlayURLVideo(index,url,fileName,loop,key)
end



function UIWidgetBase:pauseURLVideo(index)
self.widget:PauseURLVideo(index)
end



function UIWidgetBase:continueURLVideo(index)
self.widget:ContinueURLVideo(index)
end



function UIWidgetBase:stopURLVideo(index)
self.widget:StopURLVideo(index)
end




function UIWidgetBase:setURLVideoCompleteAction(index,action)
self.widget:SetURLVideoCompleteAction(index,action)
end




function UIWidgetBase:setURLVideoPathType(index,pathType)
self.widget:SetURLVideoPathType(index,pathType)
end




function UIWidgetBase:setURLVideoLoop(index,loop)
self.widget:SetURLVideoLoop(index,loop)
end




function UIWidgetBase:setURLVideoPrepareAction(index,action)
self.widget:SetURLVideoPrepareAction(index,action)
end




function UIWidgetBase:setURLVideoSpped(index,speed)
self.widget:SetURLVideoSpped(index,speed)
end




function UIWidgetBase:setURLVideoErrorAction(index,action)
self.widget:SetURLVideoErrorAction(index,action)
end




function UIWidgetBase:setURLVideoWaitAction(index,action)
self.widget:SetURLVideoWaitAction(index,action)
end




function UIWidgetBase:setURLVideoDownedAction(index,action)
self.widget:SetURLVideoDownedAction(index,action)
end




function UIWidgetBase:playClipVideo(index,loop)
self.widget:PlayClipVideo(index,loop)
end



function UIWidgetBase:pauseClipVideo(index)
self.widget:PauseClipVideo(index)
end



function UIWidgetBase:continueClipVideo(index)
self.widget:ContinueClipVideo(index)
end




function UIWidgetBase:stopClipVideo(index,prepare)
self.widget:StopClipVideo(index,prepare)
end



function UIWidgetBase:prepareClipVideo(index)
self.widget:PrepareClipVideo(index)
end




function UIWidgetBase:setClipVideoSpped(index,speed)
self.widget:SetClipVideoSpped(index,speed)
end




function UIWidgetBase:setClipVideoCompleteAction(index,action)
self.widget:SetClipVideoCompleteAction(index,action)
end




function UIWidgetBase:setClipVideoPrepareAction(index,action)
self.widget:SetClipVideoPrepareAction(index,action)
end




function UIWidgetBase:setClipVideoErrorAction(index,action)
self.widget:SetClipVideoErrorAction(index,action)
end




function UIWidgetBase:setClipVideoLoop(index,loop)
self.widget:SetClipVideoLoop(index,loop)
end




function UIWidgetBase:setChildLocalPosition(index,pos)
self.widget:SetChildLocalPosition(index,pos)
end



function UIWidgetBase:getChildLocalPosition(index)
return self.widget:GetChildLocalPosition(index)
end






function UIWidgetBase:setChildLocalPos(index,x,y,z)
self.widget:SetChildLocalPos(index,x,y,z)
end




function UIWidgetBase:setChildLocalPosX(index,x)
self.widget:SetChildLocalPosX(index,x)
end




function UIWidgetBase:setChildLocalPosY(index,y)
self.widget:SetChildLocalPosY(index,y)
end




function UIWidgetBase:setChildPosition(index,pos)
self.widget:SetChildPosition(index,pos)
end



function UIWidgetBase:getChildPosition(index)
return self.widget:GetChildPosition(index)
end






function UIWidgetBase:setChildPos(index,x,y,z)
self.widget:SetChildPos(index,x,y,z)
end




function UIWidgetBase:setChildAnchoredPosition(index,pos)
self.widget:SetChildAnchoredPosition(index,pos)
end



function UIWidgetBase:getChildAnchoredPosition(index)
return self.widget:GetChildAnchoredPosition(index)
end




function UIWidgetBase:setChildAnchoredPosition3D(index,pos)
self.widget:SetChildAnchoredPosition3D(index,pos)
end



function UIWidgetBase:getChildAnchoredPosition3D(index)
return self.widget:GetChildAnchoredPosition3D(index)
end





function UIWidgetBase:setChildAnchoredPos(index,x,y)
self.widget:SetChildAnchoredPos(index,x,y)
end







function UIWidgetBase:setChildUIScreenPosWithOffset(index,posX,posY,offsetX,offsetY)
self.widget:SetChildUIScreenPosWithOffset(index,posX,posY,offsetX,offsetY)
end




function UIWidgetBase:setChildUIScreenPos(index,pos)
self.widget:SetChildUIScreenPos(index,pos)
end




function UIWidgetBase:getChildUIScreenPos2Local(index,pos)
return self.widget:GetChildUIScreenPos2Local(index,pos)
end




function UIWidgetBase:getChildUIScreenPos(index,useMapCamera)
return self.widget:GetChildUIScreenPos(index,useMapCamera)
end




function UIWidgetBase:getChildRTCorners(index,type)
return self.widget:GetChildRTCorners(index,type)
end





function UIWidgetBase:setChildAnchors(index,min,max)
self.widget:SetChildAnchors(index,min,max)
end




function UIWidgetBase:setChildPivot(index,pivot)
self.widget:SetChildPivot(index,pivot)
end



function UIWidgetBase:setAsFirstSibling(index)
self.widget:SetAsFirstSibling(index)
end



function UIWidgetBase:setAsLastSibling(index)
self.widget:SetAsLastSibling(index)
end




function UIWidgetBase:setChildText(index,text)
self.widget:SetChildText(index,text)
end





function UIWidgetBase:setChildTextOverflow(index,hwMode,vwMode)
self.widget:SetChildTextOverflow(index,hwMode,vwMode)
end




function UIWidgetBase:setChildTextFontSize(index,fontSize)
self.widget:SetChildTextFontSize(index,fontSize)
end




function UIWidgetBase:setTextColor(index,color)
self.widget:SetTextColor(index,color)
end



function UIWidgetBase:getTextColor(index)
return self.widget:GetTextColor(index)
end




function UIWidgetBase:setTextAlpha(index,alpah)
self.widget:SetTextAlpha(index,alpah)
end




function UIWidgetBase:setTextLineSpacing(index,lineSpacing)
self.widget:SetTextLineSpacing(index,lineSpacing)
end




function UIWidgetBase:setChildOutlineEnabled(index,enabled)
self.widget:SetChildOutlineEnabled(index,enabled)
end




function UIWidgetBase:setChildOutlineColor(index,color)
self.widget:SetChildOutlineColor(index,color)
end




function UIWidgetBase:setRollNumText(index,value)
self.widget:SetRollNumText(index,value)
end





function UIWidgetBase:setChildSpriteRenderer(index,spritename,native)
self.widget:SetChildSpriteRenderer(index,spritename,native)
end






function UIWidgetBase:setChildSpriteRendererWithBundle(index,bundle,asset,native)
self.widget:SetChildSpriteRendererWithBundle(index,bundle,asset,native)
end




function UIWidgetBase:setChildSpriteRendererAlpha(index,color)
self.widget:SetChildSpriteRendererAlpha(index,color)
end





function UIWidgetBase:setChildSpriteRendererSortingLayer(index,sortingLayerName,sortingOrder)
self.widget:SetChildSpriteRendererSortingLayer(index,sortingLayerName,sortingOrder)
end





function UIWidgetBase:setChildIcon(index,iconname,native)
self.widget:SetChildIcon(index,iconname,native)
end




function UIWidgetBase:setChildIconAlpha(index,alpah)
self.widget:SetChildIconAlpha(index,alpah)
end




function UIWidgetBase:setChildIconFillAmount(index,fillValue)
self.widget:SetChildIconFillAmount(index,fillValue)
end



function UIWidgetBase:getChildIconFillAmount(index)
return self.widget:GetChildIconFillAmount(index)
end




function UIWidgetBase:setChildIconColor(index,color)
self.widget:SetChildIconColor(index,color)
end




function UIWidgetBase:setChildActive(index,active)
self.widget:SetChildActive(index,active)
end



function UIWidgetBase:getChildActiveSelf(index)
return self.widget:GetChildActiveSelf(index)
end



function UIWidgetBase:getChildActiveInHierarchy(index)
return self.widget:GetChildActiveInHierarchy(index)
end




function UIWidgetBase:setChildColor(index,color)
self.widget:SetChildColor(index,color)
end




function UIWidgetBase:setProgressBarAni(index,val)
self.widget:SetProgressBarAni(index,val)
end





function UIWidgetBase:setProgressBarAniWithTwoParams(index,val,maxVal)
self.widget:SetProgressBarAniWithTwoParams(index,val,maxVal)
end






function UIWidgetBase:setProgressBarAniWithThreeParams(index,val,maxVal,duration)
self.widget:SetProgressBarAniWithThreeParams(index,val,maxVal,duration)
end







function UIWidgetBase:setProgressBarAniWithFourParams(index,val,maxVal,duration,reverse)
self.widget:SetProgressBarAniWithFourParams(index,val,maxVal,duration,reverse)
end








function UIWidgetBase:setProgressBarAniWithFiveParams(index,current,val,maxVal,duration,reverse)
self.widget:SetProgressBarAniWithFiveParams(index,current,val,maxVal,duration,reverse)
end




function UIWidgetBase:setProgressBarAniUpdateAction(index,action)
self.widget:SetProgressBarAniUpdateAction(index,action)
end




function UIWidgetBase:setProgressBarAniFinishAction(index,action)
self.widget:SetProgressBarAniFinishAction(index,action)
end






function UIWidgetBase:setChildProgressOnTime(index,current,target,max)
self.widget:SetChildProgressOnTime(index,current,target,max)
end





function UIWidgetBase:setChildProgress(index,val,max)
self.widget:SetChildProgress(index,val,max)
end




function UIWidgetBase:setChildInteractable(index,active)
self.widget:SetChildInteractable(index,active)
end





function UIWidgetBase:setChildProgressInt64(index,val,max)
self.widget:SetChildProgressInt64(index,val,max)
end





function UIWidgetBase:setChildProgressUInt64(index,val,max)
self.widget:SetChildProgressUInt64(index,val,max)
end





function UIWidgetBase:setChildProgressValue(index,val,max)
self.widget:SetChildProgressValue(index,val,max)
end




function UIWidgetBase:setChildProgressText(index,text)
self.widget:SetChildProgressText(index,text)
end






function UIWidgetBase:setChildUIProgressbar(index,currVal,maxVal,withTween)
self.widget:SetChildUIProgressbar(index,currVal,maxVal,withTween)
end




function UIWidgetBase:setChildTextAlignment(index,textAnchor)
self.widget:SetChildTextAlignment(index,textAnchor)
end




function UIWidgetBase:setChildLinkImageTextBuildFinishAction(index,action)
self.widget:SetChildLinkImageTextBuildFinishAction(index,action)
end




function UIWidgetBase:setChildLinkImageExTextBuildFinishAction(index,action)
self.widget:SetChildLinkImageExTextBuildFinishAction(index,action)
end



function UIWidgetBase:setChildLinkImageTextResetData(index)
self.widget:SetChildLinkImageTextResetData(index)
end




function UIWidgetBase:setChildLinkImageTextMultiLineAction(index,action)
self.widget:SetChildLinkImageTextMultiLineAction(index,action)
end




function UIWidgetBase:setChildLinkImageTextClickAction(index,action)
self.widget:SetChildLinkImageTextClickAction(index,action)
end




function UIWidgetBase:setChildTMProText(index,txt)
self.widget:SetChildTMProText(index,txt)
end




function UIWidgetBase:setChildTMProColor(index,resColor)
self.widget:SetChildTMProColor(index,resColor)
end











function UIWidgetBase:playAudioSource(index,soundId,volumeWeight,loop,loopInterval,priority,minDistance,maxDistance,rolloffMode)
return self.widget:PlayAudioSource(index,soundId,volumeWeight,loop,loopInterval,priority,minDistance,maxDistance,rolloffMode)
end



function UIWidgetBase:playAudioSource(index)
self.widget:PlayAudioSource(index)
end



function UIWidgetBase:stopAudioSource(index)
self.widget:StopAudioSource(index)
end



function UIWidgetBase:pauseAudioSource(index)
self.widget:PauseAudioSource(index)
end



function UIWidgetBase:continueAudioSource(index)
self.widget:ContinueAudioSource(index)
end




function UIWidgetBase:setAudioSourceVolume(index,volume)
self.widget:SetAudioSourceVolume(index,volume)
end




function UIWidgetBase:setAudioSourceMute(index,mute)
self.widget:SetAudioSourceMute(index,mute)
end






function UIWidgetBase:setChildButtonClick(index,action,removeAllListeners,soundID)
self.widget:SetChildButtonClick(index,action,removeAllListeners,soundID)
end



function UIWidgetBase:setChildButtonSelect(index)
self.widget:SetChildButtonSelect(index)
end





function UIWidgetBase:setChildClick(index,name,removeAllListeners)
self.widget:SetChildClick(index,name,removeAllListeners)
end






function UIWidgetBase:setChildLongTouch(index,id,time,callback)
self.widget:SetChildLongTouch(index,id,time,callback)
end






function UIWidgetBase:setChildLongPress(index,id,callback,fnBack)
self.widget:SetChildLongPress(index,id,callback,fnBack)
end



function UIWidgetBase:setChildLongPressStop(index)
self.widget:SetChildLongPressStop(index)
end







function UIWidgetBase:setChildButtonClickWithID(index,func,id,removeAllListeners,soundID)
self.widget:SetChildButtonClickWithID(index,func,id,removeAllListeners,soundID)
end






function UIWidgetBase:setChildButtonClickDown(index,action,removeAllListeners,soundID)
self.widget:SetChildButtonClickDown(index,action,removeAllListeners,soundID)
end






function UIWidgetBase:setChildButtonClickUp(index,action,removeAllListeners,soundID)
self.widget:SetChildButtonClickUp(index,action,removeAllListeners,soundID)
end






function UIWidgetBase:setChildButtonPointEnterEvent(index,action,removeAllListeners,soundID)
self.widget:SetChildButtonPointEnterEvent(index,action,removeAllListeners,soundID)
end






function UIWidgetBase:setChildButtonPointExitEvent(index,action,removeAllListeners,soundID)
self.widget:SetChildButtonPointExitEvent(index,action,removeAllListeners,soundID)
end




function UIWidgetBase:setNameByIndex(index,name)
self.widget:SetNameByIndex(index,name)
end







function UIWidgetBase:setChildAnchors(index,xAnchors,yAnchors,xPivot,yPivot)
self.widget:SetChildAnchors(index,xAnchors,yAnchors,xPivot,yPivot)
end




function UIWidgetBase:setChildButtonInteractable(index,flag)
self.widget:SetChildButtonInteractable(index,flag)
end





function UIWidgetBase:setChildButtonEnable(index,flag,gray)
self.widget:SetChildButtonEnable(index,flag,gray)
end





function UIWidgetBase:switchChildParent(i0,i1,flag)
self.widget:SwitchChildParent(i0,i1,flag)
end





function UIWidgetBase:switchChildParent(i0,go,flag)
self.widget:SwitchChildParent(i0,go,flag)
end





function UIWidgetBase:lockAutoDestroyByCache(index,ab,flag)
self.widget:LockAutoDestroyByCache(index,ab,flag)
end




function UIWidgetBase:delayDestoryItemsByClonePool(index,frameNum)
self.widget:DelayDestoryItemsByClonePool(index,frameNum)
end







function UIWidgetBase:createCacheItemByClonePool(index,ab,asset,tNum,perNum)
self.widget:CreateCacheItemByClonePool(index,ab,asset,tNum,perNum)
end




function UIWidgetBase:setLoadFinishActionByClonePool(index,action)
self.widget:SetLoadFinishActionByClonePool(index,action)
end




function UIWidgetBase:setRefreshFinishActionByClonePool(index,action)
self.widget:SetRefreshFinishActionByClonePool(index,action)
end












function UIWidgetBase:creatItemByClonePool(index,abName,assetName,parentIdx,order,xPos,yPos,attach,showDelay,loadActive)
self.widget:CreatItemByClonePool(index,abName,assetName,parentIdx,order,xPos,yPos,attach,showDelay,loadActive)
end



function UIWidgetBase:setItemsSiblingByClonePool(index)
self.widget:SetItemsSiblingByClonePool(index)
end




function UIWidgetBase:setItemsActiveByClonePool(index,attachList)
self.widget:SetItemsActiveByClonePool(index,attachList)
end




function UIWidgetBase:deleteItemByClonePool(index,guid)
self.widget:DeleteItemByClonePool(index,guid)
end




function UIWidgetBase:deleteItemByClonePoolByAttach(index,attach)
self.widget:DeleteItemByClonePoolByAttach(index,attach)
end




function UIWidgetBase:getItemByClonePool(index,guid)
return self.widget:GetItemByClonePool(index,guid)
end




function UIWidgetBase:getItemWidgetByClonePool(index,guid)
return self.widget:GetItemWidgetByClonePool(index,guid)
end













function UIWidgetBase:creatItemByCloneListPool(index,len,abName,assetName,parentIdx,order,posx,posy,attach,showDelay,loadAvtive)
self.widget:CreatItemByCloneListPool(index,len,abName,assetName,parentIdx,order,posx,posy,attach,showDelay,loadAvtive)
end



function UIWidgetBase:freshItemListByCloneGameChatNotify(index)
self.widget:FreshItemListByCloneGameChatNotify(index)
end



function UIWidgetBase:freshContentSizeByCloneGameChatNotify(index)
self.widget:FreshContentSizeByCloneGameChatNotify(index)
end



function UIWidgetBase:freshByCloneGameChatNotify(index)
self.widget:FreshByCloneGameChatNotify(index)
end




function UIWidgetBase:setFitterChangeActionByCloneGameChatNotify(index,action)
self.widget:SetFitterChangeActionByCloneGameChatNotify(index,action)
end




function UIWidgetBase:setFitterChangeActionByCloneGameChatNotifyTwo(index,action)
self.widget:SetFitterChangeActionByCloneGameChatNotifyTwo(index,action)
end





function UIWidgetBase:jumpToAttachByCloneGameChatNotifyTwo(index,attach,next)
self.widget:JumpToAttachByCloneGameChatNotifyTwo(index,attach,next)
end




function UIWidgetBase:setFitterBeforeChangeActionByCloneGameChatNotifyTwo(index,action)
self.widget:SetFitterBeforeChangeActionByCloneGameChatNotifyTwo(index,action)
end




function UIWidgetBase:setEnableLayoutByCloneGameChatNotifyTwo(index,enable)
self.widget:SetEnableLayoutByCloneGameChatNotifyTwo(index,enable)
end




function UIWidgetBase:setChildStarLabel(index,starNum)
self.widget:SetChildStarLabel(index,starNum)
end




function UIWidgetBase:setChildStarNumber(index,starNum)
self.widget:SetChildStarNumber(index,starNum)
end




function UIWidgetBase:setChildGroundStarNum(index,starNum)
self.widget:SetChildGroundStarNum(index,starNum)
end





function UIWidgetBase:setChildSingleStar(index,starNum,otherfalse)
self.widget:SetChildSingleStar(index,starNum,otherfalse)
end





function UIWidgetBase:setChildSingleGroundStar(index,starNum,otherfalse)
self.widget:SetChildSingleGroundStar(index,starNum,otherfalse)
end





function UIWidgetBase:setChildStarLabelWithTemp(index,totalStar,solidStar)
self.widget:SetChildStarLabelWithTemp(index,totalStar,solidStar)
end









function UIWidgetBase:initChildSlotItem(index,icon,count,quality,indextext,itemId,series)
self.widget:InitChildSlotItem(index,icon,count,quality,indextext,itemId,series)
end









function UIWidgetBase:initChildSlotBagGridIte(index,icon,count,quality,bindFlag,newFlag,upFlag)
self.widget:InitChildSlotBagGridIte(index,icon,count,quality,bindFlag,newFlag,upFlag)
end




function UIWidgetBase:setChildSlotClick(index,action)
self.widget:SetChildSlotClick(index,action)
end






function UIWidgetBase:setChildSlotItemActiveByTag(comp,index,which,flag)
self.widget:SetChildSlotItemActiveByTag(comp,index,which,flag)
end





function UIWidgetBase:setChildSlotItemText(index,which,txt)
self.widget:SetChildSlotItemText(index,which,txt)
end






function UIWidgetBase:setChildSlotItemNumber(comp,index,which,number)
self.widget:SetChildSlotItemNumber(comp,index,which,number)
end





function UIWidgetBase:setChildCSImageIcon(index,icon,setNative)
self.widget:SetChildCSImageIcon(index,icon,setNative)
end






function UIWidgetBase:setChildCSImage(index,abname,asset,native)
self.widget:SetChildCSImage(index,abname,asset,native)
end





function UIWidgetBase:setChildCSImageSprite(index,abname,asset)
self.widget:SetChildCSImageSprite(index,abname,asset)
end





function UIWidgetBase:setChildCSImageMatTexture(index,key,tex)
self.widget:SetChildCSImageMatTexture(index,key,tex)
end






function UIWidgetBase:setChildCSImageMatTextureEx(index,key,markIdx,locks)
self.widget:SetChildCSImageMatTextureEx(index,key,markIdx,locks)
end





function UIWidgetBase:setChildCSImageMatVector(index,key,vec)
self.widget:SetChildCSImageMatVector(index,key,vec)
end




function UIWidgetBase:setChildCSImageMaterial(index,materialName)
self.widget:SetChildCSImageMaterial(index,materialName)
end





function UIWidgetBase:initMiniMap(index,posList,dataList)
self.widget:InitMiniMap(index,posList,dataList)
end





function UIWidgetBase:paintMiniMap(index,pos,data)
self.widget:PaintMiniMap(index,pos,data)
end







function UIWidgetBase:addMiniMapItem(index,GUID,position,eType,nType)
self.widget:AddMiniMapItem(index,GUID,position,eType,nType)
end








function UIWidgetBase:addMiniMapAssetItem(index,GUID,position,abName,asset,sync)
self.widget:AddMiniMapAssetItem(index,GUID,position,abName,asset,sync)
end



function UIWidgetBase:clearMiniMap(index)
self.widget:ClearMiniMap(index)
end




function UIWidgetBase:romoveMiniMapItem(index,GUID)
self.widget:RomoveMiniMapItem(index,GUID)
end






function UIWidgetBase:moveMiniMapItem(index,GUID,targetPos,moveSpeed)
self.widget:MoveMiniMapItem(index,GUID,targetPos,moveSpeed)
end






function UIWidgetBase:moveMiniMapCamera(index,position,callback,moveSpeed)
self.widget:MoveMiniMapCamera(index,position,callback,moveSpeed)
end




function UIWidgetBase:setChildRawImageTexture(index,texture)
self.widget:SetChildRawImageTexture(index,texture)
end







function UIWidgetBase:setClickerEvent(name,down,click,up,exit)
self.widget:SetClickerEvent(name,down,click,up,exit)
end



function UIWidgetBase:forceLayoutRect(index)
self.widget:ForceLayoutRect(index)
end



function UIWidgetBase:forceLayoutHorizontal(index)
self.widget:ForceLayoutHorizontal(index)
end



function UIWidgetBase:forceLayoutVertical(index)
self.widget:ForceLayoutVertical(index)
end





function UIWidgetBase:setChildSizeWithCurrentAnchors(index,axis,size)
self.widget:SetChildSizeWithCurrentAnchors(index,axis,size)
end




function UIWidgetBase:getChildMinSize(index,axis)
return self.widget:GetChildMinSize(index,axis)
end




function UIWidgetBase:getChildPreferredSize(index,axis)
return self.widget:GetChildPreferredSize(index,axis)
end




function UIWidgetBase:getChildFlexibleSize(index,axis)
return self.widget:GetChildFlexibleSize(index,axis)
end




function UIWidgetBase:setChildLayoutGroupEnable(index,enable)
self.widget:SetChildLayoutGroupEnable(index,enable)
end




function UIWidgetBase:setChildContentSizeFitterEnable(index,enable)
self.widget:SetChildContentSizeFitterEnable(index,enable)
end



function UIWidgetBase:setChildLayoutGrouprLayoutVertical(index)
self.widget:SetChildLayoutGrouprLayoutVertical(index)
end



function UIWidgetBase:setChildLayoutGroupLayoutHorizontal(index)
self.widget:SetChildLayoutGroupLayoutHorizontal(index)
end



function UIWidgetBase:setChildContentSizeFitterLayoutVertical(index)
self.widget:SetChildContentSizeFitterLayoutVertical(index)
end



function UIWidgetBase:setChildContentSizeFitterLayoutHorizontal(index)
self.widget:SetChildContentSizeFitterLayoutHorizontal(index)
end




function UIWidgetBase:setChildLayoutElementEnable(index,enable)
self.widget:SetChildLayoutElementEnable(index,enable)
end




function UIWidgetBase:setChildLayoutElementPreferredHeight(index,height)
self.widget:SetChildLayoutElementPreferredHeight(index,height)
end




function UIWidgetBase:setChildLayoutElementPreferredWidth(index,width)
self.widget:SetChildLayoutElementPreferredWidth(index,width)
end




function UIWidgetBase:setChildLayoutElementMinWidth(index,width)
self.widget:SetChildLayoutElementMinWidth(index,width)
end




function UIWidgetBase:setChildLayoutElementMinHeight(index,height)
self.widget:SetChildLayoutElementMinHeight(index,height)
end




function UIWidgetBase:setChildLayoutElementflexibleHeight(index,height)
self.widget:SetChildLayoutElementflexibleHeight(index,height)
end




function UIWidgetBase:setChildLayoutElementflexibleWidth(index,width)
self.widget:SetChildLayoutElementflexibleWidth(index,width)
end




function UIWidgetBase:setChildToggle(index,toggle)
self.widget:SetChildToggle(index,toggle)
end



function UIWidgetBase:getChildToggle(index)
return self.widget:GetChildToggle(index)
end







function UIWidgetBase:setChildSlider(index,value,min,max,callback)
self.widget:SetChildSlider(index,value,min,max,callback)
end




function UIWidgetBase:setChildSliderRefresh(index,value)
self.widget:SetChildSliderRefresh(index,value)
end







function UIWidgetBase:setChildSliderInit(index,value,min,max,callback)
self.widget:SetChildSliderInit(index,value,min,max,callback)
end




function UIWidgetBase:setChildSliderValue(index,value)
self.widget:SetChildSliderValue(index,value)
end



function UIWidgetBase:getChildEnhanceScrollerLua(index)
return self.widget:GetChildEnhanceScrollerLua(index)
end



function UIWidgetBase:getChildWidgetBase(index)
return self.widget:GetChildWidgetBase(index)
end


function UIWidgetBase:getChildSelfWidgetBase()
return self.widget:GetChildSelfWidgetBase()
end



function UIWidgetBase:getObjectWidgetBase(obj)
return self.widget:GetObjectWidgetBase(obj)
end








function UIWidgetBase:setCreatChildClonePrefab(controlIndex,indexs,parentIndexs,xs,ys,names)
self.widget:SetCreatChildClonePrefab(controlIndex,indexs,parentIndexs,xs,ys,names)
end






function UIWidgetBase:setCreatChildClonePrefabEx(controlIndex,indexs,parentIndexs,names)
self.widget:SetCreatChildClonePrefabEx(controlIndex,indexs,parentIndexs,names)
end





function UIWidgetBase:startChildClonePrefabTween(controlIndex,duration,ease)
self.widget:StartChildClonePrefabTween(controlIndex,duration,ease)
end




function UIWidgetBase:releaseChildClonePrefab(controlIndex,key)
self.widget:ReleaseChildClonePrefab(controlIndex,key)
end




function UIWidgetBase:getChildCloneWidget(controlIndex,cloneIndex)
return self.widget:GetChildCloneWidget(controlIndex,cloneIndex)
end




function UIWidgetBase:getChildCloneWidgetByKey(controlIndex,key)
return self.widget:GetChildCloneWidgetByKey(controlIndex,key)
end




function UIWidgetBase:getChildClonePositionByKey(controlIndex,key)
return self.widget:GetChildClonePositionByKey(controlIndex,key)
end




function UIWidgetBase:setChildQualityEffect(index,quality)
self.widget:SetChildQualityEffect(index,quality)
end




function UIWidgetBase:setChildAnimationCurrentFrame(index,frame)
self.widget:SetChildAnimationCurrentFrame(index,frame)
end






function UIWidgetBase:setChildAnimationStringID(index,animationstring,isSetNative,ac)
self.widget:SetChildAnimationStringID(index,animationstring,isSetNative,ac)
end




function UIWidgetBase:setChildAnimationStatus(index,status)
self.widget:SetChildAnimationStatus(index,status)
end





function UIWidgetBase:setChildAnimationID(index,animationID,isSetNative)
self.widget:SetChildAnimationID(index,animationID,isSetNative)
end




function UIWidgetBase:setChildSpriteRendererAnimationEffect(index,quality)
self.widget:SetChildSpriteRendererAnimationEffect(index,quality)
end




function UIWidgetBase:setChildSpriteRendererAnimationCurrentFrame(index,frame)
self.widget:SetChildSpriteRendererAnimationCurrentFrame(index,frame)
end






function UIWidgetBase:setChildSpriteRendererAnimationStringID(index,animationstring,isSetNative,ac)
self.widget:SetChildSpriteRendererAnimationStringID(index,animationstring,isSetNative,ac)
end




function UIWidgetBase:setChildSpriteRendererAnimationStatus(index,status)
self.widget:SetChildSpriteRendererAnimationStatus(index,status)
end





function UIWidgetBase:setChildSpriteRendererAnimationID(index,animationID,isSetNative)
self.widget:SetChildSpriteRendererAnimationID(index,animationID,isSetNative)
end




function UIWidgetBase:setChildUIGray(index,bGray)
self.widget:SetChildUIGray(index,bGray)
end




function UIWidgetBase:setChildImageExGray(index,flag)
self.widget:SetChildImageExGray(index,flag)
end






function UIWidgetBase:setChildGraphicGray(index,flag,withChildren,includeInactive)
self.widget:SetChildGraphicGray(index,flag,withChildren,includeInactive)
end




function UIWidgetBase:setIconNative(index,native)
self.widget:SetIconNative(index,native)
end




function UIWidgetBase:setChildQulaity(index,quality)
self.widget:SetChildQulaity(index,quality)
end





function UIWidgetBase:setChildQulaityEx(index,page,quality)
self.widget:SetChildQulaityEx(index,page,quality)
end






function UIWidgetBase:setChildNewbieMarkerTarget(index,cmpid,showCamera,targetCamera)
self.widget:SetChildNewbieMarkerTarget(index,cmpid,showCamera,targetCamera)
end








function UIWidgetBase:setGuideMaskTarget(index,targetIndex,left,top,right,bottom)
self.widget:SetGuideMaskTarget(index,targetIndex,left,top,right,bottom)
end








function UIWidgetBase:setGuideMaskTargetX(index,target,left,top,right,bottom)
self.widget:SetGuideMaskTargetX(index,target,left,top,right,bottom)
end





function UIWidgetBase:startGuideMask(index,delay,duration)
self.widget:StartGuideMask(index,delay,duration)
end



function UIWidgetBase:stopGuideMask(index)
self.widget:StopGuideMask(index)
end











function UIWidgetBase:setChildUIModelShowTarget(index,modelID,size,componnets,animationID,stopAnim,softMask,fadeIn,action)
self.widget:SetChildUIModelShowTarget(index,modelID,size,componnets,animationID,stopAnim,softMask,fadeIn,action)
end






function UIWidgetBase:setChildModelAnimationState(index,animationID,speed,action)
self.widget:SetChildModelAnimationState(index,animationID,speed,action)
end





function UIWidgetBase:setChildModelAnimationStop(index,iState,progress)
self.widget:SetChildModelAnimationStop(index,iState,progress)
end





function UIWidgetBase:setChildUIModelShowTargetOffset(index,offsetX,offsetY)
self.widget:SetChildUIModelShowTargetOffset(index,offsetX,offsetY)
end




function UIWidgetBase:setChildUIModelShowScale(index,scale)
self.widget:SetChildUIModelShowScale(index,scale)
end




function UIWidgetBase:setChildUIModelShowFlipX(index,flip)
self.widget:SetChildUIModelShowFlipX(index,flip)
end




function UIWidgetBase:setChildUIModelShowFlipY(index,flip)
self.widget:SetChildUIModelShowFlipY(index,flip)
end




function UIWidgetBase:setChildUIModelShowColor(index,color)
self.widget:SetChildUIModelShowColor(index,color)
end




function UIWidgetBase:setChildUIModelGray(index,gray)
self.widget:SetChildUIModelGray(index,gray)
end







function UIWidgetBase:setChildUIModelShowFadeToColor(index,dst,duration,delay,callback)
self.widget:SetChildUIModelShowFadeToColor(index,dst,duration,delay,callback)
end





function UIWidgetBase:setChildUIModelShowSlotDisplayIndex(index,slotName,displayIndex)
self.widget:SetChildUIModelShowSlotDisplayIndex(index,slotName,displayIndex)
end





function UIWidgetBase:setChildUIModelShowSlotAttachment(index,slotName,name)
self.widget:SetChildUIModelShowSlotAttachment(index,slotName,name)
end





function UIWidgetBase:setChildLoadSlot(index,slotName,id)
self.widget:SetChildLoadSlot(index,slotName,id)
end






function UIWidgetBase:setChildChangeSlotDisplay(index,targetSlotName,slotName,id)
self.widget:SetChildChangeSlotDisplay(index,targetSlotName,slotName,id)
end



function UIWidgetBase:setChildUIModelRemoveTarget(index)
self.widget:SetChildUIModelRemoveTarget(index)
end




function UIWidgetBase:setChildUIModelAnimationSpeed(index,speed)
self.widget:SetChildUIModelAnimationSpeed(index,speed)
end







function UIWidgetBase:setChildChangeFollowActorSlotDisplay(index,followSlotName,subSlotName,slotName,id)
self.widget:SetChildChangeFollowActorSlotDisplay(index,followSlotName,subSlotName,slotName,id)
end






function UIWidgetBase:setChildAddSkeletonSlot(index,slotName,attachmentName,id)
self.widget:SetChildAddSkeletonSlot(index,slotName,attachmentName,id)
end









function UIWidgetBase:setChildUIModelMount(index,mountBodyID,mountSlots,mountHP,scale,offset,onMountFinish)
self.widget:SetChildUIModelMount(index,mountBodyID,mountSlots,mountHP,scale,offset,onMountFinish)
end



function UIWidgetBase:setChildUIModelUnMount(index)
self.widget:SetChildUIModelUnMount(index)
end




function UIWidgetBase:setChildUIModelUpdateRendererSize(index,enable)
self.widget:SetChildUIModelUpdateRendererSize(index,enable)
end





function UIWidgetBase:setChildUIModelEnableInitUISpinePara(index,canvasGroupCompatible,PMAVertexColor)
self.widget:SetChildUIModelEnableInitUISpinePara(index,canvasGroupCompatible,PMAVertexColor)
end




function UIWidgetBase:setChildUIModelMountSeparatorSlot(index,sSlotName)
self.widget:SetChildUIModelMountSeparatorSlot(index,sSlotName)
end






function UIWidgetBase:setChildUIModelEnableInitUISpineParaEx(index,canvasGroupCompatible,PMAVertexColor,TintBlack)
self.widget:SetChildUIModelEnableInitUISpineParaEx(index,canvasGroupCompatible,PMAVertexColor,TintBlack)
end









function UIWidgetBase:setChildModelAnimationStateWithProgress(index,animationID,progress,speed,iLeaveStateID,loopMode,action)
self.widget:SetChildModelAnimationStateWithProgress(index,animationID,progress,speed,iLeaveStateID,loopMode,action)
end










function UIWidgetBase:setChildSceneEntityCreateModel(index,bodyID,slots,sortingLayer,sortOrder,scale,onLoadFinish,small)
self.widget:SetChildSceneEntityCreateModel(index,bodyID,slots,sortingLayer,sortOrder,scale,onLoadFinish,small)
end






function UIWidgetBase:setChildSceneEntityCreateObject(index,objID,sortOrder,onLoadFinish)
self.widget:SetChildSceneEntityCreateObject(index,objID,sortOrder,onLoadFinish)
end





function UIWidgetBase:setChildSceneEntityAddModelBoxCollider(index,boxParams,layer)
self.widget:SetChildSceneEntityAddModelBoxCollider(index,boxParams,layer)
end







function UIWidgetBase:setChildSceneEntityAddBoxCollider(index,size,offset,boxParams,layer)
self.widget:SetChildSceneEntityAddBoxCollider(index,size,offset,boxParams,layer)
end



function UIWidgetBase:setChildSceneEntityRemoveModel(index)
self.widget:SetChildSceneEntityRemoveModel(index)
end




function UIWidgetBase:setChildSceneEntitySetVisible(index,visible)
self.widget:SetChildSceneEntitySetVisible(index,visible)
end




function UIWidgetBase:setChildSceneEntitySetOrder(index,order)
self.widget:SetChildSceneEntitySetOrder(index,order)
end





function UIWidgetBase:setChildSceneEntitySetShaderRenderQueue(index,renderQueue,zTest)
self.widget:SetChildSceneEntitySetShaderRenderQueue(index,renderQueue,zTest)
end






function UIWidgetBase:setChildSceneEntityPlayAnimation(index,nStateID,speed,callback)
self.widget:SetChildSceneEntityPlayAnimation(index,nStateID,speed,callback)
end





function UIWidgetBase:setChildSceneEntityFreezeAnimation(index,nStateID,progress)
self.widget:SetChildSceneEntityFreezeAnimation(index,nStateID,progress)
end




function UIWidgetBase:setChildSceneEntityFlipX(index,isFlip)
self.widget:SetChildSceneEntityFlipX(index,isFlip)
end




function UIWidgetBase:setChildSceneEntityFlipY(index,isFlip)
self.widget:SetChildSceneEntityFlipY(index,isFlip)
end





function UIWidgetBase:setChildSceneEntityFlipXY(index,isFlipX,isFlipY)
self.widget:SetChildSceneEntityFlipXY(index,isFlipX,isFlipY)
end





function UIWidgetBase:setChildSceneEntitySetEffectRotation(index,handle,rotation)
self.widget:SetChildSceneEntitySetEffectRotation(index,handle,rotation)
end




function UIWidgetBase:setChildSceneEntitySetRotation(index,rotation)
self.widget:SetChildSceneEntitySetRotation(index,rotation)
end







function UIWidgetBase:setChildSceneEntityPlayEffect(index,effectID,offset,scale,attach)
return self.widget:SetChildSceneEntityPlayEffect(index,effectID,offset,scale,attach)
end







function UIWidgetBase:setChildSceneEntityPlayEffectOnActor(index,effectID,hangPoint,offset,scale)
return self.widget:SetChildSceneEntityPlayEffectOnActor(index,effectID,hangPoint,offset,scale)
end




function UIWidgetBase:setChildSceneEntityStopEffectOnActor(index,id)
self.widget:SetChildSceneEntityStopEffectOnActor(index,id)
end






function UIWidgetBase:setChildSceneEntityChangeColor(index,color,duration,callback)
self.widget:SetChildSceneEntityChangeColor(index,color,duration,callback)
end









function UIWidgetBase:setChildSceneEntityMount(index,id,slots,hp,scale,offset,callback)
self.widget:SetChildSceneEntityMount(index,id,slots,hp,scale,offset,callback)
end



function UIWidgetBase:setChildSceneEntityUnMount(index)
self.widget:SetChildSceneEntityUnMount(index)
end




function UIWidgetBase:setChildSceneEntitySetPosition(index,position)
self.widget:SetChildSceneEntitySetPosition(index,position)
end




function UIWidgetBase:setChildSceneEntityTransformPosition(index,offset)
return self.widget:SetChildSceneEntityTransformPosition(index,offset)
end




function UIWidgetBase:setChildSceneEntitySetOffset(index,offset)
self.widget:SetChildSceneEntitySetOffset(index,offset)
end




function UIWidgetBase:setChildSceneEntityShowShadow(index,show)
self.widget:SetChildSceneEntityShowShadow(index,show)
end




function UIWidgetBase:setChildSceneEntityGetSlotTransform(index,slot)
return self.widget:SetChildSceneEntityGetSlotTransform(index,slot)
end





function UIWidgetBase:setChildSceneEntitySetSlotIcon(index,slotName,iconName)
self.widget:SetChildSceneEntitySetSlotIcon(index,slotName,iconName)
end




function UIWidgetBase:setChildSceneEntitySetScale(index,scale)
self.widget:SetChildSceneEntitySetScale(index,scale)
end




function UIWidgetBase:setChildSceneEntitySetFreeze(index,freeze)
self.widget:SetChildSceneEntitySetFreeze(index,freeze)
end








function UIWidgetBase:setChildBoxColliderAdd(index,size,offset,scale,boxParams,layer)
self.widget:SetChildBoxColliderAdd(index,size,offset,scale,boxParams,layer)
end



function UIWidgetBase:setChildBoxColliderRemove(index)
self.widget:SetChildBoxColliderRemove(index)
end








function UIWidgetBase:setChildUIFollowWorldTransformInitObj(index,followTarget,tagOffset,uiOffset,needFollow,scaleCfg)
self.widget:SetChildUIFollowWorldTransformInitObj(index,followTarget,tagOffset,uiOffset,needFollow,scaleCfg)
end








function UIWidgetBase:setChildUIFollowWorldTransformInitPos(index,followPos,tagOffset,uiOffset,needFollow,scaleCfg)
self.widget:SetChildUIFollowWorldTransformInitPos(index,followPos,tagOffset,uiOffset,needFollow,scaleCfg)
end



function UIWidgetBase:setChildUIFollowWorldTransformStop(index)
self.widget:SetChildUIFollowWorldTransformStop(index)
end









function UIWidgetBase:setChildSpine(index,assetBundleName,skinName,stateID,speed,onLoadFinish,onAnimationFinis)
self.widget:SetChildSpine(index,assetBundleName,skinName,stateID,speed,onLoadFinish,onAnimationFinis)
end






function UIWidgetBase:setChildSpineAnimation(index,stateID,speed,onFinish)
self.widget:SetChildSpineAnimation(index,stateID,speed,onFinish)
end




function UIWidgetBase:setChildSpineSkin(index,skinName)
self.widget:SetChildSpineSkin(index,skinName)
end





function UIWidgetBase:setChildSpineSlotAttachment(index,slotName,attachName)
self.widget:SetChildSpineSlotAttachment(index,slotName,attachName)
end







function UIWidgetBase:setChildSpineFadeColor(index,col,duration,delayTime,onComplete)
self.widget:SetChildSpineFadeColor(index,col,duration,delayTime,onComplete)
end











function UIWidgetBase:setChildDragoneBoneImageTarget(index,modelID,componnets,animationID,flipX,offsetX,offsetY,cameraSize,stopAnim)
self.widget:SetChildDragoneBoneImageTarget(index,modelID,componnets,animationID,flipX,offsetX,offsetY,cameraSize,stopAnim)
end












function UIWidgetBase:setChildDragonTarget(index,modelID,size,componnets,animationID,stopAnim,stopProgress,softMask,fadetime,action)
self.widget:SetChildDragonTarget(index,modelID,size,componnets,animationID,stopAnim,stopProgress,softMask,fadetime,action)
end




function UIWidgetBase:getChildDragonSlotTransform(index,slotName)
return self.widget:GetChildDragonSlotTransform(index,slotName)
end




function UIWidgetBase:setChildDragonSlotAction(index,action)
self.widget:SetChildDragonSlotAction(index,action)
end






function UIWidgetBase:setChildDragonAnimationState(index,animationID,speed,action)
self.widget:SetChildDragonAnimationState(index,animationID,speed,action)
end






function UIWidgetBase:setChildUIAnimatorPrefabLoaderCreate(index,abname,assestNameD,callback)
self.widget:SetChildUIAnimatorPrefabLoaderCreate(index,abname,assestNameD,callback)
end






function UIWidgetBase:addChildUIAnimatorPrefabEventInt(index,eventTime,functionName,intParam)
self.widget:AddChildUIAnimatorPrefabEventInt(index,eventTime,functionName,intParam)
end





function UIWidgetBase:setChildUISetChildSortingGroupOrder(index,order,add)
self.widget:SetChildUISetChildSortingGroupOrder(index,order,add)
end




function UIWidgetBase:setChildUISetChildSortingGroupLayer(index,layer)
self.widget:SetChildUISetChildSortingGroupLayer(index,layer)
end





function UIWidgetBase:setChildDynamicGridCreateItems(index,num,callback)
self.widget:SetChildDynamicGridCreateItems(index,num,callback)
end




function UIWidgetBase:getChildDynamicGridItem(index,gridIdx)
return self.widget:GetChildDynamicGridItem(index,gridIdx)
end






function UIWidgetBase:setChildDynamicGridJump(index,jumpIdx,rate,moveTime)
self.widget:SetChildDynamicGridJump(index,jumpIdx,rate,moveTime)
end





function UIWidgetBase:setChildDynamicGridJumpPage(index,page,moveTime)
self.widget:SetChildDynamicGridJumpPage(index,page,moveTime)
end





function UIWidgetBase:setChildLayoutGroupCreateItems(index,num,callback)
self.widget:SetChildLayoutGroupCreateItems(index,num,callback)
end



function UIWidgetBase:setChildLayoutGroupClearAllItems(index)
self.widget:SetChildLayoutGroupClearAllItems(index)
end



function UIWidgetBase:getChildLayoutGroupGridList(index)
return self.widget:GetChildLayoutGroupGridList(index)
end




function UIWidgetBase:getChildLayoutGroupGridItem(index,gridIdx)
return self.widget:GetChildLayoutGroupGridItem(index,gridIdx)
end



function UIWidgetBase:setChildLayoutGroupAddItem(index)
self.widget:SetChildLayoutGroupAddItem(index)
end



function UIWidgetBase:setChildLayoutGroupRemoveItem(index)
self.widget:SetChildLayoutGroupRemoveItem(index)
end



function UIWidgetBase:getChildCommonLayoutGroupWidgetList(index)
return self.widget:GetChildCommonLayoutGroupWidgetList(index)
end




function UIWidgetBase:getChildCommonLayoutGroupWidgetItem(index,gridIdx)
return self.widget:GetChildCommonLayoutGroupWidgetItem(index,gridIdx)
end




function UIWidgetBase:setChildBlockLayoutGroupCreateItem(index,prefabIndex)
self.widget:SetChildBlockLayoutGroupCreateItem(index,prefabIndex)
end



function UIWidgetBase:getChildLayoutGroupBlockList(index)
return self.widget:GetChildLayoutGroupBlockList(index)
end





function UIWidgetBase:setChildUIPolygonImage(index,verticesDistancea,rot)
self.widget:SetChildUIPolygonImage(index,verticesDistancea,rot)
end







function UIWidgetBase:setChildScrollViewInit(index,align,usePool,clickEvent,longTouchEvent)
self.widget:SetChildScrollViewInit(index,align,usePool,clickEvent,longTouchEvent)
end






function UIWidgetBase:setChildScrollViewCreateGrids(index,num,col,startAni)
self.widget:SetChildScrollViewCreateGrids(index,num,col,startAni)
end










function UIWidgetBase:setChildScrollViewDelayCreateGrids(index,num,col,delay,sNum,scroll,alignEnd,onCreateGrid)
self.widget:SetChildScrollViewDelayCreateGrids(index,num,col,delay,sNum,scroll,alignEnd,onCreateGrid)
end



function UIWidgetBase:setChildScrollViewStopGridCreate(index)
self.widget:SetChildScrollViewStopGridCreate(index)
end




function UIWidgetBase:getChildScrollViewItemWidget(index,gridIndex)
return self.widget:GetChildScrollViewItemWidget(index,gridIndex)
end





function UIWidgetBase:getChildScrollViewItemComponent(index,gridIndex,name)
return self.widget:GetChildScrollViewItemComponent(index,gridIndex,name)
end







function UIWidgetBase:setChildScrollViewSelectItem(index,gridIndex,animation,invokeAction,alignEnd)
self.widget:SetChildScrollViewSelectItem(index,gridIndex,animation,invokeAction,alignEnd)
end



function UIWidgetBase:getChildScrollViewItemWidgets(index)
return self.widget:GetChildScrollViewItemWidgets(index)
end





function UIWidgetBase:setChildScrollViewAutoSizeOption(index,autoRect,maxSize)
self.widget:SetChildScrollViewAutoSizeOption(index,autoRect,maxSize)
end






function UIWidgetBase:setChildScrollViewChangeItemList(index,sIndex,dIndex,refreshPos)
self.widget:SetChildScrollViewChangeItemList(index,sIndex,dIndex,refreshPos)
end







function UIWidgetBase:setChildScrollViewChangeItemListEx(index,htype,sIndex,dIndex,refreshPos)
self.widget:SetChildScrollViewChangeItemListEx(index,htype,sIndex,dIndex,refreshPos)
end





function UIWidgetBase:setChildScrollViewMoveItemToIndexPos(index,sIndex,duration)
return self.widget:SetChildScrollViewMoveItemToIndexPos(index,sIndex,duration)
end





function UIWidgetBase:setChildScrollViewResetContentSize(index,num,col)
self.widget:SetChildScrollViewResetContentSize(index,num,col)
end






function UIWidgetBase:setChildScrollViewInitScrollEvent(index,checkPos,offset,callback)
self.widget:SetChildScrollViewInitScrollEvent(index,checkPos,offset,callback)
end



function UIWidgetBase:setChildScrollViewTriggerScrollEvent(index)
self.widget:SetChildScrollViewTriggerScrollEvent(index)
end



function UIWidgetBase:setChildScrollViewPlayExitAni(index)
self.widget:SetChildScrollViewPlayExitAni(index)
end




function UIWidgetBase:setChildScrollViewPlayAniAction(index,action)
self.widget:SetChildScrollViewPlayAniAction(index,action)
end







function UIWidgetBase:setChildScrollViewGridDragActive(index,bActive,scrollSpeed,borderOffset,dragDelegate)
self.widget:SetChildScrollViewGridDragActive(index,bActive,scrollSpeed,borderOffset,dragDelegate)
end






function UIWidgetBase:setChildScrollViewHandleMarkId(index,htype,gridIndex,markId)
return self.widget:SetChildScrollViewHandleMarkId(index,htype,gridIndex,markId)
end





function UIWidgetBase:setChildSimpleList(index,Count,isClear)
self.widget:SetChildSimpleList(index,Count,isClear)
end




function UIWidgetBase:setChildRefreshList(index,index1)
self.widget:SetChildRefreshList(index,index1)
end





function UIWidgetBase:setChildSimpleListAndWinlua(index,Count,winlua)
self.widget:SetChildSimpleListAndWinlua(index,Count,winlua)
end





function UIWidgetBase:setPointLineMap(index,PointData,ActiveCount)
self.widget:SetPointLineMap(index,PointData,ActiveCount)
end




function UIWidgetBase:setMapHL(index,ActiveNum)
self.widget:SetMapHL(index,ActiveNum)
end





function UIWidgetBase:getMapElement(index,MapIndex,isPoint)
return self.widget:GetMapElement(index,MapIndex,isPoint)
end




function UIWidgetBase:setChildProText(index,str)
self.widget:SetChildProText(index,str)
end




function UIWidgetBase:setChildScale(index,scale)
self.widget:SetChildScale(index,scale)
end



function UIWidgetBase:getChildScale(index)
return self.widget:GetChildScale(index)
end



function UIWidgetBase:getChildInputFieldValue(index)
return self.widget:GetChildInputFieldValue(index)
end




function UIWidgetBase:setChildInputCharacterLimit(index,number)
self.widget:SetChildInputCharacterLimit(index,number)
end



function UIWidgetBase:getChildInputCharacterLimit(index)
return self.widget:GetChildInputCharacterLimit(index)
end




function UIWidgetBase:setChildInputFieldValue(index,content)
self.widget:SetChildInputFieldValue(index,content)
end





function UIWidgetBase:setChildInputFieldChange(index,isclear,func)
self.widget:SetChildInputFieldChange(index,isclear,func)
end




function UIWidgetBase:setChildInputLineType(index,type)
self.widget:SetChildInputLineType(index,type)
end




function UIWidgetBase:setChildRollNumText(index,value)
self.widget:SetChildRollNumText(index,value)
end




function UIWidgetBase:setAcceleratorOn(index,isOn)
self.widget:SetAcceleratorOn(index,isOn)
end




function UIWidgetBase:setChildGray(index,isGray)
self.widget:SetChildGray(index,isGray)
end




function UIWidgetBase:getCommonComponent(index,ty)
return self.widget:GetCommonComponent(index,ty)
end





function UIWidgetBase:setChildToggleChange(index,func,data)
self.widget:SetChildToggleChange(index,func,data)
end




function UIWidgetBase:setChildAnimatorEnable(index,flag)
self.widget:SetChildAnimatorEnable(index,flag)
end






function UIWidgetBase:setChildAnimatorInteger(index,name,id,isUseTringger)
self.widget:SetChildAnimatorInteger(index,name,id,isUseTringger)
end






function UIWidgetBase:setChildAnimatorParameter(index,name,type,value)
self.widget:SetChildAnimatorParameter(index,name,type,value)
end




function UIWidgetBase:loadRawImageByWWW(index,path)
self.widget:LoadRawImageByWWW(index,path)
end




function UIWidgetBase:loadLocalFileRawImageByWWW(index,path)
self.widget:LoadLocalFileRawImageByWWW(index,path)
end







function UIWidgetBase:childRawImageLoader(StandID,pathType,baseURL,filename,setNativeSize)
self.widget:ChildRawImageLoader(StandID,pathType,baseURL,filename,setNativeSize)
end




function UIWidgetBase:setChildWidgetByData(index,datas)
return self.widget:SetChildWidgetByData(index,datas)
end




function UIWidgetBase:initChildDataPropArray(index,propArray)
self.widget:InitChildDataPropArray(index,propArray)
end





function UIWidgetBase:setChildDataPropArray(index,subIndex,prop)
self.widget:SetChildDataPropArray(index,subIndex,prop)
end




function UIWidgetBase:resetChildDataPropArray(index,subIndex)
self.widget:ResetChildDataPropArray(index,subIndex)
end




function UIWidgetBase:setChildDataProp(index,prop)
self.widget:SetChildDataProp(index,prop)
end



function UIWidgetBase:resetChildDataProp(index)
self.widget:ResetChildDataProp(index)
end





function UIWidgetBase:setChildLuaTable(index,luaTable,clearData)
self.widget:SetChildLuaTable(index,luaTable,clearData)
end




function UIWidgetBase:setItemBasePointerEvent(index,delagate)
self.widget:SetItemBasePointerEvent(index,delagate)
end



function UIWidgetBase:getChildItemGridView(index)
return self.widget:GetChildItemGridView(index)
end






function UIWidgetBase:setChildRotation(index,x,y,z)
self.widget:SetChildRotation(index,x,y,z)
end






function UIWidgetBase:setChildRotationEx(index,from,to,axis)
self.widget:SetChildRotationEx(index,from,to,axis)
end







function UIWidgetBase:playChildDOTween(index,id,endVal,opCode,flag)
self.widget:PlayChildDOTween(index,id,endVal,opCode,flag)
end






function UIWidgetBase:setChildDOTweenAnimation_DOPlay(index,id,opCode,flag)
self.widget:SetChildDOTweenAnimation_DOPlay(index,id,opCode,flag)
end




function UIWidgetBase:setChildDOTweenAnimation_DOToggle(index,id)
self.widget:SetChildDOTweenAnimation_DOToggle(index,id)
end




function UIWidgetBase:setChildDOTweenAnimation_DOPause(index,id)
self.widget:SetChildDOTweenAnimation_DOPause(index,id)
end







function UIWidgetBase:setChildDOTweenAnimation_Listener(index,id,opCode,clean,action)
self.widget:SetChildDOTweenAnimation_Listener(index,id,opCode,clean,action)
end



function UIWidgetBase:getChildWidgetList(index)
return self.widget:GetChildWidgetList(index)
end



function UIWidgetBase:setParentWindowLua(parent)
self.widget:SetParentWindowLua(parent)
end



function UIWidgetBase:setSelfChildWithParentTransform(parentIdx)
self.widget:SetSelfChildWithParentTransform(parentIdx)
end




function UIWidgetBase:setChildWithParentTransform(parentIdx,index)
self.widget:SetChildWithParentTransform(parentIdx,index)
end




function UIWidgetBase:setChildNewBieComponentId(index,id)
self.widget:SetChildNewBieComponentId(index,id)
end




function UIWidgetBase:setChildWeakGuideComponentId(index,id)
self.widget:SetChildWeakGuideComponentId(index,id)
end






function UIWidgetBase:setChildTrendsTextPlay(index,txt,speed,action)
self.widget:SetChildTrendsTextPlay(index,txt,speed,action)
end



function UIWidgetBase:setChildTrendsTextStop(index)
self.widget:SetChildTrendsTextStop(index)
end



function UIWidgetBase:setSelfActive(active)
self.widget:SetSelfActive(active)
end



function UIWidgetBase:getChildGameObject(index)
return self.widget:GetChildGameObject(index)
end



function UIWidgetBase:getChildWindowLua(index)
return self.widget:GetChildWindowLua(index)
end





function UIWidgetBase:setChildWidgetMaterialFloat(index,key,value)
self.widget:SetChildWidgetMaterialFloat(index,key,value)
end





function UIWidgetBase:setChildWidgetMaterialVector4(index,key,value)
self.widget:SetChildWidgetMaterialVector4(index,key,value)
end



function UIWidgetBase:getChildTextText(index)
return self.widget:GetChildTextText(index)
end






function UIWidgetBase:setChildImageMaterial(index,property,value,tweenedByAnimationCurve)
self.widget:SetChildImageMaterial(index,property,value,tweenedByAnimationCurve)
end




function UIWidgetBase:setChildImageRaycast(index,enable)
self.widget:SetChildImageRaycast(index,enable)
end




function UIWidgetBase:setChildCanvasGroupRaycast(index,enable)
self.widget:SetChildCanvasGroupRaycast(index,enable)
end




function UIWidgetBase:setChildCanvasGroupAlpha(index,alpha)
self.widget:SetChildCanvasGroupAlpha(index,alpha)
end










function UIWidgetBase:setChildGradientColor(index,TopColor,BottomColor,LeftColor,RightColor,IsHorizontal,IsVertical,HtoV)
self.widget:SetChildGradientColor(index,TopColor,BottomColor,LeftColor,RightColor,IsHorizontal,IsVertical,HtoV)
end






function UIWidgetBase:setChildHSV(index,h,s,v)
self.widget:SetChildHSV(index,h,s,v)
end




function UIWidgetBase:setChildShaderEffect(index,enableEffect)
self.widget:SetChildShaderEffect(index,enableEffect)
end






function UIWidgetBase:cloneChildTransform(index,parent,keepPosition,autoPlayEffect)
return self.widget:CloneChildTransform(index,parent,keepPosition,autoPlayEffect)
end



function UIWidgetBase:getChildList(index)
return self.widget:GetChildList(index)
end





function UIWidgetBase:setChildDoMovePath(index,byValue,onComplete)
return self.widget:SetChildDoMovePath(index,byValue,onComplete)
end









function UIWidgetBase:setChildDoMovePathWithSlider(index,byValue,orginSlider,endSlider,duration,rate,onComplete)
return self.widget:SetChildDoMovePathWithSlider(index,byValue,orginSlider,endSlider,duration,rate,onComplete)
end






function UIWidgetBase:setChildDOBlendableLocalMoveBy(index,byValue,duration,onComplete)
return self.widget:SetChildDOBlendableLocalMoveBy(index,byValue,duration,onComplete)
end







function UIWidgetBase:setChildDOBlendableLocalRotateBy(index,byValue,duration,mode,onComplete)
return self.widget:SetChildDOBlendableLocalRotateBy(index,byValue,duration,mode,onComplete)
end






function UIWidgetBase:setChildDOBlendableMoveBy(index,byValue,duration,onComplete)
return self.widget:SetChildDOBlendableMoveBy(index,byValue,duration,onComplete)
end







function UIWidgetBase:setChildDOBlendableRotateBy(index,byValue,duration,mode,onComplete)
return self.widget:SetChildDOBlendableRotateBy(index,byValue,duration,mode,onComplete)
end






function UIWidgetBase:setChildDOBlendableScaleBy(index,byValue,duration,onComplete)
return self.widget:SetChildDOBlendableScaleBy(index,byValue,duration,onComplete)
end






function UIWidgetBase:setChildDOMove(index,endValue,duration,onComplete)
return self.widget:SetChildDOMove(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOLocalMove(index,endValue,duration,onComplete)
return self.widget:SetChildDOLocalMove(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOLocalMoveX(index,endValue,duration,onComplete)
return self.widget:SetChildDOLocalMoveX(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOLocalMoveY(index,endValue,duration,onComplete)
return self.widget:SetChildDOLocalMoveY(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOLocalMoveZ(index,endValue,duration,onComplete)
return self.widget:SetChildDOLocalMoveZ(index,endValue,duration,onComplete)
end







function UIWidgetBase:setChildDOLocalRotate(index,endValue,duration,mode,onComplete)
return self.widget:SetChildDOLocalRotate(index,endValue,duration,mode,onComplete)
end






function UIWidgetBase:setChildDOScale(index,endValue,duration,onComplete)
return self.widget:SetChildDOScale(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOScaleX(index,endValue,duration,onComplete)
return self.widget:SetChildDOScaleX(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOScaleY(index,endValue,duration,onComplete)
return self.widget:SetChildDOScaleY(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOScaleZ(index,endValue,duration,onComplete)
return self.widget:SetChildDOScaleZ(index,endValue,duration,onComplete)
end







function UIWidgetBase:setChildDORotate(index,endValue,duration,mode,onComplete)
return self.widget:SetChildDORotate(index,endValue,duration,mode,onComplete)
end








function UIWidgetBase:setChildDOLocalJump(index,endValue,jumpPower,numJumps,duration,onComplete)
return self.widget:SetChildDOLocalJump(index,endValue,jumpPower,numJumps,duration,onComplete)
end








function UIWidgetBase:setChildDOJump(index,endValue,jumpPower,numJumps,duration,onComplete)
return self.widget:SetChildDOJump(index,endValue,jumpPower,numJumps,duration,onComplete)
end






function UIWidgetBase:setChildTextDOColor(index,endValue,duration,onComplete)
return self.widget:SetChildTextDOColor(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildImageDOColor(index,endValue,duration,onComplete)
return self.widget:SetChildImageDOColor(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildTextDOFade(index,endValue,duration,onComplete)
return self.widget:SetChildTextDOFade(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildSpriteRendererDOFade(index,endValue,duration,onComplete)
return self.widget:SetChildSpriteRendererDOFade(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildSpriteRendererDOColor(index,endValue,duration,onComplete)
return self.widget:SetChildSpriteRendererDOColor(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildImageDOFade(index,endValue,duration,onComplete)
return self.widget:SetChildImageDOFade(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildCanvasGroupDOFade(index,endValue,duration,onComplete)
return self.widget:SetChildCanvasGroupDOFade(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildTextMeshProUGUIDOFade(index,endValue,duration,onComplete)
return self.widget:SetChildTextMeshProUGUIDOFade(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildImageDOFillAmount(index,endValue,duration,onComplete)
return self.widget:SetChildImageDOFillAmount(index,endValue,duration,onComplete)
end







function UIWidgetBase:setChildDORotation(index,endValue,duration,mode,onComplete)
return self.widget:SetChildDORotation(index,endValue,duration,mode,onComplete)
end








function UIWidgetBase:setChildDOPunchPosition(index,punch,duration,vibrato,elasticity,onComplete)
return self.widget:SetChildDOPunchPosition(index,punch,duration,vibrato,elasticity,onComplete)
end








function UIWidgetBase:setChildDOPunchRotation(index,punch,duration,vibrato,elasticity,onComplete)
return self.widget:SetChildDOPunchRotation(index,punch,duration,vibrato,elasticity,onComplete)
end








function UIWidgetBase:setChildDOPunchScale(index,punch,duration,vibrato,elasticity,onComplete)
return self.widget:SetChildDOPunchScale(index,punch,duration,vibrato,elasticity,onComplete)
end






function UIWidgetBase:setChildDOAnchorPosX(index,endValue,duration,onComplete)
return self.widget:SetChildDOAnchorPosX(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOAnchorPosY(index,endValue,duration,onComplete)
return self.widget:SetChildDOAnchorPosY(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOAnchorPos(index,endValue,duration,onComplete)
return self.widget:SetChildDOAnchorPos(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOAnchorPos3D(index,endValue,duration,onComplete)
return self.widget:SetChildDOAnchorPos3D(index,endValue,duration,onComplete)
end






function UIWidgetBase:setChildDOSizeDelta(index,size,duration,onComplete)
return self.widget:SetChildDOSizeDelta(index,size,duration,onComplete)
end






function UIWidgetBase:setChildDOGraphicColor(index,endValue,durationn,onComplete)
return self.widget:SetChildDOGraphicColor(index,endValue,durationn,onComplete)
end







function UIWidgetBase:initDragItem(wIndex,cIndex,beginEvent,dragEvent,endEvent)
self.widget:InitDragItem(wIndex,cIndex,beginEvent,dragEvent,endEvent)
end






function UIWidgetBase:initDragView(wIndex,beginEvent,dragEvent,endEvent)
self.widget:InitDragView(wIndex,beginEvent,dragEvent,endEvent)
end






function UIWidgetBase:addDragViewItemPos(wIndex,index,x,y)
self.widget:AddDragViewItemPos(wIndex,index,x,y)
end




function UIWidgetBase:getDragViewItem(wIndex,index)
return self.widget:GetDragViewItem(wIndex,index)
end







function UIWidgetBase:setChildUIDragEvent(index,id,beginDragDelegate,endDragDelegate,dragDelegate)
self.widget:SetChildUIDragEvent(index,id,beginDragDelegate,endDragDelegate,dragDelegate)
end



function UIWidgetBase:getChildScreenPointToLocalPointRectangle(index)
return self.widget:GetChildScreenPointToLocalPointRectangle(index)
end










function UIWidgetBase:setChildGenFlowObj(index,typo,normal,stayTime,startPos,dir,onSpwanAcion,onDespwanAcion)
return self.widget:SetChildGenFlowObj(index,typo,normal,stayTime,startPos,dir,onSpwanAcion,onDespwanAcion)
end




function UIWidgetBase:setChildStopFlowObj(index,id)
self.widget:SetChildStopFlowObj(index,id)
end





function UIWidgetBase:setChildFollowEntity(index,guid,offset)
self.widget:SetChildFollowEntity(index,guid,offset)
end






function UIWidgetBase:setChildFollowEntitySlot(index,guid,slot,offset)
self.widget:SetChildFollowEntitySlot(index,guid,slot,offset)
end








function UIWidgetBase:setChildFollowPointUI(index,cameraGo,child,target,wOffset,lOffset)
self.widget:SetChildFollowPointUI(index,cameraGo,child,target,wOffset,lOffset)
end





function UIWidgetBase:setChildScreenRangeShow(index,range,callback)
self.widget:SetChildScreenRangeShow(index,range,callback)
end





function UIWidgetBase:setChildShowEffect(index,effectID,show)
self.widget:SetChildShowEffect(index,effectID,show)
end







function UIWidgetBase:setChildShowEffectEx(index,effectID,sortingLayer,sortingOrder,show)
self.widget:SetChildShowEffectEx(index,effectID,sortingLayer,sortingOrder,show)
end












function UIWidgetBase:setChildModelCaptureImage(index,modelId,componnets,scale,animationID,offsetX,offsetY,headCenter,size,isGray)
self.widget:SetChildModelCaptureImage(index,modelId,componnets,scale,animationID,offsetX,offsetY,headCenter,size,isGray)
end




function UIWidgetBase:setChildCaptureImageGray(index,isGray)
self.widget:SetChildCaptureImageGray(index,isGray)
end













function UIWidgetBase:setChildModelCaptureImageEx(index,modelId,componnets,scale,animationID,offsetX,offsetY,headCenter,size,isGray,cache)
self.widget:SetChildModelCaptureImageEx(index,modelId,componnets,scale,animationID,offsetX,offsetY,headCenter,size,isGray,cache)
end






function UIWidgetBase:setChildModelCaptureIcon(index,icon_head,gray,native)
self.widget:SetChildModelCaptureIcon(index,icon_head,gray,native)
end




function UIWidgetBase:addLineRendererPos(index,uiPos)
self.widget:AddLineRendererPos(index,uiPos)
end





function UIWidgetBase:setLineRendererPos(index,posIndex,uiPos)
self.widget:SetLineRendererPos(index,posIndex,uiPos)
end



function UIWidgetBase:removeLineRendererPos(index)
self.widget:RemoveLineRendererPos(index)
end



function UIWidgetBase:getLineRendererPositionCount(index)
return self.widget:GetLineRendererPositionCount(index)
end




function UIWidgetBase:setLineRendererPositionCount(index,num)
self.widget:SetLineRendererPositionCount(index,num)
end




function UIWidgetBase:setDissolveFactor(index,factor)
self.widget:SetDissolveFactor(index,factor)
end




function UIWidgetBase:setChildDragZoomEnable(index,enable)
self.widget:SetChildDragZoomEnable(index,enable)
end





function UIWidgetBase:setChildZoomLimit(index,maxScale,minScale)
self.widget:SetChildZoomLimit(index,maxScale,minScale)
end




function UIWidgetBase:setChildZoomRate(index,zoomRate)
self.widget:SetChildZoomRate(index,zoomRate)
end




function UIWidgetBase:setChildAutoDragZoomSmoothTime(index,smoothTime)
self.widget:SetChildAutoDragZoomSmoothTime(index,smoothTime)
end




function UIWidgetBase:setChildSubOriginalPos(index,pos)
self.widget:SetChildSubOriginalPos(index,pos)
end



function UIWidgetBase:getChildSubOriginalPos(index)
return self.widget:GetChildSubOriginalPos(index)
end



function UIWidgetBase:getChildSubOriginalScale(index)
return self.widget:GetChildSubOriginalScale(index)
end






function UIWidgetBase:setChildDragAndZoomEvent(index,oneFingerDragCallBack,twoFingerDragCallBack,zoomCallBack)
self.widget:SetChildDragAndZoomEvent(index,oneFingerDragCallBack,twoFingerDragCallBack,zoomCallBack)
end





function UIWidgetBase:setChildDragStartAndEndEvent(index,dragStartCallBack,dragEndCallBack)
self.widget:SetChildDragStartAndEndEvent(index,dragStartCallBack,dragEndCallBack)
end







function UIWidgetBase:subMoveToTargetPos(index,targetPos,duration,disableTouch,callBack)
self.widget:SubMoveToTargetPos(index,targetPos,duration,disableTouch,callBack)
end







function UIWidgetBase:subZoomToTargetScale(index,targetScale,duration,disableTouch,callBack)
self.widget:SubZoomToTargetScale(index,targetScale,duration,disableTouch,callBack)
end





function UIWidgetBase:revertSubPosAndScale(index,duration,callBack)
self.widget:RevertSubPosAndScale(index,duration,callBack)
end




function UIWidgetBase:setChildDragZoomTwoFingerMoveFlag(index,flag)
self.widget:SetChildDragZoomTwoFingerMoveFlag(index,flag)
end







function UIWidgetBase:setChildUVImageFrameSprite(index,frameRate,horizontalAmount1,verticalAmount,frameAmount)
self.widget:SetChildUVImageFrameSprite(index,frameRate,horizontalAmount1,verticalAmount,frameAmount)
end






function UIWidgetBase:setChildUVImageScrollSprite(index,dire,speed,nativeSize)
self.widget:SetChildUVImageScrollSprite(index,dire,speed,nativeSize)
end



function UIWidgetBase:setChildUVImagePause(index)
self.widget:SetChildUVImagePause(index)
end






function UIWidgetBase:setChildGreateExpandUI(index,parentIndex,type,callback)
return self.widget:SetChildGreateExpandUI(index,parentIndex,type,callback)
end





function UIWidgetBase:setChildGreateExpandUIEx(index,type,callback)
return self.widget:SetChildGreateExpandUIEx(index,type,callback)
end




function UIWidgetBase:setChildRemoveExpandUI(index,guid)
self.widget:SetChildRemoveExpandUI(index,guid)
end



function UIWidgetBase:setChildRemoveExpandUIEx(guid)
self.widget:SetChildRemoveExpandUIEx(guid)
end




function UIWidgetBase:getChildExpandUI(index,guid)
return self.widget:GetChildExpandUI(index,guid)
end



function UIWidgetBase:getChildExpandUIEx(guid)
return self.widget:GetChildExpandUIEx(guid)
end




function UIWidgetBase:setChildGraphicRayCasterActive(index,active)
self.widget:SetChildGraphicRayCasterActive(index,active)
end






function UIWidgetBase:setChildDoBrightness(index,brightness,duration,onComplete)
return self.widget:SetChildDoBrightness(index,brightness,duration,onComplete)
end



function UIWidgetBase:getChildTextureCompareValue(index)
return self.widget:GetChildTextureCompareValue(index)
end



function UIWidgetBase:setChildDrawBrushClear(index)
self.widget:SetChildDrawBrushClear(index)
end








function UIWidgetBase:setChildDrawTexture(index,assetbundleName,assetName,pos,angle,size)
self.widget:SetChildDrawTexture(index,assetbundleName,assetName,pos,angle,size)
end





function UIWidgetBase:playDoTweenSequence(index,callback,offset)
self.widget:PlayDoTweenSequence(index,callback,offset)
end







function UIWidgetBase:setCurveAniPlay(index,normal,startPos,endPosOffset,action)
self.widget:SetCurveAniPlay(index,normal,startPos,endPosOffset,action)
end








function UIWidgetBase:setChildSimulateDepth(index,yValue,order,orderR,scaleR,updateDis)
self.widget:SetChildSimulateDepth(index,yValue,order,orderR,scaleR,updateDis)
end




function UIWidgetBase:setChildSimulateDepthActiveUpdate(index,bActive)
self.widget:SetChildSimulateDepthActiveUpdate(index,bActive)
end










function UIWidgetBase:setChildSimulate3D(index,offset,scale,order,orderR,scaleR,axleR,center)
self.widget:SetChildSimulate3D(index,offset,scale,order,orderR,scaleR,axleR,center)
end







function UIWidgetBase:setChildSimulate3DActiveCoverColor(index,active,ration,fcolor,tcolor)
self.widget:SetChildSimulate3DActiveCoverColor(index,active,ration,fcolor,tcolor)
end




function UIWidgetBase:setChildSimulate3DActiveUpdate(index,bActive)
self.widget:SetChildSimulate3DActiveUpdate(index,bActive)
end




function UIWidgetBase:getChildSimulateTargetComponent(index,name)
return self.widget:GetChildSimulateTargetComponent(index,name)
end







function UIWidgetBase:setChildSimulate3DActiveDragMode(index,bActive,dragSpeed,borderOffset,camera)
self.widget:SetChildSimulate3DActiveDragMode(index,bActive,dragSpeed,borderOffset,camera)
end






function UIWidgetBase:setChildSimulate3DDragArea(index,bCheck,wcolor,areaData)
self.widget:SetChildSimulate3DDragArea(index,bCheck,wcolor,areaData)
end




function UIWidgetBase:setChildSimulate3DBaseScale(index,scale)
self.widget:SetChildSimulate3DBaseScale(index,scale)
end




function UIWidgetBase:setChildClearTween(index,clearChild)
self.widget:SetChildClearTween(index,clearChild)
end




function UIWidgetBase:setTouchOverUI(index,callback)
self.widget:SetTouchOverUI(index,callback)
end







function UIWidgetBase:setChildLoadEntityOnUI(index,modelId,pos,scale,rotation)
return self.widget:SetChildLoadEntityOnUI(index,modelId,pos,scale,rotation)
end




function UIWidgetBase:getChildUIMapNodeLPositionById(index,id)
return self.widget:GetChildUIMapNodeLPositionById(index,id)
end





function UIWidgetBase:getChildUIMapPathDataToNode(index,cId,tId)
return self.widget:GetChildUIMapPathDataToNode(index,cId,tId)
end






function UIWidgetBase:getChildUIMapPathLengthByData(index,cId,data,precision)
return self.widget:GetChildUIMapPathLengthByData(index,cId,data,precision)
end







function UIWidgetBase:setChildLoadUIMapDataById(index,id,bgType,onClick,callback)
self.widget:SetChildLoadUIMapDataById(index,id,bgType,onClick,callback)
end




function UIWidgetBase:getChildUIMapNodeIconWidget(index,id)
return self.widget:GetChildUIMapNodeIconWidget(index,id)
end




function UIWidgetBase:setChildUIRoleFreshToward(index,bActive)
self.widget:SetChildUIRoleFreshToward(index,bActive)
end




function UIWidgetBase:setChildUIRoleFlip(index,flip)
self.widget:SetChildUIRoleFlip(index,flip)
end



function UIWidgetBase:setChildScrollRectStopMovement(index)
self.widget:SetChildScrollRectStopMovement(index)
end








function UIWidgetBase:setChildUIWaterWaveDistortPlay(index,state,loop,waitPreState,lerp,onComplete)
self.widget:SetChildUIWaterWaveDistortPlay(index,state,loop,waitPreState,lerp,onComplete)
end







function UIWidgetBase:setChildUITouchEvent(index,onClick,onUp,onDown,onLongTouch)
self.widget:SetChildUITouchEvent(index,onClick,onUp,onDown,onLongTouch)
end








function UIWidgetBase:setChildLimitRange(index,model,left,right,top,bottom)
self.widget:SetChildLimitRange(index,model,left,right,top,bottom)
end



function UIWidgetBase:getChildLoop3DGround(index)
return self.widget:GetChildLoop3DGround(index)
end



function UIWidgetBase:getChildWebView3D(index)
return self.widget:GetChildWebView3D(index)
end



function UIWidgetBase:getChildWebView(index)
return self.widget:GetChildWebView(index)
end



function UIWidgetBase:getChildBaseWebView(index)
return self.widget:GetChildBaseWebView(index)
end







function UIWidgetBase:setChildTroop(index,troopCfgABName,maxNum,progress,onFinish)
self.widget:SetChildTroop(index,troopCfgABName,maxNum,progress,onFinish)
end




function UIWidgetBase:setChildTroopProgress(index,progress)
self.widget:SetChildTroopProgress(index,progress)
end

