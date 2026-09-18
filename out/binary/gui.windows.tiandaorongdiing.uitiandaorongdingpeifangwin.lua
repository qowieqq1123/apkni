







def_class("UITianDaoRongDingPeIFangWin",UIWindowBase)









function UITianDaoRongDingPeIFangWin:bindComponents()

self.addImgClick=UIObject.get(self,0)
self.subImgClick=UIObject.get(self,1)
self.handImgClick=UIObject.get(self,2)
self.effectText3=UIText.get(self,3)
self.effectText_2=UIText.get(self,4)
self.effectText_1=UIText.get(self,5)
self.gbBtn=UIButton.get(self,6)
self.gbDesc=UIText.get(self,7)
self.gbicon=UIImage.get(self,8)
self.gbClick=UIButton.get(self,9)
self.gbTitle=UIText.get(self,10)
self.addBtn=UIButton.get(self,11)
self.subBtn=UIButton.get(self,12)
self.maxCnt=UIButton.get(self,13)
self.handleImg=UIObject.get(self,14)
self.selectCntText=UIText.get(self,15)
self.title=UIText.get(self,16)
self.Dropdown1=UIDropdownEx.get(self,17)
self.ScrollView=UIScrollView.get(self,18)
self.unLockText=UIText.get(self,19)
self.materials=UIObject.get(self,20)
self.matTypeText=UIText.get(self,21)
self.selectBtn=UIButton.get(self,22)
self.limitCnt=UIText.get(self,23)
self.gbRoot=UIObject.get(self,24)
self.peifangItem=UIButton.get(self,25)
self.selectCntSlider=UIObject.get(self,26)
self.midUnLockText=UIText.get(self,27)
self.effect3=UIObject.get(self,28)
self.effect_2=UIObject.get(self,29)
self.effect_1=UIObject.get(self,30)
self.timeText=UIText.get(self,31)

self.gbBtn:setButtonClick(function()self:onGbBtn()end)

self.gbClick:setButtonClick(function()self:onGbClick()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.peifangItem:setButtonClick(function()self:onPeifangItem()end)
self.effectText={
self.effectText_1,
self.effectText_2,
}
self.effect={
self.effect_1,
self.effect_2,
}



end


function UITianDaoRongDingPeIFangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addImgClick);self.addImgClick=nil;
_UIObject_release(self.subImgClick);self.subImgClick=nil;
_UIObject_release(self.handImgClick);self.handImgClick=nil;
_UIObject_release(self.effectText3);self.effectText3=nil;
_UIObject_release(self.effectText_2);self.effectText_2=nil;
_UIObject_release(self.effectText_1);self.effectText_1=nil;
_UIObject_release(self.gbBtn);self.gbBtn=nil;
_UIObject_release(self.gbDesc);self.gbDesc=nil;
_UIObject_release(self.gbicon);self.gbicon=nil;
_UIObject_release(self.gbClick);self.gbClick=nil;
_UIObject_release(self.gbTitle);self.gbTitle=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.unLockText);self.unLockText=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.matTypeText);self.matTypeText=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.limitCnt);self.limitCnt=nil;
_UIObject_release(self.gbRoot);self.gbRoot=nil;
_UIObject_release(self.peifangItem);self.peifangItem=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.midUnLockText);self.midUnLockText=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect_2);self.effect_2=nil;
_UIObject_release(self.effect_1);self.effect_1=nil;
_UIObject_release(self.timeText);self.timeText=nil;
self.effectText=nil;
self.effect=nil;
end

















local _dropItemHeight=40
local _dropViewHeight=150

local _menuIdx=
{
select=0,
showItem=1,
require=2,
lock=3,
reddot=4,
name=5,
newImg=6,
lockBg=7,
}
local _this=nil

function UITianDaoRongDingPeIFangWin:onLoaded(...)
_this=self
self:bindComponents()
local _onClickMenuCallBack=function(...)
self:onClickMenuCallBack(...)
end
self.ScrollView:setClickAction(_onClickMenuCallBack)

local longPressFunc=function(...)
self:onLongPressBtn(...)
end
self.winlua:SetChildLongPress(self.subBtn:getID(),1,longPressFunc,nil)
self.winlua:SetChildLongPress(self.addBtn:getID(),2,longPressFunc,nil)

self.gainTable={}
self.filterIdx=0

self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(...)end)
self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(...)end)

self.checkList={}
self.on_money_changed=function(mtype,last,curr)
if self.checkList[mtype]then
self:freshRightPanel()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end

function UITianDaoRongDingPeIFangWin:__delete()
_this=nil
self:unbindComponents()

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end

function UITianDaoRongDingPeIFangWin:onShow(argtable,afterOnloaded)
local guid=argtable.entityId
local pfId=argtable.pfId or tianDaoRongDingModel:getSelectPeiFangId()
local cnt=argtable.selectCnt or 1
self.bdData=zongmenModel:findBuildingByEntityId(guid)
self.needFresh=true
if pfId==nil then
self:onSelectDefault()
else
local left=tianDaoRongDingModel:getLeftLianZhiCnt(pfId)
if left<=0 then
self:onSelectDefault()
else
self:onSelect(pfId,cnt)
end
end
end

function UITianDaoRongDingPeIFangWin:onHide()

end





function UITianDaoRongDingPeIFangWin:onAddBtn()
end



function UITianDaoRongDingPeIFangWin:onSubBtn()
end



function UITianDaoRongDingPeIFangWin:onMaxCnt()
local id=self.pfId
local maxCnt=tianDaoRongDingModel:getMaxLianZhiCount(id,self.fangAnID)
if maxCnt==0 then maxCnt=1 end
self.selectCnt=maxCnt
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UITianDaoRongDingPeIFangWin:onSelectBtn()
local pfId=self.pfId
local config=cfg_tdrlplanconfig_get(pfId)
local cnt=self.selectCnt
local fangAnID=self.fangAnID
if fangAnID==nil then return end
if not tianDaoRongDingModel:canLianZhi(pfId,fangAnID,cnt,true)then
return
end


local itemId=config.showitem[1]

local itemNum=config.showitem[2]

local itemColor=itemsConfig.getItemColor(itemId)


local nonTips=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eTianDaoDingLianZhi)
if nonTips then
tianDaoRongDingController.reqLianZhi(pfId,cnt,fangAnID)
else

local contentText=FMT.fmt("是否炼制<color={0}>{1}</color>次<color={2}>{3}</color>*{4}？",FONT_COLOR_VAL[FONT_COLOR.eOrangeColor],
cnt,
FONT_COLOR_VAL[itemColor],
config.name,
itemNum)

local tipsArgs={
type="UIDialouge",
title="提示",
content=contentText,
oktext="确定",
canceltext="取消",
allowclickBG="false",
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eTianDaoDingLianZhi,flag)
end,
okcallback=function()
tianDaoRongDingController.reqLianZhi(pfId,cnt,fangAnID)
end,
showclosebtn=true
}
local tipsDialog=UIDialogManager.newDialog(tipsArgs)
tipsDialog:show()
end
end

function UITianDaoRongDingPeIFangWin:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then return end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.maxLianZhiCnt then return end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UITianDaoRongDingPeIFangWin:onPeifangItem()

end

function UITianDaoRongDingPeIFangWin:onGbBtn()
local gbid=self.gbid
local gbCfg=cfg_gubaoconfig_get(gbid)
local isOpenGuBao=systemModel.isOpen(SYSTEM_DEFINE.eGuBao)
local canActive=isOpenGuBao and gubaoModel:checkCanActive(gbid)or false
if not isOpenGuBao or canActive then
jumpManager:jump({id=JUMP_TYPE.eGuBaoCollect})
else
local args=self:getActiveItemid(gbCfg)
if args then
local itemid=args[1]
local has=itemsModel.getCount(itemid)
if has<args[2]then
gainControl:showGainWin(itemid)
end
end
end
end

function UITianDaoRongDingPeIFangWin:onGbClick()
local gbid=self.gbid
tipsManager.showTipsGB({formType=TIPS_FORM_TYPE.eGubaoCheck,
tipsType=TIPS_TYPE.eCommonGubao,
itemid=gbid,
bg=false})
end

function UITianDaoRongDingPeIFangWin:getActiveItemid(gbCfg)
local active=gbCfg.active
local args
for itemid,num in pairs(active)do
if num==1 then
args={itemid,num}
break
end
end
return args
end


function UITianDaoRongDingPeIFangWin:onSelectDefault()
self.needFresh=true
self:freshPFData()
local pfId=self.pfList[1].id
self:onSelect(pfId)
end

function UITianDaoRongDingPeIFangWin:onSelect(pfId,num)
if pfId==nil then return end
num=num or 1
if self.pfId==pfId and self.selectCnt==num then return end
self.pfId=pfId
self.selectCnt=num
if tianDaoRongDingModel:isGuDingFangAn(self.pfId)then
self.fangAnID=1
else
self.fangAnID=nil
end
self:freshFilter()
self:freshPFData()
self:freshPeiFangGird()
self:freshRightPanel()
end












function UITianDaoRongDingPeIFangWin:freshFilter()
local cfg=cfg_tdrlplanfilterconfig()

local options={}
options[#options+1]='所有'
self.options=options

for i,v in ipairs(cfg)do
options[#options+1]=v.name
end

local idx=self.filterIdx
local reIdx=idx

self.Dropdown1:setOption(options)
self.Dropdown1:setValue(reIdx)
end

function UITianDaoRongDingPeIFangWin:onDropdownChange(reIdx)
local len=#self.options
local idx=reIdx
if self.filterIdx==idx then return end
self.filterIdx=idx
self.needFresh=true
self.selectCnt=nil
self.pfId=nil
self.fangAnID=nil
self:freshPFData()
self:onSelectDefault()
end

function UITianDaoRongDingPeIFangWin:onDropdownCreate(scrollTrans,contentTrans)
local idx=self.filterIdx or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=height-(idx)*_dropItemHeight-_dropViewHeight
else
posY=0
end
if posY<=0 then posY=0 end
contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end


function UITianDaoRongDingPeIFangWin:freshPFData()
if self.needFresh==false then return end
self.needFresh=false
local filterIdx=self.filterIdx or 0
local stype=filterIdx
local allpfList=cfg_tdrlplanconfig()
local pfList={}
local sortTag={}
local ubdId=self.bdData.un_build_id

local defaultVersionId=pfwindowslController:getGameVersion()
local pfid=loginModel:getPfid()
for i,v in pairs(allpfList)do
if v.s_type==stype or stype==0 then
local Pflock=v.Pflock
local pfflag=tianDaoRongDingModel:checkOrderPT(Pflock,defaultVersionId,pfid)

if pfflag then
local id=v.id
pfList[#pfList+1]=v
local isUnLock=tianDaoRongDingModel:isUnlock(ubdId,id)
sortTag[v.id]=v.sort
if not isUnLock then
sortTag[v.id]=100000+v.locksort
else
local left=tianDaoRongDingModel:getLeftLianZhiCnt(v.id)
if left<=0 then
sortTag[v.id]=v.sort+10000
end
end


end
end
end

table.sort(pfList,function(a,b)
return sortTag[a.id]<sortTag[b.id]
end)

self.pfList=pfList
end

function UITianDaoRongDingPeIFangWin:freshPeiFangGird()
self.ScrollView:freshGridsNum(#self.pfList,#self.pfList,1,true)
local ubdId=self.bdData.un_build_id
local selectIdx=nil
for i=1,#self.pfList do
local item=self.ScrollView:getGridObjectByindex(i-1)
if item then
local config=self.pfList[i]
local id=config.id
local lzitem=tianDaoRongDingModel:getLianZhiItem(id)
local itemid=lzitem[1]
local count=lzitem[2]or 1
local itemCfg=itemsConfig.getConfig(itemid)
local unlockGB=tianDaoRongDingModel:isUnLockGB(id)
local left=tianDaoRongDingModel:getLeftLianZhiCnt(id)

item:SetChildActive(_menuIdx.select,id==self.pfId)
if id==self.pfId then
selectIdx=i
end

item:SetChildText(_menuIdx.name,config.name)

local isUnLock,args=tianDaoRongDingModel:isUnlock(ubdId,id)
item:SetChildActive(_menuIdx.lockBg,not isUnLock)
local desc=isUnLock and config.desc or nil
if not isUnLock then
local locktype,retArgs=unpack(args)
desc=tianDaoRongDingModel:getUnlockTips(retArgs)
if locktype==2 then desc='需激活古宝'end
end
item:SetChildActive(_menuIdx.lock,not isUnLock)

local iconName=iconHelper.getIconName(itemid)
local widget=item:GetChildWidgetBase(_menuIdx.showItem)
widget:SetChildCSImageIcon(3,iconName,false)

widgetHelper.setItemQulaity(widget,itemid,2)

widget:SetChildImageExGray(2,isUnLock and left<=0)
widget:SetChildImageExGray(3,isUnLock and left<=0)

item:SetChildText(_menuIdx.require,desc)





item:SetChildActive(_menuIdx.reddot,false)

item:SetChildActive(_menuIdx.newImg,false)

item:SetBaseItemChildID(-1,id)
end
end
if#self.pfList>0 then
self.ScrollView:jumpToLockX(selectIdx)
end
end

function UITianDaoRongDingPeIFangWin:freshGridSelect(id)
for i=1,#self.pfList do
local item=self.ScrollView:getGridObjectByindex(i-1)
if item then
local config=self.pfList[i]
item:SetChildActive(_menuIdx.select,config.id==id)
end
end
end

function UITianDaoRongDingPeIFangWin:onClickMenuCallBack(id,index,guid,attach)

if self.pfId==id then return end
self.pfId=id
tianDaoRongDingModel:setSelectPeiFangId(id)
self:freshGridSelect(id)
self.selectCnt=1
if tianDaoRongDingModel:isGuDingFangAn(self.pfId)then
self.fangAnID=1
else
self.fangAnID=nil
end
self:freshRightPanel()
end

function UITianDaoRongDingPeIFangWin:freshRightPanel()
local id=self.pfId
local config=cfg_tdrlplanconfig_get(id)
if config==nil then return end
self:freshBottonInfo(config)
local left,max=tianDaoRongDingModel:getLeftLianZhiCnt(id)
local unlockGB=tianDaoRongDingModel:isUnLockGB(id)
local showGB=not unlockGB
local ubdId=self.bdData.un_build_id
local isUnLock,args=tianDaoRongDingModel:isUnlock(ubdId,id)
local lockText
if args then
local locktype,retArgs=unpack(args)
lockText=locktype==2 and''or tianDaoRongDingModel:getUnlockTips(retArgs)
end
local cntStr=FMT.cfmt(FONT_COLOR.eNomalBlackColor,'{0}/{1}',left,max)
self.limitCnt:setText(max~=-1 and FMT.fmt('每周炼制次数：{0}',cntStr)or'不限次数')
self.matTypeText:setText('消耗材料')

self.unLockText:setActive(not isUnLock and showGB)
self.unLockText:setText(lockText)
self.midUnLockText:setActive(not isUnLock and not showGB)
self.midUnLockText:setText(lockText)
self.selectBtn:setActive(isUnLock)

local widget=self.peifangItem:getWidgetBase()
local lzitem=tianDaoRongDingModel:getLianZhiItem(id)
local itemid=lzitem[1]
local count=lzitem[2]or 1
local itemCfg=itemsConfig.getConfig(itemid)
local iconName=iconHelper.getIconName(itemid)
widget:SetChildCSImageIcon(3,iconName,false)

widgetHelper.setItemQulaity(widget,itemid,2)
widget:SetChildActive(9,count>1)
widget:SetChildText(4,count>1 and count or'')
widget:SetChildText(7,itemsConfig.getColorName(itemid))
widget:SetChildButtonClick(0,function(...)
if itemid==nil or itemid==-1 then return end
tipsManager.showTips({itemid=itemid,move=TIPS_MOVE_POS.eLeft})
end)

end

function UITianDaoRongDingPeIFangWin:freshLianZhiCnt()
local id=self.pfId
local left,max=tianDaoRongDingModel:getLeftLianZhiCnt(id)
local cntStr=FMT.cfmt(FONT_COLOR.eNomalBlackColor,'{0}/{1}',left,max)
self.limitCnt:setText(max~=-1 and FMT.fmt('每周炼制次数：{0}',cntStr)or'不限次数')
end

function UITianDaoRongDingPeIFangWin:freshSlider()
local id=self.pfId
local ubdId=self.bdData.un_build_id
local isUnLock=tianDaoRongDingModel:isUnlock(ubdId,id)
local showSlider=isUnLock and self.fangAnID~=nil
self.selectCntSlider:setActive(showSlider)
if showSlider then
local func=function(...)
if _this==nil then return end
if _this.lockSlider then return end
_this:onSliderChange(...)
end
local maxcnt=tianDaoRongDingModel:getMaxLianZhiCount(id,self.fangAnID)
self.maxLianZhiCnt=maxcnt
self.winlua:SetChildImageRaycast(self.handImgClick:getID(),maxcnt>1)
local minCount=1
if maxcnt<=1 then
minCount=0
maxcnt=1
end
self.lockSlider=true
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,minCount,maxcnt,func)
self.lockSlider=false
if maxcnt<=1 then
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),1)
end
end
end

function UITianDaoRongDingPeIFangWin:freshBottonInfo(config)
local id=config.id
self.timeText:setText(timeHelper.format_time_stamp4(config.need_time))

self:freshSlider()


local condition=config.condition or{}
local gbid
for i,v in ipairs(condition)do
if v[1]==2 then
gbid=v[2]
end
end
local needgb=gbid~=nil
local isActive=gubaoModel:checkActive(gbid)
local showGB=needgb and not isActive
self.gbid=gbid
self.gbRoot:setActive(showGB)
if showGB then
local gbCfg=cfg_gubaoconfig_get(gbid)
local name=FMT.cfmt(gbCfg.color,gbCfg.name)
local desc=FMT.fmt('该秘方需借助古宝【{0}】的威能方可炼制',name)
self.winlua:SetChildCSImageIcon(self.gbicon:getID(),gubaoModel:getGuBaoIconName(gbCfg.icon),true)
self.winlua:SetChildText(self.gbDesc:getID(),desc)


local gbCfg=cfg_gubaoconfig_get(gbid)
local isOpenGuBao=systemModel.isOpen(SYSTEM_DEFINE.eGuBao)
local canActive=isOpenGuBao and gubaoModel:checkCanActive(gbid)or false
local args=self:getActiveItemid(gbCfg)
local itemid=args[1]
local config=itemsConfig.getConfig(itemid)
local produce=config.produce
if canActive then
self.gbBtn:setActive(true)
elseif produce==nil then
self.gbBtn:setActive(false)
else
self.gbBtn:setActive(true)
end
end

self.gainTable={}

self:freshMaterialsCnt()
end

function UITianDaoRongDingPeIFangWin:freshMaterialsCnt()
local id=self.pfId
local ubdId=self.bdData.un_build_id
local isUnLock=tianDaoRongDingModel:isUnlock(ubdId,id)
local is_gd=tianDaoRongDingModel:isGuDingFangAn(id)
self.selectCntText:setText(self.selectCnt)
if not is_gd and not isUnLock and self.fangAnID==nil then
self.fangAnID=1
end
local c
local costlist
local hasFangAn=self.fangAnID~=nil
if hasFangAn then
costlist=cfgHelper.get3(cfg_tdrlplanconfig_get,id,'cost',self.fangAnID)
c=#costlist
else
c=3
end
self.materials:setChildLayoutGroupCreateItems(c)
local grids=self.materials:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local show=hasFangAn
item:SetChildActive(0,show)
item:SetChildActive(1,not show)
item:SetChildActive(2,show and not is_gd)
item:SetChildButtonClick(1,function()
if _this==nil then return end
self:onClickMaterialItem()
end)
if show then
local data=costlist[i]
local itemid=data[1]
self.checkList[itemid]=true
local needCount=data[2]*self.selectCnt
local hascnt=itemsModel.getCount(itemid)
local countStr=FMT.fmt('{0}/{1}',mathHelper.formatNumber(hascnt),needCount)
if moneyConfig.isMoney(itemid)then
countStr=mathHelper.formatNumber(needCount)
else
countStr=FMT.fmt('{0}/{1}',mathHelper.formatNumber(hascnt),needCount)
end
if hascnt<needCount then
countStr=FMT.fmt('<color=#c82c2c>{0}</color>',countStr)
end
local grayNum=0
if hascnt<needCount then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
local conf={itemid=itemid,itemcount=countStr,showname=false,showCountBG=true,showStage=true,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickMaterialItem(...)
end)
item:SetBaseItemLongTouchEvent(0,function(...)
if _this==nil then return end
_this:onClickMaterialItem_long(...)
end)
self.gainTable[itemid]=needCount
end
end
end

function UITianDaoRongDingPeIFangWin:onSliderChange(value)
self.selectCnt=value
self:freshMaterialsCnt()
end

function UITianDaoRongDingPeIFangWin:onClickMaterialItem(itemId,index,guid,attach)
if not tianDaoRongDingModel:isGuDingFangAn(self.pfId)then
local args={}
args.titleName='材料选择'
args.pos=2
args.extraWin='UITianDaoRongDingFangAnSelectWin'
local extraParams={}
extraParams.danFangID=self.pfId
extraParams.fangAnID=self.fangAnID
extraParams.callback=function(fangAnID_)
if _this==nil then return end
_this.fangAnID=fangAnID_
_this:freshMaterialsCnt()
_this:freshSlider()
end
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
else
self:onClickMaterialItem_long(itemId,index,guid,attach)
end
end


function UITianDaoRongDingPeIFangWin:onClickMaterialItem_long(itemId,index,guid,attach)
if itemId==-1 then return end
local needCount=self.gainTable[itemId]or 0
local have=itemsModel.getCount(itemId)
if have<needCount then
gainControl:showGainWin(itemId)
return
end
tipsManager.showTips({itemid=itemId,move=TIPS_MOVE_POS.eLeft})
end
