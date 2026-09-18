







def_class("UIXingYuTanSuoWin",UIWindowBase)









function UIXingYuTanSuoWin:bindComponents()

self.searchIconItem_1=UIObject.get(self,0)
self.searchIconItem_2=UIObject.get(self,1)
self.searchIconItem_3=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.titleBg=UIObject.get(self,4)
self.ruleBtn=UIButton.get(self,5)
self.closeTx=UIText.get(self,6)
self.bgModel=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.tipClick=UIButton.get(self,9)
self.maskbg=UIObject.get(self,10)
self.bgEffect=UIObject.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.tipClick:setButtonClick(function()self:onTipClick()end)
self.searchIconItem={
self.searchIconItem_1,
self.searchIconItem_2,
self.searchIconItem_3,
}



end


function UIXingYuTanSuoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.searchIconItem_1);self.searchIconItem_1=nil;
_UIObject_release(self.searchIconItem_2);self.searchIconItem_2=nil;
_UIObject_release(self.searchIconItem_3);self.searchIconItem_3=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.closeTx);self.closeTx=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipClick);self.tipClick=nil;
_UIObject_release(self.maskbg);self.maskbg=nil;
_UIObject_release(self.bgEffect);self.bgEffect=nil;
self.searchIconItem=nil;
end















local teamabName="ui/windows/huanjing/huanjing_atlas_pak.ab"
local teamAssetName={
"icon_duibiao_1",
"icon_duibiao_2",
"icon_duibiao_3"
}



function UIXingYuTanSuoWin:onLoaded(...)
self:bindComponents()
self.root:setChildCanvasGroupAlpha(0)

end


function UIXingYuTanSuoWin:__delete()
self:stopTimer()
self:killAllTween()
self:unbindComponents()
end




function UIXingYuTanSuoWin:onShow(argtable,afterOnloaded)
local xyId=argtable.xyId
self:refreshView(xyId,afterOnloaded)
end


function UIXingYuTanSuoWin:onHide()

end

function UIXingYuTanSuoWin:refreshView(xyId,afterOnloaded)
self.xyId=xyId

local xyCfg=XingYuModel:getXingYuConfig(xyId)
self.closeTx:setText(xyCfg.name)

if not XingYuController.checkHasTeam(xyId)then
logErr("没有派遣队伍打开探索界面")
return
end
self:killAllTween()
self.animList={}
local func=function()
local teamGuidList=XingYuModel:getXingYuData_teamGuidList(xyId)
for i,v in ipairs(self.searchIconItem)do
local guidList=teamGuidList[i]
if guidList then
local firstFlag=XingYuController:getFirstPaiQianFlag(xyId)
table.insert(self.animList,{teamIndex=i,item=v,sFlag=0,firstFlag=firstFlag})
v:setActive(true)
local widget=v:getWidgetBase()
local fDzGuid
local fight=0
for ii,guid in ipairs(guidList)do
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local _fight=mathHelper.int64_to_number(netdata.fightvalue)
if _fight>fight then
fight=_fight
fDzGuid=guid
end
end
local headshot=widget:GetChildWidgetBase(0)
local netdata=UIDiscipleModel:getDiscipleDataX(fDzGuid).netData.net
local dzId=netdata.id
local isSpDz=UIDiscipleModel:isSPDisciple(dzId)
local switchidx
if isSpDz then
local netDzId=XingYuModel:getXingYuData_teamListDzId(xyId,fDzGuid)
if netDzId and netDzId~=dzId then
switchidx=1
end
end

local image=UIDiscipleModel.calculationDiscipleImageBase(netdata,switchidx)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headshot,modelParams,eHeadCenterType.eHead,nil,false)




local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)

comHelper.setChildModelHeadIconBGByColor(headshot,0,color)



widget:SetChildCSImageSprite(1,teamabName,teamAssetName[i])
widget:SetChildButtonClick(3,function()
XingYuController.req_35_105(xyId)
end)
else
v:setActive(false)
end
end
XingYuController:setFirstPaiQianList(xyId,false)
self:startTimer(function()
self:update()
end)
self:update()
end
local tsmodel=xyCfg.tsmodel
local effectid=xyCfg.tsBgEffect
if afterOnloaded then
if effectid then
self.bgModelTweener=self.maskbg:setChildCanvasGroupDOFade(0,0.2,function()
if self and self.isClose then return end
self.bgModel:setChildUIModelRemoveTarget()
self.root:setChildCanvasGroupAlpha(1)
end)
self.bgEffect:setChildShowEffect(effectid,true)
else
self.bgEffect:setChildShowEffect(-1,false)
self.maskbg:setChildCanvasGroupAlpha(1)
self.bgModelTweener=self.bgModel:setChildUIModelShowTarget(tsmodel,1,nil,eAnimationID.enter,false,false,0,function()
if self and self.isClose then return end
self.root:setChildCanvasGroupAlpha(1)
self.winlua:SetChildUIModelAnimationSpeed(self.bgModel:getID(),0.5)
end)
end

func()
else
if effectid then
self.rootTweener=self.root:setChildCanvasGroupDOFade(0,0.2,function()
func()
self.rootTweener=self.root:setChildCanvasGroupDOFade(1,0.2)
end)
self.bgModelTweener=self.maskbg:setChildCanvasGroupDOFade(1,0.2,function()
if self and self.isClose then return end
self.bgModel:setChildUIModelRemoveTarget()
self.bgModelTweener=self.maskbg:setChildCanvasGroupDOFade(0,0.2)
end)

self.bgEffect:setChildShowEffect(effectid,true)
else
self.bgEffect:setChildShowEffect(-1,false)
self.maskbg:setChildCanvasGroupAlpha(1)
self.rootTweener=self.root:setChildCanvasGroupDOFade(0,0.2,function()
func()
self.rootTweener=self.root:setChildCanvasGroupDOFade(1,0.2)
end)
self.bgModelTweener=self.bgModel:setChildCanvasGroupDOFade(0,0.2,function()
if self and self.isClose then return end
self.bgModel:setChildUIModelShowTarget(tsmodel,1,nil,eAnimationID.stand)
self.winlua:SetChildUIModelAnimationSpeed(self.bgModel:getID(),0.5)
self.bgModelTweener=self.bgModel:setChildCanvasGroupDOFade(1,0.2)
end)
end
















end

end

local posList={
{x=-343,y=134,w=100,h=25,pr=3,rSmoveTime=10,rEmoveTime=15,waitTime=3},
{x=-140,y=-164,w=100,h=25,pr=3,rSmoveTime=10,rEmoveTime=15,waitTime=3},
{x=435,y=-20,w=100,h=25,pr=3,rSmoveTime=10,rEmoveTime=15,waitTime=3},
}
local modelIdList={5664,5665,5666}
local weights={6,2,1}
local totalWeight=0
for _,weight in ipairs(weights)do
totalWeight=totalWeight+weight
end
function UIXingYuTanSuoWin:update()
if not self.animList or not next(self.animList)then
return
end
math.randomseed(os.time())
local changePos=self.xyId~=self.lastxyId
self.lastxyId=self.xyId
for i,teamp in ipairs(self.animList)do
if teamp.sFlag==0 then
local posCfg=posList[teamp.teamIndex]
local posX=posCfg.x
local posY=posCfg.y
if changePos then
local x=posX+math.random(-posCfg.pr,posCfg.pr)
local y=posY+math.random(-posCfg.pr,posCfg.pr)
teamp.item:setChildAnchoredPos(x,y)
end
local tx=posX+math.random(-posCfg.w,posCfg.w)
local ty=posY+math.random(-posCfg.h,posCfg.h)
local tPos=Vector2.New(tx,ty)
local mT=math.random(posCfg.rSmoveTime,posCfg.rEmoveTime)
teamp.tweener=teamp.item:setChildDOAnchorPos(tPos,mT)
teamp.finishFlag=mT+math.random(1,posCfg.waitTime)
end

if teamp.sFlag==teamp.finishFlag then
teamp.sFlag=0
else
teamp.sFlag=teamp.sFlag+1
end
if not teamp.eFlag or teamp.eCnt==0 then
teamp.eCnt=0
math.randomseed(os.time()*teamp.teamIndex*1000)
teamp.eFlag=math.random(5,20)

end
if teamp.eCnt==teamp.eFlag or teamp.firstFlag then

if teamp.tweener then
teamp.tweener:Kill(false)
teamp.tweener=nil
end
local widget=teamp.item:getWidgetBase()

local randomValue=math.random()*totalWeight


local modelId
for i,weight in ipairs(weights)do
randomValue=randomValue-weight
if randomValue<=0 then
modelId=modelIdList[i]
break
end
end
if teamp.firstFlag then
modelId=5664
teamp.firstFlag=false
end


widget:SetChildUIModelShowTarget(4,modelId,1,nil,2306,false,false,0,function()
if self and self.isClose then return end





teamp.eCnt=-5



self:delayDo(2.5,function()
if self and self.isClose then return end
UIManager:invokeUIMethod("UIXingYuMainWin","GetReward",teamp.teamIndex)
end)
end)

else
teamp.eCnt=teamp.eCnt+1
end
end

end

function UIXingYuTanSuoWin:killAllTween()
if self.bgModelTweener then
self.bgModelTweener:Kill(false)
self.bgModelTweener=nil
end
if self.rootTweener then
self.rootTweener:Kill(false)
self.rootTweener=nil
end
if not self.animList or not next(self.animList)then
return
end
for i,teamp in ipairs(self.animList)do
if teamp.tweener then
teamp.tweener:Kill(false)
teamp.tweener=nil
end
if teamp.item then
teamp.item:getWidgetBase():SetChildUIModelRemoveTarget(4)
end
end
self.animList=nil
end


function UIXingYuTanSuoWin:stopTimer()
if self._timer then
self:stopTimerByID(self._timer)
self._timer=nil
end
end

function UIXingYuTanSuoWin:startTimer(func)
self:stopTimer()
self._timer=self:setTimer(1,0,func)
end



function UIXingYuTanSuoWin:getEffectCfgList(teamIndex)
if not self.animList or not next(self.animList)then
return
end
local list={}
for i,teamp in ipairs(self.animList)do
local Position=teamp.item:getChildPosition()

if teamIndex then
if teamIndex==teamp.teamIndex then
Position.y=Position.y+1.8
table.insert(list,{sPos=Position})
break
end
else
table.insert(list,{sPos=Position})
end

end
return list
end





function UIXingYuTanSuoWin:onRuleBtn()





local args={
ruleGroupID=ruleTipsImageGroup.eXingYu,
}
self:showWindow("UIRuleTipsImage2Win",args)
end

function UIXingYuTanSuoWin:onCloseBtn()
if UIFullXingYuController.fightStage then
UIFullXingYuController.fightStage:close()
UIFullXingYuController.fightStage=nil
end
UIFullXingYuController:closeUI()
end

function UIXingYuTanSuoWin:onTipClick()
if not self.xyId then
return
end
local state,endTime=XingYuController.getXingYuState(self.xyId)
if state~=XingYuState.eTanSuo then
return
end
local curTime=timeHelper.getServerShortTime()
local lerp=endTime-curTime
local timeStr=timeHelper.format_time_stamp3(lerp)
UIManager.info(FMT.fmt("<color=#ca631d>{0}</color>后开启混战",timeStr))
end
