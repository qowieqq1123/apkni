









worldHUDTaskDisciple=simple_class(worldHUDBase)
worldHUDTaskDisciple.name="worldHUDTaskDisciple"

local childCmp={
symbol=0,
model=1,
emotBg=2,
emotTx=3,
}

local _dragonBone={
[eWorldUnitTpye.EXPERIENCE]=2044,
[eWorldUnitTpye.TOURPOINT]=2066,
}

local _progress_icon={
[worldTripProgress_RunTo_Monster.name]=5,
[worldTripProgress_FlyTo_Monster.name]=5,
[worldTripProgress_RunTo.name]=5,
[worldTripProgress_RunBack.name]=5,
[worldTripProgress_FlyTo.name]=5,
[worldTripProgress_FlyBack.name]=5,
[worldTripProgress_Run_HuntMonsterTeam.name]=5,
[worldTripProgress_Fly_HuntMonsterTeam.name]=5,
}

local _progress_dragonbone={
[worldTripProgress_Experience.name]={1,3},
[worldTripProgress_FlyTour.name]={
worldTripMoveList_FlyTour.MoveType.Jump,
worldTripMoveList_FlyTour.MoveType.Fly,
worldTripMoveList_FlyTour.MoveType.Wait,
worldTripMoveList_FlyTour.MoveType.Animation,
},
[worldTripProgress_RunTour.name]={
worldTripMoveList_RunTour.MoveType.Move,
worldTripMoveList_RunTour.MoveType.Animation,
},
}

function worldHUDTaskDisciple:onCreate()


self.task=worldTaskModel:getTask(self.data[2])
worldHUDBase.onCreate(self)
self:hideEmot()
end

function worldHUDTaskDisciple:onDestory()
self:hideEmot()

end

function worldHUDTaskDisciple:onUpdate()

local expression=self.task.expression[self.task.progress_state]
if expression and#expression.moves>0 then

local check=_progress_icon[expression.name]
if check then
local moveList=expression.moves[1]
self:showIcon(moveList.progress<check)
return
end

check=_progress_dragonbone[expression.name]

if check then
local moveList=expression.moves[1]
local show=table.containsValue(check,moveList.progress)

self:showDragonBone(show)
return
end
end

self:clearIconAndDragonBone()
return
end

function worldHUDTaskDisciple:onFlipX(flip)
local go=self.cmp:GetChildGameObject(0)
local scale=go.transform.localScale
scale.x=math.abs(scale.x)*(flip and 1 or-1)
self.cmp:SetChildScale(childCmp.symbol,scale)
end

function worldHUDTaskDisciple:clearIconAndDragonBone()
self.cmp:SetChildIcon(childCmp.symbol,"",true)
self.cmp:SetChildActive(childCmp.model,false)
end

function worldHUDTaskDisciple:showEmot(emot,cd,callback)


self.cmp:SetChildActive(childCmp.emotBg,true)
self.cmp:SetChildText(childCmp.emotTx,chatEmotHelper.decodeEmot(emot))
self.cmp:ForceLayoutRect(childCmp.emotBg)
if self.emotTimer then
self.emotTimer:cancel()
self.emotTimer=nil
end
if cd then
self.emotTimer=timer.new()
self.emotTimer:start(cd,function()

self:hideEmot()
if callback then
callback()
end
end,1)
end
end

function worldHUDTaskDisciple:hideEmot()
self.cmp:SetChildActive(childCmp.emotBg,false)


if self.emotTimer then
self.emotTimer:cancel()
self.emotTimer=nil
end
end

function worldHUDTaskDisciple:showDragonBone(show)
self.cmp:SetChildActive(childCmp.model,show)
if show then
self.cmp:SetChildIcon(childCmp.symbol,"",false)
local dragonBone=_dragonBone[self.task.target_type]
if dragonBone then
self.cmp:SetChildUIModelShowTarget(childCmp.model,dragonBone,1,nil,60000)
end
end
end

function worldHUDTaskDisciple:showIcon(show)

if show then
local icon=cfgHelper.get3(cfg_worldglobalconfig_get,"taskDisciplineHUDICON","value",self.task.target_type)
local abStr="ui/sharedtextures/uiglobalspriteatlas_1.ab"or""
local assetStr=icon
self.cmp:SetChildCSImageSprite(childCmp.symbol,abStr,assetStr)
self.cmp:SetChildActive(childCmp.model,false)
else
self.cmp:SetChildIcon(childCmp.symbol,"",false)
end
end
