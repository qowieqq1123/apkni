






local _MODULENAME="liandonModel"


def_table(_MODULENAME)
liandonModel.name=_MODULENAME
liandonModel.data={}
local notshowLD=false

function liandonModel:onAppStart()

end


function liandonModel:onEnterState(isReconnect)
liandonModel:liandonCfginit()
end


function liandonModel:onProtocolReq()

end


function liandonModel:onLeaveState(isReconnect)

self.data={}
end



function liandonModel:getLianDonLinkageIdByDZId(dzId)
if dzId==nil then
return 0
end
local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,dzId)
if diziCfg==nil or diziCfg.linkageId==nil then
return 0
end

if liandonModel:isCloseliandonFlag()then
return 0
end

return diziCfg.linkageId
end

function liandonModel:getLianDonLinkageIdByGFId(gfId)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfId)
if cfg.linkageId==nil then
return 0
end

if liandonModel:isCloseliandonFlag()then
return 0
end
return cfg.linkageId
end

function liandonModel:getLianDonLinkageIdByGBId(gbid)
local cfg=cfgHelper.get1(cfg_gubaoconfig_get,gbid)
if cfg.linkageId==nil then
return 0
end


if liandonModel:isCloseliandonFlag()then
return 0
end
return cfg.linkageId
end

function liandonModel:getLianDonLinkageIdByBuildId(buildId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildId)
if cfg.linkageId==nil then
return 0
end

if liandonModel:isCloseliandonFlag()then
return 0
end
return cfg.linkageId
end

function liandonModel:getLianDonLinkageIdByLsId(lsId)
if lsId==nil then
return 0
end
local lsCfg=cfgHelper.get1(cfg_lingshouconfig_get,lsId)
if lsCfg==nil or lsCfg.linkageId==nil then
return 0
end

if liandonModel:isCloseliandonFlag()then
return 0
end

return lsCfg.linkageId
end

function liandonModel:getLianDonLinkageIdByBuildAppearancecId(skinId)
local cfg=cfgHelper.get1(cfg_monijybuildappearanceconfig_get,skinId)
if cfg.linkageId==nil then
return 0
end
return cfg.linkageId
end

function liandonModel:getLianDonLinkageIdByItemId(itemid,type)
if type==nil then
type=ITEM_CONFIG_TYPE.eItem
end
local cfg=itemsConfig.getConfig(itemid,type)
local linkageId=cfg.linkageId
if cfg.type1==13 then
linkageId=self:getGongFaLinkageIdByItemId(itemid)
end
if cfg.type1==3 and cfg.type2==1 then
if cfg.jump and cfg.jump.args and cfg.jump.args.fastBuildId then
linkageId=self:getLianDonLinkageIdByBuildId(cfg.jump.args.fastBuildId)
end
end
if cfg.type1==3 and cfg.type2==6 then
if cfg.jump and cfg.jump.args and cfg.jump.args.skinId then
linkageId=self:getLianDonLinkageIdByBuildAppearancecId(cfg.jump.args.skinId)
end
end
local gbid=gubaoLookup:good2GuBao(itemid)
if gbid~=nil then
linkageId=self:getLianDonLinkageIdByGBId(gbid)
end
if linkageId==nil then
return 0
end


if liandonModel:isCloseliandonFlag()then
return 0
end
return linkageId
end

function liandonModel:getIsLianDonItem(itemid)
local cfg=itemsConfig.getConfig(itemid)
if cfg.linkageId==nil then
return false
end

if liandonModel:isCloseliandonFlag()then
return false
end
return cfg.linkageId>0
end

function liandonModel:getLianDonLinkageIdByPlayerImage(playerImage,sex)
if playerImage==nil then return 0 end
local linkageId=0
local playerLDSuit=self:getPlayerLDSuitData(sex)
for i,v in pairs(playerLDSuit)do
local isSuit=true
for ii,vv in pairs(v.imageList)do
if playerImage[ii]~=vv then
isSuit=false
end
end
if isSuit then
linkageId=v.linkageId

if liandonModel:isCloseliandonFlag()then
return 0
end
break
end
end

return linkageId
end
function liandonModel:getLianDonLinkageIdByPlayerImageItem(tabid,id)
local cfg=playerImageConfig.getSubConfig(tabid,id)
if cfg==nil or cfg.linkageId==nil then
return 0
end

if liandonModel:isCloseliandonFlag()then
return 0
end
return cfg.linkageId
end

function liandonModel:getIsLianDonPlayerSuit(id)
local cfg=cfg_playersuitconfig_get(id)
if cfg==nil or cfg.linkageId==nil then
return false
end


if liandonModel:isCloseliandonFlag()then
return false
end
return cfg.linkageId>0
end

function liandonModel:getLianDonConfig(linkageId)
return cfg_liandonconfig_get(linkageId)
end

function liandonModel:getPlayerLDSuitData(sex)
if not self.data.playerLDSuitData or not self.data.playerLDSuitData[sex]then
self:dealPlayerLDSuitConfig(sex)
end
return self.data.playerLDSuitData[sex]
end


function liandonModel:dealPlayerLDSuitConfig(sex)
self.data.playerLDSuitData=self.data.playerLDSuitData or{}
self.data.playerLDSuitData[sex]=self.data.playerLDSuitData[sex]or{}
local allSuitCfg=cfg_playersuitconfig()
self.data.lookupActiveItem={}
for index,suitCfg in pairs(allSuitCfg)do
if suitCfg.linkageId~=nil and suitCfg.linkageId>0 then
local temp={}
temp.imageList={}
temp.linkageId=suitCfg.linkageId

for itemIndex,itemid in pairs(suitCfg.activeItems)do
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.funcparam and itemCfg.funcparam.list then
for _,partData in pairs(itemCfg.funcparam.list[sex])do
temp.imageList[partData[1]]=partData[2]
end
end
end
self.data.playerLDSuitData[sex][#self.data.playerLDSuitData[sex]+1]=temp
end
end
end

function liandonModel:getGongFaLinkageIdByItemId(itemid)
if not self.gongFaItemLinkageIdList then
self.gongFaItemLinkageIdList={}
local cfgs=cfg_disciplegongfaconfig()
for i,v in pairs(cfgs)do
if v.piece then
for i1,v1 in ipairs(v.piece)do
self.gongFaItemLinkageIdList[v1[1]]=v.linkageId
end
end
end
end
return self.gongFaItemLinkageIdList[itemid]
end


liandongZY=
{
dizi=1,
gongfa=2,
gubao=3,
xianbao=4,
}

function liandonModel:liandonCfginit()
self.liandonCfg=cfg_linkageresourceconfig()
end


function liandonModel:CheckXB_Guanlian(XBid)
if not self.lookup_mainXB then
local cfg=self.liandonCfg and self.liandonCfg[4]
if not cfg then
cfgHelper.get1(cfg_linkageresourceconfig_get,4)
end
self.lookup_mainXB={}
self.lookup_glXB={}
local group=cfg.group
for k,v in ipairs(group)do
self.lookup_mainXB[v[1]]=v[2]
self.lookup_glXB[v[2]]=v[1]
end
end
if self.lookup_mainXB[XBid]then
return self.lookup_mainXB[XBid],1
elseif self.lookup_glXB[XBid]then
return self.lookup_glXB[XBid],2
end
return
end


function liandonModel:CheckGB_Guanlian(GBid)
if not self.lookup_maingubao then
local cfg=self.liandonCfg and self.liandonCfg[3]
if not cfg then
cfg=cfg_linkageresourceconfig_get(3)
end
self.lookup_maingubao={}
self.lookup_glgubao={}
local group=cfg.group
for k,v in ipairs(group)do
self.lookup_maingubao[v[1]]=v[2]
self.lookup_glgubao[v[2]]=v[1]
end
end
if self.lookup_maingubao[GBid]then

return self.lookup_maingubao[GBid],1
elseif self.lookup_glgubao[GBid]then

return self.lookup_glgubao[GBid],2
end
return
end


function liandonModel:CheckGB_Guanlian_Item(GBid)
local glid=liandonModel:CheckGB_Guanlian(GBid)
if glid then

local itemid=gubaoLookup:gubao2GoodActive(glid)

local pieceid=gubaoLookup:gubao2GoodPiece(glid)
return itemid,pieceid
end

return nil,nil
end



function liandonModel:CheckGongFa_Guanlian(GFid)
if not self.lookup_mainGF then
local cfg=self.liandonCfg and self.liandonCfg[2]
if not cfg then
cfgHelper.get1(cfg_linkageresourceconfig_get,2)
end
self.lookup_mainGF={}
self.lookup_glGF={}
local group=cfg.group
for k,v in ipairs(group)do
self.lookup_mainGF[v[1]]=v[2]
self.lookup_glGF[v[2]]=v[1]
end
end
if self.lookup_mainGF[GFid]then

return self.lookup_mainGF[GFid],1
elseif self.lookup_glGF[GFid]then

return self.lookup_glGF[GFid],2
end
return
end


function liandonModel:CheckGongFa_Guanlian_item(itemid)
local gftable=gongfaLookup:checkGongfaPieceindex(itemid)
local gfID=gftable[1]
local index=gftable[2]
local glid=liandonModel:CheckGongFa_Guanlian(gfID)
if glid then
local itemtable=gongfaLookup:checkpiecesgongfa(glid)
if not itemtable then
return
end
if index then
local gl_itemid=itemtable[index]
return gl_itemid
else
logErr(string.format("功法id：%d的item为空",gfID))
return nil
end
end
return nil
end


function liandonModel:JudeGuanLianGFisActive(gfid)

local glid=liandonModel:CheckGongFa_Guanlian(gfid)
if glid then

if UIGongFaModel:isGongFaActive(glid)then
return true
end
end
return false
end


function liandonModel:JudeGuanLianGFCanActive(gfid)

local glid=liandonModel:CheckGongFa_Guanlian(gfid)
if glid then

if UIGongFaModel:hasCanActivePage(glid)then
return true
end
end
return false
end



function liandonModel:CheckDiZi_Guanlian(dzid)
if not self.lookup_mainDZ then
local cfg=self.liandonCfg and self.liandonCfg[1]
if not cfg then
cfgHelper.get1(cfg_linkageresourceconfig_get,1)
end
self.lookup_mainDZ={}
self.lookup_glDZ={}
local group=cfg.group
for k,v in ipairs(group)do
self.lookup_mainDZ[v[1]]=v[2]
self.lookup_glDZ[v[2]]=v[1]
end
end
if self.lookup_mainDZ[dzid]then

return self.lookup_mainDZ[dzid],1
elseif self.lookup_glDZ[dzid]then

return self.lookup_glDZ[dzid],2
end
return
end


function liandonModel:CheckDiZiItem_Guanlian(dzid)
local glid=liandonModel:CheckDiZi_Guanlian(dzid)
if glid then
local yuanpo=cfgHelper.get2(cfg_discipleconfig_get,glid,'yuanpo')

local has_itemNum=bagModel.getItemCountById(yuanpo[1])
return yuanpo[1],has_itemNum
end
return nil,0
end


function liandonModel:CheckDiZiActive_Guanlian(dzid)
local glid=liandonModel:CheckDiZi_Guanlian(dzid)
if glid then
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(glid)
return netData
end
return
end

function liandonModel:isCloseliandonFlag()

local isHouTaiClose=houtaiModel:isNotOpenLiandon()
return isHouTaiClose
end


function liandonModel:test_openliandonFlag()
if not houtaiModel.phpData then
houtaiModel.phpData={}
end

if not houtaiModel.phpData[HOUTAI_TYPE.eliandonFlag]then
houtaiModel.phpData[HOUTAI_TYPE.eliandonFlag]={}
end

houtaiModel.phpData[HOUTAI_TYPE.eliandonFlag]["is_open"]="0"
end