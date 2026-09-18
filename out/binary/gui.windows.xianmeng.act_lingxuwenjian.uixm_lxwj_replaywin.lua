







def_class("UIXM_LXWJ_replayWin",UIWindowBase)









function UIXM_LXWJ_replayWin:bindComponents()

self.replayScrollView=UIObject.get(self,0)
self.noItemTips=UIText.get(self,1)
self.replayGridPanel=UIObject.get(self,2)



end


function UIXM_LXWJ_replayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.replayScrollView);self.replayScrollView=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.replayGridPanel);self.replayGridPanel=nil;
end
















local _this=nil


function UIXM_LXWJ_replayWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_replayWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_replayWin:onHide()

end




function UIXM_LXWJ_replayWin:onShow(argtable,afterOnloaded)






self.posData=argtable.posData
self.openReplay=argtable.openReplay
local pos=self.posData
local needRefresh=lingxuwenjianModel:checkReplayList(pos[1],pos[2],pos[3])
if not needRefresh then
self:refreshView()
else
self.replayScrollView:setActive(false)
end
end

function UIXM_LXWJ_replayWin:refreshView()
self.replayScrollView:setActive(true)
local pos=self.posData
self.replayList=lingxuwenjianModel:getReplayList(pos[1],pos[2],pos[3])or{}
local num=#self.replayList
local isShow=num>0
self.replayScrollView:setActive(isShow)
self.noItemTips:setActive(not isShow)
if isShow then
local func=function(i)
if _this==nil then return end
local item=_this.replayGridPanel:getChildLayoutGroupGridItem(i-1)
_this:refreshItem(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onReplayClick(i)
end)
end
self.replayGridPanel:setChildLayoutGroupCreateItems(num,func)
else
self.noItemTips:setText('暂无战况信息')
end


local checkJump=false
if self.openReplay~=nil then
local idx=self.openReplay
local data=self.replayList[idx]
if data then

end
self.openReplay=nil
end
if not checkJump then
lingxuwenjianController:doCloseCloud()
end
end

function UIXM_LXWJ_replayWin:refreshItem(item,idx)
if item==nil then
item=_this.replayGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local pos=self.posData

local data=self.replayList[idx]
local atkWidget=item:GetChildWidgetBase(1)
local defWidget=item:GetChildWidgetBase(2)
local ismyLeft
if pos[1]==0 then

ismyLeft=false
else

ismyLeft=true
end

local abname,icon=lingxuwenjianModel:getResultIcon4(data.result,ismyLeft)
atkWidget:SetChildCSImageSprite(0,abname,icon)

local abname_,icon_=lingxuwenjianModel:getResultIcon4(data.result,not ismyLeft)
defWidget:SetChildCSImageSprite(0,abname_,icon_)

local headParams={iconInfo=data.atk.iconInfo,scale=0.5}
playerController:setHeadIcon(atkWidget,1,headParams)

local headParams2={iconInfo=data.def.iconInfo,scale=0.5}
playerController:setHeadIcon(defWidget,1,headParams2)

local name_str=FMT.fmt('{0}\n{1}',data.atk.xmName,data.atk.actorname)
local showMy=false
if playerModel:checkActorId(data.atk.actorid)then
showMy=true
end
atkWidget:SetChildText(2,name_str)
atkWidget:SetChildActive(3,showMy)

local name_str2=FMT.fmt('{0}\n{1}',data.def.xmName,data.def.actorname)
local showMy2=false
if playerModel:checkActorId(data.def.actorid)then
showMy2=true
end
defWidget:SetChildText(2,name_str2)
defWidget:SetChildActive(3,showMy2)
end

function UIXM_LXWJ_replayWin:onReplayClick(idx)
local data=self.replayList[idx]
if data.len>0 then
local isCrossServer=true
local args={eReplayType=eRePlayerType.lingxuwenjian2}
args.player1={data.atk.actorid,data.atk.actorname,data.atk.iconInfo}
args.player2={data.def.actorid,data.def.actorname,data.def.iconInfo}
local pos=self.posData
args.data={src=pos[1],lxwjtype=pos[2],lxwjkey=pos[3],openReplay=idx,result=data.result}
args.showBattle=true

local args2={}
args2.player1={data.atk.actorname,data.atk.iconInfo}
args2.player2={data.def.actorname,data.def.iconInfo}
args2.hideFlag=true
args2.showWinTimes=true
fightModel:setSendExtraArgs(eBattleType.lingxuwenjian2,args2)
fightController:send_log_list(data.list,args,isCrossServer)
end
end

function UIXM_LXWJ_replayWin:rec_replay(src,lxwjtype,lxwjkey)
local pos=self.posData
if src==pos[1]and lxwjtype==pos[2]and lxwjkey==pos[3]then
self:refreshView()
end
end