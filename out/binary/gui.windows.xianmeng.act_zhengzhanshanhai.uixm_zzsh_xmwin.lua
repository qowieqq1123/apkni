







def_class("UIXM_ZZSH_xmWin",UIWindowBase)









function UIXM_ZZSH_xmWin:bindComponents()

self.checkFightBtn=UIButton.get(self,0)
self.fightBtn=UIButton.get(self,1)
self.supportBtn=UIButton.get(self,2)
self.fightBtnTxt=UIText.get(self,3)
self.money2Root=UIObject.get(self,4)
self.money1Root=UIObject.get(self,5)
self.topMoneyObj=UIObject.get(self,6)
self.model=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.pvpInfoPanel=UIObject.get(self,9)
self.signKuangIcon=UIImage.get(self,10)
self.signIcon=UIImage.get(self,11)
self.manNumText=UIText.get(self,12)
self.leaderNameText=UIText.get(self,13)
self.pvpRoot=UIObject.get(self,14)
self.xmNameText=UIText.get(self,15)
self.signBGIcon=UIImage.get(self,16)
self.xmLevelText=UIText.get(self,17)
self.fightText=UIText.get(self,18)

self.checkFightBtn:setButtonClick(function()self:onCheckFightBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.supportBtn:setButtonClick(function()self:onSupportBtn()end)



end


function UIXM_ZZSH_xmWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.checkFightBtn);self.checkFightBtn=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.supportBtn);self.supportBtn=nil;
_UIObject_release(self.fightBtnTxt);self.fightBtnTxt=nil;
_UIObject_release(self.money2Root);self.money2Root=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.topMoneyObj);self.topMoneyObj=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.pvpInfoPanel);self.pvpInfoPanel=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.manNumText);self.manNumText=nil;
_UIObject_release(self.leaderNameText);self.leaderNameText=nil;
_UIObject_release(self.pvpRoot);self.pvpRoot=nil;
_UIObject_release(self.xmNameText);self.xmNameText=nil;
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.xmLevelText);self.xmLevelText=nil;
_UIObject_release(self.fightText);self.fightText=nil;
end
















local _this


function UIXM_ZZSH_xmWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onZZSHOrderChange,self.onZZSHOrderChange)
end


function UIXM_ZZSH_xmWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_xmWin:onHide()

end

function UIXM_ZZSH_xmWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if _this.showTopMoney then
_this:refreshMoneyItemEx(moneyType,lastVal)
end
end




function UIXM_ZZSH_xmWin:onShow(argtable,afterOnloaded)
self.moneys={eMoneyType.mtXMLingShi,eMoneyType.mtXMJieShi,eMoneyType.mtXMXuKongJing}

local myActorid=playerModel:getActorID()
self.isManager=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)
self.root:setChildCanvasGroupAlpha(0)
self.model:setChildUIModelShowTarget(5281,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)

self.guildid=argtable.guildid
self.isMy=xianmengModel:isMyXM(self.guildid)
self.targetid_str=tostring(self.guildid)



local data
local xmData=zhengzhanshanhaiModel:getXMData(self.guildid)
self.isUseSHXMData=false
if xmData and xmData.cross_id then
self.isUseSHXMData=true
data=xmData
else
data=xianmengModel:getSearchXMDetailData(self.guildid)
end

if data~=nil then
self.detailData=data
self:refreshView()
end
self:refreshTime()
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
end

function UIXM_ZZSH_xmWin:refreshTime()
local raceState=zhengzhanshanhaiModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
self:refreshPvPPanel()
end
end

function UIXM_ZZSH_xmWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end

function UIXM_ZZSH_xmWin:refreshView()
local data=self.detailData
local image=xianmengModel.splitGuildIcon(data.guildicon)
local abname=globalABLookup.xianmengicons

self.signIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

self.signBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

self.signKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))


self.xmNameText:setText(data.guildname)

local leaderName=self.isUseSHXMData and data.lead_name or data.leadername
local leadernamestr=FMT.fmt('盟主：<color=#171311>{0}</color>',leaderName)
self.leaderNameText:setText(leadernamestr)

local xmLv=self.isUseSHXMData and data.level or data.guildlevel
local levelstr=FMT.fmt('等级：<color=#171311>{0}</color>',xmLv)
self.xmLevelText:setText(levelstr)

local maxNum=xianmengModel.getXMMaxMemberNum(xmLv)
local curNum=self.isUseSHXMData and data.menber_cnt or data.membernum
local mannumstr=FMT.fmt('成员：<color=#171311>{0}/{1}</color>',curNum,maxNum)
self.manNumText:setText(mannumstr)

local fightValue=self.isUseSHXMData and data.fight or data.memberfight
local fightnum=tonumber(tostring(fightValue))
local fightstr=FMT.fmt('总实力：<color=#171311>{0}</color>',mathHelper.formatNumber3(fightnum))
self.fightText:setText(fightstr)
end

function UIXM_ZZSH_xmWin:refreshPvPPanel()
local showInfo=self.raceState==eZZSH_State.ePVPStandby or self.raceState==eZZSH_State.ePVPFight
showInfo=showInfo and not zhengzhanshanhaiModel.maskPvP
self.pvpRoot:setActive(showInfo)
if showInfo then
self:refreshFightBtn()
self:refreshCheckFightBtn()
self:refreshPvpInfo()
end
self.showTopMoney=showInfo and not self.isMy
self.topMoneyObj:setActive(self.showTopMoney)
if self.showTopMoney then

local cost=zhengzhanshanhaiController:getZZSHCfg('spy',2)
local costMoneys={}
for i,v in ipairs(cost)do
table.insert(costMoneys,{v[1]})
end
self:initMoneyData(costMoneys)
end
end



function UIXM_ZZSH_xmWin:initMoneyData(datas)
local moneyList={}
local moneyLookup={}
for i=1,2 do
local data=datas[i]
local widgetName=FMT.fmt('money{0}Root',i)
local isshow=data~=nil
self[widgetName]:setActive(isshow)
if isshow then
local moneyType=data[1]
local isAdd=data[2]
local widget=self[widgetName]:getChildWidgetBase()
local d={widget,moneyType,isAdd}
moneyList[i]=d
if moneyType then
moneyLookup[moneyType]=d
end
end
end
self.moneyList=moneyList
self.moneyLookup=moneyLookup

for i,money in ipairs(self.moneyList)do
self:initMoneyItem(money)
end
end

function UIXM_ZZSH_xmWin:initMoneyItem(money)
local moneyType=money[2]
local widget=money[1]
local isshow=moneyType~=nil
widget:SetChildActive(-1,isshow)
if isshow then
local isAdd=money[3]~=1
local moneyVal=moneyModel.getMoney(moneyType)
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(1,iconHelper.getIconName(moneyType),false)
widget:SetChildText(2,moneyStr)
widget:SetChildActive(3,isAdd)
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onAddClick(moneyType)
end)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:clickMoney(moneyType)
end)
end
end

function UIXM_ZZSH_xmWin:refreshMoneyItemEx(moneyType,lastVal)
if not self.moneyLookup then return end
local money=self.moneyLookup[moneyType]
if money then
self:refreshMoneyItem(money,lastVal)
end
end

function UIXM_ZZSH_xmWin:refreshMoneyItem(money,lastVal)
local moneyType=money[2]
local widget=money[1]
local isshow=moneyType~=nil
widget:SetChildActive(-1,isshow)
if isshow then
local moneyVal=moneyModel.getMoney(moneyType)
self:clearFMTweener(moneyType)
if self.fmTweener==nil then self.fmTweener={}end
self.fmTweener[moneyType]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(2,moneyStr)
end,moneyVal,1)
end
end

function UIXM_ZZSH_xmWin:onAddClick(moneyType)
self:clickMoney(moneyType)
end

function UIXM_ZZSH_xmWin:clickMoney(moneyType)
gainControl:showGainWin(moneyType)
end

function UIXM_ZZSH_xmWin:clearFMTweener(mtype)
if self.fmTweener==nil then return end
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UIXM_ZZSH_xmWin:clearAllFMTweener()
if self.fmTweener then
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self.fmTweener=nil
end
end



function UIXM_ZZSH_xmWin:refreshPvpInfo()
local data
if self.isMy then
data={}
data.moneys={}
for i,v in ipairs(self.moneys)do
table.insert(data.moneys,{v,moneyModel.getMoney(v)})
end
else
local d=zhengzhanshanhaiModel:getLookXMRecord(self.guildid)
if d then
data={}
data.refreshTime=d.refreshTime
data.moneys={}
local lp={}
if d.moneys then
for i,v in ipairs(d.moneys)do
lp[v[1]]=v[2]
end
end
for i,v in ipairs(self.moneys)do
table.insert(data.moneys,{v,lp[v]or 0})
end
end
end
self.xmInfo=data
local hasData=data~=nil
local widget=self.pvpInfoPanel:getChildWidgetBase()
local spy=zhengzhanshanhaiController:getZZSHCfg('spy')
local lost=false

local title_str1,title_str2
if self.isMy then
widget:SetChildText(8,'本盟情报')
widget:SetChildText(9,'仙盟拥有物资')
else
widget:SetChildText(8,'窥探情报')
widget:SetChildText(9,'可抢夺物资')
end

local time_str
if hasData then
if not self.isMy then
local cur=gameUtilityModel.getServerShortTime()
local lerp=cur-data.refreshTime
if lerp<3600 then
time_str=''
elseif lerp>=spy[1]then
time_str='（窥探已失效）'
lost=true
else
local h=math.floor(lerp/3600)
time_str=FMT.fmt('<color=#549327>（{0}小时前更新）</color>',h)
end
else
time_str=''
end
else
time_str='（未曾窥探）'
end
widget:SetChildText(0,time_str)
self.xmInfoLost=lost

local grids=widget:GetChildCommonLayoutGroupWidgetList(1)
if hasData and not lost then
local moneys=data.moneys
for i=1,grids.Count do
local moneyItem=grids[i-1]
local money=moneys[i]
local show=money~=nil
moneyItem:SetChildActive(-1,show)
if show then
local moneyType=money[1]
local moneyStr=mathHelper.formatNumber(money[2],true)
moneyItem:SetChildText(0,moneyStr)
moneyItem:SetChildIcon(1,iconHelper.getIconName(moneyType),true)
end
end
else
for i=1,grids.Count do
local moneyItem=grids[i-1]
local moneyType=self.moneys[i]
moneyItem:SetChildText(0,'？？？？？')
moneyItem:SetChildIcon(1,iconHelper.getIconName(moneyType),true)
end
end

local canlook=hasData and not lost
local lookicon=canlook and'button_xianzhenxb_1'or'button_xianzhenxb_2'
widget:SetChildCSImageSprite(2,globalABLookup.zzshxmicons,lookicon)
widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onLookBtn()
end)


widget:SetChildActive(4,not canlook)

local showCost=not self.isMy
widget:SetChildActive(7,showCost)
if showCost then

widget:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onCheckBtn()
end)

local cost=spy[2]
local grids2=widget:GetChildCommonLayoutGroupWidgetList(6)
for i=1,grids2.Count do
local moneyItem=grids2[i-1]
local money=cost[i]
local show=money~=nil
moneyItem:SetChildActive(-1,show)
if show then
local moneyType=money[1]
local moneyNum=money[2]
local hasNum=moneyModel.getMoney(moneyType)
local num_str
if hasNum>=moneyNum then
num_str=tostring(moneyNum)
else
num_str=FMT.fmt('<color=#C82C2C>{0}</color>',moneyNum)
end
moneyItem:SetChildText(0,num_str)
moneyItem:SetChildIcon(1,iconHelper.getIconName(moneyType),true)
end
end
end
end

function UIXM_ZZSH_xmWin:onLookBtn()
if not self:checkClickLock()then
return
end
if self.isMy then
zhengzhanshanhaiModel:checkOpenOtherTeamWin(self.guildid,1)
else
if self.xmInfo==nil then
UIManager.error('需要先窥探该宗门')
return
end
if self.xmInfoLost then
UIManager.error('距离上次窥探已久，请重新窥探该仙盟')
return
end
zhengzhanshanhaiModel:checkOpenOtherTeamWin(self.guildid,1)
end
end

function UIXM_ZZSH_xmWin:onCheckBtn()
if not self:checkClickLock()then
return
end
if not self.isMy then

local cost=zhengzhanshanhaiController:getZZSHCfg('spy',2)










local moneyType=cost[1][1]
local need=cost[1][2]
local have=moneyModel.getMoney(moneyType)
local moneyName=moneyModel.getMoneyName(moneyType)
local colorStr=have>=need and"549327"or"FF0000"
local iconStr=iconHelper.getIconName(moneyType)
local costStr=FMT.fmt("<color=#{0}>{1}</color>{2}quad-icon={3}-quad",colorStr,need,moneyName,iconStr)
local contentStr=FMT.fmt("是否消耗{0}进行窥探？",costStr)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',

okcallback=function(...)
if _this==nil then return end
if not moneyModel.checkEnoughMoney(moneyType,need)then
local str=FMT.fmt('{0}不足',moneyModel.getMoneyName(moneyType))
UIManager.error(str)
gainControl:showGainWin(moneyType)
return
end
zhengzhanshanhaiController:reqCheckXM(_this.guildid)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
end

function UIXM_ZZSH_xmWin:onSupportBtn()
if not self:checkClickLock()then
return
end
if not self.isManager then
return
end
end

function UIXM_ZZSH_xmWin:onFightBtn()
if not self:checkClickLock()then
return
end
if not self.isManager then
return
end
if zhengzhanshanhaiModel:checkHasOrder(self.guildid,nil)then
zhengzhanshanhaiModel:checkOpenSelectTeamWin(2,{guildid=self.guildid})
else
if not zhengzhanshanhaiModel:checkPvPOrder(self.guildid,nil,true)then
return
end
zhengzhanshanhaiModel:checkOpenSelectTeamWin(2,{guildid=self.guildid})
end
end

function UIXM_ZZSH_xmWin:refreshFightBtn()
local showBtn=self.raceState==eZZSH_State.ePVPStandby and self.isManager and not self.isMy
self.fightBtn:setActive(showBtn)
if showBtn then
local hasOrder=zhengzhanshanhaiModel:checkHasOrder(self.guildid,nil)~=nil
self.fightBtnTxt:setText(hasOrder and'查看指令'or'发起指令')
end
end

function UIXM_ZZSH_xmWin:onCheckFightBtn()
local targetData=zhengzhanshanhaiModel:getpvpTargetData(self.targetid_str)
if targetData then
local idx=targetData:getShowIndex()
zhengzhanshanhaiModel:checkOpenPvPAttackDataWin(targetData.targetid,idx)
end
end

function UIXM_ZZSH_xmWin:refreshCheckFightBtn()
local showBtn=self.raceState==eZZSH_State.ePVPFight and zhengzhanshanhaiModel:getpvpTargetData(self.targetid_str)~=nil
self.checkFightBtn:setActive(showBtn)
end

function UIXM_ZZSH_xmWin:rec_detail(guildid)
if mathHelper.compareInt64(guildid,self.guildid)then
self.detailData=xianmengModel:getSearchXMDetailData(guildid)
self:refreshView()
end
end

function UIXM_ZZSH_xmWin:rec_look(guildid)
if mathHelper.compareInt64(guildid,self.guildid)then
self:refreshPvPPanel()
end
end

function UIXM_ZZSH_xmWin.onZZSHOrderChange(opType,qbGuid)
if _this==nil then return end

_this:refreshFightBtn()
end