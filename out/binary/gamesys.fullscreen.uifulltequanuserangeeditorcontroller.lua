
UIFullTeQuanUseRangeEditorController=gameState.addListener(fullScreenUI.create())

function UIFullTeQuanUseRangeEditorController:onAppStart()

local args=
{
skinType=fullScreenSkinType.eSkin27,
fullType=FULL_TYPE.eTeQuanRangeUseEditor,
}
self:initUI(args)
end

function UIFullTeQuanUseRangeEditorController:onLeaveState()
self.enterEditor=nil
end

function UIFullTeQuanUseRangeEditorController:showMainWindow(argstable)
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIXianGuanTeQuanUseRangeEditorWin'},
viewArgs={['UIXianGuanTeQuanUseRangeEditorWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullTeQuanUseRangeEditorController:enterQuanXianEditor(argstable)
if self.enterEditor then return false end
self.enterEditor=true
local xgid=argstable.xgid
local tqid=argstable.tqid
local entityId=argstable.entityId
local leftOffset,rightOffset,bottomOffset,topOffset=UIFullTeQuanUseRangeEditorController:getTeQuanRange(argstable)
xianjieController:addEntityHalo(entityId,XIANJIE_HALO_TYPE.eTeQuanEditor,leftOffset,rightOffset,bottomOffset,topOffset,argstable,'refreshHaloRange')

local func=function()
UIFullTeQuanUseRangeEditorController:showMainWindow(argstable)
end
local actorid=playerModel:getActorID()
local zmData=xianjieModel:getZongMenData(actorid)
local gridX_c,gridZ_c=xianjieModel:getZongMenWorldGridCenterPos(zmData)
local lookpos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c)
xianjieController:lookAtPositionChangeHeight(lookpos,25,0.2,func,DG.Tweening.Ease.Linear)
return true
end

function UIFullTeQuanUseRangeEditorController:exitQuanXianEditor()
UIFullTeQuanUseRangeEditorController:closeUI()
end

function UIFullTeQuanUseRangeEditorController:onExitQuanXianEditor(argstable)
if self.enterEditor then
self.enterEditor=nil
local entityId=argstable.entityId
xianjieController:removeEntityHalo(entityId,XIANJIE_HALO_TYPE.eTeQuanEditor)
end
end

function UIFullTeQuanUseRangeEditorController:isInEditor()
return self.enterEditor==true
end

function UIFullTeQuanUseRangeEditorController:useTeQuan(xgid,tqid,exargs)
local args
if exargs then
local jsonStr=jsonHelper.encode(exargs)
args={}
args.exInfoJsonStr=jsonStr
end
return xianguanModel:callTeQuanObjFunc(xgid,tqid,'use',args)
end


local _tqfunc=
{
[XIANGUAN_PRIVILEGE_ENUM.eTqType_18]=
{
range=function(argtable)
local effectArgs=cfg_xianguanprivilegeconfig_get(XIANGUAN_PRIVILEGE_ENUM.eTqType_18).effectArgs
return effectArgs[2],effectArgs[3],effectArgs[4],effectArgs[5]
end,
onUse=function(argtable)
local entityId=argtable.entityId
local xjdata=xianjieController:getXJClass(entityId)
if xjdata then
local entity=xjdata:getMyEntity()
if entity then
entity:playTeQuanEditorEffect(20642)
end
end
end,
onEmis=function(argtable)
local entityId=argtable.entityId

local entitylist=xianjieController:getHaloEntitysByHaloType(entityId,XIANJIE_HALO_TYPE.eTeQuanEditor)
for i,v in ipairs(entitylist)do
local xjdata=xianjieController:getXJClass(v)
if xjdata then
local entity=xjdata:getMyEntity()
if entity then
entity:playTeQuanEditorEffect(20643)
end
end
end

local xjdata=xianjieController:getXJClass(entityId)
if xjdata then
local entity=xjdata:getMyEntity()
if entity then
entity:playTeQuanEditorEffect(20643)
end
end
local tqid=argtable.tqid
local showTips=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'showTips')
if showTips then
UIManager.info(showTips)
end
end,
},
[XIANGUAN_PRIVILEGE_ENUM.eXianGuanCiFu]=
{
range=function(argtable)
local effectArgs=cfg_xianguanprivilegeconfig_get(XIANGUAN_PRIVILEGE_ENUM.eXianGuanCiFu).effectArgs
return effectArgs[3],effectArgs[4],effectArgs[5],effectArgs[6]
end,
onUse=function(argtable)
local entityId=argtable.entityId
local xjdata=xianjieController:getXJClass(entityId)
if xjdata then
local entity=xjdata:getMyEntity()
if entity then
entity:playTeQuanEditorEffect(22643)
end
end
end,
onEmis=function(argtable)
local entityId=argtable.entityId

local entitylist=xianjieController:getHaloEntitysByHaloType(entityId,XIANJIE_HALO_TYPE.eTeQuanEditor)
for i,v in ipairs(entitylist)do
local xjdata=xianjieController:getXJClass(v)
if xjdata then
local entity=xjdata:getMyEntity()
if entity then
entity:playTeQuanEditorEffect(22642)
end
end
end
local tqid=argtable.tqid
local showTips=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'showTips')
if showTips then
UIManager.info(showTips)
end
end,
emisDelay=0.5,
editorDelay=3,
}
}

function UIFullTeQuanUseRangeEditorController:getTeQuanCfg(tqid)
return _tqfunc[tqid]
end

function UIFullTeQuanUseRangeEditorController:getTeQuanEmisDelay(tqid)
local cfg=self:getTeQuanCfg(tqid)
return cfg.emisDelay or 2
end

function UIFullTeQuanUseRangeEditorController:getTeQuanEditorDelay(tqid)
local cfg=self:getTeQuanCfg(tqid)
return cfg.editorDelay or 2
end

function UIFullTeQuanUseRangeEditorController:getTeQuanEmisRangeEffect(tqid)
local cfg=self:getTeQuanCfg(tqid)
return cfg.rangeEffect or 22625
end

function UIFullTeQuanUseRangeEditorController:getTeQuanRange(argtable)
local tqid=argtable.tqid
local cfg=self:getTeQuanCfg(tqid)
return cfg.range(argtable)
end



function UIFullTeQuanUseRangeEditorController:onUse(argtable)
local tqid=argtable.tqid
local cfg=self:getTeQuanCfg(tqid)
cfg.onUse(argtable)
end



function UIFullTeQuanUseRangeEditorController:onEmis(argtable)
local tqid=argtable.tqid
local cfg=self:getTeQuanCfg(tqid)
cfg.onEmis(argtable)
end
