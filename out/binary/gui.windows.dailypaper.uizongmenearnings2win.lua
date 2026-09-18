







def_class("UIZongmenEarnings2Win",UIWindowBase)









function UIZongmenEarnings2Win:bindComponents()

self.scrollerView=UIObject.get(self,0)
self.notEarnings=UIText.get(self,1)



end


function UIZongmenEarnings2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.notEarnings);self.notEarnings=nil;
end

















function UIZongmenEarnings2Win:onLoaded(...)
self:bindComponents()
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIZongmenEarnings2Win:__delete()
self:unbindComponents()
end


function UIZongmenEarnings2Win:onHide()

end




function UIZongmenEarnings2Win:onShow(argtable,afterOnloaded)
self:refreshView()
end

function UIZongmenEarnings2Win:refreshView()
local datas={}
local lookup={}
local temp=UIDailyPaperModel:getOfflineDatasByType(eZMDailyPaperType.ePostWage)
for i,v in ipairs(temp)do
local postType=v.param_1
if lookup[postType]==nil then
lookup[postType]={postType,v.param_2,v.param_3}
else
lookup[postType][3]=lookup[postType][3]+v.param_3
end
end
for k,v in pairs(lookup)do
table.insert(datas,v)
end
local num=#datas
if num>1 then
table.sort(datas,function(a,b)
return a[1]<b[1]
end)
end

local has=num>0
self.notEarnings:setActive(not has)
self.scrollerView:setActive(has)
if has then
self.scrollerView:setChildScrollViewCreateGrids(num,2)
self.grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=datas[i]
local postType=data[1]
local moneyType=data[2]
local moneyCnt=data[3]

local bgicon,icon=UISectPalaceModel:getPostBigIcon(postType)
item:SetChildCSImageSprite(0,globalABLookup.zongmendadian,icon)

local postcfg=cfgHelper.get1(cfg_guildposconfig_get,postType)
local moneyName=moneyModel.getMoneyName(moneyType)
local iconName=iconHelper.getIconName(moneyType)

local result=UIDiscipleModel:getDiscipleByZongMenPost(postType)or{}
local name_str=FMT.fmt('{0}（{1}人）',postcfg.pos_name,#result)
item:SetChildText(1,name_str)

item:SetChildCSImageIcon(2,iconName,false)
item:SetChildText(3,FMT.fmt('<color=#c82c2c>{0}：{1}</color>',moneyName,-moneyCnt))
end
end
end
