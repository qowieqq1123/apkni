







def_class("UIFuncItemUseWin",UIWindowBase)









function UIFuncItemUseWin:bindComponents()

self.back=UIObject.get(self,0)
self.progressText=UIText.get(self,1)
self.proAddExp=UIProgressBarAni.get(self,2)
self.proExpProgressbar=UIProgressBarAni.get(self,3)
self.proCurLevel=UIText.get(self,4)
self.proName=UIText.get(self,5)
self.proIcon=UIImage.get(self,6)
self.proLevel=UIText.get(self,7)
self.handleImg=UIObject.get(self,8)
self.descListPanel=UIObject.get(self,9)
self.nullTeZhi=UIText.get(self,10)
self.maxCnt=UIButton.get(self,11)
self.selectCntSlider=UIObject.get(self,12)
self.addBtn=UIButton.get(self,13)
self.subBtn=UIButton.get(self,14)
self.proSkillInfo=UIObject.get(self,15)
self.proSkillItemScrollview=UIObject.get(self,16)
self.normalItemScrollview=UIObject.get(self,17)
self.noItems=UIObject.get(self,18)
self.teZhiPanel=UIObject.get(self,19)
self.help=UIToggleButton.get(self,20)
self.useBtn=UIButton.get(self,21)
self.tipsText=UIText.get(self,22)
self.selectCount=UIObject.get(self,23)
self.proSkillBook=UIObject.get(self,24)
self.normalItem=UIObject.get(self,25)
self.polygonAttrPanel=UIObject.get(self,26)
self.shaiXuanBtn=UIButton.get(self,27)
self.rightPanel=UIObject.get(self,28)
self.titleBack=UIObject.get(self,29)
self.proSkillListPanel=UIObject.get(self,30)
self.sortTypeDropdown=UIDropdown.get(self,31)
self.sortBtn=UIButton.get(self,32)
self.selectCntText=UIText.get(self,33)
self.dzScrollview=UIObject.get(self,34)
self.helpText=UIText.get(self,35)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.useBtn:setButtonClick(function()self:onUseBtn()end)

self.shaiXuanBtn:setButtonClick(function()self:onShaiXuanBtn()end)

self.sortBtn:setButtonClick(function()self:onSortBtn()end)



end


function UIFuncItemUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.proAddExp);self.proAddExp=nil;
_UIObject_release(self.proExpProgressbar);self.proExpProgressbar=nil;
_UIObject_release(self.proCurLevel);self.proCurLevel=nil;
_UIObject_release(self.proName);self.proName=nil;
_UIObject_release(self.proIcon);self.proIcon=nil;
_UIObject_release(self.proLevel);self.proLevel=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.nullTeZhi);self.nullTeZhi=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.proSkillInfo);self.proSkillInfo=nil;
_UIObject_release(self.proSkillItemScrollview);self.proSkillItemScrollview=nil;
_UIObject_release(self.normalItemScrollview);self.normalItemScrollview=nil;
_UIObject_release(self.noItems);self.noItems=nil;
_UIObject_release(self.teZhiPanel);self.teZhiPanel=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.selectCount);self.selectCount=nil;
_UIObject_release(self.proSkillBook);self.proSkillBook=nil;
_UIObject_release(self.normalItem);self.normalItem=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.shaiXuanBtn);self.shaiXuanBtn=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.proSkillListPanel);self.proSkillListPanel=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.sortBtn);self.sortBtn=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.dzScrollview);self.dzScrollview=nil;
_UIObject_release(self.helpText);self.helpText=nil;
end

















local _this
local isinit
local jumpbuildid=SLG_SYSTEM_TYPE.eLianDanFang

local itemTypeName=
{
[item_funtion_type.shouyuan]='寿元丹',
[item_funtion_type.liaoshang]='疗伤丹',
}

local _dropItemHeight=40
local _dropViewHeight=220


function UIFuncItemUseWin:onLoaded(...)
self:bindComponents()
_this=self
isinit=true
self.onClickUseItem=function(...)
self:onClickUseItemCallback(...)
end
self.onLongClickUseItemCallBack=function(...)
self:onLongClickUseItem(...)
end
local _OnClickDzIconCallback=function(...)
self:onClickDzIconCallback(...)
end
self.dzScrollview:setChildScrollViewInit(-1,true,_OnClickDzIconCallback,nil)
self.curDzIdx=1
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.sortTypeDropdown:setDropdownLayoutedAction(function(...)self:onDropdownCreate(...)end)
self.sortTypeIdx=1
self.sortCondition={}
self.sortOrder=eSortOrder.eDown

local longPressFunc=function(...)
self:onLongPressBtn(...)
end
self.winlua:SetChildLongPress(self.subBtn:getID(),1,longPressFunc,nil)
self.winlua:SetChildLongPress(self.addBtn:getID(),2,longPressFunc,nil)

self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
end


function UIFuncItemUseWin:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
end

function UIFuncItemUseWin.on_slider_change(value)
_this:onSliderChange(value)
end




function UIFuncItemUseWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
self.selectCnt=1
local itemid=argtable.itemid
local funcType=argtable.type
self.skillid=argtable.skillid
self.disciple_guid=argtable.disguid

if itemid then
self.selectItemid=itemid
self.itemConfig=itemsConfig.getConfig(itemid)
local funcparam=self.itemConfig.funcparam
if funcparam then
self.curItemType=funcparam.type
if self.curItemType==item_funtion_type.pro_skill_exp then
self.skillid=funcparam.skillid
end
if self.curItemType==item_funtion_type.tezhiSub then
if funcparam.itemsort then
self.sortOrder=eSortOrder.eUp
end
end
end
else
self.curItemType=funcType
end
local curFuncTypeArgs=UIFuncItemUseModel.funcTypeArgs[self.curItemType]
self.curFuncTypeArgs=curFuncTypeArgs
if self.curItemType==item_funtion_type.liaoshang then
self:_dealLiaoShangDan()
elseif self.curItemType==item_funtion_type.shouyuan then
self:_dealShouYuanDan()
elseif self.curItemType==item_funtion_type.pro_skill_exp then
self:_dealProSkillExpDan()
end

if curFuncTypeArgs then
self:_dealFuncTypeArgsItem()
if curFuncTypeArgs.showHelp then
curFuncTypeArgs.showHelp(self)
end
end

self:refreshOption()

local showProSkillListPanel=false
local showTitleBack=false

local showProskill=self.curItemType==item_funtion_type.pro_skill_exp
if curFuncTypeArgs then
showProSkillListPanel=curFuncTypeArgs.topPage or false
showTitleBack=curFuncTypeArgs.title or false
else
showProSkillListPanel=showProskill
showTitleBack=not showProskill
end
self.proSkillListPanel:setActive(showProSkillListPanel)
self.titleBack:setActive(showTitleBack)

end


function UIFuncItemUseWin:onHide()

end

function UIFuncItemUseWin:refreshOption()
self:resetSliderInit()
local haveItems=#self.itemList>0
self.useBtn:setActive(haveItems)
self.tipsText:setActive(not haveItems)
self.noItems:setActive(not haveItems)
if#self.itemList<=0 then
if self.curItemType==item_funtion_type.pro_skill_exp then
local proName=cfgHelper.get2(cfg_discipleproskillconfig_get,self.skillid,'name')
local itemName=FMT.fmt('{0}笔录',proName)
self.tipsText:setText(FMT.fmt('暂无{0}',itemName))
else
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,jumpbuildid)
local buildName=cfg.name
local itemName=itemTypeName[self.curItemType]
self.tipsText:setText(FMT.fmt('前往<color=#2DCD19>【{0}】</color>炼制{1}',buildName,itemName))
end
if self.curFuncTypeArgs and self.curFuncTypeArgs.refreshNoItem then
self.curFuncTypeArgs:refreshNoItem(self)
end
end
end



function UIFuncItemUseWin:_dealLiaoShangDan()
local option={'负伤排序','战力排序','品质排序'}
self.sortTypeDropdown:setOption(option)
self.sortTypeDropdown:setValue(0)
self.sortTypeList={eDiscipleSortType.eFuShang,eDiscipleSortType.eFightSort,eDiscipleSortType.eColorSort}
self:sortDiscipleList()

self.itemsScrollview=self.normalItemScrollview
self.itemsScrollview:setChildScrollViewInit(-1,true,self.onClickUseItem,self.onLongClickUseItemCallBack)
self:refreshItemPanel()
self:refreshDzPanel()
end

function UIFuncItemUseWin:getCurDzInjury()
local guid=self:getCurSelectDzGuid()
local injury=UIDiscipleModel:getDiscipleInjury(guid)
return injury
end


function UIFuncItemUseWin:setLiaoShangDanUseCount()
self.selectCnt=self.maxUseCnt
if self.maxUseCnt==0 then
self.maxUseCnt=1
end
end



function UIFuncItemUseWin:_dealShouYuanDan()
local option={'寿元排序','战力排序','品质排序'}
self.sortTypeDropdown:setOption(option)
self.sortTypeDropdown:setValue(0)
self.sortTypeList={eDiscipleSortType.eShouYuan,eDiscipleSortType.eFightSort,eDiscipleSortType.eColorSort}
self:sortDiscipleList()

self.itemsScrollview=self.normalItemScrollview
self.itemsScrollview:setChildScrollViewInit(-1,true,self.onClickUseItem,self.onLongClickUseItemCallBack)
self:refreshItemPanel()
self:refreshDzPanel()
end

function UIFuncItemUseWin:getCurDzShouYuan()
local guid=self:getCurSelectDzGuid()
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(guid)
return shouyuan
end

function UIFuncItemUseWin:setShouYuanDanUseCount()
local shouyuan=self:getCurDzShouYuan()
if shouyuan<0 then
self.selectCnt=0
elseif self.selectCnt>self.maxUseCnt then
self.selectCnt=self.maxUseCnt
end
if self.maxUseCnt==0 then
self.maxUseCnt=1
end
end


function UIFuncItemUseWin:_dealFuncTypeArgsItem()
local curFuncTypeArgs=self.curFuncTypeArgs
local option=curFuncTypeArgs.sortOption
local sortTypeList=curFuncTypeArgs.sortTypeList
if option then
self.sortTypeDropdown:setOption(option)
self.sortTypeDropdown:setValue(0)
self.sortTypeList=sortTypeList
end
self.itemsScrollview=self.normalItemScrollview
self.itemsScrollview:setChildScrollViewInit(-1,true,self.onClickUseItem,self.onLongClickUseItemCallBack)

if curFuncTypeArgs.topPageList then

self:initTopPageList()
else
self:refreshFuncTypePanel()
end


end

function UIFuncItemUseWin:initTopPageList()
local curFuncTypeArgs=self.curFuncTypeArgs
if curFuncTypeArgs.topPageList then
self.proSkillListPanel:setChildLayoutGroupCreateItems(#curFuncTypeArgs.topPageList,function(index)
local item=self.proSkillListPanel:getChildLayoutGroupGridItem(index-1)
local config=curFuncTypeArgs.topPageList[index]
item:SetChildButtonClick(0,function(...)
self:onClickTopPageItem(index,config)
end)
item:SetChildText(1,config.name)
self:refreshProSkillItemSelect(item,index,self.clickProSkillIdx==index)
end)
local default=1
if curFuncTypeArgs.getDefaultPageIndex then
default=curFuncTypeArgs:getDefaultPageIndex(self)
end
local config=curFuncTypeArgs.topPageList[default]
self:onClickTopPageItem(default,config,true)
end

end

function UIFuncItemUseWin:refreshFuncTypePanel(isInit)
self:sortDiscipleList()
self:refreshItemPanel(not isInit)
self:sortDiscipleList()
self:refreshDzPanel()
self:refreshPanelFunc()
end

function UIFuncItemUseWin:refreshPanelFunc()
if self.curFuncTypeArgs~=nil and self.curFuncTypeArgs.initPanelFuncName~=nil then
self[self.curFuncTypeArgs.initPanelFuncName](self)
end
end

function UIFuncItemUseWin:onClickTopPageItem(index,config,isInit)
if self.clickProSkillIdx==index then return end
if self.clickProSkillIdx then
self:refreshProSkillItemSelect(nil,self.clickProSkillIdx,false)
end
self.clickProSkillIdx=index
self:refreshProSkillItemSelect(nil,index,true)
if config then
self.selectTopPageConfig=config
else
self.selectTopPageConfig=self.curFuncTypeArgs.topPageList[index]
end
self:refreshFuncTypePanel(isInit)
self:refreshOption()
end


function UIFuncItemUseWin:_dealProSkillExpDan()
local option={'等级排序','战力排序','品质排序'}
self.sortTypeDropdown:setOption(option)
self.sortTypeDropdown:setValue(0)
self.sortTypeList={0,eDiscipleSortType.eFightSort,eDiscipleSortType.eColorSort}

self.itemsScrollview=self.proSkillItemScrollview
self.itemsScrollview:setChildScrollViewInit(-1,true,self.onClickUseItem,self.onLongClickUseItemCallBack)
self:refreshProSkill()
self:refreshProSkillList()
end

function UIFuncItemUseWin:refreshProSkill()
self:sortDiscipleList()
self:refreshItemPanel(true)
self:refreshDzPanel()
self:initProSkillInfo()
end

function UIFuncItemUseWin:getCurDzProSkillData()
local jobType
if self.skillid then
jobType=self.skillid
elseif self.itemConfig then
local funcparam=self.itemConfig.funcparam
jobType=funcparam.skillid
end
local netdata=self.disciplesList[self.curDzIdx].netData
local proskillList=netdata.net.proskillList
return proskillList,jobType
end

function UIFuncItemUseWin:initProSkillInfo()
self.normalItem:setActive(false)
self.proSkillBook:setActive(true)
local proskillList,jobType=self:getCurDzProSkillData()
local curPro=proskillList[jobType]

local name=cfgHelper.get2(cfg_discipleproskillconfig_get,jobType,'name')
self.proName:setText(name)

local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,jobType,'icon')
self.proIcon:setSprite(globalABLookup.proskill,FMT.fmt('image_gongzhongtp_{0}',icon))
self:refreshProSkilInfo(true)
end


function UIFuncItemUseWin:refreshProSkilInfo(init,reverse)
local guid=self:getCurSelectDzGuid()
local proskillList,jobType=self:getCurDzProSkillData()
local curPro=proskillList[jobType]

local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local curexp=curPro.exp
local maxexp=explist[curPro.level]
local isMax=explist[curPro.level+1]==nil


local allAddValue=self:getAllItemAddValue()
if init then
self.proAddExp:animateThreeParams(curexp+allAddValue,maxexp,0)
self.proExpProgressbar:animateThreeParams(curexp,maxexp,0)
else
if reverse then
self.proAddExp:animateFourParams(curexp+allAddValue,maxexp,0.5,reverse)
else
self:useHideAddProgress(curexp,maxexp,allAddValue)
end
self.proExpProgressbar:animateFourParams(curexp,maxexp,0.5,reverse)
end
local progressStr=''
if isMax then
progressStr='已满级'
self.proExpProgressbar:animateThreeParams(maxexp,maxexp,0)
else
if allAddValue>0 then
progressStr=FMT.fmt('{0}<color=#8bf341>（+{1}）</color>/{2}',curexp,allAddValue,maxexp)
else
progressStr=FMT.fmt('{0}/{1}',curexp,maxexp)
end
end
self.progressText:setText(progressStr)

self.proLevel:setText(FMT.fmt('{0}级',curPro.level))

local notMax=explist[curPro.level+1]~=nil
local isShowNextLv=notMax and curexp+allAddValue>=maxexp
self.proCurLevel:setActive(isShowNextLv)
if isShowNextLv then
local nextLevel=UIFuncItemUseModel:getProSkillNextLevel(curPro,allAddValue)
self.proCurLevel:setText(FMT.fmt('{0}级',curPro.level))
self.proLevel:setText(FMT.fmt('{0}级',nextLevel))
end
end

function UIFuncItemUseWin:setProSkillDanUseCount()
local selectDzGuid=self:getCurSelectDzGuid()
local proskillList,jobType=self:getCurDzProSkillData()
local isMax=UIFuncItemUseModel:checkProSkillLvMax(proskillList,jobType)
if isMax then
self.selectCnt=0
elseif self.selectCnt>self.maxUseCnt then
self.selectCnt=self.maxUseCnt
end
if self.maxUseCnt==0 then
self.maxUseCnt=1
end
end

function UIFuncItemUseWin:refreshProSkillList()
local proAllConfig=cfg_discipleproskillconfig()
local num=#proAllConfig

self.proSkillListPanel:setChildLayoutGroupCreateItems(num,function(index)
local item=self.proSkillListPanel:getChildLayoutGroupGridItem(index-1)
local config=proAllConfig[index]
item:SetChildButtonClick(0,function(...)
self:onClickProSkillItem(index,config)
self:onClickDzIconCallback(1,0)
end)
item:SetChildText(1,config.name)
self:refreshProSkillItemSelect(item,index,self.clickProSkillIdx==index)
end)
self:onClickProSkillItem(self.skillid)
end

function UIFuncItemUseWin:refreshProSkillItemSelect(item,index,flag)
if item==nil then
item=self.proSkillListPanel:getChildLayoutGroupGridItem(index-1)
end
item:SetChildCSImageSprite(0,globalABLookup.global,flag==true and'button_xiaoyeqian_1'or'button_xiaoyeqian_2')
end

function UIFuncItemUseWin:onClickProSkillItem(index,config)
if self.clickProSkillIdx==index then return end
if self.clickProSkillIdx then
self:refreshProSkillItemSelect(nil,self.clickProSkillIdx,false)
end
self.clickProSkillIdx=index
self:refreshProSkillItemSelect(nil,index,true)
if config then
self.skillid=config.id
self.selectItemid=nil
end
self:refreshProSkill()
self:refreshOption()
end



function UIFuncItemUseWin:sortDiscipleList()
local selectDzGuid
if self.disciplesList and self.disciplesList[self.curDzIdx]then
selectDzGuid=self:getCurSelectDzGuid()
end

if self.curItemType==item_funtion_type.liaoshang then

local dzList=discipleLookup:getSortDiscipleList(self.sortTypeList[self.sortTypeIdx],self.sortCondition,self.sortOrder)
self.disciplesList=UIFuncItemUseModel:selectInjuryDisciple(dzList)
elseif self.curItemType==item_funtion_type.pro_skill_exp and self.sortTypeIdx==1 then
local skillid
if self.skillid then
skillid=self.skillid
elseif self.itemConfig then
local funcparam=self.itemConfig.funcparam
skillid=funcparam.skillid
end
self.disciplesList=discipleLookup:getSortDiscipleList({eDiscipleSortType.eProSkill,skillid},self.sortCondition,self.sortOrder)
elseif self.curItemType==item_funtion_type.shouyuan then
local sortArgs=self.sortTypeList[self.sortTypeIdx]
local dzList=discipleLookup:getSortDiscipleList(sortArgs,self.sortCondition,self.sortOrder)
self.disciplesList=dzList


elseif self.curItemType==item_funtion_type.attr6Add or self.curItemType==item_funtion_type.lt_jingyandan or self.curItemType==item_funtion_type.jj_xiuweidan then
local funcparam=self.itemConfig.funcparam
local sortArgs=self.sortTypeList[self.sortTypeIdx]
if sortArgs==-1 and self.selectTopPageConfig and self.selectTopPageConfig.sortTagArg then
sortArgs=self.selectTopPageConfig.sortTagArg
end

self.disciplesList=discipleLookup:getSortDiscipleList(sortArgs,self.sortCondition,self.sortOrder,{sortFunc=function(v)
return self.curFuncTypeArgs:checkUseFunc(self,funcparam,v.netData.net.discipleguid,nil,false)
end})

elseif self.curItemType==item_funtion_type.baseAttr6 and self.sortTypeIdx==1 then
local funcparam=self.itemConfig.funcparam
local target=funcparam.target
local target_color=funcparam.color
local temp={}
if target_color then
temp={[5]=target_color}
self.disciplesList=discipleLookup:getSortDiscipleList({eDiscipleSortType.eAttr6Sum,target,target_color},self.sortCondition,self.sortOrder,temp)
else
self.disciplesList=discipleLookup:getSortDiscipleList({eDiscipleSortType.eAttr6Sum,target},self.sortCondition,self.sortOrder)
end
elseif self.curItemType==item_funtion_type.tezhiAdd and self.sortTypeIdx==1 then
local funcParam=self.itemConfig.funcparam.extra[1][2][5][2][1]
local sortArgs=self.sortTypeList[self.sortTypeIdx]
if sortArgs==-1 and self.selectTopPageConfig and self.selectTopPageConfig.sortTagArg then
sortArgs=self.selectTopPageConfig.sortTagArg
sortArgs[4]=funcParam
end
self.disciplesList=discipleLookup:getSortDiscipleList(sortArgs,self.sortCondition,self.sortOrder)
local sType=funcParam[1]
if sType and sType==DISCIPLE_SPECIALITY_TYPE.eStrange and self.clickProSkillIdx and self.clickProSkillIdx==3 then
self.disciplesList=UIFuncItemUseModel:reSortTeZiDisciple(self.disciplesList)
end
else
local sortArgs=self.sortTypeList[self.sortTypeIdx]
if self.curFuncTypeArgs then
if sortArgs==-1 and self.selectTopPageConfig and self.selectTopPageConfig.sortTagArg then
sortArgs=self.selectTopPageConfig.sortTagArg
end
end

self.disciplesList=discipleLookup:getSortDiscipleList(sortArgs,self.sortCondition,self.sortOrder)
end

if self.disciple_guid then
selectDzGuid=self.disciple_guid
self.disciple_guid=nil
end
local f=nil
if selectDzGuid then
for i,v in ipairs(self.disciplesList)do
local netData=v.netData
local dzId=netData.net.discipleguid
if mathHelper.compareInt64(dzId,selectDzGuid)then
f=i
break
end
end
end
if f then
self.curDzIdx=f
else
if#self.disciplesList>0 then
self.curDzIdx=1
else
self.curDzIdx=nil
end
end
end


function UIFuncItemUseWin.setUseRecordData()
local netdata=_this.disciplesList[_this.curDzIdx].netData
_this.useDzGuidStr=netdata.net.discipleguidStr
_this.useItemid=_this.selectItemid
end


function UIFuncItemUseWin:getIsOldUse()
local netdata=self.disciplesList[self.curDzIdx].netData
local guidStr=netdata.net.discipleguidStr

return self.useDzGuidStr==guidStr and self.useItemid==self.selectItemid
end

function UIFuncItemUseWin:getCurSelectDzGuid()
local netdata=self.disciplesList[self.curDzIdx].netData
local guid=netdata.net.discipleguid
return guid
end

function UIFuncItemUseWin:refreshDzPanel(isJump)
local dataNum=#self.disciplesList
self.dzScrollview:setChildScrollViewCreateGrids(dataNum,4)
local grids=self.dzScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local netData=self.disciplesList[i].netData.net
local guid=netData.discipleguid
local item=grids[i-1]
if item then

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(28,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))


local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)

self:refreshDzItemDesc(i)
local rate=0
if self.skillid then

rate=dzSpecialityGrowEffectController:getProskillExpRateLookup(netData,self.skillid,2,false)
end
item:SetChildActive(21,rate>0)

item:SetChildActive(20,i==self.curDzIdx)

item:SetChildLongTouch(-1,1,0.5,function(...)
self:showPlayerDzInfoWinOnLongPressed(i)
end)
end
end
if isJump then
self.dzScrollview:setChildScrollViewSelectItem(self.curDzIdx-1,false,false,false)
end
end

function UIFuncItemUseWin:showPlayerDzInfoWinOnLongPressed(index)
local dzData=self.disciplesList[index]
local netData=dzData.netData
local guid=netData.net.discipleguid
otherPlayerController:openSelfPlayerDZInfoWin({guid})
end


function UIFuncItemUseWin:refreshDzItemDesc(index)
local widget=self.dzScrollview:getChildScrollViewItemWidget(index-1)
if widget==nil then return end
local descStr=''
local netdata=self.disciplesList[index].netData
local guid=netdata.net.discipleguid
local allAddValue=self:getAllItemAddValue()
local showAddVal=self.curDzIdx==index and allAddValue>0
if self.curItemType==item_funtion_type.liaoshang then
local injury=UIDiscipleModel:getDiscipleInjury(guid)
local colorStr=eInjuryType.getType(injury)>=eInjuryType.eSevere and'#c82c2c'or'#ca631d'
local injuryStr=UIDiscipleModel:getDiscipleInjuryName(guid)
if injury>0 then
if showAddVal then
local showAddValStr=allAddValue>=injury and injury or allAddValue
descStr=FMT.fmt('<color={0}>{1}</color>（{2}<color=#549327>-{3}</color>）',colorStr,injuryStr,injury,showAddValStr)
else
descStr=FMT.fmt('<color={0}>{1}</color>（{2}）',colorStr,injuryStr,injury)
end
else
descStr=FMT.fmt('<color={0}>{1}</color>',colorStr,injuryStr)
end
elseif self.curItemType==item_funtion_type.shouyuan then
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(guid)
if shouyuan<0 then
descStr='无限'
else
if showAddVal then
descStr=FMT.fmt('<color=#7d3b17>寿元：</color>{0}<color=#549327>+{1}</color>',shouyuan,allAddValue)
else
descStr=FMT.fmt('<color=#7d3b17>寿元：</color>{0}',shouyuan)
end
end
elseif self.curItemType==item_funtion_type.pro_skill_exp then
local jobType
if self.skillid then
jobType=self.skillid
elseif self.itemConfig then
local funcparam=self.itemConfig.funcparam
jobType=funcparam.skillid
end
local proskillList=netdata.net.proskillList
local curPro=proskillList[jobType]
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,jobType,'name')
descStr=FMT.fmt('<color=#7d3b17>{0}</color>：{1}级',name,curPro.level)
else
if self.curFuncTypeArgs and self.curFuncTypeArgs.dzItemDesc then
descStr=self.curFuncTypeArgs:dzItemDesc(self,guid,self.clickProSkillIdx,index==self.curDzIdx,self.itemConfig.funcparam)
end
end
widget:SetChildText(4,descStr)

local needGray=false
if self.curFuncTypeArgs then
needGray=self.curFuncTypeArgs.grayDizi or false
end

local gray=false
if needGray then
gray=not self.curFuncTypeArgs:checkUseFunc(self,self.itemConfig.funcparam,guid,self.clickProSkillIdx,false)
end


widget:SetChildGray(0,gray)

comHelper.setChildModelRawImage(widget,guid,3,0,eHeadCenterType.eHead,nil,gray)
if self.curItemType==item_funtion_type.baseAttr6 then
local attrList=UIDiscipleModel:getFixAttrBase(netdata.net)
local color=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx2(attrList)

local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata.net,color)
widget:SetChildCSImageSprite(0,abname,iconname)
widget:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])
else
local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata.net)
widget:SetChildCSImageSprite(0,abname,iconname)
widget:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])
end


end

function UIFuncItemUseWin:onClickDzIconCallback(clickCount,index)

if self.curDzIdx==index+1 then return end
self.lastDzIndex=self.curDzIdx
self.curDzIdx=index+1
local lastWidget=self.dzScrollview:getChildScrollViewItemWidget(self.lastDzIndex-1)
local widget=self.dzScrollview:getChildScrollViewItemWidget(index)
lastWidget:SetChildActive(20,false)
widget:SetChildActive(20,true)
self:resetSelectCount()
self:refreshNeedChangeInfo()
end


function UIFuncItemUseWin:refreshNeedChangeInfo()
if self.lastDzIndex then
self:refreshDzItemDesc(self.lastDzIndex)
end
self:refreshDzItemDesc(self.curDzIdx)
if self.curItemType==item_funtion_type.pro_skill_exp then
self:refreshProSkilInfo(nil,true)
end
if self.curFuncTypeArgs then
self:refreshPanelFunc()
end
end

function UIFuncItemUseWin:onDropdownChange(idx)

idx=idx+1
self.sortTypeIdx=idx
self:sortDiscipleList()
self:refreshDzPanel()
end

function UIFuncItemUseWin:onDropdownCreate(scrollTrans,contentTrans)
local idx=self.sortTypeIdx and self.sortTypeIdx-1 or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=idx*_dropItemHeight
else
posY=0
end
if posY<=0 then posY=0 end

contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UIFuncItemUseWin.selectConditionBack(data)

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
_this:sortDiscipleList()
_this:refreshDzPanel()

local showRight=_this.disciplesList~=nil and#_this.disciplesList>0
_this.rightPanel:setActive(showRight)
if showRight then
_this:refreshPanelFunc()
end
end



function UIFuncItemUseWin:sortShowItems(reset)
local itemList=itemsLookup:get_function_items(self.curItemType)or{}
if self.curFuncTypeArgs and self.curFuncTypeArgs.getMutipleTypeItemList then
itemList=self.curFuncTypeArgs:getMutipleTypeItemList()
else
itemList=itemsLookup:get_function_items(self.curItemType)or{}
end
local showList={}
for k,v in pairs(itemList)do
local num=bagModel.getItemCountById(v.id)
if num>0 then
if self.curItemType==item_funtion_type.pro_skill_exp then
if self.skillid then
local itemFunc=v.funcparam
if self.skillid==itemFunc.skillid then
table.insert(showList,v)
end
elseif self.itemConfig then
local funcparam=self.itemConfig.funcparam
local skillid=funcparam.skillid
local itemFunc=v.funcparam
if itemFunc.skillid==skillid then
table.insert(showList,v)
end
end
else
if self.curFuncTypeArgs and self.curFuncTypeArgs.canAddItemList then
if self.curFuncTypeArgs:canAddItemList(self,v)then
table.insert(showList,v)
end
else
table.insert(showList,v)
end
end
local item=showList[#showList]
if item then
item.sortTag=v.color*-1000000+v.id
end
end
end
table.sort(showList,function(a,b)return a.sortTag<b.sortTag end)
self.itemList=showList

for i,v in ipairs(showList)do
v.sortTag=nil
if self.selectIndex==nil and v.id==self.selectItemid then
self.selectIndex=i
end
end
self.maxUseCnt=0
if#showList>0 then
if self.selectIndex==nil or reset then
self.selectIndex=1
self.selectItemid=showList[self.selectIndex].id
end
if self.selectItemid==nil then
self.selectItemid=showList[self.selectIndex].id
end
self.itemConfig=itemsConfig.getConfig(self.selectItemid)
if self.selectIndex then
self.maxUseCnt=self:getMaxUseCnt()
end
if self.curItemType==item_funtion_type.liaoshang then
self:setLiaoShangDanUseCount()
elseif self.curItemType==item_funtion_type.pro_skill_exp then
self:setProSkillDanUseCount()
elseif self.curItemType==item_funtion_type.shouyuan then
self:setShouYuanDanUseCount()
end
if self.curFuncTypeArgs and self.curFuncTypeArgs.resetSelectCount then
self.curFuncTypeArgs:resetSelectCount(self)
end
end
end

function UIFuncItemUseWin:getMaxUseCnt()
local itemid=self.selectItemid
local maxCnt=0
if itemid then
local dzguid=self:getCurSelectDzGuid()
maxCnt=UIFuncItemUseModel.getMaxUseNum(dzguid,itemid)
end
return maxCnt
end



function UIFuncItemUseWin:refreshItemPanel(reset)
self:sortShowItems(reset)
local length=#self.itemList
local col=4
local num=math.ceil(length/col)*col
if length>0 then
num=num+col*2
end
self.itemsScrollview:setChildScrollViewCreateGrids(num,col)
local grids=self.itemsScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
if self.itemList[i]then
local itemid=self.itemList[i].id
local have=bagModel.getItemCountById(itemid)
local conf={itemid=itemid,itemcount=have,showCountBG=true}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetPropData(propData)
item:SetChildActive(8,self.selectIndex==i)
else
local propData=itemsComponentHelper.getCommonTempDataSmall()
propData[PropIndex(DataPropKey.eWidgetActive,9)]=true
item:SetPropData(propData)
end
end
end
if self.selectIndex then
self.itemsScrollview:setChildScrollRectEnable(false)
self.itemsScrollview:setChildScrollViewSelectItem(self.selectIndex-1,false,false,false)
self.itemsScrollview:setChildScrollRectEnable(true)
end
end

function UIFuncItemUseWin:onClickUseItemCallback(clickCount,index)

if self.selectIndex==index+1 then return end
local itemData=self.itemList[index+1]
if itemData==nil then return end
local itemid=itemData.id
self.selectItemid=itemid

if self.selectIndex then
local lastItem=self.itemsScrollview:getChildScrollViewItemWidget(self.selectIndex-1)
if lastItem then
lastItem:SetChildActive(8,false)
end
end
local item=self.itemsScrollview:getChildScrollViewItemWidget(index)
item:SetChildActive(8,true)
self.selectIndex=index+1

if self.curFuncTypeArgs then
self:sortShowItems(false)
self:sortDiscipleList()
self:refreshDzPanel()
self:refreshPanelFunc()
end
self:resetSelectCount()
self:refreshNeedChangeInfo()
end

function UIFuncItemUseWin:onLongClickUseItem(clickCount,index)

local itemid=self.itemList[index+1].id
if itemid==-1 or itemid==0 then
return
end
tipsManager.showTips({itemid=itemid})
end

function UIFuncItemUseWin:getAllItemAddValue()
local itemid=self.selectItemid
local selectCnt=self.selectCnt
if itemid then
local have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if have==0 then
selectCnt=0
end
end
return UIFuncItemUseModel:getAllItemAddValue(itemid,selectCnt)
end

function UIFuncItemUseWin:resetSliderInit()
local showSlider=#self.itemList>0
if showSlider and self.curFuncTypeArgs then
showSlider=self.curFuncTypeArgs.showSlider
end
self.selectCount:setActive(showSlider)
if showSlider then
local mixCount=1
local curSeclet=self.selectCnt
local maxCnt=self.maxUseCnt
if self.selectCnt==0 or self.maxUseCnt==1 then
mixCount=0
curSeclet=1
maxCnt=1
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),mixCount==1)
self.winlua:SetChildImageRaycast(self.addBtn:getID(),mixCount==1)
self.winlua:SetChildImageRaycast(self.subBtn:getID(),mixCount==1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),curSeclet,mixCount,maxCnt,self.on_slider_change)
end
end

function UIFuncItemUseWin:resetSelectCount()
self.maxUseCnt=self:getMaxUseCnt()
if self.curItemType==item_funtion_type.liaoshang then
self:setLiaoShangDanUseCount()
elseif self.curItemType==item_funtion_type.pro_skill_exp then
self:setProSkillDanUseCount()
elseif self.curItemType==item_funtion_type.shouyuan then
self:setShouYuanDanUseCount()
end

if self.curFuncTypeArgs and self.curFuncTypeArgs.resetSelectCount then
self.curFuncTypeArgs:resetSelectCount(self)
end

self:resetSliderInit()
end



function UIFuncItemUseWin:onShaiXuanBtn()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=discipleLookup:getConditonFilter()
end
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selectConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIFuncItemUseWin:onSortBtn()
self.sortOrder=not self.sortOrder
self:sortDiscipleList()
self:refreshDzPanel()
end

function UIFuncItemUseWin:onUseBtn()
local allAddValue=self:getAllItemAddValue()
if allAddValue<=0 then
UIManager.info('尚未选择使用的道具')
return
end

local canUse=false
local str=''
local guid=self:getCurSelectDzGuid()
local isMax=false
if self.curItemType==item_funtion_type.liaoshang then
canUse,str=UIFuncItemUseModel:checkFuShangZhi(guid)
elseif self.curItemType==item_funtion_type.shouyuan then
canUse,str=UIFuncItemUseModel:checkShouYuan(guid)
elseif self.curItemType==item_funtion_type.pro_skill_exp then
local proskillList,jobType=self:getCurDzProSkillData()
isMax,str=UIFuncItemUseModel:checkProSkillLvMax(proskillList,jobType)
canUse=not isMax
end

if self.curFuncTypeArgs and self.curFuncTypeArgs.checkUseFunc then
local cond_str
canUse,cond_str=self.curFuncTypeArgs:checkUseFunc(self,self.itemConfig.funcparam,guid,self.clickProSkillIdx,true,self.selectCnt)
if not canUse then
if cond_str~=nil and cond_str~=''then
local item=self.itemsScrollview:getChildScrollViewItemWidget(self.selectIndex-1)
local pos=Vector2.New(-15,30)

local str
if string.lenEx(cond_str)>15 then
local str1=utf8.sub(cond_str,1,15)
local str2=utf8.sub(cond_str,16)
str=FMT.fmt("{0}\n{1}",str1,str2)
else
str=cond_str
end

UIManager:showWindow('UIConditionTipsOne',{str=str,posWidget=item,pos=pos})
end
return
end
end

if not canUse then
if isMax then
local dzname=UIDiscipleModel:getDiscipleName(guid)
UIManager.info(FMT.fmt('弟子{0}等级已满级',dzname))
elseif str~=nil then
UIManager.info(str)
end
return
end


local isOldUse=self:getIsOldUse()
local okCb=function(showTips,okcallback)
if showTips and not isOldUse then
local dzname=UIDiscipleModel:getDiscipleName(guid)
local itemConfig=itemsConfig.getConfig(self.selectItemid)
local colorStr=FONT_COLOR_VAL[itemConfig.color]
local tips=FMT.fmt('是否确认要对<color=#ca631d>{0}</color>使用<color={1}><{2}></color>',dzname,colorStr,itemConfig.name)
UIDialogManager.getConfirmDialog3(nil,tips,function()
bagProtocolControl.req_dizi_use_item(guid,self.selectItemid,self.selectCnt,isOldUse,self.setUseRecordData)
if okcallback then
okcallback()
end
end,REPEAT_TYPE.eUseTeZhiItemTips)
else
bagProtocolControl.req_dizi_use_item(guid,self.selectItemid,self.selectCnt,isOldUse,self.setUseRecordData)
if okcallback then
okcallback()
end
end
end
if self.curItemType==item_funtion_type.baseAttr6 then
UIFuncItemUseModel:checkBaseAttr6ItemTips(guid,self.selectItemid,okCb)
elseif self.curItemType==item_funtion_type.tezhiSub then

local itemConfig=itemsConfig.getConfig(self.selectItemid)
local funcparam=itemConfig.funcparam
local extra=funcparam.extra

if extra then
local movetype=extra[1][2][6]

if movetype then
local tzid=movetype[2][1][1]
if tzid==4 then

local canUseFlag=self:judeHaveCanDeleteTeZhi(DISCIPLE_SPECIALITY_TYPE.eStrange)
if not canUseFlag then
local strange_str="该弟子身上的怪癖无法被消除"
if strange_str~=nil and strange_str~=''then
local item=self.itemsScrollview:getChildScrollViewItemWidget(self.selectIndex-1)
local pos=Vector2.New(-15,30)
UIManager:showWindow('UIConditionTipsOne',{str=strange_str,posWidget=item,pos=pos})
end
return
end
end
end

end


if funcparam.tzitemdesc then
local topPageList=self.curFuncTypeArgs.topPageList[self.clickProSkillIdx]
local sType=topPageList.sortTagArg[2]
UIFuncItemUseModel:checkTeZhiSubItemTips(guid,self.selectItemid,okCb,sType)
else
okCb(true)
end
elseif self.curItemType==item_funtion_type.jj_xiuweidan then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local jjfloor=UIDiscipleModel:getJJFloor(jjlv)
local useCount=UIDiscipleModel:getTuPoDanUseCount(guid)
local limitCnt=FeiShengTaiModel.getTuPoDanUseCountLimit(jjfloor)
if useCount>=limitCnt then
UIManager.info('服用丹药次数已满')
return false
end

local isCanUse,cond=itemsLookup:checkDicipleUseItemCondition(guid,self.selectItemid)
if not isCanUse then
local str=UIDiscipleModel:getUseGoodStr(cond)











UIManager.error(str)
return
end

local netData=UIDiscipleModel:getDiscipleData(guid)

local jjlv=netData.jingjielv
local curjjexp=UIDiscipleModel:calculationJJExp(guid)
local nxjjexp=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'exp')
local itemConfig=itemsConfig.getConfig(self.selectItemid)
local funcparam=itemConfig.funcparam
local exp=funcparam.exp or 0

local isOut=curjjexp+exp>nxjjexp
if isOut then
local colorStr=FONT_COLOR_VAL[itemConfig.color]
local desc=FMT.fmt("境界修为将溢出，是否继续使用<color={0}><{1}></color>？",colorStr,itemConfig.name)
UIDialogManager.getConfirmDialog3(nil,desc,function()
okCb()
end,REPEAT_TYPE.eFuncItemUseJJOut)
return
else
okCb(true)
end
elseif self.curItemType==item_funtion_type.lt_jingyandan then
local isCanUse,cond=itemsLookup:checkDicipleUseItemCondition(guid,self.selectItemid)
if not isCanUse then
local str=''
local lianti=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLiantiLv,cond)
if lianti~=nil then
local lt_name=UIDiscipleModel:getLTNameX(lianti[1])
str=str..FMT.fmt('{0}期弟子才可以服用',lt_name)
end











UIManager.error(str)
return
end

local netData=UIDiscipleModel:getDiscipleData(guid)

local ltlv=netData.liantilv
local curltexp=netData.liantiexp
local nxltexp=cfgHelper.get2(cfg_disciplelianticonfig_get,ltlv,'exp')
local itemConfig=itemsConfig.getConfig(self.selectItemid)
local funcparam=itemConfig.funcparam
local exp=funcparam.exp or 0

local isOut=curltexp+exp>nxltexp
if isOut then
local colorStr=FONT_COLOR_VAL[itemConfig.color]
local desc=FMT.fmt("炼体修为将溢出，是否继续使用<color={0}><{1}></color>？",colorStr,itemConfig.name)
UIDialogManager.getConfirmDialog3(nil,desc,function()
okCb(true)
end,REPEAT_TYPE.eFuncItemUseLTOut)
return
else
okCb(true)
end
else
okCb(true)
end
end




function UIFuncItemUseWin:useHideAddProgress(curexp,maxexp,allAddValue)
self:stopProgressTimer()
self.proAddExp:animateThreeParams(0,maxexp,0)
self.progressTimer1=self:delayDo(0.8,function()
self.proAddExp:animateThreeParams(curexp+allAddValue,maxexp,0)
end)



end

function UIFuncItemUseWin:stopProgressTimer()
if self.progressTimer1 then
self:stopTimerByID(self.progressTimer1)
self.progressTimer1=nil
end




end

function UIFuncItemUseWin:onClickClose()


self:closeSelf()

end

function UIFuncItemUseWin:onMaxCnt()
self.selectCnt=self.maxUseCnt
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIFuncItemUseWin:onSubBtn()
end

function UIFuncItemUseWin:onAddBtn()
end

function UIFuncItemUseWin:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.maxUseCnt then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIFuncItemUseWin:onSliderChange(value)
self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
self:refreshNeedChangeInfo()
end

function UIFuncItemUseWin:onTipsClick()
if self.curItemType~=item_funtion_type.pro_skill_exp then
if not zongmenModel:haveBuildByBuildId(jumpbuildid)then
return
end
local jumpParam={type=0,id=501,args={}}
jumpManager:jump(jumpParam)
self:closeSelf()
end
end


function UIFuncItemUseWin.on_item_changed(changeType,itemguid,itemid,oldVal,newVal)
local have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
_this:refreshItemPanel(have==0)
if have==0 then
_this:sortDiscipleList()
_this:refreshDzPanel(true)
end
_this:refreshOption()
_this:refreshDzItemDesc(_this.curDzIdx)
if _this.curItemType==item_funtion_type.pro_skill_exp then
_this:refreshProSkilInfo(nil,false)
end
if _this.curFuncTypeArgs then
_this:refreshPanelFunc()
end
end

function UIFuncItemUseWin.onShowDiscipleChanged(eType,datas)
UIFuncItemUseModel.onShowDiscipleChanged(eType,datas,true)
end


function UIFuncItemUseWin:initAddTeZhiPanelInfo()
self.normalItem:setChildAnchoredPosition(Vector3.New(0,-150,0))
self.normalItemScrollview:setChildSizeDelta(319,210)
self.teZhiPanel:setActive(true)
local checkNew=false
local guid=self:getCurSelectDzGuid()

local topPageList=self.curFuncTypeArgs.topPageList[self.clickProSkillIdx]
local sType=topPageList.sortTagArg[2]
local list=UIDiscipleModel:getDiscipleSpeciality(guid,sType)
local newLookUp={}
if self.selectTeZhiGuid==guid then














end
self.selectTeZhiGuid=guid
self.selectTeZhiList=list or{}
if list then
local dataNum=#list
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local v=list[i].param_1
local cfg=UIDiscipleModel:getSpecialityConfig(sType,v)
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onDescSlotClick(i,cfg,guid)
end)
if checkNew then
item:SetChildActive(3,newLookUp[v]~=nil)
else
item:SetChildActive(3,false)
end
end
end
self.nullTeZhi:setActive(false)
else
self.descListPanel:setChildLayoutGroupCreateItems(0)
self.nullTeZhi:setActive(true)
end
end

function UIFuncItemUseWin:initSubTeZhiPanelInfo()
self.normalItem:setChildAnchoredPosition(Vector3.New(0,-150,0))
self.normalItemScrollview:setChildSizeDelta(319,210)
self.teZhiPanel:setActive(true)

local guid=self:getCurSelectDzGuid()
local topPageList=self.curFuncTypeArgs.topPageList[self.clickProSkillIdx]
local sType=topPageList.sortTagArg[2]
local list=UIDiscipleModel:getDiscipleSpeciality(guid,sType)
local funcparam=self.itemConfig.funcparam
if list then
local dataNum=#list
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local v=list[i].param_1
local cfg=UIDiscipleModel:getSpecialityConfig(sType,v)
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onDescSlotClick(i,cfg,guid)
end)
end
end
self.nullTeZhi:setActive(false)
else
self.descListPanel:setChildLayoutGroupCreateItems(0)
self.nullTeZhi:setActive(true)
end
end

function UIFuncItemUseWin:onDescSlotClick(idx,cfg,guid)
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)
local netData=UIDiscipleModel:getDiscipleData(guid)
if UIDiscipleModel.onClickClientSpeciality(item,netData,cfg,eDirectionType.eLeft)then
return
end
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=guid,config=cfg})
end

function UIFuncItemUseWin:init6AttrPanelInfo()
self.normalItem:setChildAnchoredPosition(Vector3.New(0,-218,0))
self.normalItemScrollview:setChildSizeDelta(319,85)

self.polygonAttrPanel:setActive(true)

local guid=self:getCurSelectDzGuid()
local netData=UIDiscipleModel:getDiscipleData(guid)
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
local funcparam=self.itemConfig.funcparam

local checkData={}
local allAddData={}
for i,v in ipairs(funcparam.extra)do
if v[2][3]then
local sType=v[2][3][1]




checkData[sType]=v[1][3]
allAddData[sType]=(allAddData[sType]or 0)+v[2][3][2]
end
end

local attrList=UIDiscipleModel:getFixAttrBase(netData)

local ratelistAdd={}
for i,v in ipairs(attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
if allAddData[i]and checkData[i]and a>=checkData[i][2]and a<=checkData[i][3]then
ratelistAdd[lookup[i]]=(aa+(aa+allAddData[i]>=checkData[i][3]and checkData[i][3]-aa or allAddData[i])*self.selectCnt)/(polygonMaxValue)
else
ratelistAdd[lookup[i]]=aa/polygonMaxValue
end
end

local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=attrList[attrType]==0 and 1 or attrList[attrType]
if allAddData[i]and checkData[i]and v>=checkData[i][2]and v<=checkData[i][3]then
local add=((v+allAddData[i]*self.selectCnt)>=(checkData[i][3]+allAddData[i]))and checkData[i][3]+allAddData[i]-v or allAddData[i]*self.selectCnt

wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#549327>{1}</color>+<color=#549327>{2}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v,add))
else
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#549327>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end

end
wiget:SetChildUIPolygonImage(6,ratelist,0)
wiget:SetChildUIPolygonImage(8,ratelistAdd,0)

local color=UIDiscipleModel:getDiscipleColor(guid)
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)

end

function UIFuncItemUseWin:initBaseAttr6PanelInfo()
self.normalItem:setChildAnchoredPosition(Vector3.New(0,-218,0))
self.normalItemScrollview:setChildSizeDelta(319,150)

self.polygonAttrPanel:setActive(true)

local guid=self:getCurSelectDzGuid()
local netData=UIDiscipleModel:getDiscipleData(guid)
local sum=UIDiscipleModel:getFixAttrBaseSum(netData)
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
local funcparam=self.itemConfig.funcparam
local target=funcparam.target
local ratelistTotal={}
local ratelistAdd={}
local attrList=UIDiscipleModel:getFixAttrBase(netData)

local target_color=funcparam.color
local attr_limit_list=funcparam.limit
local addList=UIFuncItemUseModel.calcAttr6ForSoul(attrList,target,attr_limit_list)or{}
for i,v in ipairs(attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
local addVal=addList[i]or 0
if addVal>0 then
ratelistTotal[lookup[i]]=(aa+addVal)/(polygonMaxValue)
else
ratelistTotal[lookup[i]]=aa/(polygonMaxValue)
end

ratelistAdd[i]=addVal
end
local color=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx3(allnum)

local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=attrList[attrType]==0 and 1 or attrList[attrType]
if ratelistAdd[attrType]>0 then
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#549327>{1}</color>+<color=#549327>{2}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v,ratelistAdd[attrType]))
else
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#549327>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end
if target_color and color>=target_color then
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#549327>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end
end
wiget:SetChildUIPolygonImage(6,ratelist,0)
wiget:SetChildUIPolygonImage(8,ratelistTotal,0)


local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)

end


function UIFuncItemUseWin:judeHaveCanDeleteTeZhi(tzType)
local guid=self:getCurSelectDzGuid()
local list=UIDiscipleModel:getDiscipleSpeciality(guid,tzType)
if#list>0 then
for k,v in ipairs(list)do
local forgetConfig=courtroomModel.getForgetConfig(tzType,v.param_1)
if forgetConfig then
return true
end
end
end
return false
end
