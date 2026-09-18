







def_class("UISectPalacePostInfoWin",UIWindowBase)









function UISectPalacePostInfoWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.colText1=UIText.get(self,1)
self.colText2=UIText.get(self,2)
self.colText3=UIText.get(self,3)
self.descPanel=UIObject.get(self,4)
self.descText=UIText.get(self,5)
self.hideToggle=UIToggleButton.get(self,6)
self.leaveBtn=UIButton.get(self,7)
self.postBtn=UIButton.get(self,8)
self.postlist=UIObject.get(self,9)
self.searchBtn=UIButton.get(self,10)
self.searchCancelBtn=UIButton.get(self,11)
self.searchInput=UIInputField.get(self,12)
self.sortTypeDropdown=UIDropdownEx.get(self,13)
self.titleText=UIText.get(self,14)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UISectPalacePostInfoWin")end)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)

self.postBtn:setButtonClick(function()self:onPostBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)



end


function UISectPalacePostInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.colText1);self.colText1=nil;
_UIObject_release(self.colText2);self.colText2=nil;
_UIObject_release(self.colText3);self.colText3=nil;
_UIObject_release(self.descPanel);self.descPanel=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.hideToggle);self.hideToggle=nil;
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
_UIObject_release(self.postBtn);self.postBtn=nil;
_UIObject_release(self.postlist);self.postlist=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end
















local titleAttr={'境界','立场','炼体','机缘','魅力','聪慧'}
local sortTypeAttr={eDiscipleSortType.eJingJieSort,nil,eDiscipleSortType.eLianTiSort,eDiscipleSortType.eJiYuan,eDiscipleSortType.eMeiLi,eDiscipleSortType.eCongHui}

local _dropItemHeight=40
local _dropViewHeight=210

local _this=nil


function UISectPalacePostInfoWin:onLoaded(...)
_this=self
self:bindComponents()
local _onClickPostItem=function(...)
self:onClickPostItem(...)
end
self.postlist:setChildScrollViewInit(0,true,_onClickPostItem,nil)

local defaultHide=userActorSetting.get('sectPalacePostInfoHide',true)
self.hideToggle:setToggle(defaultHide)
local func=function(...)
if _this==nil then return end
_this:onHideToggleChange(...)
end
self.hideToggle:setToggleChange(func)

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.searchInput:setChildInputFieldChange(true,function(...)
if _this==nil then return end
_this:onSearchChange(...)
end)
end


function UISectPalacePostInfoWin:__delete()
self:unbindComponents()
_this=nil
end


function UISectPalacePostInfoWin:onHide()

end




function UISectPalacePostInfoWin:onShow(argtable,afterOnloaded)
self.postType=argtable.postType
self.dis_guid=argtable.dis_guid
self.has_dis=self.dis_guid~=nil

self.curSelect=1
self:refreshTitle()
self:refreshPostList()
self:refreshInfo()
end

function UISectPalacePostInfoWin:refreshTitle()
self.sortTypeList={sortTypeAttr[1]}
local title_str=FMT.fmt('{0}委任',eZongMenPostType.getName(self.postType))
self.titleText:setText(title_str)

if self.postType==eZongMenPostType.eZhangMen then

self.colText1:setText(titleAttr[1])
self.colText2:setActive(false)
self.colText3:setActive(false)
elseif self.postType==eZongMenPostType.eJielu then

self.colText1:setText(titleAttr[1])
self.colText2:setText(titleAttr[6])
self.colText3:setText(titleAttr[2])
self.colText3:setActive(true)
table.insert(self.sortTypeList,sortTypeAttr[6])
elseif self.postType==eZongMenPostType.eChuanGong then

self.colText1:setText(titleAttr[1])
self.colText2:setText(titleAttr[3])
self.colText3:setActive(false)
table.insert(self.sortTypeList,sortTypeAttr[3])
elseif self.postType==eZongMenPostType.eJieYin then

self.colText1:setText(titleAttr[1])
self.colText2:setText(titleAttr[5])
self.colText3:setActive(false)
table.insert(self.sortTypeList,sortTypeAttr[5])
elseif self.postType==eZongMenPostType.eZhenYu then

self.colText1:setText(titleAttr[1])
self.colText2:setText(titleAttr[6])
self.colText3:setText(titleAttr[5])
self.colText3:setActive(true)
table.insert(self.sortTypeList,sortTypeAttr[6])
table.insert(self.sortTypeList,sortTypeAttr[5])
elseif self.postType==eZongMenPostType.eNeiMen then

self.colText1:setText(titleAttr[1])
self.colText2:setActive(false)
self.colText3:setActive(false)
end

local cfg=cfgHelper.get1(cfg_guildposconfig_get,self.postType)
if self.postType==eZongMenPostType.eZhenYu then
local text=FMT.fmt("增益：{0}，镇狱长老境界越高，俘虏越难逃脱",cfg.effects_desc)
self.descText:setText(text)
else
local text=FMT.fmt("增益：{0}",cfg.effects_desc)
self.descText:setText(text)
end
local sortTypeNamesList=eDiscipleSortTypeName:getName2List2(self.sortTypeList)
self.sortTypeDropdown:setOption(sortTypeNamesList)

self.sortTypeIndex=1

self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false
end

function UISectPalacePostInfoWin:refreshPostList(init)
local oldnum=0
if self.postDataList~=nil then
oldnum=#self.postDataList
end
self:getPostDataList()
local dataNum=#self.postDataList
if not init then
if oldnum~=dataNum then
self.postlist:setChildScrollViewCreateGrids(dataNum,1)
self.curSelect=1
end
else
self.postlist:setChildScrollViewCreateGrids(dataNum,1)
end
local grids=self.postlist:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local netData=self.postDataList[i].netData.net
local guid=netData.discipleguid
local isSelfPost=mathHelper.compareInt64(guid,self.dis_guid)
local showSp=false
local showSpData



comHelper.setChildModelHeadIconBG(item,7,guid)

comHelper.setChildModelRawImage(item,guid,0,0,eHeadCenterType.eHead)

item:SetChildText(1,UIDiscipleModel:getDiscipleName(guid)or'')

if self.postType==eZongMenPostType.eZhangMen then

item:SetChildText(2,UIDiscipleModel:getJJNameEx(netData.jingjielv))
item:SetChildActive(3,false)
item:SetChildActive(9,false)
elseif self.postType==eZongMenPostType.eJielu then

local value=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
item:SetChildText(2,UIDiscipleModel:getJJNameEx(netData.jingjielv))
item:SetChildText(3,FMT.fmt('{0}',value))
item:SetChildText(9,cfgHelper.get2(cfg_disciplestandconfig_get,netData.stand,'name'))
item:SetChildActive(9,true)

local showspecialityid=cfgHelper.get2(cfg_lvfatangconfig_get,1,'showspecialityid')
local list=UIDiscipleModel.checkCompareSpecialList(guid,showspecialityid)
if#list>0 then
showSp=true
showSpData=list[1]
end

elseif self.postType==eZongMenPostType.eChuanGong then

item:SetChildText(2,UIDiscipleModel:getJJNameEx(netData.jingjielv))
item:SetChildText(3,FMT.fmt('{0}({1})',UIDiscipleModel:getLTName(netData.liantilv),netData.liantilv))
item:SetChildActive(9,false)
elseif self.postType==eZongMenPostType.eJieYin then

local numMeiLi=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
if isSelfPost then
local lookup=UISectPalaceModel:getPostEffect6Attr(self.postType)
local num=lookup[DISCIPLE_BASE_ATTR_TYPE.eMeiLi]
if num then
numMeiLi=numMeiLi-num
end
end
item:SetChildText(2,UIDiscipleModel:getJJNameEx(netData.jingjielv))
item:SetChildText(3,numMeiLi)
item:SetChildActive(9,false)
elseif self.postType==eZongMenPostType.eZhenYu then

local numCongHui=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
local numMeiLi=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
local level_level_str=UIDiscipleModel:getJJNameEx(netData.jingjielv)

if isSelfPost then
local lookup=UISectPalaceModel:getPostEffect6Attr(self.postType)
local num1=lookup[DISCIPLE_BASE_ATTR_TYPE.eCongHui]
if num1 then
numCongHui=numCongHui-num1
end
local num2=lookup[DISCIPLE_BASE_ATTR_TYPE.eMeiLi]
if num2 then
numMeiLi=numMeiLi-num2
end
end
item:SetChildText(2,level_level_str)
item:SetChildText(3,numCongHui)
item:SetChildText(9,numMeiLi)
item:SetChildActive(9,true)
elseif self.postType==eZongMenPostType.eNeiMen then

item:SetChildText(2,UIDiscipleModel:getJJNameEx(netData.jingjielv))
item:SetChildActive(3,false)
item:SetChildActive(9,false)
end

local pos=netData.pos
if pos==0 then
pos=eZongMenPostType.eWaiMen
end
item:SetChildText(4,eZongMenPostType.getName(pos))

item:SetChildActive(5,isSelfPost)

local isselect=self.curSelect==i
self:refreshPostItemSelect(item,isselect)

item:SetChildActive(8,showSp)
if showSp then
local tzItem=item:GetChildWidgetBase(8)
local cfg=UIDiscipleModel:getSpecialityConfig(showSpData[1],showSpData[2])
UIDiscipleModel.refreshSpecialityItem(tzItem,cfg,function()
UIManager:showWindow('UISpecialityWin',{item=tzItem,node='bottom',guid=guid,config=cfg})
end)
end
end
end

function UISectPalacePostInfoWin:refreshPostItemSelect(item,isselect)
local selecticon
if isselect then
selecticon='frame_tyjlchuangkou_4'
else
selecticon='frame_tyjlchuangkou_3'
end
item:SetChildCSImageSprite(6,globalABLookup.global,selecticon)
end

function UISectPalacePostInfoWin:getDiscipleList()
local lookup=UIDiscipleModel:getAllDiscipleDataX()
local list={}
if lookup then
for k,v in pairs(lookup)do
local netData=v.netData.net
local add=false
if self.postType==eZongMenPostType.eNeiMen then

if netData.pos==eZongMenPostType.eWaiMen then

add=true
elseif netData.pos==eZongMenPostType.eNeiMen then


if self.has_dis then
if mathHelper.compareInt64(netData.discipleguid,self.dis_guid)then
add=true
end
end
end
else
add=true
end
if add then

local hide=self.hideToggle:getToggle()
if hide then
if not mathHelper.compareInt64(netData.discipleguid,self.dis_guid)and netData.pos~=eZongMenPostType.eWaiMen and netData.pos~=eZongMenPostType.eNeiMen then
add=false
end
end
end
if add then
list[#list+1]=v
end
end
end
if#list>1 then
local sortParams={}
local sortType=self.sortTypeList[self.sortTypeIndex]
discipleLookup:sortList(list,{sortType,eDiscipleSortType.eColorSort},self.sortOrder,sortParams)































































































end
return list
end

function UISectPalacePostInfoWin:getPostDataList()

local list=self:getDiscipleList()

self.postDataList=list

if self.inputstr~=nil then
self.postDataList=self:getSearchDiscipleList()
end
end

function UISectPalacePostInfoWin:speSort(a,b)
local va=mathHelper.compareInt64(a.discipleguid,self.dis_guid)and 1 or 0
local vb=mathHelper.compareInt64(b.discipleguid,self.dis_guid)and 1 or 0
if va==1 or vb==1 then
return true,va>vb
end
return false,false
end

function UISectPalacePostInfoWin:lastSort(a,b)
local imageInfo_a=UIDiscipleModel:getDiscipleImageInfoEx(a)
local color_a=imageInfo_a.color
local imageInfo_b=UIDiscipleModel:getDiscipleImageInfoEx(b)
local color_b=imageInfo_b.color
return color_a>color_b
end

function UISectPalacePostInfoWin:hasDZ()
return#self.postDataList>0
end

function UISectPalacePostInfoWin:refreshInfo()
local c=#self.postDataList
if c>0 then
local netData=self.postDataList[self.curSelect].netData.net
local pos=netData.pos
if pos==0 then
pos=eZongMenPostType.eWaiMen
end
local curInPost=mathHelper.compareInt64(netData.discipleguid,self.dis_guid)
self.leaveBtn:setActive(curInPost)
self.postBtn:setActive(not curInPost)
else
self.leaveBtn:setActive(false)
self.postBtn:setActive(false)
end
end

function UISectPalacePostInfoWin:onClickPostItem(clicknum,index)
index=index+1
if self.curSelect==index then return end
if self.curSelect~=nil then

local old=self.postlist:getChildScrollViewItemWidget(self.curSelect-1)
self:refreshPostItemSelect(old,false)
end
self.curSelect=index
local item=self.postlist:getChildScrollViewItemWidget(self.curSelect-1)
self:refreshPostItemSelect(item,true)

self:refreshInfo()
end


function UISectPalacePostInfoWin:onPostBtn()
local netData=self.postDataList[self.curSelect].netData.net
local pos=netData.pos
if pos==0 then
pos=eZongMenPostType.eWaiMen
end
if pos==self.postType then return end
if mathHelper.compareInt64(netData.discipleguid,self.dis_guid)then return end
if not self.has_dis then
local curlist=UIDiscipleModel:getDiscipleByZongMenPost(self.postType)or{}
local max=cfgHelper.get2(cfg_guildposconfig_get,self.postType,'max_cnt')
if max~=nil then
if#curlist>=max then
return
end
end
end

if(pos==eZongMenPostType.eZhangMen or eZongMenPostType:isZhangLao(pos))then
local p_name1=eZongMenPostType.getName(pos)
local p_name2=eZongMenPostType.getName(self.postType)
local content=FMT.fmt(cfgHelper.get1(cfg_lang_get,'sectpalace_tips_1'),
netData.disciplename,p_name1,p_name2)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定委任',
canceltext='容我三思',
okcallback=function()
if _this==nil then return end
_this:setPost()
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()

AudioManager.playBtnClick()
else
self:setPost()
end
end

function UISectPalacePostInfoWin:setPost()
if self.has_dis and self.postType~=eZongMenPostType.eWaiMen then
UISectPalaceController:reqPost(self.dis_guid,eZongMenPostType.eWaiMen)
end
local netData=self.postDataList[self.curSelect].netData.net
UISectPalaceController:reqPost(netData.discipleguid,self.postType)
if self.postType==eZongMenPostType.eZhangMen or self.postType==eZongMenPostType.eJielu or self.postType==eZongMenPostType.eChuanGong or self.postType==eZongMenPostType.eJieYin or self.postType==eZongMenPostType.eZhenYu then
roleAudioController:playRoleSpeak(netData.discipleguid,roleAudioNodeType.AnPaiZhiWei)
end
self:closeSelf()
end


function UISectPalacePostInfoWin:onLeaveBtn()
local netData=self.postDataList[self.curSelect].netData.net
local pos=netData.pos
if pos==0 then
pos=eZongMenPostType.eWaiMen
end
if pos~=self.postType then return end
UISectPalaceController:reqPost(netData.discipleguid,eZongMenPostType.eWaiMen)

self:closeSelf()
end

function UISectPalacePostInfoWin:onHideToggleChange(name,ison)
userActorSetting.flushVal('sectPalacePostInfoHide',ison,true)
self:refreshPostList()
end



function UISectPalacePostInfoWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then

self:refreshPostList(true)
else
UIManager.info('请输入搜索内容')
end
return
end
if self.inputstr==inputstr then
return
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含敏感字符')
return
end
self.inputstr=inputstr
local list=self:getSearchDiscipleList()
if#list<=0 then

UIManager.info('暂无符合条件的弟子')
return
end
local selectDzData=self.postDataList[self.curSelect]
self.curSelect=1
if selectDzData then
for index,dzData in ipairs(list)do
if dzData.discipleguidStr==selectDzData.discipleguidStr then
self.curSelect=index
break
end
end
end

self.searchInput:setInputFieldValue('')
self:refreshPostList(true)
self:refreshInfo()
end

function UISectPalacePostInfoWin:onSearchCancelBtn()
if self.inputstr==nil then return end
self.inputstr=nil
self:clearSearchInput()

local list=self:getSearchDiscipleList()
local selectDzData=self.postDataList[self.curSelect]
self.curSelect=1
if selectDzData then
for index,dzData in ipairs(list)do
if dzData.discipleguidStr==selectDzData.discipleguidStr then
self.curSelect=index
break
end
end
end
self:refreshPostList(true)
self:refreshInfo()
end

function UISectPalacePostInfoWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function UISectPalacePostInfoWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UISectPalacePostInfoWin:clearSearchInput()

local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UISectPalacePostInfoWin:getSearchDiscipleList()
local list=self:getDiscipleList()

if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do
local netData=v.netData.net
local guid_str=netData.discipleguidStr
local str=self.nameSearchList[guid_str]
if str==nil then
local stateStr=UIDiscipleModel:getDiscipleStateDesc(netData.discipleguid,' ')
str=UIDiscipleModel.getSearchName(guid_str,netData.disciplename,stateStr)
self.nameSearchList[guid_str]=str
end
local d={v,str}
table.insert(temp_search,d)
end

if#temp_search>0 then
for i,v in ipairs(temp_search)do
local str=v[2]
if string.find(str,self.inputstr)then
table.insert(temp,v[1])
end
end
end
return temp
else
return list
end
end

function UISectPalacePostInfoWin:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
self.sortTypeIndex=idx

self:clearSearchInput()
self:refreshPostList()
self:refreshInfo()
end

function UISectPalacePostInfoWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:refreshPostList()
self:refreshInfo()
end