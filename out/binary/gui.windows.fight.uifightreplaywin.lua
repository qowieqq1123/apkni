







def_class("UIFightReplayWin",UIWindowBase)









function UIFightReplayWin:bindComponents()

self.iconHeadItem1=UIObject.get(self,0)
self.iconHeadItem2=UIObject.get(self,1)
self.scrollerView=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.gridContent=UIObject.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIFightReplayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.iconHeadItem1);self.iconHeadItem1=nil;
_UIObject_release(self.iconHeadItem2);self.iconHeadItem2=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gridContent);self.gridContent=nil;
end


















local _abName="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _bossKuang={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}


function UIFightReplayWin:onLoaded(...)
self:bindComponents()
end


function UIFightReplayWin:__delete()
self:unbindComponents()
end




function UIFightReplayWin:onShow(argtable,afterOnloaded)
local fightType=argtable.fightType
self.fightType=fightType
local logStrList=argtable.logStrList
local logIdList=argtable.logIdList or{}
self.extraArgs=argtable.extraArgs
local infoList={}
local resultList={}
for i,fightLog in ipairs(logStrList)do
local fightInfo=fightModel:getJsonReport(fightLog)
local aInfo=fightInfo[fightReportTag.attack]
local dInfo=fightInfo[fightReportTag.defend]
local result=fightInfo[fightReportTag.result]
local aresult=fightInfo[fightReportTag.attackResult]
local dresult=fightInfo[fightReportTag.defendResult]

local aInfoImage=self:getImageList(aInfo,aresult)
local dInfoImage=self:getImageList(dInfo,dresult)

table.insert(resultList,result)
table.insert(infoList,{logId=logIdList[i],fightLog=fightLog,aInfoImage=aInfoImage,dInfoImage=dInfoImage})
end
self:refreshList(infoList)
local handle=fightRePlayHandle:getHandle(fightType)
local multiResultType=handle.mulitResultType or eFightMulitResultType.AndVictory
local result=fightResultController:getMultiResult(multiResultType,resultList)

self:setHead(result)
end








local image={"image_pqjsshengbai_1","image_pqjsshengbai_2","image_pqjsshengbai_3"}
function UIFightReplayWin:setHead(result)
local iconItem1=self.iconHeadItem1:getWidgetBase()
local iconItem2=self.iconHeadItem2:getWidgetBase()
if result==fightResultType.Tie then
iconItem1:SetChildCSImageSprite(4,globalABLookup.global,image[3])
iconItem2:SetChildCSImageSprite(4,globalABLookup.global,image[3])
elseif result==fightResultType.Victory then
iconItem1:SetChildActive(4,true)
iconItem1:SetChildCSImageSprite(4,globalABLookup.global,image[1])
iconItem2:SetChildActive(4,false)
elseif result==fightResultType.Lose then
iconItem1:SetChildActive(4,false)
iconItem2:SetChildActive(4,true)
iconItem2:SetChildCSImageSprite(4,globalABLookup.global,image[1])
end

if self.extraArgs then
local args=self.extraArgs
if args.player1 then
local name=playerModel:getOtherActorName(args.player1[2])
if args.player1[4]then
if not args.player1[2]or args.player1[2]==""then
iconItem1:SetChildText(3,FMT.fmt("{0}\n{1}","未知区服",name))
else
iconItem1:SetChildText(3,FMT.fmt("{0}\n{1}",args.player1[4],name))
end
else
iconItem1:SetChildText(3,name)
end
playerController:setHeadIcon(iconItem1,0,{iconInfo=args.player1[3],scale=1})
else
if args.monId1 then
iconItem1:SetChildText(3,'妖兽')
playerController:setWidgetHeadKuang(iconItem1,1,1)
comHelper.setChildModelRawImage_monsterGroup(iconItem2,args.monId1,5,0,eHeadCenterType.eHead)
end
end
if args.player2 then
local name=playerModel:getOtherActorName(args.player2[2])
if args.player2[4]then
if not args.player2[2]or args.player2[2]==""then
iconItem2:SetChildText(3,FMT.fmt("{0}\n{1}","未知区服",name))
else
iconItem2:SetChildText(3,FMT.fmt("{0}\n{1}",args.player2[4],name))
end
else
iconItem2:SetChildText(3,name)
end


playerController:setHeadIcon(iconItem2,0,{iconInfo=args.player2[3],scale=1})
else
if args.monId2 then
iconItem2:SetChildText(3,'妖兽')
playerController:setWidgetHeadKuang(iconItem2,1,1)
comHelper.setChildModelRawImage_monsterGroup(iconItem2,args.monId2,5,0,eHeadCenterType.eHead)
end
end
end
end

function UIFightReplayWin:getImageList(info,resultAttr)
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
image.clothingId=clothingId
image.clothingStar=clothingStar
table.insert(infoList,{typo=headFlag,image=image,resultHp=resultHp})
else
table.insert(infoList,{typo=headFlag,resultHp=resultHp})
end
end
end
end
return infoList
end

function UIFightReplayWin:refreshList(infoList)

self.scrollerView:setChildScrollViewCreateGrids(#infoList,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local logInfo=infoList[i]
self:refreshLogItem(i,item,logInfo)
end
end

function UIFightReplayWin:refreshLogItem(i,item,logInfo)
item:SetChildText(0,FMT.fmt("第{0}场",i))

if logInfo.aInfoImage then
item:SetChildLayoutGroupCreateItems(2,#logInfo.aInfoImage,function(li)
local LayoutItem=item:GetChildLayoutGroupGridItem(2,li-1)
if LayoutItem then
local typo=logInfo.aInfoImage[li].typo
local hp=logInfo.aInfoImage[li].resultHp or 1
if typo==0 then
local image=logInfo.aInfoImage[li].image
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,LayoutItem,modelParams,eHeadCenterType.eHead,nil,hp==0)
comHelper.setChildModelHeadIconBGByColor(LayoutItem,0,image.color)
LayoutItem:SetChildGray(0,hp==0)
else
local mCfg=cfgHelper.get1(cfg_monsterconfig_get,typo)
LayoutItem:SetChildCSImageSprite(0,_abName,_bossKuang[mCfg.monType])
comHelper.setChildModelRawImage_monster(LayoutItem,typo,1,0,eHeadCenterType.eHead,nil,hp==0)
LayoutItem:SetChildGray(0,hp==0)
end
end
end)
end

if logInfo.dInfoImage then
item:SetChildLayoutGroupCreateItems(3,#logInfo.dInfoImage,function(li)
local LayoutItem=item:GetChildLayoutGroupGridItem(3,li-1)
if LayoutItem then
local typo=logInfo.dInfoImage[li].typo
local hp=logInfo.dInfoImage[li].resultHp or 1
if typo==0 then
local image=logInfo.dInfoImage[li].image
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,LayoutItem,modelParams,eHeadCenterType.eHead,nil,hp==0)
comHelper.setChildModelHeadIconBGByColor(LayoutItem,0,image.color)
LayoutItem:SetChildGray(0,hp==0)
else
local mCfg=cfgHelper.get(cfg_monsterconfig_get,typo)
if mCfg then
LayoutItem:SetChildCSImageSprite(0,_abName,_bossKuang[mCfg.monType])
comHelper.setChildModelRawImage_monster(LayoutItem,typo,1,0,eHeadCenterType.eHead,nil,hp==0)
LayoutItem:SetChildGray(0,hp==0)
end
end
end
end)
end

item:SetChildButtonClick(4,function()
self:openFight(logInfo.logId,logInfo.fightLog)
end)
end

function UIFightReplayWin:openFight(logId,log)
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


function UIFightReplayWin:onHide()

end





function UIFightReplayWin:onCloseBtn()
self:closeSelf()
end

