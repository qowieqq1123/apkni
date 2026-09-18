







def_class("UICatEntrustSelectCatWin",UIWindowBase)









function UICatEntrustSelectCatWin:bindComponents()

self.autoDispatchBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.dispatchBtn=UIButton.get(self,2)
self.employeeScrollview=UIScrollView.get(self,3)
self.listContent=UIObject.get(self,4)
self.nocat=UIObject.get(self,5)
self.Root=UIObject.get(self,6)

self.autoDispatchBtn:setButtonClick(function()self:onAutoDispatchBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.dispatchBtn:setButtonClick(function()self:onDispatchBtn()end)



end


function UICatEntrustSelectCatWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.autoDispatchBtn);self.autoDispatchBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dispatchBtn);self.dispatchBtn=nil;
_UIObject_release(self.employeeScrollview);self.employeeScrollview=nil;
_UIObject_release(self.listContent);self.listContent=nil;
_UIObject_release(self.nocat);self.nocat=nil;
_UIObject_release(self.Root);self.Root=nil;
end
















local CmpEmployeeCardItemIndex={
self=0,
bg=1,
employee=2,
quality=3,
employeeimg=4,
name=5,
energyroot=6,
tilitxt=7,
tilivalue=8,
attrlist=9,
featurelist=10,
detailbtn=11,
tuijian=12,
select=13,
lvbg=14,
lv=15,
gray=16,
attrValInfo=17,
upRateInfo=18,
noTxTip=19,
noRateTip=20,
}



function UICatEntrustSelectCatWin:onLoaded(...)
self:bindComponents()

self.employeeScrollview:bindScrollWidget(function(...)self:bindEmployeeItem(...)end)
end


function UICatEntrustSelectCatWin:__delete()
self:unbindComponents()
end




function UICatEntrustSelectCatWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.wtSlotId=argtable.wtSlotId
self.tempWt=argtable.tempWt
self.selectIndex=-1

self.originalWtSlotData=catEntrustModel:getWtSlotDataById(self.wtSlotId)
self.wtSlotData=self.tempWt or self.originalWtSlotData

self:refreshAll()
end


function UICatEntrustSelectCatWin:onHide()

end

function UICatEntrustSelectCatWin:refreshAll()
self:refreshList()
self:refreshOther()
end


function UICatEntrustSelectCatWin:refreshList()
local wtType=self.wtSlotData.data.entrustType
local ex_reward_config=cfgHelper.get2(cfg_catentrusttypeconfig_get,wtType,'ex_reward_config')
local attrid=ex_reward_config[1]

local catlist=wanBaoXunBaoDuiModel:getCatSortListBySingleAttr(attrid,self.originalWtSlotData.data.dispatchCatGuid)
self.employeeList=catlist
local len=#self.employeeList

self.employeeScrollview:freshGridsNum(len,Mathf.Ceil(len/2),2)
end


function UICatEntrustSelectCatWin:bindEmployeeItem(index,item)
local data=self.employeeList[index]
local name=cfgHelper.get1(cfg_catnameconfig_get,data.name_id).name
local maxTili=wanBaoXunBaoDuiModel:caculationMaxTili(data)

local limitTxList={}
if data.texing_num>0 then
local show_limit_tx_list=catEntrustConfig.getBaseInfo('show_limit_tx_list')
for txIndex,txId in ipairs(data.txList)do
if show_limit_tx_list then
if table.containsValue(show_limit_tx_list,txId)then
limitTxList[#limitTxList+1]=txId
end
else
limitTxList[#limitTxList+1]=txId
end
end
end

local quliatyIcon,qab=wanbaoXunBaoDuiHelper:getCatQualityFrame(data.color)
item:SetChildCSImageSprite(CmpEmployeeCardItemIndex.quality,qab,quliatyIcon)

local modelid,components=wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(data)
item:SetChildModelCaptureImage(CmpEmployeeCardItemIndex.employeeimg,modelid,components,2.5,eAnimationID.idle,0,0,Vector2(0,50),1,false)

local lvbgIcon,lab=wanbaoXunBaoDuiHelper:getCatLevelFrame(data.color)
item:SetChildCSImageSprite(CmpEmployeeCardItemIndex.lvbg,lab,lvbgIcon)
item:SetChildText(CmpEmployeeCardItemIndex.lv,data.lv)


item:SetChildActive(CmpEmployeeCardItemIndex.gray,false)
item:SetChildText(CmpEmployeeCardItemIndex.name,name)

item:SetChildActive(CmpEmployeeCardItemIndex.tilivalue,false)
item:SetChildActive(CmpEmployeeCardItemIndex.select,self.selectIndex==index)

item:SetChildActive(CmpEmployeeCardItemIndex.tuijian,false)

local infos,isHasUpRate=wanBaoXunBaoDuiModel:getEntrustCatInfo(self.wtSlotData,data.guid)
item:SetChildText(CmpEmployeeCardItemIndex.attrValInfo,infos[1])
item:SetChildActive(CmpEmployeeCardItemIndex.upRateInfo,isHasUpRate)
item:SetChildActive(CmpEmployeeCardItemIndex.noRateTip,not isHasUpRate)
if isHasUpRate then
item:SetChildText(CmpEmployeeCardItemIndex.upRateInfo,infos[2])
else
item:SetChildText(CmpEmployeeCardItemIndex.noRateTip,infos[2])
end

local txLen=#limitTxList
local isShowTxList=txLen>0
item:SetChildActive(CmpEmployeeCardItemIndex.noTxTip,not isShowTxList)
if isShowTxList then
item:SetChildLayoutGroupCreateItems(CmpEmployeeCardItemIndex.featurelist,txLen,function(findex)
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
spid=limitTxList[findex],
})
end)
end)
end

item:SetChildButtonClick(CmpEmployeeCardItemIndex.detailbtn,function()
self:showWindow('UIWanBaoXunBaoDui_RecruitmentWin',{type=WBXBD_ReCruitment_TYPE.info,catdata={data}})
end)
item:SetBaseItemClickEvent(CmpEmployeeCardItemIndex.self,function(itemId,mindex,guid,attach)
if self.selectIndex>0 then
if self.selectIndex==index then
self.selectIndex=-1
item:SetChildActive(CmpEmployeeCardItemIndex.select,false)
else
local preItem=self.employeeScrollview:getGridObjectByindex(self.selectIndex-1)
preItem:SetChildActive(CmpEmployeeCardItemIndex.select,false)

self.selectIndex=index
item:SetChildActive(CmpEmployeeCardItemIndex.select,true)
end
else
self.selectIndex=index
item:SetChildActive(CmpEmployeeCardItemIndex.select,true)
end

end)
end

function UICatEntrustSelectCatWin:refreshOther()
self.employeeScrollview:setChildScrollRectEnable(#self.employeeList>2)
local isCanClick=#self.employeeList>0
self.dispatchBtn:setButtonEnable(isCanClick,not isCanClick)
self.nocat:setActive(#self.employeeList==0)
end




function UICatEntrustSelectCatWin:onDispatchBtn()
if self.selectIndex>0 then
local data=self.employeeList[self.selectIndex]
if not catEntrustModel:isWorking(data.guid)or(self.originalWtSlotData.data.dispatchCatGuid==data.guid)then
local wtSlotData=self.wtSlotData
local tempWt=self.tempWt
catEntrustModel:setWtSlotCatGuid(wtSlotData,data.guid)
self.parentWin:onClickClose()
if tempWt~=nil then
catEntrustConfig.doNextProgress(wtSlotData)
end
else
UIManager.info('猫猫已安排委托')
end
else
UIManager.info("请选取猫猫")
end
end

function UICatEntrustSelectCatWin:onAutoDispatchBtn()
if#self.employeeList>0 then
self.selectIndex=1
self:onDispatchBtn()
end
end



function UICatEntrustSelectCatWin:onCloseBtn()
self.parentWin:onClickClose()
end

