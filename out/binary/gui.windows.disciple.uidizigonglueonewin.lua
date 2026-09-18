







def_class("UIDiZIGongLueOneWin",UIWindowBase)









function UIDiZIGongLueOneWin:bindComponents()

self.itemGridPanel=UIObject.get(self,0)



end


function UIDiZIGongLueOneWin:unbindComponents()
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


function UIDiZIGongLueOneWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIDiZIGongLueOneWin:__delete()
_this=nil
self:unbindComponents()
end


function UIDiZIGongLueOneWin:onHide()

end




function UIDiZIGongLueOneWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dis_guid
self.dzid=UIDiscipleModel:getDiscipleID(self.disciple_guid)
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

function UIDiZIGongLueOneWin:onChangeDisciple(dis_guid)
self.disciple_guid=dis_guid
self.dzid=UIDiscipleModel:getDiscipleID(self.disciple_guid)
self:refreshView()
end

function UIDiZIGongLueOneWin:refreshView()
self:refreshJobItem()
self:refreshGFItem()
self:refreshFBItem()
self:refreshDBItem()
self:refreshTZItem()
if systemModel.isOpen(SYSTEM_DEFINE.eXianYouRuYun)then
self:refreshZRItem()
end
end

function UIDiZIGongLueOneWin:refreshZRItem()
local widget=self.itemsLookup[2]
local data=xianYouRuYunModel:getSuggestDataById(self.dzid)
if not data then return end
local list=data.list
local jump=data.jump

if list and next(list)and widget then
widget:SetChildActive(-1,true)
widget:SetChildActive(0,data.isNow or false)
widget:SetChildActive(2,true)

if data.isNow and jump then
local fun
if jump[1]==1 then
fun=function()activitiesController:jump(jump[2],jump[3],jump[4])end
elseif jump[1]==2 then
fun=function()jumpManager:jump({id=jump.id,args=jump.args})end
end
widget:SetChildButtonClick(0,fun)
end

local len=#list
widget:SetChildScrollViewCreateGrids(2,len,len)
local grids=widget:GetChildScrollViewItemWidgets(2)

for i=1,len do
local modelParams={}
local diziId=list[i]
local grid=grids[i-1]
local datas=UIDiscipleModel:getDiscipleDataByDiziId(diziId)
local cfg=cfgHelper.get2(cfg_discipleconfig_get,diziId,'imagelib')
local bodyid=cfgHelper.get2(cfg_disciplebodyimageconfig_get,cfg[3],'skeletonID')
modelParams.body=bodyid
local count=UIDiscipleModel:getSameIdDiscipleCount(diziId)
local isGray=true and count<1 or false


comHelper.setChildModelHeadIconBGByColor(grid,0,datas.imageInfo.color)
comHelper.setChildModelRawImageEx(1,grid,modelParams,eHeadCenterType.eHead,1,isGray)
end
else
widget:SetChildActive(-1,false)
widget:SetChildActive(2,false)
end
end



function UIDiZIGongLueOneWin:refreshJobItem()
local widget=self.itemsLookup[1]
local guid=self.disciple_guid
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local jobid=imageInfo.job
local jobcfg=cfgHelper.get1(cfg_disciplevocationconfig_get,jobid)
self.jobcfg=jobcfg
local dzid=self.dzid


local job_name=FMT.fmt('职业：{0}',jobcfg.name)
widget:SetChildText(0,job_name)

local ratelist={}
for i,v in ipairs(jobcfg.attr3Rate)do
ratelist[i]=v/100
end
widget:SetChildUIPolygonImage(1,ratelist,30)

local title=jobcfg.titleList[dzid]or jobcfg.titleList[0]
local title1=title[1]
widget:SetChildActive(2,title1~=nil)
if title1~=nil then
widget:SetChildText(3,title1)
end

local title2=title[2]
widget:SetChildActive(4,title2~=nil)
if title2~=nil then
widget:SetChildText(5,title2)
end

local desc_str=UIDiscipleModel:getJobDesc(jobid,dzid)
widget:SetChildText(6,desc_str)

local stand_str=UIDiscipleModel:getJobStandStr(jobid,dzid)
widget:SetChildText(7,FMT.fmt('推荐站位：{0}',stand_str))
end





function UIDiZIGongLueOneWin:refreshGFItem()
local widget=self.itemsLookup[3]
local isShow=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eCangJingGe)~=nil
widget:SetChildActive(-1,isShow)
if isShow then
local guid=self.disciple_guid
local dzid=self.dzid
local jobid=self.jobcfg.id
local lglookup={}

local netData=UIDiscipleModel:getDiscipleData(guid)
self.desclist=UIDiscipleModel:getDiscipleAllSpecialityByData(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
local n=#self.desclist
widget:SetChildLayoutGroupCreateItems(0,n)
local gridlist=widget:GetChildLayoutGroupGridList(0)
local count=gridlist.Count
if count>0 then
for i=1,count do
local d=self.desclist[i]
local speType=d.param_1
local cfg=UIDiscipleModel:getSpecialityConfigEx(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,d)
lglookup[speType]=true
local item=gridlist[i-1]
item:SetChildActive(-1,true)
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onLingGenClick(i)
end,d.name)
end
end

local all_active_gf=gongfaLookup:getAllActiveGongFaList()
local sx_list={}
for i,v in ipairs(all_active_gf)do
local tjValues=v.job_tjValue[jobid]
if tjValues then
local tjValue=tjValues[dzid]or tjValues[0]
if tjValue then
if v.spiritroot then
for k,v2 in pairs(v.spiritroot)do
if lglookup[k]==true then
table.insert(sx_list,{v,tjValue})
break
end
end
elseif v.spiritrootex then
local flag=true
for k,v2 in pairs(v.spiritrootex)do
if lglookup[k]==nil then
flag=false
break
end
end
if flag then
table.insert(sx_list,{v,tjValue})
end
else
table.insert(sx_list,{v,tjValue})
end
else



end
else



end
end
if#sx_list>1 then
table.sort(sx_list,function(a,b)
return a[2]>b[2]
end)
end
for i=1,2 do
local idx=i
local d=sx_list[i]
local show_sx=d~=nil
widget:SetChildActive(idx,show_sx)
if show_sx then
local gfWidget=widget:GetChildWidgetBase(idx)
local cfg=d[1]
local gfID=cfg.id

gfWidget:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onClickGF(gfID)
end)

local colorIcon=UIGongFaModel:getGFColorKuangIcon(cfg.color)
gfWidget:SetChildCSImageSprite(0,globalABLookup.cangjingge,colorIcon)

gfWidget:SetChildIcon(1,iconHelper.getGongFaIcon(cfg.icon),true)

local elements=UIGongFaModel:getGFElements(gfID)
local elementid=elements[1]
local elementIcon=ELEMENT_TYPE.getIcon(elementid)
gfWidget:SetChildCSImageSprite(2,globalABLookup.global,elementIcon)

gfWidget:SetChildText(3,cfg.name)

local isUse=UIDiscipleModel:isDiscipleGFUsing(guid,gfID)
gfWidget:SetChildActive(4,isUse)
end
end

widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onJumpGF()
end)

local jobcfg=self.jobcfg
local taoluList={}
if jobcfg.gf_taoluList then
local temp=jobcfg.gf_taoluList[dzid]or jobcfg.gf_taoluList[0]
if temp then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local temp2
for i,v in ipairs(temp)do
if jjlv>=v[1]and jjlv<=v[2]then
temp2=v[3]
break
end
end
if temp2==nil then
temp2=temp[#temp][3]
end
for i,tlid in ipairs(temp2)do
local list={}
local tlcfg=cfgHelper.get1(cfg_dizivocationtaoluconfig_get,tlid)
if tlcfg.gflist then
for i2,gfID in ipairs(tlcfg.gflist)do
local ishide=gongfaLookup:isHideGongFa(gfID)
if not ishide then
local gfcfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
if gfcfg.spiritroot then
for k,v2 in pairs(gfcfg.spiritroot)do
if lglookup[k]==true then
table.insert(list,gfID)
break
end
end
elseif gfcfg.spiritrootex then
local flag=true
for k,v2 in pairs(gfcfg.spiritrootex)do
if lglookup[k]==nil then
flag=false
break
end
end
if flag then
table.insert(list,gfID)
end
else
table.insert(list,gfID)
end
end
end
end
if#list>0 then
table.insert(taoluList,{tlcfg.name,list})
end
end
end
end
local tl_num=#taoluList
widget:SetChildLayoutGroupCreateItems(4,tl_num)
local tlGrids=widget:GetChildLayoutGroupGridList(4)
for i=1,tlGrids.Count do
local tlWidget=tlGrids[i-1]
local data=taoluList[i]

tlWidget:SetChildText(0,data[1])

local gflist=data[2]
for i3=1,3 do
local gfID=gflist[i3]
local showGf=gfID~=nil
tlWidget:SetChildActive(i3,showGf)
if showGf then
local gfWidget=tlWidget:GetChildWidgetBase(i3)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)

gfWidget:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onClickGF(gfID)
end)
local isActive=UIGongFaModel:isGongFaActive(gfID)

local colorIcon=UIGongFaModel:getGFColorKuangIcon(cfg.color)
gfWidget:SetChildCSImageSprite(0,globalABLookup.cangjingge,colorIcon)
gfWidget:SetChildImageExGray(0,not isActive)

gfWidget:SetChildIcon(1,iconHelper.getGongFaIcon(cfg.icon),true)
gfWidget:SetChildImageExGray(1,not isActive)

local elements=UIGongFaModel:getGFElements(gfID)
local elementid=elements[1]
local elementIcon=ELEMENT_TYPE.getIcon(elementid)
gfWidget:SetChildCSImageSprite(2,globalABLookup.global,elementIcon)
gfWidget:SetChildImageExGray(2,not isActive)

gfWidget:SetChildText(3,cfg.name)

gfWidget:SetChildActive(4,not isActive)
end
end
end
end
end

function UIDiZIGongLueOneWin:onLingGenClick(idx)
local d=self.desclist[idx]
local widget=self.itemsLookup[3]
local item=widget:GetChildLayoutGroupGridItem(0,idx-1)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local cfg=d.cfg or UIDiscipleModel:getSpecialityConfigEx(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,d)

if cfg and UIDiscipleModel.onClickClientSpeciality(item,netData,cfg,eDirectionType.eLeft)then
return
end
local name=d.name
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.disciple_guid,config=cfg,name=name})
end

function UIDiZIGongLueOneWin:onClickGF(gfID)
UIManager:showWindow('UIGongFaTipsFiveWin',{gfID=gfID,showGain=true})
end

function UIDiZIGongLueOneWin:onJumpGF()
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





function UIDiZIGongLueOneWin:refreshFBItem()
local widget=self.itemsLookup[4]
local guid=self.disciple_guid
local hasBuild=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eLianQiGe)~=nil
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eFaBao1)
local isShow=hasBuild and isOpen
local taoluList={}
local tl_num=0
if isShow then
local dzid=self.dzid
local jobcfg=self.jobcfg
if jobcfg.fb_taoluList then
local temp=jobcfg.fb_taoluList[dzid]or jobcfg.fb_taoluList[0]
if temp then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local temp2
for i,v in ipairs(temp)do
if jjlv>=v[1]and jjlv<=v[2]then
temp2=v[3]
break
end
end
if temp2==nil then
temp2=temp[#temp][3]
end
for i,tlid in ipairs(temp2)do
local d=nil
local tlcfg=cfgHelper.get1(cfg_dizivocationtaoluconfig_get,tlid)
if tlcfg.fblist then
for i2=#tlcfg.fblist,1,-1 do
local stage=i2
local sysid=fbStageSystem[stage]
local needjjlv=fabaoConfig.getDressJingjielv(stage)
if jjlv>=needjjlv and systemModel.isOpen(sysid)then
d=tlcfg.fblist[stage]
break
end
end
end
if d~=nil then
table.insert(taoluList,{tlcfg.name,d[1],d[2]})
end
end
end
end
tl_num=#taoluList
isShow=tl_num>0
end
widget:SetChildActive(-1,isShow)
if isShow then
local guid=self.disciple_guid

widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onJumpFB()
end)

local stid,stlv
local equip=equipsHelper.getEquipByDizi(guid,EQUIP_TYPE.eFabao)
if equip then
stid,stlv=fabaoHelper.getShentongid(equip)
end
widget:SetChildLayoutGroupCreateItems(1,tl_num)
local tlGrids=widget:GetChildLayoutGroupGridList(1)
for i=1,tlGrids.Count do
local tlWidget=tlGrids[i-1]
local data=taoluList[i]

tlWidget:SetChildText(0,data[1])

local itemid=data[2]
local conf={itemid=itemid,itemcount='',showCountBG=false,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
tlWidget:SetChildPropData(1,prop)
tlWidget:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

tlWidget:SetChildText(2,itemsConfig.getItemName(itemid))

local stid_=data[3]
local skillCfg=fabaoConfig.getShentongConfig(stid_)
tlWidget:SetChildIcon(3,iconHelper.getSkillIcon(skillCfg.icon),false)

tlWidget:SetChildText(4,skillCfg.name)

tlWidget:SetChildActive(5,stid_==stid)

tlWidget:SetChildButtonClick(6,function()
local args={skillID=stid_,skillLv=stlv or 1,attend=eSkillTipsType.eDZSTSkill,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end)
end
end
end

function UIDiZIGongLueOneWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIDiZIGongLueOneWin:onJumpFB()
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





function UIDiZIGongLueOneWin:refreshDBItem()
local widget=self.itemsLookup[6]
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)
local isShow=isOpen
widget:SetChildActive(-1,isShow)
if isShow then
local guid=self.disciple_guid
local dzid=self.dzid
local jobcfg=self.jobcfg
local tj_daobingList=self.jobcfg.tj_daobingList
local list={}
if tj_daobingList then
local temp=tj_daobingList[dzid]or tj_daobingList[0]
if temp then
for i,itemid in ipairs(temp)do
local has=daobingModel:hasDaoBingRecord(itemid)
local hideflag=itemsConfig.getConfig(itemid).hideflag
if has or(not has and hideflag~=true)then
table.insert(list,itemid)
end
end
end
end
local num=math.min(3,#list)

widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onJumpDaoBing()
end)
widget:SetChildLayoutGroupCreateItems(1,num)
local tlGrids=widget:GetChildLayoutGroupGridList(1)
for i=1,tlGrids.Count do
local tlWidget=tlGrids[i-1]
local itemid=list[i]

local conf={itemid=itemid,itemcount='',showCountBG=false,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
tlWidget:SetChildPropData(0,prop)
tlWidget:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickDBItem(...)
end)

tlWidget:SetChildText(2,itemsConfig.getItemName(itemid))

local isUse=daobingModel:isEquipedOnDiziEx(guid,itemid)
tlWidget:SetChildActive(3,isUse)
end
end
end

function UIDiZIGongLueOneWin:onJumpDaoBing()
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

function UIDiZIGongLueOneWin:onClickDBItem(itemId,index,guid,attach)
attach={starlv=5,jllv=0}
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight,attach=attach})
end





function UIDiZIGongLueOneWin:refreshTZItem()
local guid=self.disciple_guid
local dzid=self.dzid
local jobcfg=self.jobcfg
local widget=self.itemsLookup[5]
local list={}
if jobcfg.tj_taozhuangList then
local temp=jobcfg.tj_taozhuangList[dzid]or jobcfg.tj_taozhuangList[0]
if temp then
local c=#temp
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
for i=c,1,-1 do
local v=temp[i]
if jjlv>=v[1]and jjlv<=v[2]then
list=v[3]
break
end
end
end
end
local n=#list
local isShow=n>0
widget:SetChildActive(-1,isShow)
if isShow then

widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onJumpTZ()
end)
widget:SetChildLayoutGroupCreateItems(1,n)
local tlGrids=widget:GetChildLayoutGroupGridList(1)
for i=1,tlGrids.Count do
local tlWidget=tlGrids[i-1]
local tzid=list[i]
local tzcfg=cfgHelper.get1(cfg_discipleequipsuitconfig_get,tzid)

local iconname=iconHelper.getSuitIcon(tzcfg.icon)
tlWidget:SetChildIcon(0,iconname,false)

tlWidget:SetChildText(1,tzcfg.name)

local desc=FMT.fmt('[2件套]{0}',tzcfg.attr2desc)
desc=FMT.fmt('{0}\n[3件套]{1}',desc,tzcfg.attr3desc)
tlWidget:SetChildText(2,desc)
end
end
end

function UIDiZIGongLueOneWin:onJumpTZ()
local guid=self.disciple_guid
UIManager:invokeUIMethod(self.parentWin,'onCloseBtn')
UIFullDiscipleMainControl:myShowWindow({dis_guid=guid},FULL_TAB_TYPE.eDiscipleEquip)
end


