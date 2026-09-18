







def_class("UIGongFaDiscipleInfoWin",UIWindowBase)









function UIGongFaDiscipleInfoWin:bindComponents()

self.discipleModelRoot=UIObject.get(self,0)
self.discipleNameText=UIText.get(self,1)
self.discipleJobIcon=UIImage.get(self,2)
self.discipleInfoPanel=UIObject.get(self,3)
self.lgItem=UIObject.get(self,4)
self.gongfalist1=UIObject.get(self,5)
self.gongfanumText=UIText.get(self,6)
self.noGFSign=UIObject.get(self,7)
self.gongfalist2=UIObject.get(self,8)
self.sortTypeDropdown=UIDropdown.get(self,9)
self.litleman=UIObject.get(self,10)
self.kuilei=UIObject.get(self,11)
self.discipleJobIcon2=UIImage.get(self,12)
self.spBg=UIObject.get(self,13)



end


function UIGongFaDiscipleInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.discipleInfoPanel);self.discipleInfoPanel=nil;
_UIObject_release(self.lgItem);self.lgItem=nil;
_UIObject_release(self.gongfalist1);self.gongfalist1=nil;
_UIObject_release(self.gongfanumText);self.gongfanumText=nil;
_UIObject_release(self.noGFSign);self.noGFSign=nil;
_UIObject_release(self.gongfalist2);self.gongfalist2=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.litleman);self.litleman=nil;
_UIObject_release(self.kuilei);self.kuilei=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
end
















local sortTypeName
local _this


function UIGongFaDiscipleInfoWin:onLoaded(...)
_this=self
self:bindComponents()
self.gongfalist1:setChildScrollViewInit(0.5,true,nil,nil)
sortTypeName={'所有功法','可修炼功法','不可修炼功法'}
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)

self.on_money_changed=function(mtype,last,curr)
if mtype==eMoneyType.mtChuanDao then
self:doRefreshCanToggleListView()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIGongFaDiscipleInfoWin:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIGongFaDiscipleInfoWin:onHide()

end

function UIGongFaDiscipleInfoWin:refreshAfterItemUse(...)
self:doRefreshCanToggleListView()
end




function UIGongFaDiscipleInfoWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid

self.sortTypeDropdown:setOption(sortTypeName)
self.sortType=2
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortType-1)
self.lockRefresh=false

self:refreshInfoView()
self:refreshHasToggleListView()
self:refreshCanToggleListView()
self:showModel()
end

function UIGongFaDiscipleInfoWin:showModel()

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.disciple_guid,true,1)
self.litleman:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false)

self.kuilei:setChildUIModelShowTarget(2046,1,{},0,false,false,0,nil)

end

function UIGongFaDiscipleInfoWin:refreshInfoView()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

self.discipleNameText:setText(UIDiscipleModel:getDiscipleName(self.disciple_guid))

local jobicon=UIDiscipleModel:getJobIconNameX(self.disciple_guid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(self.disciple_guid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(self.disciple_guid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end

comHelper.setChildInSideModel(self.discipleModelRoot,self.disciple_guid,nil,nil,30,-15,false,true)

local infoWidget=self.discipleInfoPanel:getChildWidgetBase()

local jobstr=UIDiscipleModel:getJobNameX(self.disciple_guid)
infoWidget:SetChildText(0,FMT.fmt('职业：<color=#7d3b17>{0}</color>',jobstr))

local post=UIDiscipleModel:getDisciplePost(self.disciple_guid)
local poststr=eZongMenPostType.getName(post)
infoWidget:SetChildText(1,FMT.fmt('职位：<color=#7d3b17>{0}</color>',poststr))

local jjlv=netData.jingjielv
local jjstr=UIDiscipleModel:getJJNameEx(jjlv)
infoWidget:SetChildText(2,FMT.fmt('境界：<color=#7d3b17>{0}</color>',jjstr))

local ltlv=netData.liantilv
local ltstr=UIDiscipleModel:getLTNameEx(ltlv)
infoWidget:SetChildText(3,FMT.fmt('炼体：<color=#7d3b17>{0}</color>',ltstr))


local lglist=UIDiscipleModel:getDiscipleSpeciality(self.disciple_guid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
local lgnum=0
if lglist then
lgnum=#lglist
if lgnum>5 then lgnum=5 end
end
local showlg=lgnum>0
self.lgItem:setActive(showlg)
if showlg then
local lgWiget=self.lgItem:getChildWidgetBase()
lgWiget:SetChildButtonClick(0,function()
self:showDiscipleInfoDescribe(1)
end)
lgWiget:SetChildCSImageSprite(0,globalABLookup.cangjingge,'frame_linggenkuang_'..lgnum)
for i=1,5 do
local isshow=(i==lgnum)
lgWiget:SetChildActive(i,isshow)
if isshow then
local widget=lgWiget:GetChildWidgetBase(i)
for j=1,lgnum do
local v=lglist[j].param_1
widget:SetChildCSImageSprite(j-1,globalABLookup.global,ELEMENT_TYPE.getIcon(v))
end
end
end
end
end

function UIGongFaDiscipleInfoWin:showDiscipleInfoDescribe(ty)
if ty==1 then

local lglist=UIDiscipleModel:getDiscipleSpeciality(self.disciple_guid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
local desc_str='弟子拥有：\n'
local c=1
for i,v in ipairs(lglist)do
local s=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,v.param_1,'name')
if c~=1 then
desc_str=desc_str..'、'..s
else
desc_str=desc_str..s
end
c=c+1
end
local pos=Vector2.New(-18,25)
UIManager:showWindow('UIConditionTipsOne',{str=desc_str,posItem=self.lgItem,pos=pos})
end
end

function UIGongFaDiscipleInfoWin:refreshHasToggleListView()
self:getHasGongFaList()
local dataNum=#self.hasGongFaList
self.gongfalist1:setChildScrollViewCreateGrids(dataNum,1)

local grids=self.gongfalist1:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local netData=self.hasGongFaList[i]
local gfID=netData.param_1
local gflv=netData.param_2
local gfExp=netData.param_3
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)

item:SetChildButtonClick(0,function()
self:onClickHasGFSlotCallback(gfID)
end)

local colorIcon=UIGongFaModel:getGFColorKuangIcon(cfg.color)
item:SetChildCSImageSprite(1,globalABLookup.cangjingge,colorIcon)

item:SetChildIcon(2,iconHelper.getGongFaIcon(cfg.icon),false)

local elements=UIGongFaModel:getGFElements(gfID)
local elementid=elements[1]
local elementIcon=ELEMENT_TYPE.getIcon(elementid)
item:SetChildCSImageSprite(3,globalABLookup.global,elementIcon)

item:SetChildText(4,cfg.name)

local lv_str=UIGongFaModel:getGFLeverlStr(gflv)
item:SetChildText(5,lv_str)

local isFull=false
local gfMaxLv=UIGongFaModel:getGFMaxLevel(gfID)
if gflv>=gfMaxLv then
isFull=true
end
local curExp=gfExp
local maxExp=cfg.exp[gflv]
if maxExp==nil then
curExp=1
maxExp=1
end
item:SetChildProgressValue(6,curExp,maxExp)
local progress_str=''
if isFull then
progress_str=UIGongFaModel:getGFLeverlStr(-1)
else
progress_str=FMT.fmt('{0}/{1}',curExp,maxExp)
end
item:SetChildProgressText(6,progress_str)


local isUse=UIDiscipleModel:isDiscipleGFUsing(self.disciple_guid,gfID)
item:SetChildActive(7,isUse)

local studylv=UIGongFaModel:getStudyLevel(gfID)
local showStudy=studylv>0
item:SetChildActive(8,showStudy)
if showStudy then
item:SetChildText(9,studylv)
end
end

local cur=dataNum
local max=UIGongFaModel:getLearnGFMaxNum()
local has_str=FMT.fmt('可修炼功法数量：{0}/{1}',cur,max)
self.gongfanumText:setText(has_str)

self.noGFSign:setActive(cur<=0)
end

function UIGongFaDiscipleInfoWin:getHasGongFaList()
self.hasGongFaList=UIDiscipleModel:getDiscipleAllGFData(self.disciple_guid)
end

function UIGongFaDiscipleInfoWin:refreshCanToggleListView()
self:getCanGongFaList()
self:doRefreshCanToggleListView()
end

function UIGongFaDiscipleInfoWin:doRefreshCanToggleListView()
self:getSortCanGongFaList()
local dataNum=#self.sortCanGongFaList
self.gongfalist2:setChildLayoutGroupCreateItems(dataNum)

local grids=self.gongfalist2:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.sortCanGongFaList[i]
local cfg=data.cfg
local gfID=cfg.id

item:SetChildButtonClick(0,function()
self:onClickCanGFSlotCallback(gfID)
end)
item:SetChildButtonClick(1,function()
self:onClickCanGFSlotCallback(gfID)
end)
item:SetChildNewBieComponentId(1,FMT.fmt('UIGongFaDiscipleInfoWin.UIGongFaItem2.gfBack.{0}',i))
item:SetChildNewBieComponentId(7,FMT.fmt('UIGongFaDiscipleInfoWin.UIGongFaItem2.{0}',i))

local colorIcon=UIGongFaModel:getGFColorKuangIcon(cfg.color)
item:SetChildCSImageSprite(1,globalABLookup.cangjingge,colorIcon)

item:SetChildIcon(2,iconHelper.getGongFaIcon(cfg.icon),false)

local elements=UIGongFaModel:getGFElements(gfID)
local elementid=elements[1]
local elementIcon=ELEMENT_TYPE.getIcon(elementid)
item:SetChildCSImageSprite(3,globalABLookup.global,elementIcon)

item:SetChildText(4,cfg.name)

item:SetChildIcon(6,iconHelper.getMoneyIconName(eMoneyType.mtChuanDao),true)
local needmoney=UIGongFaModel:getGFConsume(self.disciple_guid,gfID)
local hasmoney=moneyModel.getMoney(eMoneyType.mtChuanDao)
local money_str=''
if hasmoney>=needmoney then
money_str=tostring(needmoney)
else
money_str=string.format('<color=red>%d</color>',needmoney)
end
item:SetChildText(5,money_str)

local fixLearn=UIGongFaModel:checkGongFaFixDisciple(gfID,self.disciple_guid)
local isGray=not fixLearn
item:SetChildGray(7,isGray)
item:SetChildButtonClick(7,function()
self:onLearnGFClick(gfID,i)
end)
item:SetChildWeakGuideComponentId(7,FMT.fmt('UIGongFaDiscipleInfoWin.UIGongFaItem2_{0}',i))

item:SetChildActive(8,isGray)

local istuijian=self.tuijianGFLookup[gfID]~=nil
item:SetChildActive(9,istuijian)

local studylv=UIGongFaModel:getStudyLevel(gfID)
local showStudy=studylv>0
item:SetChildActive(10,showStudy)
if showStudy then
item:SetChildText(11,studylv)
end
end
end

function UIGongFaDiscipleInfoWin:getCanGongFaList()

self.tjValusLookup={}
local temp=gongfaLookup:getAllActiveGongFaList2()
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.disciple_guid)
local jobid=imageInfo.job
local dzid=UIDiscipleModel:getDiscipleID(self.disciple_guid)
for i,v in ipairs(temp)do
local tjValues=v.cfg.job_tjValue[jobid]
local tjValue=tjValues[dzid]or tjValues[0]
v.isTuijian2=tjValue
self.tjValusLookup[v.cfg.id]=tjValue
end
local list=gongfaLookup:getSortGongFaList2(temp,2,nil,eSortOrder.eDown,self.disciple_guid)
self.tuijianGFLookup={}
for i=1,4 do
local d=list[i]
if d then
self.tuijianGFLookup[d.cfg.id]=true
end
end
self.canGongFaList=gongfaLookup:getAllActiveNotLearnGongFaList(self.disciple_guid)
for i,v in ipairs(self.canGongFaList)do
v.isTuijian2=self.tjValusLookup[v.cfg.id]or 0
end
end

function UIGongFaDiscipleInfoWin:onClickHasGFSlotCallback(gfID)


local tipsType
if UIManager:isActive('UIGongFaMainWin')then
tipsType=1
else
tipsType=2
end
UIManager:showWindow('UIGongFaTipsWin',{guid=self.disciple_guid,gfID=gfID,tipsType=tipsType})
end

function UIGongFaDiscipleInfoWin:onClickCanGFSlotCallback(gfID)
UIManager:showWindow('UIGongFaTipsTwoWin',{guid=self.disciple_guid,gfID=gfID})
end








function UIGongFaDiscipleInfoWin:onLearnGFClick(gfID,idx)
local fixLearn,fixlist=UIGongFaModel:checkGongFaFixDisciple(gfID,self.disciple_guid)
if not fixLearn then
local item=self.gongfalist2:getChildLayoutGroupGridItem(idx-1)
local pos=item:GetChildScreenPointToLocalPointRectangle(-1)
local desc_str=UIGongFaModel:checkGongFaFixDesc(fixlist)

pos.x=pos.x+60
pos.y=pos.y
UIManager:showWindow('UIConditionTipsOne',{showType=2,str=desc_str,pos=pos})
return
end

if not UIGongFaModel:enoughMoneyLearnGF(self.disciple_guid,gfID,true)then
return
end

local cur=UIDiscipleModel:getDiscipleAllGFNum(self.disciple_guid)
local max=UIGongFaModel:getLearnGFMaxNum()
if cur>=max then
UIManager.error(FMT.fmt('弟子最多只能修炼{0}本功法哦',max))
return
end

UIGongFaController:reqDiscipleLearn(self.disciple_guid,gfID)


end

function UIGongFaDiscipleInfoWin:onCloseClick()
self:closeSelf()
end



function UIGongFaDiscipleInfoWin:getSortCanGongFaList()
local list=gongfaLookup:getSortGongFaList2(self.canGongFaList,self.sortType,self.sortCondition,self.sortOrder,self.disciple_guid)
self.sortCanGongFaList=list
end

function UIGongFaDiscipleInfoWin:onDropdownChange(idx)
if self.lockRefresh==true then return end
idx=idx+1
self.sortType=idx
self:doRefreshCanToggleListView()
end

function UIGongFaDiscipleInfoWin:onSortConditionClick()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=gongfaLookup:getConditonFilter2()
end








local args={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.titleName=cfgHelper.getlang('filter_title_name')
UIManager:showWindow('UIFilterTwoWin',args)
end

function UIGongFaDiscipleInfoWin.selecConditionBack(data)
if _this==nil then
return
end
_this.filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(_this.filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

_this:doRefreshCanToggleListView()
end

function UIGongFaDiscipleInfoWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:doRefreshCanToggleListView()
end



function UIGongFaDiscipleInfoWin:rec_learGF()
self:refreshHasToggleListView()
self:refreshCanToggleListView()
end

function UIGongFaDiscipleInfoWin:rec_upGF(gfID,oldlv,newlv)
self:refreshHasToggleListView()
end

function UIGongFaDiscipleInfoWin:rec_forgetGF(guid,gfID,pos)
self:refreshHasToggleListView()
self:refreshCanToggleListView()
end

function UIGongFaDiscipleInfoWin:rec_setupGF(pos,gfID,oldpos)
self:refreshHasToggleListView()
end