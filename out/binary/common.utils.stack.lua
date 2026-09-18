







Stack=simple_class()

function Stack:__init()
self.stack_table={}
end

function Stack:Push(element)
local size=self:Size()
self.stack_table[size+1]=element
end

function Stack:Pop()
local size=self:Size()
if self:IsEmpty()then
printError("Error: Stack is empty!")
return
end
return table.remove(self.stack_table,size)
end

function Stack:Top()
local size=self:Size()
if self:IsEmpty()then
printError("Error: Stack is empty!")
return
end
return self.stack_table[size]
end

function Stack:IsEmpty()
local size=self:Size()
if size==0 then
return true
end
return false
end

function Stack:Size()
return table.nums(self.stack_table)or 0
end

function Stack:Clear()

self.stack_table=nil
self.stack_table={}
end
