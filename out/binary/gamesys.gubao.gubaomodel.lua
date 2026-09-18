







gubaoModel={}

gubaoModel.maxStar=5
local gubaoArray=nil
local rewardList=nil
local colorCollectLookup=nil
local gubaoCnt=0
local allCollectPoint=0
local allCollectStar=0
local allCollectLhlv=0

local YetActiveList={}
local YetActiveIndexById={}

local _colorNum=nil
local _bszlLevel=0
local _bszlExp=0
local _bszlOpen=0

function gubaoModel:clearData()
gubaoArray=nil
rewardList=nil
colorCollectLookup=nil
_colorNum=nil
gubaoCnt=0
allCollectPoint=0
allCollectStar=0
allCollectLhlv=0
_bszlLevel=0
_bszlExp=0
_bszlOpen=0
gubaoModel:clearAllAttr()


self.gubaoId=nil
end

function gubaoModel:initData(gubaolistlen,gubaoList_,rewardList_,collectList)
rewardList=rewardList_
gubaoArray={}
for i,v in ipairs(gubaoList_)do
gubaoArray[v.gubaoid]=v
gubaoModel:addCollect(v.gubaoid)
allCollectLhlv=allCollectLhlv+(v.gubaolhlv or 0)
allCollectStar=allCollectStar+(v.gubaostar or 0)
end
gubaoCnt=gubaolistlen
colorCollectLookup={}
if collectList then
for i,v in ipairs(collectList)do
colorCollectLookup[v.param_1]=v.param_2
end
end

self.gubaoId=nil
end

function gubaoModel:addCollect(gbid)
local collect=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'collect')
local collor=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'color')
allCollectPoint=allCollectPoint+collect[collor]
gubaoModel:setGuBaoColorDirty(collor)
end

function gubaoModel:upCollectStar(oldStar,newStar)
oldStar=oldStar or 0
allCollectStar=allCollectStar+newStar-oldStar
end

function gubaoModel:upCollectLianHua(oldlv,newlv)
oldlv=oldlv or 0
allCollectLhlv=allCollectLhlv+newlv-oldlv
end

function gubaoModel:getAllCollectPoint()
return allCollectPoint
end

function gubaoModel:getAllCollectLhLv()
return allCollectLhlv
end

function gubaoModel:getAllCollectStar()
return allCollectStar
end

function gubaoModel:setYetGubaoIndex(index)
self.gubaoId=YetActiveList[index]
end

function gubaoModel:getYetGubaoIndex()
if not self.gubaoId then
return 0
end
return YetActiveIndexById[self.gubaoId]or 0
end

function gubaoModel:setYetActiveList(page,curid)
YetActiveList={}
YetActiveIndexById={}
local cfg=cfg_gubaoconfig()
self.sortOrder=eSortOrder.eDown
self.sortType=userActorSetting.get("gubaoSelectSortType",1)
self.gubaoList=gubaoLookup:getSortList(cfg,self.sortType,nil,self.sortOrder,true)

for k,v in pairs(self.gubaoList)do
for childidx,gbCfg in pairs(self.gubaoList[k].childlist)do
local gbid=gbCfg.id
if gubaoModel:checkActive(gbid)then


local fullupstar=gubaoModel:checkFullUpStar(gbid)
if curid and curid==gbid then
table.insert(YetActiveList,gbid)
YetActiveIndexById[gbid]=#YetActiveList
elseif page==1 then
if not fullupstar then
table.insert(YetActiveList,gbid)
YetActiveIndexById[gbid]=#YetActiveList
end
elseif page==2 then
if fullupstar and gubaoModel:checkOpenAwake(gbid)then
local isAwake=gubaoModel:checkAwake(gbid)
if not isAwake then
table.insert(YetActiveList,gbid)
YetActiveIndexById[gbid]=#YetActiveList
end
end
else
if not gubaoModel:isSpecial(gbid)then
table.insert(YetActiveList,gbid)
YetActiveIndexById[gbid]=#YetActiveList
end
end
end
end
end

end

function gubaoModel:getYetActiveList(page,gbid)
self:setYetActiveList(page,gbid)
return YetActiveList
end

function gubaoModel:getGuGaoArray()
return gubaoArray
end

function gubaoModel:getRewardList()
return rewardList
end

function gubaoModel:getActiveNum()
return gubaoCnt
end

function gubaoModel:getDataByID(gbid)
if gubaoArray then
return gubaoArray[gbid]
end
return nil
end

function gubaoModel:getStar(gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData~=nil then
return gbData.gubaostar
end
return 0
end


function gubaoModel:checkActive(gbid)
local gbData=gubaoModel:getDataByID(gbid)
return gbData~=nil
end

function gubaoModel:checkActive_OrGLgubao(gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
return true
end

local glid=liandonModel:CheckGB_Guanlian(gbid)
if glid then
local gbData=gubaoModel:getDataByID(glid)
return gbData~=nil
end
return gbData~=nil
end

function gubaoModel:checkAwake(gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
return gubaoModel:checkAwakeEx(gbData.gubaojxlv)
end
return false
end
function gubaoModel:checkAwakeEx(awakelv)
return awakelv>0
end
function gubaoModel:checkOpenAwake(gbid)
local awakecfg=cfg_gubaoconfig_get(gbid).awake
if awakecfg then
local d=awakecfg[0]
if d and next(d[3])~=nil then
return true
end
end
return false
end

function gubaoModel:checkCanActive(gbid)
if gubaoModel:checkActive_OrGLgubao(gbid)then
return false
end
if not gubaoModel:checkActive(gbid)then
return gubaoLookup:checkEnoughActive(gbid)
end
return false
end

function gubaoModel:checkFullUpStar(gbid)
local glid=liandonModel:CheckGB_Guanlian(gbid)
if glid then
local gbData=gubaoModel:getDataByID(glid)
if gbData then
local flag=gubaoModel:checkFullUpStarEx(glid,gbData.gubaostar)
if flag then
return true
end
end
end
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
return gubaoModel:checkFullUpStarEx(gbid,gbData.gubaostar)
end
return false
end
function gubaoModel:checkFullUpStarEx(gbid,starlv)
if gubaoModel:isSpecial(gbid)then
return true
end
return starlv>=gubaoModel.maxStar
end


function gubaoModel:checkCanUpStar(gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
local isSpe=gubaoModel:isSpecial(gbid)
if not isSpe and not gubaoModel:checkFullUpStarEx(gbid,gbData.gubaostar)then
local goodlist=gubaoModel:initUpStarGoodList(gbid,1)
local guBaoPieceItemId=gubaoLookup:gubao2GoodPiece(gbid)
for i,v in ipairs(goodlist)do
local goodData=v
local costType=goodData.costType
if costType==1 then
local itemid=goodData.itemid
local needcnt=goodData.needcnt

local hascnt=bagModel.getItemCountById(itemid)
if guBaoPieceItemId==itemid then
local glhasnum=gubaoModel:FindGLpieceNum(gbid)
hascnt=glhasnum+hascnt
end
if hascnt<needcnt then
if guBaoPieceItemId==itemid then
local deltaNum=needcnt-hascnt
local color=itemsConfig.getItemColor(itemid)
local isEnough=false
local changePieceItemList=gubaoLookup:getChangePieceItemListByColor(color)or{}
for _,changePieceItemId in ipairs(changePieceItemList)do
local num=bagModel.getItemCountById(changePieceItemId)
deltaNum=deltaNum-num
if deltaNum<=0 then
isEnough=true
break
end
end

if not isEnough then
return false
end
else
return false
end
end
else
local needcnt=goodData.needcnt
local hascnt=0
local colorlist
if goodData.itemColor>0 then
colorlist=gubaoLookup:getGoodsSortList3(goodData.itemColor)
else
colorlist=gubaoLookup:getGoodsSortList4(math.abs(goodData.itemColor))
end
for i2,v2 in ipairs(colorlist)do
hascnt=hascnt+v2.item.itemcount
end
if hascnt<needcnt then
return false
end
end
end
return true
end
end
return false
end

function gubaoModel:checkCanAwake(gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
local isSpe=gubaoModel:isSpecial(gbid)
if not isSpe and not gubaoModel:checkAwakeEx(gbData.gubaojxlv)and gubaoModel:checkFullUpStarEx(gbid,gbData.gubaostar)and gubaoModel:checkOpenAwake(gbid)then
local goodlist=gubaoModel:initUpStarGoodList(gbid,2)
for i,v in ipairs(goodlist)do
local goodData=v
local costType=goodData.costType
if costType==1 then
local itemid=goodData.itemid
local needcnt=goodData.needcnt

local hascnt=bagModel.getItemCountById(itemid)
if hascnt<needcnt then
return false
end
else
local needcnt=goodData.needcnt
local hascnt=0
local colorlist
if goodData.itemColor>0 then
colorlist=gubaoLookup:getGoodsSortList3(goodData.itemColor)
else
colorlist=gubaoLookup:getGoodsSortList4(math.abs(goodData.itemColor))
end
for i2,v2 in ipairs(colorlist)do
hascnt=hascnt+v2.item.itemcount
end
if hascnt<needcnt then
return false
end
end
end
return true
end
end
return false
end

function gubaoModel:checkAllActiveReddot()
local configs=cfg_gubaoconfig()
for k,v in pairs(configs)do
local gbid=v.id
if gubaoModel:checkCanActive(gbid)then
return true
end
end
return false
end

function gubaoModel:setGuBaoColorDirty(color)
if _colorNum==nil or _colorNum[color]==nil then return end
_colorNum[color].dirty=true
end

function gubaoModel:getGuBaoColorNum(color,force)
if _colorNum==nil or _colorNum[color]==nil or _colorNum[color].dirty==true then
local num=0
local lookup=gubaoModel:getGuGaoArray()
if lookup then
for _,gbData in pairs(lookup)do
local gbid=gbData.gubaoid
local cl=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'color')
local notcalc=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'notcalc')
if cl==color and(not notcalc)then
num=num+1
end
end
end
local colorInfo={}
colorInfo.dirty=false
colorInfo.num=num

_colorNum=_colorNum or{}
_colorNum[color]=colorInfo
end
return _colorNum[color].num or 0
end

function gubaoModel:checkAllUpstarAndAwakeReddot()
local colorlookup={}
local lookup=gubaoModel:getGuGaoArray()
local check=false
if lookup then
for _,gbData in pairs(lookup)do
local gbid=gbData.gubaoid
local isSpe=gubaoModel:isSpecial(gbid)
if not isSpe then

local goodlist=gubaoModel:initUpStarGoodList(gbid,1)
local check_upstar=not gubaoModel:checkFullUpStarEx(gbid,gbData.gubaostar)
if check_upstar then
for i,v in ipairs(goodlist)do
local goodData=v
local costType=goodData.costType
if costType==1 then
local itemid=goodData.itemid
local needcnt=goodData.needcnt

local hascnt=bagModel.getItemCountById(itemid)
if hascnt<needcnt then
check_upstar=false
break
end
else
local needcnt=goodData.needcnt
local hascnt=0
local color=goodData.itemColor
local colorcnt=colorlookup[color]
if colorcnt==nil then
local colorlist
if color>0 then
colorlist=gubaoLookup:getGoodsSortList3(color)
else
colorlist=gubaoLookup:getGoodsSortList4(math.abs(color))
end
colorcnt=0
for i2,v2 in ipairs(colorlist)do
colorcnt=colorcnt+v2.item.itemcount
end
colorlookup[color]=colorcnt
end
hascnt=colorcnt
if hascnt<needcnt then
check_upstar=false
break
end
end
end
end
if check_upstar then
return true
end

local goodlist2=gubaoModel:initUpStarGoodList(gbid,2)
local check_awake=not gubaoModel:checkAwakeEx(gbData.gubaojxlv)and gubaoModel:checkFullUpStarEx(gbid,gbData.gubaostar)and gubaoModel:checkOpenAwake(gbid)
if check_awake then
for i,v in ipairs(goodlist2)do
local goodData=v
local costType=goodData.costType
if costType==1 then
local itemid=goodData.itemid
local needcnt=goodData.needcnt

local hascnt=bagModel.getItemCountById(itemid)
if hascnt<needcnt then
check_awake=false
break
end
else
local needcnt=goodData.needcnt
local hascnt=0
local color=goodData.itemColor
local colorcnt=colorlookup[color]
if colorcnt==nil then
local colorlist
if color>0 then
colorlist=gubaoLookup:getGoodsSortList3(color)
else
colorlist=gubaoLookup:getGoodsSortList4(math.abs(color))
end
colorcnt=0
for i2,v2 in ipairs(colorlist)do
colorcnt=colorcnt+v2.item.itemcount
end
colorlookup[color]=colorcnt
end
hascnt=colorcnt
if hascnt<needcnt then
check_awake=false
break
end
end
end
end
if check_awake then
return true
end
end
end
end
return false
end

function gubaoModel:checkCollectPageReddot()
if not gubaoController:checkInit()then return false end
return gubaoModel:checkAllActiveReddot()or gubaoModel:checkAllLianHuaReddot()
or gubaoModel:checkAllUpstarAndAwakeReddot()
end

function gubaoModel:checkCollectPageReddot2(asynch,asynchData)
if not gubaoController:checkInit()then return false end

if asynch then
if not asynchData.checkLianHua then
asynchData.checkLianHua=true
if gubaoModel:checkAllLianHuaReddot()then
return true
else
return-1,asynchData
end
end

if not asynchData.checkUpAwake then
asynchData.checkUpAwake=true
if gubaoModel:checkAllUpstarAndAwakeReddot()then
return true
else
return-1,asynchData
end
end

if not asynchData.checkCollect then
asynchData.checkCollect=true
if gubaoModel:checkAllCollectReddot()then
return true
else
return-1,asynchData
end
end

if not asynchData.checkCollorCollect then
asynchData.checkCollorCollect=true
if gubaoModel:checkAllColorCollectReddot()then
return true
else
return-1,asynchData
end
end

local num=40
local configs=cfg_gubaoconfig()
for k,v in pairs(configs)do
local gbid=v.id
if not asynchData[gbid]then
asynchData[gbid]=true
num=num-1
if gubaoModel:checkCanActive(gbid)then
return true
end
if num<=0 then
return-1,asynchData
end
end
end
return false
else
return gubaoModel:checkAllLianHuaReddot()or
gubaoModel:checkAllUpstarAndAwakeReddot()or
gubaoModel:checkAllCollectReddot()or
gubaoModel:checkAllColorCollectReddot()or
gubaoModel:checkAllActiveReddot()
end
end

function gubaoModel:checkSystemReddot(asynch,asynchData)
if not gubaoController:checkInit()then return false end
if gubaoModel:checkAllCollectReddot()then return true end
if gubaoModel:checkAllColorCollectReddot()then return true end

if asynch then
local num=40
local configs=cfg_gubaoconfig()
for k,v in pairs(configs)do
local gbid=v.id
if not asynchData[gbid]then
asynchData[gbid]=true
num=num-1
if gubaoModel:checkCanActive(gbid)then
return true
end
if num<=0 then
return-1,asynchData
end
end
end
return false
else
return gubaoModel:checkAllActiveReddot()
end
end

function gubaoModel:checkBagPageReddot()
if not gubaoController:checkInit()then return false end
local baglist=bagControl.invokeFuncByBagType(BAG_TYPE.eGubaoBag,'getBagItems')
if baglist~=nil and#baglist>0 then
for i,v in ipairs(baglist)do
local itemid=v.itemid
local gbid=gubaoLookup:good2GuBao(itemid)
if gbid then
local active=gubaoModel:checkActive(gbid)
if not active and gubaoLookup:good2GuBaoPiece(itemid)~=nil and gubaoLookup:checkEnoughPieceGoodWithChangePiece(gbid)then
return true
end
end
end
end
return false
end


function gubaoModel:checkSuitActiveEx(suitid)
local flag=true
local num=0
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,suitid)
for i,v in ipairs(suitcfg.list)do
if not gubaoModel:checkActive_OrGLgubao(v)then
flag=false
else
num=num+1
end
end
return flag,num
end


function gubaoModel:checkSuitActive1(suitid)
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,suitid)
for i,v in ipairs(suitcfg.list)do
if not gubaoModel:checkActive_OrGLgubao(v)then

return false
end
end
return true
end



function gubaoModel:checkSuitActive2(suitid)
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,suitid)
for i,v in ipairs(suitcfg.list)do
if not gubaoModel:checkActive_OrGLgubao(v)then
return false
else
local glid=liandonModel:CheckGB_Guanlian(v)


if glid then
if gubaoModel:getStar(v)<3 and gubaoModel:getStar(glid)<3 then
return false
end
elseif gubaoModel:getStar(v)<3 then
return false
end
end

end
return true
end

function gubaoModel:checkSuitActive3(suitid)
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,suitid)
for i,v in ipairs(suitcfg.list)do
if not gubaoModel:checkActive_OrGLgubao(v)then
return false
else
local glid=liandonModel:CheckGB_Guanlian(v)
if glid then
if not gubaoModel:checkAwake(v)and not gubaoModel:checkAwake(glid)then
return false
end
elseif not gubaoModel:checkAwake(v)then
return false
end

end
end
return true
end

function gubaoModel:rec_active(gbid)
local gbData=nil
if gubaoArray[gbid]==nil then
local cfg=cfgHelper.get1(cfg_gubaoconfig_get,gbid)
local haveLevelCfg=cfg.level and#cfg.level>0 or false
gbData={}
gbData.gubaoid=gbid
gbData.gubaolhlv=0
gbData.gubaolhexp=0
gbData.gubaostar=0
gbData.gubaojxlv=0
gbData.gubaoskilllv=haveLevelCfg and 1 or 0
gubaoArray[gbid]=gbData
gubaoCnt=gubaoCnt+1
gubaoModel:addCollect(gbid)
end
return gbData
end

function gubaoModel:rec_lianhua(gbid,gblv,gbexp)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
local oldlv=gbData.gubaolhlv
gbData.gubaolhlv=gblv
gbData.gubaolhexp=gbexp
gubaoModel:upCollectLianHua(oldlv,gblv)
end
return gbData
end

function gubaoModel:rec_upstar(gbid,starlv)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
local oldStar=gbData.gubaostar
gbData.gubaostar=starlv
gubaoModel:upCollectStar(oldStar,starlv)
end
return gbData
end

function gubaoModel:rec_awake(gbid,awakelv)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
gbData.gubaojxlv=awakelv
end
return gbData
end

function gubaoModel:rec_skilllv(gbid,skilllv)
local gbData=gubaoModel:getDataByID(gbid)
local old=nil
if gbData then
old=gbData.gubaoskilllv
gbData.gubaoskilllv=skilllv
end
return gbData,old
end

function gubaoModel:getGuBaoIconName(icon)
return string.format('icon_gubao_%03d',icon)
end

function gubaoModel:getGuBaoBigIconName(icon)
return string.format('icon_gubaoB_%03d',icon)
end

function gubaoModel:getBaseFight(gbid)
local attr=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'attr')
local fight=0
for i,v in ipairs(attr)do
local config=cfgHelper.get1(cfg_attributesconfig_get,v[1])
fight=fight+config.unitVal*v[2]
end
return math.floor(fight)
end

function gubaoModel:getBaseFightEx(gbid)
local attr=gubaoModel:getBaseAttrList(gbid,true)
local fight=0
for i,v in ipairs(attr)do
local config=cfgHelper.get1(cfg_attributesconfig_get,v[1])
fight=fight+config.unitVal*v[2]
end
return math.floor(fight)
end

function gubaoModel:getSkillLv(gbid)
local lv=0
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
lv=gubaoModel:getSkillLvEx(gbid,gbData.gubaostar,gbData.gubaojxlv,gbData.gubaoskilllv)
end
return lv
end

function gubaoModel:getSkillLvEx(gbid,starlv,awakelv,exlv)
local lv=exlv or 0
lv=lv+cfgHelper.get4(cfg_gubaoconfig_get,gbid,'star',starlv,2)
local awakecfg=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'awake')
if awakecfg then
local d=awakecfg[awakelv]
if d then
lv=lv+d[2]
end
end
return lv
end

function gubaoModel:getSkillDesc(gbid,skilllv,n_skilllv)
local gbcfg=cfgHelper.get(cfg_gubaoconfig_get,gbid)
local skilllist=gbcfg.skill
local skilldescFmt=gbcfg.skilldesc
local skilldata=skilllist[skilllv]
if skilldata==nil then
skilllv=1
skilldata=skilllist[skilllv]
end
local n_skilldata=nil
local n_fmtlist=nil
if n_skilllv~=nil and n_skilllv>skilllv then
n_skilldata=skilllist[n_skilllv]
n_fmtlist=gbcfg.upskilldesc
end

local str,str2,str3=gubaoModel:getEffectDesc(skilldata,skilldescFmt,n_skilldata,n_fmtlist)
return str,str2,str3
end

function gubaoModel:getSuitListDesc(suitlist,activeColor)
local str=''
local idx=1
for i,v in ipairs(suitlist)do
if idx>1 then str=str..'\n'end
str=str..gubaoModel:getSuitDesc(v,activeColor)
idx=idx+1
end
return str,idx
end

function gubaoModel:getSuitDesc(suitid,activeColor)
local ischeck=activeColor~=nil
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,suitid)
local str=''

local idx=1
for i,v in ipairs(suitcfg.list)do
local name=cfgHelper.get2(cfg_gubaoconfig_get,v,'name')
if ischeck then
if gubaoModel:checkActive(v)then name=FMT.fmt(activeColor,name)end
end
if idx>1 then
if idx==4 then
str=str..'\n'
else
str=str..'　'
end
end
str=str..name
idx=idx+1
end
str=str..'\n'

local s1='[套装]'
s1=s1..gubaoModel:getEffectDesc(suitcfg.skill0,suitcfg.skilldesc0)
if ischeck then
if gubaoModel:checkSuitActive1(suitid)then s1=FMT.fmt(activeColor,s1)end
end
str=str..s1

str=str..'\n'
local s2='[3星套装]'
s2=s2..gubaoModel:getEffectDesc(suitcfg.skill3,suitcfg.skilldesc3)
if ischeck then
if gubaoModel:checkSuitActive2(suitid)then s2=FMT.fmt(activeColor,s2)end
end
str=str..s2

if suitcfg.skill_1~=nil then
str=str..'\n'
local s3='[觉醒套装]'
s3=s3..gubaoModel:getEffectDesc(suitcfg.skill_1,suitcfg.skilldesc_1)
if ischeck then
if gubaoModel:checkSuitActive2(suitid)then s3=FMT.fmt(activeColor,s3)end
end
str=str..s3
end

return str
end

function gubaoModel:getEffectDesc(skilldata,fmtlist,n_skilldata,n_fmtlist)
local str=''
local str2=nil
local str3=nil
local idx=0
local paramData=nil

idx=idx+1
paramData=skilldata[idx]
if paramData~=nil and#paramData>0 then
local params={}
for i,attr in ipairs(paramData)do
params[i]=helper.getAttributeNum(attr[1],attr[2],6)
end
if n_skilldata then
local n_params={}
local n_paramData=n_skilldata[idx]
for i,attr in ipairs(n_paramData)do
local add=attr[2]-paramData[i][2]
n_params[i]=helper.getAttributeNum(attr[1],add,6)
end

for i,value in ipairs(n_params)do
local n_str
if value~=0 then
n_str=FMT.fmt('(+{0})',value)
else
n_str=''
end
table.insert(params,i*2,n_str)
end
local fmt_str=n_fmtlist[idx]
if fmt_str then
str=str..FMT.fmt(fmt_str,unpack(params))
end
else
local fmt_str=fmtlist[idx]
if fmt_str then
str=str..FMT.fmt(fmt_str,unpack(params))
end
end
end
idx=idx+1
paramData=skilldata[idx]
if paramData~=nil and#paramData>0 then


end
idx=idx+1
paramData=skilldata[idx]
if paramData~=nil and#paramData>0 then
local counterEffect=nil
local n_counterEffect=nil
local params={}
for i,effect in ipairs(paramData)do
local skillType=effect[1]
params[i]=gubaoModel:getSkillEffectAttrValue(effect)
params[i]=math.abs(params[i])
if gubaoModel:checkIsCounterSkillEffect(skillType)then
counterEffect=effect
end
end
if n_skilldata then
local n_params={}
local n_paramData=n_skilldata[idx]
for i,effect in ipairs(n_paramData)do
local skillType=effect[1]
n_params[i]=gubaoModel:getSkillEffectAttrValue(effect)
n_params[i]=math.abs(n_params[i])
n_params[i]=n_params[i]-params[i]
if gubaoModel:checkIsCounterSkillEffect(skillType)then
n_counterEffect=effect
end
end

for i,value in ipairs(n_params)do
local n_str
if value~=0 then
n_str=FMT.fmt('(+{0})',value)
else
n_str=''
end
table.insert(params,i*2,n_str)
end
local fmt_str=n_fmtlist[idx]
if fmt_str then
str=str..FMT.fmt(fmt_str,unpack(params))
end
else
local fmt_str=fmtlist[idx]
if fmt_str then
str=str..FMT.fmt(fmt_str,unpack(params))
end
end
if counterEffect~=nil then
local attrType,attrValue=gubaoModel.getCounterEffectLimit(counterEffect)
local cur,max=gubaoModel:getGBCounterEffectProgress(counterEffect,true)
if max>0 then
str2=FMT.fmt('生效数量：{0}/{1}',cur,max)
else
str2=FMT.fmt('生效数量：{0}',cur)
end
if n_counterEffect then
local attrType2,attrValue2,numlimit2=gubaoModel.getCounterEffectLimit(n_counterEffect)
local lerplimit=numlimit2-max
if lerplimit>0 then
str2=FMT.fmt('{0}<color=#549327>(+{1})</color>',str2,lerplimit)
end
end
attrValue=attrValue*cur
str3=FMT.fmt('累计加成：{0}',helper.getAttributeStr(attrType,attrValue,nil,'{0}+{1}'))
end
end
return str,str2,str3
end

function gubaoModel:calculationLianHuaExp(goodlist)
local exp=0
for i,v in ipairs(goodlist)do
local itemid=v.item.itemid
local num=v.cnt
local cfg=itemsConfig.getConfig(itemid)
exp=exp+cfg.gubaolianhua*num
end
return exp
end


function gubaoModel:initUpStarGoodList(gbid,page)

if page==1 then

local starlv=gubaoModel:getStar(gbid)
if self.starlookupgoollookup==nil or
self.starlookupgoollookup[gbid]==nil or
self.starlookupgoollookup[gbid][starlv]==nil then
local goodlist={}
local commonPieces=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'commonPieces')
local upcfg=cfg_gubaoconfig_get(gbid).star[starlv]
for i,v in ipairs(upcfg[4])do
local good={}
good.itemid=v[1]
good.needcnt=v[2]
good.costType=1
good.index=#goodlist+1
table.insert(goodlist,good)
end

if upcfg[3]and next(upcfg[3])~=nil then
for i,v in pairsBySortKey(upcfg[3])do
local good={}
good.selectlist={}
good.itemColor=i
good.itemIcon=commonPieces[math.abs(i)]
good.needcnt=v
good.costType=2
good.index=#goodlist+1
table.insert(goodlist,good)
end
end
self.starlookupgoollookup=self.starlookupgoollookup or{}
self.starlookupgoollookup[gbid]=self.starlookupgoollookup[gbid]or{}
self.starlookupgoollookup[gbid][starlv]=goodlist
end

return self.starlookupgoollookup[gbid][starlv]
else
local gbData=gubaoModel:getDataByID(gbid)
local awakelv=gbData.gubaojxlv
if self.awakelookupgoollookup==nil or
self.awakelookupgoollookup[gbid]==nil or
self.awakelookupgoollookup[gbid][awakelv]==nil then

local goodlist={}
local awakecfg=cfg_gubaoconfig_get(gbid).awake
if awakecfg then
local commonPieces=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'commonPieces')
local d=awakecfg[awakelv]
if d and d[3]and next(d[3])~=nil then

if d[4]~=nil and#d[4]>0 then
for i,v in ipairs(d[4])do
local good={}
good.itemid=v[1]
good.needcnt=v[2]
good.costType=1
good.index=#goodlist+1
table.insert(goodlist,good)
end
end
for i,v in pairsBySortKey(d[3])do
local good={}
good.selectlist={}
good.itemColor=i
good.itemIcon=commonPieces[math.abs(i)]
good.needcnt=v
good.costType=2
good.index=#goodlist+1
table.insert(goodlist,good)
end
end
end
self.awakelookupgoollookup=self.awakelookupgoollookup or{}
self.awakelookupgoollookup[gbid]=self.awakelookupgoollookup[gbid]or{}
self.awakelookupgoollookup[gbid][awakelv]=goodlist
end
return self.awakelookupgoollookup[gbid][awakelv]
end
end

function gubaoModel:isSpecial(gbid)
local cfg=cfg_gubaoconfig_get(gbid)

return gubaoModel:isSpecialEx(cfg)
end

function gubaoModel:isSpecialEx(cfg)
local star=cfg.star

return star[0]~=nil and star[1]==nil
end



function gubaoModel:getColorCollect()
return colorCollectLookup
end

function gubaoModel:checkColorCollect(color,num)
local n=colorCollectLookup[color]
if n~=nil then
return n>=num
end
return false
end

function gubaoModel:activeColorCollect(color,num)
colorCollectLookup[color]=num
end

function gubaoModel:checkColorCollectReddot(color)
local cur=gubaoModel:getGuBaoColorNum(color)
local list=gubaoLookup:getColorCollectList(color)
if list then
for i,v in ipairs(list)do
if cur>=v.num then
if not gubaoModel:checkColorCollect(color,v.num)then
return true,i
end
end
end
end
return false
end

function gubaoModel:checkAllColorCollectReddot()
if self.gbColorNames==nil then
self.gbColorNames=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'colorNames')
end
for color,v in pairs(self.gbColorNames)do
if gubaoModel:checkColorCollectReddot(color)then
return true
end
end
return false
end

function gubaoModel:getPieceCountByColor(color)
local baglist=gubaoLookup:getGoodsSortList3(color)
local hasnum=0
for i1,data in ipairs(baglist)do
local itemData=data.item
hasnum=hasnum+itemData.itemcount
end
return hasnum
end



function gubaoModel:FindGLpieceNum(gbid)

local glitemid,glpieceid=liandonModel:CheckGB_Guanlian_Item(gbid)
local hascnt_gl=0
if glpieceid then

hascnt_gl=bagModel.getItemCountById(glpieceid)
end
return hascnt_gl
end


function gubaoModel:checkFeiShengByDizi(guid)
local fly_disciple_lv=cfg_globalconfig_get(1).fly_disciple_lv
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
if jjlv and fly_disciple_lv and jjlv>=fly_disciple_lv then
return true
end
return false
end

function gubaoModel:checkJiHuoFeiShenglvl(fly_disciple_lv)
local all=UIDiscipleModel:getAllDiscipleDataX()
if all and fly_disciple_lv then
for k,v in pairs(all)do
local data=v.netData.net
if data.jingjielv>=fly_disciple_lv then
return true
end
end
end
return false
end

function gubaoModel:isJiHuoFeiShengArr()
if systemModel.isOpen(SYSTEM_DEFINE.eDiscipleFlyAttr)then
local fly_disciple_lv=cfg_globalconfig_get(1).fly_disciple_lv
if gubaoModel:checkJiHuoFeiShenglvl(fly_disciple_lv)then
return true
end
end
return false
end

function gubaoModel:CheckFeiShengOfDizi(guid)
if systemModel.isOpen(SYSTEM_DEFINE.eDiscipleFlyAttr)then
local fly_disciple_lv=cfg_globalconfig_get(1).fly_disciple_lv
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
if jjlv and fly_disciple_lv and jjlv>=fly_disciple_lv then
return true
end
end
return false
end

function gubaoModel:setBSZLData(bszl_level,bszl_exp)
_bszlLevel=bszl_level
_bszlExp=bszl_exp
end

function gubaoModel:getBSZLData()
return _bszlLevel,_bszlExp
end

function gubaoModel:getBSZLNextLevelNeedExp(level)
level=level or _bszlLevel
local cfg=cfg_baoshuzhulinglevelconfig_get(level)
return cfg.exp or 0
end

function gubaoModel:getBSZLMaxLevelNeedExp()
local cfgs=cfg_baoshuzhulinglevelconfig()
local curLevel=_bszlLevel
local curExp=_bszlExp
local needExp=-curExp
for i=curLevel,#cfgs-1 do
local cfg=cfgs[i]
needExp=needExp+cfg.exp or 0
end
return needExp
end

function gubaoModel:getGuBaoPieceBSZLExp(itemid)
local cfg=itemsConfig.getConfig(itemid)
return cfg.bszl_exp or 0
end

function gubaoModel:checkBSZLReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eBaoShuZhuLing)then
return false
end
if not gubaoModel.checkBaoShuZhuLingPlatformOpen()then
return false
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eBSZLReddot)
if flag then
return false
end
if not gubaoModel.getBaoShuZhuLingOpen()then
return false
end


local curLevelCfg=cfgHelper.get1(cfg_baoshuzhulinglevelconfig_get,_bszlLevel)
local consume=curLevelCfg.consume or defaultT
for i,v in ipairs(consume)do
local itemid,neednum=unpack(v)
local hascnt=itemsModel.getCount(itemid)
if hascnt<neednum then
return false
end
end

local fullStarPieceList=gubaoLookup:getGoodsSortList4(eQualityColor.eRed)
local bagList={}
for i,v in ipairs(fullStarPieceList)do
local itemid=v.item.itemid
local gbid=gubaoLookup:good2GuBaoPiece(itemid)
local exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
if gbid and gubaoModel:checkAwake(gbid)and exp>0 then
table.insert(bagList,v)
end
end
if#bagList<0 then
return false
end
local addExp=0
local curExp=_bszlExp
local needExp=gubaoModel:getBSZLNextLevelNeedExp()-curExp
if needExp<=0 then
return false
end
local ok=false
for i,v in ipairs(bagList)do
local itemData=v.item
local itemid=itemData.itemid
local itemcount=itemData.itemcount
local unit_exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
local total_exp=itemcount*unit_exp
if total_exp<needExp then
needExp=needExp-total_exp
else
ok=true
break
end
end
return ok
end

function gubaoModel.initBaoShuZhuLingOpenData(len,arr)
if len>0 then
_bszlOpen=arr[1]
end
end

function gubaoModel.setBaoShuZhuLingOpen(open)
_bszlOpen=open and 1 or 0
end

function gubaoModel.getBaoShuZhuLingOpen()
return _bszlOpen==1
end

function gubaoModel.checkBaoShuZhuLingPlatformOpen()
local const_def=cfgHelper.getdef(cfg_baoshuzhulinglevelconfig)
if const_def and const_def.open_pf and next(const_def.open_pf)then
local pfid=gameUtilityModel.getServerPlatform()
return const_def.open_pf[pfid]~=nil
end
return true
end
