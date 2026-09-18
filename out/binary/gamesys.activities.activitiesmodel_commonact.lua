


local commonActivitiesDatas={}
local commonActivitiesDatasLookUp={}

function activitiesModel:clearData_CommonAct()
commonActivitiesDatas={}
end


function activitiesModel:recv_commonActivitiesDatas(Type,len,tuituList)
if len>0 then
for i,data in ipairs(tuituList)do
commonActivitiesDatasLookUp[data.index]=data
end
commonActivitiesDatas=tuituList
end
end



function activitiesModel:recv_changeCommonActivitiesDatas(Type,datas)





local strIndex=datas.index
for i,curdata in ipairs(commonActivitiesDatas)do
if curdata.index==strIndex then
commonActivitiesDatas[i]=datas
end
end
local strIndex=datas.index
commonActivitiesDatasLookUp[strIndex]=datas
end



function activitiesModel:getCommonActInfoData(actID,subid,act2index,tuituid)
local strIndex=string.format("%s_%s_%s_%s",actID,subid,act2index,tuituid)
return commonActivitiesDatasLookUp[strIndex]
end