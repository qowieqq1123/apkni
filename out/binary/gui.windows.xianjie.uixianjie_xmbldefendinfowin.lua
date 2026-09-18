







def_class("UIXianJie_XMBLDefendInfoWin",UIWindowBase)









function UIXianJie_XMBLDefendInfoWin:bindComponents()

self.background=UIButton.get(self,0)
self.cancelAllBtn=UIButton.get(self,1)
self.cancelBtn=UIButton.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.content=UIObject.get(self,4)
self.helpBtn=UIButton.get(self,5)
self.jumpBtn=UIButton.get(self,6)
self.list=UIObject.get(self,7)
self.none=UIObject.get(self,8)
self.operationPart=UIObject.get(self,9)
self.progress=UIProgress.get(self,10)
self.refreshBtn=UIButton.get(self,11)
self.refreshReddot=UIObject.get(self,12)
self.sendBtn=UIButton.get(self,13)
self.titleTx=UIText.get(self,14)

self.background:setButtonClick(function()self:onBackground()end)

self.cancelAllBtn:setButtonClick(function()self:onCancelAllBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.sendBtn:setButtonClick(function()self:onSendBtn()end)



end


function UIXianJie_XMBLDefendInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.cancelAllBtn);self.cancelAllBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.none);self.none=nil;
_UIObject_release(self.operationPart);self.operationPart=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.refreshReddot);self.refreshReddot=nil;
_UIObject_release(self.sendBtn);self.sendBtn=nil;
_UIObject_release(self.titleTx);self.titleTx=nil;
end















local _this=nil
local _itemCmp={
root=-1,
teamGrid=0,
retreatBtn=1,
selfImage=2,
panel2=3,
headBG=4,
fightValue=5,
head=6,
xbValue=7,
levelTx=8,
playerName=9,
infoGrid=10,
arrowBtn=11,
arrow1=12,
arrow2=13,
retreatTx=14,
}
local _iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"



function UIXianJie_XMBLDefendInfoWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(35,156,self.on_35_156)
self:addProNotify(35,157,self.on_35_157)
end


function UIXianJie_XMBLDefendInfoWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJie_XMBLDefendInfoWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.guildId=argtable.guild
self:updateData()
self:refreshView()
end


function UIXianJie_XMBLDefendInfoWin:onHide()

end




function UIXianJie_XMBLDefendInfoWin:onBackground()
self:onCloseBtn()
end


function UIXianJie_XMBLDefendInfoWin:onJumpBtn()
if self.data and not xianjieModel:isInMoJie()then
if xianjieModel:checkCurrentMoJieEnterTime()then
UIDialogManager.getCommonDialog(nil,"驻防仙盟堡垒需要前往魔界\n祖师是否前往魔界?",function()
local sceneType=xianjieModel:getCurrentMoJieSceneType()
local guildId=self.guildId
xianjieController:jumpXianJie(sceneType,nil,function()
xianjieController:openXianMengWin(guildId)
end)
end)
else
UIManager.error("魔界尚未开启，无法驻防")
end
end
end


function UIXianJie_XMBLDefendInfoWin:onCancelBtn()
if self.data and xianmengModel:isMyXM2(self.guildId)then
if self.ownerIdx then
local guildId=self.guildId
UIDialogManager.getCommonDialog(nil,"是否撤回派遣援军",function()
local param=jsonHelper.encode({playerModel:getActorIDStr()})
xianjieController:reqOrder(guildId,xjOrderType.eDefendXianMengBack,{},{},param,0,nil,{})
xianjieController:send_35_156(guildId)
end)
else
UIManager.error("未派遣援军")
end
end
end


function UIXianJie_XMBLDefendInfoWin:onCancelAllBtn()
if self.data and xianmengModel:isMyXM2(self.guildId)then
if xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptDevildomDaZhen)then
local actors={}
local myActorId=playerModel:getActorID()
for i,v in ipairs(self.data.team)do
if playerModel:checkActorId(v.actor_id)or xianmengModel.compareTwoActorPost(myActorId,v.actor_id,1)then
table.insert(actors,v.actor_id)
end
end
if#actors>0 then
local guildId=self.guildId
UIDialogManager.getCommonDialog(nil,"是否撤回全部援军",function()
local myActorId=playerModel:getActorID()
for i,v in ipairs(actors)do
local param=jsonHelper.encode({mathHelper.int64_to_string(v)})
xianjieController:reqOrder(guildId,xjOrderType.eDefendXianMengBack,{},{},param,0,nil,{})
end
xianjieController:send_35_156(guildId)
end)
else
UIManager.info("暂无可撤回援军")
end
else
UIManager.error("仙盟权限不足")
end
end
end


function UIXianJie_XMBLDefendInfoWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIXianJie_XMBLDefendInfoWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='xianmengdazhen_defendinfo_help_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UIXianJie_XMBLDefendInfoWin:onRefreshBtn()
if self.data then
if self.data.serverTime>self.data.clientTime then
xianjieController:send_35_156(self.guildId)
else
UIManager.info("已是最新信息")
end
end
end


function UIXianJie_XMBLDefendInfoWin:onSendBtn()
if self.data and xianmengModel:isMyXM2(self.guildId)and xianjieModel:isInMoJie()then
if not self.ownerIdx then
if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

local guildData=xianjieModel:getXianMengData(self.guildId)
local flag,g_list=guildData:checkMovePathCondition()
if not flag then
UIManager.error("无法派遣到达目的地")
return
end

local orderType=xjOrderType.eDefendXianMeng
local guid=self.guildId
local wayTime=guildData:getBaseWayTime()
local func=function(selectDzList,selectMoneyList,boatId)
local params=jsonHelper.encode({playerModel:getActorIDStr()})
xianjieController:reqOrder(guid,xjOrderType.eDefendXianMeng,selectDzList,selectMoneyList,params,boatId,nil,g_list)
end
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,wayTime=wayTime,orderType=orderType})
else
UIManager.error("已派遣援军")
end
end
end

function UIXianJie_XMBLDefendInfoWin:updateData()
self.data=xianjieModel:getXianMengGarrison(self.guildId)
self.ownerIdx=nil
if self.data and xianmengModel:isMyXM2(self.guildId)then
for i,v in ipairs(self.data.team)do
if playerModel:checkActorId(v.actor_id)then
self.ownerIdx=i
break
end
end
end

if self.expands then
table.clear(self.expands)
else
self.expands={}
end
end

function UIXianJie_XMBLDefendInfoWin:refreshView()
if self.data~=nil then
self:refreshViewByData()
else
self:refreshViewByEmpty()
end
end

function UIXianJie_XMBLDefendInfoWin:refreshViewByEmpty()
self.titleTx:setText("")
self.progress:setProgressValue(0,10000)
self.progress:setChildProgressText("")
self.list:setChildLayoutGroupCreateItems(0)
self.none:setActive(false)
self.operationPart:setActive(false)
self.winlua:ForceLayoutRect(self.content:getID())
end

function UIXianJie_XMBLDefendInfoWin:refreshViewByData()
local isMyXM=xianmengModel:isMyXM2(self.guildId)
local isInMoJie=xianjieModel:isInMoJie()
local xmData=xianjieModel:getXianMengData(self.guildId)
local canRetreatAll=xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptDevildomDaZhen)
self.titleTx:setText(not isInMoJie and"驻防仙盟堡垒"or FMT.fmt("{0}堡垒",xmData.guildname))

local listData=self.data.team or defaultT
local listCnt=#listData
self.list:setChildLayoutGroupCreateItems(listCnt,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local data=listData[index]
item:SetChildButtonClick(_itemCmp.arrowBtn,function()
self:onClickArrowBtn(index)
end)
item:SetChildButtonClick(_itemCmp.retreatBtn,function()
self:onClickRereatBtn(index)
end)
item:SetChildButtonClick(_itemCmp.headBG,function()
self:onClickPlayer(index)
end)

local dzList={}
for i=1,data.disciplelistlen do
local baseData=data.guidlist[i]

if next(baseData)~=nil and(baseData.flag==nil or baseData.flag>0)then
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3(baseData)
table.insert(dzList,dzData)
end
end
item:SetChildLayoutGroupCreateItems(_itemCmp.teamGrid,#dzList,function(_index)
local _item=item:GetChildLayoutGroupGridItem(_itemCmp.teamGrid,_index-1)
local dzData=dzList[_index]
local baseData=dzData.base

local dizi_guid=baseData.discipleguid
local discipledata=baseData.discipledata
local discipleimage=baseData.discipleimage
local jingjielv=baseData.jingjielv
local image=UIDiscipleModel.calculationDiscipleImage(discipledata,discipleimage)

comHelper.setChildModelHeadIconBGByColor(_item,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,_item,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
_item:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
_item:SetChildCSImageSprite(4,globalABLookup.diciplecolorframe,discipleColorToFrame3[image.color])
_item:SetChildActive(4,jingjielv>0)
_item:SetChildText(5,jingjielv)

local func=function()
otherPlayerController:openOtherPlayerDZInfoWinEXX(data.actor_id,dzList,dizi_guid)
end
_item:SetChildButtonClick(-1,func,true)
end)
item:SetChildActive(_itemCmp.selfImage,playerModel:checkActorId(data.actor_id))
local isSelf=playerModel:checkActorId(data.actor_id)
local canRetreat=canRetreatAll and xianmengModel.compareTwoActorPost(playerModel:getActorID(),data.actor_id,1)
local showRetreat=isMyXM and(isSelf or canRetreat)
item:SetChildActive(_itemCmp.retreatBtn,showRetreat)
local retreatStr=""
if isMyXM then
if isSelf then
retreatStr="撤回"
elseif canRetreat then
retreatStr="遣返"
end
end
item:SetChildText(_itemCmp.retreatTx,retreatStr)
local fightStr=mathHelper.formatNumber(mathHelper.int64_to_number(data.fightvalue))
item:SetChildText(_itemCmp.fightValue,FMT.fmt("战力：{0}",fightStr))
local xsNum=0
if data.moneylistlen>0 then
local lookup={}
local list={}
for i,v in ipairs(data.moneylist)do
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(v.param_1)
if soldierLevel and soldierLevel>0 then
lookup[soldierLevel]=(lookup[soldierLevel]or 0)+v.param_2
xsNum=xsNum+v.param_2
table.insert(list,soldierLevel)
end
end
item:SetChildLayoutGroupCreateItems(_itemCmp.infoGrid,#list,function(_index)
local _item=item:GetChildLayoutGroupGridItem(_itemCmp.infoGrid,_index-1)
local soldierLevel=list[index]
local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,soldierLevel)
_item:SetChildCSImageSprite(0,_iconAb,cfg.bgIcon)
_item:SetChildCSImageSprite(1,_iconAb,cfg.nameIcon)
_item:SetChildText(2,lookup[soldierLevel]or 0)
end)
else
item:SetChildLayoutGroupCreateItems(_itemCmp.infoGrid,0)
end
local expand=self.expands[index]
item:SetChildActive(_itemCmp.panel2,data.moneylistlen>0 and expand~=false)
item:SetChildActive(_itemCmp.arrow1,data.moneylistlen>0 and expand~=false)
item:SetChildActive(_itemCmp.arrow2,data.moneylistlen>0 and expand==false)
item:SetChildText(_itemCmp.xbValue,FMT.fmt("修士：{0}",xsNum))
item:SetChildText(_itemCmp.levelTx,data.sectlevel)
item:SetChildText(_itemCmp.playerName,data.actorname)
playerController:setHeadIcon(item,_itemCmp.head,{iconInfo=data.iconInfo})
item:ForceLayoutRect(-1)
end)
self.winlua:ForceLayoutRect(self.list:getID())
self.none:setActive(listCnt<=0)

self.operationPart:setActive(isMyXM)
if isMyXM then
local showJump=not isInMoJie and self.ownerIdx==nil
self.cancelAllBtn:setActive(canRetreatAll)
self.sendBtn:setActive(isInMoJie and self.ownerIdx==nil)
self.jumpBtn:setActive(showJump)
self.cancelBtn:setActive(self.ownerIdx~=nil)
if showJump then
local gray=not xianjieModel:checkCurrentMoJieEnterTime()
self.jumpBtn:setChildGraphicGray(gray)
end
end

local level=not isInMoJie and xianMengDaZhenModel:getLevel()or xmData.lv
local maxVal=cfgHelper.get2(cfg_devildomdazhenconfig_get,level,"max")
local curVal=#self.data.team
self.progress:setProgressValue(curVal,maxVal)
self.progress:setChildProgressText(FMT.fmt("{0}/{1}",curVal,maxVal))

self.refreshReddot:setActive(self.data.serverTime>self.data.clientTime)
end

function UIXianJie_XMBLDefendInfoWin:onClickArrowBtn(index)
local data=self.data.team[index]
if data then
local expand=self.expands[index]==false
self.expands[index]=expand
local item=self.list:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_itemCmp.panel2,data.moneylistlen>0 and expand~=false)
item:SetChildActive(_itemCmp.arrow1,data.moneylistlen>0 and expand~=false)
item:SetChildActive(_itemCmp.arrow2,data.moneylistlen>0 and expand==false)
item:ForceLayoutRect(-1)
self.winlua:ForceLayoutRect(self.list:getID())
end
end

function UIXianJie_XMBLDefendInfoWin:onClickRereatBtn(index)
local data=self.data.team[index]
if data then

local params=jsonHelper.encode({mathHelper.int64_to_string(data.actor_id)})
xianjieController:reqOrder(self.guildId,xjOrderType.eDefendXianMengBack,{},{},params,0,nil,{})
end
end

function UIXianJie_XMBLDefendInfoWin:onClickPlayer(index)
local data=self.data.team[index]
if data then
if not xianjieModel:isInMoJie()then
otherPlayerController:openOtherPlayerInfoWin(data.actor_id,true,nil,attach)
else
local xmData=xianjieModel:getXianMengData(self.guildId)
local attach={
serverid=xmData.serverid
}
otherPlayerController:openOtherPlayerInfoWin(data.actor_id,true,nil,attach)
end
end
end

function UIXianJie_XMBLDefendInfoWin.on_35_156(guildid)
if mathHelper.compareInt64(_this.guildId,guildid)then
_this:updateData()
_this:refreshView()
end
end

function UIXianJie_XMBLDefendInfoWin.on_35_157(timeSec)
if xianmengModel:isMyXM2(_this.guildId)then
_this.refreshReddot:setActive(_this.data.serverTime>_this.data.clientTime)
end
end