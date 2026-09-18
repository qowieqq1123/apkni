







def_class("UIZhengZhanShanHaiLogVictoryWin",UIWindowBase)









function UIZhengZhanShanHaiLogVictoryWin:bindComponents()

self.Pool=UIGameobjectClone.new(self,0)
self.ResIcon=UIImage.get(self,1)
self.ResTx=UIText.get(self,2)
self.ResRoot=UIObject.get(self,3)
self.ScrollView=UIScrollView.get(self,4)
self.Middle=UIObject.get(self,5)
self.centerTipsTx=UIText.get(self,6)
self.TipsTx=UIText.get(self,7)
self.progressBar=UIProgress.get(self,8)
self.TextNum=UIText.get(self,9)
self.TitleIcon=UIImage.get(self,10)
self.TitleTx=UIText.get(self,11)
self.Content=UIObject.get(self,12)
self.Hurtlog=UIText.get(self,13)
self.itemScrollView=UIObject.get(self,14)
self.itemGridPanel=UIObject.get(self,15)
self.resType1=UIObject.get(self,16)
self.headKuang=UIImage.get(self,17)
self.icon=UIObject.get(self,18)
self.proroot=UIObject.get(self,19)
self.progressbarType1=UIObject.get(self,20)
self.proIcon=UIImage.get(self,21)
self.progressValueTxt=UIText.get(self,22)
self.name=UIText.get(self,23)
self.tips=UIText.get(self,24)
self.IconFlag=UIImage.get(self,25)
self.lastprogressValue=UIProgressBarAni.get(self,26)
self.resType2=UIObject.get(self,27)
self.sgtxt2=UIText.get(self,28)
self.progressbarType2=UIObject.get(self,29)
self.progressValueTxt2=UIText.get(self,30)



end


function UIZhengZhanShanHaiLogVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
self.Pool:deleteSelf();self.Pool=nil;
_UIObject_release(self.ResIcon);self.ResIcon=nil;
_UIObject_release(self.ResTx);self.ResTx=nil;
_UIObject_release(self.ResRoot);self.ResRoot=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Middle);self.Middle=nil;
_UIObject_release(self.centerTipsTx);self.centerTipsTx=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.TextNum);self.TextNum=nil;
_UIObject_release(self.TitleIcon);self.TitleIcon=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.Hurtlog);self.Hurtlog=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
_UIObject_release(self.resType1);self.resType1=nil;
_UIObject_release(self.headKuang);self.headKuang=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.proroot);self.proroot=nil;
_UIObject_release(self.progressbarType1);self.progressbarType1=nil;
_UIObject_release(self.proIcon);self.proIcon=nil;
_UIObject_release(self.progressValueTxt);self.progressValueTxt=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.IconFlag);self.IconFlag=nil;
_UIObject_release(self.lastprogressValue);self.lastprogressValue=nil;
_UIObject_release(self.resType2);self.resType2=nil;
_UIObject_release(self.sgtxt2);self.sgtxt2=nil;
_UIObject_release(self.progressbarType2);self.progressbarType2=nil;
_UIObject_release(self.progressValueTxt2);self.progressValueTxt2=nil;
end



















function UIZhengZhanShanHaiLogVictoryWin:onLoaded(...)
self:bindComponents()
end


function UIZhengZhanShanHaiLogVictoryWin:__delete()
self:unbindComponents()
end




function UIZhengZhanShanHaiLogVictoryWin:onShow(argtable,afterOnloaded)
self.argtable=argtable or{}


local flag=self.argtable.flag
if self.argtable.logstr and flag==0 then
self:showFirstTxt()
elseif self.argtable.logstr and(flag==1 or flag==4)then

self:showBaoDi_Txt()
end

if self.argtable.param and self.argtable.param.newLogic then
self.Hurtlog:setText("")
self.itemScrollView:setActive(false)
self:refreshNewLogic(self.argtable.param.newLogic)
else
self.resType1:setActive(false)
end
end


function UIZhengZhanShanHaiLogVictoryWin:onHide()


end



function UIZhengZhanShanHaiLogVictoryWin:showBaoDi_Txt()

if self.argtable.itemlist then
self.itemScrollView:setActive(#self.argtable.itemlist>0)
self.itemGridPanel:setChildLayoutGroupCreateItems(#self.argtable.itemlist,function(idx)
self:refreshItem(nil,idx)
end)
else
self.itemScrollView:setActive(false)
end

self.Hurtlog:setText(self.argtable.logstr)
end

function UIZhengZhanShanHaiLogVictoryWin:refreshItem(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)

end

local v=self.argtable.itemlist[idx]
local reward_widget=item
local itemConfig=itemsConfig.getConfig(v.param_1)
local color=itemConfig.color
reward_widget:SetChildQulaity(0,color)
reward_widget:SetChildIcon(1,iconHelper.getIconName(v.param_1),false)
local moneyStr=mathHelper.formatNumber(v.param_2,true)
reward_widget:SetChildText(2,moneyStr)
local stage=itemConfig.stage
if stage then
reward_widget:SetChildActive(7,true)
reward_widget:SetChildActive(9,false)
reward_widget:SetChildText(4,stage)
else
reward_widget:SetChildActive(9,true)
end
reward_widget:SetChildQulaity(0,color)

end


function UIZhengZhanShanHaiLogVictoryWin:showFirstTxt()
self.itemScrollView:setActive(false)





















local str=FMT.fmt(self.argtable.logstr,self.argtable.hurt_hp)
self.Hurtlog:setText(str)

end

function UIZhengZhanShanHaiLogVictoryWin:refreshNewLogic(newLogic)
local resultType=newLogic.resultType

if resultType==1 then
self.resType1:setActive(true)
self.headKuang:setCSImageSprite(newLogic.kuangAbName,newLogic.kuangAssetName)
comHelper.setChildModelRawImage_monsterGroup(self.winlua,newLogic.groupid,self.icon:getID(),0,eHeadCenterType.eHead)
self.name:setText(newLogic.name)
self.tips:setText(newLogic.tips)
local cur,max=newLogic.curProValue,newLogic.maxProValue
local progressValueTxt=newLogic.progressValueTxt
self.progressbarType1:setChildUIProgressbar(cur,max,false)
self.progressValueTxt:setText(progressValueTxt)
if newLogic.iconFlagCfg then
self.IconFlag:setCSImageSprite(newLogic.iconFlagCfg[1],newLogic.iconFlagCfg[2])
end
if newLogic.oldProValue then
self.lastprogressValue:setActive(true)
self.lastprogressValue:animateFiveParams(newLogic.oldProValue,cur,max,1,true)
else
self.lastprogressValue:setActive(false)
end
elseif resultType==2 then
self.resType2:setActive(true)
local curhp=newLogic.curhp or 1
local nowhp=newLogic.nowhp or 1
local maxhp=newLogic.maxhp or 1
curhp=tonumber(curhp)
nowhp=tonumber(nowhp)
maxhp=tonumber(maxhp)
local _shenyuhp=(nowhp/maxhp)*100
if _shenyuhp<0.01 and _shenyuhp>0 then
_shenyuhp=0.01
end
if _shenyuhp>0 then
_shenyuhp=string.format("%.2f",_shenyuhp)
end
local _shanghaihp=(curhp/maxhp)*100
if _shanghaihp<0.01 and _shanghaihp>0 then
_shanghaihp=0.01
end
if _shanghaihp>0 then
_shanghaihp=string.format("%.2f",_shanghaihp)
end

local str=FMT.fmt('本次战斗造成：<color=#c82c2c>{0}%</color>血量伤害',_shanghaihp)
self.sgtxt2:setText(str)
self.progressValueTxt2:setText(FMT.fmt("{0}%",_shenyuhp))
self.progressbarType2:setChildUIProgressbar(nowhp,maxhp,false)
end
end

function UIZhengZhanShanHaiLogVictoryWin:onShareBtn()
end



function UIZhengZhanShanHaiLogVictoryWin:onHeadIcontwo()
end



function UIZhengZhanShanHaiLogVictoryWin:onHeadIcon()
end



function UIZhengZhanShanHaiLogVictoryWin:onTgslbtn()
end



function UIZhengZhanShanHaiLogVictoryWin:onTgslgobtn()
end
