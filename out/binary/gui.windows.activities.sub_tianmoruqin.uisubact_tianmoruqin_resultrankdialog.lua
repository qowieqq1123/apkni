







def_class("UISubAct_TianMoRuQin_ResultRankDialog",UIWindowBase)









function UISubAct_TianMoRuQin_ResultRankDialog:bindComponents()

self.background=UIButton.get(self,0)
self.backBtn=UIButton.get(self,1)
self.total=UIText.get(self,2)
self.rankList=UIObject.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.backBtn:setButtonClick(function()self:onBackBtn()end)



end


function UISubAct_TianMoRuQin_ResultRankDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.total);self.total=nil;
_UIObject_release(self.rankList);self.rankList=nil;
end















local _this=nil
local _rankCmp={
rankNum=0,
playerHead=1,
playerName=2,
zmName=3,
progressBar=4,
fightNum=5,
rewardList=6,
owner=7,
}



function UISubAct_TianMoRuQin_ResultRankDialog:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_TianMoRuQin_ResultRankDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_TianMoRuQin_ResultRankDialog:onShow(argtable,afterOnloaded)
local info=activitiesModel:getSubActInfo(argtable.actId,argtable.subType,argtable.subId)
local config=activitiesModel:getSubActivityConfig(argtable.subType,argtable.subId)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,argtable.id)
local monType=monsterCfg.monType
local maxBlood=tonumber(tostring(info:getMaxBloods(monType)))
local topHurt=nil
self.rankList:setChildLayoutGroupCreateItems(#argtable.datas,function(index)
local item=self.rankList:getChildLayoutGroupGridItem(index-1)
local data=argtable.datas[index]
item:SetChildText(_rankCmp.rankNum,index)
playerController:setHeadIcon(item,_rankCmp.playerHead,{iconInfo=data.iconInfo})
item:SetChildText(_rankCmp.playerName,data.actorname)
item:SetChildText(_rankCmp.zmName,data.sectname)
item:SetChildText(_rankCmp.fightNum,math.abs(data.times))
item:SetChildActive(_rankCmp.owner,playerModel:checkActorId(data.actorid))
local damageHurt=tonumber(tostring(data.actordamage))
topHurt=topHurt or damageHurt
local percent1=damageHurt/maxBlood
local percent2=damageHurt/topHurt
percent1=math.floor(percent1*100)
percent1=(damageHurt<=0 or percent1>0)and percent1 or"小于1"
item:SetChildProgressValue(_rankCmp.progressBar,math.floor(percent2*10000),10000)
item:SetChildProgressText(_rankCmp.progressBar,FMT.fmt("{0}%({1})",percent1,mathHelper.formatNumber(damageHurt)))
local rewards={}
if monsterCfg.drops and monsterCfg.drops[2]then
rewards=worldFightModel:getMonsterShowAwardsEx2({monsterCfg.drops[2]},index)
end
item:SetChildLayoutGroupCreateItems(_rankCmp.rewardList,#rewards,function(idx)
local rewardItem=item:GetChildLayoutGroupGridItem(_rankCmp.rewardList,idx-1)
local rewardData=rewards[idx]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
end)

local total=0
for i,v in ipairs(argtable.datas)do
total=total+math.abs(v.times)
end
self.total:setText(FMT.fmt("挑战总次数：{0}",total))
end


function UISubAct_TianMoRuQin_ResultRankDialog:onHide()

end





function UISubAct_TianMoRuQin_ResultRankDialog:onBackground()
self:closeSelf()
end



function UISubAct_TianMoRuQin_ResultRankDialog:onBackBtn()
self:closeSelf()
end

