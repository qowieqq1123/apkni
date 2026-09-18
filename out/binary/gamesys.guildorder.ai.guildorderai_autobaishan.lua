
local guildOrderAI_autoBaiShan={name='autoBaiShan'}


function guildOrderAI_autoBaiShan:onInit()
self.coolDownTime=20
self.coolDownTime2=5
end


function guildOrderAI_autoBaiShan:onDelete()
self.coolDownTime=nil
self.coolDownTime2=nil
end


function guildOrderAI_autoBaiShan:onUpdate()
if xianjieController:isPauseUpdateInXianJie()then return end
local orderID=self.orderID
local setup,cfg=guildOrderModel:getSetupData(orderID)
if not setup.isOpen then
return guildOrderAIState.eClosed
end

local ddatas=shanmenModel:getBaiShanData()

if not ddatas or#ddatas==0 then
return guildOrderAIState.eCond
end


local colorFlaglist=setup.colorFlaglist
local colorvalue={2,3,4,5}
local colortemp={}
for k,v in ipairs(colorFlaglist)do
if v==1 and colorvalue[k]~=nil then
colortemp[#colortemp+1]=colorvalue[k]
end
end

for k,data in ipairs(ddatas)do
local check=true
local netData=data.discipleInfo
local info=UIRecruitModel:GetDiscipleImageInfo(netData)

local color=info.color
for i,color_ in ipairs(colortemp)do
if color_==color then
check=false
break
end
end


if check then

local specialityPreviewFlaglist=setup.specialityPreviewFlaglist
local tezhivalue={4,3,2,1,5}
local tezhitemp={}
for k,v in ipairs(specialityPreviewFlaglist)do
if v==1 then
tezhitemp[#tezhitemp+1]=tezhivalue[k]
end
end

local specialityPreviewList=UIDiscipleModel.getSpecialityPreviewList(netData)

if specialityPreviewList and#specialityPreviewList>0 then
for j,tezi_ in ipairs(specialityPreviewList)do
for x,y in ipairs(tezhitemp)do
if y==tezi_.id then
check=false
break
end
end
end
end
end


if check then
local lp=UIDiscipleModel.getSpecialityLoveLookupByGuildOrder(setup.specialityLoveList)
local list=UIDiscipleModel:getDiscipleAllSpecialityEx(netData)
if list~=nil and#list>0 then
for _,v in ipairs(list)do
local spetype=v[1]
local speid=v[2].param_1
if lp[spetype]~=nil and lp[spetype][speid]==true then
check=false
break
end
end
end
end

if check then

shanmenController:req_banshai_fail(netData.discipleguid)
end
end

return guildOrderAIState.eComplete
end

return guildOrderAI_autoBaiShan