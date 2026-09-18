







def_class("UILittleGame_CatchLingShouWin",UIWindowBase)









function UILittleGame_CatchLingShouWin:bindComponents()

self.boneEffectList=UIObject.get(self,0)
self.centerLayout=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.costMoneyCount=UIText.get(self,3)
self.costMoneyIcon=UIObject.get(self,4)
self.costPart=UIObject.get(self,5)
self.effect=UIObject.get(self,6)
self.effectMovePoint=UIObject.get(self,7)
self.flyEffectList=UIObject.get(self,8)
self.gamePart=UIObject.get(self,9)
self.infoPart=UIObject.get(self,10)
self.infoSpineBg=UIObject.get(self,11)
self.itemsPart=UIObject.get(self,12)
self.leftInfoPart=UIObject.get(self,13)
self.lingShouDaiPart=UIObject.get(self,14)
self.logContent=UIObject.get(self,15)
self.logScrollView=UIObject.get(self,16)
self.lsdList=UIObject.get(self,17)
self.movePart=UIObject.get(self,18)
self.Root=UIObject.get(self,19)
self.ruleBtn=UIButton.get(self,20)
self.spineBg=UIObject.get(self,21)
self.uiRoot=UIObject.get(self,22)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UILittleGame_CatchLingShouWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.boneEffectList);self.boneEffectList=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costMoneyCount);self.costMoneyCount=nil;
_UIObject_release(self.costMoneyIcon);self.costMoneyIcon=nil;
_UIObject_release(self.costPart);self.costPart=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effectMovePoint);self.effectMovePoint=nil;
_UIObject_release(self.flyEffectList);self.flyEffectList=nil;
_UIObject_release(self.gamePart);self.gamePart=nil;
_UIObject_release(self.infoPart);self.infoPart=nil;
_UIObject_release(self.infoSpineBg);self.infoSpineBg=nil;
_UIObject_release(self.itemsPart);self.itemsPart=nil;
_UIObject_release(self.leftInfoPart);self.leftInfoPart=nil;
_UIObject_release(self.lingShouDaiPart);self.lingShouDaiPart=nil;
_UIObject_release(self.logContent);self.logContent=nil;
_UIObject_release(self.logScrollView);self.logScrollView=nil;
_UIObject_release(self.lsdList);self.lsdList=nil;
_UIObject_release(self.movePart);self.movePart=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.spineBg);self.spineBg=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local cjson=require'cjson'

local _gameItemCmpIndex={
result=0,
mask=1,
hulu=2,
by=3,
lingshou=4,
up=5,
itemIcon=6,
itemCount=7,
endGame=8,
}




function UILittleGame_CatchLingShouWin:onLoaded(...)
self:bindComponents()

_this=self

self.effectMovePointPos=self.effectMovePoint:getChildPosition()
self.lsdItemList=self.lsdList:getChildCommonLayoutGroupWidgetList()
self.gameItemList=self.itemsPart:getChildCommonLayoutGroupWidgetList()
self.logItemList=self.logContent:getChildCommonLayoutGroupWidgetList()
self.moveItemList=self.movePart:getChildCommonLayoutGroupWidgetList()
self.flyEffectItemList=self.flyEffectList:getChildCommonLayoutGroupWidgetList()
self.boneEffectItemList=self.boneEffectList:getChildCommonLayoutGroupWidgetList()

local _recv_19_101=function(...)
if _this==nil then return end
_this:recv_19_101(...)
_this.isClicked=false
end
self:addProNotify(19,101,_recv_19_101)

local _recv_19_102=function(gameInfo)
if _this==nil then return end
_this:recv_19_102(gameInfo)
_this.isClicked=false
end
self:addProNotify(19,102,_recv_19_102)

end


function UILittleGame_CatchLingShouWin:__delete()
_this=nil
self:removeOpenBT()
resolutionUtility:hideTopMaskWin()
self:unbindComponents()
end




function UILittleGame_CatchLingShouWin:onShow(argtable,afterOnloaded)

self.args=argtable
self.gameGuid=argtable.gameGuid
self.gameGuidStr=tostring(self.gameGuid)
self.gameConfId=UICatchLingShouModel:getGameInfoData(self.gameGuidStr,'gameConfId')
local len2=UICatchLingShouModel:getGameInfoData(self.gameGuidStr,'len2')

if self.args.startCallback then
self.args.startCallback()
end

self.isNeedPlayBeginAnimation=afterOnloaded and len2<=0

self:initData()
self:refreshAll()

self:playEnterAnimation()
resolutionUtility:showTopMaskWin()
end


function UILittleGame_CatchLingShouWin:onHide()
resolutionUtility:hideTopMaskWin()
end



function UILittleGame_CatchLingShouWin:onRuleBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eZhuaChongYouXi,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end

function UILittleGame_CatchLingShouWin:onCloseBtn()
local endFlag=UICatchLingShouModel:getGameInfoData(_this.gameGuidStr,'endFlag')
if endFlag==1 then
if self.args.callback then
self.args.callback(1,1)
notifySystem:postNotify(notifyConfig.onLingShouCatchLittleGameEnd,self.args.guid)
end
self:closeSelf()
else
UILittleGameController:quitTips_CatchLingShou(function()
if self.args.callback then
self.args.callback(0,1)
end
self:closeSelf()
end)
end
end


function UILittleGame_CatchLingShouWin:recv_19_101(index,gameInfo,len,lsGuidList)
local guidStr=tostring(gameInfo.gameGuid)
if guidStr~=self.gameGuidStr then return end

local isEnd=gameInfo.endFlag==1
local bzlsItemLookup=UICatchLingShouModel:getGameInfoData(guidStr,'bzlsItemLookup')

local item=self.gameItemList[index-1]
self:playGameItemOpenEx(index,item,true,bzlsItemLookup[index],isEnd)
end

function UILittleGame_CatchLingShouWin:recv_19_102()


end

function UILittleGame_CatchLingShouWin:checkEnd()
self.isPlayAnim=false
local endFlag=UICatchLingShouModel:getGameInfoData(_this.gameGuidStr,'endFlag')
if endFlag==1 then
self.effect:setChildShowEffect(22657,true)
self:delayDo(2,function()
local getLSLen=UICatchLingShouModel:getGameInfoData(_this.gameGuidStr,'getLSLen')
local lsGuidList=UICatchLingShouModel:getGameInfoData(_this.gameGuidStr,'lsGuidList')
if getLSLen>0 then
_this.lsGuidList=lsGuidList
_this.count=getLSLen
_this:startShowLingShouInfoGetWin()
end
end)
end
end



function UILittleGame_CatchLingShouWin:startShowLingShouInfoGetWin()
if self.count>0 then
local datas={}
for index,guid in ipairs(self.lsGuidList)do
datas[#datas+1]=lingshouModel:getLingShouData2(guid)
end
local args={
lslist=datas,
closeCallBack=function()
_this:startShowLingShouInfoGetWin()
end,
}
yushoufangController:onShowLingShouInfoWin(args,_this)

self.count=0
else
self:onCloseBtn()
end
end


function UILittleGame_CatchLingShouWin:initData()
self.count=0
self.lsGuidList=nil
self.isPlayAnim=false
end

function UILittleGame_CatchLingShouWin:refreshAll()
self:refreshLeft()

self:refreshRight()
end

function UILittleGame_CatchLingShouWin:refreshLeft()
self:refreshLingShouDai()

self:refreshLogList()

self:refreshCost()
end

function UILittleGame_CatchLingShouWin:refreshLeftEx()
self:refreshLogList()

self:refreshCost()
end

function UILittleGame_CatchLingShouWin:refreshLingShouDai()
local pocketList=UICatchLingShouModel:getGameInfoData(self.gameGuidStr,'pocketList')or defaultT

for index=1,self.lsdItemList.Count do
local lsdItem=self.lsdItemList[index-1]
local lsdData=pocketList[index]
local isShow=lsdData~=nil
lsdItem:SetChildActive(-1,isShow)
if isShow then



local quality=lsdData.param_1
local qualityIconName=string.format("image_lvyxz_pz%d",quality)
lsdItem:SetChildCSImageSprite(0,"ui/windows/littlegame/catchlingshou_atlas_pak.ab",qualityIconName)



lsdItem:SetBaseItemClickEvent(-1,function()
if _this==nil then return end

_this:showWindow("UILittle_CatchLingShouPreRewardWin",{gameID=_this.gameConfId,quality=quality})
end)
end
end
end

function UILittleGame_CatchLingShouWin:splitStr(str)
return cjson.decode(str)
end

local _logParseCMD={
[1]=function(args)
local quality=args[3]
local str=FMT.cfmt(quality,eQualityColorName[quality])
return{str}
end,
[2]=function(args)
local itemDatas=args[3]

local itemListStr
if itemDatas and next(itemDatas)then
for index,itemData in ipairs(itemDatas)do
local itemID=itemData[1]
local itemCount=itemData[2]

local name=itemsConfig.getItemName(itemID)
local color=itemsConfig.getItemColor(itemID)
local sStr=FMT.fmt("{0}*{1}",name,itemCount)
sStr=FMT.cfmt(color,sStr)

itemListStr=itemListStr and FMT.fmt("{0},{1}",itemListStr,sStr)or sStr
end
end

itemListStr=itemListStr or""
return{itemListStr}
end,
[3]=function(args)
local count=args[3]

local str=FMT.fmt("灵兽袋+{0}",count)
str=FMT.cfmt(eQualityColor.eOrange,str)

return{str}
end,
}

function UILittleGame_CatchLingShouWin:getLogParse(json_str)
local tbstr=self:splitStr(json_str)
local logId=tbstr[1]
local logType=cfgHelper.get(cfg_buzhuolingshoulogconfig_get,logId,'logType')
local cmd=_logParseCMD[logType]or _logParseCMD[0]
local logArgs=cmd and cmd(tbstr)or defaultT
local logFmt=cfgHelper.get(cfg_buzhuolingshoulogconfig_get,logId,'content')
local logStr=FMT.fmt(logFmt,unpack(logArgs))

return logStr
end

function UILittleGame_CatchLingShouWin:refreshLogList()
local logList=UICatchLingShouModel:getGameInfoData(self.gameGuidStr,'logList')or defaultT

logList=table.reverse(logList)

for index=1,self.logItemList.Count do
local logItem=self.logItemList[index-1]
local logJsonString=logList[index]
local isShow=logJsonString~=nil
logItem:SetChildActive(-1,isShow)
if isShow then
local logStr=self:getLogParse(logJsonString)
logStr=FMT.fmt("{0}{1}","<color='ffffff00'>    </color>",logStr)
logStr=string.replaceSpace(logStr)
logItem:SetChildText(0,logStr)
end
end
end

function UILittleGame_CatchLingShouWin:refreshCost()
local useItem=UICatchLingShouModel:getFindUseItem(self.gameGuidStr)

local itemID=useItem[1]
local needItemCount=useItem[2]

local itemIcon=itemsModel.getItemIconName(itemID)
self.costMoneyIcon:setIcon(itemIcon,false)
self.costMoneyCount:setText(FMT.fmt("x {0}",mathHelper.formatNumber4(needItemCount,2)))

UIManager:showWindow('UITopMoneyWin',{{itemID}})
end

function UILittleGame_CatchLingShouWin:refreshRight()
local probeList=UICatchLingShouModel:getGameInfoData(self.gameGuidStr,'probeList')or defaultT
local bzlsItemLookup=UICatchLingShouModel:getGameInfoData(self.gameGuidStr,'bzlsItemLookup')or defaultT

for index=1,self.gameItemList.Count do
local isOpen=table.findValue(probeList,index)~=nil
local item=self.gameItemList[index-1]

self:refreshGameItem(index,item,isOpen,bzlsItemLookup[index])
end
end

local _dataType={
up=1,
lsNum=2,
endGame=3,
item=4,
}
function UILittleGame_CatchLingShouWin:refreshGameItem(index,item,isOpen,itemDatas)

item:SetChildActive(_gameItemCmpIndex.result,isOpen)
item:SetChildActive(_gameItemCmpIndex.mask,not isOpen)

if isOpen then
self:refreshGameItemEx(index,item,isOpen,itemDatas,true)
else
local maskAniID=self.isNeedPlayBeginAnimation and 3630 or 3631
item:SetChildSpineAnimation(_gameItemCmpIndex.mask,maskAniID,1,function()end)
end

item:SetBaseItemClickEvent(-1,function()
if _this==nil then return end
if _this.isPlayAnim then return end
if _this.isClicked then return end
local endFlag=UICatchLingShouModel:getGameInfoData(_this.gameGuidStr,'endFlag')
local isEnd=endFlag==1
if isEnd then



return
end
if isOpen then return end


local cost=UICatchLingShouModel:getFindUseItem(_this.gameGuidStr)
local isEnough=itemsModel.checkItemEnough(cost[1],cost[2])
if isEnough then
_this.isClicked=true
UICatchLingShouController.req_open_obstruction(_this.gameGuid,index)
else
gainControl:showGainWin(cost[1],cost[2])
end
end)
end

local _typeOffSet={
[_dataType.lsNum]={2,5},
[_dataType.up]={2,0},
[_dataType.item]={2,0},
[_dataType.endGame]={0,0},

}
local _byQualityAnimationID={3671,3649,3650,3647,3648}
function UILittleGame_CatchLingShouWin:refreshGameItemEx(index,item,isOpen,itemDatas,isInit)
local type=itemDatas[2]
local data=itemDatas[3]

local isLingshou=type==_dataType.lsNum
local isUpQuality=type==_dataType.up
local isItem=type==_dataType.item
local isEnd=type==_dataType.endGame

local isShowBy=true
if isLingshou or isUpQuality then
isShowBy=not isInit or not isOpen
end

item:SetChildActive(_gameItemCmpIndex.lingshou,isLingshou and(not isInit or not isOpen))
item:SetChildActive(_gameItemCmpIndex.up,isUpQuality and(not isInit or not isOpen))
item:SetChildActive(_gameItemCmpIndex.itemIcon,isItem)
item:SetChildActive(_gameItemCmpIndex.endGame,isEnd)

local byid=_byQualityAnimationID[4]

if isItem then
local itemID=data[1][1]
local itemCount=data[1][2]
local color=itemsConfig.getItemColor(itemID)
byid=_byQualityAnimationID[color]

local iconName=itemsModel.getIconName({itemid=itemID})
item:SetChildIcon(_gameItemCmpIndex.itemIcon,iconName,true)
item:SetChildText(_gameItemCmpIndex.itemCount,itemCount)
elseif isLingshou then
local lsdIconName=string.format("icon_lvyxz_pz%d",data[1])
item:SetChildCSImageSprite(_gameItemCmpIndex.lingshou,"ui/windows/littlegame/catchlingshou_atlas_pak.ab",lsdIconName)
elseif isEnd then
local lsGuidList=UICatchLingShouModel:getGameInfoData(_this.gameGuidStr,'lsGuidList')
local _,lsGuid=next(lsGuidList)
local lsData=lingshouModel:getLingShouData2(lsGuid)
byid=_byQualityAnimationID[lsData.cfg.color]
local modelParams,scale,offset=lingshouModel:getLingShouInsideModelInfo(lsGuid)
scale=scale*0.4
item:SetChildUIModelShowTarget(_gameItemCmpIndex.endGame,modelParams.body,scale,modelParams.componets,0,false,true)
item:SetChildUIModelShowTargetOffset(_gameItemCmpIndex.endGame,offset[1],-50)
end

if isShowBy then
local scale=isEnd and 1.5 or 1
item:SetChildUIModelShowTarget(_gameItemCmpIndex.by,6519,scale,nil,byid)
local offset=_typeOffSet[type]
item:SetChildUIModelShowTargetOffset(_gameItemCmpIndex.by,offset[1],offset[2])
end
end

local _bezierPath={
[1]={Vector2.New(-0.3,-0.2),Vector2.New(-0.2,-0.3),0.8},
[2]={Vector2.New(-0.3,-0.2),Vector2.New(-0.2,-0.3),0.8},
[3]={Vector2.New(-0.3,-0.2),Vector2.New(-0.2,-0.3),1},
[4]={Vector2.New(0.6,0.1),Vector2.New(0.1,0.6),0.8},
[5]={Vector2.New(0.6,0.1),Vector2.New(0.1,0.6),1},
[6]={Vector2.New(0.6,0.1),Vector2.New(0.1,0.6),1},
[7]={Vector2.New(0.6,0.1),Vector2.New(0.1,0.6),0.8},
[8]={Vector2.New(0.6,0.1),Vector2.New(0.1,0.6),1},
[9]={Vector2.New(0.6,0.1),Vector2.New(0.1,0.6),1},
}

function UILittleGame_CatchLingShouWin:flyEffect(index,callback)
local eitem=_this.flyEffectItemList[index-1]

local endPos=self.effectMovePoint:getChildPosition()

local path=_bezierPath[index]
local oSidler=path[1]
local eSidler=path[2]
local duration=path[3]

eitem:SetChildDoMovePathWithSlider(-1,endPos,oSidler,eSidler,duration,0.001,callback)
end

function UILittleGame_CatchLingShouWin:removeOpenBT()
if self.openBT then
behaviorManager:removeBehaviorTree(self.openBT)
self.openBT=nil
end
end

function UILittleGame_CatchLingShouWin:playGameItemOpenEx(index,item,isOpen,itemDatas,isEnd)
self.isPlayAnim=true

self:removeOpenBT()

local showType=itemDatas[2]


local fadeIndex
if showType==_dataType.up then
fadeIndex=_gameItemCmpIndex.up
elseif showType==_dataType.lsNum then
fadeIndex=_gameItemCmpIndex.lingshou
end

local endPos=self.effectMovePoint:getChildPosition()

self:refreshGameItemEx(index,item,isOpen,itemDatas,false)

local initData={
winName='UILittleGame_CatchLingShouWin',
winlua=self.winlua,
gindex=index,
widget=item,

showType=showType,
endPos=endPos,


huluIndex=_gameItemCmpIndex.hulu,
grassMaskIndex=_gameItemCmpIndex.mask,
resultPartIndex=_gameItemCmpIndex.result,
fadeItemIndex=fadeIndex,
byIndex=_gameItemCmpIndex.by,


huluModelID=6512,
huluModelAnimatID=3646,
huluModelFadeIn=0.2,
huluModelOffset={100,20},


disappearWaitTime=0.8,


itemFadeTime=0.5,


boneWaitTime=0.45,
boneEffectItem=_this.boneEffectItemList[index-1],
boneEffectID=22696,


flyEffectItem=_this.flyEffectItemList[index-1],
flyEffectItemTransform=_this.flyEffectItemList[index-1]:GetChildGameObject(-1).transform,
flyEffectID=22697,

oSiler=_bezierPath[index][1],
eSiler=_bezierPath[index][2],
flyDuration=_bezierPath[index][3],

flyRate=0.001,


endBoneIndex=self.effectMovePoint:getID(),
endBoneEffectID=22698,

}

self.openBT=behaviorManager:addBehaviorTree('bt_ui_ls_game_open_item',nil,true,initData)
self.openBT:setSharedVar('showType',showType)
end

function UILittleGame_CatchLingShouWin:itemGrassShake(index)
local item=self.gameItemList[index-1]
item:SetChildSpineAnimation(_gameItemCmpIndex.mask,3632,1,function()end)
end

function UILittleGame_CatchLingShouWin:playGameItemOpen(index,item,isOpen,itemDatas,isEnd)
self.isPlayAnim=true

local item=self.gameItemList[index-1]
local type=itemDatas[2]

self:refreshGameItemEx(index,item,isOpen,itemDatas,false)
item:SetChildActive(_gameItemCmpIndex.hulu,true)
item:SetChildActive(_gameItemCmpIndex.result,true)
item:SetChildUIModelShowTarget(_gameItemCmpIndex.hulu,6512,1,nil,3646,false,false,0)
item:SetChildUIModelShowTargetOffset(_gameItemCmpIndex.hulu,100,20)

self:delayDo(0.8,function()
item:SetChildSpineAnimation(_gameItemCmpIndex.mask,3632,1,function()end)
end)


if type==_dataType.lsNum then
self:delayDo(1.3,function()
item:SetChildCanvasGroupDOFade(_gameItemCmpIndex.lingshou,0,0.5,nil)

_this.boneEffectList[index-1]:SetChildShowEffect(-1,22696,true)
_this:delayDo(0.45,function()
item:SetChildActive(_gameItemCmpIndex.by,false)
local eitem=_this.flyEffectItemList[index-1]
eitem:SetChildShowEffect(-1,22697,true)

_this:flyEffect(index,function()
_this:refreshLingShouDai()
item:SetChildActive(_gameItemCmpIndex.mask,false)
item:SetChildUIModelRemoveTarget(_gameItemCmpIndex.hulu)
_this:delayDo(0.2,function()
eitem:SetChildShowEffect(-1,22697,false)
_this:checkEnd()
end)
end)
end)
end)
elseif type==_dataType.up then
self:delayDo(1.3,function()
item:SetChildCanvasGroupDOFade(_gameItemCmpIndex.up,0,0.5,nil)

_this.boneEffectList[index-1]:SetChildShowEffect(-1,22696,true)
_this:delayDo(0.45,function()
item:SetChildActive(_gameItemCmpIndex.by,false)
local eitem=_this.flyEffectItemList[index-1]
eitem:SetChildShowEffect(-1,22697,true)
_this:flyEffect(index,function()
_this:refreshLingShouDai()
item:SetChildActive(_gameItemCmpIndex.mask,false)
item:SetChildUIModelRemoveTarget(_gameItemCmpIndex.hulu)
_this:delayDo(0.2,function()
eitem:SetChildShowEffect(-1,22697,false)
_this:checkEnd()
end)
end)
end)
end)
elseif type==_dataType.endGame then
_this:refreshLeftEx()

self:delayDo(2,function()
item:SetChildActive(_gameItemCmpIndex.mask,false)
item:SetChildUIModelRemoveTarget(_gameItemCmpIndex.hulu)
_this:checkEnd()
end)
else
_this:refreshLeftEx()

self:delayDo(2.3,function()
item:SetChildActive(_gameItemCmpIndex.mask,false)
item:SetChildUIModelRemoveTarget(_gameItemCmpIndex.hulu)
_this:checkEnd()
end)
end
end

function UILittleGame_CatchLingShouWin:playEnterAnimation()
self.isPlayAnim=true
if self.isNeedPlayBeginAnimation then
self:playBeginEnterAnimation()

else
self:showInfoPart()
end
end

function UILittleGame_CatchLingShouWin:showInfoPart()
self.infoPart:setChildCanvasGroupAlpha(0)
self.infoSpineBg:setChildSpineAnimation(3635,1,function()
_this.infoPart:setChildCanvasGroupDOFade(1,0.2)
_this.isPlayAnim=false
end)
end












local _pathNode={
{3,2,4,0},{1,5,8,0.1},{2,4,6,0.4},{7,8,5,0.5},{6,5,4,0.6},{4,9,8,0.9},{8,6,3,1},{5,9,8,1.1}
}
local _animtrans={{3639,-80,20},{3640,0,-90},{3641,50,-40},{3638,0,-40},{3642,0,-40},{3645,-40,0},{3644,10,90},{3643,10,0}}
function UILittleGame_CatchLingShouWin:playBeginEnterAnimation()
self.infoPart:setChildCanvasGroupAlpha(0)
self.infoSpineBg:setChildSpineAnimation(3636,1,function()end)

local moveRandList=_pathNode

for index=1,#moveRandList do

local path=moveRandList[index]
local sitemIdx=path[1]
local mitemIdx=path[2]
local animIdx=path[3]
local delayTime=path[4]

local item=self.moveItemList[sitemIdx-1]
local gitem=self.gameItemList[sitemIdx-1]
self:delayDo(delayTime,function()
local trans=_animtrans[animIdx]
item:SetChildActive(-1,true)
item:SetChildUIModelShowTarget(-1,6515,1,nil,trans[1],false,false,0)
item:SetChildUIModelShowTargetOffset(-1,trans[2],trans[3])
gitem:SetChildSpineAnimation(_gameItemCmpIndex.mask,3634,1,function()end)
_this:delayDo(0.6,function()
local mitem=self.gameItemList[mitemIdx-1]
mitem:SetChildSpineAnimation(_gameItemCmpIndex.mask,3634,1,function()end)
end)
end)
end

self:delayDo(2,function()
for index=1,9 do
local item=self.moveItemList[index-1]
item:SetChildActive(-1,false)
end
end)

self:delayDo(2.1,function()
for index=1,9 do
local item=self.gameItemList[index-1]
item:SetChildSpineAnimation(_gameItemCmpIndex.mask,3633,1,function()end)
end
end)

self:delayDo(2,function()
self:showInfoPart()
end)

self:delayDo(3,function()
self.effect:setChildShowEffect(22656,true)
end)
end


function UILittleGame_CatchLingShouWin:testAnim(itemindex,animindex,x,y)
local item=self.moveItemList[itemindex-1]
item:SetChildActive(-1,true)
item:SetChildUIModelRemoveTarget(-1)
item:SetChildUIModelShowTarget(-1,6515,1,nil,animindex)
item:SetChildUIModelShowTargetOffset(-1,x,y)
end

function UILittleGame_CatchLingShouWin:testOpen(index)
local item=self.gameItemList[index-1]

self:delayDo(2.8,function()
local eitem=_this.flyEffectItemList[index-1]
eitem:SetChildShowEffect(-1,10077,true)
eitem:SetChildDOMove(-1,_this.effectMovePointPos,1,function()
_this:refreshLeft()
item:SetChildActive(_gameItemCmpIndex.mask,false)
item:SetChildUIModelRemoveTarget(_gameItemCmpIndex.hulu)
_this:delayDo(1.5,function()
eitem:SetChildShowEffect(-1,10077,false)
_this:checkEnd()
end)
end)
end)
end

function UILittleGame_CatchLingShouWin:testPlayEff(index)
local eitem=_this.flyEffectItemList[index-1]
eitem:SetChildShowEffect(-1,22697,true)
self:flyEffect(index)
end

