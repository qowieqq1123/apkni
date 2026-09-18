







def_class("UI2048Win",UIWindowBase)









function UI2048Win:bindComponents()

self.dragView=UIObject.get(self,0)
self.helpBtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.scoreTx=UIText.get(self,3)
self.leastTimeTx=UIText.get(self,4)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UI2048Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dragView);self.dragView=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scoreTx);self.scoreTx=nil;
_UIObject_release(self.leastTimeTx);self.leastTimeTx=nil;
end















local _this=nil
local _itemCmp={
root=-1,
effect=0,
image=1,
}
local _horDisUnit=126+3
local _verDisUnit=127+3
local _speed=0.2
local _Ease=DG.Tweening.Ease.Linear
local _abName="ui/windows/littlegame/sharedtextures/2048_image.ab"
local _horCnt=4
local _verCnt=4
local _moveDistanceType={
eUp=1,
eDown=2,
eLeft=3,
eRight=4,
}
local _randomType={
startWeight=1,
startNum=2,
addWeight=3,
addNum=4,
}
local _moveHandle={
[_moveDistanceType.eLeft]={
doMove=function(win)
win:doMoveLeft()
end,
moveLayer=function(win)
win:refreshMoveLayerLeft(win)
end,
},
[_moveDistanceType.eRight]={
doMove=function(win)
win:doMoveRight()
end,
moveLayer=function(win)
win:refreshMoveLayerLeft(win)
end,
},
[_moveDistanceType.eUp]={
doMove=function(win)
win:doMoveUp()
end,
moveLayer=function(win)
win:refreshMoveLayerLeft(win)
end,
},
[_moveDistanceType.eDown]={
doMove=function(win)
win:doMoveDown()
end,
moveLayer=function(win)
win:refreshMoveLayerLeft(win)
end,
},
}



function UI2048Win:onLoaded(...)
self:bindComponents()
_this=self

local _onBeginDrag=function(...)
self:onBeginDrag(...)
end
local _onEndDrag=function(...)
self:onEndDrag(...)
end
self.winlua:SetChildUIDragEvent(self.dragView:getID(),0,_onBeginDrag,_onEndDrag,nil)

self.scores={
{0,0,0,0},
{0,0,0,0},
{0,0,0,0},
{0,0,0,0}
}
self.effects={}
self.direction=nil
self.distances={}
self.refreshs={}
self.adds={}
end


function UI2048Win:__delete()
self:stopCDTick()
self:stopAnimation()

self:unbindComponents()
_this=nil
end




function UI2048Win:onShow(argtable,afterOnloaded)
self.args=argtable
self.mapId=self.args.mapId or 1
self.finishCallback=self.args.callback
self.startCallback=self.args.startCallback
self.config=cfgHelper.get1(cfg_2048config_get,self.mapId)
if self.args.isShowCloseBtn and self.args.isShowCloseBtn==1 then
self.closeBtn:setActive(false)
end
self.randomConfig={
[_randomType.startWeight]=self.config.startWeight,
[_randomType.startNum]=self.config.startNum,
[_randomType.addWeight]=self.config.addWeight,
[_randomType.addNum]=self.config.addNum,
}
self.randomSum={}
for rType,config in ipairs(self.randomConfig)do
local sum=0
for i,v in ipairs(config)do
sum=sum+v[2]
end
self.randomSum[rType]=sum
end

self.isGaming=false
self.isFinish=false
self.animation=nil
self.isAnimting=false
self.total=0

self.dragView:setChildLayoutGroupCreateItems(_horCnt*_verCnt,function(index)
local item=self.dragView:getChildLayoutGroupGridItem(index-1)
local h,v=self:convertItemGrid(index)
local x=81+(h-1)*(126+3)
local y=-84-(v-1)*(127+3)
item:SetChildAnchoredPos(_itemCmp.root,x,y)
local score=self.scores[v][h]
if score>0 then
local assetName=FMT.fmt("image_Xingqiu_{0}",score)
item:SetChildCSImageSprite(_itemCmp.image,_abName,assetName)
else
item:SetChildCSImageSprite(_itemCmp.image,"","")
end
item.gameObject.name=FMT.fmt("{0}({1},{2})",index,v,h)
end)
self:refreshScoreTx()

local startCB=function()
self:onStartGame()
end
local args={
info=ruleTipsImageGroup.e2048,
callback=startCB,
closeCallback=startCB,
btntxt="开始挑战",
}
self:showWindow("UIRuleTipsImageWin",args)
end


function UI2048Win:onHide()

end




function UI2048Win:onHelpBtn()
local d={}
d.title='吞噬天地规则'
d.mode=3
d.name='2048_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UI2048Win:onCloseBtn()
if self.isAnimting then return end

if not self.isGaming then
self:closeSelf()
return
end

local callback=function()
if self.finishCallback then
self.finishCallback(self.total)
end
self:closeSelf()
end

local showdata=
{
type='UIDialouge',
title='提示',
content='游戏尚未结束，现在退出会<color=#ff0000>以当前\n积分结算</color>，是否确定退出',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
}
self.quitDialog=UIDialogManager.newDialog(showdata)
self.quitDialog:show()
end

function UI2048Win:getRandom(rType)
local r=math.random(1,self.randomSum[rType])
local config=self.randomConfig[rType]
for i,v in ipairs(config)do
if r<=v[2]then
return v[1]
else
r=r-v[2]
end
end
end

function UI2048Win:onStartGame()
self.isGaming=true

if self.startCallback then
self.startCallback()
end

self.deadline=nil
if self.config.duration then
self.deadline=timeHelper.getServerShortTime()+self.config.duration
end
if self.deadline then
self:updateCDTick()
self:startCDTick()
end

self.isAnimting=true
self:checkNew(_randomType.startNum,_randomType.startWeight)
self:showNew()
end

function UI2048Win:refreshScore()
local sum=0
for v=1,_verCnt do
for h=1,_horCnt do
sum=sum+self.scores[v][h]
end
end
self.total=sum
end

function UI2048Win:refreshScoreTx()
self.scoreTx:setText(self.total)
end

function UI2048Win:checkFinish()

local check=false
for h=1,_horCnt-1 do
for v=1,_verCnt-1 do
local score=self.scores[h][v]
if score==self.config.endScore then
self:doFinish()
return
end
end
end

if self.deadline then
local nowTime=timeHelper.getServerShortTime()
if self.deadline<=nowTime then
self:doFinish()
return
end
end

for h=1,_horCnt-1 do
for v=1,_verCnt-1 do
local score=self.scores[h][v]
if score<=0 then
return
else
if h>1 and score==self.scores[h-1][v]then
return
end
if h<_horCnt and score==self.scores[h+1][v]then
return
end
if v>1 and score==self.scores[h][v-1]then
return
end
if v<_verCnt and score==self.scores[h][v+1]then
return
end
end
end
end
self:doFinish()
end

function UI2048Win:doFinish()
self.isFinish=true

local args={
tips=FMT.fmt("游戏积分:{0}",self.total),
callback=function()
if self.finishCallback then
self.finishCallback(1,self.total)
end
self:closeSelf()
end,
}
self:showWindow("UI2048ResultWin",args)
end

function UI2048Win:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UI2048Win:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UI2048Win:updateCDTick()
local leastTime=self.deadline-timeHelper.getServerShortTime()
leastTime=math.max(leastTime,0)
self.leastTimeTx:setText(FMT.fmt("游戏剩余时间：{0}",timeHelper.format_time_stamp2(leastTime)))
if leastTime<=0 then
self:stopCDTick()
self:checkFinish()
end
end

function UI2048Win:onBeginDrag(index,pos)
if self.isAnimting or self.isFinish or not self.isGaming then return end
self.beginPos=pos
end

function UI2048Win:onEndDrag(index,pos)
if self.isAnimting or self.isFinish or not self.isGaming then return end
if not self.beginPos then return end

self.direction=self:checkMoveDirection(self.beginPos,pos)
self:doMove(self.direction)

self:showMove()
self.beginPos=nil
end

function UI2048Win:checkMoveDirection(bPos,ePos)
local delta=ePos-bPos
local moveDirection=nil
local absX=math.abs(delta.x)
local absY=math.abs(delta.y)
if absX>=absY then
moveDirection=delta.x>=0 and _moveDistanceType.eRight or _moveDistanceType.eLeft
elseif absX<absY then
moveDirection=delta.y>=0 and _moveDistanceType.eUp or _moveDistanceType.eDown
end
return moveDirection
end

function UI2048Win:doMove(direction)
self:resetShowData()
local handle=_moveHandle[direction]
handle.doMove(self)

if next(self.distances)then
self:refreshScore()
end
end

function UI2048Win:resetShowData()
table.clear(self.effects)
table.clear(self.distances)
end

function UI2048Win:convertItemIndex(hor,ver)
return(ver-1)*_horCnt+hor
end

function UI2048Win:convertItemGrid(index)
local v=math.ceil(index/_horCnt)
local h=index-(v-1)*_horCnt
return h,v
end

function UI2048Win:doMoveLeft()
for h=2,_horCnt do
for v=1,_verCnt do
local cScore=self.scores[v][h]
if cScore>0 then
local d=0
local e=nil
for i=h-1,1,-1 do
local pScore=self.scores[v][i]
if pScore>0 then
if pScore==cScore then
self.scores[v][i]=cScore+pScore
self.scores[v][i+1]=0
d=d+1
e={v,i}
end
break
else
d=d+1
self.scores[v][i]=cScore
self.scores[v][i+1]=0
end
end
if d>0 then
table.insert(self.distances,{v,h,0,-d})
end
if e then
table.insert(self.effects,e)
end
end
end
end
end

function UI2048Win:doMoveRight()
for h=_horCnt-1,1,-1 do
for v=1,_verCnt do
local cScore=self.scores[v][h]
if cScore>0 then
local d=0
local e=nil
for i=h+1,_horCnt do
local pScore=self.scores[v][i]
if pScore>0 then
if pScore==cScore then
self.scores[v][i]=cScore+pScore
self.scores[v][i-1]=0
d=d+1
e={v,i}
end
break
else
d=d+1
self.scores[v][i]=cScore
self.scores[v][i-1]=0
end
end
if d>0 then
table.insert(self.distances,{v,h,0,d})
end
if e then
table.insert(self.effects,e)
end
end
end
end
end

function UI2048Win:doMoveUp()
for v=2,_verCnt do
for h=1,_horCnt do
local cScore=self.scores[v][h]
if cScore>0 then
local d=0
local e=nil
for i=v-1,1,-1 do
local pScore=self.scores[i][h]
if pScore>0 then
if pScore==cScore then
self.scores[i][h]=cScore+pScore
self.scores[i+1][h]=0
d=d+1
e={i,h}
end
break
else
d=d+1
self.scores[i][h]=cScore
self.scores[i+1][h]=0
end
end
if d>0 then
table.insert(self.distances,{v,h,d,0})
end
if e then
table.insert(self.effects,e)
end
end
end
end
end

function UI2048Win:doMoveDown()
for v=_verCnt-1,1,-1 do
for h=1,_horCnt do
local cScore=self.scores[v][h]
if cScore>0 then
local d=0
local e=nil
for i=v+1,_verCnt do
local pScore=self.scores[i][h]
if pScore>0 then
if pScore==cScore then
self.scores[i][h]=cScore+pScore
self.scores[i-1][h]=0
d=d+1
e={i,h}
end
break
else
d=d+1
self.scores[i][h]=cScore
self.scores[i-1][h]=0
end
end
if d>0 then
table.insert(self.distances,{v,h,-d,0})
end
if e then
table.insert(self.effects,e)
end
end
end
end
end

function UI2048Win:refreshMoveLayer()
local handle=_moveHandle[self.direction]
handle.moveLayer(self)
end

function UI2048Win:refreshMoveLayerLeft()
for h=1,_horCnt do
for v=1,_verCnt do
local itemIndex=self:convertItemIndex(h,v)
local item=self.dragView:getChildLayoutGroupGridItem(itemIndex-1)
item:SetAsLastSibling(-1)
end
end
end

function UI2048Win:refreshMoveLayerRight()
for h=_horCnt,1,-1 do
for v=1,_verCnt do
local itemIndex=self:convertItemIndex(h,v)
local item=self.dragView:getChildLayoutGroupGridItem(itemIndex-1)
item:SetAsLastSibling(-1)
end
end
end

function UI2048Win:refreshMoveLayerUp()
for v=1,_verCnt do
for h=1,_horCnt do
local itemIndex=self:convertItemIndex(h,v)
local item=self.dragView:getChildLayoutGroupGridItem(itemIndex-1)
item:SetAsLastSibling(-1)
end
end
end

function UI2048Win:refreshMoveLayerDown()
for v=_verCnt,1,-1 do
for h=1,_horCnt do
local itemIndex=self:convertItemIndex(h,v)
local item=self.dragView:getChildLayoutGroupGridItem(itemIndex-1)
item:SetAsLastSibling(-1)
end
end
end

function UI2048Win:showMove()
local finishCallback=function()
self.animation=nil
self:checkNew(_randomType.addNum,_randomType.addWeight)
self:showNew()
end

if not next(self.distances)then

return
end
self.isAnimting=true
self.animation=Lua.SequenceProxy.New()

self:refreshMoveLayer()

for index,distanceInfo in ipairs(self.distances)do
local h=distanceInfo[2]
local v=distanceInfo[1]
local dv=distanceInfo[3]
local dh=distanceInfo[4]
local itemIndex=self:convertItemIndex(h,v)
local item=self.dragView:getChildLayoutGroupGridItem(itemIndex-1)
local endValue=Vector2.New(dh*_horDisUnit,dv*_verDisUnit)

local tween=item:SetChildDOAnchorPos(_itemCmp.image,endValue,_speed)
tween:SetEase(_Ease)
self.animation:Join(tween)
end

local afterMoveCallback=function()
self:refreshAfterMove()
end
self.animation:AppendCallback(afterMoveCallback)

if not next(self.effects)then

self.animation:AppendCallback(finishCallback)
return
end


local effectCallback=function()
for index,effectInfo in ipairs(self.effects)do
local h=effectInfo[2]
local v=effectInfo[1]
local itemIndex=self:convertItemIndex(h,v)
local item=self.dragView:getChildLayoutGroupGridItem(itemIndex-1)
item:SetChildShowEffect(_itemCmp.effect,10102,true)
end
self:refreshScoreTx()
end
self.animation:AppendCallback(effectCallback)
self.animation:AppendInterval(0.5)
self.animation:AppendCallback(finishCallback)
end

function UI2048Win:refreshAfterMove()
for v=1,_verCnt do
for h=1,_horCnt do
local itemIndex=self:convertItemIndex(h,v)
local item=self.dragView:getChildLayoutGroupGridItem(itemIndex-1)
item:SetChildAnchoredPos(_itemCmp.image,0,0)
local score=self.scores[v][h]
if score>0 then
local assetName=FMT.fmt("image_Xingqiu_{0}",score)
item:SetChildCSImageSprite(_itemCmp.image,_abName,assetName)
else
item:SetChildCSImageIcon(_itemCmp.image,"",true)
end
end
end
end

function UI2048Win:checkNew(numRandom,weightRandom)

table.clear(self.adds)
local empty={}
for v=1,_verCnt do
for h=1,_horCnt do
local score=self.scores[v][h]
if score<=0 then
table.insert(empty,{h,v})
end
end
end
local num=self:getRandom(numRandom)
num=math.min(#empty,num)
for i=1,num do
local score=self:getRandom(weightRandom)
local r=math.random(1,#empty)
local pos=table.remove(empty,r)
local h=pos[1]
local v=pos[2]

self.scores[v][h]=score
table.insert(self.adds,{h,v})
end
self:refreshScore()
end

function UI2048Win:showNew()
local finishCallback=function()
self:refreshScoreTx()
self.animation=nil
self.isAnimting=false
self:checkFinish()
end
if not next(self.adds)then
finishCallback()
return
end

self.animation=Lua.SequenceProxy.New()
for index,addInfo in ipairs(self.adds)do
local v=addInfo[2]
local h=addInfo[1]
local itemIndex=self:convertItemIndex(h,v)
local item=self.dragView:getChildLayoutGroupGridItem(itemIndex-1)
local score=self.scores[v][h]
if score>0 then
local assetName=FMT.fmt("image_Xingqiu_{0}",score)
item:SetChildCSImageSprite(_itemCmp.image,_abName,assetName)
else
item:SetChildCSImageIcon(_itemCmp.image,"",true)
end
item:SetChildScale(_itemCmp.image,Vector3.zero)
local tween=item:SetChildDOScale(_itemCmp.image,1,_speed)
self.animation:Join(tween)
end
self.animation:AppendCallback(finishCallback)
end

function UI2048Win:stopAnimation()
if self.animation and self.animation:IsActive()then
self.animation:Kill()
end
end

function UI2048Win:printScoreData()
local str=""
for v=1,_verCnt do
for h=1,_horCnt do
local score=self.scores[v][h]
str=FMT.fmt("{0}\t{1}",str,score)
end
str=FMT.fmt("{0}\n",str)
end

end
