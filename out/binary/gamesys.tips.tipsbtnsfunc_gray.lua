








function tipsBtnsFunc.askforNPCGray(btnType,itemid,itemguid,attach,tipsType,formType)
local askforNPCData=attach.askforNPCData
local interacttype=NPC_INTERACT_TYPE.eAskfor
local npcid=askforNPCData[1]
if not npcModel:checkInteractTypeEnough(npcid,interacttype,false)then
return true
end
return false
end


function tipsBtnsFunc.stealNPCGray(btnType,itemid,itemguid,attach,tipsType,formType)
local stealNPCData=attach.stealNPCData
local interacttype=NPC_INTERACT_TYPE.eSteal
local npcid=stealNPCData[1]
if not npcModel:checkInteractTypeEnough(npcid,interacttype,false)then
return true
end
return false
end


function tipsBtnsFunc.XMDG_shopGray(btnType,itemid,itemguid,attach,tipsType,formType)
if attach and attach.selectNumCmpArgs then
local selectNumCmpArgs=attach.selectNumCmpArgs
if selectNumCmpArgs.max<=0 then
return true
end
end
return false
end


function tipsBtnsFunc.checkUseItemGray(btnType,itemid,itemguid,attach,tipsType,formType)
local itemConfig=itemsConfig.getConfig(itemid)
local level=itemConfig.level or 1
local zmLevel=zongmenModel:getLevel()
return zmLevel<level
end