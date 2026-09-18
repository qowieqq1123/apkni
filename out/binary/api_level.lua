APILEVE={}





local cur_api_level=deviceHelper.getAPILevel()

function APILEVE.setAPILevel(num)cur_api_level=num end





function api_Available_GMECompoment()return cur_api_level>=7 end
SET_API_LEVEL_CLASS(7,CS,'GMECompoment',nil)


function api_Available_CameraScreenEffect()return cur_api_level>=10 end
SET_API_LEVEL_CLASS(10,CS,'CameraScreenEffect',nil)


function api_Available_UILoopListView()return cur_api_level>=13 end
SET_API_LEVEL_CLASS(13,CS,'UILoopListView',nil)


function api_Available_UILoopTreeView()return cur_api_level>=59 end
SET_API_LEVEL_CLASS(59,CS,'UILoopTreeView',nil)


function api_Available_WXInterface()return cur_api_level>=64 end
SET_API_LEVEL_CLASS(64,CS,'WXInterface',nil)


function api_Available_CSGUILoop3DGround()return cur_api_level>=200 end
SET_API_LEVEL_CLASS(200,CS,'CSGUILoop3DGround',nil)




function api_Available_SetChildWidgetMaterialVector4()return cur_api_level>=2 end
SET_API_LEVEL_PCALL(2,CS.CSGUIWidgetBase,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUISlotItemBase,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.BagGridItem,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIWindowBase,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIListItem,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIListColumn,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIItemBase,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIBaseItem,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIComboMainItem,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIComboSubItem,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIWindowLua,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIWindowLua3DView,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.EnhancedScrollerLua,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.EnhancedScrollerGridLua,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIWindowWithHUD,'SetChildWidgetMaterialVector4',false,nil)
SET_API_LEVEL_PCALL(2,CS.CSGUIStatusWidget,'SetChildWidgetMaterialVector4',false,nil)


function api_Available_ChangeFollowActorSlotDisplay()return cur_api_level>=3 end
SET_API_LEVEL_PCALL(3,CS.Entity,'ChangeFollowActorSlotDisplay',false,nil)


function api_Available_AddSkeletonSlot()return cur_api_level>=3 end
SET_API_LEVEL_PCALL(3,CS.Entity,'AddSkeletonSlot',false,nil)
function api_Available_UpdateManager_SetRangeDownLoadPackage()return cur_api_level>=3 end
SET_API_LEVEL_PCALL(3,CS.ResourceHelper,'UpdateManager_SetRangeDownLoadPackage',false,nil)


function api_Available_SetChildAddSkeletonSlot()return cur_api_level>=3 end
SET_API_LEVEL_PCALL(3,CS.CSGUIWidgetBase,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUISlotItemBase,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.BagGridItem,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIWindowBase,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIListItem,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIListColumn,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIItemBase,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIBaseItem,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIComboMainItem,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIComboSubItem,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIWindowLua,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIWindowLua3DView,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.EnhancedScrollerLua,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.EnhancedScrollerGridLua,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIWindowWithHUD,'SetChildAddSkeletonSlot',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIStatusWidget,'SetChildAddSkeletonSlot',false,nil)


function api_Available_SetChildChangeFollowActorSlotDisplay()return cur_api_level>=3 end
SET_API_LEVEL_PCALL(3,CS.CSGUIWidgetBase,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUISlotItemBase,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.BagGridItem,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIWindowBase,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIListItem,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIListColumn,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIItemBase,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIBaseItem,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIComboMainItem,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIComboSubItem,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIWindowLua,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIWindowLua3DView,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.EnhancedScrollerLua,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.EnhancedScrollerGridLua,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIWindowWithHUD,'SetChildChangeFollowActorSlotDisplay',false,nil)
SET_API_LEVEL_PCALL(3,CS.CSGUIStatusWidget,'SetChildChangeFollowActorSlotDisplay',false,nil)


function api_Available_SetChildScrollViewAutoSizeOption()return cur_api_level>=4 end
SET_API_LEVEL_PCALL(4,CS.CSGUIWidgetBase,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUISlotItemBase,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.BagGridItem,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowBase,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIListItem,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIListColumn,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIItemBase,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIBaseItem,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIComboMainItem,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIComboSubItem,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowLua,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowLua3DView,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.EnhancedScrollerLua,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.EnhancedScrollerGridLua,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowWithHUD,'SetChildScrollViewAutoSizeOption',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIStatusWidget,'SetChildScrollViewAutoSizeOption',false,nil)


function api_Available_SetChildUIModelUnMount()return cur_api_level>=4 end
SET_API_LEVEL_PCALL(4,CS.CSGUIWidgetBase,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUISlotItemBase,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.BagGridItem,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowBase,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIListItem,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIListColumn,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIItemBase,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIBaseItem,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIComboMainItem,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIComboSubItem,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowLua,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowLua3DView,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.EnhancedScrollerLua,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.EnhancedScrollerGridLua,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowWithHUD,'SetChildUIModelUnMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIStatusWidget,'SetChildUIModelUnMount',false,nil)


function api_Available_SetChildUIModelMount()return cur_api_level>=4 end
SET_API_LEVEL_PCALL(4,CS.CSGUIWidgetBase,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUISlotItemBase,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.BagGridItem,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowBase,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIListItem,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIListColumn,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIItemBase,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIBaseItem,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIComboMainItem,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIComboSubItem,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowLua,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowLua3DView,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.EnhancedScrollerLua,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.EnhancedScrollerGridLua,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIWindowWithHUD,'SetChildUIModelMount',false,nil)
SET_API_LEVEL_PCALL(4,CS.CSGUIStatusWidget,'SetChildUIModelMount',false,nil)


function api_Available_InvokeMethod()return cur_api_level>=5 end
SET_API_LEVEL_PCALL(5,CS.ReflectionInterface,'InvokeMethod',false,nil)


function api_Available_GetFieldValue()return cur_api_level>=5 end
SET_API_LEVEL_PCALL(5,CS.ReflectionInterface,'GetFieldValue',false,nil)


function api_Available_GetPropertyValue()return cur_api_level>=5 end
SET_API_LEVEL_PCALL(5,CS.ReflectionInterface,'GetPropertyValue',false,nil)


function api_Available_SetFieldValue()return cur_api_level>=5 end
SET_API_LEVEL_PCALL(5,CS.ReflectionInterface,'SetFieldValue',false,nil)


function api_Available_SetPropertyValue()return cur_api_level>=5 end
SET_API_LEVEL_PCALL(5,CS.ReflectionInterface,'SetPropertyValue',false,nil)


function api_Available_InvokeOverloadMethod()return cur_api_level>=5 end
SET_API_LEVEL_PCALL(5,CS.ReflectionInterface,'InvokeOverloadMethod',false,nil)


function api_Available_CaptureScreenBlurImage()return cur_api_level>=7 end
SET_API_LEVEL_PCALL(7,CS.CSGUIWidgetBase,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUISlotItemBase,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.BagGridItem,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIWindowBase,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIListItem,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIListColumn,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIItemBase,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIBaseItem,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIComboMainItem,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIComboSubItem,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIWindowLua,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIWindowLua3DView,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.EnhancedScrollerLua,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.EnhancedScrollerGridLua,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIWindowWithHUD,'CaptureScreenBlurImage',false,nil)
SET_API_LEVEL_PCALL(7,CS.CSGUIStatusWidget,'CaptureScreenBlurImage',false,nil)


function api_Available_PlayEffectOnActor()return cur_api_level>=8 end
SET_API_LEVEL_PCALL(8,CS.MapManagerInterface,'PlayEffectOnActor',false,nil)


function api_Available_SetChildUIModelGray()return cur_api_level>=9 end
SET_API_LEVEL_PCALL(9,CS.CSGUIWidgetBase,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUISlotItemBase,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.BagGridItem,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIWindowBase,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIListItem,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIListColumn,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIItemBase,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIBaseItem,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIComboMainItem,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIComboSubItem,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIWindowLua,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIWindowLua3DView,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.EnhancedScrollerLua,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.EnhancedScrollerGridLua,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIWindowWithHUD,'SetChildUIModelGray',false,nil)
SET_API_LEVEL_PCALL(9,CS.CSGUIStatusWidget,'SetChildUIModelGray',false,nil)


function api_Available_SetGray()return cur_api_level>=9 end
SET_API_LEVEL_PCALL(9,CS.Entity,'SetGray',false,nil)


function api_Available_DisableAllEffect()return cur_api_level>=10 end
SET_API_LEVEL_PCALL(10,CS.CameraScreenEffect,'DisableAllEffect',false,nil)


function api_Available_SetWiggle()return cur_api_level>=10 end
SET_API_LEVEL_PCALL(10,CS.CameraScreenEffect,'SetWiggle',false,nil)


function api_Available_EnableIndex()return cur_api_level>=10 end
SET_API_LEVEL_PCALL(10,CS.CameraScreenEffect,'EnableIndex',false,nil)


function api_Available_RemoveEffectOnActor()return cur_api_level>=10 end
SET_API_LEVEL_PCALL(10,CS.MapManagerInterface,'RemoveEffectOnActor',false,nil)


function api_Available_SetChildUIModelUpdateRendererSize()return cur_api_level>=11 end
SET_API_LEVEL_PCALL(11,CS.CSGUIWidgetBase,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUISlotItemBase,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.BagGridItem,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIWindowBase,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIListItem,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIListColumn,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIItemBase,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIBaseItem,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIComboMainItem,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIComboSubItem,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIWindowLua,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIWindowLua3DView,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.EnhancedScrollerLua,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.EnhancedScrollerGridLua,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIWindowWithHUD,'SetChildUIModelUpdateRendererSize',false,nil)
SET_API_LEVEL_PCALL(11,CS.CSGUIStatusWidget,'SetChildUIModelUpdateRendererSize',false,nil)


function api_Available_SetLoadFromFimeTryCount()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.ResourceHelper,'SetLoadFromFimeTryCount',false,nil)


function api_Available_WWWLoader_SetTimeout()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.ResourceHelper,'WWWLoader_SetTimeout',false,nil)


function api_Available_SetChildScrollViewChangeItemListEx()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildScrollViewChangeItemListEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildScrollViewChangeItemListEx',false,nil)


function api_Available_SetChildSizeDeltaEx()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildSizeDeltaEx',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildSizeDeltaEx',false,nil)


function api_Available_SetChildComboBoxChangeShow()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildComboBoxChangeShow',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildComboBoxChangeShow',false,nil)


function api_Available_SetChildScrollViewGridDragActive()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildScrollViewGridDragActive',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildScrollViewGridDragActive',false,nil)


function api_Available_GetChildSimulateTargetComponent()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'GetChildSimulateTargetComponent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'GetChildSimulateTargetComponent',false,nil)


function api_Available_SetChildSimulate3DActiveDragMode()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildSimulate3DActiveDragMode',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildSimulate3DActiveDragMode',false,nil)


function api_Available_SetChildScrollViewTriggerScrollEvent()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildScrollViewTriggerScrollEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildScrollViewTriggerScrollEvent',false,nil)


function api_Available_SetChildSimulate3DActiveCoverColor()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildSimulate3DActiveCoverColor',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildSimulate3DActiveCoverColor',false,nil)


function api_Available_SetChildSimulate3D()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildSimulate3D',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildSimulate3D',false,nil)


function api_Available_SetChildSimulate3DDragArea()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildSimulate3DDragArea',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildSimulate3DDragArea',false,nil)


function api_Available_SetChildSimulate3DBaseScale()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildSimulate3DBaseScale',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildSimulate3DBaseScale',false,nil)


function api_Available_SetChildSimulate3DActiveUpdate()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildSimulate3DActiveUpdate',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildSimulate3DActiveUpdate',false,nil)


function api_Available_SetChildDragStartAndEndEvent()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildDragStartAndEndEvent',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildDragStartAndEndEvent',false,nil)


function api_Available_ScreenPointToRectTransform()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIManager,'ScreenPointToRectTransform',false,nil)


function api_Available_SetChildScrollViewHandleMarkId()return cur_api_level>=12 end
SET_API_LEVEL_PCALL(12,CS.CSGUIWidgetBase,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUISlotItemBase,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.BagGridItem,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowBase,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListItem,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIListColumn,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIItemBase,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIBaseItem,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboMainItem,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIComboSubItem,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowLua3DView,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerLua,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.EnhancedScrollerGridLua,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIWindowWithHUD,'SetChildScrollViewHandleMarkId',false,nil)
SET_API_LEVEL_PCALL(12,CS.CSGUIStatusWidget,'SetChildScrollViewHandleMarkId',false,nil)


function api_Available_GetChildMinSize()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'GetChildMinSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'GetChildMinSize',false,nil)


function api_Available_GetChildFlexibleSize()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'GetChildFlexibleSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'GetChildFlexibleSize',false,nil)


function api_Available_ForceLayoutVertical()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'ForceLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'ForceLayoutVertical',false,nil)


function api_Available_ForceLayoutHorizontal()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'ForceLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'ForceLayoutHorizontal',false,nil)


function api_Available_SetChildLayoutGrouprLayoutVertical()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildLayoutGrouprLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildLayoutGrouprLayoutVertical',false,nil)


function api_Available_SetChildLayoutElementMinHeight()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildLayoutElementMinHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildLayoutElementMinHeight',false,nil)


function api_Available_SetChildLayoutGroupLayoutHorizontal()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildLayoutGroupLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildLayoutGroupLayoutHorizontal',false,nil)


function api_Available_SetChildLayoutElementflexibleHeight()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildLayoutElementflexibleHeight',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildLayoutElementflexibleHeight',false,nil)


function api_Available_SetChildLayoutElementflexibleWidth()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildLayoutElementflexibleWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildLayoutElementflexibleWidth',false,nil)


function api_Available_SetChildContentSizeFitterLayoutVertical()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildContentSizeFitterLayoutVertical',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildContentSizeFitterLayoutVertical',false,nil)


function api_Available_GetChildPreferredSize()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'GetChildPreferredSize',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'GetChildPreferredSize',false,nil)


function api_Available_SetChildSizeWithCurrentAnchors()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildSizeWithCurrentAnchors',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildSizeWithCurrentAnchors',false,nil)


function api_Available_SetChildLayoutElementMinWidth()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildLayoutElementMinWidth',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildLayoutElementMinWidth',false,nil)


function api_Available_GetChildLoopListView2()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'GetChildLoopListView2',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'GetChildLoopListView2',false,nil)


function api_Available_SetChildContentSizeFitterLayoutHorizontal()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildContentSizeFitterLayoutHorizontal',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildContentSizeFitterLayoutHorizontal',false,nil)


function api_Available_SetLayoutRect()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetLayoutRect',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetLayoutRect',false,nil)


function api_Available_FreshChildLayoutRectThree()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'FreshChildLayoutRectThree',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'FreshChildLayoutRectThree',false,nil)


function api_Available_SetChildAttachRectThreeOffset()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'SetChildAttachRectThreeOffset',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'SetChildAttachRectThreeOffset',false,nil)


function api_Available_GetChildUILoopListView()return cur_api_level>=13 end
SET_API_LEVEL_PCALL(13,CS.CSGUIWidgetBase,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUISlotItemBase,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.BagGridItem,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowBase,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListItem,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIListColumn,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIItemBase,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIBaseItem,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboMainItem,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIComboSubItem,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowLua3DView,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerLua,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.EnhancedScrollerGridLua,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIWindowWithHUD,'GetChildUILoopListView',false,nil)
SET_API_LEVEL_PCALL(13,CS.CSGUIStatusWidget,'GetChildUILoopListView',false,nil)


function api_Available_SetChildUIModelEnableInitUISpinePara()return cur_api_level>=15 end
SET_API_LEVEL_PCALL(15,CS.CSGUIWidgetBase,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUISlotItemBase,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.BagGridItem,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIWindowBase,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIListItem,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIListColumn,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIItemBase,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIBaseItem,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIComboMainItem,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIComboSubItem,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIWindowLua,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIWindowLua3DView,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.EnhancedScrollerLua,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.EnhancedScrollerGridLua,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIWindowWithHUD,'SetChildUIModelEnableInitUISpinePara',false,nil)
SET_API_LEVEL_PCALL(15,CS.CSGUIStatusWidget,'SetChildUIModelEnableInitUISpinePara',false,nil)


function api_Available_PreLoadAssetArray()return cur_api_level>=15 end
SET_API_LEVEL_PCALL(15,CS.FightUnit.FightManager,'PreLoadAssetArray',false,nil)


function api_Available_PreLoadEffect()return cur_api_level>=15 end
SET_API_LEVEL_PCALL(15,CS.FightUnit.FightManager,'PreLoadEffect',false,nil)


function api_Available_AssetPoolLoader_PreloadEx()return cur_api_level>=15 end
SET_API_LEVEL_PCALL(15,CS.ResourceHelper,'AssetPoolLoader_PreloadEx',false,nil)


function api_Available_CleanCache()return cur_api_level>=15 end
SET_API_LEVEL_PCALL(15,CS.FightUnit.FightManager,'CleanCache',false,nil)


function api_Available_SetChildUIModelMountSeparatorSlot()return cur_api_level>=16 end
SET_API_LEVEL_PCALL(16,CS.CSGUIWidgetBase,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUISlotItemBase,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.BagGridItem,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIWindowBase,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIListItem,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIListColumn,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIItemBase,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIBaseItem,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIComboMainItem,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIComboSubItem,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIWindowLua,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIWindowLua3DView,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.EnhancedScrollerLua,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.EnhancedScrollerGridLua,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIWindowWithHUD,'SetChildUIModelMountSeparatorSlot',false,nil)
SET_API_LEVEL_PCALL(16,CS.CSGUIStatusWidget,'SetChildUIModelMountSeparatorSlot',false,nil)


function api_Available_streamingAssetsAssetBundlePath()return cur_api_level>=17 end
SET_API_LEVEL_PCALL(17,CS.GamePath,'streamingAssetsAssetBundlePath',true,nil)


function api_Available_logPath()return cur_api_level>=17 end
SET_API_LEVEL_PCALL(17,CS.GamePath,'logPath',true,nil)


function api_Available_streamingAssetsAssetBundleUrl()return cur_api_level>=17 end
SET_API_LEVEL_PCALL(17,CS.GamePath,'streamingAssetsAssetBundleUrl',true,nil)


function api_Available_streamingAssetsUrl()return cur_api_level>=17 end
SET_API_LEVEL_PCALL(17,CS.GamePath,'streamingAssetsUrl',true,nil)


function api_Available_streamingAssetsPath()return cur_api_level>=17 end
SET_API_LEVEL_PCALL(17,CS.GamePath,'streamingAssetsPath',true,nil)


function api_Available_SetChildUIModelShowFlipY()return cur_api_level>=17 end
SET_API_LEVEL_PCALL(17,CS.CSGUIWidgetBase,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUISlotItemBase,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.BagGridItem,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIWindowBase,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIListItem,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIListColumn,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIItemBase,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIBaseItem,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIComboMainItem,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIComboSubItem,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIWindowLua,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIWindowLua3DView,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.EnhancedScrollerLua,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.EnhancedScrollerGridLua,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIWindowWithHUD,'SetChildUIModelShowFlipY',false,nil)
SET_API_LEVEL_PCALL(17,CS.CSGUIStatusWidget,'SetChildUIModelShowFlipY',false,nil)


function api_Available_SetChildUIModelEnableInitUISpineParaEx()return cur_api_level>=18 end
SET_API_LEVEL_PCALL(18,CS.CSGUIWidgetBase,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUISlotItemBase,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.BagGridItem,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIWindowBase,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIListItem,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIListColumn,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIItemBase,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIBaseItem,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIComboMainItem,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIComboSubItem,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIWindowLua,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIWindowLua3DView,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.EnhancedScrollerLua,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.EnhancedScrollerGridLua,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIWindowWithHUD,'SetChildUIModelEnableInitUISpineParaEx',false,nil)
SET_API_LEVEL_PCALL(18,CS.CSGUIStatusWidget,'SetChildUIModelEnableInitUISpineParaEx',false,nil)


function api_Available_SetCellCoverTypeInArea()return cur_api_level>=19 end
SET_API_LEVEL_PCALL(19,CS.MapManagerInterface,'SetCellCoverTypeInArea',false,nil)


function api_Available_SetCellsCoverTypeInRange()return cur_api_level>=19 end
SET_API_LEVEL_PCALL(19,CS.MapManagerInterface,'SetCellsCoverTypeInRange',false,nil)


function api_Available_SetChildCSImage()return cur_api_level>=20 end
SET_API_LEVEL_PCALL(20,CS.CSGUIWidgetBase,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUISlotItemBase,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.BagGridItem,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIWindowBase,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIListItem,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIListColumn,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIItemBase,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIBaseItem,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIComboMainItem,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIComboSubItem,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIWindowLua,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIWindowLua3DView,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.EnhancedScrollerLua,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.EnhancedScrollerGridLua,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIWindowWithHUD,'SetChildCSImage',false,nil)
SET_API_LEVEL_PCALL(20,CS.CSGUIStatusWidget,'SetChildCSImage',false,nil)


function api_Available_SetSafeAreaOffset()return cur_api_level>=22 end
SET_API_LEVEL_PCALL(22,CS.UIManager,'SetSafeAreaOffset',false,nil)


function api_Available_LoadTextAsset()return cur_api_level>=23 end
SET_API_LEVEL_PCALL(23,CS.ResourceHelper,'LoadTextAsset',false,nil)


function api_Available_CroppingTexture()return cur_api_level>=24 end
SET_API_LEVEL_PCALL(24,CS.CSGUIWidgetBase,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUISlotItemBase,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.BagGridItem,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIWindowBase,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIListItem,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIListColumn,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIItemBase,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIBaseItem,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIComboMainItem,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIComboSubItem,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIWindowLua,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIWindowLua3DView,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.EnhancedScrollerLua,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.EnhancedScrollerGridLua,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIWindowWithHUD,'CroppingTexture',false,nil)
SET_API_LEVEL_PCALL(24,CS.CSGUIStatusWidget,'CroppingTexture',false,nil)


function api_Available_ToChineseCalendar()return cur_api_level>=24 end
SET_API_LEVEL_PCALL(24,CS.LuaHelper,'ToChineseCalendar',false,nil)


function api_Available_EnableDragonBoneReleasePool()return cur_api_level>=25 end
SET_API_LEVEL_PCALL(25,CS.ResourceHelper,'EnableDragonBoneReleasePool',false,nil)


function api_Available_SetDragonBoneReleasePoolTime()return cur_api_level>=25 end
SET_API_LEVEL_PCALL(25,CS.ResourceHelper,'SetDragonBoneReleasePoolTime',false,nil)


function api_Available_EnableSpineReleasePool()return cur_api_level>=25 end
SET_API_LEVEL_PCALL(25,CS.ResourceHelper,'EnableSpineReleasePool',false,nil)


function api_Available_SetSpineReleasePoolTime()return cur_api_level>=25 end
SET_API_LEVEL_PCALL(25,CS.ResourceHelper,'SetSpineReleasePoolTime',false,nil)


function api_Available_SetChildFightRenderToImage()return cur_api_level>=26 end
SET_API_LEVEL_PCALL(26,CS.CSGUIWidgetBase,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUISlotItemBase,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.BagGridItem,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIWindowBase,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIListItem,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIListColumn,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIItemBase,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIBaseItem,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIComboMainItem,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIComboSubItem,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIWindowLua,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIWindowLua3DView,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.EnhancedScrollerLua,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.EnhancedScrollerGridLua,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIWindowWithHUD,'SetChildFightRenderToImage',false,nil)
SET_API_LEVEL_PCALL(26,CS.CSGUIStatusWidget,'SetChildFightRenderToImage',false,nil)


function api_Available_SetChildModelCaptureImageEx()return cur_api_level>=27 end
SET_API_LEVEL_PCALL(27,CS.CSGUIWidgetBase,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUISlotItemBase,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.BagGridItem,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIWindowBase,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIListItem,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIListColumn,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIItemBase,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIBaseItem,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIComboMainItem,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIComboSubItem,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIWindowLua,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIWindowLua3DView,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.EnhancedScrollerLua,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.EnhancedScrollerGridLua,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIWindowWithHUD,'SetChildModelCaptureImageEx',false,nil)
SET_API_LEVEL_PCALL(27,CS.CSGUIStatusWidget,'SetChildModelCaptureImageEx',false,nil)


function api_Available_GetROMFreeSpace()return cur_api_level>=28 end
SET_API_LEVEL_PCALL(28,CS.GameInterface,'GetROMFreeSpace',false,nil)


function api_Available_GetRAMTotalSpace()return cur_api_level>=28 end
SET_API_LEVEL_PCALL(28,CS.GameInterface,'GetRAMTotalSpace',false,nil)


function api_Available_SetChildModelCaptureIcon()return cur_api_level>=29 end
SET_API_LEVEL_PCALL(29,CS.CSGUIWidgetBase,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUISlotItemBase,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.BagGridItem,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIWindowBase,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIListItem,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIListColumn,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIItemBase,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIBaseItem,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIComboMainItem,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIComboSubItem,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIWindowLua,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIWindowLua3DView,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.EnhancedScrollerLua,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.EnhancedScrollerGridLua,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIWindowWithHUD,'SetChildModelCaptureIcon',false,nil)
SET_API_LEVEL_PCALL(29,CS.CSGUIStatusWidget,'SetChildModelCaptureIcon',false,nil)


function api_Available_SetCellCoverTypeByPosList()return cur_api_level>=29 end
SET_API_LEVEL_PCALL(29,CS.MapManagerInterface,'SetCellCoverTypeByPosList',false,nil)


function api_Available_EnableLight()return cur_api_level>=30 end
SET_API_LEVEL_PCALL(30,CS.Entity,'EnableLight',false,nil)


function api_Available_GetRAMFreeSpace()return cur_api_level>=30 end
SET_API_LEVEL_PCALL(30,CS.GameInterface,'GetRAMFreeSpace',false,nil)


function api_Available_GetROMTotalSpace()return cur_api_level>=30 end
SET_API_LEVEL_PCALL(30,CS.GameInterface,'GetROMTotalSpace',false,nil)


function api_Available_DrawInRangeEx()return cur_api_level>=33 end
SET_API_LEVEL_PCALL(33,CS.MapManagerInterface,'DrawInRangeEx',false,nil)


function api_Available_ReplaceCellCheckFunction()return cur_api_level>=33 end
SET_API_LEVEL_PCALL(33,CS.MapManagerInterface,'ReplaceCellCheckFunction',false,nil)


function api_Available_SetCellCoverTypeInAreaEx()return cur_api_level>=33 end
SET_API_LEVEL_PCALL(33,CS.MapManagerInterface,'SetCellCoverTypeInAreaEx',false,nil)


function api_Available_SetCellsCoverTypeInRangeEx()return cur_api_level>=33 end
SET_API_LEVEL_PCALL(33,CS.MapManagerInterface,'SetCellsCoverTypeInRangeEx',false,nil)


function api_Available_SetCellCoverTypeByPosListEx()return cur_api_level>=33 end
SET_API_LEVEL_PCALL(33,CS.MapManagerInterface,'SetCellCoverTypeByPosListEx',false,nil)


function api_Available_SetTilemapObjectLayer()return cur_api_level>=33 end
SET_API_LEVEL_PCALL(33,CS.MapManagerInterface,'SetTilemapObjectLayer',false,nil)


function api_Available_SoundManager_GetAudioByUGUID()return cur_api_level>=34 end
SET_API_LEVEL_PCALL(34,CS.GameInterface,'SoundManager_GetAudioByUGUID',false,nil)


function api_Available_SetWorldEntityUseSmall()return cur_api_level>=35 end
SET_API_LEVEL_PCALL(35,CS.WorldEntitySetting,'SetWorldEntityUseSmall',false,nil)


function api_Available_SetCellCheckRange()return cur_api_level>=36 end
SET_API_LEVEL_PCALL(36,CS.MapManagerInterface,'SetCellCheckRange',false,nil)


function api_Available_SetRoleMoveArgs()return cur_api_level>=36 end
SET_API_LEVEL_PCALL(36,CS.MapManagerInterface,'SetRoleMoveArgs',false,nil)


function api_Available_MoveToPositionEx()return cur_api_level>=36 end
SET_API_LEVEL_PCALL(36,CS.MapManagerInterface,'MoveToPositionEx',false,nil)


function api_Available_EnableRayHit()return cur_api_level>=37 end
SET_API_LEVEL_PCALL(37,CS.Entity,'EnableRayHit',false,nil)


function api_Available_SetTilemapObjectClickActive()return cur_api_level>=37 end
SET_API_LEVEL_PCALL(37,CS.MapManagerInterface,'SetTilemapObjectClickActive',false,nil)


function api_Available_HttpGetRequestEx()return cur_api_level>=38 end
SET_API_LEVEL_PCALL(38,CS.ResourceHelper,'HttpGetRequestEx',false,nil)


function api_Available_ChildRawImageLoader()return cur_api_level>=39 end
SET_API_LEVEL_PCALL(39,CS.CSGUIWidgetBase,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUISlotItemBase,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.BagGridItem,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIWindowBase,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIListItem,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIListColumn,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIItemBase,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIBaseItem,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIComboMainItem,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIComboSubItem,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIWindowLua,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIWindowLua3DView,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.EnhancedScrollerLua,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.EnhancedScrollerGridLua,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIWindowWithHUD,'ChildRawImageLoader',false,nil)
SET_API_LEVEL_PCALL(39,CS.CSGUIStatusWidget,'ChildRawImageLoader',false,nil)


function api_Available_SetChildModelAnimationStateWithProgress()return cur_api_level>=40 end
SET_API_LEVEL_PCALL(40,CS.CSGUIWidgetBase,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUISlotItemBase,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.BagGridItem,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIWindowBase,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIListItem,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIListColumn,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIItemBase,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIBaseItem,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIComboMainItem,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIComboSubItem,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIWindowLua,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIWindowLua3DView,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.EnhancedScrollerLua,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.EnhancedScrollerGridLua,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIWindowWithHUD,'SetChildModelAnimationStateWithProgress',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIStatusWidget,'SetChildModelAnimationStateWithProgress',false,nil)


function api_Available_SetPlaceObjectCover()return cur_api_level>=40 end
SET_API_LEVEL_PCALL(40,CS.MapManagerInterface,'SetPlaceObjectCover',false,nil)


function api_Available_SetChildLimitRange()return cur_api_level>=40 end
SET_API_LEVEL_PCALL(40,CS.CSGUIWidgetBase,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUISlotItemBase,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.BagGridItem,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIWindowBase,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIListItem,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIListColumn,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIItemBase,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIBaseItem,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIComboMainItem,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIComboSubItem,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIWindowLua,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIWindowLua3DView,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.EnhancedScrollerLua,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.EnhancedScrollerGridLua,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIWindowWithHUD,'SetChildLimitRange',false,nil)
SET_API_LEVEL_PCALL(40,CS.CSGUIStatusWidget,'SetChildLimitRange',false,nil)


function api_Available_SetPlaceObjectLayer()return cur_api_level>=40 end
SET_API_LEVEL_PCALL(40,CS.MapManagerInterface,'SetPlaceObjectLayer',false,nil)


function api_Available_SetAnimationStateWithProgress()return cur_api_level>=40 end
SET_API_LEVEL_PCALL(40,CS.Entity,'SetAnimationStateWithProgress',false,nil)


function api_Available_SetCustomArea()return cur_api_level>=46 end
SET_API_LEVEL_PCALL(46,CS.GameInterface,'SetCustomArea',false,nil)


function api_Available_GetSystemCopyBuffer()return cur_api_level>=50 end
SET_API_LEVEL_PCALL(50,CS.GameInterface,'GetSystemCopyBuffer',false,nil)


function api_Available_SetSystemCopyBuffer()return cur_api_level>=50 end
SET_API_LEVEL_PCALL(50,CS.GameInterface,'SetSystemCopyBuffer',false,nil)


function api_Available_ReloadBaseBundle()return cur_api_level>=51 end
SET_API_LEVEL_PCALL(51,CS.ResourceHelper,'ReloadBaseBundle',false,nil)


function api_Available_SetFindPathLimit()return cur_api_level>=52 end
SET_API_LEVEL_PCALL(52,CS.MapManagerInterface,'SetFindPathLimit',false,nil)


function api_Available_GetDeviceOrientation()return cur_api_level>=53 end
SET_API_LEVEL_PCALL(53,CS.GameInterface,'GetDeviceOrientation',false,nil)


function api_Available_SetScreenOrientation()return cur_api_level>=55 end
SET_API_LEVEL_PCALL(55,CS.GameInterface,'SetScreenOrientation',false,nil)


function api_Available_ReleaseUIModelCache()return cur_api_level>=57 end
SET_API_LEVEL_PCALL(57,CS.ResourceHelper,'ReleaseUIModelCache',false,nil)


function api_Available_ReleaseSpinePool()return cur_api_level>=57 end
SET_API_LEVEL_PCALL(57,CS.ResourceHelper,'ReleaseSpinePool',false,nil)


function api_Available_ReleaseDragonBonePool()return cur_api_level>=57 end
SET_API_LEVEL_PCALL(57,CS.ResourceHelper,'ReleaseDragonBonePool',false,nil)


function api_Available_GetChildLoopTreeView()return cur_api_level>=59 end
SET_API_LEVEL_PCALL(59,CS.CSGUIWidgetBase,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUISlotItemBase,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.BagGridItem,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIWindowBase,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIListItem,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIListColumn,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIItemBase,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIBaseItem,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIComboMainItem,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIComboSubItem,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIWindowLua,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIWindowLua3DView,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.EnhancedScrollerLua,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.EnhancedScrollerGridLua,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIWindowWithHUD,'GetChildLoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIStatusWidget,'GetChildLoopTreeView',false,nil)


function api_Available_GetChildUILoopTreeView()return cur_api_level>=59 end
SET_API_LEVEL_PCALL(59,CS.CSGUIWidgetBase,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUISlotItemBase,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.BagGridItem,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIWindowBase,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIListItem,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIListColumn,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIItemBase,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIBaseItem,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIComboMainItem,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIComboSubItem,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIWindowLua,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIWindowLua3DView,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.EnhancedScrollerLua,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.EnhancedScrollerGridLua,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIWindowWithHUD,'GetChildUILoopTreeView',false,nil)
SET_API_LEVEL_PCALL(59,CS.CSGUIStatusWidget,'GetChildUILoopTreeView',false,nil)


function api_Available_SetDownLoadWriteByte()return cur_api_level>=61 end
SET_API_LEVEL_PCALL(61,CS.ResourceHelper,'SetDownLoadWriteByte',false,nil)


function api_Available_ChangeScreen()return cur_api_level>=62 end
SET_API_LEVEL_PCALL(62,CS.GameInterface,'ChangeScreen',false,nil)


function api_Available_ClearAssetPoolCache()return cur_api_level>=63 end
SET_API_LEVEL_PCALL(63,CS.GameInterface,'ClearAssetPoolCache',false,nil)


function api_Available_OnWheel()return cur_api_level>=64 end
SET_API_LEVEL_PCALL(64,CS.WXInterface,'OnWheel',false,nil)


function api_Available_GetClipboardData()return cur_api_level>=64 end
SET_API_LEVEL_PCALL(64,CS.WXInterface,'GetClipboardData',false,nil)


function api_Available_SetClipboardData()return cur_api_level>=64 end
SET_API_LEVEL_PCALL(64,CS.WXInterface,'SetClipboardData',false,nil)


function api_Available_GetAppBaseInfo()return cur_api_level>=65 end
SET_API_LEVEL_PCALL(65,CS.WXInterface,'GetAppBaseInfo',false,nil)


function api_Available_OnHide()return cur_api_level>=65 end
SET_API_LEVEL_PCALL(65,CS.WXInterface,'OnHide',false,nil)


function api_Available_GetDeviceInfo()return cur_api_level>=65 end
SET_API_LEVEL_PCALL(65,CS.WXInterface,'GetDeviceInfo',false,nil)


function api_Available_OnShow()return cur_api_level>=65 end
SET_API_LEVEL_PCALL(65,CS.WXInterface,'OnShow',false,nil)


function api_Available_GetJobWorkerCount()return cur_api_level>=65 end
SET_API_LEVEL_PCALL(65,CS.GameInterface,'GetJobWorkerCount',false,nil)


function api_Available_GetAccountInfoSync()return cur_api_level>=65 end
SET_API_LEVEL_PCALL(65,CS.WXInterface,'GetAccountInfoSync',false,nil)


function api_Available_SetJobWorkerCount()return cur_api_level>=65 end
SET_API_LEVEL_PCALL(65,CS.GameInterface,'SetJobWorkerCount',false,nil)


function api_Available_GetChildRTCorners()return cur_api_level>=66 end
SET_API_LEVEL_PCALL(66,CS.CSGUIWidgetBase,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUISlotItemBase,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.BagGridItem,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIWindowBase,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIListItem,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIListColumn,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIItemBase,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIBaseItem,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIComboMainItem,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIComboSubItem,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIWindowLua,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIWindowLua3DView,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.EnhancedScrollerLua,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.EnhancedScrollerGridLua,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIWindowWithHUD,'GetChildRTCorners',false,nil)
SET_API_LEVEL_PCALL(66,CS.CSGUIStatusWidget,'GetChildRTCorners',false,nil)


function api_Available_CloseScreenSlash()return cur_api_level>=67 end
SET_API_LEVEL_PCALL(67,CS.GameInterface,'CloseScreenSlash',false,nil)


function api_Available_SetNegative()return cur_api_level>=67 end
SET_API_LEVEL_PCALL(67,CS.CameraScreenEffect,'SetNegative',false,nil)


function api_Available_OpenURL()return cur_api_level>=68 end
SET_API_LEVEL_PCALL(68,CS.GameInterface,'OpenURL',false,nil)


function api_Available_SetFreezeAnimation()return cur_api_level>=68 end
SET_API_LEVEL_PCALL(68,CS.Entity,'SetFreezeAnimation',false,nil)


function api_Available_GetRuntimeInfo()return cur_api_level>=68 end
SET_API_LEVEL_PCALL(68,CS.WXInterface,'GetRuntimeInfo',false,nil)


function api_Available_SetFreezeAnimationByTypeArray()return cur_api_level>=70 end
SET_API_LEVEL_PCALL(70,CS.MapManagerInterface,'SetFreezeAnimationByTypeArray',false,nil)


function api_Available_GetAllTilemapObjectGUIDByTypeArray()return cur_api_level>=70 end
SET_API_LEVEL_PCALL(70,CS.MapManagerInterface,'GetAllTilemapObjectGUIDByTypeArray',false,nil)


function api_Available_GetLaunchOptionsSync()return cur_api_level>=70 end
SET_API_LEVEL_PCALL(70,CS.WXInterface,'GetLaunchOptionsSync',false,nil)


function api_Available_SetChildUVImageScrollSprite()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.CSGUIWidgetBase,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUISlotItemBase,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.BagGridItem,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowBase,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIListItem,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIListColumn,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIItemBase,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIBaseItem,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIComboMainItem,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIComboSubItem,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowLua,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowLua3DView,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.EnhancedScrollerLua,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.EnhancedScrollerGridLua,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowWithHUD,'SetChildUVImageScrollSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIStatusWidget,'SetChildUVImageScrollSprite',false,nil)


function api_Available_GetModelEntity()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.WorldObjectData,'GetModelEntity',false,nil)


function api_Available_SetFreeze()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.WorldModelData,'SetFreeze',false,nil)


function api_Available_GetEntity()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.WorldModelData,'GetEntity',false,nil)


function api_Available_IsFreeze()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.WorldModelData,'IsFreeze',true,nil)


function api_Available_specialHeightLine()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.WorldCameraSetting,'specialHeightLine',true,nil)


function api_Available_SetUnitModelFreeze()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.WorldObjectManager,'SetUnitModelFreeze',false,nil)


function api_Available_GetObjectDataList()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.WorldObjectManager,'GetObjectDataList',false,nil)


function api_Available_GetUnitEntity()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.WorldObjectManager,'GetUnitEntity',false,nil)


function api_Available_SetChildUVImageFrameSprite()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.CSGUIWidgetBase,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUISlotItemBase,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.BagGridItem,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowBase,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIListItem,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIListColumn,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIItemBase,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIBaseItem,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIComboMainItem,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIComboSubItem,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowLua,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowLua3DView,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.EnhancedScrollerLua,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.EnhancedScrollerGridLua,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowWithHUD,'SetChildUVImageFrameSprite',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIStatusWidget,'SetChildUVImageFrameSprite',false,nil)


function api_Available_SetChildUVImagePause()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.CSGUIWidgetBase,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUISlotItemBase,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.BagGridItem,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowBase,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIListItem,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIListColumn,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIItemBase,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIBaseItem,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIComboMainItem,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIComboSubItem,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowLua,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowLua3DView,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.EnhancedScrollerLua,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.EnhancedScrollerGridLua,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIWindowWithHUD,'SetChildUVImagePause',false,nil)
SET_API_LEVEL_PCALL(71,CS.CSGUIStatusWidget,'SetChildUVImagePause',false,nil)


function api_Available_SetModelFreeze()return cur_api_level>=71 end
SET_API_LEVEL_PCALL(71,CS.WorldObjectData,'SetModelFreeze',false,nil)


function api_Available_ReleaseCloudMaskRT()return cur_api_level>=72 end
SET_API_LEVEL_PCALL(72,CS.GameInterface,'ReleaseCloudMaskRT',false,nil)


function api_Available_replaceencode()return cur_api_level>=74 end
SET_API_LEVEL_PCALL(74,CS.GameInterface,'replaceencode',false,nil)


function api_Available_DOTransformSpriteRendererFade()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,Lua.DOTweenProxyExtensions,'DOTransformSpriteRendererFade',false,nil)


function api_Available_DOTransformSpriteRendererColor()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,Lua.DOTweenProxyExtensions,'DOTransformSpriteRendererColor',false,nil)


function api_Available_SetChildSpriteRendererDOFade()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererDOFade',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSpriteRendererDOFade',false,nil)


function api_Available_SetChildSceneEntityGetSlotTransform()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityGetSlotTransform',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityGetSlotTransform',false,nil)


function api_Available_SetChildSceneEntityTransformPosition()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityTransformPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityTransformPosition',false,nil)


function api_Available_SetChildSceneEntitySetSlotIcon()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetSlotIcon',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntitySetSlotIcon',false,nil)


function api_Available_SetChildSceneEntitySetScale()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetScale',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntitySetScale',false,nil)


function api_Available_SetChildSceneEntitySetFreeze()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetFreeze',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntitySetFreeze',false,nil)


function api_Available_SetChildSceneEntitySetPosition()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetPosition',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntitySetPosition',false,nil)


function api_Available_SetChildSceneEntityUnMount()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityUnMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityUnMount',false,nil)


function api_Available_SetChildSceneEntityMount()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityMount',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityMount',false,nil)


function api_Available_SetChildSceneEntityChangeColor()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityChangeColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityChangeColor',false,nil)


function api_Available_SetChildSceneEntityStopEffectOnActor()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityStopEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityStopEffectOnActor',false,nil)


function api_Available_SetChildSceneEntitySetRotation()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetRotation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntitySetRotation',false,nil)


function api_Available_SetChildSceneEntityShowShadow()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityShowShadow',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityShowShadow',false,nil)


function api_Available_SetChildSceneEntitySetOffset()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetOffset',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntitySetOffset',false,nil)


function api_Available_SetChildSceneEntityCreateObject()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityCreateObject',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityCreateObject',false,nil)


function api_Available_SetChildSceneEntityRemoveModel()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityRemoveModel',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityRemoveModel',false,nil)


function api_Available_SetChildSceneEntitySetVisible()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetVisible',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntitySetVisible',false,nil)


function api_Available_SetChildSceneEntitySetOrder()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetOrder',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntitySetOrder',false,nil)


function api_Available_SetChildSceneEntityFreezeAnimation()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityFreezeAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityFreezeAnimation',false,nil)


function api_Available_SetChildSpriteRendererDOColor()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererDOColor',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSpriteRendererDOColor',false,nil)


function api_Available_SetChildSceneEntityFlipX()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityFlipX',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityFlipX',false,nil)


function api_Available_SetChildSceneEntityPlayAnimation()return cur_api_level>=80 end
SET_API_LEVEL_PCALL(80,CS.CSGUIWidgetBase,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUISlotItemBase,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.BagGridItem,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowBase,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListItem,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIListColumn,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIItemBase,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIBaseItem,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboMainItem,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIComboSubItem,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowLua3DView,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerLua,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.EnhancedScrollerGridLua,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIWindowWithHUD,'SetChildSceneEntityPlayAnimation',false,nil)
SET_API_LEVEL_PCALL(80,CS.CSGUIStatusWidget,'SetChildSceneEntityPlayAnimation',false,nil)


function api_Available_pcCopyLogToDesktop()return cur_api_level>=90 end
SET_API_LEVEL_PCALL(90,CS.GameInterface,'pcCopyLogToDesktop',false,nil)


function api_Available_setEnableFileLog()return cur_api_level>=90 end
SET_API_LEVEL_PCALL(90,CS.GameInterface,'setEnableFileLog',false,nil)


function api_Available_OnKeyDown()return cur_api_level>=100 end
SET_API_LEVEL_PCALL(100,CS.WXInterface,'OnKeyDown',false,nil)


function api_Available_OnKeyUp()return cur_api_level>=100 end
SET_API_LEVEL_PCALL(100,CS.WXInterface,'OnKeyUp',false,nil)


function api_Available_SetChildSpriteRenderer()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildSpriteRenderer',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildSpriteRenderer',false,nil)


function api_Available_SetChildSpriteRendererWithBundle()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererWithBundle',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildSpriteRendererWithBundle',false,nil)


function api_Available_SetChildSpriteRendererAnimationStringID()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererAnimationStringID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildSpriteRendererAnimationStringID',false,nil)


function api_Available_SetChildSpriteRendererAnimationEffect()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererAnimationEffect',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildSpriteRendererAnimationEffect',false,nil)


function api_Available_SetChildSpriteRendererAnimationCurrentFrame()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildSpriteRendererAnimationCurrentFrame',false,nil)


function api_Available_SetChildSpriteRendererAlpha()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererAlpha',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildSpriteRendererAlpha',false,nil)


function api_Available_SetChildSpriteRendererAnimationStatus()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererAnimationStatus',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildSpriteRendererAnimationStatus',false,nil)


function api_Available_SetChildUIFollowWorldTransformInitObj()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildUIFollowWorldTransformInitObj',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildUIFollowWorldTransformInitObj',false,nil)


function api_Available_SetChildUIFollowWorldTransformInitPos()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildUIFollowWorldTransformInitPos',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildUIFollowWorldTransformInitPos',false,nil)


function api_Available_SetChildSpriteRendererAnimationID()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererAnimationID',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildSpriteRendererAnimationID',false,nil)


function api_Available_SetChildUIFollowWorldTransformStop()return cur_api_level>=110 end
SET_API_LEVEL_PCALL(110,CS.CSGUIWidgetBase,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUISlotItemBase,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.BagGridItem,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowBase,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListItem,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIListColumn,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIItemBase,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIBaseItem,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboMainItem,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIComboSubItem,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowLua3DView,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerLua,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.EnhancedScrollerGridLua,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIWindowWithHUD,'SetChildUIFollowWorldTransformStop',false,nil)
SET_API_LEVEL_PCALL(110,CS.CSGUIStatusWidget,'SetChildUIFollowWorldTransformStop',false,nil)


function api_Available_IsShortcutExist()return cur_api_level>=120 end
SET_API_LEVEL_PCALL(120,CS.WXInterface,'IsShortcutExist',false,nil)


function api_Available_CreateShortcut()return cur_api_level>=120 end
SET_API_LEVEL_PCALL(120,CS.WXInterface,'CreateShortcut',false,nil)


function api_Available_SetChildBoxColliderAdd()return cur_api_level>=130 end
SET_API_LEVEL_PCALL(130,CS.CSGUIWidgetBase,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUISlotItemBase,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.BagGridItem,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowBase,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListItem,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListColumn,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIItemBase,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIBaseItem,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboMainItem,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboSubItem,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua3DView,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerLua,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerGridLua,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowWithHUD,'SetChildBoxColliderAdd',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIStatusWidget,'SetChildBoxColliderAdd',false,nil)


function api_Available_SetChildSceneEntityCreateModel()return cur_api_level>=130 end
SET_API_LEVEL_PCALL(130,CS.CSGUIWidgetBase,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUISlotItemBase,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.BagGridItem,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowBase,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListItem,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListColumn,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIItemBase,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIBaseItem,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboMainItem,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboSubItem,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua3DView,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerLua,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerGridLua,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowWithHUD,'SetChildSceneEntityCreateModel',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIStatusWidget,'SetChildSceneEntityCreateModel',false,nil)


function api_Available_SetChildSceneEntityAddBoxCollider()return cur_api_level>=130 end
SET_API_LEVEL_PCALL(130,CS.CSGUIWidgetBase,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUISlotItemBase,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.BagGridItem,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowBase,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListItem,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListColumn,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIItemBase,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIBaseItem,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboMainItem,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboSubItem,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua3DView,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerLua,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerGridLua,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowWithHUD,'SetChildSceneEntityAddBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIStatusWidget,'SetChildSceneEntityAddBoxCollider',false,nil)


function api_Available_SetChildSpriteRendererSortingLayer()return cur_api_level>=130 end
SET_API_LEVEL_PCALL(130,CS.CSGUIWidgetBase,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUISlotItemBase,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.BagGridItem,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowBase,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListItem,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListColumn,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIItemBase,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIBaseItem,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboMainItem,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboSubItem,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua3DView,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerLua,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerGridLua,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowWithHUD,'SetChildSpriteRendererSortingLayer',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIStatusWidget,'SetChildSpriteRendererSortingLayer',false,nil)


function api_Available_SetChildSceneEntityAddModelBoxCollider()return cur_api_level>=130 end
SET_API_LEVEL_PCALL(130,CS.CSGUIWidgetBase,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUISlotItemBase,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.BagGridItem,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowBase,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListItem,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListColumn,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIItemBase,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIBaseItem,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboMainItem,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboSubItem,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua3DView,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerLua,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerGridLua,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowWithHUD,'SetChildSceneEntityAddModelBoxCollider',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIStatusWidget,'SetChildSceneEntityAddModelBoxCollider',false,nil)


function api_Available_SetChildBoxColliderRemove()return cur_api_level>=130 end
SET_API_LEVEL_PCALL(130,CS.CSGUIWidgetBase,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUISlotItemBase,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.BagGridItem,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowBase,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListItem,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIListColumn,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIItemBase,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIBaseItem,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboMainItem,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIComboSubItem,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowLua3DView,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerLua,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.EnhancedScrollerGridLua,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIWindowWithHUD,'SetChildBoxColliderRemove',false,nil)
SET_API_LEVEL_PCALL(130,CS.CSGUIStatusWidget,'SetChildBoxColliderRemove',false,nil)


function api_Available_SetURLVideoDownedAction()return cur_api_level>=150 end
SET_API_LEVEL_PCALL(150,CS.CSGUIWidgetBase,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUISlotItemBase,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.BagGridItem,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIWindowBase,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIListItem,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIListColumn,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIItemBase,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIBaseItem,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIComboMainItem,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIComboSubItem,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIWindowLua,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIWindowLua3DView,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.EnhancedScrollerLua,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.EnhancedScrollerGridLua,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIWindowWithHUD,'SetURLVideoDownedAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIStatusWidget,'SetURLVideoDownedAction',false,nil)


function api_Available_SetURLVideoWaitAction()return cur_api_level>=150 end
SET_API_LEVEL_PCALL(150,CS.CSGUIWidgetBase,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUISlotItemBase,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.BagGridItem,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIWindowBase,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIListItem,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIListColumn,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIItemBase,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIBaseItem,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIComboMainItem,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIComboSubItem,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIWindowLua,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIWindowLua3DView,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.EnhancedScrollerLua,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.EnhancedScrollerGridLua,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIWindowWithHUD,'SetURLVideoWaitAction',false,nil)
SET_API_LEVEL_PCALL(150,CS.CSGUIStatusWidget,'SetURLVideoWaitAction',false,nil)


function api_Available_HttpPostRequestFile()return cur_api_level>=160 end
SET_API_LEVEL_PCALL(160,CS.ResourceHelper,'HttpPostRequestFile',false,nil)


function api_Available_HttpPostRequestContent()return cur_api_level>=160 end
SET_API_LEVEL_PCALL(160,CS.ResourceHelper,'HttpPostRequestContent',false,nil)


function api_Available_StartDownloadFile()return cur_api_level>=160 end
SET_API_LEVEL_PCALL(160,CS.ResourceHelper,'StartDownloadFile',false,nil)


function api_Available_StartDownloadFileEx()return cur_api_level>=160 end
SET_API_LEVEL_PCALL(160,CS.ResourceHelper,'StartDownloadFileEx',false,nil)


function api_Available_StopDownloadFile()return cur_api_level>=160 end
SET_API_LEVEL_PCALL(160,CS.ResourceHelper,'StopDownloadFile',false,nil)


function api_Available_HttpGetRequestWithHeader()return cur_api_level>=160 end
SET_API_LEVEL_PCALL(160,CS.ResourceHelper,'HttpGetRequestWithHeader',false,nil)


function api_Available_GenDynamicAltlas()return cur_api_level>=170 end
SET_API_LEVEL_PCALL(170,CS.FightUnit.FightManager,'GenDynamicAltlas',false,nil)


function api_Available_ReleaseDynamicAltlas()return cur_api_level>=170 end
SET_API_LEVEL_PCALL(170,CS.FightUnit.FightManager,'ReleaseDynamicAltlas',false,nil)


function api_Available_SetEntityTroops()return cur_api_level>=170 end
SET_API_LEVEL_PCALL(170,CS.FightUnit.FightManager,'SetEntityTroops',false,nil)


function api_Available_SetJunZhengDeathCount()return cur_api_level>=170 end
SET_API_LEVEL_PCALL(170,CS.FightUnit.FightManager,'SetJunZhengDeathCount',false,nil)


function api_Available_GetItemWidget()return cur_api_level>=180 end
SET_API_LEVEL_PCALL(180,CS.UILoopListView,'GetItemWidget',false,nil)


function api_Available_SetChildSceneEntityPlayEffect()return cur_api_level>=190 end
SET_API_LEVEL_PCALL(190,CS.CSGUIWidgetBase,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUISlotItemBase,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.BagGridItem,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIWindowBase,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIListItem,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIListColumn,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIItemBase,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIBaseItem,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIComboMainItem,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIComboSubItem,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIWindowLua,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIWindowLua3DView,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.EnhancedScrollerLua,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.EnhancedScrollerGridLua,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIWindowWithHUD,'SetChildSceneEntityPlayEffect',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIStatusWidget,'SetChildSceneEntityPlayEffect',false,nil)


function api_Available_SimulationClickOneButton()return cur_api_level>=190 end
SET_API_LEVEL_PCALL(190,CS.GameInterface,'SimulationClickOneButton',false,nil)


function api_Available_SetChildSceneEntityPlayEffectOnActor()return cur_api_level>=190 end
SET_API_LEVEL_PCALL(190,CS.CSGUIWidgetBase,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUISlotItemBase,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.BagGridItem,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIWindowBase,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIListItem,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIListColumn,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIItemBase,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIBaseItem,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIComboMainItem,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIComboSubItem,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIWindowLua,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIWindowLua3DView,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.EnhancedScrollerLua,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.EnhancedScrollerGridLua,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIWindowWithHUD,'SetChildSceneEntityPlayEffectOnActor',false,nil)
SET_API_LEVEL_PCALL(190,CS.CSGUIStatusWidget,'SetChildSceneEntityPlayEffectOnActor',false,nil)


function api_Available_GetChildLoop3DGround()return cur_api_level>=200 end
SET_API_LEVEL_PCALL(200,CS.CSGUIWidgetBase,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUISlotItemBase,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.BagGridItem,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIWindowBase,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIListItem,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIListColumn,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIItemBase,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIBaseItem,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIComboMainItem,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIComboSubItem,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIWindowLua,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIWindowLua3DView,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.EnhancedScrollerLua,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.EnhancedScrollerGridLua,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIWindowWithHUD,'GetChildLoop3DGround',false,nil)
SET_API_LEVEL_PCALL(200,CS.CSGUIStatusWidget,'GetChildLoop3DGround',false,nil)


function api_Available_ReplaceSpine()return cur_api_level>=200 end
SET_API_LEVEL_PCALL(200,CS.GameInterface,'ReplaceSpine',false,nil)


function api_Available_ReplaceIcon()return cur_api_level>=200 end
SET_API_LEVEL_PCALL(200,CS.GameInterface,'ReplaceIcon',false,nil)


function api_Available_ReplaceSound()return cur_api_level>=200 end
SET_API_LEVEL_PCALL(200,CS.GameInterface,'ReplaceSound',false,nil)


function api_Available_ReplaceEffect()return cur_api_level>=200 end
SET_API_LEVEL_PCALL(200,CS.GameInterface,'ReplaceEffect',false,nil)


function api_Available_GetChildWebView3D()return cur_api_level>=220 end
SET_API_LEVEL_PCALL(220,CS.CSGUIWidgetBase,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUISlotItemBase,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.BagGridItem,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowBase,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIListItem,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIListColumn,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIItemBase,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIBaseItem,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIComboMainItem,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIComboSubItem,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowLua,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowLua3DView,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.EnhancedScrollerLua,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.EnhancedScrollerGridLua,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowWithHUD,'GetChildWebView3D',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIStatusWidget,'GetChildWebView3D',false,nil)


function api_Available_GetChildWebView()return cur_api_level>=220 end
SET_API_LEVEL_PCALL(220,CS.CSGUIWidgetBase,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUISlotItemBase,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.BagGridItem,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowBase,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIListItem,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIListColumn,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIItemBase,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIBaseItem,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIComboMainItem,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIComboSubItem,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowLua,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowLua3DView,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.EnhancedScrollerLua,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.EnhancedScrollerGridLua,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowWithHUD,'GetChildWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIStatusWidget,'GetChildWebView',false,nil)


function api_Available_GetChildBaseWebView()return cur_api_level>=220 end
SET_API_LEVEL_PCALL(220,CS.CSGUIWidgetBase,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUISlotItemBase,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.BagGridItem,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowBase,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIListItem,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIListColumn,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIItemBase,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIBaseItem,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIComboMainItem,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIComboSubItem,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowLua,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowLua3DView,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.EnhancedScrollerLua,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.EnhancedScrollerGridLua,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIWindowWithHUD,'GetChildBaseWebView',false,nil)
SET_API_LEVEL_PCALL(220,CS.CSGUIStatusWidget,'GetChildBaseWebView',false,nil)


function api_Available_SetCustomDynamicLight()return cur_api_level>=230 end
SET_API_LEVEL_PCALL(230,CS.Entity,'SetCustomDynamicLight',false,nil)


function api_Available_SetEffectAnimation()return cur_api_level>=230 end
SET_API_LEVEL_PCALL(230,CS.GameInterface,'SetEffectAnimation',false,nil)


function api_Available_SetChildSceneEntityFlipY()return cur_api_level>=240 end
SET_API_LEVEL_PCALL(240,CS.CSGUIWidgetBase,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUISlotItemBase,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.BagGridItem,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIWindowBase,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIListItem,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIListColumn,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIItemBase,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIBaseItem,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIComboMainItem,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIComboSubItem,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIWindowLua,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIWindowLua3DView,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.EnhancedScrollerLua,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.EnhancedScrollerGridLua,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIWindowWithHUD,'SetChildSceneEntityFlipY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIStatusWidget,'SetChildSceneEntityFlipY',false,nil)


function api_Available_SetChildSceneEntityFlipXY()return cur_api_level>=240 end
SET_API_LEVEL_PCALL(240,CS.CSGUIWidgetBase,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUISlotItemBase,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.BagGridItem,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIWindowBase,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIListItem,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIListColumn,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIItemBase,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIBaseItem,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIComboMainItem,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIComboSubItem,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIWindowLua,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIWindowLua3DView,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.EnhancedScrollerLua,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.EnhancedScrollerGridLua,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIWindowWithHUD,'SetChildSceneEntityFlipXY',false,nil)
SET_API_LEVEL_PCALL(240,CS.CSGUIStatusWidget,'SetChildSceneEntityFlipXY',false,nil)


function api_Available_SetAnimatorEventAction()return cur_api_level>=250 end
SET_API_LEVEL_PCALL(250,CS.FightUnit.FightCamera,'SetAnimatorEventAction',false,nil)


function api_Available_SetCameraFOV()return cur_api_level>=250 end
SET_API_LEVEL_PCALL(250,CS.FightUnit.FightCamera,'SetCameraFOV',false,nil)


function api_Available_StopAnimator()return cur_api_level>=250 end
SET_API_LEVEL_PCALL(250,CS.FightUnit.FightCamera,'StopAnimator',false,nil)


function api_Available_SetAnimation()return cur_api_level>=250 end
SET_API_LEVEL_PCALL(250,CS.FightUnit.FightCamera,'SetAnimation',false,nil)


function api_Available_GetChildEulerAngle()return cur_api_level>=260 end
SET_API_LEVEL_PCALL(260,CS.GameInterface,'GetChildEulerAngle',false,nil)


function api_Available_SetSoundLanguageInfo()return cur_api_level>=260 end
SET_API_LEVEL_PCALL(260,CS.GameInterface,'SetSoundLanguageInfo',false,nil)


function api_Available_GetChildRotation()return cur_api_level>=260 end
SET_API_LEVEL_PCALL(260,CS.GameInterface,'GetChildRotation',false,nil)


function api_Available_RotationEffect()return cur_api_level>=260 end
SET_API_LEVEL_PCALL(260,CS.Entity,'RotationEffect',false,nil)


function api_Available_SetChildRotationEx()return cur_api_level>=260 end
SET_API_LEVEL_PCALL(260,CS.CSGUIWidgetBase,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUISlotItemBase,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.BagGridItem,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIWindowBase,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIListItem,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIListColumn,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIItemBase,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIBaseItem,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIComboMainItem,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIComboSubItem,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIWindowLua,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIWindowLua3DView,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.EnhancedScrollerLua,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.EnhancedScrollerGridLua,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIWindowWithHUD,'SetChildRotationEx',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIStatusWidget,'SetChildRotationEx',false,nil)


function api_Available_SetChildSceneEntitySetEffectRotation()return cur_api_level>=260 end
SET_API_LEVEL_PCALL(260,CS.CSGUIWidgetBase,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUISlotItemBase,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.BagGridItem,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIWindowBase,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIListItem,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIListColumn,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIItemBase,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIBaseItem,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIComboMainItem,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIComboSubItem,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIWindowLua,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.EnhancedScrollerLua,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetEffectRotation',false,nil)
SET_API_LEVEL_PCALL(260,CS.CSGUIStatusWidget,'SetChildSceneEntitySetEffectRotation',false,nil)


function api_Available_SetJunZhengLiveProgress()return cur_api_level>=260 end
SET_API_LEVEL_PCALL(260,CS.FightUnit.FightManager,'SetJunZhengLiveProgress',false,nil)


function api_Available_GetJunZhengSize()return cur_api_level>=260 end
SET_API_LEVEL_PCALL(260,CS.FightUnit.FightManager,'GetJunZhengSize',false,nil)


function api_Available_SetChildTroopProgress()return cur_api_level>=270 end
SET_API_LEVEL_PCALL(270,CS.CSGUIWidgetBase,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUISlotItemBase,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.BagGridItem,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIWindowBase,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIListItem,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIListColumn,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIItemBase,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIBaseItem,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIComboMainItem,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIComboSubItem,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIWindowLua,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIWindowLua3DView,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.EnhancedScrollerLua,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.EnhancedScrollerGridLua,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIWindowWithHUD,'SetChildTroopProgress',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIStatusWidget,'SetChildTroopProgress',false,nil)


function api_Available_SetChildTroop()return cur_api_level>=270 end
SET_API_LEVEL_PCALL(270,CS.CSGUIWidgetBase,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUISlotItemBase,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.BagGridItem,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIWindowBase,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIListItem,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIListColumn,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIItemBase,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIBaseItem,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIComboMainItem,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIComboSubItem,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIWindowLua,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIWindowLua3DView,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.EnhancedScrollerLua,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.EnhancedScrollerGridLua,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIWindowWithHUD,'SetChildTroop',false,nil)
SET_API_LEVEL_PCALL(270,CS.CSGUIStatusWidget,'SetChildTroop',false,nil)


function api_Available_SetBeautifyTone()return cur_api_level>=280 end
SET_API_LEVEL_PCALL(280,CS.GameInterface,'SetBeautifyTone',false,nil)


function api_Available_SetChildDragZoomTwoFingerMoveFlag()return cur_api_level>=290 end
SET_API_LEVEL_PCALL(290,CS.CSGUIWidgetBase,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUISlotItemBase,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.BagGridItem,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIWindowBase,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIListItem,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIListColumn,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIItemBase,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIBaseItem,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIComboMainItem,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIComboSubItem,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIWindowLua,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIWindowLua3DView,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.EnhancedScrollerLua,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.EnhancedScrollerGridLua,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIWindowWithHUD,'SetChildDragZoomTwoFingerMoveFlag',false,nil)
SET_API_LEVEL_PCALL(290,CS.CSGUIStatusWidget,'SetChildDragZoomTwoFingerMoveFlag',false,nil)


function api_Available_SetAutoRotate()return cur_api_level>=291 end
SET_API_LEVEL_PCALL(291,CS.CSGUILoop3DGround,'SetAutoRotate',false,nil)


function api_Available_GetFileCacheMode()return cur_api_level>=291 end
SET_API_LEVEL_PCALL(291,CS.WXInterface,'GetFileCacheMode',false,nil)


function api_Available_SetErrLogCallback()return cur_api_level>=300 end
SET_API_LEVEL_PCALL(300,CS.GameInterface,'SetErrLogCallback',false,nil)


function api_Available_WriteLogContentToFile()return cur_api_level>=300 end
SET_API_LEVEL_PCALL(300,CS.GameInterface,'WriteLogContentToFile',false,nil)


function api_Available_SetFileWriteErrorHandleFunction()return cur_api_level>=310 end
SET_API_LEVEL_PCALL(310,CS.WXInterface,'SetFileWriteErrorHandleFunction',false,nil)


function api_Available_InitPhysics()return cur_api_level>=320 end
SET_API_LEVEL_PCALL(320,CS.GameInterface,'InitPhysics',false,nil)


function api_Available_AddMapEx()return cur_api_level>=340 end
SET_API_LEVEL_PCALL(340,CS.MapManagerInterface,'AddMapEx',false,nil)


function api_Available_SetTextLineSpacing()return cur_api_level>=350 end
SET_API_LEVEL_PCALL(350,CS.CSGUIWidgetBase,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUISlotItemBase,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.BagGridItem,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIWindowBase,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIListItem,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIListColumn,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIItemBase,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIBaseItem,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIComboMainItem,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIComboSubItem,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIWindowLua,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIWindowLua3DView,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.EnhancedScrollerLua,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.EnhancedScrollerGridLua,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIWindowWithHUD,'SetTextLineSpacing',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIStatusWidget,'SetTextLineSpacing',false,nil)


function api_Available_SetChildOutlineColor()return cur_api_level>=350 end
SET_API_LEVEL_PCALL(350,CS.CSGUIWidgetBase,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUISlotItemBase,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.BagGridItem,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIWindowBase,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIListItem,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIListColumn,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIItemBase,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIBaseItem,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIComboMainItem,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIComboSubItem,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIWindowLua,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIWindowLua3DView,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.EnhancedScrollerLua,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.EnhancedScrollerGridLua,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIWindowWithHUD,'SetChildOutlineColor',false,nil)
SET_API_LEVEL_PCALL(350,CS.CSGUIStatusWidget,'SetChildOutlineColor',false,nil)


function api_Available_SetChildSceneEntitySetShaderRenderQueue()return cur_api_level>=352 end
SET_API_LEVEL_PCALL(352,CS.CSGUIWidgetBase,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUISlotItemBase,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.BagGridItem,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIWindowBase,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIListItem,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIListColumn,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIItemBase,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIBaseItem,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIComboMainItem,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIComboSubItem,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIWindowLua,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIWindowLua3DView,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.EnhancedScrollerLua,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.EnhancedScrollerGridLua,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIWindowWithHUD,'SetChildSceneEntitySetShaderRenderQueue',false,nil)
SET_API_LEVEL_PCALL(352,CS.CSGUIStatusWidget,'SetChildSceneEntitySetShaderRenderQueue',false,nil)


function api_Available_SetSingeFrameSpineDisableRefresh()return cur_api_level>=370 end
SET_API_LEVEL_PCALL(370,CS.GameInterface,'SetSingeFrameSpineDisableRefresh',false,nil)


function api_Available_SetChildButtonPointExitEvent()return cur_api_level>=380 end
SET_API_LEVEL_PCALL(380,CS.CSGUIWidgetBase,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUISlotItemBase,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.BagGridItem,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIWindowBase,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIListItem,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIListColumn,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIItemBase,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIBaseItem,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIComboMainItem,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIComboSubItem,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIWindowLua,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIWindowLua3DView,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.EnhancedScrollerLua,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.EnhancedScrollerGridLua,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIWindowWithHUD,'SetChildButtonPointExitEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIStatusWidget,'SetChildButtonPointExitEvent',false,nil)


function api_Available_SetChildButtonPointEnterEvent()return cur_api_level>=380 end
SET_API_LEVEL_PCALL(380,CS.CSGUIWidgetBase,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUISlotItemBase,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.BagGridItem,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIWindowBase,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIListItem,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIListColumn,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIItemBase,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIBaseItem,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIComboMainItem,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIComboSubItem,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIWindowLua,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIWindowLua3DView,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.EnhancedScrollerLua,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.EnhancedScrollerGridLua,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIWindowWithHUD,'SetChildButtonPointEnterEvent',false,nil)
SET_API_LEVEL_PCALL(380,CS.CSGUIStatusWidget,'SetChildButtonPointEnterEvent',false,nil)


function api_Available_StopAllEffect()return cur_api_level>=430 end
SET_API_LEVEL_PCALL(430,CS.GameInterface,'StopAllEffect',false,nil)


function api_Available_GetAllEntity()return cur_api_level>=430 end
SET_API_LEVEL_PCALL(430,CS.GameInterface,'GetAllEntity',false,nil)


function api_Available_InitShowFinalFantasy()return cur_api_level>=432 end
SET_API_LEVEL_PCALL(432,CS.GameInterface,'InitShowFinalFantasy',false,nil)


function api_Available_SetChildInputLineType()return cur_api_level>=433 end
SET_API_LEVEL_PCALL(433,CS.CSGUIWidgetBase,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUISlotItemBase,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.BagGridItem,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIWindowBase,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIListItem,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIListColumn,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIItemBase,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIBaseItem,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIComboMainItem,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIComboSubItem,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIWindowLua,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIWindowLua3DView,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.EnhancedScrollerLua,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.EnhancedScrollerGridLua,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIWindowWithHUD,'SetChildInputLineType',false,nil)
SET_API_LEVEL_PCALL(433,CS.CSGUIStatusWidget,'SetChildInputLineType',false,nil)



