




fightReport={}


local saveReportReportName="fightReportName.json"

local config=nil

local globalReportID=0

local removeTime=86400*5

function fightReport.initReportName()

local c=nil
local e,s=pcall(function()c=jsonHelper.readFile(saveReportReportName,{})end)
if not e then
c={}
end

config=c

end

function fightReport.checkReportTime()
local stamp=gameUtilityModel.getServerShortTime()
for key,v in pairs(config)do
local time=tonumber(key)
if time<=stamp-removeTime then
os.remove(fileHelper.getFullPath(v))
config[key]=nil
end
end
jsonHelper.writeFile(saveReportReportName,config)
end

function fightReport:saveReportName(name)
local stamp=gameUtilityModel.getServerShortTime()
config[tostring(stamp)]=name
jsonHelper.writeFile(saveReportReportName,config)
end

function fightController:saveReport(serverReport)
local battle=fightBattle(serverReport,0)
local clientReport=battle:getLog()
if not clientReport then return end
local filename=''
local isSave=true

if deviceHelper.isRunEditor()then
filename=FMT.fmt('fightReport/{0}-{1}.json',os.date('%mm%dd%Hh%Mm%Ss'),globalReportID)
local weiziReportFileName=FMT.fmt('fightReport/{0}-{1}-wenzi.txt',os.date('%mm%dd%Hh%Mm%Ss'),globalReportID)
local wenziFightReport=clientReport['战斗过程']
local str=''

local wenziFightJunZhenReport=clientReport['军阵信息']

if wenziFightJunZhenReport and next(wenziFightJunZhenReport)then
str=FMT.fmt("{0}\n{1}",str,serializeHelper.serialize(wenziFightJunZhenReport))
str=FMT.fmt("{0}\n\n战斗过程：\n",str)
end

for i,v in ipairs(wenziFightReport)do
str=FMT.fmt("{0}{1}\n",str,v)
end

local wenziFightJunZhenAttrReport=clientReport['军阵属性转换']
str=FMT.fmt("{0}{1}\n",str,serializeHelper.serialize(wenziFightJunZhenAttrReport))


fileHelper.writeFileEx(weiziReportFileName,str)
else
isSave=appUtils.enableDebug
filename=FMT.fmt('fightReport_{0}-{1}.json',os.date('%mm%dd%Hh%Mm%Ss'),globalReportID)
end
if isSave then
globalReportID=globalReportID+1
jsonHelper.writeFile(filename,clientReport)
fightReport:saveReportName(filename)
end
end


function fightController:saveServerReport(serverReport)
local filename=''
local reportID=FMT.fmt('{0}-{1}',os.date('%mm%dd%Hh%Mm%Ss'),globalReportID)
local isSave=true
if deviceHelper.isRunEditor()then
filename=FMT.fmt('fightReport/{0}.json',reportID)
else
isSave=true
filename=FMT.fmt('fightReport_{0}.json',reportID)
end
if isSave then
globalReportID=globalReportID+1
jsonHelper.writeFile(filename,serverReport)

fightReport:saveReportName(filename)
end
return reportID
end

function fightController:readServerReport(reportID)
local filename=''
if deviceHelper.isRunEditor()then
filename=FMT.fmt('fightReport/{0}.json',reportID)
else
filename=FMT.fmt('fightReport_{0}.json',reportID)
end
return jsonHelper.readFile(filename,nil)
end

function fightController:replay(reportName,showStage)
if reportName~=nil then
local filename=''
if deviceHelper.isRunEditor()then
filename=FMT.fmt('fightReport/{0}.json',reportName)
else
filename=FMT.fmt('fightReport_{0}.json',reportName)
end
local clientReport=jsonHelper.readFile(filename)
if clientReport~=nil then
if showStage then
baseFullScreenUI:openMain(false)
end
fightController:startBallte(clientReport["原始战报"],showStage,nil,function(...)
baseFullScreenUI:openMain(true)
end)
end
end
end

