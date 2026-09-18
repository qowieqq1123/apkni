







activitiesHandle_RankAct1=new_activitiesHandle('activitiesHandle_RankAct1',activitiesHandle)

function activitiesHandle_RankAct1.recv_249_142(actid,act2id,len,list)
local actType=SUB_ACTIVITY_TYPE.eRankAct1

local data={rankList=list}
activitiesModel:setSubActInfoData(actid,actType,act2id,data)

UIManager:callWindowFunc('UISubAct_zhumobang_win','onRankList')
end
