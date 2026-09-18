def_class('entityHUD',{})

local charMap1={['0']='a',['1']='b',['2']='c',['3']='d',['4']='e',['5']='f',['6']='g',['7']='h',['8']='i',['9']='j'}
local charMap2={['0']='A',['1']='B',['2']='C',['3']='D',['4']='E',['5']='F',['6']='G',['7']='H',['8']='I',['9']='J'}
local demageTypoMap={[1]='X'}
local converNun=function(map,nunStr)
local str=''
local len=string.len(nunStr)
for i=1,len do
local c=map[string.sub(nunStr,i,i)]
if c~=nil then
str=str..c
end

end
return str
end


local skillTypoImage=
{
[1]='title_zdcfshanbi',
[2]='title_zdcfxishou',
[3]='title_zdcfdikang',
[4]='title_zdcffantan1',
[5]='title_zdcffanshe',
[6]='title_zdcfquchu',
[7]='title_zdcfmianyi',
[8]='title_zdcfgedang',
[9]='title_zdcfhunluan',

[20]='title_zdcffanji',
[21]='title_heji',
[22]='title_zdcffusheng',
[23]='title_zdcfwudi',

[24]='title_zdcffansi1',
[25]='title_lengquezengjia',
[26]='title_lengquejianshao',
[27]='title_lengquechongzhi',
[28]='title_lengquezuidahua',

}


SKILL_TYPO_IMAGE=skillTypoImage

local getSkillImage=function(typo)
return'ui/windows/fight/sharedtextures/fightskilleffect.ab',skillTypoImage[typo]
end

function entityHUD.getSkillImage(typo)
return getSkillImage(typo)
end

local speStateImage=
{
[1]={"image_zdzjm_01","image_zdzjm_04"},
[2]={"image_zdzjm_02","image_zdzjm_05"},
[3]={"image_zdzjm_03","image_zdzjm_06"},
}

function entityHUD.getSpeStateImage(typo)
return'ui/windows/fight/speskillstate_atlas_pak.ab',speStateImage[typo]
end





local flowTypoMap=
{

[flowObjTypo.hp]=function(ent,flowCmp,args)
local posOffset=ent:getPosOffset()
local changeHP=args.change
local curHP=args.curhp
local maxHP=args.maxhp
local demageTypo=args.demageTypo or 0
local onCmpSpwan=function(flowObjWin)
local value=changeHP
local str=''
if value>0 then
if demageTypo~=0 then
str=FMT.fmt("{0}{1}",demageTypoMap[demageTypo],value)
else
str=FMT.fmt("{0}",value)
end
else
value=tostring(math.abs(value))
value=converNun(charMap2,value)

str=FMT.fmt("+{0}",value)
end
flowObjWin:SetChildText(0,str)
end
local flowType=flowObjTypo.hp
if demageTypo~=0 then
flowType=flowObjTypo.hp_critical
end
local endPos=ent:getHudPosition()+posOffset
local uiWorldPos=fightManager.stageToUIPos(endPos)
if changeHP~=0 then
return flowCmp:genFlowObj(flowType,1.0,1.0,uiWorldPos,ent:getFlowHpPosition(),onCmpSpwan)
end
end,


[flowObjTypo.tip]=function(ent,flowCmp,args)
local posOffset=ent:getPosOffset()
local name=args.strPara
local backType=args.nunPara or 1
local scale=args.scale or 0.7
local offset=args.offset or Vector3.zero
local cmpOnSpwan=function(flowObjWin)

local flowLuaObj={}
flowLuaObj.luaWin=flowObjWin
flowLuaObj.attach=function(self,guid)
self.luaWin:SetChildFollowEntity(0,guid,Vector3.zero+offset)
end

flowLuaObj.unAttach=function(self)
self.luaWin:SetChildFollowEntity(0,-1,flowObjWin:GetChildPosition(-1))
end

local flipx=ent:getFlipX()
if flipx then
flowObjWin:SetChildText(3,name)
if backType==2 then
flowObjWin:SetChildActive(5,false)
flowObjWin:SetChildActive(6,true)
else
flowObjWin:SetChildActive(5,true)
flowObjWin:SetChildActive(6,false)
end
else
flowObjWin:SetChildText(4,name)
if backType==2 then
flowObjWin:SetChildActive(7,false)
flowObjWin:SetChildActive(8,true)
else
flowObjWin:SetChildActive(7,true)
flowObjWin:SetChildActive(8,false)
end
end
flowObjWin:SetChildActive(1,flipx)
flowObjWin:SetChildActive(2,not flipx)
flowLuaObj:attach(ent.guid)
end

return flowCmp:genFlowObj(flowObjTypo.tip,scale,args.stayTime or 1.0,ent:getHudPosition()+posOffset+offset,Vector3.New(0,0,0),cmpOnSpwan,nil)
end,


[flowObjTypo.skill]=function(ent,flowCmp,args)
local posOffset=ent:getPosOffset()
local name=args.strPara
local offset=ent:getFlowSkillNamePosition()
local cmpOnSpwan=function(flowObjWin)








flowObjWin:SetChildActive(5,true)
flowObjWin:SetChildShowEffect(6,10334,true)
flowObjWin:SetChildText(7,name)
flowObjWin:SetChildScale(7,Vector3.New(0,1,1))
flowObjWin:SetChildDOScale(7,1,0.25,nil)
flowObjWin:SetChildCanvasGroupAlpha(7,0)
flowObjWin:SetChildCanvasGroupDOFade(7,1,0.25,nil)

local t=flowObjWin:SetChildCanvasGroupDOFade(7,0,0.3,nil)
t:SetDelay(1.4)

flowObjWin:SetChildFollowEntity(0,ent.guid,offset)
end
local cmpOndespwan=function(flowObjWin)
flowObjWin:SetChildFollowEntity(0,-1,flowObjWin:GetChildPosition(-1))
end

local uiWorldPos=fightManager.stageToUIPos(ent:getHudPosition()+posOffset)
local dir=ent:getFlowDir()
return flowCmp:genFlowObj(flowObjTypo.skill,args.scale or 0.7,args.stayTime or 2.0,uiWorldPos,dir,cmpOnSpwan,cmpOndespwan)
end,


[flowObjTypo.skillEffect]=function(ent,flowCmp,args)

local posOffset=ent:getPosOffset()
local typo=args.nunPara
local abName,assetName=getSkillImage(typo)
local cmpOnSpwan=function(flowObjWin)
flowObjWin:SetChildCSImageSprite(2,abName,assetName)
end
local entPos=ent:getPosition()+posOffset
local entSize=ent:getSize()
local dir=Vector3.New(-1,1,0)
if ent:isLeft()then
dir.x=0-dir.x
end
local uiWorldPos=fightManager.stageToUIPos(entPos)+ent:getFlowSkillPosition()
return flowCmp:genFlowObj(flowObjTypo.skillEffect,args.scale or 0.7,args.stayTime or 1.2,uiWorldPos,dir,cmpOnSpwan)
end,


[flowObjTypo.biaoQing]=function(ent,flowCmp,args)
local posOffset=ent:getPosOffset()
local iconID=args.nunPara
local offset=args.offset or Vector3.zero
local iconName=iconHelper.getEmotIcon(iconID)
local cmpOnSpwan=function(flowObjWin)
flowObjWin:SetChildFollowEntity(0,ent.guid,posOffset+offset)
flowObjWin:SetChildCSImageIcon(1,iconName,true)
end
local entPos=ent:getHudPosition()+posOffset
local uiWorldPos=fightManager.stageToUIPos(entPos)+offset

local cmpOndespwan=function(flowObjWin)
flowObjWin:SetChildFollowEntity(0,-1,flowObjWin:GetChildPosition(-1))
end

return flowCmp:genFlowObj(flowObjTypo.biaoQing,1,args.stayTime or 1.0,uiWorldPos,Vector3.zero,cmpOnSpwan,cmpOndespwan)
end,


[flowObjTypo.fabao]=function(ent,flowCmp,args)
local posOffset=ent:getPosOffset()
local itemID=args.nunPara
local equip=args.equipPara
local iconName
if equip then
iconName=itemsModel.getIconName(equip)
else
iconName=itemsModel.getFabaoIconName(itemID[1],itemID[2])

end

local cmpOnSpwan=function(flowObjWin)
local body=ent:getSize()

local offset=ent:fixOffset(Vector3.New((-((body[1]+0.35)/2)),-0.2,0))
flowObjWin:SetChildFollowEntity(0,ent.guid,offset)
flowObjWin:SetChildCSImageIcon(1,iconName,true)
end

local cmpOndespwan=function(flowObjWin)
flowObjWin:SetChildFollowEntity(0,-1,flowObjWin:GetChildPosition(-1))
end

local entPos=ent:getHudPosition()

return flowCmp:genFlowObj(flowObjTypo.fabao,1,3600*24,entPos+posOffset,Vector3.zero,cmpOnSpwan,cmpOndespwan)
end,


[flowObjTypo.buff]=function(ent,flowCmp,args)
local text=args.strPara or""
local arrow=args.arrow
local cmpOnSpwan=function(flowObjWin)
text=arrow==1 and FMT.cfmt(FONT_COLOR.eGreenTxtColor,text)or FMT.fmt("<color=#ca631d>{0}</color>",text)
flowObjWin:SetChildText(1,text)
flowObjWin:SetChildActive(2,arrow==1)
flowObjWin:SetChildActive(3,arrow==0)
local scaleTween=flowObjWin:SetChildDOScale(0,1.2,0.5)
scaleTween:SetEase(_Ease.Linear)
scaleTween:SetLoops(2,_LoopType.Yoyo)
end
local offset=arrow==1 and 0.2 or-0.2
local entPos=ent:getHudPosition()+Vector3.New(0,offset,0)
local uiWorldPos=fightManager.stageToUIPos(entPos)
offset=arrow==1 and 0.5 or-0.5
local dir=Vector3.New(0,offset,0)
return flowCmp:genFlowObj(flowObjTypo.buff,1,0.8,uiWorldPos,dir,cmpOnSpwan)
end,


[flowObjTypo.effect]=function(ent,flowCmp,args)
local effectId=args.nunPara
local cmpOnSpwan=function(flowObjWin)
if args.offset then
flowObjWin:SetChildAnchoredPosition(1,args.offset)
end
if args.scale then
flowObjWin:SetChildScale(1,args.scale)
end
flowObjWin:SetChildShowEffect(1,effectId,true)

if args.attach then
local flowLuaObj={}
flowLuaObj.luaWin=flowObjWin
flowLuaObj.attach=function(self,guid)
flowObjWin:SetChildLocalPosition(0,Vector3.zero)
self.luaWin:SetChildFollowEntity(0,guid,Vector3.zero)
end
flowLuaObj.unAttach=function(self)
self.luaWin:SetChildFollowEntity(0,-1,flowObjWin:GetChildPosition(-1))
end
flowLuaObj:attach(ent.guid)
end
end

return flowCmp:genFlowObj(flowObjTypo.effect,1,args.stayTime or 2.0,flowCmp:getChildPosition(),Vector3.zero,cmpOnSpwan)
end,


[flowObjTypo.randomTip]=function(ent,flowCmp,args)
local posOffset=ent:getPosOffset()
local id=args.strPara
local backType=args.nunPara or 1
local scale=args.scale or 0.7
local stringList=cfgHelper.get(cfg_fightrandomlangconfig_get,id,"stringList")
local name=stringList[math.random(1,#stringList)]
local cmpOnSpwan=function(flowObjWin)

local flowLuaObj={}
flowLuaObj.luaWin=flowObjWin
flowLuaObj.attach=function(self,guid)
flowObjWin:SetChildLocalPosition(0,Vector3.zero)
self.luaWin:SetChildFollowEntity(0,guid,Vector3.zero)
end

flowLuaObj.unAttach=function(self)
self.luaWin:SetChildFollowEntity(0,-1,flowObjWin:GetChildPosition(-1))
end
flowLuaObj:attach(ent.guid)

local flipx=ent:getFlipX()

if flipx then
flowObjWin:SetChildText(3,name)
if backType==2 then
flowObjWin:SetChildActive(5,false)
flowObjWin:SetChildActive(6,true)
flowObjWin:SetChildActive(7,false)
flowObjWin:SetChildActive(8,false)
else
flowObjWin:SetChildActive(5,true)
flowObjWin:SetChildActive(6,false)
flowObjWin:SetChildActive(7,false)
flowObjWin:SetChildActive(8,false)
end
else
flowObjWin:SetChildText(4,name)
if backType==2 then
flowObjWin:SetChildActive(5,false)
flowObjWin:SetChildActive(6,false)
flowObjWin:SetChildActive(7,false)
flowObjWin:SetChildActive(8,true)
else
flowObjWin:SetChildActive(5,false)
flowObjWin:SetChildActive(6,false)
flowObjWin:SetChildActive(7,true)
flowObjWin:SetChildActive(8,false)
end
end

flowObjWin:SetChildActive(1,flipx)
flowObjWin:SetChildActive(2,not flipx)

end

local cmpOndespwan=function(flowObjWin)
flowObjWin:SetChildLocalPosition(0,Vector3.zero)
end

return flowCmp:genFlowObj(flowObjTypo.tip,scale,args.stayTime or 1.0,ent:getHudPosition()+posOffset,Vector3.zero,cmpOnSpwan,cmpOndespwan)
end,
}

local global_hud_id=0
function entityHUD:__init(ent)
self.entity=ent
self.showHUD=false
global_hud_id=global_hud_id+1
self.id=global_hud_id
self.hudName='UIFightHUD'
self.hudTypo=0
self.addFlowTimer=nil
self.rootQueue=queue.New()
end

function entityHUD:setHUDWin(hud)
self.hud=hud
end

function entityHUD:setFlowGen(flowObj)
self.flowObj=flowObj
end


local monsterHUD=
{
[2]="UIFightBossHUD",
[3]="UIFightBossHUD",
}

local monsterHUD2=
{
[2]="UIFightBossDemageHUD",
[3]="UIFightBossDemageHUD",
}

local monsterHUD3=
{
[3]="UIFightBossBoxHUD",
}

local teamShieldHUD="UIFightShieldHUD"

function entityHUD:checkType(show)
if self.entity.typo==fightEntityType.monster then
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,self.entity:getMonsterID())
if monsterCfg~=nil then
if monsterCfg.demageBar~=nil then
self.hudTypo=1
self.hudName=monsterHUD2[monsterCfg.monType]
if monsterCfg.demageBarType==3 then
self.hudName=monsterHUD3[monsterCfg.demageBarType]
end
if show then
entityHUDCtr:saveBossHud(self)
UIManager:showWindow(self.hudName,self)
else
entityHUDCtr:removeBossHud(self)
if entityHUDCtr:isEnptyToBossHudList()then
UIManager:invokeUIMethod(self.hudName,"releaseAllHud")
UIManager:closeWindow(self.hudName,self)
end
end
else
if monsterHUD[monsterCfg.monType]~=nil then
self.hudTypo=1
self.hudName=monsterHUD[monsterCfg.monType]
if show then
entityHUDCtr:saveBossHud(self)
UIManager:showWindow(self.hudName,self)
else
entityHUDCtr:removeBossHud(self)
if entityHUDCtr:isEnptyToBossHudList()then
UIManager:invokeUIMethod(self.hudName,"releaseAllHud")
UIManager:closeWindow(self.hudName,self)
end
end
end
end
end
elseif self.entity.typo==fightEntityType.shield then
self.hudTypo=1
self.hudName=teamShieldHUD
if show then
entityHUDCtr:saveShieldHud(self)
UIManager:showWindow(self.hudName,self)
else
entityHUDCtr:removeShieldHud(self)
if entityHUDCtr:isEmptyToShieldHudList()then
UIManager:invokeUIMethod(self.hudName,"releaseAllHud")
UIManager:closeWindow(self.hudName,self)
end
end
elseif self.entity.typo==fightEntityType.junzhen then
self.hudName="UIFightJunZhenHUD"
end

return self.hudTypo
end

function entityHUD:getHUDName()
return self.hudName
end

function entityHUD:show(show)
if self.showHUD~=show then
self.showHUD=show
if self.showHUD then
entityHUDCtr:createHUD(self)
else
entityHUDCtr:removeHUD(self)
end
end
end

function entityHUD:remove()
if self.hudTypo==1 then
UIManager:closeWindow(self.hudName)
else
self.hud=nil
self.genFlowObj=nil
entityHUDCtr:removeHUD(self)
end
if self.rootQueue then
self.rootQueue:clear()
self.rootQueue=nil
end
if self.addFlowTimer then
self.addFlowTimer:cancel()
self.addFlowTimer=nil
end
end


function entityHUD:flowText(typo,args,inQueueTime)
if self.flowObj~=nil then
local flowFunc=flowTypoMap[typo]
if flowFunc then
if inQueueTime then
if not self.addFlowTimer then
flowFunc(self.entity,self.flowObj,args)
self.addFlowTimer=timeEventController.delayDo(inQueueTime,function()
self.addFlowTimer=nil
if self.rootQueue then
local queueCB=self.rootQueue:dequeue()
if queueCB then
queueCB()
end
end
end)
else
if self.rootQueue==nil then

self.rootQueue=queue.New()
end
if self.rootQueue then
self.rootQueue:enqueue(function()
flowFunc(self.entity,self.flowObj,args)
end)
end
end
else
return flowFunc(self.entity,self.flowObj,args)
end
end
end
end

function entityHUD:stopText(id)
if self.flowObj~=nil then

self.flowObj:stop(id)
end
end

function entityHUD:flushPosition()
if self.hud and not self.hud.isClose then
self.hud:flushPosition()
end
end

function entityHUD:flushBuff(buff)
if self.hud and not self.hud.isClose then
self.hud:flushBuff(buff)
end
end

function entityHUD:flushGemPower(gemPower,maxGemPower)
if self.hud and not self.hud.isClose then
self.hud:flushGemPower(gemPower,maxGemPower)
end
end

function entityHUD:setHP(cur,max,subMaxhp,rcHP)
if self.hud and not self.hud.isClose then
self.hud:setHP(cur,max,subMaxhp,rcHP)
end
end

function entityHUD:setHuDunValue(huDun,hp,hpMax)
if self.hud and not self.hud.isClose then
self.hud:setHuDunValue(huDun,hp,hpMax)
end
end

function entityHUD:setSubHPMax(subHPMax,hpMax)
if self.hud and not self.hud.isClose then
self.hud:setSubHPMax(subHPMax,hpMax)
end
end

function entityHUD:fade(duration,targetValue)
if self.hud and not self.hud.isClose then
self.hud:fade(duration,targetValue)
self.hud.fadeTarget=targetValue
end
end

function entityHUD:getFadeTarget()
if self.hud and not self.hud.isClose then
return self.hud.fadeTarget
end
end

function entityHUD:showRoot(show)
if self.hud and not self.hud.isClose then
self.hud:showRoot(show)
end
end

function entityHUD:callExtraFunc(func,...)
if self.hud and not self.hud.isClose and self.hud.callExtraFunc then
self.hud:callExtraFunc(func,...)
end
end


function entityHUD:onAttrChange(typo,newValue,oldValue)

end

function entityHUD:flushCounterAtkPoint(pointList)
if self.hud and not self.hud.isClose then
self.hud:flushCounterAtkPoint(pointList)
end
end
