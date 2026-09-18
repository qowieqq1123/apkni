







def_class("UIXM_XMDG_bossRankWin",UIWindowBase)









function UIXM_XMDG_bossRankWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.myItem=UIObject.get(self,2)
self.manItem=UIObject.get(self,3)
self.noItem=UIObject.get(self,4)
self.noTipsTxt=UIText.get(self,5)
self.rewardObj=UIButton.get(self,6)
self.rankGridPanel=UIObject.get(self,7)
self.manNameTxt=UIText.get(self,8)
self.playerModel=UIObject.get(self,9)
self.rewardImg=UIImage.get(self,10)
self.rewardReddot=UIObject.get(self,11)
self.rewardEffect=UIObject.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rewardObj:setButtonClick(function()self:onRewardObj()end)



end


function UIXM_XMDG_bossRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.myItem);self.myItem=nil;
_UIObject_release(self.manItem);self.manItem=nil;
_UIObject_release(self.noItem);self.noItem=nil;
_UIObject_release(self.noTipsTxt);self.noTipsTxt=nil;
_UIObject_release(self.rewardObj);self.rewardObj=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
_UIObject_release(self.manNameTxt);self.manNameTxt=nil;
_UIObject_release(self.playerModel);self.playerModel=nil;
_UIObject_release(self.rewardImg);self.rewardImg=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.rewardEffect);self.rewardEffect=nil;
end
















local _this=nil


function UIXM_XMDG_bossRankWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_bossRankWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_bossRankWin:onHide()

end




function UIXM_XMDG_bossRankWin:onShow(argtable,afterOnloaded)
self.roomid=argtable.roomid
self.m_room=xianmengdigongModel:getRoom(self.roomid)

local needRefresh=xianmengdigongModel:checkBossRankList(self.roomid)
if needRefresh then
xianmengdigongController:send_20_132(self.roomid)
self:refreshView()
else
self:refreshView()
end
end

function UIXM_XMDG_bossRankWin:refreshView()
local list=xianmengdigongModel:getBossRankList(self.roomid)
local n=list~=nil and#list or 0

local isshow=n>0
local myRank,myRate

self.noTipsTxt:setActive(not isshow)
self.rankGridPanel:setChildLayoutGroupCreateItems(n)
if isshow then
local grids=self.rankGridPanel:getChildLayoutGroupGridList()
for i=1,n do
local item=grids[i-1]
local data=list[i]

item:SetChildText(0,data.rank)

item:SetChildText(1,data.name)

item:SetChildText(2,FMT.fmt('{0}%',data.hurt/100))

local my_actorid=playerModel:getActorID()
local ismy=mathHelper.compareInt64(my_actorid,data.playerId)
local icon
if ismy then
icon='frame_shanghaipaihang_2'
myRank=data.rank
myRate=data.hurt
else
icon='frame_shanghaipaihang_1'
end
item:SetChildCSImageSprite(3,globalABLookup.xmdgmainicons,icon)
end
end

local myWidget=self.myItem:getWidgetBase()
local m_rankstr
local m_ratestr
if myRank~=nil then
m_rankstr=tostring(myRank)
m_ratestr=FMT.fmt('{0}%',myRate/100)
else
m_rankstr='未上榜'
m_ratestr='0'
end
myWidget:SetChildText(0,m_rankstr)
myWidget:SetChildText(1,playerModel:getActorName()or'')
myWidget:SetChildText(2,m_ratestr)

self.noItem:setActive(not isshow)
self.manItem:setActive(isshow)
if list then
local data=list[1]

local playerImage=data.piList
playerImageController.setPlayerModel(self.winlua,self.playerModel:getID(),playerImage,1,eAnimationID.idle,0,0,playerController:supportDynamic())

self.manNameTxt:setText(data.name)
end

self:refreshReward()
end

function UIXM_XMDG_bossRankWin:doReddotPunchRotation(isreddot)
if isreddot then
if self.reddotTweener==nil then
self.rewardReddot:setRotation(0,0,0)
local tweener=self.rewardReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.rewardReddot:setRotation(0,0,0)
end
end
end

function UIXM_XMDG_bossRankWin:refreshReward()

local abname=globalABLookup.xmdgmainicons
local iconname
local hasReward=self.m_room:hasRankRewardEx()
if hasReward then
iconname='image_shanghaipaihang_1'
else
iconname='image_shanghaipaihang_2'
end
self.rewardImg:setSprite(abname,iconname)

local effectID
local unlock=self.m_room:checkunLock()
if not unlock then
effectID=0
else
effectID=0
end
self.rewardImg:setGray(not unlock)
if effectID>0 then
self.rewardEffect:setChildShowEffect(effectID,true)
else
self.rewardEffect:setChildShowEffect(0,false)
end

local isReddot=hasReward and unlock
self.rewardReddot:setActive(isReddot)
self:doReddotPunchRotation(isReddot)
end

function UIXM_XMDG_bossRankWin:onCloseBtn()
local hasReward=self.m_room:hasRankRewardEx()
local unlock=self.m_room:checkunLock()
if hasReward and unlock then

elseif not unlock then

else

end

self:closeSelf()
end

function UIXM_XMDG_bossRankWin:onRewardObj()
local hasReward=self.m_room:hasRankReward()
local unlock=self.m_room:checkunLock()
if hasReward and unlock then
xianmengdigongController:send_20_133(self.m_room.base.x,self.m_room.base.y)
elseif not unlock then
UIManager.error("击败首领后方可领取")
else
UIManager.error("已领取")
end
end

function UIXM_XMDG_bossRankWin:rec_rankReward()
self:refreshReward()
end