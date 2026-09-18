
tempDataControl=gameState.addListener({})

tempDataType={

}

function tempDataControl:onEnterState(isReconnect)
if isReconnect then
return
end

self.recordDataDict={}






self.winDataDict={}
end

function tempDataControl:onLeaveState(isReconnect)
if isReconnect then
return
end

self.recordDataDict=nil



self.winDataDict=nil
end




function tempDataControl:recordData(tType,rData)






self.recordDataDict[tType]=rData
end


function tempDataControl:getData(tType)
return self.recordDataDict[tType]
end




function tempDataControl:recordWinData(winName,wData)







self.winDataDict[winName]=wData
end


function tempDataControl:getWinData(winName)
return self.winDataDict[winName]
end
