







def_class("UIItemSelectRecruitDiscipleWin",UIWindowBase)









function UIItemSelectRecruitDiscipleWin:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.roleGridPanel=UIObject.get(self,2)
self.selectTips=UIText.get(self,3)
self.selectCount=UIText.get(self,4)
self.confirmBtn=UIButton.get(self,5)
self.effect=UIObject.get(self,6)
self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)



end


function UIItemSelectRecruitDiscipleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roleGridPanel);self.roleGridPanel=nil;
_UIObject_release(self.selectTips);self.selectTips=nil;
_UIObject_release(self.selectCount);self.selectCount=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
end


local _this=nil
local roleItemIndex={
click=0,
lihui=1,
detailpBtn=2,
orientation=3,
xiaoren=4,
name=5,
select=6,
click2=7,
selectFrame=8,
}
















function UIItemSelectRecruitDiscipleWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIItemSelectRecruitDiscipleWin:__delete()
_this=nil
self.effect:setChildShowEffect(10053,false)
self:unbindComponents()
end




function UIItemSelectRecruitDiscipleWin:onShow(argtable,afterOnloaded)
self.selectNum=argtable.funcparam.num
self.discipleList=argtable.funcparam.list
self.itemguid=argtable.funcparam.itemguid
self.itemid=argtable.funcparam.itemid
self.useCount=argtable.useCount

self.selectList_lookup={}
self.selectList={}

self.root:setChildCanvasGroupAlpha(0)








self:delayDo(0.35,function()
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)

self.effect:setChildShowEffect(10053,true)


self:refresh()
end


function UIItemSelectRecruitDiscipleWin:onHide()

end

function UIItemSelectRecruitDiscipleWin:refresh()




self:refreshRoleGridPanel()


self:refreshSelectCount()
end


function UIItemSelectRecruitDiscipleWin:refreshRoleGridPanel()
local grids=self.roleGridPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(self.itemid,i)
local info=dzData.imageInfo

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
modelParams.scale=0.03
modelParams.headCenter={0,-70,1}
comHelper.setChildModelRawImageEx(roleItemIndex.lihui,item,modelParams,eHeadCenterType.eNone,1,false)

modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
item:SetChildUIModelShowTarget(roleItemIndex.xiaoren,modelParams.body,1,modelParams.componets,eAnimationID.stand)

item:SetChildText(roleItemIndex.name,dzData.disciplename)

local abname,icon=UIDiscipleModel:getJobOrientationBigIcon(info.job,dzData.id)
item:SetChildCSImageSprite(roleItemIndex.orientation,abname,icon)

local closeCallBack=function()

if UIManager:isActive('UIItemSelectRecruitDiscipleWin')then

self.root:setActive(true)
end
end
item:SetChildButtonClick(roleItemIndex.detailpBtn,function()
if _this==nil then return end
UIRecruitControl:showItemDiscipleInfoByItemId2(self.itemid,i,closeCallBack)

_this.root:setActive(false)
end)

self:refreshRoleItemSelect(item,i)

item:SetChildButtonClick(roleItemIndex.click,function()
if _this==nil then return end
_this:onRoleItemClick(i)
end)
item:SetChildButtonClick(roleItemIndex.click2,function()
if _this==nil then return end
_this:onRoleItemClick(i)
end)
end
end

function UIItemSelectRecruitDiscipleWin:refreshSelectCount()

local count=#self.selectList
self.selectCount:setText(FMT.fmt("<color=#7d3b17>请选择：</color>{0}/{1}",count,self.selectNum))
end

function UIItemSelectRecruitDiscipleWin:refreshRoleItemSelect(item,index)
if item==nil then
item=self.roleGridPanel:getChildCommonLayoutGroupWidgetItem(index-1)
end

local isSelect=self.selectList_lookup[index]or false
item:SetChildActive(roleItemIndex.select,isSelect)
item:SetChildActive(roleItemIndex.selectFrame,isSelect)
end

function UIItemSelectRecruitDiscipleWin:onRoleItemClick(index)
local isSelect=self.selectList_lookup[index]or false

self:changeRoleSelect(index,not isSelect)
end

function UIItemSelectRecruitDiscipleWin:changeRoleSelect(index,flag)
local oldSelectState=self.selectList_lookup[index]or false
if flag==oldSelectState then

return
else
if flag then



if self.selectNum==1 then

local oldSelectIndex=self.selectList[1]
self.selectList={}
self.selectList_lookup={}
if oldSelectIndex then
self:refreshRoleItemSelect(nil,oldSelectIndex)
end


self.selectList[#self.selectList+1]=index
self.selectList_lookup[index]=true
else

local selectCount=#self.selectList
if selectCount>=self.selectNum then
UIManager.error("弟子选择数量已达上限")
return
else
self.selectList[#self.selectList+1]=index
self.selectList_lookup[index]=true
end
end
else

self.selectList_lookup[index]=nil

for i=1,#self.selectList do
if self.selectList[i]==index then
table.remove(self.selectList,i)
break
end
end
end
end

self:refreshRoleItemSelect(nil,index)


self:refreshSelectCount()
end

function UIItemSelectRecruitDiscipleWin:onClickClose()
self:closeSelf()
end

function UIItemSelectRecruitDiscipleWin:onConfirmBtn()

local selectCount=#self.selectList
if selectCount<self.selectNum then

UIManager.info(FMT.fmt("请先选择{0}个弟子",self.selectNum))
return
end


local cur=UIDiscipleModel:checkDiscipleCount()
local max=UIRecruitModel:getZongMenPeopleMax()
if cur+self.selectNum>max then
UIManager.info('宗门人数已达上限')
return false
end


bagProtocolControl.req_1_20(self.itemid,1,selectCount,self.selectList)

end

