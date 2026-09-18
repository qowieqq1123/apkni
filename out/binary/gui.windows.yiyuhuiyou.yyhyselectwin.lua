







def_class("YYHYSelectWin",UIWindowBase)









function YYHYSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.testRoot=UIObject.get(self,1)
self.roleListPanel=UIObject.get(self,2)
self.sortTypeDropdown=UIDropdown.get(self,3)
self.discipleNumText=UIText.get(self,4)
self.searchInput=UIInputField.get(self,5)
self.noDZTips=UIObject.get(self,6)
self.kickoutBtn=UIButton.get(self,7)
self.searchBtn=UIButton.get(self,8)
self.searchCancelBtn=UIButton.get(self,9)
self.kickoutLock=UIObject.get(self,10)
self.yuertext1=UIText.get(self,11)
self.yuertext2=UIText.get(self,12)
self.fbSlot1=UIBaseItem.get(self,13)
self.yugan=UIObject.get(self,14)
self.yugantext=UIText.get(self,15)
self.yuxian=UIObject.get(self,16)
self.yuxiantext=UIText.get(self,17)
self.yugou=UIObject.get(self,18)
self.yugoutext=UIText.get(self,19)
self.yujuxiaoguotext=UIText.get(self,20)
self.descListPanel=UIObject.get(self,21)
self.closebtn=UIButton.get(self,22)
self.querenbtn=UIButton.get(self,23)
self.onchange=UIButton.get(self,24)

self.kickoutBtn:setButtonClick(function()self:onKickoutBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.querenbtn:setButtonClick(function()self:onQuerenbtn()end)

self.onchange:setButtonClick(function()self:onOnchange()end)



end


function YYHYSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.testRoot);self.testRoot=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.discipleNumText);self.discipleNumText=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.noDZTips);self.noDZTips=nil;
_UIObject_release(self.kickoutBtn);self.kickoutBtn=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.kickoutLock);self.kickoutLock=nil;
_UIObject_release(self.yuertext1);self.yuertext1=nil;
_UIObject_release(self.yuertext2);self.yuertext2=nil;
_UIObject_release(self.fbSlot1);self.fbSlot1=nil;
_UIObject_release(self.yugan);self.yugan=nil;
_UIObject_release(self.yugantext);self.yugantext=nil;
_UIObject_release(self.yuxian);self.yuxian=nil;
_UIObject_release(self.yuxiantext);self.yuxiantext=nil;
_UIObject_release(self.yugou);self.yugou=nil;
_UIObject_release(self.yugoutext);self.yugoutext=nil;
_UIObject_release(self.yujuxiaoguotext);self.yujuxiaoguotext=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.querenbtn);self.querenbtn=nil;
_UIObject_release(self.onchange);self.onchange=nil;
end
















local _this=nil

local abname_yyhy='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'
local yujuimgname=
{
[1]='image_yiyuhuiyound_',
[2]='image_yiyuhuiyound_',
[3]='image_yiyuhuiyound_',
}


function YYHYSelectWin:onLoaded(...)
self:bindComponents()
_this=self
local _OnClickRoleItemCallback=function(...)

end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)

notifySystem:listenNotify(notifyConfig.onTestModelChange,self.onTestModelChange)



end


function YYHYSelectWin:__delete()
self:unbindComponents()
_this=nil

self:clearAllDZNewSign()

notifySystem:removelistener(notifyConfig.onTestModelChange,self.onTestModelChange)
end

function YYHYSelectWin.onTestModelChange(flag)
if _this==nil then return end

_this:showTestRoot()
end

function YYHYSelectWin:showTestRoot()
local show=false



show=show and playerController.testModel
self.testRoot:setActive(show)
end

function YYHYSelectWin:onHide()
self.nameSearchList=nil
self:clearAllDZNewSign()
end

function YYHYSelectWin:clearAllDZNewSign()

if self.hasNewDZ==true and self.clickDZClose~=true then
UIDiscipleModel:clearAllDZNewSign()
end
self.hasNewDZ=nil
self.clickDZClose=nil
end

function YYHYSelectWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end




function YYHYSelectWin:onShow(argtable,afterOnloaded)
if argtable then
self.isqiehuan=true
else
self.isqiehuan=false
end
argtable=argtable or{}

self.param={}
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end
self.sortTypeDropdown:setOption(eDiscipleSortTypeName:getName2List())
if argtable.sortType~=nil then
self.sortType=argtable.sortType
UIDiscipleModel:setSaveSortType(self.sortType)
else
self.sortType=eDiscipleSortType.eFightSort
end
local recordSortCondition=argtable.recordSortCondition
if recordSortCondition==true then
self.sortCondition=UIDiscipleModel:getSaveSortCondition()
else
local sortCondition={}
self.sortCondition=sortCondition
UIDiscipleModel:setSaveSortCondition(sortCondition)
end
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortType-1)
self.lockRefresh=false

local recordIInputstr=argtable.recordIInputstr
if recordIInputstr~=nil then
self.inputstr=recordIInputstr
else
self.inputstr=nil
end

self:initRoleListPanel()






end







































function YYHYSelectWin:onChangeItemClick(itemid)
UIManager:showWindow('YYHYGainWin')
end




function YYHYSelectWin:onWinItemClick(itemid)
local itemid=YiYuHuiYouModel:getXianLuId()
if itemid~=0 then
tipsManager.showTips({itemid=itemid,itemguid=nil})
else
UIManager:showWindow('YYHYGainWin')
end
end


function YYHYSelectWin:refreshFBYuErSlot()

_this.fbSlot1:setBaseItemClickEvent(function(...)_this:onWinItemClick(...)end)
_this.fbSlot1:setBaseItemChildIndex(EQUIP_TYPE.eFabao)

local itemID=YiYuHuiYouModel:getXianLuId()
local item
if itemID~=0 then
item={itemid=itemID,itemguid=nil}
end

local prop={}


if item then
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
local iconName=itemsModel.getIconName(item)
local name=itemConfig.name
local reddot=false

prop[PropIndex(DataPropKey.eWidgetQuality,0)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetActive,3)]=false
prop[PropIndex(DataPropKey.eWidgetText,4)]=stage
prop[PropIndex(DataPropKey.eWidgetActive,5)]=reddot
prop[PropIndex(DataPropKey.eWidgetText,6)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid or-1

local config=cfg_yiyuhuiyouxianluconfig_get(itemID)
_this.yuertext2:setText(FMT.fmt('<color=#7D3B17>鱼饵效果：</color>{0}',config.effects_show))
_this.onchange:setActive(true)

else

local showAdd=true
local name=''
local reddot=false
local filter={}
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{21}}
local yuerDatas=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter)
if yuerDatas and#yuerDatas>0 then
reddot=true
else
reddot=false
end

prop[PropIndex(DataPropKey.eWidgetActive,0)]=false
prop[PropIndex(DataPropKey.eWidgetActive,1)]=false
prop[PropIndex(DataPropKey.eWidgetActive,2)]=showAdd
prop[PropIndex(DataPropKey.eWidgetActive,3)]=false
prop[PropIndex(DataPropKey.eWidgetActive,5)]=reddot
prop[PropIndex(DataPropKey.eWidgetText,6)]=name
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1

_this.yuertext2:setText(FMT.fmt('<color=#7D3B17>鱼饵效果：</color>无'))
_this.onchange:setActive(false)
end
_this.fbSlot1:setChildPropData(prop)
end



function YYHYSelectWin:refreshFishTools()




local yuganlevel=YiYuHuiYouModel:getYgLevel()or 1
local yuxianlevel=YiYuHuiYouModel:getYxLevel()or 1
local yugoulevel=YiYuHuiYouModel:getYwLevel()or 1

local yugan_cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yugan)[yuganlevel]
local yugou_cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yugou)[yugoulevel]
local yuxian_cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yuxian)[yuxianlevel]

_this.winlua:SetChildCSImageSprite(_this.yugan:getID(),abname_yyhy,FMT.fmt('yyhy_yugan_shop_{0}',yugan_cfg.yujuImg))
_this.yugantext:setText(yugan_cfg.yj_name)

_this.winlua:SetChildCSImageSprite(_this.yugou:getID(),abname_yyhy,FMT.fmt('yyhy_yugou_shop_{0}',yugou_cfg.yujuImg))
_this.yugoutext:setText(yugou_cfg.yj_name)

_this.winlua:SetChildCSImageSprite(_this.yuxian:getID(),abname_yyhy,FMT.fmt('yyhy_yugxian_shop_{0}',yuxian_cfg.yujuImg))
_this.yuxiantext:setText(yuxian_cfg.yj_name)



local desclist={}
if yugan_cfg.strarry then
desclist[#desclist+1]=yugan_cfg.strarry
end
if yugou_cfg.strarry then
for k,v in ipairs(yugou_cfg.strarry)do
desclist[#desclist+1]=v
end
end
if yuxian_cfg.strarry then
desclist[#desclist+1]=yuxian_cfg.strarry
end

YYHYSelectWin:refreshFishToolsXiaoGuo(desclist)

if#desclist<1 then
_this.yujuxiaoguotext:setActive(true)
else
_this.yujuxiaoguotext:setActive(false)
end
end


local abanemxg='ui/windows/equip/collocation_atlas_pak.ab'
function YYHYSelectWin:refreshFishToolsXiaoGuo(desclist)

self.desclist=desclist
local dataNum=#self.desclist
_this.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=_this.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local cfg=_this.desclist[i]
local name=cfg.name
local framecolor=cfg.framecolor
local item=gridlist[i-1]
item:SetChildActive(-1,true)
local cfg2={}
cfg2.framecolor=2
cfg2.name=cfg[1]
UIDiscipleModel.refreshSpecialityItem(item,cfg2,function()
self:onDescSlotClick(i)
end)

item:SetChildText(0,cfg[1])


item:SetChildCSImageSprite(1,abanemxg,'image_dzzhuangbeicdui_3')

end
end
end


function YYHYSelectWin:onDescSlotClick(idx)
local cfg=_this.desclist[idx]
local item=_this.descListPanel:getChildLayoutGroupGridItem(idx-1)







UIManager:showWindow('UIYYHYSpecialityWin',{item=item,node='bottom',guid=nil,config=cfg})
end


function YYHYSelectWin:getNetDataList()
local list={}
local sortParams={[1]=true,[3]=true}
if self.param.disciples then
for i,v in ipairs(self.param.disciples)do
table.insert(list,UIDiscipleModel:getDiscipleDataX(v))
end
discipleLookup:sortList(list,self.sortType,self.sortOrder,sortParams)
else
list=discipleLookup:getSortDiscipleListEx(self.sortType,self.sortCondition,self.sortOrder,sortParams)
end

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



function YYHYSelectWin:paixu(list)
local listnew={}

if#list>0 then
local count=#list

for i,v in ipairs(list)do



local netData=v.netData.net
local guid=netData.discipleguid
local fright=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eJiYuan)
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei


local state=chuiwei==true and 0 or 1

local weight=state*100000+(100000+fright)
table.insert(listnew,{v,weight})
end
table.sort(listnew,function(a,b)
return a[2]>b[2]
end)
end
return listnew
end



function YYHYSelectWin:initRoleListPanel()

local list=self:getNetDataList()
local newlist=YYHYSelectWin:paixu(list)
self:initRoleListPanelEx(newlist)

_this.select_index=-1

local dizi_guid=YiYuHuiYouModel:getDiZiId()or-1
if dizi_guid~=-1 then

local dizi_index=1
local dataNum=#_this.disciplesList
for i=1,dataNum do
local netdata=_this.disciplesList[i][1].netData
local netData=netdata.net
local guid=netData.discipleguid
if tostring(guid)==tostring(dizi_guid)then
dizi_index=i
end
end
YYHYSelectWin:OnClickRoleItemCallback(1,dizi_index)
end
YYHYSelectWin:refreshFishTools()
YYHYSelectWin:refreshFBYuErSlot()
end


function YYHYSelectWin:initRoleListPanelEx(list)
self.disciplesList=list
local dataNum=#self.disciplesList
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,3)
local hasDZ=dataNum>0
self.hasNewDZ=nil
if hasDZ then
local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local netdata=self.disciplesList[i][1].netData
local netData=netdata.net
local guid=netData.discipleguid
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local beibu=state==DISCIPLE_STATE_TYPE.eBeiBu
local item=grids[i-1]


local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(22,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,chuiwei)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)

if self.sortType==eDiscipleSortType.eJingJieSort then

item:SetChildActive(6,false)

local jjlv=netData.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶',n,p)
else
jj_str=n
end
item:SetChildText(4,jj_str)
elseif self.sortType==eDiscipleSortType.eLianTiSort then

item:SetChildActive(6,false)

local ltlv=netData.liantilv
local n1,p1=UIDiscipleModel:getLTNameX(ltlv)
local lt_str=''
if p1~=nil then
lt_str=FMT.fmt('{0}{1}层',n1,p1)
else
lt_str=n1
end
item:SetChildText(4,lt_str)
elseif self.sortType==eDiscipleSortType.ePostSort then

item:SetChildActive(6,false)

local post_id=netData.pos
local post_name=eZongMenPostType.getName(post_id)
item:SetChildText(4,post_name)
else

item:SetChildActive(6,true)

item:SetChildText(6,UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eJiYuan))


item:SetChildText(4,'')
end

item:SetChildActive(8,not chuiwei and self.inputstr~=nil)
item:SetChildText(9,UIDiscipleModel:getDiscipleStateDesc(guid,' '))



item:SetChildActive(12,chuiwei)
item:SetChildActive(13,chuiwei)
item:SetChildActive(16,chuiwei)
item:SetChildActive(18,beibu)


local isnew=netdata.isnew==true
if isnew then self.hasNewDZ=true end
item:SetChildActive(7,isnew)

local isreddot=(not chuiwei)and UIDiscipleModel:checkLTReddot(guid)
item:SetChildActive(11,isreddot)

local isdujie=(not chuiwei)and UIDiscipleModel:checkJJReddot(guid)
item:SetChildActive(14,isdujie)

local showOrder=UIDiscipleModel:checkDZHasOrder(guid)
item:SetChildActive(15,showOrder)

local newbieName
local srctype=UIDiscipleModel:getDiscipleSrcType(guid)
if discipleSrcType:isPlot(srctype)then
newbieName=FMT.fmt('YYHYSelectWin.discipleItemPlot_{0}',srctype)
else
newbieName=FMT.fmt('YYHYSelectWin.discipleItem_{0}',i)
end
item:SetChildNewBieComponentId(-1,newbieName)

local func=function()
self:OnClickRoleItemCallback(1,i)
end
item:SetChildButtonClick(-1,func,true)

UIDiscipleController.refreshCommonItemTianMing(item,netData)


item:SetChildNewBieComponentId(-1,FMT.fmt('YYHYSelectWin.roleListPanel_{0}',i))
end
end
self.noDZTips:setActive(not hasDZ)
end


function YYHYSelectWin:OnClickRoleItemCallback(clicknum,index)








local dzData=_this.disciplesList[index][1]
local netdata=dzData.netData.net
dzData.netData.isnew=false
_this.clickDZClose=true
local item=_this.roleListPanel:getChildScrollViewItemWidget(index-1)
item:SetChildActive(7,false)










local func=function(args_)
UIFullDiscipleSelectControl:showDiscipleSelectWindow(args_)
end


if _this.select_index==index then return end
local selectdz=_this.disciplesList[index][1].netData.net.discipleguid
local state=UIDiscipleModel:getDiscipleState(selectdz)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
UIManager.error('弟子垂危中，无法参与活动')
return
end

local old=_this.select_index
_this.select_index=index

_this.select_dz=_this.disciplesList[_this.select_index][1].netData.net.discipleguid


_this:refreshSelect(old,false)
_this:refreshSelect(index,true)


end


function YYHYSelectWin:refreshSelect(index,flag)
if index<0 then
return
end
local item=_this.roleListPanel:getChildScrollViewItemWidget(index-1)


item:SetChildActive(10,flag)
end

function YYHYSelectWin:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
self.sortType=idx
UIDiscipleModel:setSaveSortType(idx)

self:clearSearchInput()
self:initRoleListPanel()
end

function YYHYSelectWin:onSortConditionClick()
local filterName,filterFlag=discipleLookup:getConditonFilterEx(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function YYHYSelectWin.selecConditionBack(data)

if _this==nil then
return
end
local filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

UIDiscipleModel:setSaveSortCondition(table.deepCopy(_this.sortCondition))

_this:clearSearchInput()
_this:initRoleListPanel()
end

function YYHYSelectWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end


function YYHYSelectWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:initRoleListPanel()
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
UIManager.info('暂无符合条件的弟子')
return
end
self.searchInput:setInputFieldValue('')
self:initRoleListPanelEx(list)
end

function YYHYSelectWin:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:initRoleListPanel()
end

function YYHYSelectWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function YYHYSelectWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function YYHYSelectWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function YYHYSelectWin:onTestBtnClick()
local sortCondition=table.deepCopy(self.sortCondition)
UIManager:showWindow('UIDiscipleGUIDCopylWin',{sortCondition=sortCondition,sortOrder=self.sortOrder,sortType=self.sortType})
end

function YYHYSelectWin:onTestAttrBtnClick()
UIManager:showWindow('UIDiscipleAttrLookWin')
end

function YYHYSelectWin:refreshKickoutBtn()
local islock=not zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eShuWuDian)
self.kickoutLock:setActive(islock)
end

function YYHYSelectWin:onKickoutBtn()
if not zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eShuWuDian)then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eShuWuDian)
UIManager.error(FMT.fmt('{0}级建造{1}后可用',cfg.show_level,cfg.name))
return
end
UIFullShuWuDianControl:showMyWindowEx(FULL_TAB_TYPE.eShuWuDianKickout,{})
end




function YYHYSelectWin:onClosebtn()
self:closeSelf()
end


function YYHYSelectWin:onQuerenbtn()
local npcid=YiYuHuiYouModel:getNPCId()
if _this.select_index~=-1 then

local select_dz=_this.disciplesList[_this.select_index][1].netData.net.discipleguid




YiYuHuiYouModel:setDiZiId(select_dz)

local guidkey=mathHelper.int64_to_string(select_dz)
userActorSetting.set('YYHYSelectWin_dizi_guid_new',guidkey)
userActorSetting.flush()

if _this.isqiehuan then
UIManager:invokeUIMethod('UIYYHYWin','doSpeaking_ai_auto',3)
UIManager:invokeUIMethod('UIYYHYWin','doSpeaking_player_auto',12)
else
UIManager:invokeUIMethod('UIYYHYWin','doSpeaking_ai_auto',2)
UIManager:invokeUIMethod('UIYYHYWin','doSpeaking_player_auto',11)
end

UIManager:invokeUIMethod('UIYYHYWin','refreshcenterPanel')
UIManager:invokeUIMethod('UIYYHYWin','setPlayerModel')

UIManager:invokeUIMethod('UIYYHYWinzhiyin','refreshcenterPanel')
UIManager:invokeUIMethod('UIYYHYWinzhiyin','setPlayerModel')

self:closeSelf()
else
UIManager.error('请选择至少一名弟子参与游戏')
end
end



function YYHYSelectWin:onOnchange()
UIManager:showWindow('YYHYGainWin')
end
