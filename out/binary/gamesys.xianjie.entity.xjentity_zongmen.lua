









local xjEntity_zongmen={}

local _buffRoot={
13,
}
local invisibleRangeEffectId=20639


function xjEntity_zongmen:onInit()
local data=self.data
self.actorid=data[1]
self.ismy=data[2]
self:initData()

self.ent_name=data[3]
self.canSelect=true
self.allowClickGrid=true
self.showAlphaValue=1

self.isPlayEffect=false
self.isHideModel=false

local enemyType=xianjieModel:checkEnemyType2(self.actorid,self.zmData.ownersceneidx)
if enemyType==xjEnemyType.eSelf then
self.xjicontype=401
elseif enemyType==xjEnemyType.eAllies then
self.xjicontype=402
elseif enemyType==xjEnemyType.eEnemy then
self.xjicontype=403
elseif enemyType==xjEnemyType.eStranger then
self.xjicontype=404
end
end

function xjEntity_zongmen:initData()
local zmData=self:getZMData()
self.zmData=zmData
self.pos=zmData:getWorldPos_1()
self.size=zmData:getWorldSize()
end

function xjEntity_zongmen:getZMData()
local zmData
if self.ismy then
zmData=xianjieModel:getMyZongMenData()
else
zmData=xianjieModel:getZongMenData(self.actorid)
end
return zmData
end

function xjEntity_zongmen:setIsPlayEffect(flag)
self.isPlayEffect=flag
end

function xjEntity_zongmen:getIsPlayEffect()
return self.isPlayEffect or false
end

function xjEntity_zongmen:playEffect()
if not self.ismy then return end

self:playMoveEffect()
end

function xjEntity_zongmen:playOtherMoveEffect(afterHideCall)
local hud=self:getHud()
local hudWidget
if hud then hudWidget=hud:getWidget()end
if hudWidget then hudWidget:SetChildActive(-1,false)end

local widget=self:getWidget()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")

if widget then
self:onSelectHandle(widget,false)

widget:SetChildActive(-1,true)

widget:SetChildActive(0,true)
widget:SetChildShowEffectEx(5,22640,sortingLayer,entCfg.sortOrder-1,true)
widget:SetChildSceneEntityPlayAnimation(0,3080,1)
widget:SetChildActive(3,false)

self.isPlayOtherMoveEffect=true
local sequenceProxy=Lua.SequenceProxy.New()
sequenceProxy:AppendInterval(3)

sequenceProxy:AppendCallback(function()
widget:SetChildActive(3,true)
self.isPlayOtherMoveEffect=nil
widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.stand,1)
widget:SetChildSceneEntityRemoveModel(8)
widget:SetChildSceneEntityRemoveModel(9)
local hud=self:getHud()
local hudWidget
if hud then hudWidget=hud:getWidget()end
if hudWidget then hudWidget:SetChildActive(-1,true)end

self.isPlayEffect=false
if self.isHideModel then
widget:SetChildActive(0,false)
end
if afterHideCall then
afterHideCall()
end
end)

end
end

function xjEntity_zongmen:stopOtherMoveEffect(widget)
if not self.isPlayOtherMoveEffect then return end
if widget==nil then return end
self.isPlayOtherMoveEffect=nil
widget:SetChildSceneEntityRemoveModel(8)
widget:SetChildSceneEntityRemoveModel(9)
end


function xjEntity_zongmen:initHaloRange()
local zmData=self.zmData
local haloType=XIANJIE_HALO_TYPE.eTeQuanEditor
if zmData.haloLookup[haloType]then
self:enterHaloRangeEditor(haloType)
end
end


function xjEntity_zongmen:enterHaloRange(haloType)
if haloType==XIANJIE_HALO_TYPE.eTeQuanEditor then
self:enterHaloRangeEditor(haloType)
end
end


function xjEntity_zongmen:exitHaloRange(haloType)
if haloType==XIANJIE_HALO_TYPE.eTeQuanEditor then
self:exitHaloRangeEditor(haloType)
end
end


function xjEntity_zongmen:enterHaloRangeEditor(haloType)
local widget=self:getWidget()
if widget==nil then return end
if self.enterEditor then return end
self.enterEditor=true

local zmData=self.zmData
local entityid=zmData.haloLookup[haloType]
local isSelf=entityid==zmData:getID()
local haloArgs=zmData.haloInfo[haloType]
local tqid=haloArgs.tqid
local xgid=haloArgs.xgid
if isSelf then
local effectId=UIFullTeQuanUseRangeEditorController:getTeQuanEmisRangeEffect(tqid)
self:playTeQuanEditorRangeEffect(effectId)
end
self:pauseAllEffects(widget)
self:refreshTeQuanEditorHUD()
end


function xjEntity_zongmen:exitHaloRangeEditor(haloType)
if not self.enterEditor then return end
self.enterEditor=nil

local zmData=self.zmData
local haloArgs=zmData.haloInfo[haloType]
local tqid=haloArgs.tqid
local xgid=haloArgs.xgid

local widget=self:getWidget()
self:resumeAllEffects(widget)
self:refreshTeQuanEditorHUD()
widget:SetChildShowEffect(14,0,false)
end

function xjEntity_zongmen:refreshTeQuanEditorHUD()
local hud=self:getHud()
if hud then
hud:refreshTeQuanEditorHUD()
end
end

function xjEntity_zongmen:playTeQuanEditorRangeEffect(effectId)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
local widget=self:getWidget()
widget:SetChildShowEffectEx(14,effectId,sortingLayer,entCfg.sortOrder-2,true)
end

function xjEntity_zongmen:playTeQuanEditorEffect(effectId,order)
order=order or 1
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
local widget=self:getWidget()
widget:SetChildShowEffectEx(15,effectId,sortingLayer,entCfg.sortOrder+order,true)
end












function xjEntity_zongmen:playMoveEffect()
local hud=self:getHud()
local hudWidget
if hud then hudWidget=hud:getWidget()end
if hudWidget then hudWidget:SetChildActive(-1,false)end

local widget=self:getWidget()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")

self:pauseMoveEffect(widget)

if widget then
widget:SetChildActive(0,true)
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0,nil)
widget:SetChildActive(-1,true)
local movelEffectId=xianjieModel:getZongMenMovePlayEffectId()
widget:SetChildShowEffectEx(5,movelEffectId,sortingLayer,entCfg.sortOrder-1,true)
local alphaValue=self.showAlphaValue or 1
widget:SetChildDOScale(0,1,1.4,function()

widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,alphaValue),1,function()
local hud=self:getHud()
local hudWidget
if hud then hudWidget=hud:getWidget()end
if hudWidget then hudWidget:SetChildActive(-1,true)end
UIManager.info('堡垒移动成功')
self.isPlayEffect=false
if self.isHideModel then
widget:SetChildActive(0,false)
end
xianjieModel:checkShowFreeTimesofXianGuanPrivilegeTips()

self:resumeMoveEffect(widget)
end)
end)
end
end


function xjEntity_zongmen:pauseMoveEffect(widget)
if self.enterEditor then return end
if self.enterMove then return end
self.enterMove=true
widget=widget or self:getWidget()
self:pauseAllEffects(widget)
end

function xjEntity_zongmen:resumeMoveEffect(widget)
if self.enterEditor then return end
if not self.enterMove then return end
self.enterMove=nil
widget=widget or self:getWidget()
self:resumeAllEffects(widget)
end


function xjEntity_zongmen:pauseAllEffects(widget)
if self.isShieldEffect then return end
self.isShieldEffect=true


local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(10,0,sortingLayer,entCfg.sortOrder-1,false)

self:pauseFangHuZhaoEffect(widget)
self:pauseDisableFangHuZhaoEffect(widget)
self:pauseTianShuShenDunEffect(widget)
self:pauseZaieBuQinEffect(widget)
self:pauseBanMoveZongMenBuffEffect(widget)
self:pauseMoJunAreaEffect(widget)

end


function xjEntity_zongmen:resumeAllEffects(widget)

if not self.isShieldEffect then return end
self.isShieldEffect=false



local isShowRangeEffect=self.isShowInvisibleRangeGrids
if isShowRangeEffect then
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
local effectId=invisibleRangeEffectId
widget:SetChildShowEffectEx(10,effectId,sortingLayer,entCfg.sortOrder-1,true)
end

self:resumeFangHuZhaoEffect(widget)
self:resumeDisableFangHuZhaoEffect(widget)
self:resumeTianShuShenDunEffect(widget)
self:resumeZaieBuQinEffect(widget)
self:resumeBanMoveZongMenBuffEffect(widget)
self:resumeMoJunAreaEffect(widget)
end


function xjEntity_zongmen:refreshPos()
self:initData()
xianjieController:resetEntityPos(self:getKey(),self.pos)

local hud=self:getHud()
local hudWidget
if hud then hudWidget=hud:getWidget()end
if hudWidget then
hudWidget:SetChildDOScale(0,1,0.5,function()
self:invokeEntityHudFunc('refreshJobBuff',hudWidget)
end)
end
end


function xjEntity_zongmen:refreshInfo()
self:refreshPos()
self:changeModel()
end


function xjEntity_zongmen:onSelectHandle(widget,isSelect)
if not widget then
self.selectEffect=nil
return
end
if isSelect then

local isInvisible=xianjieModel:isZmInvisible(self.actorid)
if isInvisible then

local enemyType=xianjieModel:checkEnemyType2(self.actorid,self.zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if not isFriend then

return
end
end

if self.selectEffect==nil then
local modelset=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'modelSet_zm')
local effect=modelset.selectEffect
if effect then
self.selectEffect=effect[1]
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(1,self.selectEffect,sortingLayer,entCfg.sortOrder-1,true)
local pos=effect[2]
widget:SetChildLocalPosition(1,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[3]
widget:SetChildScale(1,Vector3(scale,scale,scale))
end
end
else
if self.selectEffect then
self.selectEffect=nil
widget:SetChildShowEffect(1,0,false)
end
end
end


function xjEntity_zongmen:onCreateWidget(widget)
self.buffList={}
self:changeModel(widget,true)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)

self:onCreateByExtraData()

if self.isHideModel then
widget:SetChildActive(0,false)
end
if self.isPlayEffect and self.ismy then
widget:SetChildActive(-1,false)
self:playEffect()
else
self.isPlayEffect=false


local isShowRangeEffect=self.isShowInvisibleRangeGrids
if isShowRangeEffect then
local sortingLayer=helper.getSortingLayerID("Entity")
local effectId=invisibleRangeEffectId
widget:SetChildShowEffectEx(10,effectId,sortingLayer,entCfg.sortOrder-1,true)
end
end


self:checkShowInvisibleRangeGrids(widget)

local effType=xianjieController:getZMMoJunAreaEffect(self.actorid)
if effType~=nil then
self:playMoJunAreaEffect(widget,effType)
end


self:initHaloRange(widget)
end

function xjEntity_zongmen:onCreateByExtraData()
local zmData=self.zmData
xianjieModel:handleBuffList_OnCreate(zmData)
xianjieModel:createEntityBuff(zmData)
end


function xjEntity_zongmen:onRemoveWidget(widget)
if self.buffList then
for i,v in pairs(self.buffList)do
_InstantiateManager.RemoveInstance(v)
end
self.buffList=nil
end

self.isPlayEffect=false
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(5,0,sortingLayer,entCfg.sortOrder-1,false)
widget:SetChildShowEffectEx(10,0,sortingLayer,entCfg.sortOrder-1,false)

widget:SetChildActive(0,true)
widget:SetChildSceneEntityRemoveModel(0)
self.curModel=nil
self:stopFangHuZhaoEffect(widget,true)
self:stopDisableFangHuZhaoEffect(widget)
self:stopOtherMoveEffect(widget)
self:stopBanMoveZongMenBuffEffect(widget)
self.isShieldEffect=nil
self.enterEditor=nil
self.enterMove=nil
self:stopInvisibleEffect(widget,nil,true)
self:stopSkillPengLaiEffect(widget)
self:stopSLSkillBuffIcon(widget)
self:stopSkillJiuYuanEffect(widget)
self:stopMoJunAreaEffect(widget)
self.isHideModel=nil
self:setInvisibleRangeGridsShow(nil,false)
self:stopTianShuShenDunEffect(widget,true)
self:stopZaieBuQinEffect(widget,true)
end

function xjEntity_zongmen:onEnterPool()
self.curModel=nil
end

function xjEntity_zongmen:isCanPlayEffect()
return not UIFullTeQuanUseRangeEditorController:isInEditor()and
not self.isShieldEffect
end


function xjEntity_zongmen:onMyClick(boxParams)
local isMy=self.ismy
local actorId
if not isMy then
actorId=self.actorid
end
xianjieController:openZmInfoWin(isMy,actorId)
end



function xjEntity_zongmen:playTianShuShenDunEffect()
if not self:isCanPlayEffect()then return end
if self.showtssd then return end
if self.pausetssd then return end
local widget=self:getWidget()
if widget==nil then return end
self:stopFangHuZhaoEffect(widget)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
if self:playSpriteAnimation(widget,3,'xj_ts_sprite',Vector3.New(0,3.2,0),Vector3.New(3.3,3.3,3.3),'Entity',entCfg.sortOrder+1)then
self.showtssd=true
end
end

function xjEntity_zongmen:stopTianShuShenDunEffect(widget,removeEntity)
if not self.showtssd then return end
widget=widget or self:getWidget()
self:stopSpriteAnimation(widget,3)
self.showtssd=nil
self.pausetssd=nil
if not removeEntity then
self:playFangHuZhaoEffect()
end
end

function xjEntity_zongmen:pauseTianShuShenDunEffect(widget)
if not self.showtssd then return end
if self.pausetssd then return end
self.pausetssd=true
self:stopSpriteAnimation(widget,3)
end

function xjEntity_zongmen:resumeTianShuShenDunEffect(widget)
if not self:isCanPlayEffect()then return end
if not self.showtssd then return end
if not self.pausetssd then return end
self.pausetssd=nil
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
self:playSpriteAnimation(widget,3,'xj_ts_sprite',Vector3.New(0,3.2,0),Vector3.New(3.3,3.3,3.3),'Entity',entCfg.sortOrder+1)
end


function xjEntity_zongmen:playZaieBuQinEffect()
if not self:isCanPlayEffect()then return end
if self.showtzqbq then return end
if self.pausezqbq then return end
local widget=self:getWidget()
if widget==nil then return end
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
if self:playSpriteAnimation(widget,3,'xj_ts_sprite',Vector3.New(0,3.2,0),Vector3.New(3.3,3.3,3.3),'Entity',entCfg.sortOrder+1)then
self.showtzqbq=true
end
end

function xjEntity_zongmen:stopZaieBuQinEffect(widget,removeEntity)
if not self.showtzqbq then return end
widget=widget or self:getWidget()
self:stopSpriteAnimation(widget,3)
self.showtzqbq=nil
self.pausezqbq=nil
end

function xjEntity_zongmen:pauseZaieBuQinEffect(widget)
if not self.showtzqbq then return end
if self.pausezqbq then return end
self.pausezqbq=true
self:stopSpriteAnimation(widget,3)
end

function xjEntity_zongmen:resumeZaieBuQinEffect(widget)
if not self:isCanPlayEffect()then return end
if not self.showtzqbq then return end
if not self.pausezqbq then return end
self.pausezqbq=nil
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
self:playSpriteAnimation(widget,3,'xj_ts_sprite',Vector3.New(0,3.2,0),Vector3.New(3.3,3.3,3.3),'Entity',entCfg.sortOrder+1)
end


function xjEntity_zongmen:playFangHuZhaoEffect()
if not self:isCanPlayEffect()then return end
if self.showtssd then return end
if self.showfhz then return end
if self.pausefhz then return end
local widget=self:getWidget()
if widget==nil then return end
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
if self:playSpriteAnimation(widget,3,'xj_ts_sprite',Vector3.New(0,3.2,0),Vector3.New(3.3,3.3,3.3),'Entity',entCfg.sortOrder+1)then
self.showfhz=true
end
end

function xjEntity_zongmen:stopFangHuZhaoEffect(widget,removeEntity)
if not self.showfhz then return end
widget=widget or self:getWidget()
self:stopSpriteAnimation(widget,3)
self.showfhz=nil
self.pausefhz=nil
end

function xjEntity_zongmen:pauseFangHuZhaoEffect(widget)
if not self.showfhz then return end
if self.pausefhz then return end
self.pausefhz=true
self:stopSpriteAnimation(widget,3)
end

function xjEntity_zongmen:resumeFangHuZhaoEffect(widget)
if not self:isCanPlayEffect()then return end
if not self.showfhz then return end
if not self.pausefhz then return end
self.pausefhz=nil
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
self:playSpriteAnimation(widget,3,'xj_ts_sprite',Vector3.New(0,3.2,0),Vector3.New(3.3,3.3,3.3),'Entity',entCfg.sortOrder+1)
end



function xjEntity_zongmen:playDisableFangHuZhaoEffect()
if not self:isCanPlayEffect()then return end
if self.showdfhz then return end
if self.pausedfhz then return end
local widget=self:getWidget()
if widget==nil then return end
self.showdfhz=true
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(6,772128,{},'Entity',entCfg.sortOrder-1,1,nil,false)
widget:SetChildSceneEntityCreateModel(7,772127,{},'Entity',entCfg.sortOrder+1,1,nil,false)
end

function xjEntity_zongmen:stopDisableFangHuZhaoEffect(widget)
if not self.showdfhz then return end
widget=widget or self:getWidget()
widget:SetChildSceneEntityRemoveModel(6)
widget:SetChildSceneEntityRemoveModel(7)
self.showdfhz=nil
self.pausedfhz=nil
end

function xjEntity_zongmen:pauseDisableFangHuZhaoEffect(widget)
if not self.showdfhz then return end
if self.pausedfhz then return end
self.pausedfhz=true
widget:SetChildSceneEntityRemoveModel(6)
widget:SetChildSceneEntityRemoveModel(7)
end

function xjEntity_zongmen:resumeDisableFangHuZhaoEffect(widget)
if not self:isCanPlayEffect()then return end
if not self.showdfhz then return end
if not self.pausedfhz then return end
self.pausedfhz=nil
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(6,772128,{},'Entity',entCfg.sortOrder-1,1,nil,false)
widget:SetChildSceneEntityCreateModel(7,772127,{},'Entity',entCfg.sortOrder+1,1,nil,false)
end



function xjEntity_zongmen:playBanMoveZongMenBuffEffect()
if not self:isCanPlayEffect()then return end
if self.showdbm then return end
if self.pausemzmbf then return end
local widget=self:getWidget()
if widget==nil then return end
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
if self:playSpriteAnimation(widget,3,'xj_sq_sprite',Vector3.New(0,2,0),Vector3.New(5.5,5.5,5.5),'Entity',entCfg.sortOrder-2)then
self.showdbm=true
end
end

function xjEntity_zongmen:stopBanMoveZongMenBuffEffect(widget)
if not self.showdbm then return end
widget=widget or self:getWidget()
self:stopSpriteAnimation(widget,3)
self.showdbm=nil
self.pausemzmbf=nil
end

function xjEntity_zongmen:pauseBanMoveZongMenBuffEffect(widget)
if not self.showdbm then return end
if self.pausemzmbf then return end
self.pausemzmbf=true
self:stopSpriteAnimation(widget,3)
end

function xjEntity_zongmen:resumeBanMoveZongMenBuffEffect(widget)
if not self:isCanPlayEffect()then return end
if not self.showdbm then return end
if not self.pausemzmbf then return end
self.pausemzmbf=nil
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
self:playSpriteAnimation(widget,3,'xj_sq_sprite',Vector3.New(0,2,0),Vector3.New(5.5,5.5,5.5),'Entity',entCfg.sortOrder-2)
end



function xjEntity_zongmen:playProgressbar(widget,current,val,maxVal,duration,reverse)
self:invokeEntityHudFunc('playProgressbar',nil,current,val,maxVal,duration,reverse)
end


function xjEntity_zongmen:playInvisibleEffect(widget,isDisable)
local isExecuteFunc=true
self:invokeEntityHudFunc('playInvisibleEffect',nil,isDisable)
if not isDisable then

if self.showivbe then return end

if self.showdivbe then
isExecuteFunc=false
end
else

if not self.showdivbe then return end

if not self.showivbe then
isExecuteFunc=false
end
end

if isExecuteFunc then
widget=widget or self:getWidget()
if widget==nil then return end
local enemyType=xianjieModel:checkEnemyType2(self.actorid,self.zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
widget:SetChildActive(0,true)
if isFriend then



widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0.5),0)
self.showAlphaValue=0.5
else

widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0)
self.showAlphaValue=0
widget:SetChildActive(0,false)
self.isHideModel=true
end
end

if not isDisable then
self.showivbe=true
else
self.showdivbe=nil
end
end


function xjEntity_zongmen:stopInvisibleEffect(widget,isDisable,isForceStop)
local isExecuteFunc=true
self:invokeEntityHudFunc('stopInvisibleEffect',nil,isDisable,isForceStop)
if not isForceStop then
if not isDisable then

if not self.showivbe then return end

if self.showdivbe then
isExecuteFunc=false
end
else

if self.showdivbe then return end

if not self.showivbe then
isExecuteFunc=false
end
end
end

if isExecuteFunc then
widget=widget or self:getWidget()
if widget==nil then return end

widget:SetChildActive(0,true)
widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),0)
self.showAlphaValue=1
self.isHideModel=false
end

if isForceStop then
self.showivbe=nil
self.showdivbe=nil
else
if not isDisable then
self.showivbe=nil
else
self.showdivbe=true
end
end
end

function xjEntity_zongmen:showSpineBuffEffect(buffId,buffParam)
if self.buffList==nil then return end
local widget=self:getWidget()
if widget==nil then return end
local guid=self.buffList[buffId]
if not guid then
local spineId=buffParam[1]
local hangPoint=buffParam[2]
local offset=buffParam[3]
local scale=buffParam[4]
local isMoJie=buffParam[5]
if isMoJie and not self:CheckIsInMoJie()then
return
end
local parent=widget:GetCommonComponent(_buffRoot[hangPoint],"Transform")
guid=_InstantiateManager.AddInstance(INSTANCE_TYPE.eXJBuffItem_Spine,parent,function(id)
local _widget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
_widget:SetChildSceneEntityCreateModel(0,spineId,{},'Entity',entCfg.sortOrder+1,scale,nil,false)
_widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,0),0.01)
_widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.enter,1,nil)
_widget:SetChildSceneEntityChangeColor(0,Color.New(1,1,1,1),1)
_widget:SetChildLocalPosition(0,mathHelper.convertArrayToVector(offset))
end)
self.buffList[buffId]=guid
end
end

function xjEntity_zongmen:hideBuffEffect(buffId)
if self.buffList==nil then return end
local guid=self.buffList[buffId]
if guid then
_InstantiateManager.RemoveInstance(guid)
self.buffList[buffId]=nil
end
end

function xjEntity_zongmen:changeModel(widget,isInit)
widget=widget or self:getWidget()
if widget==nil then return end
local modelset=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'modelSet_zm')
local modelId=modelset.model
if self.zmData and self.zmData.sectdress and self.zmData.sectdress~=0 then
local sectdressId=self.zmData.sectdress
local settingcfg=UISettingConfig.getCfg(KUANGE_TYPE.zongmen,sectdressId)
if settingcfg then
modelId=settingcfg.modelId
end
end
local flag=xianjieController:getJianHuaMode()
if self.curModel==modelId and self.jianhuaMode==flag then
return
end
widget:SetChildActive(0,true)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityCreateModel(0,modelId,{},'Entity',entCfg.sortOrder,modelset.scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)

if flag then
widget:SetChildSceneEntityFreezeAnimation(0,0,0)
end
self.jianhuaMode=flag








local offset=modelset.offset
widget:SetChildLocalPosition(0,Vector3(offset[1],offset[2],offset[3]))
self.curModel=modelId
if not isInit then
if self.isHideModel then
widget:SetChildActive(0,false)
end
end
end

function xjEntity_zongmen:initInvisibleRangeGridsShow(widget)
widget=widget or self:getWidget()
if widget==nil then return end
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayerName='Entity'
local sortingOrder=entCfg.sortOrder

local gridsList=widget:GetChildLayoutGroupGridList(12)
if gridsList then
for i=1,gridsList.Count do
local grid=gridsList[i-1]
grid:SetChildSpriteRendererSortingLayer(-1,sortingLayerName,sortingOrder-2)
end
end
end


function xjEntity_zongmen:setInvisibleRangeGridsShow(widget,isShow)
isShow=isShow or false
self.isShowInvisibleRangeGrids=self.isShowInvisibleRangeGrids or false
if self.isShowInvisibleRangeGrids==isShow then
return
end

widget=widget or self:getWidget()
local hudTipsStr
if widget then
widget:SetChildActive(12,isShow)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
self.isShowInvisibleRangeGrids=isShow
local effectId=invisibleRangeEffectId
if isShow then
local sceneidx=self.zmData.sceneidx
local zm_gridX=self.zmData.gridX
local zm_gridZ=self.zmData.gridZ
local abname=globalABLookup.xjhudicons
local gridIndexList={
11,12,13,14,15,16,
21,22,23,24,25,26,
31,32,35,36,
41,42,45,46,
51,52,53,54,55,56,
61,62,63,64,65,66,
}
local defaultIndex_X=3
local defaultIndex_Z=3
local privilegeId=XIANGUAN_PRIVILEGE_ENUM.eShenYinMoCe
local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
local effectArgs=privilegeCfg.effectArgs
local rangeOutList={effectArgs[3],effectArgs[4],effectArgs[5],effectArgs[6]}
local validIntervalRange=self:getIntervalRangeList(rangeOutList)


local gridCount=#gridIndexList
widget:SetChildLayoutGroupCreateItems(12,gridCount,function(i)
local grid=widget:GetChildLayoutGroupGridItem(12,i-1)
local gridIndex=gridIndexList[i]
local gridIndex_X=gridIndex%10
local gridIndex_Z=math.floor(gridIndex/10)
local interval_X=gridIndex_X-defaultIndex_X
local interval_Z=gridIndex_Z-defaultIndex_Z
local isValid=(interval_X>=validIntervalRange[1][1]and interval_X<=validIntervalRange[1][2])and(interval_Z>=validIntervalRange[2][1]and interval_Z<=validIntervalRange[2][2])
grid:SetChildActive(-1,isValid)
if isValid then
local gridTran=grid:GetChildGameObject(-1).transform
local posX=2.5*interval_X-1.25
local posZ=2.5*interval_Z-1.25
gridTran.localPosition=Vector3.New(posX,0,posZ)

local gridX=zm_gridX+interval_X
local gridZ=zm_gridZ+interval_Z
local icon=self:getGridIcon(sceneidx,gridX,gridZ)
grid:SetChildSpriteRendererWithBundle(-1,abname,icon,false)

local sortingLayerName='Entity'
local sortingOrder=entCfg.sortOrder
grid:SetChildSpriteRendererSortingLayer(-1,sortingLayerName,sortingOrder-2)
end
end)

widget:SetChildShowEffectEx(10,effectId,sortingLayer,entCfg.sortOrder-1,true)

local actorName=self.zmData.actorname
local jobType=XIANGUAN_TYPE_ENUM.eLingYinMiShi
local jobTypeCfg=cfgHelper.get(cfg_xianguanjobtypeconfig_get,jobType)
local jobName=jobTypeCfg.name
hudTipsStr=FMT.fmt("{0}为<color=#fcca31>{1}</color>\n迁移至光阵内将不被其他仙盟祖师<color=#09ca16>侦查</color>和<color=#09ca16>放逐</color>",actorName,jobName)
else
widget:SetChildShowEffectEx(10,effectId,sortingLayer,entCfg.sortOrder-1,false)
widget:SetChildLayoutGroupClearAllItems(12)
end
end

self:invokeEntityHudFunc('refreshJobTipsPanel',nil,hudTipsStr,true)
end

function xjEntity_zongmen:getGridIcon(sceneidx,gridX,gridZ)
local flag=xianjieModel:checkGridState2(sceneidx,gridX,gridZ)
if flag then
return'image_xjbs_7'
else
return'image_xjbs_6'
end
end

function xjEntity_zongmen:getIntervalRangeList(rangeOutList)
local rangeList={}
rangeList[1]={-rangeOutList[4],1+rangeOutList[2]}
rangeList[2]={-rangeOutList[3],1+rangeOutList[1]}
return rangeList
end

function xjEntity_zongmen:checkShowInvisibleRangeGrids(widget)

local jobType=XIANGUAN_TYPE_ENUM.eLingYinMiShi
local actorId=self.actorid

local isShow=false
local isInMoveState=xianjieModel:checkSceneState(xjSceneStateType.eMoveZongMen)
if isInMoveState then
local isLYMS,jobId=xianguanController:checkActorHasJobByType(actorId,jobType)
if isLYMS then
local privilegeId=XIANGUAN_PRIVILEGE_ENUM.eShenYinMoCe
local isHasTq=xianguanConfig.checkJobCfgHasTeQuan(jobId,privilegeId)
local isCanUse=xianguanHelper.checkTeQuanPlatformLimit(privilegeId)and xianguanHelper.checkSpecialUseCondition(jobId,privilegeId,false)
if isHasTq and isCanUse then
local enemyType=xianjieModel:checkEnemyType2(self.actorid,self.zmData.ownersceneidx)

local isFriend=enemyType==xjEnemyType.eAllies
isShow=isFriend
end
end
end
return self:setInvisibleRangeGridsShow(widget,isShow)
end



function xjEntity_zongmen:CheckIsInMoJie()
local curSceneidx=xianjieModel:getSceneIndex()
local isInMoJie=xianjienSceneIndexType:isMoJie(curSceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(curSceneidx)
return isInMoJie
end

function xjEntity_zongmen:playSkillPengLaiEffect(widget)
if not self:isCanPlayEffect()then return end
if not self:CheckIsInMoJie()then return end
if self.showpladd then return end
widget=widget or self:getWidget()
if widget==nil then return end

local enemyType=xianjieModel:checkEnemyType2(self.actorid,self.zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if isFriend then
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)

local effect={11118,{0,0,0},2}
if effect then
widget:SetChildActive(16,true)
local effectid=effect[1]
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(16,effectid,sortingLayer,entCfg.sortOrder-1,true)
local pos=effect[2]
widget:SetChildLocalPosition(16,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[3]
widget:SetChildScale(16,Vector3(scale,scale,scale))
self.showpladd=true
end
else
widget:SetChildActive(16,false)
end

end

function xjEntity_zongmen:stopSkillPengLaiEffect(widget)
widget=widget or self:getWidget()
if widget==nil then return end
widget:SetChildActive(16,false)
self.showpladd=false

end


function xjEntity_zongmen:playSLSkillBuffIcon(widget)

if not self:CheckIsInMoJie()then return end
self:invokeEntityHudFunc('playSLSkillBuffIcon')
end

function xjEntity_zongmen:stopSLSkillBuffIcon(widget)

self:invokeEntityHudFunc('stopSLSkillBuffIcon')
end


function xjEntity_zongmen:playSkillJiuYuanEffect(widget)
if not self:isCanPlayEffect()then return end
if not self:CheckIsInMoJie()then return end
if self.showjyadd then return end
widget=widget or self:getWidget()
if widget==nil then return end
local enemyType=xianjieModel:checkEnemyType2(self.actorid,self.zmData.ownersceneidx)
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if isFriend then
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local effect={11117,{-0.2,-1.3,0},3}
if effect then
widget:SetChildActive(17,true)
local effectid=effect[1]
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(17,effectid,sortingLayer,entCfg.sortOrder-1,true)
local pos=effect[2]
widget:SetChildLocalPosition(17,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[3]
widget:SetChildScale(17,Vector3(scale,scale,scale))
self.showjyadd=true
end
else
widget:SetChildActive(17,false)
end

end

function xjEntity_zongmen:stopSkillJiuYuanEffect(widget)
widget=widget or self:getWidget()
if widget==nil then return end
widget:SetChildActive(17,false)
self.showjyadd=false

end


function xjEntity_zongmen:playMoJunAreaEffect(widget,effType)
if not self:isCanPlayEffect()then return end
if not self:CheckIsInMoJie()then return end
if self.showmojuneff then return end
if self.pausemojuneff then return end
widget=widget or self:getWidget()
if widget==nil then return end
local anim=effType==1 and'mojun_zhenwu'or'mojun_xiedu'
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
self:playSpriteAnimation(widget,18,anim,Vector3.New(0,5,0),Vector3.New(5.5,5.5,5.5),'Entity',entCfg.sortOrder-1)
self.showmojuneff=true
end


function xjEntity_zongmen:stopMoJunAreaEffect(widget)
widget=widget or self:getWidget()
if widget==nil then return end
self:stopSpriteAnimation(widget,18)
self.showmojuneff=false

end

function xjEntity_zongmen:pauseMoJunAreaEffect(widget)
if not self.showmojuneff then return end
if self.pausemojuneff then return end
widget=widget or self:getWidget()
if widget==nil then return end
self.pausemojuneff=true
self.showmojuneff=false
self:stopSpriteAnimation(widget,18)
end

function xjEntity_zongmen:resumeMoJunAreaEffect(widget)
if not self:isCanPlayEffect()then return end
widget=widget or self:getWidget()
if widget==nil then return end
self.pausemojuneff=nil
local effType=xianjieController:getZMMoJunAreaEffect(self.actorid)
if effType~=nil then
self:playMoJunAreaEffect(widget,effType)
end
end

function xjEntity_zongmen:onDelete()

end

return xjEntity_zongmen