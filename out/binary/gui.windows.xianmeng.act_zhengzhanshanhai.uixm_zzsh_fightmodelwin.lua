







def_class("UIXM_ZZSH_fightModelWin",UIWindowBase)









function UIXM_ZZSH_fightModelWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.descTxt=UIText.get(self,1)
self.desc1Txt=UIText.get(self,2)
self.desc2Txt=UIText.get(self,3)
self.desc3Txt=UIText.get(self,4)
self.reward1Panel=UIObject.get(self,5)
self.desc4Txt=UIText.get(self,6)
self.reward2Panel=UIObject.get(self,7)
self.commitBtn=UIButton.get(self,8)
self.tipsTxt=UIText.get(self,9)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIXM_ZZSH_fightModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.desc3Txt);self.desc3Txt=nil;
_UIObject_release(self.reward1Panel);self.reward1Panel=nil;
_UIObject_release(self.desc4Txt);self.desc4Txt=nil;
_UIObject_release(self.reward2Panel);self.reward2Panel=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
end
















local _this=nil


function UIXM_ZZSH_fightModelWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_fightModelWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_fightModelWin:onHide()

end




function UIXM_ZZSH_fightModelWin:onShow(argtable,afterOnloaded)
self:updateView()
end

function UIXM_ZZSH_fightModelWin:updateView()
local flag=zhengzhanshanhaiModel:checkJoinFightFlag()
local rewards1,rewards2
if flag then

self.titleTxt:setText('放弃争夺')
self.descTxt:setText('“放弃争夺”状态下，会在<征战山海>活动中获得以下效果')
self.desc1Txt:setText('不会成为其他仙盟抢夺的目标')
self.desc2Txt:setText('无法进攻领地和抢夺其他仙盟')
self.desc3Txt:setText('仙盟在<征战山海>结算时会获得')
self.desc4Txt:setText('仙盟全体成员在<征战山海>结算时会获得')
local safe=zhengzhanshanhaiController:getZZSHCfg('safe')
rewards1=safe[1]
rewards2=safe[2]
else

self.titleTxt:setText('参与争夺')
self.descTxt:setText('“参与争夺”状态下，会在<征战同海>活动中获得以下效果')
self.desc1Txt:setText('会成为其他仙盟抢夺的目标')
self.desc2Txt:setText('可以进攻领地和抢夺其他仙盟')
self.desc3Txt:setText('仙盟在<征战山海>结算时至少会获得')
self.desc4Txt:setText('仙盟全体成员在<征战山海>结算时至少会获得')
local comfort=zhengzhanshanhaiController:getZZSHCfg('comfort')
rewards1=comfort[1]
rewards2=comfort[2]
end

local rnum1=#rewards1
self.reward1Panel:setChildLayoutGroupCreateItems(rnum1)
local grids1=self.reward1Panel:getChildLayoutGroupGridList()
for i=1,rnum1 do
local rwItem=grids1[i-1]
local itemid=rewards1[i][1]
local itemnum=rewards1[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=mathHelper.formatNumber(itemnum)
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

local rnum2=#rewards2
self.reward2Panel:setChildLayoutGroupCreateItems(rnum2)
local grids2=self.reward2Panel:getChildLayoutGroupGridList()
for i=1,rnum2 do
local rwItem=grids2[i-1]
local itemid=rewards2[i][1]
local itemnum=rewards2[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=mathHelper.formatNumber(itemnum)
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

local ldData=zhengzhanshanhaiModel:getMyLDData()
local showBtn=ldData==nil
self.commitBtn:setActive(showBtn)
self.tipsTxt:setActive(not showBtn)
end

function UIXM_ZZSH_fightModelWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_ZZSH_fightModelWin:onCommitBtn()
local flag=zhengzhanshanhaiModel:checkJoinFightFlag()
if flag then

zhengzhanshanhaiController:reqJoinFightChange(0)
else

zhengzhanshanhaiController:reqJoinFightChange(1)
end
end



