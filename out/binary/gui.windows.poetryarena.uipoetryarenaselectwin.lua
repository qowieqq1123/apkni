







def_class("UIPoetryArenaSelectWin",UIWindowBase)









function UIPoetryArenaSelectWin:bindComponents()

self.background=UIButton.get(self,0)
self.back=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.dzScrollview=UIObject.get(self,3)
self.confirmBtn=UIButton.get(self,4)
self.tipsTx=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)

self.background:setButtonClick(function()self:onBackground()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIPoetryArenaSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.dzScrollview);self.dzScrollview=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end
















local _this=nil
local _job=51



function UIPoetryArenaSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self:refreshTips()
end


function UIPoetryArenaSelectWin:__delete()
self:unbindComponents()
_this=nil
end




function UIPoetryArenaSelectWin:onShow(argtable,afterOnloaded)
self.arenaGuid=argtable.guid
self.selectGuid=argtable.select
self:updateList()
self:selectDefaultDisciple()
self:refreshSelect()
self:refreshList()
self:refreshButton()
end


function UIPoetryArenaSelectWin:onHide()

end




function UIPoetryArenaSelectWin:onBackground()
UIFullPoetryArenaController:closeWindow("UIPoetryArenaSelectWin")
end


function UIPoetryArenaSelectWin:onConfirmBtn()
if self.selectGuid then
poetryArenaModel:setArenaDisciple(self.arenaGuid,self.selectGuid)
UIManager:invokeUIMethod("UIPoetryArenaWin","onRefreshDisciple",self.arenaGuid)
UIManager.info("选择成功")

UIFullPoetryArenaController:closeWindow("UIPoetryArenaSelectWin")
end
end

function UIPoetryArenaSelectWin:onCloseBtn()
UIFullPoetryArenaController:closeWindow("UIPoetryArenaSelectWin")
end

function UIPoetryArenaSelectWin:onClickRole(index)
if self.selectIdx then
local item=self.dzScrollview:getChildScrollViewItemWidget(self.selectIdx-1)
item:SetChildActive(10,false)
end

if self.selectIdx~=index then
local netData=self.disciplesList[index]
if UIDiscipleModel:checkDiscipleState2(netData.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)then
UIManager.error("弟子垂危")
self.selectGuid=nil
self.selectIdx=nil
else
self.selectGuid=netData.discipleguid
self.selectIdx=index
local item=self.dzScrollview:getChildScrollViewItemWidget(self.selectIdx-1)
item:SetChildActive(10,true)
end
else
self.selectGuid=nil
self.selectIdx=nil
end
self:refreshButton()
end

function UIPoetryArenaSelectWin:refreshTips()
local extraTips=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"extraTips")
local str=pfwindowsModel:getVersionAndPfCfg(extraTips)
self.tipsTx:setText(str)
end

function UIPoetryArenaSelectWin:updateList()
local discipleInfoList=UIDiscipleModel:findDisciplesByJob(_job)
local disciplesList={}
for i,v in ipairs(discipleInfoList)do
disciplesList[#disciplesList+1]=UIDiscipleModel:getDiscipleDataByStr(v.discipleguidStr)
end
self.disciplesList=disciplesList
table.sort(self.disciplesList,self.sortList)
end

function UIPoetryArenaSelectWin.sortList(a,b)
local aState=UIDiscipleModel:checkDiscipleState2(a.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)
local bState=UIDiscipleModel:checkDiscipleState2(b.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)
if aState~=bState then
return bState
else
local aCongHui=UIDiscipleModel:getDiscipleBaseAttr(a.discipleguid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
local bCongHui=UIDiscipleModel:getDiscipleBaseAttr(b.discipleguid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
return aCongHui>bCongHui
end
end

function UIPoetryArenaSelectWin:selectDefaultDisciple()
if not mathHelper.validInt64(self.selectGuid)and#self.disciplesList>0 then
for i,v in ipairs(self.disciplesList)do
if not UIDiscipleModel:checkDiscipleState2(v.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)then
self.selectGuid=v.discipleguid
break
end
end
end
end

function UIPoetryArenaSelectWin:refreshSelect()
self.selectIdx=nil
if self.selectGuid then
for i,v in ipairs(self.disciplesList)do
if mathHelper.compareInt64(v.discipleguid,self.selectGuid)then
self.selectIdx=i
return
end
end
end
end

function UIPoetryArenaSelectWin:refreshList()
local dataNum=#self.disciplesList
self.dzScrollview:setChildScrollViewCreateGrids(dataNum,6)
if dataNum>0 then
for i=1,dataNum do
self:refreshListItem(i)
end
end
end

function UIPoetryArenaSelectWin:refreshListItem(index)
local netData=self.disciplesList[index]
local item=self.dzScrollview:getChildScrollViewItemWidget(index-1)
local guid=netData.discipleguid
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(29,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,chuiwei)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)

item:SetChildActive(6,false)

item:SetChildActive(12,chuiwei)
item:SetChildActive(13,chuiwei)

item:SetChildActive(10,self.selectIdx==index)

local ch_str=FMT.fmt("聪慧：{0}",UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui))
item:SetChildText(4,ch_str)

local func=function()
self:onClickRole(index)
end
item:SetChildButtonClick(-1,func,true)
end

function UIPoetryArenaSelectWin:refreshButton()
local enable=self.selectGuid~=nil and self.selectGuid~=int64.zero
self.winlua:SetChildButtonEnable(self.confirmBtn:getID(),enable,not enable)
end