






local _MODULENAME="adController"




gameState.addListener(def_table(_MODULENAME))
adController.name=_MODULENAME
adController.data={}



function adController:onAppStart()
socketManager:register_receiver(254,21,self.onPrizeAd)
end


function adController:onEnterState(isReconnect)
end


function adController:onProtocolReq()
end


function adController:onLeaveState(isReconnect)
self.data={}
end


function adController:onLostConnection()

end


function adController:onReConnection(isInitPro)

end


function adController.onPrizeAd(adId,param,useItem,assistant)

end

function adController:reqPlayAD(adId,param,useItem,assistant)
socketManager:send_254_21(adId,param,useItem,assistant or 0)
end


local _editorCallback=function(ret,info,cb)
local attach=info.attach

local strArray=string.split(attach,'|')
local id=tonumber(strArray[1])
local ext=strArray[2]
if ret then
adController:reqPlayAD(id,ext,0)
end
if cb then
cb(ret,id,ext)
end
end

local _callback=function(ret,info)
if not ret then return end
local attach=info.attach

local strArray=string.split(attach,'|')
local id=tonumber(strArray[1])
local ext=strArray[2]
adController:reqPlayAD(id,ext,0)
end


function adController:supportPlayAD()
return houtaiModel:supportAD()
end




function adController:playAD(id,ext,cb,useitem,assistant)
assistant=assistant or 0

local supportPlayAD=adController:supportPlayAD()

if not supportPlayAD then
if cb then
cb(false,id,ext)
end
return false
elseif useitem==1 then
local itemid=cfg_advertconfig().const_def.itemid
if itemsModel.getCount(itemid)>=1 then
adController:reqPlayAD(id,ext,1,assistant)
if cb then
cb(true,id,ext)
end
else
UIManager.error(FMT.fmt("{0}不足",itemsModel.getName(itemid)))
if cb then
cb(false,id,ext)
end
end
else
local aid=cfg_advertconfig_get(id).aid
local attach=FMT.fmt('{0}',id)
if ext and ext~=''then
attach=FMT.fmt('{0}|{1}',id,ext)
end
local callback=function(ret,...)
_callback(ret,...)
if cb then
cb(ret,id,ext)
end
end
if deviceHelper.isRunEditor()then
_editorCallback(true,{attach=attach},cb)
else
platformSDK:reqPlayAD(aid,attach,callback)
end
end
return true
end

function adController:showPlayADDialog(id,ext,cb,dialog)
UIManager:showWindow('UIXianGouGuangGaoDialogWin',{name="提示",extra={id=id,ext=ext},dialog=dialog,callback=cb})
end





function adController:getParam(...)
local out={}
local n=select('#',...)
for i=1,n,1 do
local v=select(i,...)
out[#out+1]=tostring(v)
end
return table.concat(out,"-")
end
