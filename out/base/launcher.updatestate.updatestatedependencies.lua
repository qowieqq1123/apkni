local _SetDependencies=CS.ResourceHelper.AssetBundleCacheManager_SetDependencies
local _MarkAssetBundleStatic=CS.ResourceHelper.AssetbundleProperty_MarkAssetBundleStatic
function updateState.setDependencies()
local dep0={
'ui/fonts/dsffont.ab',
"updatesystem/ui/sprites_pak.ab",
'character/spinelib/ui/ui_jingdutiao_skeletondata.ab',

}
_SetDependencies('updatesystem/ui/uiupdatewindow.ab',dep0)

local dep1={
'ui/fonts/dsffont.ab',
"updatesystem/ui/sprites_pak.ab",
}

_SetDependencies('updatesystem/ui/uiupdatedialog.ab',dep1)
_MarkAssetBundleStatic('ui/fonts/dsffont.ab')
end
