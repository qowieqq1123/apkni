







def_class("UIYuJingMainMJWin",UIWindowBase)









function UIYuJingMainMJWin:bindComponents()

self.bgeffect=UIObject.get(self,0)
self.bgeffect2=UIObject.get(self,1)
self.btnBangYu=UIButton.get(self,2)
self.btnBaoKu=UIButton.get(self,3)
self.btnClose=UIButton.get(self,4)
self.btnGroup=UIObject.get(self,5)
self.btnShiLi=UIButton.get(self,6)
self.btnXianGuan=UIButton.get(self,7)
self.content=UIObject.get(self,8)
self.reddotShiLi=UIObject.get(self,9)
self.reddotXianGongBangYu=UIObject.get(self,10)
self.reddotXianGuan=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.sjimg=UIImage.get(self,13)
self.mjsltime=UIText.get(self,14)
self.btnMJSkill=UIButton.get(self,15)
self.btnMJTask=UIButton.get(self,16)
self.btnMJSL=UIButton.get(self,17)
self.mjskillicon=UIImage.get(self,18)
self.mjskillname=UIText.get(self,19)
self.mjskilllvl=UIText.get(self,20)
self.reddotMJSkill=UIObject.get(self,21)
self.reddotMJTask=UIObject.get(self,22)
self.reddotMJSL=UIObject.get(self,23)
self.bgModel=UIObject.get(self,24)

self.btnBangYu:setButtonClick(function()self:onBtnBangYu()end)

self.btnBaoKu:setButtonClick(function()self:onBtnBaoKu()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnShiLi:setButtonClick(function()self:onBtnShiLi()end)

self.btnXianGuan:setButtonClick(function()self:onBtnXianGuan()end)

self.btnMJSkill:setButtonClick(function()self:onBtnMJSkill()end)

self.btnMJTask:setButtonClick(function()self:onBtnMJTask()end)

self.btnMJSL:setButtonClick(function()self:onBtnMJSL()end)



end


function UIYuJingMainMJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgeffect);self.bgeffect=nil;
_UIObject_release(self.bgeffect2);self.bgeffect2=nil;
_UIObject_release(self.btnBangYu);self.btnBangYu=nil;
_UIObject_release(self.btnBaoKu);self.btnBaoKu=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnGroup);self.btnGroup=nil;
_UIObject_release(self.btnShiLi);self.btnShiLi=nil;
_UIObject_release(self.btnXianGuan);self.btnXianGuan=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.reddotShiLi);self.reddotShiLi=nil;
_UIObject_release(self.reddotXianGongBangYu);self.reddotXianGongBangYu=nil;
_UIObject_release(self.reddotXianGuan);self.reddotXianGuan=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sjimg);self.sjimg=nil;
_UIObject_release(self.mjsltime);self.mjsltime=nil;
_UIObject_release(self.btnMJSkill);self.btnMJSkill=nil;
_UIObject_release(self.btnMJTask);self.btnMJTask=nil;
_UIObject_release(self.btnMJSL);self.btnMJSL=nil;
_UIObject_release(self.mjskillicon);self.mjskillicon=nil;
_UIObject_release(self.mjskillname);self.mjskillname=nil;
_UIObject_release(self.mjskilllvl);self.mjskilllvl=nil;
_UIObject_release(self.reddotMJSkill);self.reddotMJSkill=nil;
_UIObject_release(self.reddotMJTask);self.reddotMJTask=nil;
_UIObject_release(self.reddotMJSL);self.reddotMJSL=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _this=nil
local abname='ui/windows/mojieforce/mojieforce_atlas_pak.ab'



function UIYuJingMainMJWin:onLoaded(...)
self:bindComponents()
_this=self


self:addNotify(notifyConfig.on_system_open,self.onSystemOpen)

xianjieModel:closeForceResetCamera()
end


function UIYuJingMainMJWin:__delete()
self:unbindComponents()
self:stopSelfTimerMJSL()
self:endAllReddotPunchRotation()
_this=nil
UIManager:closeActiveWindow("UIXianJieForceWin")
end




function UIYuJingMainMJWin:onShow(argtable,afterOnloaded)
self.bgModel:setChildUIModelShowTarget(6259,1,nil,3450)
if not webGLHelper:isRunMiniGame()then
self.bgeffect:setChildShowEffect(20474,true)
end
self.bgeffect2:setChildShowEffect(20511,true)

local showRoot=argtable==nil or argtable.onlyBg~=true
self:showRoot(true)


self.btnGroup:setActive(true)

self.btnShiLi:setActive(true)
self:ShowMoJieShiLiPanel()

if argtable then
if argtable.flag and argtable.flag==1 then
local temp
if argtable.showtips then
temp={}
temp.showtips=argtable.showtips
end
xianjieController:OpenMoJieShiLiSkillWin(temp)
end
end
end


function UIYuJingMainMJWin:onHide()

end





function UIYuJingMainMJWin:onBtnBangYu()
end



function UIYuJingMainMJWin:onBtnBaoKu()
end



function UIYuJingMainMJWin:onBtnClose()
UIFullXJMJForceControl:closeUI()
end



function UIYuJingMainMJWin:onBtnShiLi()
local args={
parentWin=UIFullXJMJForceControl,
select=xianjieForceType.eYuJing,
}
UIFullXJMJForceControl:showWindow("UIXianGongInfluenceMainWin",args)
end



function UIYuJingMainMJWin:onBtnXianGuan()
end

function UIYuJingMainMJWin:showRoot(show)
self.root:setActive(show)
end
function UIYuJingMainMJWin:Scrollchange()
local w=self.winlua:GetChildSizeDeltaY(self.content:getID())
local localPosX=self.winlua:GetChildLocalPosition(self.content:getID()).x
UIManager:invokeUIMethod("UIXianJieForceWin","ChangeScrowview",localPosX)
end
function UIYuJingMainMJWin.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eXianJieShiLiJH then
_this:refreshShiLiButton()
end
end



function UIYuJingMainMJWin:onBtnMJSkill()
local forceid=xianjieController:getForce()
if forceid>0 then
xianjieController:OpenMoJieShiLiSkillWin()
else

xianjieController:OpenMoJieShiLiWin()
end
end

function UIYuJingMainMJWin:onBtnMJTask()
xianjieController:OpenMoJieShiLiTaskWin()
end

function UIYuJingMainMJWin:onBtnMJSL()
xianjieController:OpenMoJieShiLiWin()
end


function UIYuJingMainMJWin:ShowMoJieShiLiPanel()
self:freshMJSLTitle()
self:freshMJSLSkil()
self:freshMJSLForceReddot()
self:freshMJSLTaskReddot()
self:freshMJSLSkillReddot()
end

function UIYuJingMainMJWin:freshMJSLTitle()
local saijiid=xianjieController:getMoJieSaiJiID()
if saijiid then
local mojiecfg=cfgHelper.get1(cfg_devildomseasonconfig_get,saijiid)
local forcetitle=mojiecfg.forcetitle
self.winlua:SetChildCSImageSprite(self.sjimg:getID(),abname,forcetitle)
end
local endtime=xianjieController:getMoJieSaiJieTime()
if endtime then
self:MJSLrefreshTime(endtime)
else
self:stopSelfTimerMJSL()
end
end
function UIYuJingMainMJWin:MJSLrefreshTime(endTime)
local curTime=timeHelper.getServerShortTime()
local timeStr=FMT.fmt('赛季时间：<color=#aae252>{0}</color>',timeHelper.format_time_stamp3(endTime-curTime))
self.mjsltime:setText(timeStr)
self:stopSelfTimerMJSL()
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
timeStr=FMT.fmt('赛季时间：<color=#aae252>{0}</color>',timeHelper.format_time_stamp3(showTime))
self.mjsltime:setText(timeStr)
if dtTime<=0 then
self:stopSelfTimerMJSL()
end
end
self.timermjsl=self:setTimer(1,0,func)
end
function UIYuJingMainMJWin:stopSelfTimerMJSL()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end

function UIYuJingMainMJWin:freshMJSLSkil()
local forceid=xianjieController:getForce()
local Skillidx,Taskidx=xianjieController:getForceCfg()
if forceid and Skillidx then
local skillcfg=xianjieController:getForceSkillCfg(forceid,Skillidx)
if skillcfg then
local lvl=xianjieController:getForceSkilllv()
local iconName=iconHelper.getSkillIcon(skillcfg.skillicon)
self.mjskillicon:setImageIcon(iconName,false)
self.mjskilllvl:setText(FMT.fmt('{0}级',lvl))
self.mjskillname:setText('技能升级')
end
end
end


function UIYuJingMainMJWin:freshMJSLSkilldesc()
_this:freshMJSLSkil()
_this:freshMJSLSkillReddot()
end

function UIYuJingMainMJWin:freshMJSLForceReddot()
local reddot=xianjieController:getMJSLForceReddot()
_this.reddotMJSL:setActive(reddot)
_this:doPunchRotation(_this.reddotMJSL,1,reddot)
end

function UIYuJingMainMJWin:freshMJSLTaskReddot()
local reddot=xianjieController:getMJSLTaskReddot()
_this.reddotMJTask:setActive(reddot)
_this:doPunchRotation(_this.reddotMJTask,2,reddot)
end

function UIYuJingMainMJWin:freshMJSLSkillReddot()
local reddot=xianjieController:getMJSLSkillUpReddot()
_this.reddotMJSkill:setActive(reddot)
_this:doPunchRotation(_this.reddotMJSkill,3,reddot)
end


function UIYuJingMainMJWin:doPunchRotation(widget,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if self.reddotTweenerList[reddotIndex]==nil then
self.winlua:SetChildRotation(widget:getID(),0,0,0)
local tweener=self.winlua:SetChildDOPunchRotation(widget:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
self.winlua:SetChildRotation(widget:getID(),0,0,0)
return nil
end
end
end

function UIYuJingMainMJWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
end
end
self.reddotTweenerList=nil
end

