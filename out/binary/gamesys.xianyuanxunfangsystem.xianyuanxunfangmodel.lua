







xianyuanxunfangModel={}

function xianyuanxunfangModel:checkInit()
return self.data~=nil
end

function xianyuanxunfangModel:initData(data)
self.data=data
xianyuanxunfangModel:handData()
end

function xianyuanxunfangModel:handData()
local data=self.data
if data~=nil then
local selectItemsLookup={}
if data.len>0 then
local disciple=xianyuanxunfangModel:getCfg('disciple')
for _,index in ipairs(data.items)do
local itemid=disciple[index][1]
selectItemsLookup[itemid]=true
end
end
data.selectItemsLookup=selectItemsLookup
end
end

function xianyuanxunfangModel:clearData()
self.data=nil
self.dzOpenLookup=nil
self.dzOpenNum=nil
self.dzOpenNumMax=nil
end

function xianyuanxunfangModel:getData()
return self.data
end

function xianyuanxunfangModel:setFree(num)
if self.data then
self.data.free=num
end
end

function xianyuanxunfangModel.checkHasFree(free)
local maxfree=xianyuanxunfangModel:getCfg('free')
return free<maxfree
end

function xianyuanxunfangModel:checkFreeReddot()
if self.data then
return xianyuanxunfangModel.checkHasFree(self.data.free)
end
return false
end

function xianyuanxunfangModel:getCfg(...)
local version=pfwindowslController:getGameVersion()
return cfgHelper.get(cfg_lotteryactnewconfig_get,version,...)
end

function xianyuanxunfangModel:getCfg2()
local version=pfwindowslController:getGameVersion()
return cfgHelper.get(cfg_lotteryactnewconfig_get,version)
end

function xianyuanxunfangModel:getConstCfg(...)
return cfgHelper.getdef(cfg_lotteryactnewconfig,...)
end



function xianyuanxunfangModel:getActID()
local actids=xianyuanxunfangModel:getCfg('actids')
for _,actID in ipairs(actids)do
if activitiesModel:checkActOpen(actID)then
return actID
end
end
return nil
end

function xianyuanxunfangModel:checkChouKaWithAct(isWarning)
local num=0
local actids=xianyuanxunfangModel:getCfg('actids')
for _,actID in ipairs(actids)do
if activitiesModel:checkActOpen(actID)then
num=num+1
end
end
if num==0 or num>1 then
if isWarning then
UIManager.error('活动存在异常，暂时无法进行寻访')
end
return false
end
return true
end





function xianyuanxunfangModel:getDZOpenSortList()
local list={}
local max=7
local disciple=xianyuanxunfangModel:getCfg('disciple')
local openDay=timeHelper.getServerOpenDay()
local lock=nil
for i,v in ipairs(disciple)do
local itemid=v[1]
local openDay_=v[3]
local lerp=openDay_-openDay
if lerp<=0 then
table.insert(list,{itemid,openDay_,lerp,i})
else
if lerp<=max then
if lock==nil or(lock~=nil and openDay_<lock)then
lock=openDay_
table.insert(list,{itemid,openDay_,lerp,i})
end
end
end
end
if#list>1 then
table.sort(list,function(a,b)
return a[2]<b[2]
end)
end
return list
end

function xianyuanxunfangModel:initDZLookup()
local dzOpenLookup=self.dzOpenLookup
if dzOpenLookup==nil then
dzOpenLookup={}
local disciple=xianyuanxunfangModel:getCfg('disciple')
local num=0
local max=#disciple
local openDay=timeHelper.getServerOpenDay()
for i,v in ipairs(disciple)do
local itemid=v[1]
local openDay_=v[3]
if openDay>=openDay_ then
dzOpenLookup[itemid]=true
num=num+1
end
end
self.dzOpenLookup=dzOpenLookup
self.dzOpenNum=num
self.dzOpenNumMax=max

local changed=false
local typo=ACTOR_SETTING_TYPE.eXianYuanXunFang
local data=userActorArraySetting.getBase(typo,{})
local lp=data.dzOpenLookup or{}
local itemsNew=data.itemsNew or{}
for itemid,_ in pairs(dzOpenLookup)do
local itemid_str=tostring(itemid)
if lp[itemid_str]==nil then
lp[itemid_str]=true
if self.data.selectItemsLookup[itemid]==nil then
itemsNew[itemid_str]=true
end
changed=true
end
end
if changed then
userActorArraySetting.setBase(typo,data)
xianyuanxunfangModel:recordDZNew()
end
end
end

function xianyuanxunfangModel:refreshDZLookup()
local changed=false
local typo=ACTOR_SETTING_TYPE.eXianYuanXunFang
local data=userActorArraySetting.getBase(typo,{})
local lp=data.dzOpenLookup or{}
local itemsNew=data.itemsNew or{}
local disciple=xianyuanxunfangModel:getCfg('disciple')
local openDay=timeHelper.getServerOpenDay()
for i,v in ipairs(disciple)do
local itemid=v[1]
if self.dzOpenLookup[itemid]==nil then
if openDay>=v[3]then
local itemid_str=tostring(itemid)
self.dzOpenLookup[itemid]=true
self.dzOpenNum=self.dzOpenNum+1
lp[itemid_str]=true
itemsNew[itemid_str]=true
changed=true
end
end
end
if changed then
userActorArraySetting.setBase(typo,data)
xianyuanxunfangModel:recordDZNew()
end
return changed
end

function xianyuanxunfangModel:hasLockDZ()
if self.dzOpenNum~=nil then
return self.dzOpenNum<self.dzOpenNumMax
else
return false
end
end

function xianyuanxunfangModel:checkAnyDZNew()
local typo=ACTOR_SETTING_TYPE.eXianYuanXunFang
local data=userActorArraySetting.getBase(typo,{})
local itemsNew=data.itemsNew
if itemsNew~=nil then
return next(itemsNew)~=nil
end
return false
end

function xianyuanxunfangModel:checkDZNew(itemid)
local typo=ACTOR_SETTING_TYPE.eXianYuanXunFang
local data=userActorArraySetting.getBase(typo,{})
local itemsNew=data.itemsNew
if itemsNew~=nil then
local itemid_str=tostring(itemid)
return itemsNew[itemid_str]==true
end
return false
end

function xianyuanxunfangModel:clearDZNew(itemid)
local changed=false
local typo=ACTOR_SETTING_TYPE.eXianYuanXunFang
local data=userActorArraySetting.getBase(typo,{})
local itemsNew=data.itemsNew
local itemid_str=tostring(itemid)
if itemsNew~=nil and itemsNew[itemid_str]~=nil then
itemsNew[itemid_str]=nil
userActorArraySetting.setBase(typo,data)
xianyuanxunfangModel:recordDZNew()
changed=true
end
return changed
end

function xianyuanxunfangModel:recordDZNew()
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianYuanXunFang)
end





function xianyuanxunfangModel:handleNote(note)
local desc_fmt=xianyuanxunfangModel:getConstCfg('note_fmt')
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(note.item_id)
note.desc=FMT.fmt(desc_fmt,note.name,dzData.disciplename)
end

function xianyuanxunfangModel:initNotes(loglist)
local notesList={}
if loglist then
for i,note in ipairs(loglist)do
self:handleNote(note)
table.insert(notesList,note)
end
end
self.data.notesList=notesList
end

function xianyuanxunfangModel:setNotesNew(loglist)
if loglist==nil then return end
local data=self.data
if data then
if data.notesList==nil then
data.notesList={}
end
if#loglist>0 then
local maxrecord=xianyuanxunfangModel:getCfg('maxrecord')
for i,note in ipairs(loglist)do
self:handleNote(note)
if#data.notesList>=maxrecord then
table.remove(data.notesList,1)
end
table.insert(data.notesList,note)
end
data.showNoteIndex=#data.notesList
end
end
end

function xianyuanxunfangModel:getOneNoteStr()
local data=self.data
if data and data.notesList then
local c=#data.notesList
if c>0 then
if data.showNoteIndex==nil or data.showNoteIndex>c or data.showNoteIndex<=0 then
data.showNoteIndex=c
end
local note=data.notesList[data.showNoteIndex]
data.showNoteIndex=data.showNoteIndex-1
local nextRound=data.showNoteIndex<=0
return note.desc,nextRound
end
end
end

function xianyuanxunfangModel:clearNoteSelect()
local data=self.data
if data then
data.showNoteIndex=nil
end
end

