







def_class("UIXBSL_mainWin",UIWindowBase)









function UIXBSL_mainWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.targetBtn=UIButton.get(self,1)
self.mapRoot=UIObject.get(self,2)
self.xuanShangBtn=UIButton.get(self,3)
self.modeMenuGroup=UIObject.get(self,4)
self.cloudClickMask=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.title2=UIText.get(self,7)
self.vocBanPanel=UIObject.get(self,8)
self.buffItem=UIObject.get(self,9)
self.gotoBtn=UIButton.get(self,10)
self.tipsBg=UIObject.get(self,11)
self.mask=UIObject.get(self,12)
self.xuanShangLockFlag=UIObject.get(self,13)
self.xuanShangReddot=UIObject.get(self,14)
self.targetReddot=UIObject.get(self,15)
self.map=UIObject.get(self,16)
self.mapClickMask=UIObject.get(self,17)
self.tipsText=UIText.get(self,18)
self.vocBanGroup=UIObject.get(self,19)
self.gotoBtnText=UIText.get(self,20)
self.unlockTipsRoot=UIObject.get(self,21)
self.unlockTips=UIText.get(self,22)
self.mapBg=UIImage.get(self,23)
self.cloudModel=UIObject.get(self,24)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.targetBtn:setButtonClick(function()self:onTargetBtn()end)

self.xuanShangBtn:setButtonClick(function()self:onXuanShangBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIXBSL_mainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.targetBtn);self.targetBtn=nil;
_UIObject_release(self.mapRoot);self.mapRoot=nil;
_UIObject_release(self.xuanShangBtn);self.xuanShangBtn=nil;
_UIObject_release(self.modeMenuGroup);self.modeMenuGroup=nil;
_UIObject_release(self.cloudClickMask);self.cloudClickMask=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.vocBanPanel);self.vocBanPanel=nil;
_UIObject_release(self.buffItem);self.buffItem=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.xuanShangLockFlag);self.xuanShangLockFlag=nil;
_UIObject_release(self.xuanShangReddot);self.xuanShangReddot=nil;
_UIObject_release(self.targetReddot);self.targetReddot=nil;
_UIObject_release(self.map);self.map=nil;
_UIObject_release(self.mapClickMask);self.mapClickMask=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.vocBanGroup);self.vocBanGroup=nil;
_UIObject_release(self.gotoBtnText);self.gotoBtnText=nil;
_UIObject_release(self.unlockTipsRoot);self.unlockTipsRoot=nil;
_UIObject_release(self.unlockTips);self.unlockTips=nil;
_UIObject_release(self.mapBg);self.mapBg=nil;
_UIObject_release(self.cloudModel);self.cloudModel=nil;
end
















local _pathType=DG.Tweening.PathType
local _this
local _levelItemCmpIndex={
root=0,
icon=1,
levelText=2,
finishFlag=3,
monsterPos=4,
levelTitle=5,
smoke=6,
}




function UIXBSL_mainWin:onLoaded(...)
self:bindComponents()
_this=self
self.levelSTID={}
if verifyManager:isHideBusinessActivity()then
local obj=self:FindTransform("#xuanShangBtn").gameObject
if obj then
obj:SetActive(false)
end
end
end


function UIXBSL_mainWin:__delete()
self:clearOpenChapterTimer()
self:clearGotoBtnTimer()
self:clearTipsTweener()
self:clearAll()
self:unbindComponents()
_this=nil
end




function UIXBSL_mainWin:onShow(argtable,afterOnloaded)
self.smokeDelayTimerList={}
self.fadeTweennerList={}
self:init(argtable)
self:onShowArgRecv(argtable,afterOnloaded)
end

function UIXBSL_mainWin:onShowArgRecv(argtable,afterOnloaded)

self:refresh(true,true)
end


function UIXBSL_mainWin:onHide()
self:clearOpenChapterTimer()
self:clearGotoBtnTimer()
self:clearTipsTweener()
self:clearAll()
self:clearAllSmoke()
end

function UIXBSL_mainWin:init(argtable)
local args=argtable and argtable.args or{}

self.autoToNext=args.autoToNext
if self.autoToNext then
self.clickGoTO=true
end

self.modeMenuList={XBSL_DIFFICULTY_MODE.Normal,XBSL_DIFFICULTY_MODE.Hard}
if args.modeId then
for i,modeId in ipairs(self.modeMenuList)do
if modeId==args.modeId then
self.selectModeIndex=i
break
end
end
self.modeId=args.modeId
else
self.selectModeIndex=1
self.modeId=self.modeMenuList[self.selectModeIndex]
end

if args.chapterId then
self.chapterId=args.chapterId
end

if args.standLevelIdx then
self.standLevelIdx=args.standLevelIdx
end
end

function UIXBSL_mainWin:refresh(isInit,isShowEnter)
self:refreshModeMenu()
local chapterId=xunBaoShiLianModel:getChapterIdByModeId(self.modeId)
if not chapterId or chapterId==0 then
chapterId=1
end
local isChapterUnlock=xunBaoShiLianModel:checkChapterIsUnlock(chapterId,self.modeId)
local isShowLastArea=false
if not isChapterUnlock and chapterId>1 then
local lastChapterId=chapterId-1
local nowChapterCfg=xunBaoShiLianModel:checkModelChapter(self.modeId,chapterId)
local lastChapterCfg=xunBaoShiLianModel:checkModelChapter(self.modeId,lastChapterId)

local nowMapId=nowChapterCfg and nowChapterCfg.mapParam[1]
local lastMapId=lastChapterCfg and lastChapterCfg.mapParam[1]

if lastMapId and nowMapId and nowMapId==lastMapId then
isShowLastArea=true
isChapterUnlock=true
end
end

self:refreshTipsText()
if isInit then
local cloudId=5278
local animId=isChapterUnlock and 2160 or eAnimationID.stand
self.cloudModel:setChildUIModelShowTarget(cloudId,1,{},animId,false,false,0,nil)
self.cloudClickMask:setActive(not isChapterUnlock)
self.isShowCloud=not isChapterUnlock
self:setTipsBgShow(not isChapterUnlock)
self:refreshPage(isInit,isShowEnter,isShowLastArea)
else
return self:showMapCloud(not isChapterUnlock,not self.isShowCloud,isShowLastArea)
end

self:refreshBtnReddot()
end

function UIXBSL_mainWin:setTipsBgShow(isShow,ignoreInit)
self:clearTipsTweener()
local startAlpha=isShow and 0 or 1
local endAlpha=isShow and 1 or 0
if not ignoreInit then
self.tipsBg:setChildCanvasGroupAlpha(startAlpha)
end
self.tipsTweener=self.tipsBg:setChildCanvasGroupDOFade(endAlpha,0.5)
end

function UIXBSL_mainWin:refreshBtnReddot()

local xuanshangBtnReddot=xunBaoShiLianModel:checkXuanShangEnterReddot()
self.xuanShangReddot:setActive(xuanshangBtnReddot)


local targetBtnReddot=xunBaoShiLianModel:checkTargetEnterReddot()
self.targetReddot:setActive(targetBtnReddot)

end

function UIXBSL_mainWin:refreshTipsText()
self:clearOpenChapterTimer()
local chapterId=xunBaoShiLianModel:getChapterIdByModeId(self.modeId)
if not chapterId or chapterId==0 then
chapterId=1
end
local isChapterUnlock,isTimeType,lockParam=xunBaoShiLianModel:checkChapterIsUnlock(chapterId,self.modeId)
self.tipsBg:setActive(not isChapterUnlock)

if not isChapterUnlock then
if isTimeType then
local openTime=lockParam[1]
local nowTime=timeHelper.getServerShortTime()
self.tipsText:setText(FMT.fmt("{0}后开启",timeHelper.format_time_stamp11(openTime-nowTime,true)))

self:setOpenChapterTimer(openTime)
elseif lockParam and next(lockParam)then
local targetChapterId=lockParam[1]
local targetLevelIdx=lockParam[2]
self.tipsText:setText(FMT.fmt("通关普通难度{0}-{1}后开启",targetChapterId,targetLevelIdx))
else

self.tipsText:setText("暂未觅得宝物行踪，请祖师静候弟子佳音...")
end
end

end

function UIXBSL_mainWin:refreshModeMenu()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXBSL_TiaoZhanReddot)
local grids=self.modeMenuGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local modeId=self.modeMenuList[i]
if modeId then
widget:SetChildActive(-1,true)
local isSelect=self.selectModeIndex==i
widget:SetChildActive(0,not isSelect)
widget:SetChildActive(1,isSelect)
local isCanTZ=xunBaoShiLianModel:isCanTiaoZhanByModeId(modeId)
widget:SetChildActive(2,not flag and isCanTZ)

widget:SetChildButtonClick(-1,function()
if not _this then return end
if _this.modeId==modeId then return end

return _this:selectMode(i)
end,true)
else
widget:SetChildActive(-1,false)
end
end
end

function UIXBSL_mainWin:selectMode(selectModeIndex)
if selectModeIndex==self.selectModeIndex then
return
end

if self.isChanging then
return
end
self:clearAllSmoke()

self.selectModeIndex=selectModeIndex
self.modeId=self.modeMenuList[self.selectModeIndex]
self:refresh()
end

function UIXBSL_mainWin:refreshPage(isInit,isShowEnter,isShowLastArea)
self.chapterId=xunBaoShiLianModel:getChapterIdByModeId(self.modeId)
if not self.chapterId or self.chapterId==0 then

self.chapterId=1
end
self.levelIdx=xunBaoShiLianModel:getLevelIdxByModeId(self.modeId)

if isShowLastArea and self.chapterId>1 then
self.chapterId=self.chapterId-1
local chapterCfg=xunBaoShiLianModel:checkModelChapter(self.modeId,self.chapterId)
local guanqiaIdList={}
if chapterCfg then
if self.modeId==XBSL_DIFFICULTY_MODE.Normal then
guanqiaIdList=chapterCfg.simple_ids
elseif self.modeId==XBSL_DIFFICULTY_MODE.Hard then
guanqiaIdList=chapterCfg.difficulty_ids
end
end
local lastChapterMaxLevelIdx=#guanqiaIdList
self.levelIdx=lastChapterMaxLevelIdx
end
if not isInit or not self.standLevelIdx then
self.standLevelIdx=self.levelIdx
end
if self.levelIdx~=0 then

isShowEnter=false
end

local ccfg=xunBaoShiLianModel:checkModelChapter(self.modeId,self.chapterId)

self.title:setText(FMT.fmt('第{0}章',self.chapterId))
self.title2:setText(ccfg and ccfg.chapterName or"未知区域")

local mapParam=ccfg and ccfg.mapParam or nil
if mapParam then
self:initMap(isShowEnter)
self:refreshBuffItem()
self:refreshVocBanPanel()
end
self:setGoTOBtn(isShowLastArea)
end


function UIXBSL_mainWin:refreshBuffItem()
local isShowBuff=self.modeId==XBSL_DIFFICULTY_MODE.Hard
self.buffItem:setActive(isShowBuff)
if not isShowBuff then
return
end

local widget=self.buffItem:getWidgetBase()
local cfg=xunBaoShiLianModel:checkModelChapter(self.modeId,self.chapterId)
local buffInfoCfg=cfg.buffInfo
if buffInfoCfg then

local desc=buffInfoCfg.desc or""
widget:SetChildText(1,desc)


local iconParam=buffInfoCfg.icon
if iconParam then
local iconType=iconParam[1]
local param=iconParam[2]

if iconType==1 then

local jobId=param[1]
local jobicon=UIDiscipleModel:getJobIconName(jobId)
widget:SetChildCSImageSprite(0,globalABLookup.global,jobicon)
elseif iconType==2 then
local abName=param[1]
local iconName=param[2]
widget:SetChildCSImageSprite(0,abName,iconName)
end
end


local clickTips=buffInfoCfg.tips
widget:SetChildButtonClick(2,function()
local pos=Vector2.New(45,35)
self:showWindow('UIConditionTipsOne',{showType=2,str=clickTips,posWidget=self.widget,posWidgetIndex=self.buffItem:getID(),pos=pos})
end,true)
end
end

function UIXBSL_mainWin:refreshVocBanPanel()
local isHard=self.modeId==XBSL_DIFFICULTY_MODE.Hard
if not isHard then
self.vocBanPanel:setActive(false)
return
end

local cfg=xunBaoShiLianModel:checkModelChapter(self.modeId,self.chapterId)
local banList_lookup=cfg.voc_bans
local hasVocBan=banList_lookup~=nil and next(banList_lookup)~=nil
self.vocBanPanel:setActive(hasVocBan)
if not hasVocBan then
return
end

local banList={}
for vocId,v in pairs(banList_lookup)do
if v and v==1 then
banList[#banList+1]=vocId
end
end

table.sort(banList,function(a,b)
return a<b
end)

local count=#banList
self.vocBanGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.vocBanGroup:getChildLayoutGroupGridItem(index-1)
local vocId=banList[index]
local jobicon=UIDiscipleModel:getJobIconName(vocId)
widget:SetChildCSImageSprite(0,globalABLookup.global,jobicon)
end)
end


function UIXBSL_mainWin:showMapCloud(isShow,isOpenAgain,isShowLastArea,isShowEnter)

local animId=isShow and 2512 or 2511
local endAnimId=isShow and 2511 or 2512
self.cloudClickMask:setActive(true)
self.isChanging=true
local isOriginalShow=self.isShowCloud or false
self.isShowCloud=isShow
if not isShow and isOpenAgain then
self:clearAll()
self:setTipsBgShow(false)
self.cloudModel:setChildModelAnimationState(endAnimId,1,function()
if not _this then return end
return self:showMapCloud(isShow,nil,isShowLastArea,isShowEnter)
end)
else
if not isShow then
self:clearAll()
self:refreshPage(nil,isShowEnter,isShowLastArea)
self:setTipsBgShow(isShow,true)
elseif isOriginalShow then
self:clearAll()
self:refreshPage(nil,true)
self:setTipsBgShow(isShow,true)
self.isChanging=false
return
end
self.cloudModel:setChildModelAnimationState(animId,1,function()
if not _this then return end
if not isShow then
self.cloudClickMask:setActive(false)
self.widget:SetChildModelAnimationStop(self.cloudModel:getID(),animId,1)
else
self:clearAll()
self:refreshPage(nil,true)
self:setTipsBgShow(isShow,true)
end
self.isChanging=false

end)
end
end

function UIXBSL_mainWin:initMap(isShowEnter)

local cfg=xunBaoShiLianModel:checkModelChapter(self.modeId,self.chapterId)
local isChapterUnlock=xunBaoShiLianModel:checkChapterIsUnlock(self.chapterId,self.modeId)
local mapParam=cfg and cfg.mapParam or nil
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(self.modeId)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(self.modeId)
if mapParam then
local mapId=mapParam[1]
local areaId=mapParam[2]
local mapCfg=cfgHelper.get(cfg_treasuretrainningmapconfig_get,mapId)
local guanqiaIdList={}
if self.modeId==XBSL_DIFFICULTY_MODE.Normal then
guanqiaIdList=cfg.simple_ids
elseif self.modeId==XBSL_DIFFICULTY_MODE.Hard then
guanqiaIdList=cfg.difficulty_ids
end

local areaPointList=mapCfg.areaPointParam and mapCfg.areaPointParam[areaId]or{}
local pointCount=#areaPointList
self.map:setChildLayoutGroupCreateItems(pointCount,function(index)
local widget=self.map:getChildLayoutGroupGridItem(index-1)
local guanqiaId=guanqiaIdList[index]
local levelIdx=index
local isNextLevelIdx=levelIdx==clearLevelIdx+1
local pointPos=areaPointList[index]
local isClear=clearChapterId>self.chapterId or(self.chapterId==clearChapterId and clearLevelIdx>=levelIdx)
if isChapterUnlock and guanqiaId and pointPos then
widget:SetChildActive(-1,true)
widget:SetChildAnchoredPos(-1,pointPos[1],pointPos[2])

widget:SetChildActive(_levelItemCmpIndex.finishFlag,isClear)


if not isClear then
local guanqiaCfg=cfgHelper.get1(cfg_treasuretrainninggqconfig_get,guanqiaId)
if guanqiaCfg and guanqiaCfg.model then
local tran=widget:GetCommonComponent(_levelItemCmpIndex.monsterPos,'Transform')
local modelParam=guanqiaCfg.modelParam or{}
local scale=modelParam.scale
local offset=modelParam.offset
self:addAMonster(index,guanqiaCfg.model,tran,Vector3.zero,scale,offset,not isNextLevelIdx)
widget:SetChildActive(_levelItemCmpIndex.monsterPos,true)
widget:SetChildActive(_levelItemCmpIndex.icon,false)
else
widget:SetChildActive(_levelItemCmpIndex.monsterPos,false)
widget:SetChildActive(_levelItemCmpIndex.icon,true)
end
else
widget:SetChildActive(_levelItemCmpIndex.monsterPos,false)
widget:SetChildActive(_levelItemCmpIndex.icon,false)
end


widget:SetChildText(_levelItemCmpIndex.levelText,FMT.fmt("{0}-{1}",self.chapterId,levelIdx))

self:clearSmokeDelayTimerByIndex(index)
if isShowEnter then
widget:SetChildCanvasGroupAlpha(_levelItemCmpIndex.root,0)
local delayTime=(index-1)*0.6
self.smokeDelayTimerList[index]=self:delayDo(delayTime,function()

widget:SetChildShowEffect(_levelItemCmpIndex.smoke,20441,true)
self.fadeTweennerList[index]=widget:SetChildCanvasGroupDOFade(_levelItemCmpIndex.root,1,1)
end)
else
widget:SetChildShowEffect(_levelItemCmpIndex.smoke,0,false)
widget:SetChildCanvasGroupAlpha(_levelItemCmpIndex.root,1)
end
else
widget:SetChildActive(-1,false)
end
end)


self:refreshMapBg()
self.mapId=mapId
end
end

function UIXBSL_mainWin:refreshMapBg()
local ccfg=xunBaoShiLianModel:checkModelChapter(self.modeId,self.chapterId)
local mapParam=ccfg.mapParam
local mapId=mapParam[1]
local mapCfg=cfgHelper.get(cfg_treasuretrainningmapconfig_get,mapId)
if mapCfg then
local mapWidth=mapCfg.mapWidth
if mapWidth then
local height=self.map:getChildSizeDeltaY()
self.map:setChildSizeDelta(mapWidth,height)
end

local bgParam=mapCfg.bgParam
local bgImageName=bgParam[1]
local bgOffestX=bgParam[2]or 0
if bgImageName then
local abName=FMT.fmt("ui/windows/xunbaoshilian/sharedtextures/{0}.ab",bgImageName)
self.mapBg:setSprite(abName,bgImageName)
local anchoredPos=self.mapBg:getChildAnchoredPosition()
self.mapBg:setChildAnchoredPosition(Vector2(bgOffestX,anchoredPos.y))
end

local areaId=mapParam[2]
local anchoredPos=self.map:getChildAnchoredPosition()
if mapCfg and mapCfg.areaPos and mapCfg.areaPos[areaId]then
local posX=mapCfg.areaPos[areaId]
self.map:setChildAnchoredPos(posX,anchoredPos.y)
else
self.map:setChildAnchoredPos(0,anchoredPos.y)
end
end
end

function UIXBSL_mainWin:clearMonster()
for k,v in pairs(self.levelSTID)do
_InstantiateManager.RemoveInstance(v.stId)
if v.hud then
_InstantiateManager.RemoveInstance(v.hud)
end
end
self.levelSTID={}
end

function UIXBSL_mainWin:addAMonster(levelIdx,model,parent,pos,scale,offset,isHideHud)
local md={}
scale=scale or 0.8
offset=offset or{0,-30}
md.stId=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,parent,function(id)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')

local posOffset=Vector3.New(offset[1],offset[2],0)
local finalPos=pos+posOffset
stWidget:SetChildAnchoredPosition3D(0,finalPos)
local modelScale=isometricMapSystem:getModelScale(model,true)
modelScale=modelScale*scale
stWidget:SetChildUIModelShowTarget(0,model,modelScale,nil,eAnimationID.stand)

stWidget:SetChildButtonClick(2,function()
self.on_level_click(levelIdx)
end)

local headPos=stWidget:GetChildAnchoredPosition(1)
stWidget:SetChildAnchoredPos(1,headPos.x,headPos.y)
if not isHideHud then
local head=stWidget:GetCommonComponent(1,'Transform')
md.hud=_InstantiateManager.AddInstance(INSTANCE_TYPE.eCommonFlagHUD,head,function(hud)
local hudWidget=_InstantiateManager.GetComponent(hud,'CSGUIWidgetBase')
hudWidget:SetChildButtonClick(1,function()
self.on_level_click(levelIdx)
end)
end)
end
end)
self.levelSTID[levelIdx]=md
end

function UIXBSL_mainWin:setGoTOBtn(isShowLastArea)
self:clearGotoBtnTimer()
local nextLevelIdx=self.levelIdx+1

local chapterCfg=xunBaoShiLianModel:checkModelChapter(self.modeId,self.chapterId)
local guanqiaIdList={}
if chapterCfg then
if self.modeId==XBSL_DIFFICULTY_MODE.Normal then
guanqiaIdList=chapterCfg.simple_ids
elseif self.modeId==XBSL_DIFFICULTY_MODE.Hard then
guanqiaIdList=chapterCfg.difficulty_ids
end
end


local chapterId=xunBaoShiLianModel:getChapterIdByModeId(self.modeId)
if not chapterId or chapterId==0 then
chapterId=1
end
if isShowLastArea and chapterId>1 then
chapterId=chapterId-1
end
local isChapterUnlock=xunBaoShiLianModel:checkChapterIsUnlock(chapterId,self.modeId)

self.gotoBtn:setActive(isChapterUnlock)
self.gotoBtnText:setActive(isChapterUnlock)
if not isChapterUnlock then
return
end
local isBtnEnable=true
local isBtnGray=false
if nextLevelIdx>self.standLevelIdx then
local isUnlock,tips
if self.levelIdx>=#guanqiaIdList then
isUnlock=true
local nextChapterId=chapterId+1
local nextChapterCfg=xunBaoShiLianModel:checkModelChapter(self.modeId,nextChapterId)
if nextChapterCfg then
local isNextChapterUnlock,isTimeType,lockParam=xunBaoShiLianModel:checkChapterIsUnlock(nextChapterId,self.modeId)
if isNextChapterUnlock then
self.gotoBtnText:setText('<color=#fee48a>开启</color>\n下一章')
else
if isTimeType then
local openTime=lockParam[1]
local nowTime=timeHelper.getServerShortTime()
self.gotoBtnText:setText(FMT.fmt("{0}\n后<color=#fee48a>开启</color>",timeHelper.format_time_stamp11(openTime-nowTime,true)))

self:setGotoBtnTimer(openTime)
elseif lockParam and next(lockParam)then
local targetChapterId=lockParam[1]
local targetLevelIdx=lockParam[2]
self.gotoBtnText:setText(FMT.fmt("通关普通难度\n{0}-{1}后开启",targetChapterId,targetLevelIdx))
else

self.gotoBtnText:setText("敬请期待")
end
isBtnEnable=false
isBtnGray=true
end
else

self.gotoBtnText:setText("敬请期待")
isBtnEnable=false
isBtnGray=true
end
else
local nextGuanqiaId=guanqiaIdList[nextLevelIdx]
isUnlock,tips=self:checkAndGetUnlockArgs(nextGuanqiaId)
self.gotoBtnText:setText(FMT.fmt('<color=#fee48a>前往</color>\n{0}-{1}',self.chapterId,nextLevelIdx))
end
self.unlockTipsRoot:setActive(not isUnlock)
if not isUnlock then
self.unlockTips:setText(tips)
isBtnEnable=false
isBtnGray=true
end
else
self.gotoBtnText:setText('挑战关卡')
self.unlockTipsRoot:setActive(false)
end
self.gotoBtn:setButtonEnable(isBtnEnable,isBtnGray)
end

function UIXBSL_mainWin:getJingJie(level)
local n,p,pN=UIDiscipleModel:getJJNameX(level)
local jj_str
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
return jj_str
end

function UIXBSL_mainWin:getRewards(dropsId)
local list={}
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,dropsId)
for ii,vv in ipairs(rwcfg.showItems)do
local c=list[vv[1]]or 0
list[vv[1]]=c+vv[2]
end
local rlist={}
for k,v in pairs(list)do
table_insert(rlist,{k,v})
end
return rlist
end

function UIXBSL_mainWin:checkAndGetUnlockArgs(guanqiaId)
local cfg=cfgHelper.get1(cfg_treasuretrainninggqconfig_get,guanqiaId)
if cfg and cfg.conditions then
local cndParam=cfg.conditions
if cndParam[1]==1 then
local zmLevel=zongmenModel:getLevel()
if zmLevel<cndParam[2]then
local tips=FMT.fmt('宗门达到{0}级可挑战',cndParam[2])
return false,tips
end
end
end
return true
end

function UIXBSL_mainWin.on_level_click(levelIdx)
local chapterCfg=xunBaoShiLianModel:checkModelChapter(_this.modeId,_this.chapterId)
local nextLevelIdx=_this.levelIdx+1
if levelIdx<nextLevelIdx then
return
end

local guanqiaIdList={}
if _this.modeId==XBSL_DIFFICULTY_MODE.Normal then
guanqiaIdList=chapterCfg.simple_ids
elseif _this.modeId==XBSL_DIFFICULTY_MODE.Hard then
guanqiaIdList=chapterCfg.difficulty_ids
end
local guanqiaId=guanqiaIdList[levelIdx]
if not guanqiaId then
return
end

local cfg=cfgHelper.get1(cfg_treasuretrainninggqconfig_get,guanqiaId)
if not cfg then
return
end

local mId=cfg.mon_ids
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)
local skills=mcfg.showSkills
local rwList=_this:getRewards(cfg.drop_id)
local title=FMT.fmt("试炼{0}-{1}",_this.chapterId,levelIdx)

local args={
groupId=mId,
title=title,
name=mcfg.name,
level=_this:getJingJie(mcfg.level),
skills=skills,
rewards=rwList,
desc=mcfg.desc,
active_bg_click=true,
}
if nextLevelIdx==levelIdx then
local isUnlock,tips=_this:checkAndGetUnlockArgs(guanqiaId)
if isUnlock then
args.callback=function()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXBSL_TiaoZhanReddot)
if not flag then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXBSL_TiaoZhanReddot,true)
reddotControl.on_change_catch_type(CATCH_TYPE.eBaoLingShuXBSL)
end
_this:openFighting(mcfg.mapId,mId,mcfg.monList,levelIdx,guanqiaId)
end
else
args.challenge_tips=tips
end
else
if levelIdx>nextLevelIdx then
args.challenge_tips='需要完成前置关卡挑战'
else
args.challenge_tips='关卡已挑战'
end
end
_this:showWindow('UIMonsterInfoWin',args)
end

function UIXBSL_mainWin:openFighting(mapId,groupId,monList,levelIdx,guanqiaId)
local md=self.levelSTID[levelIdx]









local chapterId=self.chapterId
local isHardFlag=self.modeId==XBSL_DIFFICULTY_MODE.Hard and 1 or 0
if self.autoToNext then
local guidList=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.xunbaoshilian)
local team={}
for i=1,fightPreSelectModel.maxPosNum do
if guidList[i]then
team[i]={1,guidList[i]}
else
team[i]={0,int64.zero}
end
end
fightLaunchController:sendFight(eBattleLaunch.xunbaoshilian,team,mapId or 0,0,{chapterId,levelIdx,isHardFlag})
self:onCloseClick()
return
end
local modeId=self.modeId
local xbsl_datas={}
if self.modeId==XBSL_DIFFICULTY_MODE.Hard then
local chapterCfg=xunBaoShiLianModel:checkModelChapter(self.modeId,chapterId)
if chapterCfg then
if chapterCfg.voc_faze_list then
xbsl_datas.xbsl_buff_joblist=chapterCfg.voc_faze_list
end
if chapterCfg.voc_bans then
xbsl_datas.xbsl_ban_voclist=chapterCfg.voc_bans
end
end
end

local winArgs={
enterTxt="寻宝试炼",
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isCheckVocBan=true,
isHomeBattle=true,
monsterList=monList,
groupId=groupId,
xbsl_datas=xbsl_datas,
enterCallBack=function(guidList,zfId)
UIManager:closeWindow('UIXBSL_fightExtraWin')
fightLaunchController:sendFight(eBattleLaunch.xunbaoshilian,guidList,mapId or 0,zfId,{chapterId,levelIdx,isHardFlag})
end,
cancelCallBack=function()

UIManager:closeWindow('UIXBSL_fightExtraWin')
UIFullBaoLingShuControl:showXunBaoShiLianWindow({args={chapterId=chapterId,standLevelIdx=levelIdx,modeId=modeId}})
end,
}
local isShowExtraWin=self.modeId==XBSL_DIFFICULTY_MODE.Hard
fightController.showPrepareWin(fightPreSelectModel.fightType.xunbaoshilian,winArgs,function()
if not isShowExtraWin then
return
end
UIManager:showWindow('UIXBSL_fightExtraWin',{chapterId=chapterId,levelIdx=levelIdx,guanqiaId=guanqiaId})
end)
end

function UIXBSL_mainWin:playChangeChapter()
xunBaoShiLianController:setShiLianEnterNextChapter(self.modeId)

local chapterId=xunBaoShiLianModel:getChapterIdByModeId(self.modeId)
if not chapterId or chapterId==0 then
chapterId=1
end
local isChapterUnlock=xunBaoShiLianModel:checkChapterIsUnlock(chapterId,self.modeId)
self:refreshTipsText()

if isChapterUnlock and not self.isShowCloud then
local ccfg=xunBaoShiLianModel:checkModelChapter(self.modeId,chapterId)
local mapParam=ccfg.mapParam
local mapId=mapParam[1]
if mapId==self.mapId then

local areaId=mapParam[2]
self:setTipsBgShow(false)
local mapCfg=cfgHelper.get(cfg_treasuretrainningmapconfig_get,mapId)
if mapCfg and mapCfg.areaPos and mapCfg.areaPos[areaId]then
local posX=mapCfg.areaPos[areaId]
self.cloudClickMask:setActive(true)
self.isChanging=true
self.map:setChildDOAnchorPosX(posX,0.5,function()
self.cloudClickMask:setActive(false)
self.isChanging=false
self:clearAll()
self:refreshPage(nil,true)
end)
return
end
end
end


self:showMapCloud(not isChapterUnlock,not self.isShowCloud,nil,true)
end

function UIXBSL_mainWin:leave()
local time=0.5
self.mapRoot:setChildDOScale(0.75,time,nil)
self.mapRoot:setChildCanvasGroupDOFade(0,time,nil)
end

function UIXBSL_mainWin:enter()
local time=0.5
self.mapRoot:setChildDOScale(1,time,nil)
self.mapRoot:setChildCanvasGroupDOFade(1,time,function()
if self.autoToNext then
self:onGotoBtn()
end
end)
end

function UIXBSL_mainWin:countTZValue()
local investData=UILiLianControl:getInvestData()
local levelRewards=UILiLianControl:getTZRewardList(investData.rechargeId)
local lcfg=cfgHelper.get1(cfg_guanqiainvestconfig_get,investData.rechargeId)
local currLevel=UILiLianControl:getCurrentLevel()
local mtype=lcfg.rw_value[1]
local count=0
for i,v in ipairs(levelRewards)do
if v.level<=currLevel then
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,v.rwId)
local rewards=rwcfg.showItems
for ii,vv in ipairs(rewards)do
if vv[1]==mtype then
count=count+vv[2]
end
end
end
end
return count,mtype
end

function UIXBSL_mainWin:clearAllSmokeDelayTimer()
for index,timer in pairs(self.smokeDelayTimerList)do
self:stopTimerByID(timer)
self.smokeDelayTimerList[index]=nil
end
end

function UIXBSL_mainWin:clearSmokeDelayTimerByIndex(index)
if self.smokeDelayTimerList[index]then
self:stopTimerByID(self.smokeDelayTimerList[index])
self.smokeDelayTimerList[index]=nil
end
end

function UIXBSL_mainWin:clearAll()
self:clearMonster()

self:clearAllSmokeDelayTimer()
self:clearAllFadeTweenner()

uiAIManager:clearUIWinData('UIXBSL_mainWin')
end

function UIXBSL_mainWin:clearAllFadeTweenner()
for index,tweenner in pairs(self.fadeTweennerList)do
tweenner:Complete()
tweenner:Kill()
self.fadeTweennerList[index]=nil
end
end
function UIXBSL_mainWin:clearAllSmoke()
local grids=self.map:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
widget:SetChildShowEffect(_levelItemCmpIndex.smoke,0,false)
end
end




function UIXBSL_mainWin:onTargetBtn()

UIFullBaoLingShuControl:showXBSL_targetWindow()
end



function UIXBSL_mainWin:onXuanShangBtn()

local check=xunBaoShiLianModel:checkXuanShangHasBounty()
if not check then
return UIManager.error("当前悬赏已全部领取，敬请期待")
end

UIFullBaoLingShuControl:showXBSL_xuanShangWindow()
end



function UIXBSL_mainWin:onGotoBtn()
self.clickGoTO=nil
if self.isMoveing then
return
end
local nextLevelIdx=self.levelIdx+1

local chapterCfg=xunBaoShiLianModel:checkModelChapter(self.modeId,self.chapterId)
local guanqiaIdList={}
if self.modeId==XBSL_DIFFICULTY_MODE.Normal then
guanqiaIdList=chapterCfg.simple_ids
elseif self.modeId==XBSL_DIFFICULTY_MODE.Hard then
guanqiaIdList=chapterCfg.difficulty_ids
end
if nextLevelIdx>self.standLevelIdx then
local isUnlock,tips
if self.levelIdx>=#guanqiaIdList then
isUnlock=true

self:playChangeChapter()
else
local nextGuanqiaId=guanqiaIdList[nextLevelIdx]
isUnlock,tips=self:checkAndGetUnlockArgs(nextGuanqiaId)
if isUnlock then
self.on_level_click(nextLevelIdx)
else
return
end
end
self.unlockTipsRoot:setActive(not isUnlock)
if not isUnlock then
self.unlockTips:setText(tips)
end
else
if self.standLevelIdx>self.levelIdx then
self.on_level_click(nextLevelIdx)
else
return
end
end
end

function UIXBSL_mainWin:onCloseBtn()
UIFullBaoLingShuControl:closeUI(true,true)
end

function UIXBSL_mainWin:clearTipsTweener()
if self.tipsTweener~=nil then
self.tipsTweener:Kill(false)
self.tipsTweener=nil
end
end

function UIXBSL_mainWin:setOpenChapterTimer(openTime)
self:clearOpenChapterTimer()
self.openChapterTimer=self:setTimer(1,0,function()
if not _this then return end
local nowTime=timeHelper.getServerShortTime()
local lerp=openTime-nowTime
if lerp>0 then
self.tipsText:setText(FMT.fmt("{0}后开启",timeHelper.format_time_stamp11(openTime-nowTime,true)))
else

return self:refresh(nil,true)
end
end)
end

function UIXBSL_mainWin:setGotoBtnTimer(openTime)
self:clearGotoBtnTimer()
self.gotoBtnTimer=self:setTimer(1,0,function()
if not _this then return end
local nowTime=timeHelper.getServerShortTime()
local lerp=openTime-nowTime
if lerp>0 then

self.gotoBtnText:setText(FMT.fmt("{0}\n后<color=#fee48a>开启</color>",timeHelper.format_time_stamp11(openTime-nowTime,true)))
else



return self:setGoTOBtn()
end
end)
end

function UIXBSL_mainWin:clearOpenChapterTimer()
if self.openChapterTimer then
self:stopTimerByID(self.openChapterTimer)
self.openChapterTimer=nil
end
end

function UIXBSL_mainWin:clearGotoBtnTimer()
if self.gotoBtnTimer then
self:stopTimerByID(self.gotoBtnTimer)
self.gotoBtnTimer=nil
end
end