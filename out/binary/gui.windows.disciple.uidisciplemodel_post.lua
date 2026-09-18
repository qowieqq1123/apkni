








eZongMenPostType=
{
eZhangMen=1,
eJielu=2,
eChuanGong=3,
eJieYin=4,
eZhenYu=5,
eNeiMen=6,
eWaiMen=7,

getName=function(v)
return cfgHelper.get(cfg_guildposconfig_get,v,'pos_name')
end,
isZhangLao=function(self,v)
return v==self.eJielu or v==self.eChuanGong or
v==self.eJieYin or v==self.eZhenYu
end,
}


function UIDiscipleModel:getDiscipleByZongMenPost(postType)
UIDiscipleModel:initDiscipleZongMenPost()
return self.postList_[postType]
end

function UIDiscipleModel:initDiscipleZongMenPost(force)
if self.postList_==nil or force then
local postList_={}

local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
for k,v in pairs(all)do
local netData=v.netData.net
local pos=netData.pos
if pos then
if postList_[pos]==nil then postList_[pos]={}end
local list=postList_[pos]
list[#list+1]=netData
end
end
end
self.postList_=postList_
end
end

function UIDiscipleModel:refreshDiscipleZongMenPost(dzGuidStr,pos1,pos2)
UIDiscipleModel:initDiscipleZongMenPost()
local postList_=self.postList_
if pos1 and postList_[pos1]then
for i,v in ipairs(postList_[pos1])do
if v.discipleguidStr==dzGuidStr then
_remove(postList_[pos1],i)
break
end
end
end
if pos2 then
if postList_[pos2]==nil then postList_[pos2]={}end
local netData=UIDiscipleModel:getDiscipleDataByStr(dzGuidStr)
local t=postList_[pos2]
t[#t+1]=netData
end
end

function UIDiscipleModel:hasZongMenPost(postType)
local result=UIDiscipleModel:getDiscipleByZongMenPost(postType)
if result then return#result>0 end
return false
end

function UIDiscipleModel:getDisciplePost(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDisciplePostEX(netData)
end

function UIDiscipleModel:checkDisciplePost(guid,postType)
local p=UIDiscipleModel:getDisciplePost(guid)
return p==postType
end

function UIDiscipleModel:getDisciplePostEX(netData)
local pos=netData.pos
if pos==0 then
pos=eZongMenPostType.eWaiMen
end
return pos
end

function UIDiscipleModel:getDisciplePostWages(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDisciplePostWagesEx(netData)
end

function UIDiscipleModel:getDisciplePostWagesEx(netData)
local postType=netData.pos
if postType==0 then
postType=eZongMenPostType.eWaiMen
end
local jjlv=netData.jingjielv
local wages=cfgHelper.get2(cfg_guildposconfig_get,postType,'wages')or 0
local wages2=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'wages')or 0
local rate=0
rate=rate+dzSpecialityGrowEffectController:getPostWagesRate(netData)/100
local rate_=1+rate
if rate_<0 then rate_=0 end
local num=math.ceil((wages+wages2)*rate_)
return num,{wages,wages2,rate}
end

function UIDiscipleModel:getDisciplePostWagesDesc(guid)
local num,args=UIDiscipleModel:getDisciplePostWages(guid)
local fmt_str=cfgHelper.getlang('dizi_wage_desc')or'添加语言表：dizi_wage_desc\n职位俸禄：{0}\n境界俸禄：{1}\n加成：{2}%'
local str=FMT.fmt(fmt_str,args[1],args[2],args[3]*100)
return str
end

function UIDiscipleModel.checkDisciplePostOpen(postType,isWarning)
local guildcfg=cfgHelper.get1(cfg_guildposconfig_get,postType)
local guild_lv=guildcfg.guild_lv
local cur=zongmenModel:getLevel()
if cur<guild_lv then
if isWarning==true then
UIManager.error(FMT.fmt(cfgHelper.getlang('sectpalace_tips_2'),guild_lv))
end
return false,{1,guild_lv}
end
local build_id=guildcfg.build_id
if build_id then
local sfId=mapIdType.zhufeng
if zongmenModel:findBuildingDataByID(sfId,build_id)==nil then
if isWarning==true then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,build_id,'name')
UIManager.error(FMT.fmt(cfgHelper.getlang('sectpalace_tips_4'),name))
end
return false,{2,build_id}
end
end
return true
end