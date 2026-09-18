







def_class("UIDiscipleJJAndLTTips",UIWindowBase)









function UIDiscipleJJAndLTTips:bindComponents()

self.rightBG=UIObject.get(self,0)
self.titleTxt1=UIText.get(self,1)
self.titleTxt2=UIText.get(self,2)
self.itemGreator=UIObject.get(self,3)



end


function UIDiscipleJJAndLTTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rightBG);self.rightBG=nil;
_UIObject_release(self.titleTxt1);self.titleTxt1=nil;
_UIObject_release(self.titleTxt2);self.titleTxt2=nil;
_UIObject_release(self.itemGreator);self.itemGreator=nil;
end

















function UIDiscipleJJAndLTTips:onLoaded(...)
self:bindComponents()
end


function UIDiscipleJJAndLTTips:__delete()
self:unbindComponents()
end


function UIDiscipleJJAndLTTips:onHide()

end




function UIDiscipleJJAndLTTips:onShow(argtable,afterOnloaded)
local jjlv=argtable.jjlv
local ltlv=argtable.ltlv

local netData=UIDiscipleModel:getDiscipleData(argtable.dzId)
self.isShuWuDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
self.rightBG:setActive(not self.isShuWuDZ)

self.titleTxt1:setText('修道境界')
self.titleTxt2:setText('炼体境界')

local max_sectlv=cfgHelper.getglobal1('maxlv')
local lock_floor
local cfgs=cfg_disciplejingjieconfig()
for i,cfg in ipairs(cfgs)do
if cfg.sectlv then
if cfg.sectlv>max_sectlv then
lock_floor=cfg.floor+1
break
end
end
end

local args1={}
local descList1={}
local temp1=cfgHelper.getglobal1('jingjiename')
if lock_floor then
if temp1[lock_floor]==nil then
lock_floor=nil
end
end

for floor_,v in pairsBySortKey(temp1)do
local check=true
if lock_floor~=nil and floor_>lock_floor then
check=false
end
if check then
table.insert(descList1,v)
end
end
args1.descList=descList1
local floor=UIDiscipleModel:getJJFloor(jjlv)
args1.selectIndex=floor+1



local args2={}
local descList2={}
local temp2=cfgHelper.getglobal1('liantiname')
for floor_,v in pairsBySortKey(temp2)do
local check=true
if lock_floor~=nil and floor_>lock_floor then
check=false
end
if check then
table.insert(descList2,v)
end
end
args2.descList=descList2
local grade=UIDiscipleModel:getLTGrade(ltlv)
args2.selectIndex=grade+1

self:refreshPanel(args1,args2)
end

function UIDiscipleJJAndLTTips:refreshPanel(args1,args2)
local num=#args1.descList
self.itemGreator:setChildLayoutGroupCreateItems(num)
local itemGrid=self.itemGreator:getChildLayoutGroupGridList()
for i=1,num do
local item=itemGrid[i-1]

local isSelect1=i==args1.selectIndex
item:SetChildActive(0,isSelect1)
local desc_str1=args1.descList[i]
if isSelect1 then
desc_str1=FMT.fmt('<color=#7d3b17>{0}</color>',desc_str1)
end
item:SetChildText(1,desc_str1)

if not self.isShuWuDZ then
local isSelect2=i==args2.selectIndex
item:SetChildActive(2,isSelect2)
local desc_str2=args2.descList[i]
if isSelect2 then
desc_str2=FMT.fmt('<color=#7d3b17>{0}</color>',desc_str2)
end
item:SetChildText(3,desc_str2)
else
item:SetChildActive(2,false)
item:SetChildText(3,'')
end
end
end
