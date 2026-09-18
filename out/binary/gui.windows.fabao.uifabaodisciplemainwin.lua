







def_class("UIFaBaoDiscipleMainWin",UIWindowBase)









function UIFaBaoDiscipleMainWin:bindComponents()

self.root=UIObject.get(self,0)
self.discipleList=UIScrollView.get(self,1)



end


function UIFaBaoDiscipleMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
end



















function UIFaBaoDiscipleMainWin:onLoaded(...)
self:bindComponents()

self._on_select_dis=function(...)
self:on_select_dis(...)
end
self.discipleList:setClickAction(self._on_select_dis)
self.isInitDiscipleList=false
self.disciplelist={}
end


function UIFaBaoDiscipleMainWin:__delete()
self:unbindComponents()
self.isInitDiscipleList=false
end




function UIFaBaoDiscipleMainWin:onShow(argtable,afterOnloaded)
if argtable then
local itemguid=argtable.itemguid
self.item=fabaoHelper.getFabao(itemguid)
self.isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
self.menuPageIndex=argtable.menuPageIndex
end

if not self.isInitDiscipleList then
self.isInitDiscipleList=true
if self.isEquip then
self.disciple_guid=fabaoModel.getDiziguidByItemguid(argtable.itemguid)
local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local sortParams={[1]=true,[3]=true}
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder,sortParams)
for i,v in ipairs(list)do
local fabao=fabaoModel.getFabaoByDizi(v.netData.net.discipleguid)
if fabao then
table.insert(self.disciplelist,v)
end
end
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,self.disciple_guid)then
self.curDisIndex=i
break
end
end
end
self.disciplelistLen=#self.disciplelist
if self.disciplelistLen>0 then
self:refreshDiscipleList()
end
else
if self.disciplelistLen>0 then
self.discipleList:setActive(true)
end
end
self.root:setActive(self.disciplelistLen>0)
end


function UIFaBaoDiscipleMainWin:onHide()
self.discipleList:setActive(false)
end


function UIFaBaoDiscipleMainWin:refreshDiscipleList()
local tNum=#self.disciplelist
self.discipleList:freshGridsNum(tNum,tNum,1,true)
local idx=1
for i=1,tNum do
local item=self.discipleList:getGridObjectByindex(i-1)
local netdata=self.disciplelist[i].netData.net
local discipleguid=netdata.discipleguid



comHelper.setChildModelHeadIconBG(item,0,discipleguid)

comHelper.setChildModelRawImage(item,discipleguid,1,0,eHeadCenterType.eHead)

local isSelect=mathHelper.compareInt64(self.disciple_guid,discipleguid)
if isSelect then
idx=i
self.curDisIndex=idx
end
self:changItemSelect(item,isSelect)

self:refreshItemReddot(item,i)
end
self.discipleList:jumpToLockX(idx)
end

function UIFaBaoDiscipleMainWin:changItemSelect(item,isSelect)
item:SetChildActive(3,isSelect)
end

function UIFaBaoDiscipleMainWin:refreshItemReddot(item,idx)
if item==nil then
item=self.discipleList:getGridObjectByindex(idx-1)
end
item:SetChildActive(6,false)
end

function UIFaBaoDiscipleMainWin:on_select_dis(id,index,guid,attach)
if self.curDisIndex==index then return end

local old=self.curDisIndex
self.curDisIndex=index
if old then
local olditem=self.discipleList:getGridObjectByindex(old-1)
self:changItemSelect(olditem,false)
end
local item=self.discipleList:getGridObjectByindex(self.curDisIndex-1)
self:changItemSelect(item,true)

local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid

local oldItemId=self.item.itemid
local fabao=fabaoModel.getFabaoByDizi(dis_guid)
local itemguid=fabao.itemguid
self.item=fabaoHelper.getFabao(itemguid)

local argtable={itemguid=itemguid}
local oldIsBM=fabaoConfig.isBenMingFabao(oldItemId)
local isBM=fabaoConfig.isBenMingFabao(self.item.itemid)
if oldIsBM~=isBM then
local config=oneTabScreenConfig:getScreenConfig(SEC_FULL_TYPE.fabaoSecondary)
local eType=config and config.children[self.menuPageIndex]or nil
local isOpen=eType and oneTabScreenController:openTabUI(eType,argtable)or nil
if not isOpen then
oneTabScreenController:openUI(SEC_FULL_TYPE.fabaoSecondary,argtable)
end
else
oneTabScreenController:changeArgs(argtable,true)
end

UIManager:invokeUIMethod('UIFabaoBenMingInfoWin','freshFaBao',argtable)
UIManager:invokeUIMethod('UIFabaoYunYangWin','freshFaBao',argtable)
UIManager:invokeUIMethod('UIFabaoJilianWin','freshFaBao',argtable)
UIManager:invokeUIMethod('UIFabaoLianhuaWin','freshFaBao',argtable)
end
