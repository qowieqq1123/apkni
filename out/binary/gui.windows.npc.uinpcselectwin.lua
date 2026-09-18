







def_class("UINPCSelectWin",UIWindowBase)









function UINPCSelectWin:bindComponents()

self.roleListPanel=UIObject.get(self,0)
self.numText=UIText.get(self,1)
self.root=UIObject.get(self,2)
self.searchInput=UIInputField.get(self,3)
self.searchBtn=UIButton.get(self,4)
self.searchCancelBtn=UIButton.get(self,5)
self.noTips=UIObject.get(self,6)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)



end


function UINPCSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.numText);self.numText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.noTips);self.noTips=nil;
end
















local _this=nil


function UINPCSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.roleListPanel:setChildScrollViewInit(-1,true,nil,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)

end


function UINPCSelectWin:__delete()
self:unbindComponents()
_this=nil

end

function UINPCSelectWin:onHide()
end

function UINPCSelectWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end




function UINPCSelectWin:onShow(argtable,afterOnloaded)
self.param=argtable
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end

self:initRoleListPanel()
self:refreshInputBtns()

local cur=#self.npcList
self.numText:setText(tostring(cur))
end

function UINPCSelectWin:getNetDataList()
local list=npcModel:getAllUnlockNPC(true)
if#list>1 then
table.sort(list,function(a,b)
return a<b
end)
end

if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,npcid in ipairs(list)do
local str=self.nameSearchList[npcid]
if str==nil then
local name=npcModel:getNPCName(npcid)
str=UIDiscipleModel.getSearchName(tostring(npcid),name)
self.nameSearchList[npcid]=str
end
local d={npcid,str}
table.insert(temp_search,d)
end
if#temp_search>0 then
for i,v in ipairs(temp_search)do
local str=v[2]
if string.find(str,self.inputstr)then
table.insert(temp,v[1])
end
end
end
return temp
else
return list
end
end

function UINPCSelectWin:initRoleListPanel()
local list=self:getNetDataList()
self:initRoleListPanelEx(list)
end

function UINPCSelectWin:initRoleListPanelEx(list)
self.npcList=list
local dataNum=#self.npcList
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,6)
local has=dataNum>0
if has then
local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local npcid=self.npcList[i]
local npcItemData=npcModel:getNPCItemData(npcid)

local imagecfg=npcModel:getNPCImageCfg(npcid)
local item=grids[i-1]

local color=eQualityColor.eWhite
item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobid=npcModel:getNPCJob(npcid)
local jobicon=UIDiscipleModel:getJobIconName(jobid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

item:SetChildText(2,imagecfg.name)

comHelper.setChildModelRawImage_npc(item,imagecfg.id,3,0,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local jj_str=tostring(npcModel:getNPCJingJie(npcid))
item:SetChildText(5,jj_str)

local hgd=npcModel:getNPCIntimacy(npcid)
local hgdname=npcModel.getHaoGanDuName(hgd)
item:SetChildText(4,hgdname)

local func=function()
self:OnClickRoleItemCallback(1,i)
end
item:SetChildButtonClick(-1,func,true)
end
end
self.noTips:setActive(not has)
end


function UINPCSelectWin:OnClickRoleItemCallback(clicknum,index)
local npcid=self.npcList[index]
local winParams={
titleName='仙友信息',
extraWin='UINPCInfoWin',
extraParams={npcid=npcid},
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end

function UINPCSelectWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:initRoleListPanel()
else
UIManager.info('请输入搜索内容')
end
return
end
if self.inputstr==inputstr then
return
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含敏感字符')
return
end
self.inputstr=inputstr
local list=self:getNetDataList()
if#list<=0 then
self.inputstr=nil
UIManager.info('查无此人')
return
end
self.searchInput:setInputFieldValue('')
self:initRoleListPanelEx(list)
end

function UINPCSelectWin:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:initRoleListPanel()
end

function UINPCSelectWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function UINPCSelectWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UINPCSelectWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end