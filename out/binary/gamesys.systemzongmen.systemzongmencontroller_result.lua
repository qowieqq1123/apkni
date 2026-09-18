local _resultData=nil
local _catchResultPrize=false
local _winPrevHandle={
[systemZongMenFuncType.eTaYin]={"UISystemZongMenTaYinWin1","onResult"}
}

function systemZongMenController.onShowPrize(prizeType,temp,effectData,temp2)
if prizeType==ePrizeType.eSystemZongMenTaYin then
if _catchResultPrize then
systemZongMenModel:pushOtherResultData({items=temp})
else
systemZongMenModel:setTempRewards(temp,temp2)
end
end
end

function systemZongMenController.onShowDiscipleChanged(prizeType,temp,effectData)
if prizeType==ePrizeType.eCommonClient then
systemZongMenModel:pushOtherResultData({disciples=temp})
end
end

function systemZongMenController:handleResult()
self.resulting=true
_resultData=systemZongMenModel:getResultWinsEx()
local result=systemZongMenModel:getResultData()
local prevHandle=_winPrevHandle[result.funcType]
if prevHandle then
UIManager:invokeUIMethod(prevHandle[1],prevHandle[2],result.result)
else
systemZongMenController:beginResult()
end
end

function systemZongMenController:beginResult()
if _resultData then
UIManager:showWindow("UISystemZongMenBlackWin",{list=_resultData})
else
self:endResult()
end
end

function systemZongMenController:endResult()
systemZongMenModel:clearResultData()
self.resulting=false
_resultData=nil
end

function systemZongMenController:startCatchResultPrize()
_catchResultPrize=true
end

function systemZongMenController:endCatchResultPrize()
_catchResultPrize=false
end