







def_class("UIDiZIGongLueTwoWin",UIWindowBase)









function UIDiZIGongLueTwoWin:bindComponents()

self.itemGridPanel=UIObject.get(self,0)



end


function UIDiZIGongLueTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
end
















local _this=nil
local fbStageSystem={
[1]=SYSTEM_DEFINE.eFaBao1,
[2]=SYSTEM_DEFINE.eFaBao2,
[3]=SYSTEM_DEFINE.eFaBao3,
[4]=SYSTEM_DEFINE.eFaBao4,
[5]=SYSTEM_DEFINE.eFaBao5,
}


function UIDiZIGongLueTwoWin:onLoaded(...)
_this=self
self:bindComponents()
self.animSpeed=0.5
end


function UIDiZIGongLueTwoWin:__delete()
_this=nil
self:unbindComponents()
end


function UIDiZIGongLueTwoWin:onHide()

end




function UIDiZIGongLueTwoWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dis_guid
self.parentWin=argtable.parentWin

if afterOnloaded then
local itemsLookup={}
local grid=self.itemGridPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grid.Count do
itemsLookup[i]=grid[i-1]
end
self.itemsLookup=itemsLookup
end
self:refreshView()
end

function UIDiZIGongLueTwoWin:onChangeDisciple(dis_guid)
self.disciple_guid=dis_guid
self:refreshView()
end

function UIDiZIGongLueTwoWin:refreshView()
self:refreshFightItem()
self:refreshXiuWeiItem()
self:refreshTianMingItem()
self:refreshZhuangBeiItem()
self:refreshFaBaotem()
self:refreshDaoBingtem()
self:refreshGongFatem()
end



function UIDiZIGongLueTwoWin:refreshFightItem()
local widget=self.itemsLookup[1]
local guid=self.disciple_guid
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local jobid=imageInfo.job
local jobcfg=cfgHelper.get1(cfg_disciplevocationconfig_get,jobid)
self.jobcfg=jobcfg

local fight=UIDiscipleModel:getDiscipleFightValue(guid)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local maxFight=nil
local tj_fight=cfgHelper.get2(cfg_disciplevocationconfig_get,jobid,'tj_fight')
for i,v in ipairs(tj_fight)do
if jjlv>=v[1]and jjlv<=v[2]then
maxFight=v[3]
break
end
end
if maxFight==nil then
maxFight=tj_fight[#tj_fight][3]
end
local rate=fight/maxFight
if rate>1 then
rate=1
end

local desc
local rate_=rate*100
local fight_rate_desc=cfgHelper.getdef1(cfg_dizivocationtaoluconfig,'fight_rate_desc')
for i,v in ipairs(fight_rate_desc)do
if rate_>=v[1]and rate_<v[2]then
desc=v[3]
break
end
end
widget:SetChildText(0,desc or'')

local speed=self.animSpeed
local old_rate=widget:GetChildIconFillAmount(1)
widget:SetChildImageDOFillAmount(1,rate,math.abs(rate-old_rate)*speed,nil)

local fight_str=FMT.fmt('战力：{0}',fight)
widget:SetChildText(2,fight_str)
end





function UIDiZIGongLueTwoWin:refreshXiuWeiItem()
local widget=self.itemsLookup[2]
local guid=self.disciple_guid
local speed=self.animSpeed


local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local maxjjlv=jjlv
local jjcfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,maxjjlv)
while jjcfg~=nil and not UIDiscipleModel:checkJJLevelFullEx(jjcfg)and jjcfg.sectlv==nil do
local cur=maxjjlv+1
jjcfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,cur)
if jjcfg~=nil then
maxjjlv=cur
end
end
if maxjjlv==0 then
maxjjlv=1
end

local jjname=UIDiscipleModel.getJJNameCommon(jjlv,3)
local jj_str=FMT.fmt('{0} {1}/{2}',jjname,jjlv,maxjjlv)
widget:SetChildText(1,jj_str)

local jj_rate=jjlv/maxjjlv
local old_jj_rate=widget:GetChildIconFillAmount(0)
widget:SetChildImageDOFillAmount(0,jj_rate,math.abs(jj_rate-old_jj_rate)*speed,nil)


local ltlv=UIDiscipleModel:getDiscipleLTLevel(guid)
local maxltlv=ltlv
local ltcfg=cfgHelper.get1(cfg_disciplelianticonfig_get,maxltlv)
local ltlimit
if ltcfg~=nil then
ltlimit=ltcfg.jingjie
end
if jjlv>=ltlimit then
while ltcfg~=nil and not UIDiscipleModel:checkLTFullEx(ltcfg)and ltcfg.jingjie==ltlimit do
local cur=maxltlv+1
ltcfg=cfgHelper.get1(cfg_disciplelianticonfig_get,cur)
if ltcfg~=nil then
maxltlv=cur
end
end
end
if maxltlv==0 then
maxltlv=1
end

local ltname=UIDiscipleModel.getLTNameCommon(ltlv,3)
local lt_str=FMT.fmt('{0} {1}/{2}',ltname,ltlv,maxltlv)
widget:SetChildText(3,lt_str)

local lt_rate=ltlv/maxltlv
local old_lt_rate=widget:GetChildIconFillAmount(2)
widget:SetChildImageDOFillAmount(2,lt_rate,math.abs(lt_rate-old_lt_rate)*speed,nil)


widget:SetChildButtonClick(4,function()
if _this==nil then return end
_this:onJumpXiuWei()
end)
end

function UIDiZIGongLueTwoWin:onJumpXiuWei()
local guid=self.disciple_guid
UIManager:invokeUIMethod(self.parentWin,'onCloseBtn')
UIFullDiscipleMainControl:myShowWindow({dis_guid=guid},FULL_TAB_TYPE.eDiscipleInfo)
end





function UIDiZIGongLueTwoWin:refreshTianMingItem()
local widget=self.itemsLookup[3]
local guid=self.disciple_guid
local netData=UIDiscipleModel:getDiscipleData(guid)
local isOpen=UIDiscipleModel:checkOponTianMing(netData)
local isShow=isOpen
widget:SetChildActive(-1,isShow)
if isShow then
local speed=self.animSpeed
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local jobid=self.jobcfg.id


local floorname=UIDiscipleModel.getTianMingLevelFloorName(tmlv)
local desc_str=FMT.fmt('弟子当前天命：<color=#171311>{0}</color>',floorname)
widget:SetChildText(1,desc_str)

local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local chong=UIDiscipleModel.getTianMingLevelChong(tmlv)
local maxchong=3
local chong_rate=chong/3
local old_chong_rate=widget:GetChildIconFillAmount(2)
widget:SetChildImageDOFillAmount(2,chong_rate,math.abs(chong_rate-old_chong_rate)*speed,nil)
widget:SetChildText(3,floorname)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local chongWidget=widget:GetChildWidgetBase(4)
for i=1,3 do
local item=chongWidget:GetChildWidgetBase(i-1)
local isActive=i<=chong
local scale=0.5
if not isActive then
abName=globalABLookup.dizitianmingicons
iconName='image_dztianmingui_2'
scale=1
end
item:SetChildCSImageSprite(0,abName,iconName)
item:SetChildScale(0,Vector3.New(scale,scale,scale))
end

local tmList=UIDiscipleModel:getTianMingByIndexEx(netData)
local n=#tmList
widget:SetChildLayoutGroupCreateItems(5,n)
local grids=widget:GetChildLayoutGroupGridList(5)
for i=1,grids.Count do
local item=grids[i-1]
local tmId=tmList[i]
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmId)
local isUnlock,need_tmlv=UIDiscipleModel:checkTianMingFloorActive(tmlv,i)
local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,jobid,netData)
local skillIconName=iconHelper.getSkillIcon(skillIconId)
item:SetChildCSImageIcon(0,skillIconName,false)
item:SetChildImageExGray(0,not isUnlock)
item:SetChildActive(1,not isUnlock)
item:SetChildButtonClick(2,function()
self:showWindow("UIDiscipleTianMingSkillTipsWin",{tmId=tmId,tmLv=tmlv,tmIndex=i,guid=guid,skillIconId=skillIconId})
end)
end

widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onJumpTianMing()
end)
end
end

function UIDiZIGongLueTwoWin:onJumpTianMing()
local guid=self.disciple_guid
UIManager:invokeUIMethod(self.parentWin,'onCloseBtn')
UIFullDiscipleMainControl:myShowWindow({dis_guid=guid},FULL_TAB_TYPE.eDiscipleTianMing)
end





function UIDiZIGongLueTwoWin:refreshZhuangBeiItem()
local widget=self.itemsLookup[4]
local guid=self.disciple_guid
local speed=self.animSpeed
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)

local cur_maxStage=-1

local typoLookup={}
typoLookup[1]={EQUIP_TYPE.eWeapon}
typoLookup[2]={EQUIP_TYPE.eClothes}
typoLookup[3]={EQUIP_TYPE.eCap}
typoLookup[4]={EQUIP_TYPE.eShoot}
local isShow=false
for i,v in ipairs(typoLookup)do
local equip=equipsHelper.getEquipByDizi(guid,v[1])
v[2]=equip
if equip~=nil then
isShow=true
end
end
widget:SetChildActive(3,isShow)
widget:SetChildActive(2,not isShow)
if isShow then
local grids=widget:GetChildCommonLayoutGroupWidgetList(4)
for i=1,4 do
local item=grids[i-1]
local typo=typoLookup[i][1]
local equip=typoLookup[i][2]

item:SetChildText(0,equipsConfig.getEquipName(typo))
local show=equip~=nil
item:SetChildActive(1,show)
item:SetChildActive(4,not show)
if show then
local stage=itemsConfig.getConfig(equip.itemid).stage
if stage>cur_maxStage then
cur_maxStage=stage
end

local cur=equipsModel.getEquipJinglianLevel(equip)
local max=equipsConfig.getJinglianMaxLvByItemid(equip.itemid)
local rate=cur/max
item:SetChildText(3,FMT.fmt('{0}/{1}',cur,max))
local old_rate=item:GetChildIconFillAmount(2)
item:SetChildImageDOFillAmount(2,rate,math.abs(rate-old_rate)*speed,nil)
end
end
end

local check_str=''
local dressStage=equipsConfig.getDressState(jjlv)
if cur_maxStage>0 and cur_maxStage<dressStage then
check_str='（可更换）'
end
local desc_str=FMT.fmt('推荐装备阶数：<color=#171311>{0}阶{1}</color>',dressStage,check_str)
widget:SetChildText(0,desc_str)

widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onJumpZhuangBei()
end)
end

function UIDiZIGongLueTwoWin:onJumpZhuangBei()
local guid=self.disciple_guid
UIManager:invokeUIMethod(self.parentWin,'onCloseBtn')
UIFullDiscipleMainControl:myShowWindow({dis_guid=guid},FULL_TAB_TYPE.eDiscipleEquip)
end






function UIDiZIGongLueTwoWin:refreshFaBaotem()
local widget=self.itemsLookup[5]
local guid=self.disciple_guid
local speed=self.animSpeed
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)

local dressStage=fabaoConfig.getDressState(jjlv)
local isUnlock=dressStage>0
widget:SetChildActive(-1,isUnlock)
if isUnlock then
local cur_maxStage=-1
local equip=equipsHelper.getEquipByDizi(guid,EQUIP_TYPE.eFabao)
local isShow=equip~=nil
widget:SetChildActive(3,isShow)
widget:SetChildActive(2,not isShow)
if isShow then
local stage=itemsConfig.getConfig(equip.itemid).stage
cur_maxStage=stage
local grids=widget:GetChildCommonLayoutGroupWidgetList(4)
for i=1,3 do
local item=grids[i-1]
local itemguid=equip.itemguid
local show
if i==1 then

show=systemModel.isOpen(SYSTEM_DEFINE.eJiLian)
elseif i==2 then

show=systemModel.isOpen(SYSTEM_DEFINE.eLianHua)
else

show=fabaoConfig.isBenMingFabao(equip.itemid)and systemModel.isOpen(SYSTEM_DEFINE.eBenMingFaBao)
end
item:SetChildActive(-1,show)
if show then
local cur,max
if i==1 then

cur=fabaoModel.getFabaoJilianLevel(itemguid)
max=fabaoHelper.getJilianMaxLv(itemguid)
elseif i==2 then

cur=fabaoModel.getFabaoLianhuanum(itemguid)
max=fabaoHelper.getLianhuaMaxNum(itemguid)
else

cur=fabaoModel.getLingXingLv(itemguid)
local m=0
local cfgs=cfg_disciplefabaolingxingconfig()
for i,v in ipairs(cfgs)do
if v.id~=nil then
local jjlv_=v.jingjie or 0
if jjlv>=jjlv_ then
m=v.id
end
end
end
max=m
if max==0 then max=1 end
end
local rate=cur/max
item:SetChildText(1,FMT.fmt('{0}/{1}',cur,max))
local old_rate=item:GetChildIconFillAmount(0)
item:SetChildImageDOFillAmount(0,rate,math.abs(rate-old_rate)*speed,nil)
end
end
end


local check_str=''
local maxStage
for stage_,sysid in ipairs(fbStageSystem)do
if systemModel.isOpen(sysid)then
maxStage=stage_
end
end
if cur_maxStage>0 and maxStage~=nil and cur_maxStage<dressStage and cur_maxStage<maxStage then
check_str='（可更换）'
end
local desc_str=FMT.fmt('推荐法宝阶数：<color=#171311>{0}阶{1}</color>',dressStage,check_str)
widget:SetChildText(0,desc_str)

widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onJumpFaBao()
end)
end
end

function UIDiZIGongLueTwoWin:onJumpFaBao()
local guid=self.disciple_guid
UIManager:invokeUIMethod(self.parentWin,'onCloseBtn')
local opedCallBack=function()
if UIManager:isActive('UIEquipWin')then
UIManager:invokeUIMethod('UIEquipWin','onClickEquipType',EQUIP_TYPE.eFabao)
else
timeEventController.delayDo(0.8,function()
UIManager:invokeUIMethod('UIEquipWin','onClickEquipType',EQUIP_TYPE.eFabao)
end)
end
end
UIFullDiscipleMainControl:myShowWindow({dis_guid=guid,opedCallBack=opedCallBack},FULL_TAB_TYPE.eDiscipleEquip)
end





function UIDiZIGongLueTwoWin:refreshDaoBingtem()
local widget=self.itemsLookup[6]
local guid=self.disciple_guid
local speed=self.animSpeed
local jobid=self.jobcfg.id

local equip=equipsHelper.getEquipByDizi(guid,EQUIP_TYPE.eDaoBing)
local isShow=equip~=nil
widget:SetChildActive(3,isShow)
widget:SetChildActive(2,not isShow)
if isShow then
local itemguid=equip.itemguid
local cur,max,rate,old_rate
local starlv=daobingModel:getStarLv(itemguid)

cur=daobingModel:getJilianLv(itemguid)
max=daobingConfig.getCurrentJinglianMaxLv(equip.itemid,starlv)
rate=cur/max
widget:SetChildText(5,FMT.fmt('{0}/{1}',cur,max))
old_rate=widget:GetChildIconFillAmount(4)
widget:SetChildImageDOFillAmount(4,rate,math.abs(rate-old_rate)*speed,nil)

cur=starlv
max=daobingConfig.getStarMaxLv(equip.itemid)
rate=cur/max
widget:SetChildText(7,FMT.fmt('{0}/{1}',cur,max))
old_rate=widget:GetChildIconFillAmount(6)
widget:SetChildImageDOFillAmount(6,rate,math.abs(rate-old_rate)*speed,nil)
end

local str=''
local weapon=cfgHelper.get2(cfg_disciplevocationconfig_get,jobid,'weapon')
local n=#weapon
for i=1,n do
local typo=weapon[i]
local name=cfgHelper.get2(cfg_discipleweaponconfig_get,typo,'name')
if i==n then
str=FMT.fmt('{0}{1}',str,name)
else
if pfwindowslController:checkIsGameVersion_oumei()then
str=FMT.fmt('{0} {1},',str,name)
else
str=FMT.fmt('{0}{1}、',str,name)
end
end
end
local desc_str=FMT.fmt('可装备道兵类型：<color=#171311>{0}</color>',str)
widget:SetChildText(0,desc_str)

widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onJumpDaoBing()
end)
end

function UIDiZIGongLueTwoWin:onJumpDaoBing()
local guid=self.disciple_guid
UIManager:invokeUIMethod(self.parentWin,'onCloseBtn')
local opedCallBack=function()
if UIManager:isActive('UIEquipWin')then
UIManager:invokeUIMethod('UIEquipWin','onClickEquipType',EQUIP_TYPE.eDaoBing)
else
timeEventController.delayDo(0.8,function()
UIManager:invokeUIMethod('UIEquipWin','onClickEquipType',EQUIP_TYPE.eDaoBing)
end)
end
end
UIFullDiscipleMainControl:myShowWindow({dis_guid=guid,opedCallBack=opedCallBack},FULL_TAB_TYPE.eDiscipleEquip)
end





function UIDiZIGongLueTwoWin:refreshGongFatem()
local widget=self.itemsLookup[7]
local guid=self.disciple_guid
local speed=self.animSpeed
local netData=UIDiscipleModel:getDiscipleData(guid)
local usingGFList=UIDiscipleModel:getDiscipleUsingGFList(netData)

local isShow=false
for i=1,2 do
local gfID=usingGFList[i]
if gfID~=nil and gfID>0 then
isShow=true
end
end
widget:SetChildActive(3,isShow)
widget:SetChildActive(2,not isShow)
if isShow then
local gfSkillList=UIDiscipleModel:getDiscipleUsingGFSkillList(guid,true)

local lvGrids=widget:GetChildCommonLayoutGroupWidgetList(4)
for i=1,4 do
local item=lvGrids[i-1]
local d=gfSkillList[i]
local show=d~=nil
item:SetChildActive(-1,show)
if show then
local skillID=d[1]
local skillLv=d[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)

item:SetChildText(0,skillCfg.name)

local cur,max
cur=skillLv
max=skillCfg.maxGrowLv
local rate=cur/max
item:SetChildText(2,FMT.fmt('{0}/{1}',cur,max))
local old_rate=item:GetChildIconFillAmount(1)
item:SetChildImageDOFillAmount(1,rate,math.abs(rate-old_rate)*speed,nil)
end
end

local studyGrids=widget:GetChildCommonLayoutGroupWidgetList(5)
for i=1,2 do
local item=studyGrids[i-1]
local gfID=usingGFList[i]
local show=gfID~=nil and gfID>0
item:SetChildActive(-1,show)
if show then

local name=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'name')
item:SetChildText(0,name)

local cur,max
cur=UIGongFaModel:getStudyLevel(gfID)
max=UIGongFaModel:getStudyMaxLevel(gfID)
if max<=0 then
item:SetChildIconFillAmount(1,1)
item:SetChildText(2,'功法无研习')
else
local rate=cur/max
item:SetChildText(2,FMT.fmt('{0}/{1}',cur,max))
local old_rate=item:GetChildIconFillAmount(1)
item:SetChildImageDOFillAmount(1,rate,math.abs(rate-old_rate)*speed,nil)
end
end
end
end

local str=''
local desclist=UIDiscipleModel:getDiscipleAllSpecialityByData(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
local n=#desclist
for i=1,n do
local typo=desclist[i].param_1
local name=ELEMENT_TYPE.getName(typo)
if i==n then
str=FMT.fmt('{0}{1}',str,name)
else
if pfwindowslController:checkIsGameVersion_oumei()then
str=FMT.fmt('{0} {1},',str,name)
else
str=FMT.fmt('{0}{1}、',str,name)
end
end
end
local desc_str=FMT.fmt('可修炼功法五行：<color=#171311>{0}</color>',str)
widget:SetChildText(0,desc_str)

widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onJumpGongFa()
end)
end

function UIDiZIGongLueTwoWin:onJumpGongFa()
local guid=self.disciple_guid
UIManager:invokeUIMethod(self.parentWin,'onCloseBtn')
local opedCallBack=function()
if UIManager:isActive('UIDiscipleSkillInfoWin')then
UIManager:invokeUIMethod('UIDiscipleSkillInfoWin','onGFSlotClick',1)
else
timeEventController.delayDo(0.8,function()
UIManager:invokeUIMethod('UIDiscipleSkillInfoWin','onGFSlotClick',1)
end)
end
end
UIFullDiscipleMainControl:myShowWindow({dis_guid=guid,opedCallBack=opedCallBack},FULL_TAB_TYPE.eDiscipleSkill)
end

