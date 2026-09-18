







def_class("UISubAct_TianMoRuQin_RankDialog",UIWindowBase)









function UISubAct_TianMoRuQin_RankDialog:bindComponents()

self.background=UIButton.get(self,0)
self.model=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.rankList=UIObject.get(self,4)
self.baodirewardList=UIObject.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_TianMoRuQin_RankDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rankList);self.rankList=nil;
_UIObject_release(self.baodirewardList);self.baodirewardList=nil;
end















local _this=nil
local _rankCmp={
rankImg=0,
rankNum=1,
playerHead=2,
playerName=3,
zmName=4,
progressBar=5,
fightNum=6,
rewardList=7,
none=8,
have=9,
ownerBg=10,
}



function UISubAct_TianMoRuQin_RankDialog:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
end


function UISubAct_TianMoRuQin_RankDialog:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
end




function UISubAct_TianMoRuQin_RankDialog:onShow(argtable,afterOnloaded)
self.info=activitiesModel:getSubActInfo(argtable.actId,argtable.subType,argtable.subId)
self.datas=argtable.datas
local config=activitiesModel:getSubActivityConfig(argtable.subType,argtable.subId)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,argtable.id)
local monType=monsterCfg.monType
local maxBlood=tonumber(tostring(self.info:getMaxBloods(monType)))
local topHurt=nil
self.rankList:setChildLayoutGroupCreateItems(config.monster[monType][2],function(index)
local item=self.rankList:getChildLayoutGroupGridItem(index-1)
local data=self.datas[index]
item:SetChildCSImageSprite(_rankCmp.rankImg,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",index))
item:SetChildText(_rankCmp.rankNum,index)
local haveData=data~=nil
item:SetChildActive(_rankCmp.none,not haveData)
item:SetChildActive(_rankCmp.have,haveData)
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
item:SetChildButtonClick(_rankCmp.playerHead,function()
self:onClickHead(index)
end)
if haveData then
playerController:setHeadIcon(item,_rankCmp.playerHead,{iconInfo=data.iconInfo})
item:SetChildText(_rankCmp.playerName,data.actorname)
item:SetChildText(_rankCmp.zmName,data.sectname)
item:SetChildText(_rankCmp.fightNum,math.abs(data.times))

local damageHurt=tonumber(tostring(data.actordamage))
topHurt=topHurt or damageHurt
local percent1=damageHurt/maxBlood
local percent2=damageHurt/topHurt
percent1=math.floor(percent1*100)
percent1=(damageHurt<=0 or percent1>0)and percent1 or"小于1"
item:SetChildProgressValue(_rankCmp.progressBar,math.floor(percent2*10000),10000)
item:SetChildProgressText(_rankCmp.progressBar,FMT.fmt("伤害：{0}% ({1})",percent1,mathHelper.formatNumber(damageHurt)))
end
end)
self.model:setChildUIModelShowTarget(4927,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.4,function()
self.root:setChildCanvasGroupAlpha(1)
end)
end)


local baodi_reward=config.monster[monType][8]
if baodi_reward then

self.baodirewardList:setChildLayoutGroupCreateItems(#baodi_reward,function(idx)

local rewardItem=self.baodirewardList:getChildLayoutGroupGridItem(idx-1)
local rewardData=baodi_reward[idx]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
end



end


function UISubAct_TianMoRuQin_RankDialog:onHide()

end





function UISubAct_TianMoRuQin_RankDialog:onCloseBtn()
self:closeSelf()
end

function UISubAct_TianMoRuQin_RankDialog:onBackground()

end

function UISubAct_TianMoRuQin_RankDialog:onActivityEnd(actId,subType,subId)
if _this.info:compare(actId,subType,subId)then
_this:closeSelf()
end
end

function UISubAct_TianMoRuQin_RankDialog:onClickHead(index)
local data=self.datas[index]
local actorId=data.actorid
if not mathHelper.compareInt64(actorId,playerModel:getActorID())then
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,nil)
end
end