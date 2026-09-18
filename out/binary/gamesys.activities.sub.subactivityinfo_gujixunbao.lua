









local subActivityInfo_xianjieqiyuan={name='xinashichouka'}

function subActivityInfo_xianjieqiyuan:onInit()

end

function subActivityInfo_xianjieqiyuan:onStart()

end

function subActivityInfo_xianjieqiyuan:onUpdate()

end

function subActivityInfo_xianjieqiyuan:onDelete()

end

function subActivityInfo_xianjieqiyuan:checkReddot()
local data=self.data
if data then
local sub_actcfg=self:getSubActConfig()

if activitiesHandle_xianjieqiyuan.checkHasFree(self.sub_act_type,self.sub_act_id,data.free)then
return true
end


local target=sub_actcfg.target
local max=#target
local flag=data.flag
local total=data.total
for i=1,max do
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=mathHelper.getBitValue(flag,i-1)
if fix and not rewardFlag then
return true
end
end


local itemid=sub_actcfg.itemid
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem>=10 then
return true
end
end


return false
end

function subActivityInfo_xianjieqiyuan:handleNote(note)
local desc_fmt=activitiesModel:getSubActivity_def(self.sub_act_type,'note_fmt')
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(note.item_id)
note.desc=FMT.fmt(desc_fmt,note.name,dzData.disciplename)
end

function subActivityInfo_xianjieqiyuan:initNotes(loglist)
local notesList={}
if loglist then
for i,note in ipairs(loglist)do
self:handleNote(note)
table.insert(notesList,note)
end
end
self.data.notesList=notesList
end

function subActivityInfo_xianjieqiyuan:setNotesNew(loglist)
if loglist==nil then return end
local data=self.data
if data then
if data.notesList==nil then
data.notesList={}
end
if#loglist>0 then
local maxrecord=activitiesModel:getSubActivity_def(self.sub_act_type,'maxrecord')
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

function subActivityInfo_xianjieqiyuan:getOneNoteStr()
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

function subActivityInfo_xianjieqiyuan:clearNoteSelect()
local data=self.data
if data then
data.showNoteIndex=nil
end
end





return subActivityInfo_xianjieqiyuan