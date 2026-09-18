







def_class("UIGongFaResetWin",UIWindowBase)









function UIGongFaResetWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.descone=UIText.get(self,2)
self.taskdesc=UIText.get(self,3)
self.item_1=UIObject.get(self,4)
self.tipsdesc=UIText.get(self,5)
self.changebtn=UIButton.get(self,6)
self.center=UIObject.get(self,7)
self.effect1=UIObject.get(self,8)
self.effect2=UIObject.get(self,9)
self.effect3=UIObject.get(self,10)
self.item_2=UIObject.get(self,11)
self.descone2=UIText.get(self,12)
self.shengyunum=UIText.get(self,13)
self.zstxt=UIText.get(self,14)
self.zsicon=UIObject.get(self,15)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.changebtn:setButtonClick(function()self:onChangebtn()end)
self.item={
self.item_1,
self.item_2,
}



end


function UIGongFaResetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descone);self.descone=nil;
_UIObject_release(self.taskdesc);self.taskdesc=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.tipsdesc);self.tipsdesc=nil;
_UIObject_release(self.changebtn);self.changebtn=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.descone2);self.descone2=nil;
_UIObject_release(self.shengyunum);self.shengyunum=nil;
_UIObject_release(self.zstxt);self.zstxt=nil;
_UIObject_release(self.zsicon);self.zsicon=nil;
self.item=nil;
end
















local _this



function UIGongFaResetWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIGongFaResetWin:__delete()
self:unbindComponents()
self:closeWindow('UITopMoneyWin2')
end




function UIGongFaResetWin:onShow(argtable,afterOnloaded)
self.gfID=argtable.gfID

self:delayDo(0.3,function()
self:showWindow('UITopMoneyWin2',{{eMoneyType.mtXianYu},{eMoneyType.mtLingYu}})
end)


local recordNum=gameUtilityModel:getData_counter(gameCounterType.eGongFaResetNum)
local reset=cfgHelper.getdef(cfg_disciplegongfaconfig,'reset')
local reset_num=reset[1]
local reset_arry=reset[2]


local systr=FMT.fmt("<color=#c82c2c>本月剩余次数:</color> {0}",reset_num-recordNum)
if(reset_num-recordNum)<=0 then
local stemp=timeHelper.getNextMonthDateDisStamp2(1,5,1,0)
local times=timeHelper.format_time_stamp12(stemp)
systr=FMT.fmt("<color=#c82c2c>{0}后可以再次重置</color>",times)
end
self.shengyunum:setText(systr)
self.ishasNum=reset_num>recordNum

local gfID=self.gfID
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local gfcolor=cfg.color
local gfname=cfg.name
local gfpiece=cfg.piece
local tayin=cfg.tayin
local study=cfg.study
local studylevel=UIGongFaModel:getStudyLevel(gfID)
local speItemID=cfgHelper.getdef(cfg_disciplegongfaconfig,'speitemids',gfcolor)


local str=FMT.fmt("重置功法将 <color=#ca631d>{0}+{1}</color> 重置至 <color=#ca631d>0级</color>，\n并返还研习消耗的所有功法篇章、无字天书",gfname,studylevel)
self.descone:setText(str)


local costid=eMoneyType.mtLingYu
local costNum=0
if reset_arry[gfcolor]then
if reset_arry[gfcolor][studylevel]then
local cost=reset_arry[gfcolor][studylevel][1]
costid=cost[1]
costNum=cost[2]
end
end
local moneyName=moneyModel.getMoneyName(costid)
local str2=FMT.fmt("<color=#c82c2c>(重置功法所需{0}随功法的品质与研习等级提升而增加)</color>",moneyName)
self.descone2:setText(str2)

local isEnough=moneyModel.checkEnoughMoney(costid,costNum)
if not isEnough and costid==eMoneyType.mtLingYu then
local hasLingYuCount=moneyModel.getMoney(costid)
local needXianYuCount=costNum-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end
local moneystr=""
if not isEnough then
moneystr=FMT.fmt("<color=#c82c2c>{0}</color>",costNum)
else
moneystr=FMT.fmt("<color=#549327>{0}</color>",costNum)
end
self.zsicon:setChildIcon(iconHelper.getIconName(costid),false)
self.zstxt:setText(moneystr)
self._costid=costid
self._needValue=costNum
self.isEnough=isEnough


if not self.ishasNum or not self.isEnough then
self.winlua:SetChildGray(self.changebtn:getID(),true)
end


local neednum=0
for i=1,studylevel do
local cost=study[i-1][1]
neednum=neednum+cost[1][2]
end
local spe_num=UIGongFaModel:getGongFaSpenum(gfID)
local pianzhang_num=neednum-spe_num




if spe_num==0 and pianzhang_num>0 then

self.item_1:setActive(true)
self.item_2:setActive(false)
self.winlua:SetChildLocalPosX(self.item_1:getID(),0)
local gfitemid
if gfpiece then
gfitemid=gfpiece[1][1]
else
gfitemid=tayin[1][1]
end
local dataitem={gfitemid,pianzhang_num}
local item=self.item_1:getWidgetBase()
widgetHelper.setNormalRewardItem(item,-1,dataitem)
item:SetChildButtonClick(14,function()
if _this==nil then return end
self:ontipsClick(dataitem[1])
end)

elseif spe_num>0 and pianzhang_num==0 then

self.item_1:setActive(true)
self.item_2:setActive(false)
self.winlua:SetChildLocalPosX(self.item_1:getID(),0)
local gfitemid=speItemID
local dataitem={gfitemid,spe_num}
local item=self.item_1:getWidgetBase()
widgetHelper.setNormalRewardItem(item,-1,dataitem)
item:SetChildButtonClick(14,function()
if _this==nil then return end
self:ontipsClick(dataitem[1])
end)

elseif spe_num>0 and pianzhang_num>0 then

self.item_1:setActive(true)
self.item_2:setActive(true)
local gfitemid
if gfpiece then
gfitemid=gfpiece[1][1]
else
gfitemid=tayin[1][1]
end
local dataitem={gfitemid,pianzhang_num}
local item=self.item_1:getWidgetBase()
widgetHelper.setNormalRewardItem(item,-1,dataitem)
item:SetChildButtonClick(14,function()
if _this==nil then return end
self:ontipsClick(dataitem[1])
end)

local gfitemid2=speItemID
local dataitem2={gfitemid2,spe_num}
local item2=self.item_2:getWidgetBase()
widgetHelper.setNormalRewardItem(item2,-1,dataitem2)
item2:SetChildButtonClick(14,function()
if _this==nil then return end
self:ontipsClick(dataitem2[1])
end)
end

end


function UIGongFaResetWin:onHide()

end


function UIGongFaResetWin:onCloseBtn()
self:closeSelf()
end


function UIGongFaResetWin:onChangebtn()
if not _this.ishasNum then
UIManager.error("本月剩余重置次数已用完")
return
end
if not _this.isEnough then
if _this._costid then
gainControl:showGainWin(_this._costid)
end
return
end


local moneyType=_this._costid
local needValue=_this._needValue
local _gfID=self.gfID
local iconname=iconHelper.getIconName(moneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)
local str=FMT.fmt('是否确认花费{0}{1} 进行功法重置？',iconStr,needValue)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext='确认',
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
moneySystem:useMoney(moneyType,needValue,function(...)
UIGongFaController:reqGongFaReset(_gfID)
_this.comfirmDialog:deleteSelf()
UIManager:closeWindow("UIGongFaResetWin")
end,WARNING_TYPE.eWarning)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


function UIGongFaResetWin:ontipsClick(itemId)
if not itemId or itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end
