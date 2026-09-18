







def_class("UIDIscipleTianMingCiFuWin",UIWindowBase)









function UIDIscipleTianMingCiFuWin:bindComponents()

self.cifuGrid=UIObject.get(self,0)
self.showSkillItem=UIObject.get(self,1)
self.commitBtn=UIButton.get(self,2)
self.signImg=UIObject.get(self,3)
self.commitTxt=UIText.get(self,4)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIDIscipleTianMingCiFuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cifuGrid);self.cifuGrid=nil;
_UIObject_release(self.showSkillItem);self.showSkillItem=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.signImg);self.signImg=nil;
_UIObject_release(self.commitTxt);self.commitTxt=nil;
end
















local _this=nil


function UIDIscipleTianMingCiFuWin:onLoaded(...)
_this=self
self:bindComponents()

notifySystem:listenNotify(notifyConfig.onDiscipleTianMingCiFuChange,self.onDiscipleTianMingCiFuChange)
end


function UIDIscipleTianMingCiFuWin:__delete()
_this=nil
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onDiscipleTianMingCiFuChange,self.onDiscipleTianMingCiFuChange)
end


function UIDIscipleTianMingCiFuWin:onHide()

end

function UIDIscipleTianMingCiFuWin.onDiscipleTianMingCiFuChange(dis_guid_)
if _this==nil then return end

if not mathHelper.compareInt64(dis_guid_,_this.dis_guid)then
return
end

UIManager.info('设置成功')
_this:refreshCiFuGrid()
_this:refreshInfo()
end




function UIDIscipleTianMingCiFuWin:onShow(argtable,afterOnloaded)
local dis_guid=argtable.dis_guid
local groupIdx=argtable.groupIdx or 1
self.dis_guid=dis_guid
self.jobID=UIDiscipleModel:getDiscipleJob(dis_guid)
self.tmlv=UIDiscipleModel:getTianMingLevel(dis_guid)
self.dzId=UIDiscipleModel:getDiscipleID(dis_guid)

self.curGroupIdx=groupIdx
self:initData()
self:refreshCiFuGrid()
self:refreshInfo()
end

function UIDIscipleTianMingCiFuWin:initData()
local curGroupIdx=self.curGroupIdx
local cifuID=UIDiscipleModel:getTianMingCiFuID(self.dis_guid,curGroupIdx)
local list=UIDiscipleModel.getTianMingCiFuSelectCfg(self.jobID,curGroupIdx,self.dzId)
local curSelectIdx=1
for i,v in ipairs(list)do
if v==cifuID then
curSelectIdx=i
end
end
self.curSelectIdx=curSelectIdx
end

function UIDIscipleTianMingCiFuWin:refreshCiFuGrid()
local tmlv=self.tmlv
local grids=self.cifuGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshGroupItem(item,i)
self:refreshGroupItemSelect(item,i,i==self.curGroupIdx)

local isActive,limit_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(tmlv,i,false)
local lv_str
if isActive then
lv_str=UIDiscipleModel.getTianMingLevelDesc(limit_tmlv)
else
lv_str=FMT.fmt('{0}解锁',UIDiscipleModel.getTianMingLevelDesc(limit_tmlv))
end
item:SetChildText(1,lv_str)
end
end

function UIDIscipleTianMingCiFuWin:refreshGroupItem(item,groupIdx)
if item==nil then
item=self.cifuGrid:getChildCommonLayoutGroupWidgetItem(groupIdx-1)
end

local isOpen=UIDiscipleModel:checkTiamMingCiFuPosOpen(self.dis_guid,groupIdx)
local list=UIDiscipleModel.getTianMingCiFuSelectCfg(self.jobID,groupIdx,self.dzId)
local grids=item:GetChildCommonLayoutGroupWidgetList(2)
for i=1,grids.Count do
local skillItem=grids[i-1]
local cifuID=list[i]
local cifucfg=cfgHelper.get1(cfg_discipletmcfconfig_get,cifuID)
skillItem:SetChildActive(4,not isOpen)

skillItem:SetChildCSImageIcon(0,iconHelper.getSkillIcon(cifucfg.icon))
skillItem:SetChildImageExGray(0,not isOpen)

skillItem:SetChildText(2,cifucfg.name)
local cur_cifuID=UIDiscipleModel:getTianMingCiFuID(self.dis_guid,groupIdx)

skillItem:SetChildActive(3,isOpen and cur_cifuID==cifuID)

self:refreshSkillItemSelect(item,groupIdx,skillItem,i,groupIdx==self.curGroupIdx and self.curSelectIdx==i)

skillItem:SetChildButtonClick(-1,function()
self:onSkillItemClick(groupIdx,i)
end)
end
end

function UIDIscipleTianMingCiFuWin:refreshGroupItemSelect(item,groupIdx,isSelect)
if item==nil then
item=self.cifuGrid:getChildCommonLayoutGroupWidgetItem(groupIdx-1)
end





end

function UIDIscipleTianMingCiFuWin:refreshSkillItemSelect(item,groupIdx,skillItem,selectIdx,isSelect)
if item==nil then
item=self.cifuGrid:getChildCommonLayoutGroupWidgetItem(groupIdx-1)
end
if skillItem==nil then
skillItem=item:GetChildCommonLayoutGroupWidgetItem(2,selectIdx-1)
end
skillItem:SetChildActive(1,isSelect)
end

function UIDIscipleTianMingCiFuWin:onSkillItemClick(groupIdx,selectIdx)






local curGroupIdx=self.curGroupIdx
local curSelectIdx=self.curSelectIdx
if curGroupIdx~=groupIdx then
self:refreshGroupItemSelect(nil,curGroupIdx,false)
self:refreshSkillItemSelect(nil,curGroupIdx,nil,curSelectIdx,false)
self.curGroupIdx=groupIdx
self.curSelectIdx=selectIdx
self:refreshGroupItemSelect(nil,groupIdx,true)
self:refreshSkillItemSelect(nil,groupIdx,nil,selectIdx,true)
else
if curSelectIdx==selectIdx then
return
end
self:refreshSkillItemSelect(nil,curGroupIdx,nil,curSelectIdx,false)
self.curSelectIdx=selectIdx
self:refreshSkillItemSelect(nil,curGroupIdx,nil,selectIdx,true)
end

self:refreshInfo()
end

function UIDIscipleTianMingCiFuWin:refreshInfo()
local list=UIDiscipleModel.getTianMingCiFuSelectCfg(self.jobID,self.curGroupIdx,self.dzId)
local cifuID=list[self.curSelectIdx]
local cifucfg=cfgHelper.get1(cfg_discipletmcfconfig_get,cifuID)
local tmlv=self.tmlv
local isActive,limit_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(tmlv,self.curGroupIdx,false)

local itemWidget=self.showSkillItem:getChildWidgetBase()

itemWidget:SetChildCSImageIcon(0,iconHelper.getSkillIcon(cifucfg.icon))

itemWidget:SetChildText(1,cifucfg.name)

itemWidget:SetChildText(2,cifucfg.desc)

local cur_cifuID=UIDiscipleModel:getTianMingCiFuID(self.dis_guid,self.curGroupIdx)
local isSelect=cur_cifuID==cifuID
local has=cur_cifuID~=nil and cur_cifuID~=0

local showbtn=isActive and not isSelect
local showsign=isActive and isSelect
self.commitBtn:setActive(showbtn)
self.signImg:setActive(showsign)
if showbtn then
local commit_str=has==true and'替换'or'选择'
self.commitTxt:setText(commit_str)
end
end

function UIDIscipleTianMingCiFuWin:onCommitBtn()
local tmlv=self.tmlv
local isActive,limit_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(tmlv,self.curGroupIdx,true)
if not isActive then
return
end

local list=UIDiscipleModel.getTianMingCiFuSelectCfg(self.jobID,self.curGroupIdx,self.dzId)
local cifuID=list[self.curSelectIdx]
local cur_cifuID=UIDiscipleModel:getTianMingCiFuID(self.dis_guid,self.curGroupIdx)
if cur_cifuID==cifuID then
return
end

UIDiscipleController:reqSaveTianMingCiFu(self.dis_guid,{[self.curGroupIdx]=cifuID})
end

