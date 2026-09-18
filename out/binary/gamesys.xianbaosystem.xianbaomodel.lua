






local _MODULENAME="xianbaoModel"


def_table(_MODULENAME)
xianbaoModel.name=_MODULENAME
xianbaoModel.data={}

function xianbaoModel:onAppStart()

end


function xianbaoModel:onEnterState(isReconnect)
self.data={}
end


function xianbaoModel:onProtocolReq()

end


function xianbaoModel:onLeaveState(isReconnect)

self.data={}
end



function xianbaoModel:setData(data)
self.data=data
end

function xianbaoModel:getData()
return self.data
end

function xianbaoModel:refreshXBList()

local allxbCfg=xianbaoConfig.getAllXBCfg()
local notActiveList={}
local activeList={}
local canActiveList={}
local activeAndUpStarList={}
local xbId
local activeFlag
for k,v in pairs(allxbCfg)do
xbId=k
activeFlag=xianbaoModel:checkActive(xbId)
if activeFlag then
activeList[#activeList+1]=xbId
if xianbaoModel:checkCanUpStar(xbId)then
activeAndUpStarList[#activeAndUpStarList+1]=xbId
end
else
local glid,main=liandonModel:CheckXB_Guanlian(xbId)
if xianbaoModel:checkCanActive(xbId)then
if glid then

local glactive=xianbaoModel:JudeGuanLianXianBao(glid)


if not glactive then
canActiveList[#canActiveList+1]=xbId
else

if xianbaoModel:checkCanActive(xbId)and xianbaoModel:checkCanActive(glid)then
if main==1 then

canActiveList[#canActiveList+1]=xbId
end
end
end
else
canActiveList[#canActiveList+1]=xbId
end
else
if not v.isHide then
if glid then

local glactive=xianbaoModel:JudeGuanLianXianBao(glid)
if not glactive then

if main==1 then
notActiveList[#notActiveList+1]=xbId
end

end
else
notActiveList[#notActiveList+1]=xbId
end
end
end

end

end
self.notActiveList=notActiveList
self.activeList=activeList
self.canActiveList=canActiveList
self.activeAndUpStarList=activeAndUpStarList
end

function xianbaoModel:checkCanActive(xbId)
if xianbaoModel:checkActive(xbId)then
return false
end
local xbCfg=xianbaoConfig.getXBCfg(xbId)
local active=xbCfg.active
if not active then
return false
end
local itemId,needCoun,hasCount
for k,v in pairs(active)do
itemId=k
needCoun=v
hasCount=itemsModel.getCount(itemId)
if hasCount>=needCoun then
return true,itemId
end
end
return false
end

function xianbaoModel:checkCanUpStar(xbId)
if xianbaoModel:CheckDianfengXianbao(xbId)then
return false
end
local maxStar=xianbaoConfig.getXBMaxStar(xbId)
return maxStar>0
end

function xianbaoModel:checkActive(xbId)
local data=self.data
return data[xbId]~=nil
end

function xianbaoModel:checkIsMaxStar(xbId)
if not xianbaoModel:checkCanUpStar(xbId)then
return false
end
local star=xianbaoModel:getXbStart(xbId)
local maxStar=xianbaoConfig.getXBMaxStar(xbId)
if star>=maxStar then
return true
end
end

function xianbaoModel:checkUpStar(xbId)
if not xianbaoModel:checkCanUpStar(xbId)then
return false
end
local star=xianbaoModel:getXbStart(xbId)
if xianbaoModel:checkIsMaxStar(xbId)then
return false
end
local nextXbStarCfg=xianbaoConfig.getXBStarCfg(xbId,star+1)
local cost=nextXbStarCfg.up_star_cost
if not cost then
return true
end
local itemId,hasCount,needCount
for i,v in ipairs(cost)do
itemId=v[1]
needCount=v[2]
hasCount=itemsModel.getCount(itemId)
if hasCount<needCount then
return false,itemId
end
end
return true
end

function xianbaoModel:getXbStart(xbId)
return self.data[xbId]or 0
end


function xianbaoModel:getXbStart_liandon(xbId)
if not xianbaoModel:checkActive(xbId)then
local glid=liandonModel:CheckXB_Guanlian(xbId)
if glid and xianbaoModel:checkActive(xbId)then
return self.data[glid]or 0
end
end
return self.data[xbId]or 0
end


function xianbaoModel:getBagList()
xianbaoModel:refreshXBList()
return self.canActiveList
end

function xianbaoModel:getActiveList()
xianbaoModel:refreshXBList()
return self.activeList
end

function xianbaoModel:getNotActiveList()
xianbaoModel:refreshXBList()
return self.notActiveList
end

function xianbaoModel:getCanActiveList()
xianbaoModel:refreshXBList()
return self.canActiveList
end

function xianbaoModel:getUpStarList()
xianbaoModel:refreshXBList()
return self.activeAndUpStarList
end

function xianbaoModel:getBagReddot()
return false
end

local effectReddotFun={
[XianBaoEffectType.ZTP]=function()
if not YiFangLingTianModel:GetISOpen()then
return false
end
local cur,maxPro=YiFangLingTianModel:GetLingYeNum()
return cur>=maxPro
end
}

function xianbaoModel:checkXBEffectReddot(effectType)
local fun=effectReddotFun[effectType]
if fun then
return fun()
end
return false
end

function xianbaoModel:checkXBReddot(xbId)
if xianbaoModel:CheckDianfengXianbao(xbId)then
return DianFengLevelController:checkDFReddot()
end
if xianbaoModel:checkUpStar(xbId)then
return true
end
local xbCfg=xianbaoConfig.getXBCfg(xbId)
local effectType=xbCfg.effectType
return xianbaoModel:checkXBEffectReddot(effectType)
end

function xianbaoModel:getTujianReddot()
if not xianbaoController:checkOpenXianBao()then
return false
end
xianbaoModel:refreshXBList()
if#self.canActiveList>0 then
return true
end
local xbId
for i,v in ipairs(self.activeList)do
xbId=v
if xianbaoModel:checkXBReddot(xbId)then
return true
end
end
return false
end


function xianbaoModel:getBaseFightEx(xbid)
local dfxb=xianbaoModel:CheckDianfengXianbao(xbid)
if dfxb then
local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local attr=cfglvl.attrs
local fight=0
for i,v in ipairs(attr)do
local config=cfgHelper.get1(cfg_attributesconfig_get,v[1])
fight=fight+config.unitVal*v[2]
end
return math.floor(fight)
else
local starlv=xianbaoModel:getXbStart(xbid)
local cfg=xianbaoConfig.getXBStarCfg(xbid,starlv)
local attr=cfg.attrs
local fight=0
for i,v in ipairs(attr)do
local config=cfgHelper.get1(cfg_attributesconfig_get,v[1])
fight=fight+config.unitVal*v[2]
end
return math.floor(fight)
end
end

function xianbaoModel:getAddAttrList()
if not xianbaoController:checkOpenXianBao()then
return nil
end
local allxbCfg=xianbaoConfig.getAllXBCfg()
local xbId
local activeFlag
local dfactiveFlag
local star
local starCfg
local lookupList={}
for k,v in pairs(allxbCfg)do
xbId=k
local dfxb=xianbaoModel:CheckDianfengXianbao(xbId)
if dfxb then

dfactiveFlag=self:checkActive(xbId)
if dfactiveFlag then
lookupList=DianFengLevelModel:getDianFengXianBaoAttrList(lookupList)
end
else

local GBaddval=gubaoModel:getXianBaoAttr(xbId)
activeFlag=self:checkActive(xbId)
if activeFlag then
star=self:getXbStart(xbId)
starCfg=xianbaoConfig.getXBStarCfg(xbId,star)
if starCfg.attrs and next(starCfg.attrs)then
for i,v in ipairs(starCfg.attrs)do
local attrId=v[1]
local attrCfgVal=v[2]
lookupList[attrId]=(lookupList[attrId]or 0)+attrCfgVal
if not attrListHelper.isMod(attrId)then
lookupList[attrId]=math.floor(lookupList[attrId]*(1+GBaddval/100))
end
end
end
end
end
end
return lookupList
end


function xianbaoModel:JudeGuanLianXianBao(xbId)
if xianbaoModel:checkActive(xbId)or xianbaoModel:checkCanActive(xbId)then
return true
end
return false
end


function xianbaoModel:checkActiveItemID(xbId)
if not xbId then
return
end
local xbCfg=xianbaoConfig.getXBCfg(xbId)

local active=xbCfg.active
if not active then
return
end
local itemId
for k,v in pairs(active)do
itemId=k
return itemId
end
end





function xianbaoModel:CheckActiveItem()
local activeList=xianbaoModel:getActiveList()
local itemlist={}
for i,v in ipairs(activeList)do
local xbId=v
local dfxb=xianbaoModel:CheckDianfengXianbao(xbId)
if not dfxb then
local itemid=xianbaoModel:checkActiveItemID(xbId)
local itemcfg=itemsConfig.getConfig(itemid)
local dealPrice=itemcfg.dealPrice

local hasCount=itemsModel.getCount(itemid)
if hasCount>0 then





local item,itemguid=bagControl.invokeFuncByItemId(itemid,'getItemByItemID',itemid)
bagProtocolControl.req_sell_item(itemguid,hasCount)

itemlist[#itemlist+1]={itemid,hasCount,dealPrice[1],hasCount*dealPrice[2],xbId=xbId}
end

local glid=liandonModel:CheckXB_Guanlian(xbId)
local itemid_gl=xianbaoModel:checkActiveItemID(glid)
local hasCount_gl=itemsModel.getCount(itemid_gl)
if hasCount_gl>0 then




local item,itemguid=bagControl.invokeFuncByItemId(itemid_gl,'getItemByItemID',itemid_gl)
bagProtocolControl.req_sell_item(itemguid,hasCount_gl)

itemlist[#itemlist+1]={itemid_gl,hasCount_gl,dealPrice[1],hasCount_gl*dealPrice[2],xbId=glid}
end
end
end
return itemlist
end


function xianbaoModel:CheckCanShowMax(xbId,formType)

if not xianbaoModel:checkCanUpStar(xbId)then
return
end
local isAdd=false
if formType==TIPS_FORM_TYPE.eXianBaoTujian or formType==TIPS_FORM_TYPE.eXianBaoUpStar then
if not xianbaoModel:checkActive(xbId)then
isAdd=true
end
elseif formType==TIPS_FORM_TYPE.eXianBaoMaterial or formType==TIPS_FORM_TYPE.eXianBaoBag then
isAdd=true
end
return isAdd
end


function xianbaoModel:CheckDianfengXianbao(xbId)
local cfg=xianbaoConfig.getXBCfg(xbId)
if cfg and cfg.dianfengType then
return true
end
return false
end
