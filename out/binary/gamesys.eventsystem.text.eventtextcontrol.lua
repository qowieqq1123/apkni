




eventTextControl={}



function eventTextControl.getOutDiziArgs(eventid,paramList)
local eventconfig=eventConfig.getEventConfig(eventid)
local title=eventconfig.optiontitle
local txt=eventTextControl.getFinalText(title)
return txt
end

function eventTextControl.getOptionRetContent(eventid,optionid,cndid,effectid)
local eventconfig=eventConfig.getEventConfig(eventid)
local optionretcontent=eventconfig.optionretcontent
if optionretcontent then
return optionretcontent[optionid][cndid][effectid]
end
end



function eventTextControl.getTextData(eventconfig,paramList)
local mainType=eventconfig.type1
local subType=eventconfig.type2
local ret=eventControl.invokeEventControl(mainType,subType,'handleParamListToTxt',paramList)
return ret
end

function eventTextControl.getContent(eventguid,eventid,paramList)
local eventconfig=eventConfig.getEventConfig(eventid)
local textData=eventTextControl.getTextData(eventconfig,paramList)
if textData==nil then return end
local content=eventconfig.content
local action=eventConfig.getMultiAction(eventconfig)
return eventTextControl.getContentByParams(eventguid,textData,content,action)
end

function eventTextControl.getOptionContent(eventguid,eventid,paramList,optionid,cndid,effectidx)
local eventconfig=eventConfig.getEventConfig(eventid)
local textData=eventTextControl.getTextData(eventconfig,paramList)
if textData==nil then return end
local optionConfig=eventconfig.option[optionid]
local action=optionConfig.result[cndid][2][effectidx][1]
local contentParam=eventTextControl.getOptionRetContent(eventid,optionid,cndid,effectidx)
if contentParam==nil then
loggerUtil.logErrFMT('没有配置决策结果内容：决策id:{0} 条件序号：{1} 效果序号：{2}',optionid,cndid,effectidx)
return
end
local param={}
local contentCount=contentParam and#contentParam or 0
for i,content in ipairs(contentParam)do
local isIgnoreEffect=false
if contentCount>1 and i==1 then

isIgnoreEffect=true
end
local str=eventTextControl.getContentByParams(eventguid,textData,content,action,isIgnoreEffect)
param[i]=str
end

return param
end


function eventTextControl.getFinalText(fmt,args)
local txt=FMT.out(fmt,args and unpack(args)or nil)
eventActionControl.clearReplaceData()
return txt
end


function eventTextControl.getOutDiziArgs(textData)
if textData.dizi1 then
return{discipleguid=textData.dizi1.diziguid}
end
end

function eventTextControl.getContentByParams(eventguid,textData,content,action,isIgnoreEffect)

local outParmas={}
local replaceArgs={}
if not isIgnoreEffect then
local effectFunc=eventTextConfig.effectFunc
for i,effect in ipairs(action)do
local effectid=effect[1]
if effectFunc[effectid]then
local ret=effectFunc[effectid](eventguid,textData,effect,outParmas,content,replaceArgs)
if ret==false then
return
end
else
for i=2,#effect do
outParmas[#outParmas+1]=math.abs(effect[i])
end
end
end
end
if#outParmas==0 then outParmas=nil end
local args1=""

if textData then
local idx=1
local diziInfoStr=FMT.fmt('dizi{0}',idx)
while textData[diziInfoStr]do
local diziname=FMT.fmt('dname{0}',idx)
eventActionControl.setReplace(diziname,textData[diziInfoStr].diziname)
idx=idx+1
diziInfoStr=FMT.fmt('dizi{0}',idx)
end
args1=eventTextControl.getOutDiziArgs(textData)
end

local txt=eventTextControl.getFinalText(content,outParmas)

return txt,args1 or{}
end
