







def_class("UIPengLaiMainMJWin",UIWindowBase)









function UIPengLaiMainMJWin:bindComponents()

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
self.StrangeAnimalSpine1=UIObject.get(self,13)
self.StrangeAnimalSpine2=UIObject.get(self,14)
self.StrangeAnimalSpine3=UIObject.get(self,15)
self.sjimg=UIImage.get(self,16)
self.mjsltime=UIText.get(self,17)
self.btnMJSkill=UIButton.get(self,18)
self.btnMJTask=UIButton.get(self,19)
self.btnMJSL=UIButton.get(self,20)
self.mjskillicon=UIImage.get(self,21)
self.mjskillname=UIText.get(self,22)
self.mjskilllvl=UIText.get(self,23)
self.reddotMJSkill=UIObject.get(self,24)
self.reddotMJTask=UIObject.get(self,25)
self.reddotMJSL=UIObject.get(self,26)
self.bgModel=UIObject.get(self,27)

self.btnBangYu:setButtonClick(function()self:onBtnBangYu()end)

self.btnBaoKu:setButtonClick(function()self:onBtnBaoKu()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnShiLi:setButtonClick(function()self:onBtnShiLi()end)

self.btnXianGuan:setButtonClick(function()self:onBtnXianGuan()end)

self.btnMJSkill:setButtonClick(function()self:onBtnMJSkill()end)

self.btnMJTask:setButtonClick(function()self:onBtnMJTask()end)

self.btnMJSL:setButtonClick(function()self:onBtnMJSL()end)



end


function UIPengLaiMainMJWin:unbindComponents()
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
_UIObject_release(self.StrangeAnimalSpine1);self.StrangeAnimalSpine1=nil;
_UIObject_release(self.StrangeAnimalSpine2);self.StrangeAnimalSpine2=nil;
_UIObject_release(self.StrangeAnimalSpine3);self.StrangeAnimalSpine3=nil;
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



















local _this
local abname='ui/windows/mojieforce/mojieforce_atlas_pak.ab'

function UIPengLaiMainMJWin:onLoaded(...)
self:bindComponents()
_this=self


self:addNotify(notifyConfig.on_system_open,self.onSystemOpen)

xianjieModel:closeForceResetCamera()
end


function UIPengLaiMainMJWin:__delete()
self:unbindComponents()
self:endAllReddotPunchRotation()
_this=nil
UIManager:closeActiveWindow("UIXianJieForceWin")
if self.btlistp and next(self.btlistp)then
for k,v in ipairs(self.btlistp)do
uiAIManager:removeUIInstance(v)
end
end

end




function UIPengLaiMainMJWin:onShow(argtable,afterOnloaded)
self.bgModel:setChildUIModelShowTarget(6259,1,nil,3450)
if not webGLHelper:isRunMiniGame()then
self.bgeffect:setChildShowEffect(20475,true)
end
self.bgeffect2:setChildShowEffect(20512,true)

self.nowindex=0
self:PlayStrangeAnimal()
self:setRemainingTimeTimer()

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


function UIPengLaiMainMJWin:onHide()

end


function UIPengLaiMainMJWin:setRemainingTimeTimer()
self.nowtime=0
local func=function()
self.nowtime=self.nowtime+1
if self.nowtime>=self.alltime then
if self.btlistp and next(self.btlistp)then
for k,v in ipairs(self.btlistp)do
uiAIManager:removeUIInstance(v)
end
end
self:PlayStrangeAnimal()
self.nowtime=0
end
end
self.timer=self:setTimer(1,0,func)
end

function UIPengLaiMainMJWin:PlayStrangeAnimal(randtable)
self.btlistp={}

local StrangeAnimal=cfgHelper.get2(cfg_xianjieforceconfig_get,3,'StrangeAnimal')
self.max=0

for k,v in ipairs(StrangeAnimal)do
self.max=v[1]+self.max
end
if self.nowindex>0 then
self.max=self.max-StrangeAnimal[self.nowindex][1]
end
local num=math.random(1,self.max)

local index=1
for i=1,#StrangeAnimal do
if i==self.nowindex then

elseif StrangeAnimal[i][1]>=num then
index=i
break
else
num=num-StrangeAnimal[i][1]
end
end
self.nowindex=index

local randcfg=StrangeAnimal[index]
self.alltime=randcfg[2]

local allAnimal=randtable
if randtable then
allAnimal=randtable
else
allAnimal=randcfg[3]
end
self.showtable={}
self.showtableindex={}
self.scaletable={}
self.scaleindex={}
if not allAnimal then
return
end
for i=1,#allAnimal do

local singleAnimal=allAnimal[i]
local animalspine=singleAnimal[1]
local shownum=singleAnimal[7]and#singleAnimal[7]or 0
local scalenum=singleAnimal[8]and#singleAnimal[8]or 0
local initData=
{
myid=i,
scaleStateId=-1,
canvasStateId=-1,
animalspine=singleAnimal[1],
beginpos=singleAnimal[2],
endpos=singleAnimal[3],
speedtime=singleAnimal[4],
rotation=singleAnimal[5],
scale=singleAnimal[6],
shownum=shownum,
beginshow=0,
endshow=0,
changevalue=0,
scalenum=scalenum,
beginscale=0,
endscale=0,
changeScalevalue=0,
}
local cav=self:getChildCanvas(-1)

local otherdata=
{
order=cav[2]+4
}
local func=function(bt)
self.btlistp[#self.btlistp+1]=bt
self.showtable[i]=singleAnimal[7]

self.showtableindex[i]=0
self.scaletable[i]=singleAnimal[8]
self.scaleindex[i]=0


end

local tran=self.content:getCommonComponent('Transform')
local vpos=Vector2.New(singleAnimal[2][1],singleAnimal[2][2])
local modelId=animalspine
uiAIManager:createUIObject('UIPengLaiMainMJWin','bt_ui_xianjiePengLai',INSTANCE_TYPE.eUIDModel,modelId,tran,vpos,initData,otherdata,func)
end
end


function UIPengLaiMainMJWin:ChangeCanvasGroupFade(bt,myid)
self.showtableindex[myid]=self.showtableindex[myid]+1
local nowindex=self.showtableindex[myid]
local nowshowtable=self.showtable[myid]
if nowshowtable and nowshowtable[nowindex]then
local datatb=nowshowtable[nowindex]
local begintime=datatb[1]
if nowindex>1 then
begintime=datatb[1]-nowshowtable[nowindex-1][2]
end
bt:setSharedVar('beginshow',begintime)
local usetime=datatb[2]-datatb[1]
usetime=usetime>0 and usetime or 0
bt:setSharedVar('endshow',usetime)
bt:setSharedVar('changevalue',datatb[3])

bt:setSharedVar('canvasStateId',0)
else
bt:setSharedVar('canvasStateId',-1)
end
end

function UIPengLaiMainMJWin:ChangeScale(bt,myid)
self.scaleindex[myid]=self.scaleindex[myid]+1
local nowindex=self.scaleindex[myid]
local nowscaletable=self.scaletable[myid]
if nowscaletable and nowscaletable[nowindex]then
local datatb=nowscaletable[nowindex]
local begintime=datatb[1]
if nowindex>1 then
begintime=datatb[1]-nowscaletable[nowindex-1][2]
end
bt:setSharedVar('beginscale',begintime)
local usetime=datatb[2]-datatb[1]
usetime=usetime>0 and usetime or 0
bt:setSharedVar('endscale',usetime)
bt:setSharedVar('changeScalevalue',datatb[3])

bt:setSharedVar('scaleStateId',0)
else
bt:setSharedVar('scaleStateId',-1)
end
end
function UIPengLaiMainMJWin:SetMovePengLai(widget,val,duration)
if type(val)=='table'then
val=Vector3(val[1],val[2],val[3]or 0)
end
local tweener=widget:SetChildDOLocalMove(0,val,duration,nil)
tweener:SetEase(DG.Tweening.Ease.Linear)
end




function UIPengLaiMainMJWin:onBtnBangYu()
end



function UIPengLaiMainMJWin:onBtnBaoKu()
end



function UIPengLaiMainMJWin:onBtnClose()
UIFullXJMJForceControl:closeUI()
end



function UIPengLaiMainMJWin:onBtnShiLi()
local args={
parentWin=UIFullXJMJForceControl,
select=xianjieForceType.ePengLai,
}
UIFullXJMJForceControl:showWindow("UIXianGongInfluenceMainWin",args)
end



function UIPengLaiMainMJWin:onBtnXianGuan()
end


function UIPengLaiMainMJWin:showRoot(show)
self.root:setActive(show)
end

function UIPengLaiMainMJWin:Scrollchange()
local w=self.winlua:GetChildSizeDeltaY(self.content:getID())
local localPosX=self.winlua:GetChildLocalPosition(self.content:getID()).x
UIManager:invokeUIMethod("UIXianJieForceWin","ChangeScrowview",localPosX)
end


function UIPengLaiMainMJWin.onSystemOpen(sysid)

end




function UIPengLaiMainMJWin:onBtnMJSkill()
local forceid=xianjieController:getForce()
if forceid>0 then
xianjieController:OpenMoJieShiLiSkillWin()
else

xianjieController:OpenMoJieShiLiWin()
end
end

function UIPengLaiMainMJWin:onBtnMJTask()
xianjieController:OpenMoJieShiLiTaskWin()
end

function UIPengLaiMainMJWin:onBtnMJSL()
xianjieController:OpenMoJieShiLiWin()
end


function UIPengLaiMainMJWin:ShowMoJieShiLiPanel()
self:freshMJSLTitle()
self:freshMJSLSkil()
self:freshMJSLForceReddot()
self:freshMJSLTaskReddot()
self:freshMJSLSkillReddot()
end

function UIPengLaiMainMJWin:freshMJSLTitle()
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
function UIPengLaiMainMJWin:MJSLrefreshTime(endTime)
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
function UIPengLaiMainMJWin:stopSelfTimerMJSL()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end

function UIPengLaiMainMJWin:freshMJSLSkil()
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


function UIPengLaiMainMJWin:freshMJSLSkilldesc()
_this:freshMJSLSkil()
_this:freshMJSLSkillReddot()
end

function UIPengLaiMainMJWin:freshMJSLForceReddot()
local reddot=xianjieController:getMJSLForceReddot()
_this.reddotMJSL:setActive(reddot)
_this:doPunchRotation(_this.reddotMJSL,1,reddot)
end

function UIPengLaiMainMJWin:freshMJSLTaskReddot()
local reddot=xianjieController:getMJSLTaskReddot()
_this.reddotMJTask:setActive(reddot)
_this:doPunchRotation(_this.reddotMJTask,2,reddot)
end

function UIPengLaiMainMJWin:freshMJSLSkillReddot()
local reddot=xianjieController:getMJSLSkillUpReddot()
_this.reddotMJSkill:setActive(reddot)
_this:doPunchRotation(_this.reddotMJSkill,3,reddot)
end



function UIPengLaiMainMJWin:doPunchRotation(widget,reddotIndex,isReddot)
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

function UIPengLaiMainMJWin:endAllReddotPunchRotation()
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

