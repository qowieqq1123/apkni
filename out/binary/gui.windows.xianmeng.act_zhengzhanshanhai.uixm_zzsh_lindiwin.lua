







def_class("UIXM_ZZSH_lindiWin",UIWindowBase)









function UIXM_ZZSH_lindiWin:bindComponents()

self.rewardPanel=UIObject.get(self,0)
self.checkRewardBtn=UIButton.get(self,1)
self.xmNameTxt=UIText.get(self,2)
self.checkBtn=UIButton.get(self,3)
self.fightBtnTxt=UIText.get(self,4)
self.titleTxt=UIText.get(self,5)
self.modelEffect=UIObject.get(self,6)
self.descTxt=UIText.get(self,7)
self.tipsTxt=UIText.get(self,8)
self.pvpRoot=UIObject.get(self,9)
self.fightBtn=UIButton.get(self,10)
self.checkFightBtn=UIButton.get(self,11)

self.checkRewardBtn:setButtonClick(function()self:onCheckRewardBtn()end)

self.checkBtn:setButtonClick(function()self:onCheckBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.checkFightBtn:setButtonClick(function()self:onCheckFightBtn()end)



end


function UIXM_ZZSH_lindiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.checkRewardBtn);self.checkRewardBtn=nil;
_UIObject_release(self.xmNameTxt);self.xmNameTxt=nil;
_UIObject_release(self.checkBtn);self.checkBtn=nil;
_UIObject_release(self.fightBtnTxt);self.fightBtnTxt=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.modelEffect);self.modelEffect=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.pvpRoot);self.pvpRoot=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.checkFightBtn);self.checkFightBtn=nil;
end
















local _this=nil


function UIXM_ZZSH_lindiWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onZZSHOrderChange,self.onZZSHOrderChange)
end


function UIXM_ZZSH_lindiWin:__delete()
_this=nil
self.modelEffect:setChildShowEffect(0,false)
self:unbindComponents()
end


function UIXM_ZZSH_lindiWin:onHide()

end




function UIXM_ZZSH_lindiWin:onShow(argtable,afterOnloaded)
local myActorid=playerModel:getActorID()
self.isManager=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)

self.cfgID=argtable.cfgID
self.targetid_str=tostring(-self.cfgID)
self:refreshView()

self:refreshTime()
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
end

function UIXM_ZZSH_lindiWin:refreshTime()
local raceState=zhengzhanshanhaiModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
self:refreshInfo()
end
end

function UIXM_ZZSH_lindiWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end

function UIXM_ZZSH_lindiWin:refreshView()
local cfgID=self.cfgID
local cfg=zhengzhanshanhaiModel:getLingDiCfg(cfgID)

self.titleTxt:setText(cfg.name)

self.modelEffect:setChildShowEffect(cfg.effectSet[1],true)
local scale=cfg.UIWinSet[1]
self.modelEffect:setScale(Vector3(scale,scale,scale))

local desc_str
if cfg.type==1 then
desc_str=cfgHelper.getlang('zzsh_dongtian_desc')or'语言表zzsh_dongtian_desc'
else
desc_str=cfgHelper.getlang('zzsh_fudi_desc')or'语言表zzsh_fudi_desc'
end
self.descTxt:setText(desc_str)
end

function UIXM_ZZSH_lindiWin:refreshInfo()
local showInfo=not zhengzhanshanhaiModel.maskPvP
self.tipsTxt:setActive(not showInfo)
self.pvpRoot:setActive(showInfo)
if showInfo then
local cfgID=self.cfgID
local cfg=zhengzhanshanhaiModel:getLingDiCfg(cfgID)

local rewardID=cfg.daily[GUILD_POST_TYPE.gpCivilian]
local rewards
if rewardID then
rewards=zongmenControl:getRewardConfigData(rewardID,zongmenModel:getLevel())or{}
else
rewards={}
end
local rnum=#rewards
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
rwItem:SetChildActive(1,showSign)
end

self:refreshXM()

self:refreshFightBtn()
self:refreshCheckFightBtn()
end
end

function UIXM_ZZSH_lindiWin:getMyXMData()
local cfgID=self.cfgID
local xmData
if self.raceState==eZZSH_State.ePVPFight then
local targetData=zhengzhanshanhaiModel:getpvpTargetData(self.targetid_str)
if targetData then
local winner=targetData:findWinner()
if winner then
xmData=zhengzhanshanhaiModel:getXMData(winner)
end
end
end
if xmData==nil then
local ldData=zhengzhanshanhaiModel:getLDData(cfgID)
if ldData then
xmData=ldData:getXM()
end
end
return xmData
end

function UIXM_ZZSH_lindiWin:refreshXM()

local xmData=self:getMyXMData()
if xmData then
self.isMy=xmData:checkMyXM()
else
self.isMy=false
end

local hasXM=xmData~=nil
self.checkBtn:setActive(hasXM)

local name_str
if hasXM then
name_str=xmData.guildname
else
name_str='无'
end
self.xmNameTxt:setText(name_str)
end

function UIXM_ZZSH_lindiWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_ZZSH_lindiWin:onCheckBtn()
if not self:checkClickLock()then
return
end
local xmData=self:getMyXMData()
if xmData then
zhengzhanshanhaiController:openXMDetailInfoWin(xmData.guildid)
end
end

function UIXM_ZZSH_lindiWin:onCheckRewardBtn()
if not self:checkClickLock()then
return
end
UIManager:showWindow('UIXM_ZZSH_ldRewardWin',{cfgID=self.cfgID})
end

function UIXM_ZZSH_lindiWin:onFightBtn()
if not self:checkClickLock()then
return
end
if self.raceState~=eZZSH_State.ePVPStandby then
return
end
if not self.isManager then
return
end
if self.isMy then
return
end
if zhengzhanshanhaiModel:checkHasOrder(nil,self.cfgID)then
zhengzhanshanhaiModel:checkOpenSelectTeamWin(2,{domainid=self.cfgID})
else
if zhengzhanshanhaiModel:getOrderNum(2)>0 then
UIManager.error('每轮只能下达一次攻占领地指令')
return
end
if not zhengzhanshanhaiModel:checkPvPOrder(nil,self.cfgID,true)then
return
end
zhengzhanshanhaiModel:checkOpenSelectTeamWin(2,{domainid=self.cfgID})
end
end

function UIXM_ZZSH_lindiWin:refreshFightBtn()
local showFightBtn=false
if not zhengzhanshanhaiModel.maskPvP then
showFightBtn=self.raceState==eZZSH_State.ePVPStandby and self.isManager and not self.isMy
end
self.fightBtn:setActive(showFightBtn)
if showFightBtn then
local hasOrder=zhengzhanshanhaiModel:checkHasOrder(nil,self.cfgID)~=nil
self.fightBtnTxt:setText(hasOrder and'查看指令'or'发起指令')
end
end

function UIXM_ZZSH_lindiWin:onCheckFightBtn()
local targetData=zhengzhanshanhaiModel:getpvpTargetData(self.targetid_str)
if targetData then
local idx=targetData:getShowIndex()
zhengzhanshanhaiModel:checkOpenPvPAttackDataWin(targetData.targetid,idx)
end
end

function UIXM_ZZSH_lindiWin:refreshCheckFightBtn()
local showBtn=false
if not zhengzhanshanhaiModel.maskPvP then
showBtn=self.raceState==eZZSH_State.ePVPFight and zhengzhanshanhaiModel:getpvpTargetData(self.targetid_str)~=nil
end
self.checkFightBtn:setActive(showBtn)
end


function UIXM_ZZSH_lindiWin:changeXM(cfgID_)
if cfgID_==self.cfgID then
self:refreshXM()
end
end

function UIXM_ZZSH_lindiWin.onZZSHOrderChange(opType,qbGuid)
if _this==nil then return end

_this:refreshFightBtn()
end