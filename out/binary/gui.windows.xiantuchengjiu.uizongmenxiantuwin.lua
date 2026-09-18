







def_class("UIZongMenXianTuWin",UIWindowBase)









function UIZongMenXianTuWin:bindComponents()

self.content=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.lookBack=UIButton.get(self,2)
self.openXianZhi=UIButton.get(self,3)
self.openXianZhiRoot=UIObject.get(self,4)
self.scrollView=UIObject.get(self,5)
self.shield=UIObject.get(self,6)
self.showModel_1=UIObject.get(self,7)
self.showModel_2=UIObject.get(self,8)
self.showModel_3=UIObject.get(self,9)
self.showModel_4=UIObject.get(self,10)
self.showModelRoot=UIObject.get(self,11)

self.lookBack:setButtonClick(function()self:onLookBack()end)

self.openXianZhi:setButtonClick(function()self:onOpenXianZhi()end)
self.showModel={
self.showModel_1,
self.showModel_2,
self.showModel_3,
self.showModel_4,
}



end


function UIZongMenXianTuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.lookBack);self.lookBack=nil;
_UIObject_release(self.openXianZhi);self.openXianZhi=nil;
_UIObject_release(self.openXianZhiRoot);self.openXianZhiRoot=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.shield);self.shield=nil;
_UIObject_release(self.showModel_1);self.showModel_1=nil;
_UIObject_release(self.showModel_2);self.showModel_2=nil;
_UIObject_release(self.showModel_3);self.showModel_3=nil;
_UIObject_release(self.showModel_4);self.showModel_4=nil;
_UIObject_release(self.showModelRoot);self.showModelRoot=nil;
self.showModel=nil;
end















local _this=nil
local _itemCmp={
owner=-1,
root=0,
name=1,
infoBg=2,
infoTx=3,
timeTx=4,
disciple=5,
reddot=6,
button=7,
road=8,
model=9,
effect=10,
road2=11,
}
local _fakeCmp={
root=-1,
model=0,
}
local _leftPos={
infoBg={320,0},
disciple={75,0},
discipleFlip=true,
name={-150,-34},
road={210,-185},
roadEnter=2102,
roadStand=2100,
nameSince={-200,-75},
}
local _rightPos={
infoBg={-283,0},
disciple={-75,0},
discipleFlip=false,
name={150,-34},
road={-210,-185},
roadEnter=2103,
roadStand=2101,
nameSince={200,-75},
}
local _enterDuration=3
local _roadSpine=4235
local _roadSpine2=4236
local _listBottom=235
local _listSpacing=390
local _ab="ui/windows/xiantuchengjiu/xiantuchengjiu_atlas_pak.ab"



function UIZongMenXianTuWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskChange)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskChange)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskChange)
notifySystem:listenNotify(notifyConfig.onZongMenXianTuReward,self.onZongMenXianTuReward)
notifySystem:listenNotify(notifyConfig.onZongMenXianTuStage,self.onZongMenXianTuStage)

self:refreshLookBack()
self:initList()

end


function UIZongMenXianTuWin:__delete()
self:endSheild()

if self.guideTweener and self.guideTweener:IsActive()then
self.guideTweener:Kill()
end

self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskChange)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskChange)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskChange)
notifySystem:removelistener(notifyConfig.onZongMenXianTuReward,self.onZongMenXianTuReward)
notifySystem:removelistener(notifyConfig.onZongMenXianTuStage,self.onZongMenXianTuStage)
end




function UIZongMenXianTuWin:onShow(argtable,afterOnloaded)




self:checkOpenAnimation()

self:refreshOpenXianZhi()
end


function UIZongMenXianTuWin:onHide()

end

function UIZongMenXianTuWin:onLostConnection()
self:endGuideAnimation()
self:pauseAllTimers()
end

function UIZongMenXianTuWin:onShowArgRecv()
self:refreshOpenXianZhi()
end





function UIZongMenXianTuWin:onLookBack()
UIFullXianTuChengJiuControl:showWindow("UIXianTuLookBackWin")
end

function UIZongMenXianTuWin:onOpenXianZhi()
local state=xianzhiModel:checkFirstOpenXianZhi()
if state then
xianzhiController:reqOpenXianZhi()
else
xianzhiModel:setReturnToZMXTFlag(false)
local openFunc=function()
UIFullXianTuChengJiuControl:showWindow_XianZhi()

UIManager:invokeUIMethod("UIXTCJForeGroundWin",'refreshMenu')
end
UIFullXianTuChengJiuControl:showWindowByCloud(openFunc)
end
end

function UIZongMenXianTuWin:refreshLookBack()
self.lookBack:setActive(false)
end

function UIZongMenXianTuWin:initList()
self.list={}
local initHeightIndex=0
local forceHeightIndex=nil
local lookup=cfg_lookupsectxiantuconfig()
for i,v in ipairs(lookup)do
self.list[i]=v[1]
if xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,v[1])then
initHeightIndex=i
if not forceHeightIndex and xiantuchengjiuModel:getZMXTReddot_Single(v[1])then
forceHeightIndex=i
end
end
end
table.sort(self.list)
self.content:setChildLayoutGroupCreateItems(#self.list,function(index)
self:initItem(index)
end)
local initIndex=forceHeightIndex or initHeightIndex
self.content:setChildAnchoredPos(0,(initIndex-1)*-_listSpacing)
end

function UIZongMenXianTuWin:resetContent()
local initHeightIndex=0
local forceHeightIndex=nil
local lookup=cfg_lookupsectxiantuconfig()
for i,v in ipairs(lookup)do
if xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,v[1])then
initHeightIndex=i
if not forceHeightIndex and xiantuchengjiuModel:getZMXTReddot_Single(v[1])then
forceHeightIndex=i
end
end
end
local initIndex=forceHeightIndex or initHeightIndex
self.content:setChildAnchoredPos(0,(initIndex-1)*-_listSpacing)
end

function UIZongMenXianTuWin:refreshView()
for i,v in ipairs(self.list)do
self:refreshItem(i)
end
end

function UIZongMenXianTuWin:initItem(index)
local item=self.content:getChildLayoutGroupGridItem(index-1)
if item==nil then return end
local id=self.list[index]
local cfg=cfgHelper.get1(cfg_sectxiantuconfig_get,id)
local data=xiantuchengjiuModel:getInfoData(eXianTuChengJiuTabType.ZongMenXianTu,id)
local posInfo=(index%2==0)and _leftPos or _rightPos
local opened=data~=nil
item:SetChildAnchoredPos(_itemCmp.owner,cfg.pos[1],cfg.pos[2])
item:SetChildAnchoredPos(_itemCmp.infoBg,posInfo.infoBg[1],posInfo.infoBg[2])
item:SetChildAnchoredPos(_itemCmp.disciple,posInfo.disciple[1],posInfo.disciple[2])
item:SetChildAnchoredPos(_itemCmp.name,posInfo.name[1],posInfo.name[2])
item:SetChildAnchoredPos(_itemCmp.road,posInfo.road[1],posInfo.road[2])
item:SetChildAnchoredPos(_itemCmp.road2,posInfo.road[1],posInfo.road[2])
item:SetChildActive(_itemCmp.infoBg,opened)
item:SetChildCSImageSprite(_itemCmp.name,_ab,cfg.image)
if api_Available_SetChildUIModelUpdateRendererSize()then
item:SetChildUIModelShowTarget(_itemCmp.model,cfg.spine,1,{},eAnimationID.stand,false,false,0)
item:SetChildUIModelUpdateRendererSize(_itemCmp.model,true)
else
local func=function()
self:delayDo(0.02,function()
local rt=item:GetCommonComponent(_itemCmp.model,'RectTransform')
local r=rt:GetChild(0):GetChild(0):GetChild(0)
for i=1,r.childCount do
local child=r:GetChild(i-1):GetComponent("RectTransform")
child.sizeDelta=Vector2.one*500
end
end)
end
item:SetChildUIModelShowTarget(_itemCmp.model,cfg.spine,1,{},eAnimationID.stand,false,false,0,func)
end

if api_Available_SetChildUIModelGray()then
item:SetChildUIModelGray(_itemCmp.model,not opened)
else
item:SetChildUIModelShowColor(_itemCmp.model,Color.gray)
end
item:SetChildButtonClick(_itemCmp.button,function()
self:onClickItem(index)
end)
item:SetChildActive(_itemCmp.reddot,xiantuchengjiuModel:getZMXTReddot_Single(id))
if cfg.hideStageAnim then
item:SetChildUIModelRemoveTarget(_itemCmp.road)
item:SetChildUIModelRemoveTarget(_itemCmp.road2)
else
item:SetChildUIModelShowTarget(_itemCmp.road,_roadSpine,1,{},posInfo.roadStand,false,false,0)
item:SetChildUIModelShowTarget(_itemCmp.road2,_roadSpine2,1,{},posInfo.roadStand,false,false,0)
end
if opened then
local dzData=data.disciple
local image=UIDiscipleModel.calculationDiscipleImage(dzData.data,dzData.image)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)
item:SetChildText(_itemCmp.infoTx,FMT.fmt(cfg.desc,dzData.name))
item:SetChildText(_itemCmp.timeTx,FMT.fmt(FMT.fmt("第{0}年",gameUtilityModel.getGameYearPass(data.opensec))))
item:SetChildUIModelShowTarget(_itemCmp.disciple,modelParams.body,0.7,modelParams.componets,eAnimationID.stand,false,false,0)
item:SetChildUIModelShowFlipX(_itemCmp.disciple,posInfo.discipleFlip)
else
item:SetChildUIModelRemoveTarget(_itemCmp.disciple)
end
item:SetChildNewBieComponentId(_itemCmp.button,FMT.fmt("UITianDaoShuWin.zmItem.{0}",index))
end

function UIZongMenXianTuWin:refreshItem(index)
local item=self.content:getChildLayoutGroupGridItem(index-1)
if item==nil then return end
local id=self.list[index]
local cfg=cfgHelper.get1(cfg_sectxiantuconfig_get,id)
local data=xiantuchengjiuModel:getInfoData(eXianTuChengJiuTabType.ZongMenXianTu,id)
local opened=data~=nil
item:SetChildActive(_itemCmp.infoBg,opened)
if api_Available_SetChildUIModelGray()then
item:SetChildUIModelGray(_itemCmp.model,not opened)
else
item:SetChildUIModelShowColor(_itemCmp.model,Color.gray)
end
item:SetChildActive(_itemCmp.reddot,xiantuchengjiuModel:getZMXTReddot_Single(id))
local posInfo=(index%2==0)and _leftPos or _rightPos
if opened then
local dzData=data.disciple
local image=UIDiscipleModel.calculationDiscipleImage(dzData.data,dzData.image)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)
item:SetChildText(_itemCmp.infoTx,FMT.fmt(cfg.desc,dzData.name))
item:SetChildText(_itemCmp.timeTx,FMT.fmt(FMT.fmt("第{0}年",gameUtilityModel.getGameYearPass(data.opensec))))
item:SetChildUIModelShowTarget(_itemCmp.disciple,modelParams.body,0.7,modelParams.componets,eAnimationID.stand,false,false,0)
item:SetChildUIModelShowFlipX(_itemCmp.disciple,posInfo.discipleFlip)
else
item:SetChildUIModelRemoveTarget(_itemCmp.disciple)
end
end

function UIZongMenXianTuWin:refreshItemByID(id)
local index=table.findValue(self.list,id)
self:refreshItem(index)
end

function UIZongMenXianTuWin:refreshItemReddotByKey(id)
local index=table.findValue(self.list,id)
local item=self.content:getChildLayoutGroupGridItem(index-1)
if item==nil then return end
item:SetChildActive(_itemCmp.reddot,xiantuchengjiuModel:getZMXTReddot_Single(id))
end

function UIZongMenXianTuWin:onClickItem(index)
local id=self.list[index]
local data=xiantuchengjiuModel:getInfoData(eXianTuChengJiuTabType.ZongMenXianTu,id)
if data then
UIFullXianTuChengJiuControl:showWindow("UIZongMenXianTuInfoWin",{id=id,next=self.list[index+1]})
else
local dzCount=UIDiscipleModel:getDiscipleJJCount(id)
local cfg=cfgHelper.get1(cfg_sectxiantuconfig_get,id)
if dzCount<=0 then
UIManager.error(FMT.fmt("弟子达到{0}境界后解锁{1}",UIDiscipleModel:getJJFloorNameEx(id),cfg.name))
else
local prev=self.list[index-1]
if prev then
local pCfg=cfgHelper.get1(cfg_sectxiantuconfig_get,prev)
UIManager.error(FMT.fmt("完成{0}进阶后解锁{1}",pCfg.name,cfg.name))
else
UIManager.error(FMT.fmt('系统未开启'))
end
end
end
end

function UIZongMenXianTuWin.onXianTuChengJiuSystemInit()
if _this.checkTick then return end
_this:refreshView()
end

function UIZongMenXianTuWin.onXianTuChengJiuTaskChange(list)
if _this.checkTick then return end
local keys={}
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.ZongMenXianTu then
keys[v[2]]=true
end
end
for i,v in pairs(keys)do
_this:refreshItemReddotByKey(i)
end
end

function UIZongMenXianTuWin.onZongMenXianTuReward(id)
if _this.checkTick then return end
_this:refreshItemReddotByKey(id)
end

function UIZongMenXianTuWin.onZongMenXianTuStage(id)
if _this.checkTick then return end
_this:refreshItemByID(id)
_this:startAnimation(id)
end

function UIZongMenXianTuWin:startAnimation(id,callback)

local index=table.findValue(self.list,id)
local data=xiantuchengjiuModel:getInfoData(eXianTuChengJiuTabType.ZongMenXianTu,id)
local cfg=cfgHelper.get1(cfg_sectxiantuconfig_get,id)

if index and data and not cfg.hideStageAnim then
for i=1,#self.list do
local item=self.content:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(_itemCmp.infoBg,false)
item:SetChildActive(_itemCmp.disciple,false)
end

self:startSheild()
UIManager:invokeUIMethod("UIZongMenXianTuInfoWin","startAnimation")
self.showModelRoot:setActive(true)
self.winlua:SetAsLastSibling(self.showModelRoot:getID())

local item=self.content:getChildLayoutGroupGridItem(index-1)

local lastCfg=cfgHelper.get1(cfg_sectxiantuconfig_get,self.list[index-1])
local contentPos=lastCfg.lookat
self.content:setChildAnchoredPos(0,math.min(contentPos,0))

local posInfo=(index%2==0)and _leftPos or _rightPos
local startPos=(index%2==0)and _rightPos or _leftPos
local dzData=data.disciple

local image=UIDiscipleModel.calculationDiscipleImage(dzData.data,dzData.image)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)
self.showModel_1:setChildUIModelShowTarget(modelParams.body,0.7,modelParams.componets,eAnimationID.stand,false,false,0)
self.showModel_1:setChildUIModelMount(1110011,{},nil,1.2,Vector3.zero,nil)
self.showModel_1:setChildUIModelShowFlipX(not posInfo.discipleFlip)
self.showModel_1:setChildAnchoredPos(lastCfg.pos[1]+startPos.disciple[1],lastCfg.pos[2])
self.showModel_1:setChildDOAnchorPos(Vector2.New(posInfo.disciple[1]+cfg.pos[1],cfg.pos[2]),_enterDuration,function()
UIManager:invokeUIMethod("UIZongMenXianTuInfoWin","endAnimation")
self.showModelRoot:setActive(false)
for i=1,#self.list do
local item=self.content:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(_itemCmp.infoBg,xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,self.list[i]))
item:SetChildActive(_itemCmp.disciple,true)
end
self:endSheild()
xiantuchengjiuModel:markAnimationRecord(id)
reddotControl.on_change_catch_type(CATCH_TYPE.eZongMenXianTuAnimation)
notifySystem:postNotify(notifyConfig.onZongMenXianTuAnimation,id)
if callback then
callback()
end
end)
else
xiantuchengjiuModel:markAnimationRecord(id)
reddotControl.on_change_catch_type(CATCH_TYPE.eZongMenXianTuAnimation)
notifySystem:postNotify(notifyConfig.onZongMenXianTuAnimation,id)
if callback then
callback()
end
end
end











function UIZongMenXianTuWin:startGuideAnimation(bt,key)
self.animBt=bt
self.animFlag=key
self:startSheild()

local sequence0=Lua.SequenceProxy.New()

local sequence1=Lua.SequenceProxy.New()

local sequence2=Lua.SequenceProxy.New()

local sequence3=Lua.SequenceProxy.New()

local sequence4=Lua.SequenceProxy.New()
for i,v in ipairs(self.list)do
local item=self.content:getChildLayoutGroupGridItem(i-1)
local config=cfgHelper.get1(cfg_sectxiantuconfig_get,v)
local posInfo=(i%2==0)and _leftPos or _rightPos
local tweener1=self.content:setChildDOAnchorPosY(config.lookat,2)
tweener1:SetEase(DG.Tweening.Ease.Linear)
sequence1:Append(tweener1)


local posVec=mathHelper.convertArrayToVector(config.pos)
local tweener6=self.effect:setChildDOAnchorPos(posVec,2)
sequence1:Join(tweener6)

local tweener2=item:SetChildDOAnchorPosY(_itemCmp.model,0,1)
if i>2 then
sequence2:AppendInterval(1)
end
sequence2:AppendCallback(function()
item:SetChildShowEffect(_itemCmp.effect,10322,true)

AudioManager.playAudio(605)
end)
sequence2:Append(tweener2)

local tweener3=item:SetChildCanvasGroupDOFade(_itemCmp.name,1,6/30)
local tweener4=item:SetChildDOScale(_itemCmp.name,1,6/30)
sequence4:AppendInterval(config.imageWait/30)
sequence4:Append(tweener3)
sequence4:Join(tweener4)

if not config.hideStageAnim then
sequence3:AppendCallback(function()
item:SetChildActive(_itemCmp.road,true)
item:SetChildActive(_itemCmp.road2,true)
item:SetChildModelAnimationState(_itemCmp.road,posInfo.roadEnter)
item:SetChildModelAnimationState(_itemCmp.road2,posInfo.roadEnter)
end)
local tweener5=item:SetChildCanvasGroupDOFade(_itemCmp.road2,107/255,10/30)
tweener5:SetEase(DG.Tweening.Ease.Linear)
local tweener6=item:SetChildCanvasGroupDOFade(_itemCmp.road2,0,20/30)
tweener6:SetEase(DG.Tweening.Ease.Linear)
local tweener7=item:SetChildCanvasGroupDOFade(_itemCmp.road,1,1)
tweener7:SetEase(DG.Tweening.Ease.Linear)

local seq_1=Lua.SequenceProxy.New()
seq_1:Append(tweener5)
seq_1:AppendInterval(20/30)
seq_1:Append(tweener6)
seq_1:AppendInterval(10/30)

local seq_2=Lua.SequenceProxy.New()
seq_2:AppendInterval(1)
seq_2:Append(tweener7)

sequence3:Append(seq_1)
sequence3:Join(seq_2)
end
end
sequence3:AppendCallback(function()

AudioManager.playAudio(607)
end)

sequence1:AppendCallback(function()

AudioManager.playAudio(606)
end)
local sizeY=self.content:getChildSizeDeltaY()
local screenY=self.shield:getChildRectHeight()
local tweener0=self.content:setChildDOAnchorPosY(-sizeY+screenY,2)
sequence1:Append(tweener0)
sequence1:AppendInterval(1.5)

local onFlag=function()
if self.animBt and self.animBt:isRuning()then
self.animBt:setSharedVar(self.animFlag,true)
end
end
local onFinish=function()
self.content:setChildAnchoredPos(0,0)
self:endGuideAnimation()
end
sequence0:Join(sequence1)
sequence0:Join(sequence2)
sequence0:Join(sequence3)
sequence0:Join(sequence4)
sequence0:AppendCallback(onFlag)
sequence0:AppendInterval(0.5)
sequence0:AppendCallback(onFinish)
self.guideTweener=sequence0
end

function UIZongMenXianTuWin:initGuideAnimation()
UIManager:invokeUIMethod("UIXTCJForeGroundWin","setRootVisible",false)
self:hideLookBack()
self:hideOpenXianZhi()
self.shield:setActive(true)
for i,v in ipairs(self.list)do
local item=self.content:getChildLayoutGroupGridItem(i-1)
local config=cfgHelper.get1(cfg_sectxiantuconfig_get,v)
local posInfo=(i%2==0)and _leftPos or _rightPos
item:SetChildAnchoredPos(_itemCmp.model,0,-350)
item:SetChildActive(_itemCmp.infoBg,false)
item:SetChildActive(_itemCmp.reddot,false)
item:SetChildActive(_itemCmp.disciple,false)
item:SetChildCanvasGroupAlpha(_itemCmp.name,0)
item:SetChildScale(_itemCmp.name,Vector3.one*1.6)
item:SetChildActive(_itemCmp.road,false)
item:SetChildActive(_itemCmp.road2,false)
item:SetChildCanvasGroupAlpha(_itemCmp.road,0)
item:SetChildCanvasGroupAlpha(_itemCmp.road2,0)
if api_Available_SetChildUIModelGray()then
item:SetChildUIModelGray(_itemCmp.model,false)
else
item:SetChildUIModelShowColor(_itemCmp.model,Color.white)
end
end
self.content:setChildAnchoredPos(0,0)
self.effect:setChildAnchoredPos(0,0)

end

function UIZongMenXianTuWin:hideLookBack()
self.lookBack:setActive(false)
end

function UIZongMenXianTuWin:hideOpenXianZhi()
self.openXianZhiRoot:setActive(false)
end

function UIZongMenXianTuWin:refreshOpenXianZhi()
local state=xianzhiModel:checkFirstOpenXianZhi()
local isReturn=xianzhiModel:getReturnToZMXTFlag()
self.openXianZhiRoot:setActive(state or isReturn)

if state then
self.scrollView:setChildScrollRectEnable(false)
self.openXianZhi:setChildShowEffect(20431,true)
elseif isReturn then
self.openXianZhi:setChildShowEffect(20458,true)
self.scrollView:setChildScrollRectEnable(true)
end
if state then
self.content:setChildAnchoredPos(0,-3550)
end
end

function UIZongMenXianTuWin:endGuideAnimation()
UIManager:invokeUIMethod("UIXTCJForeGroundWin","setRootVisible",true)
self:refreshLookBack()
self:refreshOpenXianZhi()
self:endSheild()

for i,v in ipairs(self.list)do
local item=self.content:getChildLayoutGroupGridItem(i-1)
item:SetChildAnchoredPos(_itemCmp.model,0,0)
item:SetChildActive(_itemCmp.disciple,true)
item:SetChildCanvasGroupAlpha(_itemCmp.name,1)
self:refreshItem(i)
end
end

function UIZongMenXianTuWin:startSheild()
self.shield:setActive(true)
if self.checkTick then
self:stopTimerByID(self.checkTick)
self.checkTick=nil
end
self.checkTick=self:delayDo(30,function()
self:endGuideAnimation()
end)
end

function UIZongMenXianTuWin:endSheild()
self.shield:setActive(false)
if self.checkTick then
self:stopTimerByID(self.checkTick)
self.checkTick=nil
end
end

function UIZongMenXianTuWin:checkOpenAnimation()
local lookup=cfg_lookupsectxiantuconfig()
for i=#lookup,1,-1 do
local key=lookup[i][1]
if xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,key)and not xiantuchengjiuModel:getAnimationRecord(key)then
self:startAnimation(key)
return
end
end
end


function UIZongMenXianTuWin.test_playGuideAnimation()
_this:initGuideAnimation()
_this:startGuideAnimation()
end
