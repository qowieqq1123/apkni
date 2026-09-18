





comHelper={}

function comHelper.setChildHead(widget,diziguid,index,scale,offsetX,offsetY,stopAnim,softMask,fadeIn)
if widget==nil then return end
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(diziguid)
widget:SetChildUIModelShowTarget(index,
modelParams.body,
scale or 1,
modelParams.componets,
modelParams.anim,
stopAnim==nil and true or stopAnim,
softMask==nil and false or softMask,
fadeIn or 0.6)
widget:SetChildUIModelShowTargetOffset(index,offsetX or modelParams.offset[1],offsetY or modelParams.offset[2])
end

function comHelper.setChildHead2(uiObject,diziguid,scale,offsetX,offsetY,stopAnim,softMask,fadeIn)
if uiObject==nil then return end
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(diziguid)
uiObject:setChildUIModelShowTarget(modelParams.body,
scale or 1,
modelParams.componets,
modelParams.anim,
stopAnim==nil and true or stopAnim,
softMask==nil and false or softMask,
fadeIn or 0.6)
uiObject:setChildUIModelShowTargetOffset(offsetX or modelParams.offset[1],offsetY or modelParams.offset[2])
end

function comHelper.setChildInSideModel(uiObject,diziguid,scale,anim,offsetX,offsetY,stopAnim,softMask,fadeIn,args,switchidx)
if uiObject==nil then return end
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(diziguid,args,switchidx)
comHelper.setChildInSideModelEx(uiObject,modelParams,scale,anim,offsetX,offsetY,stopAnim,softMask,fadeIn)
end

function comHelper.setChildInSideModelEx(uiObject,modelParams,scale,anim,offsetX,offsetY,stopAnim,softMask,fadeIn)
if uiObject==nil then return end
uiObject:setChildUIModelShowTarget(modelParams.body,
scale or modelParams.scale,
modelParams.componets,
anim or modelParams.anim,
stopAnim==nil and false or stopAnim,
softMask==nil and false or softMask,
fadeIn or-1)
if offsetX~=nil and offsetY~=nil then
uiObject:setChildUIModelShowTargetOffset(offsetX,offsetY)
end
end

function comHelper.setChildInSideModel2(widget,diziguid,index,scale,anim,offsetX,offsetY,stopAnim,softMask,fadeIn)
if widget==nil then return end
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(diziguid)
widget:SetChildUIModelShowTarget(index,
modelParams.body,
scale or modelParams.scale,
modelParams.componets,
anim or modelParams.anim,
stopAnim==nil and false or stopAnim,
softMask==nil and false or softMask,
fadeIn or-1)
if offsetX~=nil and offsetY~=nil then
widget:SetChildUIModelShowTargetOffset(index,offsetX,offsetY)
end
end

function comHelper.setChildInSideModel3(widget,modelParams,index,scale,anim,offsetX,offsetY,stopAnim,softMask,fadeIn)
if widget==nil then return end
widget:SetChildUIModelShowTarget(index,
modelParams.body,
scale or modelParams.scale,
modelParams.componets,
anim or modelParams.anim,
stopAnim==nil and false or stopAnim,
softMask==nil and false or softMask,
fadeIn or-1)
if offsetX~=nil and offsetY~=nil then
widget:SetChildUIModelShowTargetOffset(index,offsetX,offsetY)
end
end




function comHelper.setChildModelRawImage(widget,diziguid,index,anim,headCenterType,size,gray,cache,switchidx)
if widget==nil then return end
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(diziguid,nil,switchidx)


local isTop=UIDiscipleModel:isTexture2dTopDisciple(tostring(diziguid))
cache=cache and isTop or false

headCenterType=headCenterType or 1
if anim then
modelParams.anim=anim
end
comHelper.setChildModelRawImageEx(index,widget,modelParams,headCenterType,size,gray,cache)
end


function comHelper.setChildModelRawImageByDiziId(widget,diziId,index,anim,headCenterType,size,gray)
if widget==nil then return end
local diziData=UIDiscipleModel:getDiscipleDataByDiziId(diziId)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(diziData)
headCenterType=headCenterType or 1
if anim then
modelParams.anim=anim
end
comHelper.setChildModelRawImageEx(index,widget,modelParams,headCenterType,size,gray)
end



function comHelper.setChildModelRawImage_monster(widget,monsterId,index,anim,headCenterType,size,gray)
if widget==nil then return end
local modelParams=comHelper.getMonsterModelParams(monsterId)
if anim then
modelParams.anim=anim
end
comHelper.setChildModelRawImageEx(index,widget,modelParams,headCenterType,size,gray)
end
function comHelper.setChildModelRawImage_monsterGroup(widget,monsterGroupId,index,anim,headCenterType,size,gray)
if widget==nil then return end
local modelParams=comHelper.getMonsterGroupModelParams(monsterGroupId)
if anim then
modelParams.anim=anim
end
comHelper.setChildModelRawImageEx(index,widget,modelParams,headCenterType,size,gray)
end
function comHelper.getMonsterModelParams(monsterId)
local cfg=cfgHelper.get1(cfg_monsterconfig_get,monsterId)
local result
if cfg.npcID~=nil then
result=fightPreSelectModel.getNPCInSideModel(cfg.npcID)
comHelper.getMonsterModelParamsEx2(result)
else
result=comHelper.getMonsterModelParamsEx(cfg.modelid[1])
result.componets=cfg.modelid[2]or{}
end
return result
end
function comHelper.getMonsterGroupModelParams(monsterGroupId)
local cfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local result=comHelper.getMonsterModelParamsEx(cfg.model[1])
result.componets=cfg.model[3]or{}
return result
end
function comHelper.getMonsterModelParamsEx(modelid)
local result={}
result.body=modelid
result.componets={}
comHelper.getMonsterModelParamsEx2(result)
return result
end

function comHelper.getMonsterModelParamsEx2(result)
local dbcfg=cfgHelper.get1(cfg_dbbodyconfig_get,result.body)
local scales=dbcfg.scales or{}
result.offset=dbcfg.headOffset or{0,-90}
if result.offset[3]then
result.scale=result.offset[3]
else
result.scale=scales[1]or 1
end
result.icon_head=dbcfg.icon_head
result.anim=0
end

function comHelper.getModelScales2Config(body,type)
local scales2=cfgHelper.get2(cfg_dbbodyconfig_get,body,"scales2")
return scales2 and scales2[type]or nil
end


function comHelper.setChildModelRawImage_npc(widget,npcImgID,index,anim,headCenterType,size,gray)
if widget==nil then return end
local modelParams=npcModel:getImageInfo(npcImgID)
if anim then
modelParams.anim=anim
end
comHelper.setChildModelRawImageEx(index,widget,modelParams,headCenterType,size,gray)
end


function comHelper.setChildModelRawImage_lingshou(widget,lsID,index,anim,headCenterType,size,gray)
if widget==nil then return end
local modelParams=comHelper.getLingShouModelParams(lsID)
if anim then
modelParams.anim=anim
end
comHelper.setChildModelRawImageEx(index,widget,modelParams,headCenterType,size,gray)
end
function comHelper.getLingShouModelParams(lsID)
local cfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local result=comHelper.getMonsterModelParamsEx(cfg.model)
return result
end




function comHelper.setChildLingShouBaseCard(widget,lsGuid,descType,clickFunc)
local guid=lsGuid
local lsData=lingshouModel:getLingShouData(lsGuid)
local lsID=lsData.id
local lscfg=lsData.cfg
if not lscfg then
lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
end

local color=lingshouModel:getColor(guid)
widget:SetChildCSImageSprite(0,globalABLookup.lingshoumain,lingshouColorToFrame[color])

local name_str=lsData.name
widget:SetChildText(1,name_str)


comHelper.setChildModelRawImage_lingshou(widget,lsID,2,0,eHeadCenterType.eHead,1)

descType=descType or 4
if descType==1 then


widget:SetChildActive(5,false)

local jj_str=lingshouModel:getJJName(guid,2)
widget:SetChildText(4,jj_str)
elseif descType==2 then

widget:SetChildActive(5,false)

local ql_str=lingshouModel:getQianLiDesc(guid)
ql_str=FMT.fmt("潜力：<color=#171311>{0}</color>",ql_str)
widget:SetChildText(4,ql_str)
elseif descType==3 then

widget:SetChildActive(5,false)

local str=FMT.fmt("资质：<color=#171311>{0}</color>",lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI))
widget:SetChildText(4,str)
elseif descType==4 then

widget:SetChildActive(5,true)
local fight=lingshouModel:getFightValue(guid)
widget:SetChildText(5,FMT.fmt("<color=#7D3B17>战力</color> {0}",mathHelper.formatNumber7(fight,1,2)))

widget:SetChildText(4,'')
elseif descType==5 then

widget:SetChildActive(5,false)

local str=FMT.fmt("血脉：<color=#171311>{0}</color>",lingshouModel:switchLevelToStageName_XueMai(lsData.xuemai_val))
widget:SetChildText(4,str)
end

local showSign=lscfg.bianyi==1
widget:SetChildActive(3,showSign)

local generation=lsData.generation
widget:SetChildText(8,FMT.fmt("{0}代",generation))
local generationShowParams=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,'generationShowBg')
local generationParam=generationShowParams[generation]or generationShowParams[#generationShowParams]
local abName=generationParam.abname
local iconName=generationParam.icon
widget:SetChildCSImageSprite(7,abName,iconName)


if clickFunc then
widget:SetChildButtonClick(-1,clickFunc,true)
end
end





function comHelper.setChildModelRawImageEx(index,widget,modelParams,headCenterType,size,gray,cache)
if widget==nil then return end

if api_Available_SetChildModelCaptureIcon()and modelParams.icon_head then
widget:SetChildModelCaptureIcon(index,modelParams.icon_head,gray,false)
else
if api_Available_SetChildModelCaptureIcon()then
widget:SetChildModelCaptureIcon(index,nil,gray,false)
end

local offsetX=0
local offsetY=0
if modelParams.offset then
offsetX=modelParams.offset[1]
offsetY=modelParams.offset[2]
else
local headOffset=cfgHelper.get2(cfg_dbbodyconfig_get,modelParams.body,'headOffset')
if headOffset then
offsetX=headOffset[1]
offsetY=headOffset[2]
end
end
local headCenterX=0
local headCenterY=0
local texSize=1
headCenterType=headCenterType or eHeadCenterType.eHead

if not modelParams.headCenter then
local headCenter=cfgHelper.get2(cfg_dbbodyconfig_get,modelParams.body,'headCenter')or{}
modelParams.headCenter=headCenter[headCenterType]
end


if modelParams.headCenter then
headCenterX=modelParams.headCenter[1]or 0
headCenterY=modelParams.headCenter[2]or 0
texSize=modelParams.headCenter[3]or 1
end

if size then
texSize=size
end

if api_Available_SetChildModelCaptureImageEx()then
widget:SetChildModelCaptureImageEx(index,modelParams.body,modelParams.componets,modelParams.scale or 1
,modelParams.anim or 0,offsetX,offsetY,Vector2(headCenterX,headCenterY),texSize,gray or false,cache or false)
else
widget:SetChildModelCaptureImage(index,modelParams.body,modelParams.componets,modelParams.scale or 1,modelParams.anim or 0,offsetX,offsetY,Vector2(headCenterX,headCenterY),texSize,gray or false)
end
end

end





function comHelper.setChildDiziExpression(widget,index,id,spineBodyID)
if spineBodyID~=nil and spineHelper.enableChangeFace(spineBodyID)then
if id>0 then
local cfg=cfgHelper.get1(cfg_discipleexpressionimageconfig_get,id)
if cfg~=nil then
widget:SetChildChangeSlotDisplay(index,"face","face",cfg.out_side)
end
else
widget:SetChildChangeSlotDisplay(index,"face","face",0)
end
end
end

function comHelper.setChildFollowActorExpression(widget,index,boneName,id)
if deviceHelper.getAPILevel()>=3 then
if id>0 then
local cfg=cfgHelper.get1(cfg_discipleexpressionimageconfig_get,id)
if cfg~=nil then
widget:SetChildChangeFollowActorSlotDisplay(index,boneName,"face","face",cfg.out_side)
end
else
widget:SetChildChangeFollowActorSlotDisplay(index,boneName,"face","face",0)
end
end
end

function comHelper.setChildModelHeadIconBG(widget,index,dzguid,switchidx)
comHelper.setChildModelHeadIconBGByColor(widget,index,UIDiscipleModel:getDiscipleColor(dzguid,switchidx))
end

function comHelper.setChildModelHeadIconBGByColor(widget,index,color)
local bgName=FMT.fmt('image_gwtouxiangpjk_{0}',color)
local abName=globalABLookup.global
if color==0 then
abName=globalABLookup.globa4
end
widget:SetChildCSImageSprite(index,abName,bgName)
end

local _ParseModelParams=function(imagelist,sex,dynamic)
local modelParams={}
modelParams.body=playerImageConfig.getPlayerImageBody(sex)

local componets={}
modelParams.componets=componets
for tabid,id in pairs(imagelist)do
local subCfg=playerImageConfig.getSubConfig(tabid,id)
if subCfg~=nil then
if subCfg.spineid then
if dynamic then
if subCfg.skeletonID~=nil then
modelParams.body=subCfg.skeletonID
else
if subCfg.dynamicSpineID~=nil then
componets[#componets+1]=subCfg.dynamicSpineID
else
componets[#componets+1]=subCfg.spineid
end

end
else
componets[#componets+1]=subCfg.spineid
end
end
else
if id~=0 then
logErr(FMT.fmt("类型{0}不存在ID:{1}",tabid,id))
end
end

end

return modelParams
end

function comHelper.setChildPlayerRawImage(widget,index,playerImage,sex,scale,ani,offsetX,offsetY,headCenterType,size,gray,dynamic)


local imagelist=playerImageModel:getSupportImage(playerImage,PLAYER_IMAGE_TYPE.eFace)
ani=playerImageController.getPlayerImageSuitAni(playerImage,sex)or ani

local modelParams=_ParseModelParams(imagelist,sex,dynamic)
local headCenterX=0
local headCenterY=0
local texSize=1

local headCenter=cfgHelper.get2(cfg_dbbodyconfig_get,modelParams.body,'headCenter')or{}
local headCenterArgs=headCenter[headCenterType]

if size then texSize=size end


if headCenterArgs then
headCenterX=headCenterArgs[1]or 0
headCenterY=headCenterArgs[2]or 0
texSize=headCenterArgs[3]or 1
end

widget:SetChildModelCaptureImage(index,modelParams.body,modelParams.componets,scale or 1,ani or 0,offsetX or 0,offsetY or 0,Vector2(headCenterX,headCenterY),texSize,gray or false)
end

function comHelper.setChildPlayerImage(widget,index,playerImage,sex,scale,ani,offsetX,offsetY,dynamic,action,enableFadeCompatible)


local imagelist=playerImageModel:getSupportImage(playerImage,PLAYER_IMAGE_TYPE.eFace)

local modelParams=_ParseModelParams(imagelist,sex,dynamic)

ani=playerImageController.getPlayerImageSuitAni(playerImage,sex)or ani

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
if enableFadeCompatible then
widget:SetChildUIModelEnableInitUISpineParaEx(index,true,true,true)
else
widget:SetChildUIModelEnableInitUISpineParaEx(index,false,true,false)
end
end
widget:SetChildUIModelShowTarget(index,modelParams.body,
scale or 1,
modelParams.componets,
ani or eAnimationID.idle,
false,
false,
-1,
action)
if offsetX~=0 or offsetY~=0 then
widget:SetChildUIModelShowTargetOffset(index,offsetX or 0,offsetY or 0)
end
end

function comHelper.setChildPlayerImage2(widget,index,playerImage,sex,scale,ani,offsetX,offsetY,dynamic)

local modelParams=_ParseModelParams(playerImage,sex,dynamic)

ani=playerImageController.getPlayerImageSuitAni(playerImage,sex)or ani

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
widget:SetChildUIModelEnableInitUISpineParaEx(index,false,true,false)
end
widget:SetChildUIModelShowTarget(index,modelParams.body,
scale or 1,
modelParams.componets,
ani or eAnimationID.idle,
false,
false,
-1)
if offsetX~=0 or offsetY~=0 then
widget:SetChildUIModelShowTargetOffset(index,offsetX or 0,offsetY or 0)
end
end

function comHelper.setChildMount(widget,index,modelId,componets,node,scale,offsetX,offsetY,offsetZ,action)
offsetX=offsetX or 0
offsetY=offsetY or 0
offsetZ=offsetZ or 0
local scaleArgs=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'scales')or{}
scale=scale or scaleArgs[2]or 1
widget:SetChildUIModelMount(index,modelId,
componets,
node,
scale,
Vector3.New(offsetX,offsetY,offsetZ),
action)
end


function comHelper.setOutSideChildMount(dzguid,widget,index,node,scale,offsetX,offsetY,action)
local modelParams=mountHelper.getMountModelParams(dzguid)
if modelParams==nil then
widget:SetChildUIModelUnMount(index)
return
end
local offset=modelParams.offset or{}
offsetX=offsetX or offset[1]or 0
offsetY=offsetY or offset[2]or 0
local offsetZ=offset[3]or 1
local modelId=modelParams.model
local scaleArgs=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'scales')or{}
scale=scale or scaleArgs[2]or 1
node=node or'zuoqidian'
comHelper.setChildMount(widget,index,modelId,{},node,scale,offsetX,offsetY,offsetZ,action)
if api_Available_SetChildUIModelMountSeparatorSlot()then
if modelParams.spSlot~=nil then
widget:SetChildUIModelMountSeparatorSlot(index,modelParams.spSlot)
end
end
end


function comHelper.setInSideChildMount(dzguid,widget,index,node,scale,offsetX,offsetY,action)
local modelParams=mountHelper.getMountModelParams(dzguid)
if modelParams==nil then
widget:SetChildUIModelUnMount(index)
return
end
local offset=modelParams.offset or{}
offsetX=offsetX or offset[1]or 0
offsetY=offsetY or offset[2]or 0
local offsetZ=offset[3]or 1
local modelId=modelParams.model
local scaleArgs=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'scales')or{}
scale=scale or scaleArgs[1]or 1
node=node or'zuoqidian'
comHelper.setChildMount(widget,index,modelId,node,scale,offsetX,offsetY,offsetZ,action)
if api_Available_SetChildUIModelMountSeparatorSlot()then
if modelParams.spSlot~=nil then
widget:SetChildUIModelMountSeparatorSlot(index,modelParams.spSlot)
end
end
end







function comHelper.getCheckLayoutStr(checkTextObj,maxWidth,str,isReplaceSpace,ignoreCharList)
if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
local text=ComponentHelper.GetComponent(checkTextObj,UI.Text)

local ignoreCharList_lookup={}
if ignoreCharList then
for i,char in ipairs(ignoreCharList)do
ignoreCharList_lookup[char]=true
end
end


local clearLinkStr=string.gsub(str,"<a;[^>]+>",function(word)
local argList=string.split(word,";")
if argList and argList[2]then
local wordText=argList[2]
local replaceWord=wordText
return replaceWord
else
return""
end
end)

local richStrList={}
local clearRichStr=string.gsub(clearLinkStr,"<[^>]+>",function(word)
local index=#richStrList+1
local charTable=string.toTable(word)
richStrList[index]=charTable
return""
end)

local charList=string.toTable(str)
local charList_clearRich=string.toTable(clearRichStr)
local textWidthList={}
local lineWidth=0
local clearRichIndex=1
local checkRichStrIndex=1
local skipNum=0
for i,char in ipairs(charList)do
local isSkip=false
if skipNum>0 then
skipNum=skipNum-1
isSkip=true
end

if not isSkip then
local clearRichChar=charList_clearRich[clearRichIndex]
if char==clearRichChar then
clearRichIndex=clearRichIndex+1
if isReplaceSpace and char==" "then

char="\194\160"
end
text.text=char
local width=text.preferredWidth
if width==0 then

lineWidth=width
else
lineWidth=lineWidth+width
if lineWidth>maxWidth then

if ignoreCharList_lookup[char]or(not specialfontHelper.check_spec_char_same(char,1)and not specialfontHelper.check_spec_char_same(char,3))then

char=FMT.fmt("\n{0}",char)
lineWidth=width
end
end
end
else
local checkRichStrTable=richStrList[checkRichStrIndex]
if checkRichStrTable and next(checkRichStrTable)~=nil then
if checkRichStrTable[1]==char then

local len=#checkRichStrTable
local isSame=true
local sameNum=0
for idx=1,len do
local index=idx+i-1
if checkRichStrTable[idx]==charList[index]then
sameNum=sameNum+1
else
isSame=false
break
end
end

if isSame then
skipNum=skipNum+sameNum-1
end
end
end
end
end
table.insert(textWidthList,char)
end
local checkStr=table.concat(textWidthList)
return checkStr
elseif pfwindowslController:checkIsGameVersion_yuenan()then
local text=ComponentHelper.GetComponent(checkTextObj,UI.Text)
local ignoreCharList_lookup={}
if ignoreCharList then
for i,char in ipairs(ignoreCharList)do
ignoreCharList_lookup[char]=true
end
end


local clearLinkStr=string.gsub(str,"<a;[^>]+>",function(word)
local argList=string.split(word,";")
return argList and argList[2]or""
end)


local richStrList={}
local clearRichStr=string.gsub(clearLinkStr,"<[^>]+>",function(word)
table.insert(richStrList,string.toTable(word))
return""
end)

local charList=string.toTable(str)
local charList_clearRich=string.toTable(clearRichStr)
local textWidthList={}
local lineWidth=0
local clearRichIndex=1
local checkRichStrIndex=1
local skipNum=0

local lastBreakPos=nil
local lastBreakWidth=0

for i,char in ipairs(charList)do
local isSkip=false
if skipNum>0 then
skipNum=skipNum-1
isSkip=true
end

if not isSkip then
local clearRichChar=charList_clearRich[clearRichIndex]
if char==clearRichChar then
clearRichIndex=clearRichIndex+1


local isNormalSpace=(char==" "and not isReplaceSpace)
local isNonBreakingSpace=(char=="\194\160")
if isNormalSpace then

lastBreakPos=#textWidthList+1
lastBreakWidth=lineWidth
end


text.text=char
local charWidth=text.preferredWidth

if char==" "and charWidth==0 then
charWidth=text.fontSize*0.2
end

if charWidth==0 then

lineWidth=0
lastBreakPos=nil
lastBreakWidth=0
else
lineWidth=lineWidth+charWidth


if lineWidth>maxWidth then
local breakInserted=false

if lastBreakPos then

textWidthList[lastBreakPos]=tostring(textWidthList[lastBreakPos]or" ")
textWidthList[lastBreakPos]=textWidthList[lastBreakPos].."\n"

lineWidth=lineWidth-lastBreakWidth

lastBreakPos=nil
lastBreakWidth=0
breakInserted=true
end


if not breakInserted then

local isSymbol=specialfontHelper.check_spec_char_same(char,1)or specialfontHelper.check_spec_char_same(char,3)
if not ignoreCharList_lookup[char]and not isSymbol then

char="\n"..char
lineWidth=charWidth
end
end
end
end
else

local checkRichStrTable=richStrList[checkRichStrIndex]
if checkRichStrTable and checkRichStrTable[1]==char then
local len=#checkRichStrTable
local isSame=true
for idx=1,len do
local index=idx+i-1
if checkRichStrTable[idx]~=charList[index]then
isSame=false
break
end
end
if isSame then
skipNum=skipNum+len-1
end
end
end
end
table.insert(textWidthList,char)
end

return table.concat(textWidthList)
end
end


function comHelper.getCheckStrStartFormat(str)
local charList=string.toTable(str)
local char=charList[1]
if char==" "or char=="　"or char=="\194\160"or char=="\t"then

return str
end


local isSpecialStart=false
local specialStartList={"亲爱的","尊敬的","祖师大人"}
for i=1,#specialStartList do
local specialStr=specialStartList[i]
local targetFirstIndex=string.find(str,specialStr)
if targetFirstIndex and targetFirstIndex==1 then
isSpecialStart=true
break
end
end
if isSpecialStart then

return str
end


local startStr=FMT.fmt("\t\t{0}",str)
return startStr
end


function comHelper.cleanUserData(t)
for k,v in pairs(t)do
if type(v)=='table'then
comHelper.cleanUserData(v)
end
if type(v)=='userdata'then
t[k]=nil
end
end
end

function comHelper.setChildFightReportStart(widget,index,reportId,stageId,callback)
local stage=nil
local _onFightStageLoaded=function()
local report=fightModel:getFightReport(reportId)
local battleId=fightController:startBallte(report,true,nil,nil,{hideStartWin=true,repeatPlayRound=true,entHideHud=true,resetCamera=true})
local sizeDeltaX=widget:GetChildSizeDeltaX(index)
local sizeDeltaY=widget:GetChildSizeDeltaY(index)
widget:SetChildFightRenderToImage(index,true,sizeDeltaX,sizeDeltaY,17)
widget:SetChildActive(index,true)
callback(battleId)
end

stage=fightStage:create(stageId,_onFightStageLoaded,{})
return stage
end

function comHelper.setChildFightReportClose(widget,index,battleId,stage)
if battleId then
fightController:completeBattle(battleId,true)
fightController:closeBattle(battleId)
battleId=nil
end

if stage then
stage:close()
end

widget:SetChildFightRenderToImage(index,false,0,0,17)
end
