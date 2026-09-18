




UIFullYanDaoTaiControl=gameState.addListener(fullScreenUI.create())

function UIFullYanDaoTaiControl:onAppStart()
self.isShowEnum=false
self.isOpenEnum=false
local _showChuanChengWindow=function(...)
self:showChuanChengWindow(...)
end
local _showDaoZangWindow=function(...)
self:showDaoZangWindow(...)
end

local _checkOpeMenu=function(...)
local treeId=yandaotaiModel:getTreeIdByTypeAndTabIdx(YDT_TREE_TYPE.eDaoZang,1)
local isShow=yandaotaiModel:getIsShowTree(treeId)
return isShow
end

local menulist=
{

{tabType=FULL_TAB_TYPE.eYanDaoTai,callback=_showChuanChengWindow,checkOpen=_checkOpeMenu,reddotType=REDDIT_SUB_TYPE.sYanDaoTaiCC},

{tabType=FULL_TAB_TYPE.eYanDaoTai_dz,callback=_showDaoZangWindow,checkOpen=_checkOpeMenu,reddotType=REDDIT_SUB_TYPE.sYanDaoTaiDZ},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eYanDaoTai,
skinType=fullScreenSkinType.eSkin24,
attachName={'entityId'},
}
self:initUI(args)
end

function UIFullYanDaoTaiControl:refreshMainMenu()
local treeId=yandaotaiModel:getTreeIdByTypeAndTabIdx(YDT_TREE_TYPE.eDaoZang,1)
local isShow=yandaotaiModel:getIsShowTree(treeId)
local isOpen=yandaotaiModel:getIsOpenTree(treeId)
if self.isShowEnum~=isShow then
self.isShowEnum=isShow
local win=UIManager:findActiveWindow("UIYanDaoTaiWin")
if win then
self:refreshMenu()
end
end
if self.isOpenEnum~=isOpen then
self.isOpenEnum=isOpen
local win=UIManager:findActiveWindow("UIXianJieBottomMaskWin")
if win then
win:freshMenuList()
end
end
end


function UIFullYanDaoTaiControl:showMainWindow(argstable)
local flag,state,icon,id=yandaotaiController:checkLevelUpFinish()

if flag and state==1 and id then
yandaotaiController.send_6_178(1,{id})
local entityId=argstable.entityId
buildingEffectControl:playEffectByEID(entityId,SLG_SYSTEM_TYPE.eYanDaoTai,buildEffectType.eYanDaoTai)
else
argstable=argstable or{}
local treeId
local studyList=yandaotaiModel:getStudyList()
if studyList and studyList.id and studyList.starTime then
treeId=yandaotaiModel:getTechnologyTreeId(studyList.id)
else
treeId=yandaotaiModel:getYanDaoTaiSaveTreeId()
end
if treeId and yandaotaiModel:getIsOpenTree(treeId)then
local cfg=cfgHelper.get1(cfg_technologytreeconfig_get,treeId)
argstable.treeType=cfg.type
else
argstable.treeType=YDT_TREE_TYPE.eChuanCheng
end

if argstable.treeType==YDT_TREE_TYPE.eChuanCheng then
self:showChuanChengWindow(argstable)
elseif argstable.treeType==YDT_TREE_TYPE.eDaoZang then
self:showDaoZangWindow(argstable)
else
self:showChuanChengWindow(argstable)
end
return true
end
end


function UIFullYanDaoTaiControl:showChuanChengWindow(argstable)
argstable=argstable or{}
argstable.treeType=YDT_TREE_TYPE.eChuanCheng
local tabType=FULL_TAB_TYPE.eYanDaoTai
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIYanDaoTaiWin'},
viewArgs={['UIYanDaoTaiWin']=argstable},
}

self:showUI(args)
return true
end


function UIFullYanDaoTaiControl:showDaoZangWindow(argstable)
argstable=argstable or{}
argstable.treeType=YDT_TREE_TYPE.eDaoZang
local tabType=FULL_TAB_TYPE.eYanDaoTai_dz
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIYanDaoTaiDaoZangWin'},
viewArgs={['UIYanDaoTaiDaoZangWin']=argstable},
}

self:showUI(args)
return true
end