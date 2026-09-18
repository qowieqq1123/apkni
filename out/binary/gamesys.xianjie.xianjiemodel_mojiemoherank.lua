







function xianjieModel:initData_MoHe()
self.MoHedata={}
end

function xianjieModel:clearData_MoHe(isReconnet)
self.MoHedata={}
self.myScore=0
end




function xianjieModel:SetMoHe_PersonalData(len,rankList,myScore)
if len>0 then
self.MoHedata.PersonalData=rankList or{}
self.myrank=-1
local selfactid=tostring(playerModel:getActorID())
local left,right=1,len

while left<=right do
local mid=left+math.floor((right-left)/2)
if self.MoHedata.PersonalData[mid].score<=myScore then
right=mid-1
else
left=mid+1
end
end
local firstIndex=left

for i=firstIndex,len do
if tostring(self.MoHedata.PersonalData[i].actorid)==selfactid then
self.myrank=i
break
end
end
end

self.myScore=myScore or 0
end

function xianjieModel:GetMoHe_PersonalDataList()
return self.MoHedata.PersonalData or{}
end

function xianjieModel:GetMoHe_playerScore()
return self.myScore or 0
end

function xianjieModel:GetMoHe_playerrank()
return self.myrank or-1
end


function xianjieModel:SetMoHe_XMData(len,rankList,XMScore)
if len>0 then
self.MoHedata.XMdata=rankList or{}
self.XMrank=-1
if xianmengModel:hasXM()then
local selfXMid=tostring(xianmengModel:myXMGuildID())
local left,right=1,len

while left<=right do
local mid=left+math.floor((right-left)/2)
if self.MoHedata.XMdata[mid].score<=XMScore then
right=mid-1
else
left=mid+1
end
end
local firstIndex=left

for i=firstIndex,len do
if tostring(self.MoHedata.XMdata[i].xmGuid)==selfXMid then
self.XMrank=i
break
end
end
end

end

self.XMScore=XMScore or 0
end

function xianjieModel:GetMoHe_XMDataList()
return self.MoHedata.XMdata or{}
end

function xianjieModel:GetMoHe_XMScore()
return self.XMScore or 0
end

function xianjieModel:GetMoHe_XMrank()
return self.XMrank or-1
end