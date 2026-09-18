







def_class("UIXM_ZZSH_teamInfoTwoWin",UIWindowBase)









function UIXM_ZZSH_teamInfoTwoWin:bindComponents()

self.maskBlock=UIButton.get(self,0)
self.frameSp=UIObject.get(self,1)
self.infoPanel=UIObject.get(self,2)
self.teamNumTxt=UIText.get(self,3)
self.pageGrid=UIObject.get(self,4)
self.noSign=UIObject.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.teamScrollView=UIEnhancedScrollerLua.get(self,7)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXM_ZZSH_teamInfoTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.teamNumTxt);self.teamNumTxt=nil;
_UIObject_release(self.pageGrid);self.pageGrid=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
end
















local UITeamScroller=simple_class(UIEnhancedScroller)
local _this=nil


function UIXM_ZZSH_teamInfoTwoWin:onLoaded(...)
_this=self
self:bindComponents()
self.scrollscript=UITeamScroller(self.teamScrollView:getGameObject(),self.teamScrollView:getCSharpObject(),nil,nil)
end


function UIXM_ZZSH_teamInfoTwoWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_teamInfoTwoWin:onHide()

end




function UIXM_ZZSH_teamInfoTwoWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.infoPanel:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(5287,1,{},0,false,false,0,function()
if _this==nil then return end

_this.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)

end)
end

local teamtype=argtable.teamtype
self.guildid=argtable.guildid
self.m_zrData=zhengzhanshanhaiModel:getOtherPvPZhenRong(self.guildid)
local teamtypeList={}
local temp
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
for teamtype_=1,max do
temp=self.m_zrData.teamLookup[teamtype_]
if temp and#temp>0 then
table.insert(teamtypeList,teamtype_)
end
end
temp=self.m_zrData.teamLookup[0]
if temp and#temp>0 then
table.insert(teamtypeList,0)
end
self.teamtypeList=teamtypeList
self.selectPage=nil
if#teamtypeList>0 then
if teamtype then
for i,teamtype_ in ipairs(teamtypeList)do
if teamtype_==teamtype then
self.selectPage=i
break
end
end
end
if self.selectPage==nil then
self.selectPage=1
end
end
self:refreshView()
end

function UIXM_ZZSH_teamInfoTwoWin:refreshView()
self:initPageGrid()
self:refreshTeamsSV()
end

function UIXM_ZZSH_teamInfoTwoWin:initPageGrid()
local num=#self.teamtypeList
self.pageGrid:setChildLayoutGroupCreateItems(num)
local grids=self.pageGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onGridItemClick(i)
end)

local teamtype=self.teamtypeList[i]
local teamname=zhengzhanshanhaiModel:getTeamZhenRongName(teamtype)
item:SetChildText(1,teamname)
self:refreshGridItemSelect(item,i,i==self.selectPage)
self:refreshGridItemReddot(item,i)
end
end

function UIXM_ZZSH_teamInfoTwoWin:refreshGridItemSelect(item,idx,flag)
if item==nil then
item=self.pageGrid:getChildLayoutGroupGridItem(idx-1)
end
local icon=flag==true and'button_shsjzrxxui_1'or'button_shsjzrxxui_2'
item:SetChildCSImageSprite(0,globalABLookup.zzshicons,icon)
end

function UIXM_ZZSH_teamInfoTwoWin:refreshGridItemReddot(item,idx)
if item==nil then
item=self.pageGrid:getChildLayoutGroupGridItem(idx-1)
end
local teamtype=self.teamtypeList[idx]
local zrData=self.m_zrData
local num
if teamtype>0 then
num=zrData:getAtkTeamNumEx(teamtype)
else
num=zrData:getDefTeamNum()
end
local isshow=num>0
item:SetChildActive(2,isshow)
if isshow then
item:SetChildText(3,tostring(num))
end
end

function UIXM_ZZSH_teamInfoTwoWin:onGridItemClick(idx)
if self.selectPage==idx then
return
end
if self.selectPage then
self:refreshGridItemSelect(nil,self.selectPage,false)
end
self:refreshGridItemSelect(nil,idx,true)
self.selectPage=idx
self:refreshTeamsSV()
if self.teamsListNum>0 then
self.scrollscript:jumpToDataIndex(0,0,0,true,0,0,nil)
end
end



function UIXM_ZZSH_teamInfoTwoWin:findTeamIndex(teamguid_str)
for i,data in ipairs(self.teamsList)do
if data.teamguid_str==teamguid_str then
return i
end
end
return nil
end

function UIXM_ZZSH_teamInfoTwoWin:refreshTeamsSV()
local oldNum=self.teamsListNum or 0
local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
local zrData=self.m_zrData
local temp={}
if teamtype then
local list=zrData.teamLookup[teamtype]
if list then
for i,d in ipairs(list)do
local data=zrData.detailLookup[d.teamguid_str]
table.insert(temp,data)
end
end
end
self.teamsList=temp
self.teamsListNum=#temp
if oldNum==self.teamsListNum then
if self.teamsListNum==0 then
self.scrollscript:initData(nil,148,0)
else
self.scrollscript:doRefreshActiveCellViews()
end
else
self.scrollscript:initData(nil,148,self.teamsListNum)
end

local has=self.teamsListNum>0
self.noSign:setActive(not has)

local str=FMT.fmt('队伍：<color=#F7F7F7>{0}</color>',self.teamsListNum)
self.teamNumTxt:setText(str)
end

function UITeamScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UITeamScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UITeamScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local data=_this.teamsList[dataIndex]

item:SetChildButtonClick(0,function()
self:onItemClick(dataIndex)
end)

item:SetChildText(1,mathHelper.formatNumber6(data.teamfight_num))

item:SetChildText(2,data.actorData.actorname)

item:SetChildButtonClick(3,function()
self:onItemLQClick(dataIndex)
end)
local cur=data.power
local max=zhengzhanshanhaiModel.maxLingLi
local rate=cur/max
if rate>1 then rate=1 end
item:SetChildIconFillAmount(4,rate)
item:SetChildText(5,data.power)

local dzlist=data.discipleList or{}
local dznum=5
item:SetChildLayoutGroupCreateItems(6,dznum)
local grids=item:GetChildLayoutGroupGridList(6)
for i=1,dznum do
local netData=dzlist[i]
local dzitem=grids[i-1]
local has=netData~=nil and netData.flag>0
dzitem:SetChildActive(0,not has)
dzitem:SetChildActive(1,has)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
end
end

local signab,signIcon=data.actorData:getSignIcon()
local showSign=signIcon~=nil
item:SetChildActive(7,showSign)
if showSign then
item:SetChildCSImageSprite(7,signab,signIcon)
end
end

function UITeamScroller:onItemClick(dataIndex)
if _this==nil then return end
local data=_this.teamsList[dataIndex]
if data==nil then
return
end
local zrData=_this.m_zrData
local d=zrData:getSelected(data.teamguid_str)
local typo
if d~=nil then
if d.teamtype>0 then
typo=1
else
typo=2
end
else
typo=3
end
zhengzhanshanhaiController:showOtherPlayerRivalInfo(data.actorid,data.idx,typo,data.server_id)
end

function UITeamScroller:onItemLQClick(dataIndex)
if _this==nil then return end
local item=self:GetCell(dataIndex-1)
if item==nil then return end
local data=_this.teamsList[dataIndex]
if data==nil then return end
local pos=item:GetChildScreenPointToLocalPointRectangle(3)
zhengzhanshanhaiController:openLingLiTips(_this.guildid,data.teamguid_str,2,pos.x,pos.y,25,0)
end

function UIXM_ZZSH_teamInfoTwoWin:refreshTeamItem(teamguid_str)
local idx=self:findTeamIndex(teamguid_str)
if idx then
self.scrollscript:RefreshCell(idx,nil,nil)
end
end



function UIXM_ZZSH_teamInfoTwoWin:onMaskBlock()
self:closeSelf()
end

function UIXM_ZZSH_teamInfoTwoWin:onCloseBtn()
self:closeSelf()
end