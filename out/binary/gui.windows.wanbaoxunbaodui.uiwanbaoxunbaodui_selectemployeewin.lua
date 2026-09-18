







def_class("UIWanBaoXunBaoDui_SelectEmployeeWin",UIWindowBase)









function UIWanBaoXunBaoDui_SelectEmployeeWin:bindComponents()

self.Root=UIObject.get(self,0)
self.listbg=UIObject.get(self,1)
self.dispatchBtn=UIButton.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.employeeScrollview=UIObject.get(self,4)
self.bgspine=UIObject.get(self,5)
self.nocat=UIObject.get(self,6)

self.dispatchBtn:setButtonClick(function()self:onDispatchBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIWanBaoXunBaoDui_SelectEmployeeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.listbg);self.listbg=nil;
_UIObject_release(self.dispatchBtn);self.dispatchBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.employeeScrollview);self.employeeScrollview=nil;
_UIObject_release(self.bgspine);self.bgspine=nil;
_UIObject_release(self.nocat);self.nocat=nil;
end

















local CmpEmployeeCardItemIndex={
self=0,
bg=1,
employee=2,
quality=3,
kuang=4,
employeeimg=5,
line=6,
name=7,
line2=8,
energyroot=9,
tilitxt=10,
tilivalue=11,
attrlist=12,
featurelist=13,
detailbtn=14,
tuijian=15,
select=16,
lvbg=17,
lv=18,
gray=19,
}




function UIWanBaoXunBaoDui_SelectEmployeeWin:onLoaded(...)
self:bindComponents()
end


function UIWanBaoXunBaoDui_SelectEmployeeWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_SelectEmployeeWin:onShow(argtable,afterOnloaded)
self.channel_id=argtable.channel_id
self.dispatchIndex=argtable.index

self.selectIndex=-1

self.channelData=wanBaoXunBaoDuiModel:getChannelDataById(self.channel_id)

local catlist=wanBaoXunBaoDuiModel:getSelectEmployeeData(self.channelData)
self.employeeList=catlist

local cb=function()

end
self.bgspine:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,cb)

AudioManager.playAudio(633)

self:initUI()
end


function UIWanBaoXunBaoDui_SelectEmployeeWin:onHide()

end





function UIWanBaoXunBaoDui_SelectEmployeeWin:onDispatchBtn()
if self.selectIndex>0 then
local data=self.employeeList[self.selectIndex]
if not wanBaoXunBaoDuiModel:isWorking(data.guid)then








local tili=cfgHelper.get2(cfg_catmapconfig_get,self.channelData.task_Id,'tili')
local maxTili=wanBaoXunBaoDuiModel:caculationMaxTili(data)
if maxTili>=tili then
wanBaoXunBaoDuiModel:addDispatchEmployee(self.channel_id,self.dispatchIndex,data.guid)
else
UIManager.info('该猫猫总体力不足探险')
end
else
UIManager.info('猫猫正在探险中')
end
else
UIManager.info("请选取猫猫")
end
end



function UIWanBaoXunBaoDui_SelectEmployeeWin:onCloseBtn()

UIFullWanBaoXunBaoDuiController:closeWindow('UIWanBaoXunBaoDui_SelectEmployeeWin')
end


function UIWanBaoXunBaoDui_SelectEmployeeWin:onClickDetailBtn()

end

function UIWanBaoXunBaoDui_SelectEmployeeWin:checkRecommend()
return false
end

function UIWanBaoXunBaoDui_SelectEmployeeWin:initUI()
local needTili=cfgHelper.get2(cfg_catmapconfig_get,self.channelData.task_Id,'tili')
self.listbg:setChildLayoutGroupCreateItems(#self.employeeList,function(index)
local data=self.employeeList[index]
local item=self.listbg:getChildLayoutGroupGridItem(index-1)

local name=cfgHelper.get1(cfg_catnameconfig_get,data.name_id).name
local maxTili=wanBaoXunBaoDuiModel:caculationMaxTili(data)

local quliatyIcon,qab=wanbaoXunBaoDuiHelper:getCatQualityFrame(data.color)
item:SetChildCSImageSprite(CmpEmployeeCardItemIndex.quality,qab,quliatyIcon)

local modelid,components=wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(data)
item:SetChildModelCaptureImage(CmpEmployeeCardItemIndex.employeeimg,modelid,components,2.5,eAnimationID.idle,0,0,Vector2(0,50),1,false)

local lvbgIcon,lab=wanbaoXunBaoDuiHelper:getCatLevelFrame(data.color)
item:SetChildCSImageSprite(CmpEmployeeCardItemIndex.lvbg,lab,lvbgIcon)
item:SetChildText(CmpEmployeeCardItemIndex.lv,data.lv)

item:SetChildActive(CmpEmployeeCardItemIndex.gray,needTili>data.tili)
item:SetChildText(CmpEmployeeCardItemIndex.name,name)
item:SetChildText(CmpEmployeeCardItemIndex.tilivalue,FMT.fmt("{0}/{1}",data.tili,maxTili))
item:SetChildActive(CmpEmployeeCardItemIndex.select,self.selectIndex==index)
item:SetChildActive(CmpEmployeeCardItemIndex.tuijian,data.tuijian)

local propNameList=wanBaoXunBaoDuiModel:getPropNameList()
item:SetChildLayoutGroupCreateItems(CmpEmployeeCardItemIndex.attrlist,5,function(pindex)
local value=data.propList[pindex]
local name=propNameList[pindex]
local aitem=item:GetChildLayoutGroupGridItem(CmpEmployeeCardItemIndex.attrlist,pindex-1)
aitem:SetChildText(1,FMT.fmt('{0}：',name))
aitem:SetChildText(2,value)
end)

item:SetChildLayoutGroupCreateItems(CmpEmployeeCardItemIndex.featurelist,data.texing_num,function(findex)
local titem=item:GetChildLayoutGroupGridItem(CmpEmployeeCardItemIndex.featurelist,findex-1)
local txconfig=cfgHelper.get1(cfg_cattxconfig_get,data.txList[findex])

local name=UIDiscipleModel.getSpecialityNameStr(txconfig.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(txconfig.frame)
titem:SetChildCSImageSprite(0,abName,frameIcon)
titem:SetChildText(1,name)
titem:SetBaseItemClickEvent(-1,function()
self:showWindow('UIWanBaoXunBaoDui_SpeicialWin',{
item=titem,
node='bottom',
spid=data.txList[findex],
})
end)
end)

item:SetChildButtonClick(CmpEmployeeCardItemIndex.detailbtn,function()
self:showWindow('UIWanBaoXunBaoDui_RecruitmentWin',{type=WBXBD_ReCruitment_TYPE.info,catdata={data}})
end)
item:SetBaseItemClickEvent(CmpEmployeeCardItemIndex.self,function(itemId,mindex,guid,attach)
if self.selectIndex>0 then
if self.selectIndex==index then
self.selectIndex=-1
item:SetChildActive(CmpEmployeeCardItemIndex.select,false)
else
local preItem=self.listbg:getChildLayoutGroupGridItem(self.selectIndex-1)
preItem:SetChildActive(CmpEmployeeCardItemIndex.select,false)

self.selectIndex=index
item:SetChildActive(CmpEmployeeCardItemIndex.select,true)
end
else
self.selectIndex=index
item:SetChildActive(CmpEmployeeCardItemIndex.select,true)
end

end)
end)

self.employeeScrollview:setChildScrollRectEnable(#self.employeeList>2)
local isCanClick=#self.employeeList>0
self.dispatchBtn:setButtonEnable(isCanClick,not isCanClick)
self.nocat:setActive(#self.employeeList==0)
end


function UIWanBaoXunBaoDui_SelectEmployeeWin:showBuyTiliDialoug(data,needTili)
local const_def=wanBaoXunBaoDuiModel:getConstDef()
local maxTili=wanBaoXunBaoDuiModel:caculationMaxTili(data)
local moneyid=const_def.add_tili_need[1]
local rate=const_def.add_tili_need[2]
local least=maxTili-data.tili

local iconname=iconHelper.getIconName(moneyid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)

local needNum=rate*least
local numStr=needNum
local contentStr=FMT.fmt('目前猫猫体力为{0}/{1},是否消耗{2} {3} 购买<color=#6833c0>{4}</color>点体力',data.tili,maxTili,numStr,iconStr,least)

local callback=function()
local moneyNum=itemsModel.getCount(moneyid)
if moneyNum>=needNum then
wanBaoXunBaoDuiController:reqRecoverCatTiliByUseMoney(1,{{data.guid,least}})
else
gainControl:showGainWin(moneyid,needNum)
end
end

local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=callback,
moneytypes={{eMoneyType.mtYuBi}},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIWanBaoXunBaoDui_SelectEmployeeWin:freshRecoverCatTili(catinfo)
for k,v in pairs(self.employeeList)do
if v.guid==catinfo.guid then
v.tili=catinfo.tili
end
end
self:initUI()
end