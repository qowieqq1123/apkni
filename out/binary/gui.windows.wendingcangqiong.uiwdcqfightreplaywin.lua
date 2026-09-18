







def_class("UIWDCQFightReplayWin",UIWindowBase)









function UIWDCQFightReplayWin:bindComponents()

self.scrollerView=UIObject.get(self,0)



end


function UIWDCQFightReplayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollerView);self.scrollerView=nil;
end


















local _abName="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _bossKuang={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}

local infoItemCmp={
roundTitle=0,
subBg=1,
replayIcon=2,
fightIcon=3,
noData=4,
teamItemL=5,
teamItemR=6,
InfoItem=7,
}

local teamCmp={
hss=0,
headSlotList={1,2,3,4,5},
nodzTip=6,
winFlag=7,
failFlag=8,
}


function UIWDCQFightReplayWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQFightReplayWin:__delete()
self:unbindComponents()
end




function UIWDCQFightReplayWin:onShow(argtable,afterOnloaded)
local fightType=argtable.fightType
self.fightType=fightType
local logStrList=argtable.logStrList
local logIdList=argtable.logIdList or{}
self.extraArgs=argtable.extraArgs
local infoList={}
for i,fightLog in ipairs(logStrList)do
local fightInfo=fightModel:getJsonReport(fightLog)
local aInfo=fightInfo[fightReportTag.attack]
local dInfo=fightInfo[fightReportTag.defend]
local result=fightInfo[fightReportTag.result]
local aresult=fightInfo[fightReportTag.attackResult]
local dresult=fightInfo[fightReportTag.defendResult]

local aInfoImage=self:getImageList(aInfo,aresult)
local dInfoImage=self:getImageList(dInfo,dresult)
table.insert(infoList,{logId=logIdList[i],fightLog=fightLog,aInfoImage=aInfoImage,dInfoImage=dInfoImage})
end
self:refreshList(infoList)
end


function UIWDCQFightReplayWin:onHide()

end

function UIWDCQFightReplayWin:getImageList(info,resultAttr)
local infoList={}
if info then
for i,v in ipairs(info)do
if v.id~=-1 then
local resultHp=0
local resultProp=resultAttr[i].prop
if resultProp then
for _,prop in ipairs(resultProp)do
if prop[1]==entityAttr.hp then
resultHp=prop[2]
break
end
end
end

local headFlag=v[fightEntityTag.typo]
if headFlag==0 then
local baseInfo=v[fightEntityTag.baseInfo]

local jobInfo=baseInfo[fightBaseInfoTag.jobData]
local modelData=baseInfo[fightBaseInfoTag.model]
local weaponItemID=baseInfo[fightBaseInfoTag.weapon]or 0
local weaponID=0
if weaponItemID>0 then
local equipCfg=itemsConfig.getConfig(weaponItemID)
if equipCfg~=nil then
weaponID=equipCfg.imageID or 0
end
end
local tmlv=baseInfo[fightBaseInfoTag.tmlv]or-1

local clothingId=baseInfo[fightBaseInfoTag.clothingId]
local clothingStar=baseInfo[fightBaseInfoTag.clothingStar]

local xianmo_voc
if baseInfo[fightBaseInfoTag.hide_xm]~=1 then
xianmo_voc=baseInfo[fightBaseInfoTag.xm_voc]
end

local args={
tmLv=tmlv,
clothingId=clothingId,
clothingStar=clothingStar,
xianmo_voc=xianmo_voc,
}
local image,outSideImage=UIDiscipleModel.getDiscipleFightModelInfo(jobInfo,modelData,weaponID,1.0,args)
table.insert(infoList,{typo=headFlag,image=image,resultHp=resultHp})
else
table.insert(infoList,{typo=headFlag,resultHp=resultHp})
end
end
end
end
return infoList
end

function UIWDCQFightReplayWin:refreshList(infoList)

self.scrollerView:setChildScrollViewCreateGrids(#infoList,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local logInfo=infoList[i]
self:refreshLogItem(i,item,logInfo)
end
end

function UIWDCQFightReplayWin:refreshLogItem(i,item,logInfo)
item:SetChildActive(infoItemCmp.InfoItem,true)
item:SetChildText(infoItemCmp.roundTitle,FMT.fmt("第{0}场",i))
if not logInfo.aInfoImage and not logInfo.dInfoImage then
item:SetChildActive(infoItemCmp.noData,true)
item:SetChildActive(infoItemCmp.subBg,false)
else
item:SetChildActive(infoItemCmp.noData,false)
item:SetChildActive(infoItemCmp.subBg,true)
if logInfo.aInfoImage and logInfo.dInfoImage then
item:SetChildActive(infoItemCmp.replayIcon,true)
item:SetChildActive(infoItemCmp.fightIcon,false)
else
item:SetChildActive(infoItemCmp.replayIcon,false)
item:SetChildActive(infoItemCmp.fightIcon,true)
end
end

item:SetChildButtonClick(infoItemCmp.replayIcon,function()
self:openFight(logInfo.logId,logInfo.fightLog)
end)
local teamItemL=item:GetChildWidgetBase(infoItemCmp.teamItemL)
self:setTeamItem(teamItemL,logInfo.aInfoImage)
local teamItemR=item:GetChildWidgetBase(infoItemCmp.teamItemR)
self:setTeamItem(teamItemR,logInfo.dInfoImage)
end

function UIWDCQFightReplayWin:setTeamItem(item,InfoImage)
if InfoImage then
item:SetChildActive(teamCmp.hss,true)
item:SetChildActive(teamCmp.nodzTip,false)
item:SetChildActive(teamCmp.winFlag,false)
item:SetChildActive(teamCmp.failFlag,false)

for i,v in ipairs(teamCmp.headSlotList)do
local info=InfoImage[i]
if info then
item:SetChildActive(v,true)
local headWidget=item:GetChildWidgetBase(v)
local typo=info.typo
local hp=info.resultHp or 1
if typo==0 then
local image=info.image
comHelper.setChildModelHeadIconBGByColor(headWidget,0,image.color)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
headWidget:SetChildCSImageSprite(2,globalABLookup.global,jobicon)
headWidget:SetChildGray(0,hp==0)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headWidget,modelParams,eHeadCenterType.eHead,nil,hp==0)
else
local mCfg=cfgHelper.get(cfg_monsterconfig_get,typo)
if mCfg then
headWidget:SetChildActive(2,false)
headWidget:SetChildCSImageSprite(0,_abName,_bossKuang[mCfg.monType])
comHelper.setChildModelRawImage_monster(headWidget,typo,1,0,eHeadCenterType.eHead,nil,hp==0)
headWidget:SetChildGray(0,hp==0)
end
end
else
item:SetChildActive(v,false)
end

end
else
item:SetChildActive(teamCmp.hss,false)
item:SetChildActive(teamCmp.nodzTip,true)
item:SetChildActive(teamCmp.winFlag,false)
item:SetChildActive(teamCmp.failFlag,false)
end
end

function UIWDCQFightReplayWin:openFight(logId,log)
local args=self.extraArgs or{}
local fightType=self.fightType
if not fightType then
fightType=args.eReplayType
end
local handle=fightRePlayHandle:getHandle(fightType)
local exchangeHp=handle and handle.exchangeHp
local onComplete=function(battleID)
if handle then
if handle.onCompleteBattle then
handle.onCompleteBattle(battleID,args)
end
end
end

local onClose=function(battleID)
if handle and handle.onCloseBattle then
handle.onCloseBattle(battleID,args)
end
end

local showStage=handle and handle.showStage
if not showStage then
showStage=true
end
local hideExitWatch=handle and handle.hideExitWatch or false

local battleType=handle.battleType
local player1=self.extraArgs.player1 or{}
local player2=self.extraArgs.player2 or{}

local playerName1=player1[2]
if player1[4]then
playerName1=FMT.fmt("{0}{1}",player1[4],player1[2]or'')
end
local playerName2=player2[2]
if player2[4]then
playerName2=FMT.fmt("{0}{1}",player2[4],player2[2]or'')
end

local battleID=fightController:startBallte(log,showStage,onComplete,onClose,{hideExitWatch=hideExitWatch,isRePlay=true,exchangeHp=exchangeHp,battleType=battleType},
{player1={playerName1,player1[3]},player2={playerName2,player2[3]},showWinTimes=false})

if handle and handle.onStartBattle then
handle.onStartBattle(battleID,args)
end
end



