







def_class("UIAreaUnlockSelectDZWin",UIWindowBase)









function UIAreaUnlockSelectDZWin:bindComponents()

self.btnCommit=UIButton.get(self,0)
self.descTxt=UIText.get(self,1)
self.roleListPanel=UIObject.get(self,2)
self.timeTxt=UIText.get(self,3)
self.txtCommit=UIText.get(self,4)

self.btnCommit:setButtonClick(function()self:onBtnCommit()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIAreaUnlockSelectDZWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnCommit);self.btnCommit=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.txtCommit);self.txtCommit=nil;
end
















local _this=nil




function UIAreaUnlockSelectDZWin:onLoaded(...)
_this=self
self:bindComponents()

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
end


function UIAreaUnlockSelectDZWin:__delete()
_this=nil
self:unbindComponents()
self:clearAllFMTweener()
end




function UIAreaUnlockSelectDZWin:onShow(argtable,afterOnloaded)
self:clearAllFMTweener()
self.parentWin=argtable.parentWin
self.callback=argtable.callback
self.select_dz=nil

self.areaId=argtable.areaId
self.areacfg=cfgHelper.get1(cfg_monijyareaconfig_get,self.areaId)

self.select_index=nil
self:refreshView()
end


function UIAreaUnlockSelectDZWin:onHide()

end

function UIAreaUnlockSelectDZWin:refreshView()
self:refreshScrollView()

local showDesc=self.areacfg.unlock_desc~=nil
self.descTxt:setActive(showDesc)
if showDesc then
self.descTxt:setText(self.areacfg.unlock_desc)
end

local waitTime=self.areacfg.unlock_wait or 0
self.timeTxt:setActive(waitTime>0)
if waitTime>0 then
self.timeTxt:setText(FMT.fmt("探索时间：{0}",timeHelper.format_time_stamp3(waitTime)))
end
end

function UIAreaUnlockSelectDZWin:initDiscipleList()
self.disciplelist={}
local list=UIDiscipleModel:getSortList()
for i,data in ipairs(list)do
local locData={}
locData.disciple=data
local guid=data.discipleguid
local checkCurrent=self.select_dz~=nil and mathHelper.compareInt64(guid,self.select_dz)

local tips=nil
local num1=UIDiscipleModel:getDiscipleDaoHeng(guid)
local num2=UIDiscipleModel:getDiscipleXianMoVoc(guid)
local effectlist={}
local dzNeed=self.areacfg.unlock_dizi
if dzNeed and#dzNeed>0 then
for i,v in ipairs(dzNeed)do
if v[1]==1 then
if num1<v[2]then
if tips==nil then
tips="道行不足"
end
end
elseif v[1]==2 then
if num2==0 then
tips="尚未转职"
elseif v[2]~=0 and num2~=v[2]then
if tips==nil then
if v[1]==1 then
tips="非仙道修士"
elseif v[1]==2 then
tips="非魔道修士"
end
end
end
elseif v[1]==3 then
local speType=v[2]
local speid=v[3]
local spe=UIDiscipleModel:getDiscipleSpecialityByID(guid,speType,speid,true)
if spe then
local specfg=UIDiscipleModel:getSpecialityConfig(speType,speid)
table.insert(effectlist,specfg)
else
if tips==nil then

local speName=UIDiscipleModel:getSpecialityName(speType,speid)
if speType==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
tips=FMT.fmt('需要{0}',speName)
else
tips="不满足条件"
end
end
end
end
end
end
local netData=UIDiscipleModel:getDiscipleData(guid)

local jjlv=netData.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=n
end

locData.desc1=FMT.fmt('<color=#ca631d>境界</color>：{0}',jj_str)
locData.desc2=FMT.fmt('<color=#ca631d>道行</color>：{0}',num2==0 and"无"or num1)
locData.effectlist=effectlist
locData.tips=tips
locData.xianMoVoc=num2
local sorts={}
locData.sorts=sorts
sorts[1]=checkCurrent==true and 1 or 0
if tips==nil then
sorts[2]=1
else
sorts[2]=0
end
sorts[3]=num1
sorts[4]=jjlv
sorts[5]=guid

table.insert(self.disciplelist,locData)
end
end

function UIAreaUnlockSelectDZWin:reSelectDisciple()
if self.select_dz then
local f
for i,v in ipairs(self.disciplelist)do
if mathHelper.compareInt64(v.disciple.discipleguid,self.select_dz)then
f=i
break
end
end
if f then
self.select_index=f
else
self.select_dz=nil
self.select_index=nil
end
else
self.select_index=nil
end
end

function UIAreaUnlockSelectDZWin:refreshScrollView()
self:initDiscipleList()
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
if _this==nil then return end
_this:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()

if#self.disciplelist>0 and not self.select_index then
for i=1,#self.disciplelist do

local flag=self:firstSelectdz(i)
if flag then
break
end
end
end
end

function UIAreaUnlockSelectDZWin:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local xianMoVoc=data.xianMoVoc


local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(6,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

comHelper.setChildModelRawImage(item,guid,1,0,eHeadCenterType.eHalf,nil,false)

local name=UIDiscipleModel:getDiscipleName(guid)
item:SetChildText(2,name)

local xm_str
if xianMoVoc==1 then
xm_str="仙道修士"
elseif xianMoVoc==2 then
xm_str="魔道修士"
else
xm_str="尚未转职"
end
item:SetChildText(16,xm_str)

item:SetChildActive(0,self.select_index==index)

item:SetChildActive(9,false)
item:SetChildActive(10,false)
item:SetChildActive(11,false)


local showDesc1=data.desc1~=nil
item:SetChildActive(14,showDesc1)
if showDesc1 then
item:SetChildText(3,data.desc1)
end
local showDesc2=data.desc2~=nil
item:SetChildActive(15,showDesc2)
if showDesc2 then
item:SetChildText(4,data.desc2)
end


local effectlist=data.effectlist
local showspe=effectlist~=nil and#effectlist>0
item:SetChildActive(5,showspe)
if showspe then
local count=#effectlist
item:SetChildLayoutGroupCreateItems(8,count)
local spegrids=item:GetChildLayoutGroupGridList(8)
for i=1,count do
local speitem=spegrids[i-1]
local effectcfg=effectlist[i]
UIDiscipleModel.refreshSpecialityItemExx(speitem,effectcfg)
speitem:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onDescSlotClick(index,i)
end)
end
end


local tips=data.tips
local showTips=tips~=nil
item:SetChildActive(12,showTips)
if showTips then
item:SetChildText(13,tips)
end


local checkCurrent=data.checkCurrent
item:SetChildActive(7,checkCurrent)
end

function UIAreaUnlockSelectDZWin:onDescSlotClick(disIdx,speIdx)
local data=self.disciplelist[disIdx]
local effects=data.effectlist
local cfg=effects[speIdx]
cfg.specialitytype=cfg.typo
local item=self.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(8,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIAreaUnlockSelectDZWin:refreshSelect(index,flag)
local item=self.grids[index-1]
item:SetChildActive(0,flag)
end

function UIAreaUnlockSelectDZWin:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index

local data=self.disciplelist[index]
if data.tips then
UIManager.error(data.tips)
return
end

self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
if old~=nil then
self:refreshSelect(old,false)
end
self:refreshSelect(index,true)

end

function UIAreaUnlockSelectDZWin:firstSelectdz(index)
if self.select_index==index then return end
local old=self.select_index

local data=self.disciplelist[index]
if data.tips then
return
end

self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
if old~=nil then
self:refreshSelect(old,false)
end
self:refreshSelect(index,true)
return true
end


function UIAreaUnlockSelectDZWin:onBtnCommit()
if self.select_index==nil then
UIManager.error('请选择弟子')
return
end

local data=self.disciplelist[self.select_index]
if data.tips then
return
end

local select_dz=self.select_dz
local callback=self.callback
if callback then
callback(select_dz)
end
self:onClickClose()
end

function UIAreaUnlockSelectDZWin:onClickClose()
self.parentWin:closeSelf()
end

function UIAreaUnlockSelectDZWin:clearFMTweener(mtype)
if self.fmTweener==nil then return end
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UIAreaUnlockSelectDZWin:clearAllFMTweener()
if self.fmTweener then
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self.fmTweener=nil
end
end


