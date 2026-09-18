







def_class("UIDouFaTaiRecordWin",UIWindowBase)









function UIDouFaTaiRecordWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.scrollerView=UIObject.get(self,1)
self.notRecord=UIText.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDouFaTaiRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.notRecord);self.notRecord=nil;
end

















local item_index=
{
lookbtn=0,
time=1,
kuang=2,
head=3,
name=4,
scoreicon=5,
scorevalue=6,
beatbackbtn=7,
beatbackstr=8,
cost=9,
costicon=10,
costnum=11,
}


function UIDouFaTaiRecordWin:onLoaded(...)
self:bindComponents()
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIDouFaTaiRecordWin:__delete()
self:unbindComponents()
end




function UIDouFaTaiRecordWin:onShow(argtable,afterOnloaded)
self.config=douFaTaiModel:getDouFaTaiBasicConfig()
self:refreshPanel()
end


function UIDouFaTaiRecordWin:onHide()

end

function UIDouFaTaiRecordWin:refreshPanel()
self.recordData=douFaTaiModel:get_record_data()
self.scrollerView:setActive(#self.recordData>0)
self.notRecord:setActive(#self.recordData<=0)
local serTime=timeHelper.getServerShortTime()
if#self.recordData>0 then
self.scrollerView:setChildScrollViewCreateGrids(#self.recordData,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
local isTruce=douFaTaiModel:checkIsTruce()
for i=1,count do
local item=grids[i-1]
local record=self.recordData[i]
record.robotType=DOUFATAI_ROBOTTYPE.player

local oriName=record.name
local isEmpty=oriName==''
local head,kuang,name,wendao,iconInfo=douFaTaiModel:getDouFaTaiActorInfo(record)
item:SetChildActive(12,isEmpty)
item:SetChildActive(item_index.head,not isEmpty)
item:SetChildButtonClick(item_index.lookbtn,function(...)
self:onClickLookBtn(i)
end)
local passTime=serTime-record.logTime
item:SetChildText(item_index.time,FMT.fmt('{0}前',timeHelper.format_time_stamp7(passTime)))
local actorIdNum=tonumber(tostring(record.actorId))
if iconInfo then
playerController:setHeadIcon(item,item_index.head,{scale=0.6,iconInfo=iconInfo})
else
iconInfo=playerModel:getActorIconInfoByCfg(head,kuang)
playerController:setHeadIcon(item,item_index.head,{scale=0.6,iconInfo=iconInfo})
end

item:SetChildButtonClick(item_index.head,function()
if actorIdNum>0 then
douFaTaiModel:setCurLookType(DOUFATAI_LOOK_TYPE.eRecord)
local defense=douFaTaiModel:getOtherDefense(1,actorIdNum)
if defense then
douFaTaiController.prePareFight(record.actorId,defense[2],defense[3],defense[1],nil,DOUFATAI_ROBOTTYPE.player)
end

else
UIManager.info('对手过于神秘，无法查看信息')
end
end)
if actorIdNum>0 then
local zmName=isEmpty and playerModel:getOtherZongMenName(record.zongmenName)or record.zongmenName
name=FMT.fmt('{0}·{1}',zmName,name)
end
item:SetChildText(item_index.name,name)
local canBeatBack=record.battleFlag==1 and not isTruce and oriName~=''
item:SetChildActive(item_index.beatbackbtn,canBeatBack)
if canBeatBack then
item:SetChildButtonClick(item_index.beatbackbtn,function(...)
self:onClickBeatBackBtn(i)
end)
end
local colorStr=wendao<0 and'c82c2c'or'549327'
local score='无变化'
if wendao>0 then
score=FMT.fmt('<color=#{0}>+{1}</color>',colorStr,record.wendao)
elseif wendao<0 then
score=FMT.fmt('<color=#{0}>{1}</color>',colorStr,record.wendao)
end
local iconName=douFaTaiModel:getWenDaoIconName()
item:SetChildCSImageIcon(item_index.scoreicon,iconName,false)
item:SetChildText(item_index.scorevalue,score)
local haveFree=douFaTaiModel:checkFreeCount()
item:SetChildActive(item_index.beatbackstr,haveFree)
item:SetChildActive(item_index.cost,not haveFree)
if not haveFree then
local costList=self:getCurCostList()
local iconName=iconHelper.getIconName(costList[1])
item:SetChildCSImageIcon(item_index.costicon,iconName,false)
item:SetChildText(item_index.costnum,costList[2])
end
end
end
end

function UIDouFaTaiRecordWin:getCurCostList()
local config=self.config
local cost=config.challenge_item[1]
local itemid=cost[1]
local needItem=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem>=needItem then
return cost
end

return cost
end



function UIDouFaTaiRecordWin:onClickLookBtn(index)
douFaTaiModel:setCurLookType(DOUFATAI_LOOK_TYPE.eBeatBack)
local record=self.recordData[index]


local guid=record.logGuid


fightController:send_254_29(guid,{record,guid,eRePlayerType.doufatai})

end

function UIDouFaTaiRecordWin:onClickBeatBackBtn(index)
if self.beatbackTimer then
return
end

local record=self.recordData[index]
local battleFlag=record.battleFlag
if battleFlag==1 then
local haveFree=douFaTaiModel:checkFreeCount()
if haveFree then


if not self.beatbackTimer then
self.beatbackTimer=self:setTimer(1,1,function()
self.beatbackTimer=nil
end)
end
douFaTaiModel:setCurLookType(DOUFATAI_LOOK_TYPE.eBeatBack)

douFaTaiController:req_actor_defense_new(record.actorId,DOUFATAI_ROBOTTYPE.player,true,true)
else
local config=self.config
local cost=config.challenge_item[1]
local itemid=cost[1]
local needItem=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem>=needItem then


if not self.beatbackTimer then
self.beatbackTimer=self:setTimer(1,1,function()
self.beatbackTimer=nil
end)
end
douFaTaiModel:setCurLookType(DOUFATAI_LOOK_TYPE.eBeatBack)
douFaTaiController:req_actor_defense_new(record.actorId,DOUFATAI_ROBOTTYPE.player,true,true)
return
else
UIManager.info(FMT.fmt('{0}不足',itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid)
end










end
else
UIManager.info('不能反击，有问题')
end
end

function UIDouFaTaiRecordWin:onCloseBtn()
UIFullDouFaTaiControl:closeWindow(self.winlua.name)
end