







def_class("UIDiscipleBatchZhiliaoWin",UIWindowBase)









function UIDiscipleBatchZhiliaoWin:bindComponents()

self.ScrollView=UIScrollViewSlow.get(self,0)
self.title=UIText.get(self,1)
self.goodlist=UIObject.get(self,2)
self.btn=UIButton.get(self,3)
self.tab1=UIButton.get(self,4)
self.tab2=UIButton.get(self,5)
self.selectab1=UIObject.get(self,6)
self.selectab2=UIObject.get(self,7)
self.success=UIObject.get(self,8)
self.frame=UIButton.get(self,9)

self.btn:setButtonClick(function()self:onBtn()end)

self.tab1:setButtonClick(function()self:onTab1()end)

self.tab2:setButtonClick(function()self:onTab2()end)

self.frame:setButtonClick(function()self:onFrame()end)



end


function UIDiscipleBatchZhiliaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.goodlist);self.goodlist=nil;
_UIObject_release(self.btn);self.btn=nil;
_UIObject_release(self.tab1);self.tab1=nil;
_UIObject_release(self.tab2);self.tab2=nil;
_UIObject_release(self.selectab1);self.selectab1=nil;
_UIObject_release(self.selectab2);self.selectab2=nil;
_UIObject_release(self.success);self.success=nil;
_UIObject_release(self.frame);self.frame=nil;
end

















local _colomn=2
local _slotArray={6,7,8}

function UIDiscipleBatchZhiliaoWin:onLoaded(...)
self:bindComponents()
self.isSetZero=false
self.maxSelect={}
self.lookup={}
self.selectItem={}
self.oldValues={}
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
self._onItemChange=function(...)self:onItemChange(...)end
notifySystem:listenNotify(notifyConfig.on_item_changed,self._onItemChange)



















end

function UIDiscipleBatchZhiliaoWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChange)



end

function UIDiscipleBatchZhiliaoWin:onShow(argtable,afterOnloaded)

self.dzguid=argtable.dzguid
local canvasIdx=argtable.canvasIdx
if canvasIdx then
self:setCanvasIndex(-1,canvasIdx)
end
self.list=argtable.list

self:sortDiziList()
self:onSelect(argtable.type or 1)
end

function UIDiscipleBatchZhiliaoWin:onShowArgRecv(argtable)

self:onSelect(argtable.type or 1)
end

function UIDiscipleBatchZhiliaoWin:onHide()

end

function UIDiscipleBatchZhiliaoWin:clearData()
self.maxSelect={}
self.lookup={}
self.selectItem={}
self.reqArray={}
end



function UIDiscipleBatchZhiliaoWin:freshDiziPanel()
local selectIdx=self.selectIdx
local openFuncType=self.list[selectIdx].type
local list=self.list[selectIdx].list
local len=#list
local row=math.ceil(len/_colomn)
if self.autoSelect then
for i,diziInfo in ipairs(list)do
local diziguid=diziInfo.netData.net.discipleguid
self:autoFenPei(diziguid)
end
self.autoSelect=false
end
self.ScrollView:clearSlowItems()
self.ScrollView:freshSlowGrids(len,row,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIDiscipleBatchZhiliaoWin:bindGrid(index,widget)
local selectIdx=self.selectIdx
local openFuncType=self:getSelectFunType()
local list=self.list[selectIdx].list
local diziInfo=list[index]
local diziguid=diziInfo.netData.net.discipleguid
local diziguidStr=tostring(diziguid)
local dzName=UIDiscipleModel:getDiscipleName(diziguid)
local dzcolor=UIDiscipleModel:getDiscipleColor(diziguid)
local isShouYuan=openFuncType==item_funtion_type.shouyuan
local isInjury=openFuncType==item_funtion_type.liaoshang
local isChuiWei=UIDiscipleModel:checkShouYuanChuiWeiType(diziguid)
local isFushang=false
if isInjury then
isChuiWei=UIDiscipleModel:checkInjuryChuiWeiType(diziguid)
isFushang=UIDiscipleModel:checkInjuryFushangType(diziguid)
end

local itemCfgs=self.goodDataList
local needVal=self:getNeedVal(openFuncType,diziguid)

widget:SetChildText(0,dzName)
widget:SetChildActive(1,isChuiWei)
comHelper.setChildModelRawImage(widget,diziguid,2,0,eHeadCenterType.eHead,nil,isChuiWei)
widget:SetChildActive(9,isChuiWei or isFushang)
widget:SetChildActive(10,not isChuiWei and not isFushang)
widget:SetChildCSImageSprite(11,globalABLookup.diciplecolorframe,discipleColorToFrame[dzcolor])
widget:SetChildText(12,FMT.fmt("<color=#7D3B17>战力</color>{0}",UIDiscipleModel:getDiscipleFightValue(diziguid)))

widget:SetChildLongTouch(13,index,0.5,function()
self:onLongTouchClick(index)
end)
widget:SetChildActive(14,isChuiWei)

if not isChuiWei and isFushang then
local injury=UIDiscipleModel:getDiscipleInjury(diziguid)
local injuryIcon
local injuryDesc
local icon_=eInjuryType:getIcon(injury)
if icon_~=nil then
injuryIcon='icon_fushang'
injuryDesc=FMT.fmt('<color=#FD7474>{0}</color>',eInjuryType:getName(injury))
end
local showInjury=injuryIcon~=nil
widget:SetChildActive(15,showInjury)
if showInjury then
widget:SetChildCSImageSprite(16,globalABLookup.global,injuryIcon)
widget:SetChildText(17,injuryDesc)
end
else
widget:SetChildActive(15,false)
end

if self.maxSelect[openFuncType]==nil then self.maxSelect[openFuncType]={}end
self.maxSelect[openFuncType][diziguidStr]={}
local maxSelect=self.maxSelect[openFuncType][diziguidStr]

if self.lookup[openFuncType]==nil then self.lookup[openFuncType]={}end
self.lookup[openFuncType][diziguidStr]=index

if self.oldValues[openFuncType]==nil then self.oldValues[openFuncType]={}end

if isChuiWei or isFushang then
local tadd=0
for i,v in ipairs(_slotArray)do
local itemidx=v
local cfg=itemCfgs[i]
if cfg==nil then
widget:SetChildActive(v,false)
else
widget:SetChildActive(v,true)
local item=widget:GetChildCSGUIBaseItem(itemidx)
local itemid=cfg.id
local funcparam=cfg.funcparam
local heal=funcparam.heal
local shouyuan=funcparam.shouyuan
local add=isShouYuan and shouyuan or isInjury and heal or 0
local maxNum=math.ceil(needVal/add)
maxSelect[itemid]=maxNum
local num=self:getSelectNumByDZ(diziguid,itemid)
tadd=tadd+num*add
local iconName=iconHelper.getIconName(itemid)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=cfg.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local isGray=num<=0

item:SetChildQulaity(0,cfg.color)
item:SetChildGray(0,isGray)
item:SetChildIcon(1,iconName,false)
item:SetChildGray(1,isGray)
item:SetChildText(2,num)
item:SetChildActive(3,num>0)
item:SetChildText(4,stageStr)
item:SetChildActive(5,stageStr~='')
item:SetChildActive(6,num>0)
item:SetChildButtonClick(6,function()self:onClickGridButton(diziguid,itemid)end,true)
item:SetBaseItemClickEvent(-1,function(...)self:onClickItem(diziguid,itemid)end)
end
end

if isShouYuan then
local shouyuan=cfg_discipledyingconfig_get(1).shouyuan
local max=shouyuan[2]
local val=UIDiscipleModel:getDiscipleShouYuan(diziguid)
local str=''
if tadd>0 then
str=FMT.fmt('寿元：{0}+{1}/{2}',val,tadd,max)
else
str=FMT.fmt('寿元：{0}/{1}',val,max)
end
self.oldValues[openFuncType][diziguidStr]=val
widget:SetProgressBarAniWithThreeParams(3,val,max,0)
widget:SetProgressBarAniWithThreeParams(4,val+tadd,max,0)
widget:SetChildText(5,str)
elseif isInjury then
local range=cfg_discipleinjuryconfig_get(1).range
local injury=range[1][1]
local max=injury[1]
local rangeMax=range[#range][1]
local rmax=rangeMax[2]
local val=UIDiscipleModel:getDiscipleInjury(diziguid)
local left=rmax-max
local cur=max-val+left
local str=''
if tadd>0 then
str=FMT.fmt('负伤：{0}<color=#56eb5d>（-{1}）</color>',val,math.min(val,tadd))
else
str=FMT.fmt('负伤：{0}',val)
end
self.oldValues[openFuncType][diziguidStr]=val
widget:SetProgressBarAniWithThreeParams(3,cur,rmax,0)
widget:SetProgressBarAniWithThreeParams(4,cur+tadd,rmax,0)
widget:SetChildText(5,str)
end
end
end

function UIDiscipleBatchZhiliaoWin:freshItem(diziguid,ret)
local diziguidStr=tostring(diziguid)
local openFuncType=self:getSelectFunType()
local idx=self.lookup[openFuncType][diziguidStr]
if idx==nil then return end
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget==nil then return end
local isShouYuan=openFuncType==item_funtion_type.shouyuan
local isInjury=openFuncType==item_funtion_type.liaoshang
local isChuiWei=UIDiscipleModel:checkShouYuanChuiWeiType(diziguid)
local isFushang=false
if isInjury then
isChuiWei=UIDiscipleModel:checkInjuryChuiWeiType(diziguid)
isFushang=UIDiscipleModel:checkInjuryFushangType(diziguid)
end
local itemCfgs=self.goodDataList
widget:SetChildActive(9,isChuiWei or isFushang)
widget:SetChildActive(10,not isChuiWei and not isFushang)
widget:SetChildActive(1,isChuiWei)

widget:SetChildActive(14,isChuiWei)

if not isChuiWei and isFushang then
local injury=UIDiscipleModel:getDiscipleInjury(diziguid)
local injuryIcon
local injuryDesc
local icon_=eInjuryType:getIcon(injury)
if icon_~=nil then
injuryIcon='icon_fushang'
injuryDesc=FMT.fmt('<color=#FD7474>{0}</color>',eInjuryType:getName(injury))
end
local showInjury=injuryIcon~=nil
widget:SetChildActive(15,showInjury)
if showInjury then
widget:SetChildCSImageSprite(16,globalABLookup.global,injuryIcon)
widget:SetChildText(17,injuryDesc)
end
else
widget:SetChildActive(15,false)
end

comHelper.setChildModelRawImage(widget,diziguid,2,0,eHeadCenterType.eHead,nil,isChuiWei)
if isChuiWei or isFushang then
local tadd=0
for i,v in ipairs(_slotArray)do
local itemidx=v
local cfg=itemCfgs[i]
if cfg then
local item=widget:GetChildCSGUIBaseItem(itemidx)
local itemid=cfg.id
local funcparam=cfg.funcparam
local heal=funcparam.heal
local shouyuan=funcparam.shouyuan
local add=isShouYuan and shouyuan or isInjury and heal or 0
local needVal=self:getNeedVal(openFuncType,diziguid)
local maxNum=math.ceil(needVal/add)
local num=self:getSelectNumByDZ(diziguid,itemid)
tadd=tadd+num*add
local iconName=iconHelper.getIconName(itemid)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=cfg.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local isGray=num<=0
item:SetChildGray(0,isGray)
item:SetChildGray(1,isGray)
item:SetChildText(2,num)
item:SetChildActive(6,num>0)
end
end

if isShouYuan then
local shouyuan=cfg_discipledyingconfig_get(1).shouyuan
local max=shouyuan[2]
local val=UIDiscipleModel:getDiscipleShouYuan(diziguid)
local str=''
if tadd>0 then
str=FMT.fmt('寿元：{0}+{1}/{2}',val,tadd,max)
else
str=FMT.fmt('寿元：{0}/{1}',val,max)
end
self.oldValues[openFuncType][diziguidStr]=val
widget:SetProgressBarAniWithThreeParams(3,val,max,ret and 0.2 or 0)
widget:SetProgressBarAniWithThreeParams(4,val+tadd,max,not ret and 0.2 or 0)
widget:SetChildText(5,str)
elseif isInjury then
local range=cfg_discipleinjuryconfig_get(1).range
local injury=range[1][1]
local max=injury[1]
local rangeMax=range[#range][1]
local rmax=rangeMax[2]
local val=UIDiscipleModel:getDiscipleInjury(diziguid)
local left=rmax-max
local cur=max-val+left
local str=''
if tadd>0 then
str=FMT.fmt('负伤：{0}<color=#56eb5d>（-{1}）</color>',val,math.min(val,tadd))
else
str=FMT.fmt('负伤：{0}',val)
end
self.oldValues[openFuncType][diziguidStr]=val
widget:SetProgressBarAniWithThreeParams(3,cur,rmax,ret and 0.2 or 0)
widget:SetProgressBarAniWithThreeParams(4,cur+tadd,rmax,not ret and 0.2 or 0)
widget:SetChildText(5,str)
end
end
return not isChuiWei
end

function UIDiscipleBatchZhiliaoWin:onDzItemListUse(array)
local reqArray=self.reqArray or{}
local diziArray={}
local lookup={}
local flag=false
for i,v in ipairs(array)do
local diziguid=v.param_1
local itemid=v.param_2
local num=v.param_3
local info=reqArray[i]or{}
local _diziguid=info[1]
local _itemid=info[2]
local _num=info[3]
if lookup[tostring(diziguid)]==nil then
lookup[tostring(diziguid)]=true
diziArray[#diziArray+1]=diziguid
end
if not flag and tostring(diziguid)~=tostring(_diziguid)or
itemid~=_itemid or num~=_num then
flag=true
end
end
if flag then return end
self.selectItem={}
self.reqArray={}
local hasHeal=false
for i,v in ipairs(diziArray)do
local ret=self:freshItem(v,true)
hasHeal=hasHeal or ret
end
self:freshBottomPanel()
if hasHeal then
self.success:setChildShowEffect(10090,true)
end
local openFuncType=self:getSelectFunType()
if openFuncType==item_funtion_type.shouyuan then
UIManager.info('寿元丹使用成功')
elseif openFuncType==item_funtion_type.liaoshang then
UIManager.info('疗伤丹使用成功')
end

self:getgoodDataList()
self:freshDiziPanel()
self:freshBottomPanel()
end

function UIDiscipleBatchZhiliaoWin:freshBottomPanel()
local dataNum=#self.goodDataList
self.goodlist:setChildScrollViewCreateGrids(dataNum,dataNum)

local goodGrid=self.goodlist:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=goodGrid[i-1]
self:refreshGoodListItem(item,i)
end
end

function UIDiscipleBatchZhiliaoWin:getgoodDataList()
local selectIdx=self.selectIdx
local openFuncType=self.list[selectIdx].type
self.goodDataList=itemsLookup:getItemsByBag(openFuncType)
if#self.goodDataList==0 then
self.goodDataList=itemsLookup:get_function_items(openFuncType)
end
if#self.goodDataList>0 then
table.sort(self.goodDataList,function(a,b)
return a.color<b.color
end)
end
end

function UIDiscipleBatchZhiliaoWin:refreshGoodListItem(item,index)
if item==nil then
item=self.goodlist:getChildScrollViewItemWidget(index-1)
end
local cfg=self.goodDataList[index]
local itemid=cfg.id
local itemNum=bagModel.getItemCountById(itemid)
local selectNum=self:getSelectNum(itemid)
local num=selectNum>0 and FMT.fmt('{0}/{1}',itemNum,selectNum)or itemNum
local conf={itemid=itemid,itemcount=num,showname=false,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
end

function UIDiscipleBatchZhiliaoWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=TIPS_MOVE_POS.eRight})
end
end

function UIDiscipleBatchZhiliaoWin:initDiziData()
local dizilist=UIDiscipleModel:getAllDiscipleDataX()
local hasDizi=dizilist~=nil
self.list={}
if not hasDizi then return false end
local flag=0
local injuryData={}
local shouyuanData={}
for _,v in pairs(dizilist)do
local diziguid=v.netData.net.discipleguid
if UIDiscipleModel:checkInjuryChuiWeiType(diziguid)then
injuryData[#injuryData+1]=v
flag=flag+1
end
if UIDiscipleModel:checkShouYuanChuiWeiType(diziguid)then
shouyuanData[#shouyuanData+1]=v
flag=flag+1
end
end
local list={}
local openFuncType1=item_funtion_type.shouyuan
local list1=itemsLookup:getItemsByBag(openFuncType1)
if#list1==0 then
list1=itemsLookup:get_function_items(openFuncType1)
end
local openFuncType2=item_funtion_type.liaoshang
local list2=itemsLookup:getItemsByBag(openFuncType2)
if#list2==0 then
list2=itemsLookup:get_function_items(openFuncType2)
end
if#shouyuanData>0 and#list1>0 then
list[#list+1]={
type=item_funtion_type.shouyuan,
list=shouyuanData,
}
self.tab1:setActive(true)
else
self.tab1:setActive(false)
end
if#injuryData>0 and#list2>0 then
list[#list+1]={
type=item_funtion_type.liaoshang,
list=injuryData,
}
self.tab2:setActive(true)
else
self.tab2:setActive(false)
end
self.list=list
return flag>0
end

function UIDiscipleBatchZhiliaoWin:sortListByInjury(list)
if#list>1 then
local injury=cfg_discipledyingconfig_get(1).injury
local min=injury[1]

local max=25
table.sort(list,function(a,b)
local diziguid1=a.netData.net.discipleguid
local has1=UIDiscipleModel:getDiscipleInjury(diziguid1)
local need1=has1-max
local diziguid2=b.netData.net.discipleguid
local has2=UIDiscipleModel:getDiscipleInjury(diziguid2)
local need2=has2-max
local sortFirst1=self.dzguid==diziguid1 and 1 or 0
local sortFirst2=self.dzguid==diziguid2 and 1 or 0
if sortFirst1==sortFirst2 then
if need1==need2 then
local ajingjie=UIDiscipleModel:getDiscipleJJLevel(diziguid1)
local bjingjie=UIDiscipleModel:getDiscipleJJLevel(diziguid2)
if ajingjie==bjingjie then
local aColor=UIDiscipleModel:getDiscipleColor(diziguid1)
local bColor=UIDiscipleModel:getDiscipleColor(diziguid2)
if aColor==bColor then
return tonumber(tostring(diziguid1))>tonumber(tostring(diziguid2))
else
return aColor>bColor
end
else
return ajingjie>bjingjie
end
else
return need1>need2
end
else
return sortFirst1>sortFirst2
end
end)
end
end

function UIDiscipleBatchZhiliaoWin:sortListByShouyuan(list)
if#list>1 then
local shouyuan=cfg_discipledyingconfig_get(1).shouyuan
local min=shouyuan[1]
local max=shouyuan[2]
table.sort(list,function(a,b)
local diziguid1=a.netData.net.discipleguid
local has1=UIDiscipleModel:getDiscipleShouYuan(diziguid1)
local need1=max-has1
local diziguid2=b.netData.net.discipleguid
local has2=UIDiscipleModel:getDiscipleShouYuan(diziguid2)
local need2=max-has1
if need1==need2 then
local ajingjie=UIDiscipleModel:getDiscipleJJLevel(diziguid1)
local bjingjie=UIDiscipleModel:getDiscipleJJLevel(diziguid2)
if ajingjie==bjingjie then
local aColor=UIDiscipleModel:getDiscipleColor(diziguid1)
local bColor=UIDiscipleModel:getDiscipleColor(diziguid2)
if aColor==bColor then
return tonumber(tostring(diziguid1))>tonumber(tostring(diziguid2))
else
return aColor>bColor
end
else
return ajingjie>bjingjie
end
else
return need1<need2
end
end)
end
end

function UIDiscipleBatchZhiliaoWin:sortDiziList()
for i,v in ipairs(self.list)do
local type=v.type
local list=v.list
if type==item_funtion_type.liaoshang then
self:sortListByInjury(list)
elseif type==item_funtion_type.shouyuan then
self:sortListByShouyuan(list)
end
end

end

function UIDiscipleBatchZhiliaoWin:getNeedVal(openFuncType,diziguid,isAll)
local isShouYuan=openFuncType==item_funtion_type.shouyuan
local isInjury=openFuncType==item_funtion_type.liaoshang
if isShouYuan then
local shouyuan=cfg_discipledyingconfig_get(1).shouyuan
local min=shouyuan[1]
local max=shouyuan[2]
local has=UIDiscipleModel:getDiscipleShouYuan(diziguid)
return max-has
elseif isInjury then
local isChuiWei=UIDiscipleModel:checkInjuryChuiWeiType(diziguid)
local injury=cfg_discipledyingconfig_get(1).injury
local min=injury[1]
local max=(isAll or isChuiWei)and injury[2]or 25
local has=UIDiscipleModel:getDiscipleInjury(diziguid)
return has-max
end
end

function UIDiscipleBatchZhiliaoWin:getHasAddVal(openFuncType,diziguid)
local isShouYuan=openFuncType==item_funtion_type.shouyuan
local isInjury=openFuncType==item_funtion_type.liaoshang
if isShouYuan then
local shouyuan=cfg_discipledyingconfig_get(1).shouyuan
local min=shouyuan[1]
local max=shouyuan[2]
local has=UIDiscipleModel:getDiscipleShouYuan(diziguid)
return max-has
elseif isInjury then
local injury=cfg_discipledyingconfig_get(1).injury
local min=injury[1]
local max=injury[2]
local has=UIDiscipleModel:getDiscipleInjury(diziguid)
return has-max
end
end

function UIDiscipleBatchZhiliaoWin:onTab1()
self:onSelect(1)
end

function UIDiscipleBatchZhiliaoWin:onTab2()
self:onSelect(2)
end

function UIDiscipleBatchZhiliaoWin:onSelect(idx)
if self.selectIdx==idx then return end
self.isSetZero=false
self:clearData()
self.autoSelect=true
self.selectIdx=idx
self:getgoodDataList()
local openFuncType=self.list[idx].type
local isShouYuan=openFuncType==item_funtion_type.shouyuan
local isInjury=openFuncType==item_funtion_type.liaoshang
self.selectab1:setActive(isShouYuan)
self.selectab2:setActive(isInjury)

self:freshDiziPanel()
self:freshBottomPanel()
end

function UIDiscipleBatchZhiliaoWin:freshBtn()
local openFuncType1=item_funtion_type.shouyuan
local list1=itemsLookup:getItemsByBag(openFuncType1)
if#list1==0 then
list1=itemsLookup:get_function_items(openFuncType1)
end
local openFuncType2=item_funtion_type.liaoshang
local list2=itemsLookup:getItemsByBag(openFuncType2)
if#list2==0 then
list2=itemsLookup:get_function_items(openFuncType2)
end
local active1=#list1>0 and self.list[1]~=nil
local active2=#list2>0 and self.list[2]~=nil
self.activeShouyuan=active1
self.activeLiaoshang=active2
self.tab1:setActive(active1)
self.tab2:setActive(active2)
end

function UIDiscipleBatchZhiliaoWin:onClickItem(diziguid,itemid)
if itemid==-1 then return end
local openFuncType=self:getSelectFunType()
local flag,num=self:getIsUse(diziguid,itemid)
if not flag then
return
end
local isChuiWei=UIDiscipleModel:checkInjuryChuiWeiType(diziguid)
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eUseZhiLiaoTis)
local isShouYuan=openFuncType==item_funtion_type.shouyuan
if not check and num<=25 and not isShouYuan and not isChuiWei then
local showdata=
{
type='UIDialouge',
title='提示',
content='弟子负伤值低于<color=#d4852e>25</color>时可随着时间恢复，是否继续使用疗伤丹？',
oktext='确定',
canceltext='取消',
allowclickBG='true',
timeCount=3,
choosetext='今日不再提示',
okcallback=function(...)
local flag=self:addSelectNum(diziguid,itemid)
if not flag then
return
end
self:freshItem(diziguid)
self:freshBottomPanel()
end,
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eUseZhiLiaoTis,flag)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
return
end
local flag=self:addSelectNum(diziguid,itemid)
if not flag then
return
end
self:freshItem(diziguid)
self:freshBottomPanel()
end

function UIDiscipleBatchZhiliaoWin:onClickGridButton(diziguid,itemid)
if itemid==-1 then return end
local flag=self:deleteSelectNum(diziguid,itemid)
if not flag then
return
end
self:freshItem(diziguid)
self:freshBottomPanel()
end

function UIDiscipleBatchZhiliaoWin:getSelectFunType()
local selectIdx=self.selectIdx
return self.list[selectIdx].type
end

function UIDiscipleBatchZhiliaoWin:getSelectNumByDZ(diziguid,itemid)
local openFuncType=self:getSelectFunType()
local guidStr=tostring(diziguid)
if self.selectItem==nil then return 0 end
local selectByDz=self.selectItem.dizi
if selectByDz==nil then return 0 end
if selectByDz[openFuncType]==nil then return 0 end
if selectByDz[openFuncType][guidStr]==nil then return 0 end
return selectByDz[openFuncType][guidStr][itemid]or 0
end

function UIDiscipleBatchZhiliaoWin:getSelectNum(itemid)
if self.selectItem==nil then return 0 end
local select=self.selectItem.num
if select==nil then return 0 end
return select[itemid]or 0
end

function UIDiscipleBatchZhiliaoWin:getMaxSelectNumByDZ(diziguid,itemid)
local openFuncType=self:getSelectFunType()
local guidStr=tostring(diziguid)
if self.maxSelect[openFuncType]==nil then return 0 end
if self.maxSelect[openFuncType][guidStr]==nil then return 0 end
return self.maxSelect[openFuncType][guidStr][itemid]or 0
end

function UIDiscipleBatchZhiliaoWin:getIsUse(diziguid,itemid,addnum,warning)
local openFuncType=self:getSelectFunType()
local needVal=self:getNeedVal(openFuncType,diziguid,true)
local addVal=self:getTotalAdd(diziguid)
local isShouYuan=openFuncType==item_funtion_type.shouyuan
if addVal>=needVal and not isShouYuan then
if warning~=false then
local name=itemsConfig.getItemName(itemid)
UIManager.error(FMT.fmt('{0}数量已达上限',name))
end
return false
end
addnum=addnum or 1
local num=self:getSelectNum(itemid)
local has=bagModel.getItemCountById(itemid)
if has<(num+addnum)then
if warning~=false then
local name=itemsConfig.getItemName(itemid)
UIManager.error(FMT.fmt('{0}数量不足',name))
gainControl:showGainWin(itemid)
end
return false
end
return true,needVal-addVal
end

function UIDiscipleBatchZhiliaoWin:addSelectNum(diziguid,itemid,addnum,warning)
local openFuncType=self:getSelectFunType()
local needVal=self:getNeedVal(openFuncType,diziguid,true)
local addVal=self:getTotalAdd(diziguid)
local isShouYuan=openFuncType==item_funtion_type.shouyuan
if addVal>=needVal and not isShouYuan then
if warning~=false then
local name=itemsConfig.getItemName(itemid)
UIManager.error(FMT.fmt('{0}数量已达上限',name))
end
return false
end
addnum=addnum or 1
local num=self:getSelectNum(itemid)
local has=bagModel.getItemCountById(itemid)
if has<(num+addnum)then
if warning~=false then
local name=itemsConfig.getItemName(itemid)
UIManager.error(FMT.fmt('{0}数量不足',name))
gainControl:showGainWin(itemid)
end
return false
end

local guidStr=tostring(diziguid)
local openFuncType=self:getSelectFunType()
if self.selectItem==nil then self.selectItem={}end
if self.selectItem.dizi==nil then self.selectItem.dizi={}end
if self.selectItem.dizi[openFuncType]==nil then self.selectItem.dizi[openFuncType]={}end
if self.selectItem.dizi[openFuncType][guidStr]==nil then self.selectItem.dizi[openFuncType][guidStr]={}end
local lastNum=self.selectItem.dizi[openFuncType][guidStr][itemid]or 0
self.selectItem.dizi[openFuncType][guidStr][itemid]=lastNum+addnum

if self.selectItem.num==nil then self.selectItem.num={}end
local lastNum=self.selectItem.num[itemid]or 0
self.selectItem.num[itemid]=lastNum+addnum
return true
end

function UIDiscipleBatchZhiliaoWin:deleteSelectNum(diziguid,itemid)
local numByDz=self:getSelectNumByDZ(diziguid,itemid)
if numByDz<=0 then
UIManager.error('没有选择道具')
return false
end
local guidStr=tostring(diziguid)
local openFuncType=self:getSelectFunType()
if self.selectItem==nil then self.selectItem={}end
if self.selectItem.dizi==nil then self.selectItem.dizi={}end
if self.selectItem.dizi[openFuncType]==nil then self.selectItem.dizi[openFuncType]={}end
if self.selectItem.dizi[openFuncType][guidStr]==nil then self.selectItem.dizi[openFuncType][guidStr]={}end
local lastNum=self.selectItem.dizi[openFuncType][guidStr][itemid]or 0
if lastNum<=0 then
logErr('deleteSelectNum代码有问题')
end
self.selectItem.dizi[openFuncType][guidStr][itemid]=lastNum-1

if self.selectItem.num==nil then self.selectItem.num={}end
local lastNum=self.selectItem.num[itemid]or 0
if lastNum<=0 then
logErr('deleteSelectNum代码有问题')
end
self.selectItem.num[itemid]=lastNum-1
return true
end

function UIDiscipleBatchZhiliaoWin:getTotalAdd(diziguid)
local openFuncType=self:getSelectFunType()
local guidStr=tostring(diziguid)
if self.selectItem==nil then return 0 end
local selectByDz=self.selectItem.dizi
if selectByDz==nil then return 0 end
if selectByDz[openFuncType]==nil then return 0 end
if selectByDz[openFuncType][guidStr]==nil then return 0 end
local temp=selectByDz[openFuncType][guidStr]
local isShouYuan=openFuncType==item_funtion_type.shouyuan
local isInjury=openFuncType==item_funtion_type.liaoshang
local t_add=0
for itemid,num in pairs(temp)do
local cfg=itemsConfig.getConfig(itemid)
local funcparam=cfg.funcparam
local heal=funcparam.heal
local shouyuan=funcparam.shouyuan
local add=isShouYuan and shouyuan or isInjury and heal or 0
t_add=t_add+add*num
end
return t_add
end

function UIDiscipleBatchZhiliaoWin:onBtn()
local array={}
local openFuncType=self:getSelectFunType()
local itemCfgs=itemsLookup:getItemsByBag(openFuncType)
if not itemCfgs or not next(itemCfgs)then

itemCfgs=itemsLookup:get_function_items(openFuncType)
if itemCfgs then
local cfgs=table.deepCopy(itemCfgs)
table.sort(cfgs,function(a,b)
return a.color<b.color
end)
local itemid=cfgs[1].id
local name=itemsConfig.getItemName(itemid)
UIManager.error(FMT.fmt('{0}数量不足',name))
gainControl:showGainWin(itemid)
return
end
end

local selectByDz=self.selectItem.dizi or{}
if selectByDz[openFuncType]==nil then
UIManager.error('尚未选择救治的弟子')
return
end
local array={}
local openFuncTypeTable=selectByDz[openFuncType]
for guidStr,v in pairs(openFuncTypeTable)do
local diziguid=int64.new(guidStr)
for itemid,num in pairs(v)do
if num>0 then
array[#array+1]={diziguid,itemid,num}
end
end
end
if#array==0 then
UIManager.error('尚未选择救治的弟子')
return
end
self.reqArray=array
bagProtocolControl.req_dizi_use_item_list(#array,array)
end

function UIDiscipleBatchZhiliaoWin:autoFenPei(diziguid)
local openFuncType=self:getSelectFunType()
local needVal=self:getNeedVal(openFuncType,diziguid)
local itemCfgs=self.goodDataList
if#itemCfgs>0 then
table.sort(itemCfgs,function(a,b)
return a.color>b.color
end)
end
local len=#itemCfgs
local hasArray={}
local addArray={}
for i,cfg in ipairs(itemCfgs)do
local itemid=cfg.id
local funcparam=cfg.funcparam
local heal=funcparam.heal
local shouyuan=funcparam.shouyuan
local isShouYuan=openFuncType==item_funtion_type.shouyuan
local isInjury=openFuncType==item_funtion_type.liaoshang
local add=isShouYuan and shouyuan or isInjury and heal or 0
local itemNum=bagModel.getItemCountById(itemid)
local num=self:getSelectNum(itemid)
local leftNum=itemNum-num
hasArray[i]=leftNum
addArray[i]=add
end
local add1=addArray[1]or 0
local add2=addArray[2]or 0
local add3=addArray[3]or 0
local has1=hasArray[1]or 0
local has2=hasArray[2]or 0
local has3=hasArray[3]or 0
has1=has1+1
has2=has2+1
has3=has3+1
local div=nil
local info=nil
local max1=add1>0 and(math.ceil(needVal/add1)+1)or 1
local max2=add2>0 and(math.ceil(needVal/add2)+1)or 1
local max3=add3>0 and(math.ceil(needVal/add3)+1)or 1
max1=math.min(has1,max1)
max2=math.min(has2,max2)
max3=math.min(has3,max3)
local maxVal=0
local maxInfo=nil
for i=max1,1,-1 do
for j=max2,1,-1 do
for t=max3,1,-1 do
local num1=i-1
local num2=j-1
local num3=t-1
local v=add1*num1+add2*num2+add3*num3
local _info={v,num1,num2,num3}

local left=v-needVal
if left>=0 then
if div==nil then
info=_info
div=left
elseif left<div then
info=_info
div=left
end
end
if maxVal<v then
maxInfo=_info
maxVal=v
end
end
end
end
if info==nil then
info=maxInfo
end
if info then
local num1=info[2]
local num2=info[3]
local num3=info[4]
if num1>0 then
self:addSelectNum(diziguid,itemCfgs[1].id,num1,false)
end
if num2>0 then
self:addSelectNum(diziguid,itemCfgs[2].id,num2,false)
end
if num3>0 then
self:addSelectNum(diziguid,itemCfgs[3].id,num3,false)
end
end
end

function UIDiscipleBatchZhiliaoWin:onLongTouchClick(index)
local selectIdx=self.selectIdx
local list=self.list[selectIdx].list
local diziInfo=list[index]
local diziguid=diziInfo.netData.net.discipleguid
local diziguidList={}
for i,v in ipairs(list)do
table.insert(diziguidList,v.netData.net.discipleguid)
end
otherPlayerController:openSelfPlayerDZInfoWin(diziguidList,diziguid)
end

function UIDiscipleBatchZhiliaoWin:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
local openFuncType=self:getSelectFunType()
local itemCfgs=itemsLookup:get_function_items(openFuncType)
for i,cfg in ipairs(itemCfgs)do
if cfg.id==itemid then

self:getgoodDataList()
self:freshDiziPanel()
self:freshBottomPanel()
break
end
end
end
