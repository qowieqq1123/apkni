







def_class("UIMDiscipleSelect_Couple2",UIWindowBase)









function UIMDiscipleSelect_Couple2:bindComponents()

self.roleListPanel=UIObject.get(self,0)
self.btnFire=UIButton.get(self,1)
self.btnWork=UIButton.get(self,2)
self.searchInput=UIInputField.get(self,3)
self.selectType=UIObject.get(self,4)
self.condition=UIObject.get(self,5)
self.txtFire=UIText.get(self,6)
self.txtWork=UIText.get(self,7)
self.costTips=UIObject.get(self,8)
self.searchBtn=UIButton.get(self,9)
self.searchCancelBtn=UIButton.get(self,10)
self.condition1=UIText.get(self,11)
self.condition2=UIText.get(self,12)
self.check1=UIImage.get(self,13)
self.check2=UIImage.get(self,14)
self.emptyIcon=UIObject.get(self,15)

self.btnFire:setButtonClick(function()self:onBtnFire()end)

self.btnWork:setButtonClick(function()self:onBtnWork()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIMDiscipleSelect_Couple2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.btnFire);self.btnFire=nil;
_UIObject_release(self.btnWork);self.btnWork=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.selectType);self.selectType=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.txtFire);self.txtFire=nil;
_UIObject_release(self.txtWork);self.txtWork=nil;
_UIObject_release(self.costTips);self.costTips=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.check1);self.check1=nil;
_UIObject_release(self.check2);self.check2=nil;
_UIObject_release(self.emptyIcon);self.emptyIcon=nil;
end



















local _this
local coupleList
local item_cmp_index=
{
img_select=0,
coupleRoot1=1,
coupleRoot2=2,
stateName_1=3,
jobText_1=4,
jobImg_1=5,
blackTx1=6,
blackTx_1=7,
speGrid_1=8,
xiangxi_1=9,
taozhuangGrid_1=10,
black_1=11,
order_1=12,
fightTxt_1=13,
jobRoot_1=14,
up_1=15,
stateObj_1=16,
quguan_1=17,
speBtnGrid_1=18,
jiuzhiBtn_1=19,
colorFrame_1=20,
chuiweiBack_1=21,
head_1=22,
name_1=23,
chuiweiImg_1=24,
tipstxt_1=25,
signIcon_1=26,
curSign_1=27,
exinfo_1=28,
black1=29,
speScrollView_1=30,
fightTxt_2=31,
jiuzhiBtn_2=32,
stateObj_2=33,
order_2=34,
jobRoot_2=35,
xiangxi_2=36,
up_2=37,
taozhuangGrid_2=38,
speBtnGrid_2=39,
black2=40,
black_2=41,
tipstxt_2=42,
curSign_2=43,
signIcon_2=44,
speScrollView_2=45,
name_2=46,
chuiweiImg_2=47,
head_2=48,
chuiweiBack_2=49,
colorFrame_2=50,
exinfo_2=51,
quguan_2=52,
stateName_2=53,
jobText_2=54,
jobImg_2=55,
speGrid_2=56,
blackTx2=57,
blackTx_2=58,
descText1=59,
descText2=60,
descText3=61,
descText4=62,
descText5=63,
descText6=64,
}

local _filtRoomMate=function(bdData,data)
for i,v in ipairs(bdData)do
if v.caveGeziList then
for i,w in ipairs(v.caveGeziList)do
local id=tostring(w.dizi_id)
if id~='0'then
data[id]=v
end
end
elseif v.build_id==SLG_SYSTEM_TYPE.eDaoLv then
coupleList=DiscipleCoupleModel:getCoupleLiveId(tostring(v.un_build_id))
if coupleList then
local id1=tostring(coupleList.dizi_id_1)
if id1~='0'then
data[id1]=v
end
local id2=tostring(coupleList.dizi_id_2)
if id2~='0'then
data[id2]=v
end
end
end
end
end


function UIMDiscipleSelect_Couple2:onLoaded(...)
self:bindComponents()
_this=self
local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end


function UIMDiscipleSelect_Couple2:__delete()
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_Couple2:onShow(argtable,afterOnloaded)
self.args=argtable
self.callback=argtable.callback
self.bdData=argtable.bdData
self.parentWin=argtable.parentWin
self.sfId=mapIdType.zhufeng
self.select_dz=argtable.coupleList

local canvasIdx=argtable.canvasIdx
if canvasIdx then
self:setCanvasIndex(-1,canvasIdx)
end

self.allMultiRoom=zongmenModel:getBuildingDataByBdId(self.sfId,SLG_SYSTEM_TYPE.eDuoRen)
self.allSingleRoom=zongmenModel:getBuildingDataByBdId(self.sfId,SLG_SYSTEM_TYPE.eDanRen)
self.allDaoLvRoom=zongmenModel:getBuildingDataByBdId(self.sfId,SLG_SYSTEM_TYPE.eDaoLv)

self.txtWork:setText('入住')
self:refreshView()
end


function UIMDiscipleSelect_Couple2:onHide()

end


function UIMDiscipleSelect_Couple2.onDiscipleStateChange()
_this:refreshView()
end

function UIMDiscipleSelect_Couple2:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_Couple2:refreshScrollView()
self:initDiscipleList()
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,1,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_Couple2:getNetDataList()
local list=DiscipleCoupleModel:getCoupleList()
if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList_man==nil then
self.nameSearchList_man={}
end
if self.nameSearchList_women==nil then
self.nameSearchList_women={}
end

if list then
for i,v in ipairs(list)do
local netData=v
local guid_str1=tostring(netData.man)
local guid_str2=tostring(netData.woman)
local str1=self.nameSearchList_man[guid_str1]
local str2=self.nameSearchList_women[guid_str2]
local netData1=UIDiscipleModel:getDiscipleData(netData.man)
local netData2=UIDiscipleModel:getDiscipleData(netData.woman)

if str1==nil then
str1=UIDiscipleModel.getSearchName(guid_str1,netData1.disciplename)
self.nameSearchList_man[guid_str1]=str1
end

if str2==nil then
str2=UIDiscipleModel.getSearchName(guid_str2,netData2.disciplename)
self.nameSearchList_women[guid_str2]=str2
end

local d1={v,str1}
local d2={v,str2}
table.insert(temp_search,d1)
table.insert(temp_search,d2)
end
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






function UIMDiscipleSelect_Couple2:initDiscipleList()
local curDz1
local curDz2

if self.select_dz then
curDz1=self.select_dz.dizi_id_1
curDz2=self.select_dz.dizi_id_2
end

self.roomMate={}
_filtRoomMate(self.allMultiRoom,self.roomMate)
_filtRoomMate(self.allSingleRoom,self.roomMate)
_filtRoomMate(self.allDaoLvRoom,self.roomMate)

self.disciplelist={}
local list=self:getNetDataList()

for k,data in ipairs(list)do
local ltlv
local isEccent
local guid1=data.man
local guid2=data.woman

local desclist1=UIDiscipleModel:getDiscipleSpecialityConfig(guid1,true)
local desclist2=UIDiscipleModel:getDiscipleSpecialityConfig(guid2,true)
if self:isHaveEccent(desclist1)or self:isHaveEccent(desclist2)then
isEccent=true
end

local netData1=UIDiscipleModel:getDiscipleData(guid1)
local netData2=UIDiscipleModel:getDiscipleData(guid2)
local ltlv1=netData1.liantilv
local ltlv2=netData2.liantilv

if ltlv1>ltlv2 then
ltlv=ltlv1
else
ltlv=ltlv2
end

local temp={}
local sorts={}
temp.sorts=sorts
temp.disciple=data

if curDz1 and curDz2 then
if curDz1==guid1 and curDz2==guid2 then
temp.current=true
end
else
temp.current=false
end

sorts[1]=ltlv
sorts[2]=isEccent==true and 0 or 1
sorts[3]=data.jingjielv

table.insert(self.disciplelist,temp)
mathHelper.sortWeightList(self.disciplelist)
end

end


function UIMDiscipleSelect_Couple2:isHaveEccent(datas)
for k,v in ipairs(datas)do
if v.typo==4 and v.id==22 then
return true
end
end
return false
end

function UIMDiscipleSelect_Couple2:getEccent(datas)
local list={}
for k,v in ipairs(datas)do
if v.typo==4 and v.id==22 or v.typo==7 then
table.insert(list,v)
end
end
return list
end

function UIMDiscipleSelect_Couple2:reSelectDisciple(default_idx)

default_idx=default_idx or 1
local dzNum=#self.disciplelist
if dzNum>0 then
if self.select_dz~=nil then
local f=nil
for i,v in ipairs(self.disciplelist)do
if mathHelper.compareInt64(v.disciple.man,self.select_dz.man)then
f=i
break
end
end
if f then
self.select_index=f
else
self.select_index=default_idx
end
elseif self.select_index~=nil then
local f=self.disciplelist[self.select_index]
if f==nil then
self.select_index=default_idx
end
else
self.select_index=default_idx
end
else
self.select_index=nil
self.select_dz=nil
end
if self.select_index then
self.select_dz=self.disciplelist[self.select_index].disciple
end
end

function UIMDiscipleSelect_Couple2:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid1=disdata.man
local guid2=disdata.woman

item:SetChildActive(item_cmp_index.curSign_1,data.current)
item:SetChildActive(item_cmp_index.curSign_2,data.current)



local color1=UIDiscipleModel:getDiscipleColor(guid1)
local color2=UIDiscipleModel:getDiscipleColor(guid2)
item:SetChildCSImageSprite(item_cmp_index.colorFrame_1,globalABLookup.diciplecolorframe,discipleColorToFrame[color1])
item:SetChildCSImageSprite(item_cmp_index.colorFrame_2,globalABLookup.diciplecolorframe,discipleColorToFrame[color2])

local chuiwei1=UIDiscipleModel:checkDiscipleState2(guid1,DISCIPLE_STATE_TYPE.eChuiWei)
local chuiwei2=UIDiscipleModel:checkDiscipleState2(guid2,DISCIPLE_STATE_TYPE.eChuiWei)
comHelper.setChildModelRawImage(item,guid1,item_cmp_index.head_1,0,eHeadCenterType.eHalf,nil,chuiwei1)
comHelper.setChildModelRawImage(item,guid2,item_cmp_index.head_2,0,eHeadCenterType.eHalf,nil,chuiwei2)
item:SetChildActive(item_cmp_index.chuiweiImg_1,chuiwei1)
item:SetChildActive(item_cmp_index.jiuzhiBtn_1,chuiwei1)
item:SetChildActive(item_cmp_index.chuiweiImg_2,chuiwei2)
item:SetChildActive(item_cmp_index.jiuzhiBtn_2,chuiwei2)
if chuiwei1 then
local func=function()
UIManager:showWindow('UIDiscipleChuiweiWin',{guid=guid1})
end
item:SetChildButtonClick(item_cmp_index.jiuzhiBtn_1,func,true)
end
if chuiwei2 then
local func=function()
UIManager:showWindow('UIDiscipleChuiweiWin',{guid=guid2})
end
item:SetChildButtonClick(item_cmp_index.jiuzhiBtn_2,func,true)
end

local name1=UIDiscipleModel:getDiscipleName(guid1)
local name2=UIDiscipleModel:getDiscipleName(guid2)
item:SetChildText(item_cmp_index.name_1,name1)
item:SetChildText(item_cmp_index.name_2,name2)

local fight_str1
local fight_str2
local dzData1=UIDiscipleModel:getDiscipleData(guid1)
local dzData2=UIDiscipleModel:getDiscipleData(guid2)


local isShuWuDZ1=dzData1 and UIDiscipleModel:isShuWuDisciple(dzData1.id)
local isShuWuDZ2=dzData2 and UIDiscipleModel:isShuWuDisciple(dzData2.id)

if isShuWuDZ1 then
local shili=UIDiscipleModel:getShuWuFightValue(guid1)
fight_str1=FMT.fmt('<color=#7d3b17>实力</color> {0}',shili)
else
fight_str1=FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:getDiscipleFightValue(guid1))
end

if isShuWuDZ2 then
local shili=UIDiscipleModel:getShuWuFightValue(guid2)
fight_str2=FMT.fmt('<color=#7d3b17>实力</color> {0}',shili)
else
fight_str2=FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:getDiscipleFightValue(guid2))
end

item:SetChildText(item_cmp_index.fightTxt_1,fight_str1)
item:SetChildText(item_cmp_index.fightTxt_2,fight_str2)


item:SetChildActive(item_cmp_index.img_select,self.select_index==index)

if self.args.exInfoFunc then
local text1,text2=self.args.exInfoFunc(disdata)

if text1 then
item:SetChildActive(item_cmp_index.black_1,true)
item:SetChildText(item_cmp_index.blackTx_1,text1)
else
item:SetChildActive(item_cmp_index.black_1,false)
end

if text2 then
item:SetChildActive(item_cmp_index.black_2,true)
item:SetChildText(item_cmp_index.blackTx_2,text2)
else
item:SetChildActive(item_cmp_index.black_2,false)
end
end

local desc1_1=FMT.fmt('境界：<color=#171311>{0}</color>',UIDiscipleModel:getJJNameEx(dzData1.jingjielv))
local desc1_2=FMT.fmt('境界：<color=#171311>{0}</color>',UIDiscipleModel:getJJNameEx(dzData2.jingjielv))


local desc2_1
local desc2_2
local state_title_str='状态'
local state_state_str
local state_color_fmt
local bdData1=self.roomMate[dzData1.discipleguidStr]
local bdData2=self.roomMate[dzData2.discipleguidStr]

if bdData1 then
local bd_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData1.build_id)
state_color_fmt='171311'
state_state_str=bd_cfg.name
desc2_1=FMT.fmt('{0}：<color=#{1}>{2}</color>',state_title_str,state_color_fmt,state_state_str)
else
state_color_fmt='c82c2c'
state_state_str='暂无居所'
desc2_1=FMT.fmt('{0}：<color=#{1}>{2}</color>',state_title_str,state_color_fmt,state_state_str)
end

if bdData2 then
local bd_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData2.build_id)
state_color_fmt='171311'
state_state_str=bd_cfg.name
desc2_2=FMT.fmt('{0}：<color=#{1}>{2}</color>',state_title_str,state_color_fmt,state_state_str)
else
state_color_fmt='c82c2c'
state_state_str='暂无居所'
desc2_2=FMT.fmt('{0}：<color=#{1}>{2}</color>',state_title_str,state_color_fmt,state_state_str)
end

















item:SetChildActive(item_cmp_index.descText1,desc1_1~="")
item:SetChildActive(item_cmp_index.descText2,desc2_1~="")
item:SetChildActive(item_cmp_index.descText4,desc1_2~="")
item:SetChildActive(item_cmp_index.descText5,desc2_2~="")

item:SetChildText(item_cmp_index.descText1,desc1_1 or"")
item:SetChildText(item_cmp_index.descText2,desc2_1 or"")
item:SetChildText(item_cmp_index.descText4,desc1_2 or"")
item:SetChildText(item_cmp_index.descText5,desc2_2 or"")

local desclist1=UIDiscipleModel:getDiscipleSpecialityConfig(guid1,true)
local desclist2=UIDiscipleModel:getDiscipleSpecialityConfig(guid2,true)

local eccent_effect1=self:getEccent(desclist1)
local eccent_effect2=self:getEccent(desclist2)


if eccent_effect1~=nil and#eccent_effect1>0 then
item:SetChildActive(item_cmp_index.speScrollView_1,true)

local count=#eccent_effect1
item:SetChildLayoutGroupCreateItems(item_cmp_index.speGrid_1,count)
local spegrids=item:GetChildLayoutGroupGridList(item_cmp_index.speGrid_1)
for i=1,count do
local speitem=spegrids[i-1]
local effectcfg=eccent_effect1[i]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index.speGrid_1,i-1)
UIDiscipleModel.refreshSpecialityItemExx(speitem,effectcfg)
speitem:SetChildButtonClick(1,function()
self.onDescSlotClick(i,guid1,eccent_effect1,speitem)
end)
end
item:SetChildScrollRectEnable(item_cmp_index.speScrollView_1,count>=3)
else
item:SetChildActive(item_cmp_index.speScrollView_1,false)
item:SetChildText(item_cmp_index.tipstxt_1,'')
end

if eccent_effect2~=nil and#eccent_effect2>0 then
item:SetChildActive(item_cmp_index.speScrollView_2,true)

local count=#eccent_effect2
item:SetChildLayoutGroupCreateItems(item_cmp_index.speGrid_2,count)
local spegrids=item:GetChildLayoutGroupGridList(item_cmp_index.speGrid_2)
for i=1,count do
local speitem=spegrids[i-1]
local effectcfg=eccent_effect2[i]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index.speGrid_2,i-1)
UIDiscipleModel.refreshSpecialityItemExx(speitem,effectcfg)
speitem:SetChildButtonClick(1,function()
self.onDescSlotClick(i,guid1,eccent_effect2,speitem)
end)
end
item:SetChildScrollRectEnable(item_cmp_index.speScrollView_2,count>=3)
else
item:SetChildActive(item_cmp_index.speScrollView_2,false)
item:SetChildText(item_cmp_index.tipstxt_2,'')
end
end


function UIMDiscipleSelect_Couple2.onDescSlotClick(speIdx,guid,build_effects,speitem)
if _this==nil then return end
local effects=build_effects
local cfg=effects[speIdx]
local speitem=speitem
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=guid,config=cfg})
end


function UIMDiscipleSelect_Couple2:refreshSelect(index,flag)
local item=self.grids[index-1]
item:SetChildActive(item_cmp_index.img_select,flag)
end

function UIMDiscipleSelect_Couple2:onClickItem(index)
if self.select_index==index then return end

local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_Couple2:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local checkCurrent=data.current
self.btnFire:setActive(checkCurrent)
self.btnWork:setActive(not checkCurrent)
else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end



function UIMDiscipleSelect_Couple2:onBtnFire()

local list={man=int64.new(0),woman=int64.new(0)}
self.callback(list)
end


function UIMDiscipleSelect_Couple2:onBtnWork()
local dzData1=UIDiscipleModel:getDiscipleData(self.select_dz.man)
local dzData2=UIDiscipleModel:getDiscipleData(self.select_dz.woman)
if dzData1:check_in()or dzData2:check_in()then
local show_data={
type='UIDialouge',
title='提示',
content='入住道侣洞府会退出已入住的房舍，\n是否继续？',
oktext='确定',
canceltext='取消',
okcallback=function()
self.callback(self.select_dz)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self.callback(self.select_dz)
end
end


function UIMDiscipleSelect_Couple2:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()
if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:refreshView()
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
local list=self:getNetDataList()
if#list<=0 then
self.inputstr=nil
UIManager.info('宗门查无此人')
return
end
self.searchInput:setInputFieldValue('')
self:refreshView()
end

function UIMDiscipleSelect_Couple2:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_Couple2:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end


function UIMDiscipleSelect_Couple2:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_Couple2:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end