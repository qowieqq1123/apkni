







def_class("UIDZCreateImageWin",UIWindowBase)









function UIDZCreateImageWin:bindComponents()

self.jobDropdown=UIDropdown.get(self,0)
self.sexDropdown=UIDropdown.get(self,1)
self.btnCopy=UIButton.get(self,2)
self.outModel=UIObject.get(self,3)
self.outModelBtn=UIButton.get(self,4)
self.pageGridPanel=UIObject.get(self,5)
self.btnRange=UIButton.get(self,6)
self.btnSave=UIButton.get(self,7)
self.btnRevert=UIButton.get(self,8)
self.searchInput=UIInputField.get(self,9)
self.inModel=UIObject.get(self,10)
self.partGridPanel=UIObject.get(self,11)

self.btnCopy:setButtonClick(function()self:onBtnCopy()end)

self.outModelBtn:setButtonClick(function()self:onOutModelBtn()end)

self.btnRange:setButtonClick(function()self:onBtnRange()end)

self.btnSave:setButtonClick(function()self:onBtnSave()end)

self.btnRevert:setButtonClick(function()self:onBtnRevert()end)



end


function UIDZCreateImageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.jobDropdown);self.jobDropdown=nil;
_UIObject_release(self.sexDropdown);self.sexDropdown=nil;
_UIObject_release(self.btnCopy);self.btnCopy=nil;
_UIObject_release(self.outModel);self.outModel=nil;
_UIObject_release(self.outModelBtn);self.outModelBtn=nil;
_UIObject_release(self.pageGridPanel);self.pageGridPanel=nil;
_UIObject_release(self.btnRange);self.btnRange=nil;
_UIObject_release(self.btnSave);self.btnSave=nil;
_UIObject_release(self.btnRevert);self.btnRevert=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.inModel);self.inModel=nil;
_UIObject_release(self.partGridPanel);self.partGridPanel=nil;
end
















local _this=nil
local maxRecoreNum=200


function UIDZCreateImageWin:onLoaded(...)
_this=self
self:bindComponents()
self.jobDropdown:setChangeAction(function(...)self:onJobChange(...)end)
self.sexDropdown:setChangeAction(function(...)self:onSexChange(...)end)
self.jobImageLookup=discipleLookup:getJobImageLookup()
local voclist=self.jobImageLookup.voclist
local joblist={}
local jobNames={}
for i,v in ipairs(voclist)do
joblist[i]=v
jobNames[i]=cfgHelper.get2(cfg_disciplevocationconfig_get,v,'name')
end
self.joblist=joblist
self.jobNames=jobNames
self.pagelist={

{1,'头发',0.6,-40,{[2]=1,[3]=1,[4]=1}},
{2,'脸谱',0.8,-45,{[1]=0,[3]=1,[4]=1}},
{3,'身体',0.3,0,{[1]=1,[2]=1,[4]=1}},
{4,'配饰',0.7,-30,{[1]=0,[2]=1,[3]=1}},
}

local recordlist=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eDiZiCreateImage,{})
local recorelp={}
for i,v in ipairs(recordlist)do
recorelp[v.name]=true
end
self.recordlist=recordlist
self.recorelp=recorelp
end


function UIDZCreateImageWin:__delete()
_this=nil
self:unbindComponents()
end


function UIDZCreateImageWin:onHide()

end




function UIDZCreateImageWin:onShow(argtable,afterOnloaded)
self:initPartSelect()
self.jobDropdown:setOption(self.jobNames)
self.jobType=1
self.lockRefresh=true
self.jobDropdown:setValue(self.jobType-1)
self.lockRefresh=false
self:refreshSexDropdown()
self:refreshPageGridPanel()
end



function UIDZCreateImageWin:refreshPageGridPanel()
self.pageIndex=1
local n=#self.pagelist
self.pageGridPanel:setChildLayoutGroupCreateItems(n,function(idx)
self:refreshPageItem(nil,idx)
end)
self:refreshPartGridPanel()
self:refreshModel()
end

function UIDZCreateImageWin:refreshPageItem(item,idx)
if item==nil then
item=self.pageGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end

item:SetChildButtonClick(2,function()
if _this==nil then return end
self:onPageItemClick(idx)
end)

self:refreshPageItemSelect(item,idx)
end

function UIDZCreateImageWin:refreshPageItemSelect(item,idx)
if item==nil then
item=self.pageGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local page=self.pagelist[idx]
local isSelect=idx==self.pageIndex
item:SetChildActive(0,isSelect)

local name=isSelect and page[2]or FMT.cfmt2('#F5AF6C',page[2])
item:SetChildText(1,name)
end

function UIDZCreateImageWin:onPageItemClick(idx)
if self.pageIndex==idx then return end
local old=self.pageIndex
self.pageIndex=idx
if old then
self:refreshPageItemSelect(nil,old)
end
self:refreshPageItemSelect(nil,idx)
self:refreshPartGridPanel()
end



function UIDZCreateImageWin:refreshSexDropdown()
local jobid=self.joblist[self.jobType]
local lp=self.jobImageLookup[jobid]
self.sexType=1
self.sexlist={}
self.sexNames={}
local sexlist=lp.sexlist
for i,v in ipairs(sexlist)do
self.sexlist[i]=v
self.sexNames[i]=SEX_TYPE.getName(v)
end
self.sexDropdown:setOption(self.sexNames)
self.lockRefresh=true
self.sexDropdown:setValue(self.sexType-1)
self.lockRefresh=false
end



function UIDZCreateImageWin:initPartSelect()
self.partSelctLookup={}
for i,v in ipairs(self.pagelist)do
self.partSelctLookup[i]=1
end
end

function UIDZCreateImageWin:refreshPartGridPanel()
local jobid=self.joblist[self.jobType]
local sex=self.sexlist[self.sexType]
local page=self.pagelist[self.pageIndex]
local partType=page[1]
local list=self.jobImageLookup[jobid][sex][partType]
self.partlist=table.deepCopy(list)or{}

local n=#self.partlist
self.partGridPanel:setChildLayoutGroupCreateItems(n,function(idx)
self:refreshPartItem(nil,idx)
end)
end

function UIDZCreateImageWin:refreshPartItem(item,idx)
if item==nil then
item=self.partGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end

item:SetChildButtonClick(0,function()
if _this==nil then return end
self:onPartItemClick(idx)
end)

local page=self.pagelist[self.pageIndex]
local partIndexs=table.deepCopy(page[5])
partIndexs[page[1]]=idx
local image=self:calculationImage(partIndexs)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildInSideModel3(item,modelParams,2,page[3],nil,0,page[4],true)

item:SetChildText(3,tostring(idx))

self:refreshPartItemSelect(item,idx)
end

function UIDZCreateImageWin:refreshPartItemSelect(item,idx)
if item==nil then
item=self.partGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local page=self.pagelist[self.pageIndex]
local partType=page[1]
local partIndex=self.partSelctLookup[partType]
item:SetChildActive(1,idx==partIndex)
end

function UIDZCreateImageWin:onPartItemClick(idx)
local page=self.pagelist[self.pageIndex]
local partType=page[1]
local partIndex=self.partSelctLookup[partType]
if partIndex==idx then return end
self.partSelctLookup[partType]=idx
if partIndex then
self:refreshPartItemSelect(nil,partIndex)
end
self:refreshPartItemSelect(nil,idx)
self:refreshModel()
end



function UIDZCreateImageWin:calculationImage(partIndexs)
partIndexs=partIndexs or{}
local jobid=self.joblist[self.jobType]
local sex=self.sexlist[self.sexType]
local page,partType,partIndex,partlist
local image={}
image.color=0
image.race=0
image.sex=sex
image.job=jobid

page=self.pagelist[1]
partType=page[1]
partIndex=partIndexs[partType]or self.partSelctLookup[partType]
partlist=self.jobImageLookup[jobid][sex][partType]or{}
image.hair=partlist[partIndex]or 0

page=self.pagelist[2]
partType=page[1]
partIndex=partIndexs[partType]or self.partSelctLookup[partType]
partlist=self.jobImageLookup[jobid][sex][partType]or{}
image.face=partlist[partIndex]or 0

page=self.pagelist[3]
partType=page[1]
partIndex=partIndexs[partType]or self.partSelctLookup[partType]
partlist=self.jobImageLookup[jobid][sex][partType]or{}
image.body=partlist[partIndex]or 0

page=self.pagelist[4]
partType=page[1]
partIndex=partIndexs[partType]or self.partSelctLookup[partType]
partlist=self.jobImageLookup[jobid][sex][partType]or{}
image.accessory=partlist[partIndex]or 0

return image
end

function UIDZCreateImageWin:refreshModel()
local image=self:calculationImage()
self.modelImage=image


local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildInSideModelEx(self.inModel,modelParams,1,nil,0,0,false,true)





end

function UIDZCreateImageWin:initAnimationList()
self.animationList={0,21,10,11,20,1000,1001}
self.cur_anim=1
end

function UIDZCreateImageWin:onJobChange(idx)
if self.lockRefresh then return end
idx=idx+1
self.jobType=idx
self:initPartSelect()
self:refreshSexDropdown()
self:refreshPageGridPanel()
end

function UIDZCreateImageWin:onSexChange(idx)
if self.lockRefresh then return end
idx=idx+1
self.sexType=idx
self:initPartSelect()
self:refreshPageGridPanel()
end

function UIDZCreateImageWin:onOutModelBtn()





end

function UIDZCreateImageWin:onBtnRange()
self:randomImage(true)
end

function UIDZCreateImageWin:onBtnRevert()
self:randomImage()
end

function UIDZCreateImageWin:randomImage(isRandom)
local isChange=false
local jobid=self.joblist[self.jobType]
local sex=self.sexlist[self.sexType]
local partType,partIndex,partlist
for pageIdx,page in ipairs(self.pagelist)do
partType=page[1]
partIndex=self.partSelctLookup[partType]
partlist=self.jobImageLookup[jobid][sex][partType]
local partIndex_
if partlist and#partlist>0 then
if isRandom then
partIndex_=math.random(1,#partlist)
else
partIndex_=1
end
end
self.partSelctLookup[partType]=partIndex_
if partIndex~=partIndex_ then
isChange=true
if self.pageIndex==pageIdx then
if partIndex then
self:refreshPartItemSelect(nil,partIndex)
end
if partIndex_ then
self:refreshPartItemSelect(nil,partIndex_)
end
end
end
end
if isChange then
self:refreshModel()
end
end

function UIDZCreateImageWin:onBtnSave()
local inputstr=self.searchInput:getInputFieldValue()
if inputstr==''or inputstr==nil then
UIManager.info('请输入弟子名字')
return
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含敏感字符')
return
end
if self.recorelp[inputstr]~=nil then
UIManager.info('弟子名字重复')
return
end
if#self.recordlist>=maxRecoreNum then
local d_=table.remove(self.recordlist,1)
self.recorelp[d_.name]=nil
end
local d=table.deepCopy(self.modelImage)
d.name=inputstr
table.insert(self.recordlist,d)
self.recorelp[inputstr]=true
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eDiZiCreateImage)
UIManager.info('保存成功!')
end

function UIDZCreateImageWin:onBtnCopy()
local str=serializeHelper.serialize(self.recordlist)
CS.UIHelper.WriteInCopyBuffer(str)
end