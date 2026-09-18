







def_class("UICourtroomDiscipleSelect",UIWindowBase)









function UICourtroomDiscipleSelect:bindComponents()

self.specialityPanel=UIObject.get(self,0)
self.scrollview=UIObject.get(self,1)
self.txtFight=UIText.get(self,2)
self.sortTypeMenu=UIDropdown.get(self,3)
self.btnFire=UIButton.get(self,4)
self.btnWork=UIButton.get(self,5)
self.txtWork=UIText.get(self,6)
self.scrollview2=UIObject.get(self,7)

self.btnFire:setButtonClick(function()self:onBtnFire()end)

self.btnWork:setButtonClick(function()self:onBtnWork()end)



end


function UICourtroomDiscipleSelect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.specialityPanel);self.specialityPanel=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.txtFight);self.txtFight=nil;
_UIObject_release(self.sortTypeMenu);self.sortTypeMenu=nil;
_UIObject_release(self.btnFire);self.btnFire=nil;
_UIObject_release(self.btnWork);self.btnWork=nil;
_UIObject_release(self.txtWork);self.txtWork=nil;
_UIObject_release(self.scrollview2);self.scrollview2=nil;
end


















local _this

local _sort_type={
eFight=1,
eTalent=2,
eStrange=3,
}

local _sort_type_name={
[_sort_type.eFight]="战力顺序",
[_sort_type.eTalent]="天赋数量顺序",
[_sort_type.eStrange]="怪癖数量顺序",
}

local _item_cmp_index={
img_select=0,
img_icon=1,
txt_name=2,
txt_fight=3,
btn_Gift=4,
img_tuijian=5,
sign_Icon=6,
btn_Strange=7,
}

local _sort_func=function(a,b)
return a.sort_score>b.sort_score
end


function UICourtroomDiscipleSelect:onLoaded(...)
self:bindComponents()
_this=self
self.sortTypeMenu:setChangeAction(function(id)
self:onDropDownChange(id)
end)
self.scrollview:setChildScrollViewInit(0.5,true,function(clicknum,i)
self:onClickItem(i+1)
end,nil)
end


function UICourtroomDiscipleSelect:__delete()
self:unbindComponents()
_this=nil
end




function UICourtroomDiscipleSelect:onShow(argtable,afterOnloaded)
self.selecteduid=argtable
self.datas={}
local dzArray=self:getDiscipleDatas()

local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJielu)or{}
if#dis_list>0 then
local ddata=dis_list[1]
self.zlguid=ddata.discipleguid
end

for i,data in ipairs(dzArray)do
local net=data.netData.net
if net.discipleguid~=self.zlguid then
local locData={uid=net.discipleguid,uidStr=tostring(net.discipleguid),name=net.disciplename,check_in=net:check_in()}
locData.fight=UIDiscipleModel:getDiscipleFightValue(locData.uid)
local configs=UIDiscipleModel:getDiscipleSpecialityConfig(locData.uid)
local talentList={}
local strangeList={}
for _,v in ipairs(configs)do
if v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eTalent then
table.insert(talentList,v)
end
if v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eStrange then
table.insert(strangeList,v)
end
end
locData.talentList=talentList
locData.strangeList=strangeList
locData.score_talent=#talentList
locData.score_strange=#strangeList
table.insert(self.datas,locData)
end
end

self.sortTypeMenu:setOption(_sort_type_name)
self.sortType=_sort_type.eFight
self.sortTypeMenu:setValue(self.sortType-1)
self:refreshScrollView()
self:onClickItem(1)


end


function UICourtroomDiscipleSelect:onHide()

end

function UICourtroomDiscipleSelect:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
table.insert(list,v)
end
end
return list
end

function UICourtroomDiscipleSelect:refreshScrollView()
self.fight_score=self.sortType==_sort_type.eFight and 10000 or 0
self.talent_score=self.sortType==_sort_type.eTalent and 10000 or 1
self.strange_score=self.sortType==_sort_type.eStrange and 10000 or 1
for i,v in ipairs(self.datas)do
v.sort_score=self:getSortScore(v)
end
table.sort(self.datas,function(a,b)
return self.sortList(a.sort_score,b.sort_score,self.sortOrder)
end)
self.scrollview:setChildScrollViewDelayCreateGrids(#self.datas,1,0.02,1,false,false,function(id,item)
if self.refreshItem~=nil then
self:refreshItem(id,item)
end
end)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
end

function UICourtroomDiscipleSelect:refreshItem(id,item)
local index=id+1
local data=self.datas[index]
comHelper.setChildHead(item,data.uid,_item_cmp_index.img_icon)
item:SetChildActive(_item_cmp_index.img_select,self.select_index==index)
item:SetChildText(_item_cmp_index.txt_name,data.name)
item:SetChildText(_item_cmp_index.txt_fight,mathHelper.formatNumber(data.fight))
item:SetChildButtonClickWithID(_item_cmp_index.btn_Gift,function(index)
self:onClickSpeciality(index,DISCIPLE_SPECIALITY_TYPE.eTalent)
end,index)
item:SetChildButtonClickWithID(_item_cmp_index.btn_Strange,function(index)
self:onClickSpeciality(index,DISCIPLE_SPECIALITY_TYPE.eStrange)
end,index)
end

function UICourtroomDiscipleSelect:onClickSpeciality(index,eSpecialityType)
local datas
local name=''
if eSpecialityType==DISCIPLE_SPECIALITY_TYPE.eTalent then
datas=self.datas[index].talentList
name='天赋列表'
elseif eSpecialityType==DISCIPLE_SPECIALITY_TYPE.eStrange then
datas=self.datas[index].strangeList
name='怪癖列表'
end
if datas then
UIManager:showWindow('UICourtroomSpecialityScrollViewWin',{datas=datas,name=name,guid=datas.uid})
end
end

function UICourtroomDiscipleSelect.sortList(a,b,sortOrder)
if sortOrder then
return a<b
else
return a>b
end
end

function UICourtroomDiscipleSelect:getSortScore(loc)
return(loc.fight or 0)*self.fight_score+(loc.score_talent or 0)*self.talent_score+(loc.score_strange or 0)*self.strange_score
end

function UICourtroomDiscipleSelect:onDropDownChange(id)
self.sortType=id+1
self:refreshScrollView()
end

function UICourtroomDiscipleSelect:refreshSelect(index)
local item=self.grids[index-1]
item:SetChildActive(_item_cmp_index.img_select,self.select_index==index)
end

function UICourtroomDiscipleSelect:onClickItem(index)
if index<=self.grids.Count then
self.select_index=index
self:refreshSelect(index)
if self.last_select_index then
self:refreshSelect(self.last_select_index)
end
self.last_select_index=self.select_index
local data=self.datas[self.select_index]
if self.selecteduid and data.uid==self.selecteduid then
self.btnFire:setActive(true)
self.btnWork:setActive(false)
else
self.btnFire:setActive(false)
self.btnWork:setActive(true)
end
end
end

function UICourtroomDiscipleSelect:onClickClose()
if not self.wait_replace_building_mgr then
self:closeSelf()
end
end

function UICourtroomDiscipleSelect:onClickSort()
self.sortOrder=not self.sortOrder
self:refreshScrollView()
end





function UICourtroomDiscipleSelect:onBtnFire()
UIManager:invokeUIMethod('UICourtroomMainWin','selectDisciple')
UIManager:closeWindow("UICourtroomDiscipleSelect")
end



function UICourtroomDiscipleSelect:onBtnWork()
if self.select_index then
local data=self.datas[self.select_index]
UIManager:invokeUIMethod('UICourtroomMainWin','selectDisciple',data.uid)
UIManager:closeWindow("UICourtroomDiscipleSelect")
end
end

