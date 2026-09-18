






def_class('fightTeamShieldAction',fightBaseAction)

function fightTeamShieldAction:__init()
self.typo=fightActionType.TEAM_SHIELD_CHANGE
end


function fightTeamShieldAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.teamType=_rawData[fightTeamShieldTag.teamType]
self.num=_rawData[fightTeamShieldTag.num]
self.nownum=_rawData[fightTeamShieldTag.nownum]

self.rawData=_rawData
self.isComplete=false
self.delayTime=0
self.isDead=false
end


function fightTeamShieldAction:exe()
if self.teamType==1 then
self.isDead=self.battle:updateLeftTeamShield(self.num,self.nownum)
elseif self.teamType==2 then
self.isDead=self.battle:updateRightTeamShield(self.num,self.nownum)
end
self.isExe=true
if self.isDead then
self.delayTime=5
self.isComplete=false
else
self.delayTime=0
self.isComplete=true
end



end

function fightTeamShieldAction:logExe(logContent)
logContent(FMT.fmt('{0}队伍护盾值由{1}变化为{2},变化量{3}',self.teamType==1 and'攻方'or'守方',self.nownum+self.num,self.nownum,self.num))
self.isComplete=true
end

function fightTeamShieldAction:statisticsExe()

end

function fightTeamShieldAction:update(deltaTime)

if self.isExe then
self.delayTime=self.delayTime-deltaTime
if self.delayTime<0 then
self.isComplete=true
end
end

return self.isComplete
end

function fightTeamShieldAction:onDespwan()
self.round=nil
self.battle=nil

self.rawData=nil
self.isComplete=false
self.teamType=nil
self.num=nil
self.nownum=nil
fightActionMrg:recycleAction(self)
end