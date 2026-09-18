







def_class("UIWorldFuncStorageWin",UIWindowBase)









function UIWorldFuncStorageWin:bindComponents()

self.root=UIObject.get(self,0)
self.funcList=UIObject.get(self,1)
self.funcListbtn=UIButton.get(self,2)
self.funcBtn_SystemZongMenLetter=UIButton.get(self,3)
self.funcBtn_SystemZongMenSG=UIButton.get(self,4)
self.funcBtn_SystemZongMenSurrender=UIButton.get(self,5)
self.funcBtn_SystemZongMenFight=UIButton.get(self,6)
self.funcBtn_ZaWuBu=UIButton.get(self,7)
self.funcBtn_PaiQianLu=UIButton.get(self,8)
self.funcListbtnselect=UIObject.get(self,9)
self.funcListReddot=UIObject.get(self,10)

self.funcListbtn:setButtonClick(function()self:onFuncListbtn()end)

self.funcBtn_SystemZongMenLetter:setButtonClick(function()self:onFuncBtn_SystemZongMenLetter()end)

self.funcBtn_SystemZongMenSG:setButtonClick(function()self:onFuncBtn_SystemZongMenSG()end)

self.funcBtn_SystemZongMenSurrender:setButtonClick(function()self:onFuncBtn_SystemZongMenSurrender()end)

self.funcBtn_SystemZongMenFight:setButtonClick(function()self:onFuncBtn_SystemZongMenFight()end)

self.funcBtn_ZaWuBu:setButtonClick(function()self:onFuncBtn_ZaWuBu()end)

self.funcBtn_PaiQianLu:setButtonClick(function()self:onFuncBtn_PaiQianLu()end)
self.funcBtn={
["SystemZongMenLetter"]=self.funcBtn_SystemZongMenLetter,
["SystemZongMenSG"]=self.funcBtn_SystemZongMenSG,
["SystemZongMenSurrender"]=self.funcBtn_SystemZongMenSurrender,
["SystemZongMenFight"]=self.funcBtn_SystemZongMenFight,
["ZaWuBu"]=self.funcBtn_ZaWuBu,
["PaiQianLu"]=self.funcBtn_PaiQianLu,
}



end


function UIWorldFuncStorageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.funcList);self.funcList=nil;
_UIObject_release(self.funcListbtn);self.funcListbtn=nil;
_UIObject_release(self.funcBtn_SystemZongMenLetter);self.funcBtn_SystemZongMenLetter=nil;
_UIObject_release(self.funcBtn_SystemZongMenSG);self.funcBtn_SystemZongMenSG=nil;
_UIObject_release(self.funcBtn_SystemZongMenSurrender);self.funcBtn_SystemZongMenSurrender=nil;
_UIObject_release(self.funcBtn_SystemZongMenFight);self.funcBtn_SystemZongMenFight=nil;
_UIObject_release(self.funcBtn_ZaWuBu);self.funcBtn_ZaWuBu=nil;
_UIObject_release(self.funcBtn_PaiQianLu);self.funcBtn_PaiQianLu=nil;
_UIObject_release(self.funcListbtnselect);self.funcListbtnselect=nil;
_UIObject_release(self.funcListReddot);self.funcListReddot=nil;
self.funcBtn=nil;
end















local _this=nil



function UIWorldFuncStorageWin:onLoaded(...)
self:bindComponents()
_this=self

self.bShowFuncList=true

self:addNotify(notifyConfig.onWorldCameraStateChanged,self.onWorldCameraStateChanged)
self:addNotify(notifyConfig.on_system_open,self.on_system_open)
self:addNotify(notifyConfig.onWorldFightRecordChanged,self.on_paiqian_change)
self:addNotify(notifyConfig.onSystemZMFightRecordNew,self.onSystemZMFightRecordNew)
self:addNotify(notifyConfig.onSystemZMFightResultNew,self.onSystemZMFightResultNew)
self:addNotify(notifyConfig.onSystemZMFightWaitResultNew,self.onSystemZMFightWaitResultNew)
self:addNotify(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)
self:addNotify(notifyConfig.onSystemZMVassalRewardChange,self.onSystemZMVassalRewardChange)
self:addNotify(notifyConfig.onSystemZMInit,self.onSystemZMInit)
self:addNotify(notifyConfig.onSystemZMLetterChange,self.onSystemZMLetterChange)
end


function UIWorldFuncStorageWin:__delete()
self:doPunchRotation(false)
self:clearTweener_AllBtn()
self:stopSystemZongMenFightCDTimer()
self:clearFLTweener()
self:unbindComponents()
_this=nil
end




function UIWorldFuncStorageWin:onShow(argtable,afterOnloaded)
self:refresh()
self:refreshReddot()
end


function UIWorldFuncStorageWin:onHide()
self:doPunchRotation(false)
self:clearTweener_AllBtn()
end




function UIWorldFuncStorageWin:onFuncListbtn()
self:changeFuncListShow(not self.bShowFuncList)
end

function UIWorldFuncStorageWin:clearFLTweener()
if self.flTweener then
self.flTweener:Kill()
self.flTweener=nil
end
end

function UIWorldFuncStorageWin:changeFuncListShow(isShow)
if self.bShowFuncList==isShow then
return
end

self:clearFLTweener()
if isShow then
self.funcList:setActive(true)
self.flTweener=self.funcList:setChildCanvasGroupDOFade(1,0.5,nil)
self.funcListReddot:setActive(false)
else
self.flTweener=self.funcList:setChildCanvasGroupDOFade(0,0.5,function()
self.funcList:setActive(false)
end)
end
self.bShowFuncList=isShow
self.funcListbtnselect:setActive(self.bShowFuncList)

self:refresh()
if not self.bShowFuncList then
self:refreshReddot()
end
end

function UIWorldFuncStorageWin:doPunchRotation(reddot)
if webGLHelper:isHidePunchAni()then return end
if reddot then
if self.reddotTweener==nil then
self.funcListReddot:setRotation(0,0,0)
local tweener=self.funcListReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.funcListReddot:setRotation(0,0,0)
end
end
end

function UIWorldFuncStorageWin:doPunchRotation_Btn(widgetId,btnWidget,index,reddot)
if not self.reddotTweener_BtnList then
self.reddotTweener_BtnList={}
end

if reddot then
if self.reddotTweener_BtnList[widgetId]==nil then
btnWidget:SetChildRotation(index,0,0,0)
local tweener=btnWidget:SetChildDOPunchRotation(index,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener_BtnList[widgetId]={}
self.reddotTweener_BtnList[widgetId].tweener=tweener
self.reddotTweener_BtnList[widgetId].cmpIndex=index
self.reddotTweener_BtnList[widgetId].btnWidget=btnWidget
btnWidget:SetChildActive(index,true)
end
else
if self.reddotTweener_BtnList[widgetId]~=nil then
btnWidget:SetChildActive(index,false)
local tweener=self.reddotTweener_BtnList[widgetId].tweener
tweener:Complete()
tweener:Kill()
self.reddotTweener_BtnList[widgetId]=nil
btnWidget:SetChildRotation(index,0,0,0)
end
end
end

function UIWorldFuncStorageWin:clearTweener_AllBtn()
if not self.reddotTweener_BtnList then
return
end

for widgetId,v in pairs(self.reddotTweener_BtnList)do
local tweener=v.tweener
local cmpIndex=v.cmpIndex
local btnWidget=v.btnWidget
btnWidget:SetChildActive(cmpIndex,false)
tweener:Complete()
tweener:Kill()
btnWidget:SetChildRotation(cmpIndex,0,0,0)
self.reddotTweener_BtnList[widgetId]=nil
end
end

function UIWorldFuncStorageWin:checkReddot()
for name,btn in pairs(self.funcBtn)do
if self.showBtns[name]then
local funcName=FMT.fmt("check{0}Reddot",name)
local func=self[funcName]
if func and func(self)then
return true
end
end
end
return false
end

function UIWorldFuncStorageWin:refreshReddot()
if self.showRoot and not self.bShowFuncList then
local isReddot=self:checkReddot()
self.funcListReddot:setActive(isReddot)
self:doPunchRotation(isReddot)
end
end

function UIWorldFuncStorageWin:refresh()
local inScene=worldExperienceModel:checkScene()
if inScene then
self.root:setActive(false)
self.showRoot=false
return
end

self.showBtns={}
for name,btn in pairs(self.funcBtn)do
local refreshName=FMT.fmt("refresh{0}",name)
local show=self[refreshName](self)
if show then
self.showBtns[name]=true
end
end
self.showRoot=next(self.showBtns)~=nil
self.root:setActive(self.showRoot)
end

function UIWorldFuncStorageWin:refreshFuncButton(name)
if self.showRoot then
local refreshName=FMT.fmt("refresh{0}",name)
local show=self[refreshName](self)
self.showBtns[name]=show or nil

local showRoot=next(self.showBtns)~=nil
self.root:setActive(showRoot)

if showRoot and not self.bShowFuncList then
self:refreshReddot()
end
end
end

function UIWorldFuncStorageWin:refreshFuncButtons(names)
if self.showRoot then
for idx,name in ipairs(names)do
local refreshName=FMT.fmt("refresh{0}",name)
local show=self[refreshName](self)
self.showBtns[name]=show or nil
end

local showRoot=next(self.showBtns)~=nil
self.root:setActive(showRoot)

if showRoot and not self.bShowFuncList then
self:refreshReddot()
end
end
end

function UIWorldFuncStorageWin.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eDispatchRecord then
_this:refreshFuncButton("PaiQianLu")
elseif sysId==SYSTEM_DEFINE.eXiTongZongMenZhanDou then
_this:refreshFuncButtons({"SystemZongMenFight","SystemZongMenSG"})
elseif sysId==SYSTEM_DEFINE.eJianZhuTiShi then
_this:refreshFuncButton("ZaWuBu")
end
end

function UIWorldFuncStorageWin.onWorldCameraStateChanged(state,oldState)
if state~=oldState and(state==eWorldCameraState.Experience or oldState==eWorldCameraState.Experience)then
_this:refresh()
_this:refreshReddot()
end
end

function UIWorldFuncStorageWin.onSystemZMInit()
_this:refreshFuncButtons({"SystemZongMenFight","SystemZongMenSG"})
end

function UIWorldFuncStorageWin:onFuncBtn_PaiQianLu()
UIManager:showWindow("UIWorldFightRecordWin")
end

function UIWorldFuncStorageWin:refreshPaiQianLu()
local check=systemModel.isOpen(SYSTEM_DEFINE.eDispatchRecord)
self.funcBtn_PaiQianLu:setActive(check)
if not check then
return false
end
local num=worldFightRecordModel:getNewRecordCount()
local widget=self.funcBtn_PaiQianLu:getChildWidgetBase()
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
return true
end

function UIWorldFuncStorageWin.on_paiqian_change()
_this:refreshFuncButton("PaiQianLu")
end

function UIWorldFuncStorageWin:checkPaiQianLuReddot()

local check=systemModel.isOpen(SYSTEM_DEFINE.eDispatchRecord)
if check then
local num=worldFightRecordModel:getNewRecordCount()
if num>0 then
return true
end
end
return false
end


function UIWorldFuncStorageWin:onFuncBtn_SystemZongMenFight()
local temp=self.systemZongMenPlayFight
if temp then
systemZongMenController:playFightBattle(temp,true)
else
local width=self.funcList:getChildSizeDeltaX()
local listPos=self.funcList:getChildAnchoredPosition()
local btnPos=self.funcBtn_SystemZongMenFight:getChildAnchoredPosition()
listPos.x=listPos.x-width+btnPos.x-10
if self.systemZongMenFlagType==systemZongMenFightFlagType.eBeAttacked then
UIManager:showWindow("UISystemZongMenFightingAttackWin",{arrow=listPos})
elseif self.systemZongMenFlagType==systemZongMenFightFlagType.eAttacking then
UIManager:showWindow("UISystemZongMenFightingDefenseWin",{arrow=listPos})
else
UIManager.error("暂无战况")
end
end
end

function UIWorldFuncStorageWin:refreshSystemZongMenFight()



self.systemZongMenPlayFight=nil
self.systemZongMenFlagType=nil
if not systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)then
self.funcBtn_SystemZongMenFight:setActive(false)
return false
end

local widget=self.funcBtn_SystemZongMenFight:getChildWidgetBase()

local resultList=systemZongMenModel:getAllWaitNotifyResult()
if next(resultList)~=nil then
self.funcBtn_SystemZongMenFight:setActive(true)
self:stopSystemZongMenFightCDTimer()

local temp=nil
for key,data in pairs(resultList)do
if data.teamIndex==0 then
self.systemZongMenFlagType=systemZongMenFightFlagType.eAttacking
self.systemZongMenPlayFight=key
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_2")
widget:SetChildText(1,"<color=#BC4F4F>队伍战斗中</color>")
return true
else
temp=key
end
end

if temp then
self.systemZongMenFlagType=systemZongMenFightFlagType.eBeAttacked
self.systemZongMenPlayFight=temp
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_1")
widget:SetChildText(1,"<color=#BC4F4F>队伍战斗中</color>")

else
self.systemZongMenFlagType=systemZongMenFightFlagType.eNone
widget:SetChildCSImageIcon(0,"",true)
widget:SetChildText(1,"战况")
end
return true
end


local teamList=systemZongMenModel:getAllBattleWaitResult()
if#teamList>0 then
self.funcBtn_SystemZongMenFight:setActive(true)

local firstStamp=nil
for index,data in ipairs(teamList)do
if data.teamIndex==0 then
self.systemZongMenFlagType=systemZongMenFightFlagType.eAttacking
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_2")
self.systemZongMenFightDeadline=data.gameStamp
self:startSystemZongMenFightCDTimer()
return true
else
firstStamp=firstStamp and math.min(firstStamp,data.gameStamp)or data.gameStamp
end
end

if firstStamp then
self.systemZongMenFlagType=systemZongMenFightFlagType.eBeAttacked
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_1")
self.systemZongMenFightDeadline=firstStamp
self:startSystemZongMenFightCDTimer()

else
self.systemZongMenFlagType=systemZongMenFightFlagType.eNone
self:stopSystemZongMenFightCDTimer()
widget:SetChildCSImageIcon(0,"",true)
widget:SetChildText(1,"战况")
end
return true
end


local attackFlag=systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eBeAttacked)
local defenseFlag=systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eAttacking)
local haveFight=attackFlag or defenseFlag
self.funcBtn_SystemZongMenFight:setActive(haveFight)
if attackFlag then
self.systemZongMenFlagType=systemZongMenFightFlagType.eBeAttacked
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_1")
widget:SetChildText(1,"未派遣队伍")

elseif defenseFlag then
self.systemZongMenFlagType=systemZongMenFightFlagType.eAttacking
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_2")
widget:SetChildText(1,"宗门来袭")
else
self.systemZongMenFlagType=systemZongMenFightFlagType.eNone
widget:SetChildCSImageIcon(0,"",true)
widget:SetChildText(1,"战况")
end
self:stopSystemZongMenFightCDTimer()
return haveFight
end

function UIWorldFuncStorageWin:startSystemZongMenFightCDTimer()
if not self.systemZongMenFightCDTimer then
if self:updateSystemZongMenFightCDTimer()then
self.systemZongMenFightCDTimer=self:setTimer(1,0,function()
if not self:updateSystemZongMenFightCDTimer()then
self:stopSystemZongMenFightCDTimer()
end
end)
end
end
end

function UIWorldFuncStorageWin:stopSystemZongMenFightCDTimer()
if self.systemZongMenFightCDTimer then
self:stopTimerByID(self.systemZongMenFightCDTimer)
self.systemZongMenFightCDTimer=nil
end
end

function UIWorldFuncStorageWin:updateSystemZongMenFightCDTimer()
local widget=self.funcBtn_SystemZongMenFight:getChildWidgetBase()
local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.systemZongMenFightDeadline-nowTime
if deltaTime<0 then

widget:SetChildText(1,"<color=#BC4F4F>即将战斗</color>")
return false
else
local str=FMT.fmt("<color=#94C547>{0}</color>到达",timeHelper.format_time_stamp(deltaTime,true))
widget:SetChildText(1,str)
return true
end
end

function UIWorldFuncStorageWin.onSystemZMFightRecordNew()
_this:refreshFuncButton("SystemZongMenFight")
end

function UIWorldFuncStorageWin.onSystemZMFightResultNew()
_this:refreshFuncButton("SystemZongMenFight")
end

function UIWorldFuncStorageWin.onSystemZMFightWaitResultNew()
_this:refreshFuncButton("SystemZongMenFight")
end

function UIWorldFuncStorageWin.onSystemZMFightFlagChanged(serial,oldFlag,newFlag)
if systemZongMenModel:isFightingAboutFlag(oldFlag)or systemZongMenModel:isFightingAboutFlag(newFlag)then
_this:refreshFuncButton("SystemZongMenFight")
end
if oldFlag==systemZongMenFightFlagType.eSurrender or newFlag==systemZongMenFightFlagType.eSurrender then
_this:refreshSystemZongMenSurrender()
end
end


function UIWorldFuncStorageWin:onFuncBtn_SystemZongMenSG()
local width=self.funcList:getChildSizeDeltaX()
local listPos=self.funcList:getChildAnchoredPosition()
local btnPos=self.funcBtn_SystemZongMenSG:getChildAnchoredPosition()
listPos.x=listPos.x-width+btnPos.x-10
UIManager:showWindow("UISystemZongMenVassalRewardWin",{arrow=listPos})
end

function UIWorldFuncStorageWin:refreshSystemZongMenSG()



local show=systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)and systemZongMenModel:haveSGReward()
self.funcBtn_SystemZongMenSG:setActive(show)
local btnWidget=self.funcBtn_SystemZongMenSG:getChildWidgetBase()
local widgetId=self.funcBtn_SystemZongMenSG:getID()
self:doPunchRotation_Btn(widgetId,btnWidget,0,show)
end

function UIWorldFuncStorageWin:checkSystemZongMenSGReddot()
return systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)and systemZongMenModel:haveSGReward()
end

function UIWorldFuncStorageWin.onSystemZMVassalRewardChange(serial,oldNum,newNum)
if oldNum<=0 and newNum>0 then
_this:refreshFuncButton("SystemZongMenSG")
elseif oldNum>0 and newNum<=0 then
_this:refreshFuncButton("SystemZongMenSG")
end
end


function UIWorldFuncStorageWin:onFuncBtn_ZaWuBu()
UIManager:showWindow('UIXiaoDaoTongMainWin',{page=self.fastMarPage})
end

function UIWorldFuncStorageWin:refreshZaWuBu()
local check=systemModel.isOpen(SYSTEM_DEFINE.eJianZhuTiShi)
self.funcBtn_ZaWuBu:setActive(check)
if not check then
return
end
local widget=self.funcBtn_ZaWuBu:getChildWidgetBase()
local num=0
local mNum=xiaodaotongModel:getManufactureReddotNum()
local bdNum=xiaodaotongModel:getBuildingReddotNum()
local tipsNum=xiaodaotongModel:getReddotNum()or 0
num=num+mNum+bdNum+tipsNum
if tipsNum>0 then
self.fastMarPage=3
elseif mNum>0 then
self.fastMarPage=1
elseif bdNum>0 then
self.fastMarPage=2
else
self.fastMarPage=3
end
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
end


function UIWorldFuncStorageWin:refreshSystemZongMenSurrender()
if not systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)then
self.funcBtn_SystemZongMenSurrender:setActive(false)
return false
end

local show=systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eSurrender)
self.funcBtn_SystemZongMenSurrender:setActive(show)

local btnWidget=self.funcBtn_SystemZongMenSurrender:getChildWidgetBase()
local widgetId=self.funcBtn_SystemZongMenSurrender:getID()
self:doPunchRotation_Btn(widgetId,btnWidget,0,show)

return show
end

function UIWorldFuncStorageWin:onFuncBtn_SystemZongMenSurrender()
local width=self.funcList:getChildSizeDeltaX()
local listPos=self.funcList:getChildAnchoredPosition()
local btnPos=self.funcBtn_SystemZongMenSurrender:getChildAnchoredPosition()
listPos.x=listPos.x-width+btnPos.x-10
UIManager:showWindow("UISystemZongMenSurrenderListWin",{arrow=listPos})
end

function UIWorldFuncStorageWin:checkSystemZongMenSurrenderReddot()
return systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)and systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eSurrender)
end


function UIWorldFuncStorageWin:onFuncBtn_SystemZongMenLetter()
UIManager:showWindow("UISystemZongMenLetterDialog")
end

function UIWorldFuncStorageWin:refreshSystemZongMenLetter()
local exsit=systemZongMenModel:exsitALetter()
self.funcBtn_SystemZongMenLetter:setActive(exsit)
end

function UIWorldFuncStorageWin.onSystemZMLetterChange(flag)
_this:refreshSystemZongMenLetter()
end