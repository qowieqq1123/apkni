







def_class("UIXianMengDaZhenWin",UIWindowBase)









function UIXianMengDaZhenWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.dzModel_1=UIObject.get(self,1)
self.dzModel_2=UIObject.get(self,2)
self.dzModel_3=UIObject.get(self,3)
self.dzModel_4=UIObject.get(self,4)
self.dzModel_5=UIObject.get(self,5)
self.full=UIObject.get(self,6)
self.helpBtn=UIButton.get(self,7)
self.moneyList=UIObject.get(self,8)
self.notFull=UIObject.get(self,9)
self.progressSp_0=UIObject.get(self,10)
self.progressSp_1=UIObject.get(self,11)
self.progressSp_2=UIObject.get(self,12)
self.progressTips=UIText.get(self,13)
self.progressTx=UIText.get(self,14)
self.recordBtn=UIButton.get(self,15)
self.teamBtn=UIButton.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.teamBtn:setButtonClick(function()self:onTeamBtn()end)
self.dzModel={
self.dzModel_1,
self.dzModel_2,
self.dzModel_3,
self.dzModel_4,
self.dzModel_5,
}
self.progressSp={
[0]=self.progressSp_0,
[1]=self.progressSp_1,
[2]=self.progressSp_2,
}



end


function UIXianMengDaZhenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dzModel_1);self.dzModel_1=nil;
_UIObject_release(self.dzModel_2);self.dzModel_2=nil;
_UIObject_release(self.dzModel_3);self.dzModel_3=nil;
_UIObject_release(self.dzModel_4);self.dzModel_4=nil;
_UIObject_release(self.dzModel_5);self.dzModel_5=nil;
_UIObject_release(self.full);self.full=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.moneyList);self.moneyList=nil;
_UIObject_release(self.notFull);self.notFull=nil;
_UIObject_release(self.progressSp_0);self.progressSp_0=nil;
_UIObject_release(self.progressSp_1);self.progressSp_1=nil;
_UIObject_release(self.progressSp_2);self.progressSp_2=nil;
_UIObject_release(self.progressTips);self.progressTips=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.teamBtn);self.teamBtn=nil;
self.dzModel=nil;
self.progressSp=nil;
end















local _this=nil
local _attrCmp={
prevTx=0,
arrow=1,
nextTx=2,
}
local _moneyCmp={
btn=0,
icon=1,
value=2,
add=3,
}
local _costCmp={
icon=0,
value=1,
}
local _fullCmp={
attrList=0,
attrArrow=1,
attrTitle=2,
}
local _notFullCmp={
permissionTx=0,
levelupBtn=1,
costList=2,
attrList=3,
attrArrow=4,
costEmpty=5,
}



function UIXianMengDaZhenWin:onLoaded(...)
self:bindComponents()
_this=self
self.fullWidget=self.full:getChildWidgetBase()
self.fullWidget:SetChildButtonClick(_fullCmp.attrList,function()
self:onExpandFullAttr()
end)
self.notFullWidget=self.notFull:getChildWidgetBase()
self.notFullWidget:SetChildButtonClick(_notFullCmp.attrList,function()
self:onExpandNotFullAttr()
end)
self.notFullWidget:SetChildButtonClick(_notFullCmp.levelupBtn,function()
self:onLevelUpBtn()
end)
local posList=xianmengModel:findPostListByPrivile(GUILD_PRIVILE_TYPE.gptDevildomDaZhen)
local permissionStr=""
local postCnt=#posList
if postCnt>0 then
for i=postCnt,1,-1 do
local pos=posList[i]
local posName=xianmengModel.getXMPostName(pos,true)
if i==postCnt then
permissionStr=posName
elseif i==postCnt-1 then
permissionStr=FMT.fmt("{1}和{0}",permissionStr,posName)
else
permissionStr=FMT.fmt("{1}、{0}",permissionStr,posName)
end
end
self.permisionStr=permissionStr
permissionStr=FMT.fmt("{0}可升级大阵",permissionStr)
end
self.notFullWidget:SetChildText(_notFullCmp.permissionTx,permissionStr)
self._refreshProgress=function()
self:refreshProgress()
end
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onXianMengDaZhenLevelUp,self.onXianMengDaZhenLevelUp)
self:addProNotify(20,81,self.on_20_81)
self.attrExpand=true
end


function UIXianMengDaZhenWin:__delete()
self:unbindComponents()
_this=nil

self:stopBehavior()
self:stopProgressTick()
self:killProgressTween()
end




function UIXianMengDaZhenWin:onShow(argtable,afterOnloaded)
self:refreshProgress()
self:refreshMoneys()
self:refreshLevel()
self:refreshModels()
end


function UIXianMengDaZhenWin:onHide()

end




function UIXianMengDaZhenWin:onCloseBtn()
UIFullXianMengDaZhenController:closeUI(true,true)
end


function UIXianMengDaZhenWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='xianmengdazhen_help_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UIXianMengDaZhenWin:onRecordBtn()
xianjieController:OpenXianjieResourceLog(true)
end


function UIXianMengDaZhenWin:onTeamBtn()
local guildId=xianmengModel:getMyXMGuildID()
local garrison=xianjieModel:getMyXianMengGarrison()
if garrison==nil or garrison.serverTime>garrison.clientTime then
xianjieController:send_35_156(guildId)
end
local args={
guild=guildId,
parentWin=self,
}
self:showWindow("UIXianJie_XMBLDefendInfoWin",args)
end

function UIXianMengDaZhenWin:onLevelUpBtn()
if xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptDevildomDaZhen)then
local max=#cfg_devildomdazhenconfig()
local level=xianMengDaZhenModel:getLevel()
if level>=max then
UIManager.error("仙盟大阵已满级")
elseif level<=0 then
UIManager.error("仙盟大阵未修复")
else
if#self.costs>0 then
moneySystem:useMoneys(self.costs,function()
xianMengDaZhenController:send_20_82()
end,WARNING_TYPE.eWarning)
else
xianMengDaZhenController:send_20_82()
end
end
else
UIManager.error(FMT.fmt("{0}方可升级大阵",self.permisionStr))
end
end

function UIXianMengDaZhenWin:onExpandFullAttr()
self.attrExpand=not self.attrExpand
self:refreshFullAttr()
end

function UIXianMengDaZhenWin:onExpandNotFullAttr()
self.attrExpand=not self.attrExpand
self:refreshNotFullAttr()
end

function UIXianMengDaZhenWin:refreshLevel()
local curLv=xianMengDaZhenModel:getLevel()
if curLv then
local maxLv=#cfg_devildomdazhenconfig()
local full=curLv>=maxLv
if full then
self.full:setActive(true)
self.notFull:setActive(false)
self:refreshFull()
else
self.full:setActive(false)
self.notFull:setActive(true)
self:refreshNotFull()
end
else
self.full:setActive(false)
self.notFull:setActive(false)
end
end

function UIXianMengDaZhenWin:refreshFull()
local curLv=xianMengDaZhenModel:getLevel()
self.fullWidget:SetChildText(_fullCmp.attrTitle,FMT.fmt("大阵{0}级",curLv))
self:refreshFullAttr()
self.costs=defaultT
end

function UIXianMengDaZhenWin:refreshFullAttr()
if self.attrExpand then
local level=xianMengDaZhenModel:getLevel()
local config=cfgHelper.get1(cfg_devildomdazhenconfig_get,level)
local attrs=config.showAttrs
local teamNum=config.max
local shield=config.shield
local attrCnt=#attrs
self.fullWidget:SetChildLayoutGroupCreateItems(_fullCmp.attrList,attrCnt+2,function(index)
local item=self.fullWidget:GetChildLayoutGroupGridItem(_fullCmp.attrList,index-1)
if index<=attrCnt then
local attrInfo=attrs[index]
local attrType=attrInfo[1]
local attrValue=attrInfo[2]
local attrStr=helper.getAttributeStr(attrType,attrValue,2,"{0}：{1}")
item:SetChildText(0,attrStr)
elseif index==attrCnt+1 then
item:SetChildText(0,FMT.fmt("驻防部队：{0}",teamNum))
elseif index==attrCnt+2 then
item:SetChildText(0,FMT.fmt("城防值：{0}",shield))
end
end)
else
self.fullWidget:SetChildLayoutGroupCreateItems(_fullCmp.attrList,0)
end
self.fullWidget:ForceLayoutRect(_fullCmp.attrList)
self.fullWidget:SetChildRotation(_fullCmp.attrArrow,0,0,self.attrExpand and 0 or 180)
end

function UIXianMengDaZhenWin:refreshNotFull()
self:refreshNotFullAttr()
self:refreshCost()
end

function UIXianMengDaZhenWin:refreshNotFullAttr()
if self.attrExpand then
local level=xianMengDaZhenModel:getLevel()
local currCfg=cfgHelper.get1(cfg_devildomdazhenconfig_get,level)
local nextCfg=cfgHelper.get1(cfg_devildomdazhenconfig_get,level+1)
local attrCnt=#currCfg.showAttrs
self.notFullWidget:SetChildLayoutGroupCreateItems(_notFullCmp.attrList,attrCnt+2,function(index)
local item=self.notFullWidget:GetChildLayoutGroupGridItem(_notFullCmp.attrList,index-1)
if index<=attrCnt then
local currInfo=currCfg.showAttrs[index]
local nextInfo=nextCfg.showAttrs[index]
local attrType=currInfo[1]
local currValue=currInfo[2]
local nextValue=nextInfo[2]
local currStr=helper.getAttributeStr(attrType,currValue,2,"{0}：{1}")
local nextStr=helper.getAttributeStrEx(attrType,nextValue,2)
item:SetChildText(0,currStr)
item:SetChildActive(1,currValue~=nextValue)
item:SetChildActive(2,currValue~=nextValue)
item:SetChildText(2,nextStr)
elseif index==attrCnt+1 then
item:SetChildText(0,FMT.fmt("驻防部队：{0}",currCfg.max))
item:SetChildActive(1,currCfg.max~=nextCfg.max)
item:SetChildActive(2,currCfg.max~=nextCfg.max)
item:SetChildText(2,nextCfg.max)
elseif index==attrCnt+2 then
item:SetChildText(0,FMT.fmt("城防值：{0}",mathHelper.formatNumber(currCfg.shield)))
item:SetChildActive(1,currCfg.shield~=nextCfg.shield)
item:SetChildActive(2,currCfg.shield~=nextCfg.shield)
item:SetChildText(2,mathHelper.formatNumber(nextCfg.shield))
end
end)
else
self.notFullWidget:SetChildLayoutGroupCreateItems(_notFullCmp.attrList,0)
end
self.notFullWidget:ForceLayoutRect(_notFullCmp.attrList)
self.notFullWidget:SetChildRotation(_notFullCmp.attrArrow,0,0,self.attrExpand and 0 or 180)
end

function UIXianMengDaZhenWin:refreshCost()
local level=xianMengDaZhenModel:getLevel()
self.costs=level>0 and cfgHelper.get2(cfg_devildomdazhenconfig_get,level,"consume")or defaultT
local costCnt=#self.costs
self.notFullWidget:SetChildLayoutGroupCreateItems(_notFullCmp.costList,costCnt,function(index)
local item=self.notFullWidget:GetChildLayoutGroupGridItem(_notFullCmp.costList,index-1)
local cost=self.costs[index]
local costId=cost[1]
local costNum=cost[2]
local haveNum=itemsModel.getCount(costId)
local color=haveNum>=costNum and FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_TIPS_COLOR_VAL[FONT_COLOR.eRedColor]
local costStr=FMT.fmt("{0}：<color={2}>{1}</color>",itemsConfig.getItemName(costId),mathHelper.formatNumber(costNum),color)
item:SetChildCSImageIcon(_costCmp.icon,iconHelper.getIconName(costId),false)
item:SetChildText(_costCmp.value,costStr)
end)
self.notFullWidget:SetChildActive(_notFullCmp.costEmpty,costCnt<=0)
end

function UIXianMengDaZhenWin:refreshProgress()
local value,since=xianMengDaZhenModel:getProgress()
if value then
local nowTime=timeHelper.getServerShortTime()
local level=xianMengDaZhenModel:getLevel()
local config=cfgHelper.get1(cfg_devildomdazhenconfig_get,level)
local maxVal=config.shield
local maxStr=mathHelper.formatNumber(maxVal)
if value<=0 then
local finishTime=since+config.fix
if nowTime>=finishTime then

self:setAllProgressValue(maxStr)
else

self.progressSp_0:setActive(false)
self.progressSp_1:setActive(false)
self.progressSp_2:setActive(true)
local progressVal=Mathf.Clamp((nowTime-since)/config.fix,0,1)
self.winlua:SetChildIconFillAmount(self.progressSp_2:getID(),progressVal)
self.progressTips:setText(FMT.fmt("修复进度：{0}%",math.floor(progressVal*10000)/100))
self.progressTx:setText(FMT.fmt("距离修复完成剩余时间：{0}",timeHelper.format_time_stamp(finishTime-nowTime)))
self:startProgressTick1(since,finishTime,config.fix)
end
else
local curVal=value+math.floor((nowTime-since)/config.recover[1])*config.recover[2]
if curVal>=maxVal then

self:setAllProgressValue(maxStr)
else
self.progressSp_0:setActive(false)
self.progressSp_1:setActive(true)
self.progressSp_2:setActive(false)
local progressVal=Mathf.Clamp(curVal/maxVal,0,1)
local curStr=mathHelper.formatNumber(math.min(curVal,maxVal))
self.winlua:SetChildIconFillAmount(self.progressSp_2:getID(),progressVal)
self.progressTx:setText(FMT.fmt("城防值：{0}/{1}",curStr,maxStr))
self.progressTips:setText("")
self:startProgressTick2(curVal,maxVal,since,config.recover[1],config.recover[2])
end
end
else
self:stopProgressTick()
self.progressTx:setText("")
self.progressTips:setText("")
for i,v in ipairs(self.progressSp)do
v:setActive(false)
end
end
end

function UIXianMengDaZhenWin:setAllProgressValue(maxStr)
self.progressSp_0:setActive(true)
self.progressSp_1:setActive(false)
self.progressSp_2:setActive(false)
self.winlua:SetChildIconFillAmount(self.progressSp_0:getID(),1)
self.progressTx:setText(FMT.fmt("城防值：{0}/{0}",maxStr))
self.progressTips:setText("")
self:stopProgressTick()
end

function UIXianMengDaZhenWin:startProgressTick1(sinceTime,finishTime,duration)
self:stopProgressTick()
self.progressData={sinceTime,finishTime,duration}
self.progressTick=self:setTimer(1,0,function()
self:updateProgressTick1()
end)
end

function UIXianMengDaZhenWin:startProgressTick2(sinceVal,targetVal,sinceTime,interval,deltaVal)
self:stopProgressTick()
self.progressData={sinceVal,targetVal,sinceTime,interval,deltaVal}
self.progressTick=self:setTimer(1,0,function()
self:updateProgressTick2()
end)
end

function UIXianMengDaZhenWin:stopProgressTick()
self.progressData=nil
if self.progressTick then
self:stopTimerByID(self.progressTick)
self.progressTick=nil
end
end

function UIXianMengDaZhenWin:updateProgressTick1()
local nowTime=timeHelper.getServerShortTime()
local finishTime=self.progressData[2]
local callback=nowTime>=finishTime and self._refreshProgress or nil
local sinceTime=self.progressData[1]
local duration=self.progressData[3]
local progressVal=Mathf.Clamp((nowTime-sinceTime)/duration,0,1)
self:killProgressTween()
self.progressTween=self.progressSp_2:setChildImageDOFillAmount(progressVal,0.1,callback)
self.progressTips:setText(FMT.fmt("修复进度：{0}%",math.floor(progressVal*10000)/100))
self.progressTx:setText(FMT.fmt("距离修复完成剩余时间：{0}",timeHelper.format_time_stamp(finishTime-nowTime)))
end

function UIXianMengDaZhenWin:updateProgressTick2()
local nowTime=timeHelper.getServerShortTime()
local sinceTime=self.progressData[3]
local interval=self.progressData[4]
if(sinceTime-nowTime)%interval==0 then
local sinceVal=self.progressData[1]
local targetVal=self.progressData[2]
local targetStr=mathHelper.formatNumber(maxVal)
local deltaVal=self.progressData[5]
local curVal=sinceVal+(nowTime-sinceTime)/interval*deltaVal
local curStr=mathHelper.formatNumber(math.min(curVal,targetVal))
local callback=curVal>=targetVal and self._refreshProgress or nil
local progressVal=curVal/targetVal
self.progressTx:setText(FMT.fmt("城防值：{0}/{1}",curStr,targetStr))
self:killProgressTween()
self.progressTween=self.progressSp_1:setChildImageDOFillAmount(progressVal,0.1,callback)
end
end

function UIXianMengDaZhenWin:killProgressTween()
if self.progressTween and self.progressTween:IsActive()then
self.progressTween:Kill()
self.progressTween=nil
end
end

function UIXianMengDaZhenWin:refreshMoneys()
self.moneys=xianMengDaZhenModel:getShowMoneys()
self.moneyList:setChildLayoutGroupCreateItems(#self.moneys,function(index)
local item=self.moneyList:getChildLayoutGroupGridItem(index-1)
local money=self.moneys[index]
item:SetChildButtonClick(_moneyCmp.btn,function()
if money==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(money)
end
end)
item:SetChildButtonClick(_moneyCmp.add,function()
gainControl:showGainWin(money)
end)
item:SetChildCSImageIcon(_moneyCmp.icon,iconHelper.getIconName(money),false)
item:SetChildText(_moneyCmp.value,mathHelper.formatNumber(itemsModel.getCount(money)))
end)
end

function UIXianMengDaZhenWin:refreshModels()
local garrison=xianjieModel:getMyXianMengGarrison()
local teams=garrison and garrison.team or defaultT
local btArgs={
widget=self.winlua
}
local showBT=false
for i,v in ipairs(self.dzModel)do
local team=teams[i]
v:setActive(team~=nil)
local dzKey=string.format("dzWidget%d",i)
if team then
local firstDz=nil
for j=1,fightPreSelectModel.maxPosNum do
if team.discipleList[j]then
firstDz=team.guidlist[j]
break
end
end
local args={
tmLv=firstDz.tmLv,
clothingId=firstDz.clothingId,
clothingStar=firstDz.clothingStar,
xianmo_voc=firstDz.xianmo_voc,
}
local imageInfo=UIDiscipleModel.calculationDiscipleImage(firstDz.discipledata,firstDz.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,nil,args)
v:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,eAnimationID.stand,false,false,0)
btArgs[dzKey]=v:getID()
showBT=true
else
btArgs[dzKey]=nil
end
end
self:stopBehavior()
if showBT then
self.bt=behaviorManager:addBehaviorTree("ui_bt_xianmengdazhen",nil,true,btArgs,true)
end
end

function UIXianMengDaZhenWin:randomSpeakStr(bt,index)
local wordKey=string.format("dzSpeakWord%d",index)
bt:setSharedVar(wordKey,tostring(math.random(1,5)))
end

function UIXianMengDaZhenWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end

function UIXianMengDaZhenWin.on_money_changed(moneyType,lastVal,val)
for i,v in ipairs(_this.moneys)do
if v==moneyType then
local item=_this.moneyList:getChildLayoutGroupGridItem(i-1)
item:SetChildText(_moneyCmp.value,mathHelper.formatNumber(itemsModel.getCount(v)))
break
end
end

if _this.notFullWidget:GetChildActiveSelf(-1)then
for i,v in ipairs(_this.costs)do
if v[1]==moneyType then
local item=_this.notFullWidget:GetChildLayoutGroupGridItem(_notFullCmp.costList,i-1)
local color=val>=v[2]and FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_TIPS_COLOR_VAL[FONT_COLOR.eRedColor]
local costStr=FMT.fmt("{0}：<color={2}>{1}</color>",itemsConfig.getItemName(v[1]),mathHelper.formatNumber(v[2]),color)
item:SetChildText(_costCmp.value,costStr)
break
end
end
end
end

function UIXianMengDaZhenWin.onXianMengDaZhenLevelUp(oldLv,newLv)
local args={
parentWin=_this,
oldLv=oldLv,
newLv=newLv,
}
_this:showWindow("UIXianMengDaZhenLevelUpWin",args)
end

function UIXianMengDaZhenWin.on_20_81()
_this:refreshProgress()
_this:refreshLevel()
end

function UIXianMengDaZhenWin.on_35_156(guildid)
if xianmengModel:isMyXM2(guildid)then
_this:refreshModels()
end
end