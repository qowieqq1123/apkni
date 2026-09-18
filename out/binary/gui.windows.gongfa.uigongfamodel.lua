







UIGongFaModel={}

local activeGongFaList=nil
local maxLvGongFaList=nil

function UIGongFaModel:initData(list)
activeGongFaList={}
maxLvGongFaList={}

if list then
for i,v in ipairs(list)do
v.piecelookup={}
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,v.gongfaid)or{}
local pieces=cfg.piece
if pieces then
for i1,v1 in ipairs(pieces)do
v.piecelookup[v1[1]]=mathHelper.getBitValue(v.flag,i1*2-1)
end
end
activeGongFaList[v.gongfaid]=v

local mxlv=0
if cfg.study~=nil then
mxlv=#cfg.study
end
if v.studylv>=mxlv then
maxLvGongFaList[v.gongfaid]=true
end
end
end
end

function UIGongFaModel:clearData()
activeGongFaList=nil
maxLvGongFaList=nil
end

function UIGongFaModel:getAcitveGFList()
return activeGongFaList or{}
end

function UIGongFaModel:getMaxLvGFList()
return maxLvGongFaList or{}
end

function UIGongFaModel:getGongFaNetData(gfID)
if activeGongFaList==nil then return nil end
return activeGongFaList[gfID]
end

function UIGongFaModel:isGongFaActive(gfID)
if UIGongFaModel:isGongFaDefaultActive(gfID)then

return true
end
return UIGongFaModel:getGongFaNetData(gfID)~=nil
end

function UIGongFaModel:isGongFaDefaultActive(gfID)






return cfg_disciplegongfaconfig_get(gfID).maxlv~=nil
end

function UIGongFaModel:activeGongFaPage(gfID,flag)
if activeGongFaList[gfID]==nil then
activeGongFaList[gfID]={gongfaid=gfID,flag=0,studylv=0,piecelookup={}}
end
local netData=activeGongFaList[gfID]
netData.flag=flag
netData.piecelookup={}
local pieces=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'piece')
if pieces then
for i,v in ipairs(pieces)do
netData.piecelookup[v[1]]=mathHelper.getBitValue(netData.flag,i*2-1)
end
end
end

function UIGongFaModel:isPageActive(gfID,itemid)
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
return gfNetData.piecelookup[itemid]==true
end
return false
end

function UIGongFaModel:isPageActiveEx(gfID,piece_idx)
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
return mathHelper.getBitValue(gfNetData.flag,piece_idx*2-1)
end
return false
end

function UIGongFaModel:isPageAllActive(gfID)

if UIGongFaModel:isGongFaDefaultActive(gfID)then
return true
end
local piece=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'piece')
for i,v in ipairs(piece)do
if not UIGongFaModel:isPageActive(gfID,v[1])then
return false
end
end
return true
end

function UIGongFaModel:getNotActivePages(gfID)
if UIGongFaModel:isGongFaDefaultActive(gfID)then

return nil
end
local piece=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'piece')
local temp={}
for i,v in ipairs(piece)do
if not UIGongFaModel:isPageActive(gfID,v[1])then
table.insert(temp,{v[1],i})
end
end
if#temp>0 then
return temp
end
return nil
end

function UIGongFaModel:getCanActivePage(gfID)
local temp=UIGongFaModel:getNotActivePages(gfID)
local glid=liandonModel:CheckGongFa_Guanlian(gfID)
if temp~=nil then
local temp1={}
for i,v in ipairs(temp)do
local itemid=v[1]

local c=itemsModel.getCount(itemid)
if c>0 then
table.insert(temp1,v)
else

if UIGongFaModel:isGongFaActive(gfID)then
if glid then
local glitemid=liandonModel:CheckGongFa_Guanlian_item(itemid)
if glitemid then
local glnum=bagControl.invokeFuncByItemId(glitemid,'getItemCountByItemID',glitemid)
if glnum>0 then
temp[i][3]=glitemid
table.insert(temp1,v)
end
end
end
end
end
end
if#temp1>0 then
return temp1
end
return nil
end
return nil
end

function UIGongFaModel:hasCanActivePage(gfID)



if UIGongFaModel:isGongFaDefaultActive(gfID)then

return false
end
local isActive=UIGongFaModel:isGongFaActive(gfID)
local glid=liandonModel:CheckGongFa_Guanlian(gfID)


local piece=cfg_disciplegongfaconfig_get(gfID).piece
for i,v in ipairs(piece)do
local itemid=v[1]
if not UIGongFaModel:isPageActive(gfID,v[1])then
local c=bagModel.getItemCountById(itemid)
if c>0 then
return true
else

if isActive and glid then
local glitemid=liandonModel:CheckGongFa_Guanlian_item(itemid)
if glitemid then
local glnum=bagModel.getItemCountById(glitemid)
if glnum>0 then
return true
end
end
end
end
end
end
return false
end

function UIGongFaModel:hasActiveAllPageReward(gfID)
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
return(not mathHelper.getBitValue(gfNetData.flag,0))and UIGongFaModel:isPageAllActive(gfID)
end
return false
end

function UIGongFaModel:hasActiveAllPageRewardEx(gfID)
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
return not mathHelper.getBitValue(gfNetData.flag,0)
end
return false
end

function UIGongFaModel:hasActivePageReward(gfID,piece_idx)
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
return(not mathHelper.getBitValue(gfNetData.flag,piece_idx*2))and mathHelper.getBitValue(gfNetData.flag,piece_idx*2-1)
end
return false
end

function UIGongFaModel:hasActivePageRewardEx(gfID,piece_idx)
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
return not mathHelper.getBitValue(gfNetData.flag,piece_idx*2)
end
return false
end

function UIGongFaModel:hasActiveAnyPageReward(gfID)
if not UIGongFaModel:isGongFaDefaultActive(gfID)then
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
if(not mathHelper.getBitValue(gfNetData.flag,0))and UIGongFaModel:isPageAllActive(gfID)then
return true
end
local pieces=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'piece')
for i,v in ipairs(pieces)do
if(not mathHelper.getBitValue(gfNetData.flag,i*2))and mathHelper.getBitValue(gfNetData.flag,i*2-1)then
return true
end
end
end
end
return false
end

function UIGongFaModel:chackAllGongFaHasReward()
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
if UIGongFaModel:hasActiveAnyPageReward(v.id)then
return true
end
end
return false
end

function UIGongFaModel:checkAllGongFaReddot()
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:hasCanActivePage(gfID)or UIGongFaModel:hasActiveAnyPageReward(gfID)or UIGongFaModel:checkStudyReddot(gfID,false,false)then
return true
end
end
return false
end

function UIGongFaModel:chackAllGongFaState(bdData)
local allGFList=gongfaLookup:getAllGongFaList()
local canActive=false
local canReward=false
local canStudy=false
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:hasCanActivePage(gfID)then
canActive=true
break
end
if UIGongFaModel:hasActiveAnyPageReward(gfID)then
canReward=true
end
if UIGongFaModel:checkStudyReddot(gfID)then
canStudy=true
end
end
local state=0
if canActive then
state=1
elseif canReward then
state=2
elseif canStudy then
state=3
end
return state
end


function UIGongFaModel:getActiveDataCountByColor(needColor)
local list=self:getAcitveGFList()
local count=0
for gfID,gfData in pairs(list)do
local color=UIGongFaModel:getGFColor(gfID)
if needColor<=color then
count=count+1
end
end
return count
end

function UIGongFaModel:getAllActiveCountByColor(needColor,notGreater)
if not UIGongFaController:checkInit()then return 0 end
local count=0
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:isGongFaActive(gfID)then
local color=UIGongFaModel:getGFColor(gfID)
if notGreater==true then
if needColor==color then
count=count+1
end
else
if needColor<=color then
count=count+1
end
end
end
end
return count
end

function UIGongFaModel:getAllCompletePageCountByColor(needColor,notGreater)
if not UIGongFaController:checkInit()then return 0 end
local count=0
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:isPageAllActive(gfID)then
local color=UIGongFaModel:getGFColor(gfID)
if notGreater==true then
if needColor==color then
count=count+1
end
else
if needColor<=color then
count=count+1
end
end
end
end
return count
end

function UIGongFaModel:getAllActiveCountByElements(needElement)
if not UIGongFaController:checkInit()then return 0 end
local count=0
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:isGongFaActive(gfID)then
local elements=UIGongFaModel:getGFElements(gfID)
if table.containsValue(elements,needElement)then
count=count+1
end
end
end
return count
end

function UIGongFaModel:getAllCompletePageCountByElements(needElement)
if not UIGongFaController:checkInit()then return 0 end
local count=0
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:isPageAllActive(gfID)then
local elements=UIGongFaModel:getGFElements(gfID)
if table.containsValue(elements,needElement)then
count=count+1
end
end
end
return count
end

function UIGongFaModel:checkAllActiveReddot()
if not UIGongFaController:checkInit()then return false end
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:hasCanActivePage(gfID)then return true end
end
return false
end

function UIGongFaModel:checkAllRewardReddot()
if not UIGongFaController:checkInit()then return false end
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:hasActiveAnyPageReward(gfID)then return true end
end
return false
end

function UIGongFaModel:checkAllStudyReddot()
if not UIGongFaController:checkInit()then return false end
local allGFList=gongfaLookup:getAllGongFaList()
for i,v in ipairs(allGFList)do
local gfID=v.id
if UIGongFaModel:checkStudyReddot(gfID)then return true end
end
return false
end

function UIGongFaModel:getGongFaRecycleList()
local recycleList={}
local maxLvGFList=UIGongFaModel:getMaxLvGFList()
for gfID,_ in pairs(maxLvGFList)do
local num=0
local pieces=UIGongFaModel:getGongFaStudyPieces(gfID)or{}
for i,v in ipairs(pieces)do
local itemCount=itemsModel.getCount(v)
num=num+itemCount
end
if num>0 then
table.insert(recycleList,{gfID=gfID,gfNum=num,piece=pieces[1]})
end
end
return recycleList
end

function UIGongFaModel:checkGongFaRecycleReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eGongFaRecycle)then return false end
if not UIGongFaController:checkInit()then return false end
local maxLvGFList=UIGongFaModel:getMaxLvGFList()
for gfID,_ in pairs(maxLvGFList)do
local pieces=UIGongFaModel:getGongFaStudyPieces(gfID)or{}
for i,v in ipairs(pieces)do
local itemCount=itemsModel.getCount(v)
if itemCount>0 then
return true
end
end
end
return false
end

function UIGongFaModel:getGongFaStudyPieces(gfID)
local studyCfg=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'study')
local studyCostCfg=studyCfg[0][1]
local studyCostItemCfg=studyCostCfg[1]
return studyCostItemCfg[1]
end

function UIGongFaModel:checkStudyReddot(gfID)
return UIGongFaModel:isPageAllActive(gfID)and not UIGongFaModel:hasActiveAnyPageReward(gfID)and UIGongFaModel:checkStudyCanUp(gfID,false,false)
end

function UIGongFaModel:getGongFaProgressByElement(element)
local allGFList=gongfaLookup:getAllGongFaList()
local cur=0
local max=0
for i,cfg in ipairs(allGFList)do
local check=false
if element~=0 then
local f=false
if cfg.element then
for i2,v2 in ipairs(cfg.element)do
if v2==element then
f=true
break
end
end
end
if f then
check=true
end
else
check=true
end
if check then
max=max+1
if UIGongFaModel:isPageAllActive(cfg.id)then
cur=cur+1
end
end
end
return cur,max
end

function UIGongFaModel:checkGongFaFixDisciple(gfID,dis_guid)
local gfcfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dis_guid)
local fixlist={}

fixlist[1]=false
if gfcfg.sex==nil then
fixlist[1]={true,nil}
elseif imageInfo.sex==SEX_TYPE.eNo then
fixlist[1]={true,gfcfg.sex}
else
fixlist[1]={imageInfo.sex==gfcfg.sex,gfcfg.sex}
end

fixlist[2]=false
if gfcfg.guild==nil or gfcfg.guild==0 then
fixlist[2]={true,nil}
else
local guild=UISectPalaceModel:getZongMenLiChang()
fixlist[2]={guild==gfcfg.guild,gfcfg.guild}
end

fixlist[3]=false
if gfcfg.jingjie==nil then
fixlist[3]={true,nil}
else
local jjlv=UIDiscipleModel:getDiscipleJJLevel(dis_guid)
fixlist[3]={jjlv>=gfcfg.jingjie,gfcfg.jingjie}
end

fixlist[4]=false
if gfcfg.lianti==nil then
fixlist[4]={true,nil}
else
local ltlv=UIDiscipleModel:getDiscipleLTLevel(dis_guid)
fixlist[4]={ltlv>=gfcfg.lianti,gfcfg.lianti}
end

fixlist[5]=false
if gfcfg.voc==nil then
fixlist[5]={true,nil}
else
fixlist[5]={gfcfg.voc[imageInfo.job]==1,gfcfg.voc}
end

fixlist[6]=false
if gfcfg.attr6==nil then
fixlist[6]={true,nil}
else
local fix=true
local p={{},{}}
for k,v in pairs(gfcfg.attr6[1])do
local vv=UIDiscipleModel:getDiscipleBaseAttr(dis_guid,k)
if vv<=v then
fix=false
p[1][k]=v
end
end
for k,v in pairs(gfcfg.attr6[2])do
local vv=UIDiscipleModel:getDiscipleBaseAttr(dis_guid,k)
if vv>=v then
fix=false
p[2][k]=v
end
end
if fix then
fixlist[6]={fix,gfcfg.attr6}
else
fixlist[6]={fix,p}
end
end

fixlist[7]=false
local lglookup={}
local lglist=UIDiscipleModel:getDiscipleSpeciality(dis_guid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
if lglist~=nil and#lglist>0 then
for i,v in ipairs(lglist)do
lglookup[v.param_1]=true
end
end
if gfcfg.spiritroot then
local fix=false
for k,v2 in pairs(gfcfg.spiritroot)do
if lglookup[k]==true then
fix=true
break
end
end
fixlist[7]={fix,gfcfg.spiritroot,1}
elseif gfcfg.spiritrootex then
local fix=true
for k,v2 in pairs(gfcfg.spiritrootex)do
if lglookup[k]==nil then
fix=false
break
end
end
fixlist[7]={fix,gfcfg.spiritrootex,2}
else
fixlist[7]={true,nil}
end
local allfix=true
for i,v in ipairs(fixlist)do
if v[1]==false then
allfix=false
break
end
end
return allfix,fixlist
end

function UIGongFaModel:checkGongFaFixDesc(conditionList)
local desc_str='<color=#c82c2c>弟子未达到以下修炼要求</color>'
if conditionList[1][1]==false then
desc_str=desc_str..'\n'
local cond=conditionList[1][2]
desc_str=desc_str..FMT.fmt('<color=#b39d68>性别：</color>{0}',cfgHelper.get2(cfg_disciplesexconfig_get,cond,'name'))
end
if conditionList[2][1]==false then
desc_str=desc_str..'\n'
local cond=conditionList[2][2]
desc_str=desc_str..FMT.fmt('<color=#b39d68>宗门：</color>{0}',cond)
end
if conditionList[3][1]==false then
desc_str=desc_str..'\n'
local cond=conditionList[3][2]
desc_str=desc_str..FMT.fmt('<color=#b39d68>境界：</color>{0}',UIDiscipleModel:getJJNameXX(cond))
end
if conditionList[4][1]==false then
desc_str=desc_str..'\n'
local cond=conditionList[4][2]
desc_str=desc_str..FMT.fmt('<color=#b39d68>炼体：</color>{0}',UIDiscipleModel:getLTNameXX(cond))
end
if conditionList[5][1]==false then
desc_str=desc_str..'\n'
local cond=conditionList[5][2]
desc_str=desc_str..'<color=#b39d68>职业：</color>'
local c=1
for k,v in pairsBySortKey(cond)do
local s=cfgHelper.get2(cfg_disciplevocationconfig_get,k,'name')
if c~=1 then
desc_str=desc_str..'、'..s
else
desc_str=desc_str..s
end
c=c+1
end
end
if conditionList[7][1]==false then
desc_str=desc_str..'\n'
local cond=conditionList[7][2]
local typo=conditionList[7][3]
desc_str=desc_str..'<color=#b39d68>灵根：</color>'
local c=1
for k,v in pairsBySortKey(cond)do
local s=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,k,'name')
if c~=1 then
if typo==1 then
desc_str=desc_str..'/'..s
else
desc_str=desc_str..'、'..s
end
else
desc_str=desc_str..s
end
c=c+1
end
end
if conditionList[6][1]==false then
desc_str=desc_str..'\n'
local cond=conditionList[6][2]
desc_str=desc_str..'<color=#b39d68>六维：</color>'
local str1=''
local c1=1
for k,v in pairsBySortKey(cond[1])do
local s=FMT.fmt('{0}大于{1}',UIDiscipleModel:discipleBaseAttrName(k),v)
if c1~=1 then
str1=str1..'、'..s
else
str1=str1..s
end
c1=c1+1
end
local str2=''
local c2=1
for k,v in pairsBySortKey(cond[2])do
local s=FMT.fmt('{0}小于{1}',UIDiscipleModel:discipleBaseAttrName(k),v)
if c2~=1 then
str2=str2..'、'..s
else
str2=str2..s
end
c2=c2+1
end
if c1>1 and c2>1 then
desc_str=desc_str..str1..'、'..str2
elseif c1>1 then
desc_str=desc_str..str1
elseif c2>1 then
desc_str=desc_str..str2
end
end
return desc_str
end

function UIGongFaModel:getConditionDesc(gfID)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local list={}
if cfg.sex~=nil then
local str=cfgHelper.get2(cfg_disciplesexconfig_get,cfg.sex,'name')
list[#list+1]={'性别：',str,1}
end
if cfg.guild~=nil then
local str=tostring(cfg.guild)
list[#list+1]={'宗门：',str,2}
end
if cfg.jingjie~=nil then
local str=UIDiscipleModel:getJJNameXX(cfg.jingjie)
list[#list+1]={'境界：',str,3}
end
if cfg.lianti~=nil then
local str=UIDiscipleModel:getLTNameXX(cfg.lianti)
list[#list+1]={'炼体：',str,4}
end
if cfg.voc~=nil then
local str=''
local c=1
for k,v in pairsBySortKey(cfg.voc)do
local s=cfgHelper.get2(cfg_disciplevocationconfig_get,k,'name')
if c~=1 then
str=FMT.fmt('{0}、{1}',str,s)
else
str=FMT.fmt('{0}{1}',str,s)
end
c=c+1
end
list[#list+1]={'职业：',str,5}
end
if cfg.spiritroot~=nil then
local str=''
local c=1
for k,v in pairsBySortKey(cfg.spiritroot)do
local s=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,k,'name')
if c~=1 then
str=FMT.fmt('{0}/{1}',str,s)
else
str=FMT.fmt('{0}{1}',str,s)
end
c=c+1
end
list[#list+1]={'灵根：',str,7}
elseif cfg.spiritrootex~=nil then
local str=''
local c=1
for k,v in pairsBySortKey(cfg.spiritrootex)do
local s=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,k,'name')
if c~=1 then
str=FMT.fmt('{0}、{1}',str,s)
else
str=FMT.fmt('{0}{1}',str,s)
end
c=c+1
end
list[#list+1]={'灵根：',str,7}
end
if cfg.attr6~=nil then
local str=''
local str1=''
local c1=1
for k,v in pairsBySortKey(cfg.attr6[1])do
local s=FMT.fmt('{0}大于{1}',UIDiscipleModel:discipleBaseAttrName(k),v)
if c1~=1 then
str1=FMT.fmt('{0}、{1}',str1,s)
else
str1=FMT.fmt('{0}{1}',str1,s)
end
c1=c1+1
end
local str2=''
local c2=1
for k,v in pairsBySortKey(cfg.attr6[2])do
local s=FMT.fmt('{0}小于{1}',UIDiscipleModel:discipleBaseAttrName(k),v)
if c2~=1 then
str2=FMT.fmt('{0}、{1}',str2,s)
else
str2=FMT.fmt('{0}{1}',str2,s)
end
c2=c2+1
end
if c1>1 and c2>1 then
str=FMT.fmt('{0}{1}、{2}',str,str1,str2)
elseif c1>1 then
str=FMT.fmt('{0}{1}',str,str1)
elseif c2>1 then
str=FMT.fmt('{0}{1}',str,str2)
end
list[#list+1]={'六维：',str,6}
end
return list
end

function UIGongFaModel:enoughMoneyLearnGF(dis_guid,gfID,isWarning)
local needmoney=UIGongFaModel:getGFConsume(dis_guid,gfID)
if not moneyModel.checkEnoughMoney(eMoneyType.mtChuanDao,needmoney)then
if isWarning then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(eMoneyType.mtChuanDao)))
gainControl:showGainWin(eMoneyType.mtChuanDao)
end
return false
end
return true
end

function UIGongFaModel:getGFConsume(dis_guid,gfID)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local rate=gubaoModel:getGBSkil_MoneyDownRate(0,eMoneyType.mtChuanDao)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
rate=rate+dzSpecialityGrowEffectController:getGongFaLearnCostRateLookup(netData,cfg.element or{})
local needmoney=math.ceil(cfg.consume*(1+rate/100))
return needmoney
end

function UIGongFaModel:getLearnGFMaxNum()
return cfgHelper.getdef1(cfg_disciplegongfaconfig,'maxnum')
end

function UIGongFaModel:getGFMaxLevel(gfID)
if UIGongFaModel:isGongFaDefaultActive(gfID)then
return cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'maxlv')
else
local pagenum=UIGongFaModel:getGFPieceNum(gfID)
local rate=cfgHelper.getdef1(cfg_disciplegongfaconfig,'level')
return pagenum*rate
end
end

function UIGongFaModel:getUpGFExp(gfID,gflv)
local exp=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'exp')
local upexp=exp[gflv]
return upexp
end

function UIGongFaModel:getUpGFExpDiscount(netData,gfID,exp)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local rate=1+gubaoModel:getGBSkil_MoneyDownRate(0,eMoneyType.mtChuanDao)/100

rate=rate+dzSpecialityGrowEffectController:getGongFaLevelUpCostRate(netData,cfg.element or{})/100
return math.ceil(exp*rate)
end

function UIGongFaModel:getGFPieceNum(gfID)
local netData=UIGongFaModel:getGongFaNetData(gfID)
if netData~=nil then
local pieces=cfgHelper.get2(cfg_disciplegongfaconfig_get,netData.gongfaid,'piece')
if pieces then
local c=0
for i=1,#pieces do
if mathHelper.getBitValue(netData.flag,i*2-1)then
c=c+1
end
end
return c
end
end
return 0
end

function UIGongFaModel:isDiscipleGFLevelFull(dis_guid,gfID,isWarning)
local discipleGFNetData=UIDiscipleModel:getDiscipleGFData(dis_guid,gfID)
local gfLv=discipleGFNetData.param_2
local gfMaxLv=UIGongFaModel:getGFMaxLevel(gfID)
if gfLv>=gfMaxLv then
if isWarning then
UIManager.error('功法等级已达上限')
end
return true
end
return false
end

function UIGongFaModel:getGFLeverlStr(gfLv)
if gfLv<0 then
return'圆满'
elseif gfLv==0 then
return'未激活'
else
return FMT.fmt('{0}层',gfLv)
end
end

function UIGongFaModel:getGFElements(gfID)
return cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'element')
end

function UIGongFaModel:getGFElementName(gfID)
local elements=UIGongFaModel:getGFElements(gfID)
local res=''
local c=#elements
for i,v in ipairs(elements)do
res=res..ELEMENT_TYPE.getNameGF(v)
if i<c then
res=res..'/'
end
end
return res
end

function UIGongFaModel:getGFFactionIcon(factionid)
local icon=cfgHelper.get2(cfg_factiontypeconfig_get,factionid,'icon')
return UIGongFaModel.getGFFactionIconName(icon)
end
function UIGongFaModel.getGFFactionIconName(icon)
if icon then
return'icon_paixitp_'..icon
end
end

function UIGongFaModel:getGFColor(gfID)
return cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'color')
end

function UIGongFaModel:getGFColorName(gfID,str)
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
if str then
str=FMT.fmt(str,cfg.name)
else
str=cfg.name
end
return toColorString(cfg.color,str)
end

function UIGongFaModel:getGFColorKuangIcon(color)
return'frame_gongfakuang_'..color
end
function UIGongFaModel:getGFColorKuangIconEx(gfID)
local color=UIGongFaModel:getGFColor(gfID)
return UIGongFaModel:getGFColorKuangIcon(color)
end

function UIGongFaModel.getGFEffectIconName(icon)
if icon then
return'icon_buff_'..icon
end
end

function UIGongFaModel:getSkillLvInGongFa(gfID,gfLv,skillID)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local skills=cfg.skill
local idx=0
for i,v in ipairs(skills)do
if v==skillID then
idx=i
break
end
end
if idx>0 and gfLv>0 then
local levels=cfg.level
if levels[gfLv]~=nil then
return levels[gfLv][idx]
else



end
end
return nil
end

function UIGongFaModel:getGongFaLvBySkillLv(skillID,skillLv,gfID)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local skills=cfg.skill
local idx=0
for i,v in ipairs(skills)do
if v==skillID then
idx=i
break
end
end
if idx>0 then
local levels=cfg.level
for i,v in ipairs(levels)do
if v[idx]==skillLv then
return i
end
end
end
return nil
end


function UIGongFaModel:checkGFHasBDSkill(gfID)
if gfID==nil or gfID<=0 then return false end
local skills=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'skill')
for i,v in ipairs(skills)do
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,v)
if skillModel.isSkillBD(skillCfg.skillType)then
return true
end
end
return false
end


function UIGongFaModel:getForgetPoint(gfID,gfLv)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
return cfg.back[gfLv]
end

function UIGongFaModel:getDZForgetPoint(dzguid,gfID,gfLv)
local point=UIGongFaModel:getForgetPoint(gfID,gfLv)
local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(dzguid))
local rate=dzSpecialityGrowEffectController:getGongFaForgetGiveRateLookup(netData)/100
point=math.floor(point*(1+rate))
return point
end



function UIGongFaModel:recStudyGF(gfID,spenum)
local gfNetData=activeGongFaList[gfID]
if gfNetData==nil then
gfNetData={}
gfNetData.gongfaid=gfID
gfNetData.flag=0
gfNetData.studylv=1
gfNetData.spenum=spenum
activeGongFaList[gfID]=gfNetData
return 0,1
else
local o_lv=gfNetData.studylv
local n_lv=o_lv+1
gfNetData.studylv=n_lv
gfNetData.spenum=spenum
return o_lv,n_lv
end
end

function UIGongFaModel:refreshGongFaFullStudy(gfID)
if UIGongFaModel:checkFullStudy(gfID)then
maxLvGongFaList[gfID]=true
else
maxLvGongFaList[gfID]=nil
end
end

function UIGongFaModel:getStudyLevel(gfID)
local lv=0
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
lv=gfNetData.studylv or 0
end
return lv
end

function UIGongFaModel:getStudyMaxLevel(gfID)
local mxlv=0
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
if cfg.study~=nil then
mxlv=#cfg.study
end
return mxlv
end

function UIGongFaModel:checkOpenStudy(gfID)
return UIGongFaModel:getStudyMaxLevel(gfID)~=0
end

function UIGongFaModel:checkFullStudy(gfID)
local mxlv=UIGongFaModel:getStudyMaxLevel(gfID)
if mxlv==0 then return true end

local lv=UIGongFaModel:getStudyLevel(gfID)
return lv>=mxlv
end



function UIGongFaModel:checkStudyCanUp(gfID,usespe,isWarning)
local mxlv=UIGongFaModel:getStudyMaxLevel(gfID)
if mxlv==0 then return false end

local lv=UIGongFaModel:getStudyLevel(gfID)
if lv>=mxlv then
if isWarning then
UIManager.error('研习已达最大等级')
end
return false
end

local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local study=cfg.study
local color=cfg.color
local cost=study[lv][1]

local goodlist=cost[1][1]
local neednum=cost[1][2]
local num
local hadnum=0
local GLtable={}
local itemid
local spenum=0
if usespe then
local speItemID=cfgHelper.getdef(cfg_disciplegongfaconfig,'speitemids',color)
num=bagModel.getItemCountById(speItemID)
hadnum=hadnum+num
spenum=bagModel.getItemCountById(speItemID)
itemid=speItemID
end
for i,v in ipairs(goodlist)do
num=bagModel.getItemCountById(v)
hadnum=hadnum+num
itemid=v

if liandonModel:CheckGongFa_Guanlian(gfID)then
local glitemid=liandonModel:CheckGongFa_Guanlian_item(itemid)
if glitemid then
num=bagModel.getItemCountById(glitemid)
if num>0 then

GLtable[glitemid]={itemid,num,neednum-hadnum+spenum}
hadnum=hadnum+num
end
end
end
end
if hadnum<neednum then
if isWarning then
UIManager.error('篇章道具不足')
if itemid then
gainControl:showGainWin(itemid)
end
end
return false
end

local money=cost[2]
local moneyType=money[1]
local needmoney=money[2]
local hasmoney=moneyModel.getMoney(moneyType)
if hasmoney<needmoney then
if isWarning then
UIManager.error('货币不足')
gainControl:showGainWin(moneyType)
end
return false
end
return true,GLtable
end



function UIGongFaModel:checkStudyCanUp2(gfID,usespe,isWarning,costlp,lv)
local costIdx,lp2
local markCost=costlp~=nil
if markCost then
lp2={}
end
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local study=cfg.study
local cost=study[lv][1]
local goodlist=cost[1][1]
local neednum=cost[1][2]
local add,num
local hadnum=0
local GLtable={}
local itemid,itemid_
local spenum=0
if usespe==true then
local color=cfg.color
itemid_=cfgHelper.getdef(cfg_disciplegongfaconfig,'speitemids',color)
num=bagModel.getItemCountById(itemid_)
if markCost==true then
num=math.max(0,num-((costlp[itemid_]or 0)+(lp2[itemid_]or 0)))
end
add=math.min(num,neednum-hadnum)
if add>0 then
if markCost==true then
lp2[itemid_]=(lp2[itemid_]or 0)+add
end
hadnum=hadnum+add
spenum=add
end
if hadnum<neednum then itemid=itemid_ end
end
for i,v in ipairs(goodlist)do
itemid_=v
num=bagModel.getItemCountById(itemid_)
if markCost==true then
num=math.max(0,num-((costlp[itemid_]or 0)+(lp2[itemid_]or 0)))
end
add=math.min(num,neednum-hadnum)
if add>0 then
if markCost==true then
lp2[itemid_]=(lp2[itemid_]or 0)+add
end
hadnum=hadnum+add
end
if hadnum<neednum then itemid=itemid_ end

if liandonModel:CheckGongFa_Guanlian(gfID)then
itemid_=liandonModel:CheckGongFa_Guanlian_item(itemid_)
if itemid_ then
num=bagModel.getItemCountById(itemid_)
if markCost==true then
num=math.max(0,num-((costlp[itemid_]or 0)+(lp2[itemid_]or 0)))
end
add=math.min(num,neednum-hadnum)
if add>0 then
if markCost==true then
lp2[itemid_]=(lp2[itemid_]or 0)+add
end


GLtable[itemid_]={v,num,add}
hadnum=hadnum+add
end
end
end
end
if hadnum<neednum then
if isWarning then
UIManager.error('篇章道具不足')
if itemid then
gainControl:showGainWin(itemid)
end
end
return false
end
local money=cost[2]
itemid_=money[1]
add=money[2]
num=moneyModel.getMoney(itemid_)
if markCost==true then
num=math.max(0,num-((costlp[itemid_]or 0)+(lp2[itemid_]or 0)))
end
if num<add then
if isWarning then
UIManager.error('货币不足')
gainControl:showGainWin(itemid_)
end
return false
end
if markCost==true then
lp2[itemid_]=(lp2[itemid_]or 0)+add


if costlp.part==nil then costlp.part={}end
costIdx=#costlp.part+1
costlp.part[costIdx]=lp2
for itemid__,n in pairs(lp2)do
costlp[itemid__]=(costlp[itemid__]or 0)+n
end
end

return true,GLtable,true,costIdx
end

function UIGongFaModel:getStudyDescList(gfID,studylv)
local desclist={}

local attrlist=UIGongFaModel:getGFStudyAttr(gfID,studylv)
for i,v in ipairs(attrlist)do
local str=helper.getAttributeStr(v[1],v[2],1,'{0}+{1}')
table.insert(desclist,str)
end

local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local studyDesc=cfg.studyDesc
for i,v in ipairs(studyDesc)do
local active_lv=v[1]
local desc=v[2]
local isActive=studylv>=active_lv
if isActive then
table.insert(desclist,desc)
end
end
return desclist
end


function UIGongFaModel:setGongFaSpenum(gfID,spenum)
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
gfNetData.spenum=spenum
gfNetData.studylv=0
end
end


function UIGongFaModel:getGongFaSpenum(gfID)
local gfNetData=UIGongFaModel:getGongFaNetData(gfID)
if gfNetData then
return gfNetData.spenum or 0
end
return 0
end



