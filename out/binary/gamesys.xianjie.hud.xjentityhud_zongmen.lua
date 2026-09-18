









local xjEntityHud_zongmen={}
local widgetCmpIndex={
nameBG=0,
name=1,
lv=2,
mySign=3,
yuanjun=4,
lvbg=5,
iconBack=6,
buffIcon=7,
root=8,
jobTipsPanel=9,
jobTipsText=10,
skillpanel=11,
progressbar=12,
hitCountBg=13,
hitCountTxt_1=14,
hitCountTxt_2=15,
hitCountTxt_3=16,
}
local skillpanelIndex=
{
skillicon={0,1,2},
skillnum={3,4,5},
}


function xjEntityHud_zongmen:onInit()
self.needFollow=true

local hudSet=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'hudSet_zm')
local tagOffset=hudSet.tagOffset
self.tagOffset={}
for i=1,6 do
local offset=tagOffset~=nil and tagOffset[i]or nil
self.tagOffset[i]=offset and mathHelper.convertArrayToVector(offset)or Vector3.zero
end
if self.tagOffset[4]then
self.tagOffset[4]=mathHelper.convertArrayToVector({1.5,6,0})
end
if self.tagOffset[5]then
self.tagOffset[5]=mathHelper.convertArrayToVector({-2,-1,0})
end
if self.tagOffset[6]then
self.tagOffset[6]=mathHelper.convertArrayToVector({0,7.1,0})
end
local uiOffset=hudSet.uiOffset
self.uiOffset={}
for i=1,6 do
local offset=uiOffset~=nil and uiOffset[i]or nil
self.uiOffset[i]=offset and mathHelper.convertArrayToVector(offset)or Vector2(0,0)
end

local data=self.data
self.actorid=data[1]
self.ismy=data[2]
local zmData=self:getZMData()
self.enemyType=xianjieModel:checkEnemyType2(self.actorid,zmData.ownersceneidx)
self.isHideModel=self.isHideModel

if self.isHideModel==nil then
self.isHideModel=false
local enemyType=self.enemyType
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if not isFriend then
self.isHideModel=xianjieModel:isZmInvisible(self.actorid)
end
end

self._onHitCountChange=function(...)
if self.m_widgetID==nil then return end

self:updateHitCount(...)
end
notifySystem:listenNotify(notifyConfig.onHitCountChange,self._onHitCountChange)
end

function xjEntityHud_zongmen:getZMData()
local zmData
if self.ismy then
zmData=xianjieModel:getMyZongMenData()
else
zmData=xianjieModel:getZongMenData(self.actorid)
end
return zmData
end

function xjEntityHud_zongmen:getZMBG()
local icon
local typo=self.enemyType
if typo==xjEnemyType.eSelf then
icon='image_xjbs_zongmen_lv'
elseif typo==xjEnemyType.eAllies then
icon='image_xjbs_zongmen_lan'
elseif typo==xjEnemyType.eEnemy then
icon='image_xjbs_zongmen_hong'
elseif typo==xjEnemyType.eStranger then
icon='image_xjbs_zongmen_hui'
end
return globalABLookup.xjhudicons,icon
end


function xjEntityHud_zongmen:onCreateWidget(widget)
if self.ismy then
local zmData=self:getZMData()
local isPlayEffect=xianjieController:invokeEntityFunc(zmData.ent_key,'getIsPlayEffect')
if isPlayEffect then widget:SetChildActive(-1,false)end
end
widget:SetChildActive(widgetCmpIndex.root,true)
local zmData=self:getZMData()

local abname,icon=self:getZMBG()
widget:SetChildCSImageSprite(widgetCmpIndex.lvbg,abname,icon)
widget:SetChildButtonClick(widgetCmpIndex.nameBG,function()
self:onClick()
end)

local name_str=xianjieModel.getColorStrByEnemyType(self.enemyType,zmData.actorname)




widget:SetChildText(widgetCmpIndex.name,name_str)

widget:SetChildText(widgetCmpIndex.lv,zmData:getBaoLeiLevel())

widget:SetChildActive(widgetCmpIndex.mySign,self.ismy)
if self.ismy then
widget:SetChildButtonClick(widgetCmpIndex.mySign,function()
self:onClick()
end)
end

local hasYuanJun=false
widget:SetChildActive(widgetCmpIndex.yuanjun,hasYuanJun)
if hasYuanJun then
widget:SetChildButtonClick(widgetCmpIndex.yuanjun,function()
self:onClick()
end)
end

if self.isHideModel then
widget:SetChildActive(widgetCmpIndex.root,false)
end


self:refreshJobBuff(widget)


self:refreshJobTipsPanel(widget)


widget:SetChildActive(widgetCmpIndex.skillpanel,false)
self:playSLSkillBuffIcon(widget)




widget:SetProgressBarAniFinishAction(widgetCmpIndex.progressbar,function()
widget:SetChildActive(widgetCmpIndex.progressbar,false)
end)


self:refreshHitCount(widget)
end


function xjEntityHud_zongmen:refreshTeQuanEditorHUD()
local widget=self:getWidget()

if widget then
self:refreshJobBuff(widget)
end
end

function xjEntityHud_zongmen:refreshJobBuff(widget)
widget=widget or self:getWidget()
if widget==nil then return end
local args=self:getJobBuffArgsList()
widget:SetChildActive(widgetCmpIndex.root,true)
if args then
local iconName=args.outIconName
local abName=args.outAbName
widget:SetChildActive(widgetCmpIndex.iconBack,true)
widget:SetChildCSImageSprite(widgetCmpIndex.buffIcon,abName,iconName)
widget:SetChildButtonClick(widgetCmpIndex.buffIcon,function()self:onClickBuff(widget,args)end)
if args.doAni then
self:doAni(widgetCmpIndex.iconBack)
else
self:endAni(widgetCmpIndex.iconBack)
end
else
self:endAni(widgetCmpIndex.iconBack)
widget:SetChildActive(widgetCmpIndex.iconBack,false)
end
if self.isHideModel then
widget:SetChildActive(widgetCmpIndex.root,false)
end
end

function xjEntityHud_zongmen:refreshJobTipsPanel(widget,tipsStr,justUseTips,saveTips)
widget=widget or self:getWidget()
if widget==nil then return end
if saveTips==nil then saveTips=true end
local showJobTipsStr=self.showJobTipsStr
if justUseTips then
showJobTipsStr=tipsStr
else
showJobTipsStr=tipsStr or self.showJobTipsStr
end
if saveTips then self.showJobTipsStr=showJobTipsStr end

local isShowJobTips=showJobTipsStr~=nil
widget:SetChildActive(widgetCmpIndex.jobTipsPanel,isShowJobTips)
if isShowJobTips then

widget:SetChildText(widgetCmpIndex.jobTipsText,showJobTipsStr)
end
end

function xjEntityHud_zongmen:getJobBuffArgsList()








local lymsArgs=self:checkLYMSBuff()
if lymsArgs then
return lymsArgs
end

local tqArgs=self:checkTeQuanEditor()
if tqArgs then
return tqArgs
end
end


function xjEntityHud_zongmen:checkFLXSBuff()
local jobId
local xmGuid
local myXMGuid
local ismyself=false
local isFLXS=false
local zmData=self:getZMData()
if self.ismy then
isFLXS,jobId=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eFuLuXianShi)
if isFLXS then ismyself=true end
end


if not isFLXS then
myXMGuid=zmData.guildid
isFLXS,jobId,xmGuid=xianguanController:checkIsActiveXGBuff(zmData.gridX,zmData.gridZ,zmData.sceneidx)
end

if isFLXS then
local buffId
local iconId=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,XIANGUAN_PRIVILEGE_ENUM.eXianGuanCiFu,'icon')
local jobName=cfgHelper.get2(cfg_xianguanconfig_get,jobId,'name')
local iconName=string.format('icon_xgtq_%s',iconId)
local buffCfg=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,XIANGUAN_PRIVILEGE_ENUM.eXianGuanCiFu,'effectArgs')


if xmGuid then
if not mathHelper.compareInt64(myXMGuid,int64.new('0'))and mathHelper.compareInt64(xmGuid,myXMGuid)then
buffId=buffCfg[1]
else
buffId=buffCfg[2]
end
else
if ismyself then
buffId=buffCfg[1]
else
buffId=buffCfg[2]
end
end
local desc1=homeBuffModel:getBuffDescByStateId(buffId)
local descList={desc1}
local abName='ui/icons/xianguantequan/xianguantequan_atlas_pak.ab'
local args={
name=jobName,
descList=descList,
iconName=iconName,
abName=abName,
outIconName=iconName,
outAbName=abName,
}
return args
end

return nil
end


function xjEntityHud_zongmen:checkLYMSBuff()
local hasLYMSBuff=xianjieModel:isCanNotTanChaAndFangZhu(self.actorid)
if hasLYMSBuff then
local zmData=self:getZMData()
if zmData.bufflistlen>0 then
local privilegeId=XIANGUAN_PRIVILEGE_ENUM.eShenYinMoCe
local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
local effectArgs=privilegeCfg.effectArgs
local alliesAndSelfBuffId=effectArgs[1]
local otherBuffId=effectArgs[2]
local buffId
local buffList_lookup=zmData.buffList_lookup or{}
local stamp=timeHelper.getServerShortTime()
if buffList_lookup[alliesAndSelfBuffId]then

local buffInfo=buffList_lookup[alliesAndSelfBuffId]
local sec=buffInfo.endsec
if sec==0 or sec>stamp then

buffId=alliesAndSelfBuffId
end
end
if not buffId and buffList_lookup[otherBuffId]then

local buffInfo=buffList_lookup[otherBuffId]
local sec=buffInfo.endsec
if sec==0 or sec>stamp then

buffId=otherBuffId
end
end

if buffId then
local iconName=xianguanConfig.getTeQuanIconName(privilegeCfg.icon)
local abName='ui/icons/xianguantequan/xianguantequan_atlas_pak.ab'
local args={
outIconName=iconName,
outAbName=abName,
privilegeId=privilegeId,
}
return args
end
end
end

return nil
end

function xjEntityHud_zongmen:checkTeQuanEditor()
local zmData=self:getZMData()
local entityId=zmData:getID()
local data
if playerModel:checkActorId(self.actorid)then
data=xianjieController:getHaloEntityArgs(entityId,XIANJIE_HALO_TYPE.eTeQuanEditor)
if data==nil then return end
else
local lookup=xianjieController:getSelfHaloEntitys(entityId,XIANJIE_HALO_TYPE.eTeQuanEditor)
if lookup==nil then return end
local myZmData=xianjieModel:getMyZongMenData()
local myZm_entityId=myZmData:getID()
if lookup[myZm_entityId]==nil then return end
data=xianjieController:getHaloEntityArgs(myZm_entityId,XIANJIE_HALO_TYPE.eTeQuanEditor)
end

local tqid=data.tqid
if tqid then
local cfg=cfg_xianguanprivilegeconfig_get(tqid)
local iconId=cfg.icon
local iconName=xianguanConfig.getTeQuanIconName(iconId)
local abName='ui/icons/xianguantequan/xianguantequan_atlas_pak.ab'

local args={
outIconName=iconName,
outAbName=abName,
privilegeId=tqid,
doAni=true,
}
return args
end

return nil
end


function xjEntityHud_zongmen:playInvisibleEffect(widget,isDisable)
local isExecuteFunc=true
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
local enemyType=self.enemyType
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if not isFriend then

widget=widget or self:getWidget()
if widget then
widget:SetChildActive(widgetCmpIndex.root,false)
end
self.isHideModel=true
end
end

if not isDisable then
self.showivbe=true
else
self.showdivbe=nil
end
end


function xjEntityHud_zongmen:stopInvisibleEffect(widget,isDisable,isForceStop)
local isExecuteFunc=true
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
if widget then
widget:SetChildActive(widgetCmpIndex.root,true)
end
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

function xjEntityHud_zongmen:onClickBuff(widget,args)


local posVector2=widget:GetChildScreenPointToLocalPointRectangle(widgetCmpIndex.buffIcon)
local pos={posVector2.x,posVector2.y}
local offset={180,90}
UIManager:showWindow("UIXianGuanPrivilegeTipsWin",{pos=pos,showData=args,offset=offset})
end

function xjEntityHud_zongmen:onCloseBuff(widget)
widget:SetChildActive(12,false)
end


function xjEntityHud_zongmen:onRemoveWidget(widget)
self:stopInvisibleEffect(widget,nil,true)
self.isHideModel=nil
self.showJobTipsStr=nil
widget:SetChildIcon(widgetCmpIndex.lvbg,'',false)
widget:SetChildActive(widgetCmpIndex.jobTipsPanel,false)
self:stopAllAni()

end

function xjEntityHud_zongmen:onClick()
if not self:checkWidget()then return end
local ismy=self.ismy
local actorId
if not ismy then
actorId=self.actorid
end
xianjieController:openZmInfoWin(ismy,actorId)
end

function xjEntityHud_zongmen:doAni(componentIndex)
if self.tweenerlist==nil then self.tweenerlist={}end

if self.tweenerlist[componentIndex]==nil then
local widget=self:getWidget()
local tweener=widget:SetChildCanvasGroupDOFade(componentIndex,0.5,0.5)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.tweenerlist[componentIndex]={}
self.tweenerlist[componentIndex]=tweener
end
end

function xjEntityHud_zongmen:endAni(componentIndex)
if self.tweenerlist==nil then return end

if self.tweenerlist[componentIndex]then
local tweener=self.tweenerlist[componentIndex]
tweener:Complete()
tweener:Kill()
self.tweenerlist[componentIndex]=nil
end
end

function xjEntityHud_zongmen:stopAllAni()
if self.tweenerlist==nil then return end
for _,tweener in pairs(self.tweenerlist)do
tweener:Complete()
tweener:Kill()
end
self.tweenerlist=nil
end

function xjEntityHud_zongmen:playProgressbar(widget,current,val,maxVal,duration,reverse)
widget=widget or self:getWidget()
if widget==nil then return end
widget:SetChildActive(widgetCmpIndex.progressbar,true)

widget:SetProgressBarAniWithFiveParams(widgetCmpIndex.progressbar,current,val,maxVal,duration,true)

if self.closeProgressTimer then
self.closeProgressTimer:cancel()
end
self.closeProgressTimer=timeEventController.delayDo(duration,function()
if widget==nil then return end
widget:SetChildActive(widgetCmpIndex.progressbar,false)
self.closeProgressTimer=nil
end)
end



function xjEntityHud_zongmen:CheckIsInMoJie()
local curSceneidx=xianjieModel:getSceneIndex()
local isInMoJie=xianjienSceneIndexType:isMoJie(curSceneidx)
return isInMoJie
end

function xjEntityHud_zongmen:handleBuffIconShow(widget)

local buffTemp={}
local buffNum=0
local zmData=self:getZMData()
if zmData and zmData.bufflistlen and zmData.bufflistlen>0 then
local buffList_lookup=zmData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end
if buffTemp and next(buffTemp)then
widget:SetChildActive(widgetCmpIndex.skillpanel,true)
local item=widget:GetChildWidgetBase(widgetCmpIndex.skillpanel)
local num=#skillpanelIndex.skillicon
for i=1,num do
if buffTemp[i]and buffTemp[i].buffid then
local buffId=buffTemp[i].buffid
item:SetChildActive(skillpanelIndex.skillicon[i],true)
local buffCfg=cfg_fairylandbuffconfig_get(buffId)
item:SetChildIcon(skillpanelIndex.skillicon[i],buffCfg.iconNmae,false)
else
item:SetChildActive(skillpanelIndex.skillicon[i],false)
end
end
else
widget:SetChildActive(widgetCmpIndex.skillpanel,false)
end

end


function xjEntityHud_zongmen:playSLSkillBuffIcon(widget)
widget=widget or self:getWidget()

if widget==nil then return end
if not self:CheckIsInMoJie()then return end
local enemyType=self.enemyType
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if isFriend then
self:handleBuffIconShow(widget)
end
end

function xjEntityHud_zongmen:stopSLSkillBuffIcon(widget)
widget=widget or self:getWidget()

if widget==nil then return end
if not self:CheckIsInMoJie()then return end
widget:SetChildActive(widgetCmpIndex.skillpanel,false)
local enemyType=self.enemyType
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if isFriend then
self:handleBuffIconShow(widget)
end
end

local _hitCountCmpIndexList={widgetCmpIndex.hitCountTxt_1,widgetCmpIndex.hitCountTxt_2,widgetCmpIndex.hitCountTxt_3}
local _hitCountBgAb="ui/windows/xianjie/xianjiemain_atlas_pak.ab"
function xjEntityHud_zongmen:refreshHitCount(widget)
widget=widget or self:getWidget()
if widget==nil then return end
local hitCount=xianjieModel:getZongMenLianZhan(self.actorid)
local isShow=hitCount and hitCount>0 or false

local sceneIdx=xianjieModel:getSceneIndex()
local isInMoGongZhengDuo=sceneIdx and xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)

isShow=isShow and(isInMoGongZhengDuo)
widget:SetChildActive(widgetCmpIndex.hitCountBg,isShow)
if not isShow then return end




local bgName,sIndex=xianjieModel:getHitCountBgName(hitCount)
widget:SetChildCSImageSprite(widgetCmpIndex.hitCountBg,_hitCountBgAb,bgName)

local countCmpIndex=_hitCountCmpIndexList[sIndex]
for index,cmpindx in ipairs(_hitCountCmpIndexList)do
widget:SetChildActive(cmpindx,cmpindx==countCmpIndex)
end

widget:SetChildText(countCmpIndex,hitCount)
end

function xjEntityHud_zongmen:updateHitCount(sceneid,actorID,hitCount)
if mathHelper.compareInt64(self.actorid,actorID)then
self:refreshHitCount()
end
end


function xjEntityHud_zongmen:onDelete()
notifySystem:removelistener(notifyConfig.onHitCountChange,self._onHitCountChange)
end

return xjEntityHud_zongmen