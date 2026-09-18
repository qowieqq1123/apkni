






local _MODULENAME="JiuYuZhengFengModel"


def_table(_MODULENAME)
JiuYuZhengFengModel.name=_MODULENAME
JiuYuZhengFengModel.data={}

function JiuYuZhengFengModel:onAppStart()

end


function JiuYuZhengFengModel:onEnterState(isReconnect)
end


function JiuYuZhengFengModel:onProtocolReq()

end


function JiuYuZhengFengModel:onLeaveState(isReconnect)

self.data={}
self.logList={}
self.scoreListLookUp={}
end

function JiuYuZhengFengModel:setData(data)
self.data=data
end













function JiuYuZhengFengModel:setLogList(logList)
self.logList=logList
end

function JiuYuZhengFengModel:getLogList()
return self.logList
end

function JiuYuZhengFengModel:setScoreList(cross_id,scoreList)
if not self.scoreListLookUp then
self.scoreListLookUp={}
end
local scoreLookUp={}
if scoreList then
for i,v in ipairs(scoreList)do
scoreLookUp[v.param_1]=v.param_2
end
end
self.scoreListLookUp[cross_id]=scoreLookUp
end


function JiuYuZhengFengModel:getScore(cross_id,scoreId)
if self.scoreListLookUp and self.scoreListLookUp[cross_id]then
return self.scoreListLookUp[cross_id][scoreId]or 0
end
return 0
end


function JiuYuZhengFengModel:getData_rankList()
return self.data.rankList
end

function JiuYuZhengFengModel:getData_myRankInfo()
if not self.data.myRankInfo then
local crossId=loginModel:getCrossServerId()
if crossId then
for i,v in ipairs(self.data.rankList or{})do
if v.param_1==crossId then
self.data.myRankInfo={}
self.data.myRankInfo.rank=i
self.data.myRankInfo.crossId=crossId
self.data.myRankInfo.score=v.param_2
break
end
end
else
logErr("仙域评级 拿不到跨服id")
end
end
return self.data.myRankInfo
end

function JiuYuZhengFengModel:getData_rank_level()
return self.data.rank_level
end

function JiuYuZhengFengModel:getData_isSpe()
return self.data.is_spe_state==1
end

function JiuYuZhengFengModel:getData_pfId()
return self.data.pf_id
end

function JiuYuZhengFengModel:getData_is_open()
return self.data.is_open
end

function JiuYuZhengFengModel:getData_is_settle()
return self.data.is_settle
end

function JiuYuZhengFengModel:getDropDownNameList()
local names={}

local cfgs=cfg_xianyulevelcconfig()

for index,cfg in ipairs(cfgs)do
names[#names+1]=cfg.nameIcon
end

return names
end








