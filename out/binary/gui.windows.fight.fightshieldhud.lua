

def_class("FightShieldHUD",{})

local hudItemComp={
energyBar=0,
fullEnergy=1,
bgHP=2,
flickProgress=3,
hpProgress=4,
number=5,
headIcon=6,
EntityName=7,
lastHuDunProgress=8,
HPBar=9,
huDunProgress=10,
BuffRoot=11,
Energy=12,
HuDunBar=13,
bgHuDun=14,
huDunflickProgress=15,
hdNumber=16,
root=17,
counterAtkPoint=18,
txBtn=19,
txRoot=20,
txScrollView=21,
txRootBack=22,
txList=23,
pbIcon=24,
demageNum=25,
}


local _cmpItemWidgetIdx=
{
cmpIcon=0,
buffCount=1,
buffLayer=2,
}
local _spriteCount=3
local _FindCSGUIProgressbar=CS.UIHelper.FindCSGUIProgressbar
local _mIndex=0
local _mNextIndex=0
local _mlastIndex=0

local _mlastHuDunIndex=0
local _hudunSprite={3,4}

function FightShieldHUD:__init(args)
self.info=args
end

function FightShieldHUD:bindComponents()
self.flickProgressBar=_FindCSGUIProgressbar(self.winlua.gameObject,'#Root/HP/#HPBar/#flickProgress')
self.ProgressBar=_FindCSGUIProgressbar(self.winlua.gameObject,'#Root/HP/#HPBar/#hpProgress')

self.flickHuDunProgressBar=_FindCSGUIProgressbar(self.winlua.gameObject,'#Root/HP/#HuDunBar/#huDunflickProgress')
self.progressHuDunBar=_FindCSGUIProgressbar(self.winlua.gameObject,'#Root/HP/#HuDunBar/#huDunProgress')
end

function FightShieldHUD:unbindComponents()

end

function FightShieldHUD:onShow(args)

end

function FightShieldHUD:getHudItemComp()
return hudItemComp
end

function FightShieldHUD:setItem(item)
self.widget=item:GetChildWidgetBase(-1);
self.winlua=self.widget
self:bindComponents()
end

function FightShieldHUD:init(mcfg)

end

function FightShieldHUD:initHud()
self.entHUD=self.info
self.entHUD:setHUDWin(self)
self.ent=self.entHUD.entity
local id=self.ent:getSheildID()
local cfg=cfgHelper.get1(cfg_fightsheildconfig_get,id)
self:init(cfg)
self:initBloodData(cfg)
local abName="ui/windows/fight/zmhudun_atlas_pak.ab"
if cfg~=nil then

self.winlua:SetChildCSImageSprite(hudItemComp.headIcon,abName,"icon_zmdazhentx_"..cfg.icon)
end

local show=true
self:showRoot(true)

if show then
self:flushPosition()
self:initHP()
self:flushBuff(self.ent:getBuffInfo())

self:flushCounterAtkPoint(self.ent:getATKPoint())
end

end

function FightShieldHUD:flushPosition()

end

function FightShieldHUD:initHP()
local ent=self.entHUD.entity
self.winlua:SetChildText(hudItemComp.EntityName,ent.name)
self.winlua:SetChildActive(hudItemComp.EntityName,true)
local subMaxHp=ent:getAttribute(entityAttr.sub_max_hp)
local max_hp=ent:getAttribute(entityAttr.max_hp)
self.max_hp=max_hp

self:setHP(ent:getAttribute(entityAttr.hp),ent:getAttribute(entityAttr.max_hp),subMaxHp,0)
self:setHuDunValue(ent:getAttribute(entityAttr.hudun),ent:getAttribute(entityAttr.hp),ent:getAttribute(entityAttr.max_hp),subMaxHp)
self:setSubHPMax(subMaxHp,ent:getAttribute(entityAttr.max_hp))
if ent.typo==fightEntityType.diZi then
local gemPower=ent:getAttribute(entityAttr.gem_power)
local maxGemPower=ent:getAttribute(entityAttr.max_gem_power)
self.winlua:SetChildActive(hudItemComp.Energy,true)
self.winlua:SetChildProgress(hudItemComp.energyBar,gemPower,maxGemPower)
end
local info=ent:getbaseInfo()
self:initFabao(info.fabao,ent:isLeft())
end

function FightShieldHUD:initBloodData(monsterCfg)
local ent=self.ent
local hp=ent:getAttribute(entityAttr.hp)
local maxHp=ent:getAttribute(entityAttr.max_hp)
self.maxHpNum=monsterCfg.bloodnum or 1
self.hpNumber=self.maxHpNum
self.hideBloodNum=monsterCfg.hideBloodNum or false
end

function FightShieldHUD:setHP(hp,maxHP,subMaxhp,rcHP)
if self.hp==hp then return end
self.hp=hp
local maxHpNum=self.maxHpNum
local hpPerNum=math.floor(maxHP/maxHpNum)
local curNum=math.ceil(hp/hpPerNum)
if curNum<=0 then curNum=1 end
if curNum>maxHpNum then curNum=maxHpNum end
if maxHP==hp then curNum=maxHpNum end
local realIndex=maxHpNum-curNum+1
self:setHPAnimate(realIndex,maxHpNum,hp,maxHP,hpPerNum,true)




















self.winlua:SetChildText(hudItemComp.number,FMT.fmt("大阵护盾值：{0}/{1}",hp,maxHP))
end

function FightShieldHUD:setHPAnimate(curIndex,maxIndex,curHp,maxHp,hpPerNum,isAnimate)
if isAnimate==nil then isAnimate=true end
if curIndex<=0 then curIndex=1 end
local rate=0
if not isAnimate then _mlastIndex=0 end
if(maxIndex==1)then
rate=curHp/maxHp
self:playHPAnimate(curIndex,maxIndex,rate,isAnimate)
return
end
rate=curHp%hpPerNum
rate=rate/hpPerNum
if curHp<=0 then
rate=0
elseif curHp>=maxHp then
rate=1
elseif curIndex~=maxIndex and rate<=0 then
rate=1
end
self:playHPAnimate(curIndex,maxIndex,rate,isAnimate)
end

function FightShieldHUD:playHPAnimate(curIndex,maxIndex,rate,isAnimate)
if isAnimate==nil then isAnimate=true end
self.winlua:SetChildActive(hudItemComp.bgHP,curIndex~=maxIndex)
local targetValue=math.modf(rate*self.ProgressBar.Max)
self:setHpIndex(maxIndex,curIndex)
if _mNextIndex>0 then
self.winlua:SetChildSpriteByPrefabIndex(hudItemComp.bgHP,_mNextIndex-1,false)
else
self.winlua:SetChildActive(hudItemComp.bgHP,false)
end
local recoverBlood=false
if((curIndex~=_mlastIndex and curIndex<_mlastIndex)or(curIndex==_mlastIndex and self.ProgressBar.Value<targetValue))then
recoverBlood=true
end

if _mlastIndex~=curIndex and _mlastIndex~=maxIndex then


end
if not recoverBlood then
if _mlastIndex~=curIndex and _mlastIndex~=maxIndex then
self.ProgressBar.Value=self.ProgressBar.Max
self.flickProgressBar.Value=self.flickProgressBar.Max
end
else
if _mlastIndex~=curIndex then
self.ProgressBar.Value=0
self.flickProgressBar.Value=0
end
end
if isAnimate then
self.ProgressBar:Animate(targetValue)
self.flickProgressBar:Animate(targetValue,0.2)
else
self.ProgressBar.Value=rate*self.ProgressBar.Max
self.flickProgressBar.Value=rate*self.flickProgressBar.Max
end
_mlastIndex=curIndex
end

function FightShieldHUD:setHpIndex(maxIndex,curIndex)
local count=_spriteCount
_mIndex=(curIndex-1)%count+1
if curIndex==maxIndex then
_mNextIndex=-1
else
_mNextIndex=_mIndex+1
if _mNextIndex>count then
_mNextIndex=1
end
end
end

function FightShieldHUD:addHuDun(hudun,hp,maxHP)
local maxHpNum=self.maxHpNum
local perValue=maxHP/maxHpNum
local leftHP=hp%perValue
local lastRate=leftHP/perValue
local lastLeftHuDun=perValue-leftHP
local hudunOffset=0
if leftHP==0 then
hudunOffset=hudunOffset+lastLeftHuDun
lastLeftHuDun=0
end
local leftHuDun=hudun-lastLeftHuDun
local number=math.modf(leftHuDun/perValue)
local firstLeftHuDun=leftHuDun-perValue*number
local firstRate=firstLeftHuDun/perValue
if firstRate>0 then
hudunOffset=hudunOffset+firstLeftHuDun
if firstRate<0.01 then
firstRate=hudunOffset/perValue
if firstRate<0.01 then
firstLeftHuDun=0
if leftHP>0 then
lastLeftHuDun=lastLeftHuDun+hudunOffset
end
else
firstLeftHuDun=hudunOffset
end
else
firstLeftHuDun=hudunOffset
end
else
if leftHP>0 then
lastLeftHuDun=lastLeftHuDun+hudunOffset
end
end


local number=math.modf((hudun-lastLeftHuDun)/perValue)
local lastnumber=lastLeftHuDun>0 and 1 or 0
local firstnumber=firstLeftHuDun>0 and 1 or 0
local tNumber=number+lastnumber+firstnumber
self.maxHuDunNum=tNumber
self.maxHuDun=tNumber*perValue
self.lastLeftHuDun=lastLeftHuDun
self.firstLeftHuDun=firstLeftHuDun

local targetValue=lastLeftHuDun>0 and perValue or 0
self.winlua:SetProgressBarAniWithThreeParams(hudItemComp.lastHuDunProgress,targetValue,perValue,0)
end

function FightShieldHUD:setHuDunValue(hudun,hp,maxHP)
if self.hudun==hudun then return end
local add=hudun>0 and(self.hudun==nil or hudun>self.hudun)
self.hudun=hudun
if hudun<=0 then
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end

self.winlua:SetProgressBarAniWithThreeParams(hudItemComp.huDunProgress,0,100,0)
self.winlua:SetProgressBarAniWithThreeParams(hudItemComp.lastHuDunProgress,0,100,0)

self.winlua:SetChildActive(hudItemComp.bgHuDun,false)
return
end
if add then
self:addHuDun(hudun,hp,maxHP)
end
local curIndex=1
local maxHpNum=self.maxHpNum
local perValue=maxHP/maxHpNum
local lastLeftHuDun=self.lastLeftHuDun
local firstLeftHuDun=self.firstLeftHuDun
local left=maxHP-firstLeftHuDun
local rate=0
if hudun<=lastLeftHuDun then
curIndex=1
rate=hudun/perValue+hp%perValue/perValue
elseif hudun<=left then
local leftValue=hudun-lastLeftHuDun
curIndex=math.modf(leftValue/perValue)
if lastLeftHuDun>0 then curIndex=curIndex+1 end
rate=leftValue%perValue/perValue
elseif hudun<=maxHP then
curIndex=self.maxHuDunNum
local leftValue=hudun-lastLeftHuDun
rate=leftValue%perValue/perValue
end
if curIndex>self.maxHuDunNum then curNum=self.maxHuDunNum end
if curIndex<=0 then curIndex=1 end

if hudun<=0 then rate=0 end
local maxIndex=self.maxHuDunNum
local targetValue=math.modf(rate*perValue)
perValue=math.modf(perValue)

local func=(function()
self.winlua:SetProgressBarAniFinishAction(hudItemComp.lastHuDunProgress,nil)
self.winlua:SetProgressBarAniFinishAction(hudItemComp.huDunProgress,nil)

self.doProgress2=false
self.func=nil
end)

local func1=(function()
self.winlua:SetProgressBarAniFinishAction(hudItemComp.lastHuDunProgress,nil)
self.winlua:SetProgressBarAniFinishAction(hudItemComp.huDunProgress,nil)

self.doProgress2=false
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
end
self.delayTimer=nil
self.func1=nil
end)

if self.delayTimer then
self:stopTimerByID(self.delayTimer)
end
self.delayTimer=nil

if self.func then self.func()end
if self.func1 then self.func1()end
self.func=nil
self.func1=nil

local func2=function(delay)
self.doProgress2=false
if _mlastHuDunIndex>0 and curIndex~=_mlastHuDunIndex then
self:playHuDunAnimate(_mlastHuDunIndex,maxIndex,0,perValue,func,delay)
if delay>0 then
self.delayTimer=self:delayDo(delay,function()
self:playHuDunAnimate(_mlastHuDunIndex,maxIndex,perValue,perValue,func,0)
self.doProgress2=true
self:playHuDunAnimate(curIndex,maxIndex,targetValue,perValue,func1,delay)
end)
else
if self.doProgress1 then
self:playHuDunAnimate(_mlastHuDunIndex,maxIndex,perValue,perValue,func,0)
end
self.doProgress2=true
self:playHuDunAnimate(curIndex,maxIndex,targetValue,perValue,func1,0)
end
else
self:playHuDunAnimate(curIndex,maxIndex,targetValue,perValue,func1,delay)
end
end

self.func1=func1
self.func=func
func2(0.5)
end

function FightShieldHUD:playHuDunAnimate(curIndex,maxIndex,targetValue,perValue,func,delay)
local mlastIndex=_mlastHuDunIndex
_mlastHuDunIndex=curIndex
local isChangeIndex=mlastIndex~=curIndex

local mSpriteIndex,mNextSpriteIndex=self:setHuDunSpriteIndex(curIndex,maxIndex)

if curIndex>1 then
self.winlua:SetProgressBarAniWithThreeParams(hudItemComp.huDunProgress,targetValue,perValue,delay)
self.winlua:SetProgressBarAniWithThreeParams(hudItemComp.lastHuDunProgress,0,perValue,0)
self.winlua:SetProgressBarAniFinishAction(hudItemComp.huDunProgress,func)
if isChangeIndex then
self.winlua:SetChildSpriteByPrefabIndex(hudItemComp.huDunProgress,mSpriteIndex,false)
end
else
if self.lastLeftHuDun>0 then
self.winlua:SetProgressBarAniWithThreeParams(hudItemComp.huDunProgress,0,perValue,0)

self.winlua:SetProgressBarAniWithThreeParams(hudItemComp.lastHuDunProgress,targetValue,perValue,delay)

self.winlua:SetProgressBarAniFinishAction(hudItemComp.lastHuDunProgress,func)

if isChangeIndex then
self.winlua:SetChildSpriteByPrefabIndex(hudItemComp.lastHuDunProgress,mSpriteIndex,false)
end
else
self.winlua:SetProgressBarAniWithThreeParams(hudItemComp.huDunProgress,targetValue,perValue,delay)
self.winlua:SetProgressBarAniWithThreeParams(hudItemComp.lastHuDunProgress,0,perValue,0)
self.winlua:SetProgressBarAniFinishAction(hudItemComp.huDunProgress,func)

if isChangeIndex then
self.winlua:SetChildSpriteByPrefabIndex(hudItemComp.huDunProgress,mSpriteIndex,false)
end
end
end
if isChangeIndex then
local showBg=curIndex>2
self.winlua:SetChildActive(hudItemComp.bgHuDun,showBg)
if showBg then
self.winlua:SetChildSpriteByPrefabIndex(hudItemComp.bgHuDun,mNextSpriteIndex,false)
end
end
end

function FightShieldHUD:setHuDunSpriteIndex(curIndex,maxIndex)
local count=#_hudunSprite
local mIndex=(curIndex-1)%count+1
local mNextIndex=mIndex+1
if mNextIndex>count then mNextIndex=1 end
return _hudunSprite[mIndex],_hudunSprite[mNextIndex]
end

function FightShieldHUD:doScaleAni()
if self.dotween then return end
self.dotween=self.winlua:SetChildDOPunchScale(hudItemComp.number,Vector3.New(1.2,1.2,0),0.2,1)
self.dotween:SetEase(_Ease.OutElastic)
self.dotween:OnComplete(function()
self.dotween=nil
end)
end

function FightShieldHUD:initFabao(fabaoInfo,isLeft)

local itemID=nil
if fabaoInfo~=nil then
itemID=fabaoInfo[1]
if fabaoInfo[2]~=0 then
itemID=fabaoInfo[2]
end

self.fabaoInfo=fabaoInfo

if self.ent.fabaoObjID~=nil then
self.fabaoObjID=self.ent.fabaoObjID
end
if self.fabaoObjID~=nil then
self.ent:stopText(self.fabaoObjID)
self.fabaoObjID=nil
end
self.fabaoObjID=self.ent:flowText(flowObjTypo.fabao,{nunPara=fabaoInfo})
self.ent.fabaoObjID=self.fabaoObjID
end

if itemID then
local gemPower=self.ent:getAttribute(entityAttr.gem_power)
local maxGemPower=self.ent:getAttribute(entityAttr.max_gem_power)
self:flushGemPower(gemPower,maxGemPower)
self.winlua:SetChildActive(hudItemComp.Energy,true)
else
self.winlua:SetChildActive(hudItemComp.Energy,true)
self:flushGemPower(0,100)
end
end

function FightShieldHUD:flushGemPower(gemPower,maxGemPower)
self.winlua:SetChildProgress(hudItemComp.energyBar,gemPower,maxGemPower)
self.winlua:SetChildActive(hudItemComp.fullEnergy,gemPower>=maxGemPower)
end

function FightShieldHUD:fade(duration,targetVlaue)

end

function FightShieldHUD:setSubHPMax(subHPMax,hpMax)

end

function FightShieldHUD:showRoot(show)

end

function FightShieldHUD:flushBuff(buffData)
local buffDataList={}
for i,v in pairs(buffData)do
if v.cfg.icon~=0 then
buffDataList[#buffDataList+1]=v
end
end

table.sort(buffDataList,function(a,b)
return a.clientID<b.clientID
end)

self.winlua:SetChildLayoutGroupCreateItems(hudItemComp.BuffRoot,#buffDataList)
local items=self.winlua:GetChildLayoutGroupGridList(hudItemComp.BuffRoot)
for i=1,items.Count do
items[i-1]:SetChildPropData(-1,self:fillBuffData(buffDataList[i],i,i))
end
end

function FightShieldHUD:fillBuffData(buffInfo,id,index)
local prop={}
prop[PropIndex(DataPropKey.eWidgetIcon,_cmpItemWidgetIdx.cmpIcon)]=buffInfo.flag==1 and iconHelper.getResDispelBuffIcon(buffInfo.cfg.icon)or iconHelper.getBuffIcon(buffInfo.cfg.icon)
local round=(buffInfo.round==-1 or buffInfo.round==0)and""or buffInfo.round
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffCount)]=round
local layer=(buffInfo.layer==1 or buffInfo.layer==0)and""or buffInfo.layer
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffLayer)]=layer
prop[DataPropKey.eItemID]=id
prop[DataPropKey.eItemSeries]=index

return prop
end

function FightShieldHUD:getRecyleData()
return
{
[PropIndex(DataPropKey.eWidgetIcon,_cmpItemWidgetIdx.cmpIcon)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffCount)]='',
[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffLayer)]='',
[DataPropKey.eItemID]=-1,
[DataPropKey.eItemSeries]=-1,
}
end

function FightShieldHUD:flushCounterAtkPoint(pointList)
local buffDataList={}
for i,v in pairs(pointList)do
if v>0 then
local counterConfig=cfgHelper.get1(cfg_skillljconfig_get,i)
if counterConfig and counterConfig.show==1 then
buffDataList[#buffDataList+1]={i,v}
end
end
end

table.sort(buffDataList,function(a,b)
return a[1]<b[1]
end)

self.winlua:SetChildLayoutGroupCreateItems(hudItemComp.counterAtkPoint,#buffDataList)
local items=self.winlua:GetChildLayoutGroupGridList(hudItemComp.counterAtkPoint)
for i=1,items.Count do
local v=buffDataList[i]
items[i-1]:SetChildPropData(-1,self:fillCounterATKData(v[1],v[2],i))
end
end

function FightShieldHUD:fillCounterATKData(id,num,index)
local prop={}
prop[PropIndex(DataPropKey.eWidgetIcon,_cmpItemWidgetIdx.cmpIcon)]=iconHelper.getCounterAtkIcon(id,num)
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffCount)]=''
prop[PropIndex(DataPropKey.eWidgetText,_cmpItemWidgetIdx.buffLayer)]=''
prop[DataPropKey.eItemID]=id
prop[DataPropKey.eItemSeries]=index
return prop
end

function FightShieldHUD:onProgressBarFinishAction()

end


function FightShieldHUD:setTimer(delay,count,func)

if self._timer_lookup==nil then
self._timer_lookup={}
end
if not self.winlua then
return-1
end
local newfunc=function(...)
if not self or self.isClose then return end
func(...)
end
local id=self.winlua:StartTimer(delay,count,newfunc)
self._timer_lookup[newfunc]=id
return id
end

function FightShieldHUD:stopTimerByID(id)
if self.winlua and id>0 then
self.winlua:StopTimer(id)
end
end

function FightShieldHUD:stopAllTimer()
if self._timer_lookup==nil then
self._timer_lookup={}
end
for func,v in pairs(self._timer_lookup)do
self._timer_lookup[func]=nil
if self.winlua then
self.winlua:StopTimer(v)
end
end
end


function FightShieldHUD:delayDo(delay,func)
return self:setTimer(delay,1,func)
end

function FightShieldHUD:stopTimerByName(tname)
local id=self[tname]
if id~=nil then
self:stopTimerByID(id)
self[tname]=nil
end
end

function FightShieldHUD:pauseAllTimers()
if not UIManager:isCanPauseTimer(self.__name)then return end
if self.__isPause then return end
self.__isPause=true
self.winlua:PauseAllTimer()
end

function FightShieldHUD:continueAllTimers()
if not UIManager:isCanPauseTimer(self.__name)then return end
if not self.__isPause then return end
self.__isPause=nil
self.winlua:ContinueAllTimer()
end



function FightShieldHUD:releaseHud()
self.entHUD:setHUDWin(nil)
end

